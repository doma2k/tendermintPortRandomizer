#! /bin/bash

# ===================
# Script funtionality
# ===================

# do something
doSomething() {
    echo 'doing something'
}


# ================
# Script structure
# ================

# Show usage via commandline arguments
usage() {
  echo "~~~~~~~~~~~"
  echo "RANDOMISER"
  echo "~~~~~~~~~~~"
  echo "Usage: ./example.sh [option]"
  echo "  options:"
  echo "    -d : do something"
  echo "    -m : Show interactive menu"
  echo "    -h : Show this help"
  echo ""
  exit
}

# Function to display menu options
show_menus() {
    clear
    echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    echo " Example Main Menu"
    echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    echo "  1. Do something"
    echo "  ---"
    echo "  2. Exit"
    echo ""
}

# Function to read menu input selection and take a action
read_options(){
    local choice
    read -p "Enter choice [ 1 - 2 ] " choice
    case $choice in
    1) doSomething;;
    2) exit 0;;
    *) echo -e "${RED}Error...${STD}" && sleep 2
    esac
}

# Use menu...
do_menu() {
  # Main menu handler loop
  while true
  do
    show_menus
    read_options
  done
}

# If no arguments provided, display usage information
[[ $# -eq 0 ]] && usage

# Process command line arguments
if [[ $@ ]]; then
  while getopts "dmh" opt; do
    case $opt in
      d)
        doSomething
        shift
        ;;
      m)
      	do_menu
        shift
        ;;
      h)
        usage
        exit 0
        ;;
      \?)
        ;;
    esac
  done
else
  usage
  exit 0
fi