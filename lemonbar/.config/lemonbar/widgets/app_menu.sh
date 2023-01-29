#!/bin/bash


menu() {
  while :; do
    string="MEN%{A:dmenu_settings:}   %{A}"   # f303
    echo "$string"
    sleep 1
  done
}

