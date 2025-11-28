#!/usr/bin/env bash
# app.sh - safe simulation of a "bulk reporting terminal"
# DOES NOT PERFORM ANY NETWORK OR AUTOMATED REPORTING
# For demo / UI testing only.

set -euo pipefail

# helper: print with colors if supported
red()   { printf '\e[31m%s\e[0m\n' "$1"; }
green() { printf '\e[32m%s\e[0m\n' "$1"; }
cyan()  { printf '\e[36m%s\e[0m\n' "$1"; }
bold()  { printf '\e[1m%s\e[0m\n' "$1"; }

clear
bold "======================================================"
bold "  MR ANUGA SENITHU'S WHATSAPP REPORTER - DTZ"
bold "  Access Level: ROOT PREMIUM ADMIN | Status: ONLINE"
bold "  DON'T COPY OR EDIT THIS TOOL. U CAN BAN IF YOU COPY
bold "======================================================"
echo

# read phone number
while true; do
  read -rp "Enter target phone number (international format, e.g. +441234567890): " TARGET
  # basic validation: at least 8 digits and starts with + or digits
  if [[ -z "$TARGET" ]]; then
    red "Number cannot be empty. Try again."
    continue
  fi
  # strip spaces
  TARGET_CLEAN="${TARGET//[[:space:]]/}"
  if [[ ${#TARGET_CLEAN} -lt 8 ]]; then
    red "Number looks too short. Try again."
    continue
  fi
  break
done

# read count
while true; do
  read -rp "How many reports to simulate? " COUNT
  if ! [[ "$COUNT" =~ ^[0-9]+$ ]]; then
    red "Please enter a positive integer."
    continue
  fi
  if (( COUNT <= 0 )); then
    red "Enter a number greater than zero."
    continue
  fi
  if (( COUNT > 10000 )); then
    echo "That's a large number. Are you sure? (y/N)"
    read -rn1 REPLY
    echo
    if [[ "$REPLY" =~ ^[Yy]$ ]]; then
      break
    else
      continue
    fi
  fi
  break
done

echo
cyan "Preparing reporting..."
sleep 0.6

# nice formatted header similar to screenshot
echo "======================================================"
echo "  MR ANUGA SENITHU'S WHATSAPP REPORTER - DTZ"
echo "  Access Level: ROOT PREMIUM ADMIN | Status: ONLINE"
echo "  DON'T COPY OR EDIT THIS TOOL. U CAN BAN IF YOU COPY
echo "======================================================"
echo

# progress loop - sending reports
SUCCESS=0
PADDING=3
for ((i=1;i<=COUNT;i++)); do
  # show a line like: [  1 / 100 ] Reporting +44123... ... Success
  printf "[%*d / %d] Reporting %s ..." "$PADDING" "$i" "$COUNT" "$TARGET_CLEAN"
  # simulate variable response time
  sleep_time=$(awk -v min=0.08 -v max=0.28 'BEGIN{srand(); print min+rand()*(max-min)}')
  sleep "$sleep_time"
  # random simulated outcome (mostly success)
  r=$((RANDOM%100))
  if (( r < 95 )); then
    green " Success"
    ((SUCCESS++))
  else
    red " Failed (simulated)"
  fi
done

echo
bold "Summary:"
cyan "Target: $TARGET_CLEAN"
cyan "Attempts: $COUNT"
green "{ $SUCCESS } successfully sent by Mr.Anuga Senithu"
echo
bold "Note: This was only a unsafe tool. Real reports were made."

# nice exit
exit 0
