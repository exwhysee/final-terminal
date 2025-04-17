#!/bin/bash
# Simple TUI game with emoji locations

# trap ensures reset runs even if the script
# crashes or is interrupted or exits with error
# code 0
trap 'tput reset; tput cnorm; exit' INT TERM EXIT

tput civis

# Emoji map: Fruits and animals
map=(
  "🐍  2,2"
  "🍎  5,5"
  "🍓  8,8"
  "🐢  10,3"
  "🍌  12,6"
  "🦁  15,4"
)

# Display emoji map on top
clear
echo "Emoji map:"
for entry in "${map[@]}"; do
  echo "$entry"
done

x=10; y=5
while true; do
  # Display player '@' on map
  tput cup $y $x; echo "@"
  tput cup 20 0; echo "[WASD or Arrows] Move | Ctrl+C to Exit"

  # Read input for movement
  IFS= read -rsn1 input
  [[ $input == $'\e' ]] && { IFS= read -rsn2 k; input+=$k; }

  # Move player based on input
  [[ $input == a || $input == $'\e[D' ]] && ((x--))
  [[ $input == d || $input == $'\e[C' ]] && ((x++))
  [[ $input == w || $input == $'\e[A' ]] && ((y--))
  [[ $input == s || $input == $'\e[B' ]] && ((y++))

  # Clear screen for the next frame
  clear
  # Print the updated emoji map
  echo "Emoji map:"
  for entry in "${map[@]}"; do
    echo "$entry"
  done
  # Print player's position
  tput cup $y $x; echo "@"
  tput cup 20 0; echo "[WASD or Arrows] Move | Ctrl+C to Exit"
done

