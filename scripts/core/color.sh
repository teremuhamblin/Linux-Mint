#!/usr/bin/env bash
set -euo pipefail

# Couleurs ANSI
COLOR_RESET="\033[0m"
COLOR_RED="\033[31m"
COLOR_GREEN="\033[32m"
COLOR_YELLOW="\033[33m"
COLOR_BLUE="\033[34m"
COLOR_CYAN="\033[36m"
COLOR_BOLD="\033[1m"

color_red()    { printf "%b%s%b\n"   "${COLOR_RED}"   "$1" "${COLOR_RESET}"; }
color_green()  { printf "%b%s%b\n"   "${COLOR_GREEN}" "$1" "${COLOR_RESET}"; }
color_yellow() { printf "%b%s%b\n"   "${COLOR_YELLOW}" "$1" "${COLOR_RESET}"; }
color_blue()   { printf "%b%s%b\n"   "${COLOR_BLUE}"  "$1" "${COLOR_RESET}"; }
color_cyan()   { printf "%b%s%b\n"   "${COLOR_CYAN}"  "$1" "${COLOR_RESET}"; }
color_bold()   { printf "%b%s%b\n"   "${COLOR_BOLD}"  "$1" "${COLOR_RESET}"; }
