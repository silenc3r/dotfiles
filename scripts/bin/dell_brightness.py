#!/usr/bin/env python3

import subprocess
import sys


def brightness_down(val=5):
    subprocess.run(
        ['ddcutil', '--bus', '5', '--nodetect', 'setvcp', '10', '-', str(val)]
    )


def brightness_up(val=5):
    subprocess.run(
        ['ddcutil', '--bus', '5', '--nodetect', 'setvcp', '10', '+', str(val)]
    )


def brightness_zero():
    subprocess.run(
        ['ddcutil', '--bus', '5', '--nodetect', 'setvcp', '10', '0']
    )


def get_brightness():
    b = subprocess.run(
        "ddcutil --bus=5 --nodetect getvcp 10 | awk -F'[ ,]+' '{ print $9 }'",
        shell=True,
        stdout=subprocess.PIPE
    ).stdout.decode('utf-8')
    s = "Brightness: " + b.strip()
    subprocess.run(['notify-send', '-t', '500', s])


def main():
    if len(sys.argv) > 1:
        cmd = sys.argv[1]
        if cmd == 'up':
            brightness_up()
        elif cmd == 'down':
            brightness_down()
        elif cmd == 'zero':
            brightness_zero()
        else:
            get_brightness()


if __name__ == "__main__":
    main()
