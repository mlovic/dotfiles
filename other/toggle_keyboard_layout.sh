#!/usr/bin/env bash

# Toggles between en and es keyboard layouts

current="$(setxkbmap -print | grep xkb_symbols | awk '{print $4}' | awk -F"+" '{print $2}')"

echo $current
echo "$current"

if [ "$current" = 'us' ]; then
  setxkbmap es -model pc105
else
  setxkbmap us
fi
