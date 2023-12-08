#!/bin/bash
#----------
usage() {
  echo "list of available options goes here"
  exit 0; }
invalid() {
  echo "testflag: detecting improper option"
  echo "try option '-h' for more information"
  exit 1; }
generate() {
  echo "my name is $1 ($3)" | grep -E --color "$1|$3"  
  echo "i am $2 years old"  | grep -E --color "$2"
  exit 0; }
#----------
while getopts "n: a: s: g h" opt; do
  case $opt in
    n) n="${OPTARG}" ;;
    a) a="${OPTARG}" ;;
    s) s="${OPTARG}" ;;
    g) opt_sub="generate" ;;
    h) usage ;;
    *) invalid ;;
  esac
done
#----------
case $opt_sub in
  "generate") [[ "$n" && "$a" && "$s" ]] && generate "$n" "$a" "$s" || invalid ;;  
esac
#----------
usage
