#!/usr/bin/env python

import os
import shutil
import subprocess
import sys

base_dir = os.path.dirname(os.path.abspath(__file__))


def uninstallPowerlineFontsOnWindows():
   font_directory = os.path.join(base_dir, 'fonts')
   if not os.path.exists(font_directory):
      print("Fonts already removed")
   else:
      print('Uninstalling')
      pr = subprocess.Popen('powershell uninstall.ps1', cwd=font_directory,
          shell = True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
      (status, error) = pr.communicate()
      print(status, error)

      print('Removing Fonts...')
      pr = subprocess.Popen('rm -rf ' + font_directory, shell = True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
      (git_status, error) = pr.communicate()
      print('Done Removing')


def uninstallPowerlineFontsOnLinux():
   font_directory = os.path.join(os.environ['HOME'], 'fonts')
   if not os.path.exists(font_directory):
      print("Fonts already removed")
   else:
      print('Uninstalling')
      pr = subprocess.Popen('/bin/sh uninstall.sh', cwd=font_directory,
          shell = True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
      (status, error) = pr.communicate()
      print(status, error)

      print('Removing Fonts:')
      pr = subprocess.Popen('rm -rf ' + font_directory, shell = True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
      (git_status, error) = pr.communicate()
      print('Done Removing')


if __name__ == '__main__':
   if sys.platform.startswith('win'):
      uninstallPowerlineFontsOnWindows()
      print("Finished!")
   elif sys.platform.startswith('linux'):
      uninstallPowerlineFontsOnLinux()
      print("Finished!")
   else:
      print('OS %s not supported' % sys.platform)
