#!/bin/bash


clock() {
  while :; do
    echo "TIM   $(date +'%H:%M')"        # f64f
    sleep 10
  done
}

