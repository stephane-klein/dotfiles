#!/usr/bin/env bash
set -u

G=$'\e[32m'; R=$'\e[31m'; Y=$'\e[33m'; O=$'\e[0m'
if [ ! -t 1 ]; then G=; R=; Y=; O=; fi

declare -A STATUS MSG

set_status() { STATUS[$1]=$2; MSG[$1]="$3"; }
ok()   { set_status "$1" 0 "$2"; }
warn() { set_status "$1" 1 "$2"; }
fail() { set_status "$1" 2 "$2"; }

check_nvme_apst() {
  local p=/sys/module/nvme_core/parameters/default_ps_max_latency_us
  local arg='nvme_core.default_ps_max_latency_us=0'
  local src=/etc/kernel/cmdline
  if [ ! -r "$p" ]; then
    fail nvme_apst "cannot read $p (nvme_core driver not loaded?)"
    return
  fi
  local val
  val="$(cat "$p")"
  if [ "$val" != "0" ]; then
    fail nvme_apst "NVMe APST is ENABLED (latency=${val}us). On this laptop (single NVMe) it can hang the controller under sustained writes -> hard freeze with no log. Apply: sudo grubby --update-kernel=ALL --args='${arg}' && sudo reboot. Note: GRUB uses BLSCFG, grub2-mkconfig alone does not refresh the existing boot entry."
  elif [ -r "$src" ] && grep -Fq "$arg" "$src"; then
    ok nvme_apst "NVMe APST disabled and persisted in ${src}."
  else
    warn nvme_apst "NVMe APST disabled at runtime but NOT persisted: missing '${arg}' in ${src}. Add it there so kernel updates keep it, then: sudo grubby --update-kernel=ALL --args='${arg}' && sudo reboot."
  fi
}

check_coredump_size() {
  local want='ProcessSizeMax=200M'
  local conf
  conf="$(systemd-analyze cat-config systemd/coredump.conf 2>/dev/null || true)"
  if printf '%s\n' "$conf" | grep -Fq "$want"; then
    ok coredump_size "systemd coredumps capped (${want})."
  else
    fail coredump_size "systemd coredump limit is NOT set (${want} missing). A recurring mise/node crash (6.4G RSS) writes ~2G dumps per occurrence, causing I/O bursts during heavy writes. Apply: sudo mkdir -p /etc/systemd/coredump.conf.d && printf '[Coredump]\\nProcessSizeMax=200M\\n' | sudo tee /etc/systemd/coredump.conf.d/99-limit.conf"
  fi
}

check_coredump_dir() {
  local dir=/var/lib/systemd/coredump
  if [ ! -d "$dir" ]; then
    ok coredump_dir "no coredump storage dir (${dir})."
    return
  fi
  local count size
  count="$(find "$dir" -maxdepth 1 -type f 2>/dev/null | wc -l)"
  size="$(du -sh "$dir" 2>/dev/null | awk '{print $1}')"
  if [ "$count" -eq 0 ]; then
    ok coredump_dir "no coredumps stored (${dir})."
  else
    warn coredump_dir "${count} coredump file(s) (~${size}) stored in ${dir}. Clean them: sudo rm -f ${dir}/core.*.zst"
  fi
}

CHECKS=( nvme_apst coredump_size coredump_dir )

overall=0
for c in "${CHECKS[@]}"; do
  "check_$c"
done
for c in "${CHECKS[@]}"; do
  code=${STATUS[$c]}
  case $code in
    0) col=$G; lbl=OK;;
    1) col=$Y; lbl=WARN; (( overall < 1 )) && overall=1;;
    2) col=$R; lbl=FAIL; (( overall < 2 )) && overall=2;;
    *) col=$O; lbl='?';;
  esac
  printf '%s[%s]%s %s\n' "$col" "$lbl" "$O" "${MSG[$c]}"
done
exit $overall
