#!/usr/bin/env bash
# doctor-laptop — general system checks for this laptop.
# Usage : doctor-laptop [check ...]   (no arg = run all)
# Exit  : 0 = OK · 1 = WARN (submitted) · 2 = FAIL (worst status wins)
set -u

if [ -t 1 ] && command -v tput >/dev/null 2>&1; then
  G=$'\e[32m'; R=$'\e[31m'; Y=$'\e[33m'; O=$'\e[0m'
else G=; R=; Y=; O=; fi

declare -A STATUS MSG            # check name -> code / name -> message
# code: 0 = OK, 1 = WARN, 2 = FAIL
say()  { STATUS[$1]=$2; MSG[$1]="$3"; }
ok()   { say "$1" 0 "$2"; }
warn() { say "$1" 1 "$2"; }
fail() { say "$1" 2 "$2"; }

# --- Checks. To extend: add a check_<name> function here,             ---
#     then register it in the CHECKS array below.                      ---

check_nvme_apst() {
  local p=/sys/module/nvme_core/parameters/default_ps_max_latency_us
  local arg='nvme_core.default_ps_max_latency_us=0'
  local src=/etc/kernel/cmdline
  if [ ! -r "$p" ]; then
    fail nvme_apst "cannot read $p (nvme_core driver not loaded?)"; return
  fi
  local val; val="$(cat "$p")"
  if [ "$val" != "0" ]; then
    fail nvme_apst "NVMe APST is ENABLED (latency=${val}). Under sustained writes this can hang the controller (hard freeze, no log). Fix: sudo grubby --update-kernel=ALL --args='${arg}' then reboot (GRUB BLSCFG: grub2-mkconfig alone does not refresh the entry)."
  elif [ -r "$src" ] && grep -qw "$arg" "$src"; then
    ok nvme_apst "APST disabled and persisted in $src."
  else
    warn nvme_apst "APST disabled at runtime but missing from $src: it will revert on the next kernel update. Add '${arg}' to $src to persist."
  fi
}

# --- Active check registry --------------------------------------------
CHECKS=( nvme_apst )
# Future ideas: check_disk_smart, check_temperature, check_battery,
#               check_disk_space, check_suspend, check_updates ...

# --- Runner -----------------------------------------------------------
if [ $# -gt 0 ]; then selected=("$@"); else selected=("${CHECKS[@]}"); fi

overall=0
for c in "${selected[@]}"; do "check_$c"; done
for c in "${selected[@]}"; do
  code=${STATUS[$c]}
  case $code in
    0) col=$G; lbl=OK;;
    1) col=$Y; lbl=WARN; (( overall < 1 )) && overall=1;;
    2) col=$R; lbl=FAIL; (( overall < 2 )) && overall=2;;
    *) continue;;
  esac
  printf '%s[%s]%s %s\n' "$col" "$lbl" "$O" "${MSG[$c]}"
done
exit $overall
