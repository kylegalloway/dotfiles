#!/usr/bin/env python

import os
import shutil
import subprocess
import sys

base_dir = os.path.dirname(os.path.abspath(__file__))


def installPowerlineFontsOnWindows():
   font_directory = os.path.join(base_dir, 'fonts')
   if not os.path.exists(font_directory):
      print 'Cloning Fonts...'
      pr = subprocess.Popen('git clone https://github.com/powerline/fonts.git ' + font_directory,
         shell = True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
      (git_status, error) = pr.communicate()
      print 'Done cloning'
   else:
      print 'Fonts directory already exists'

   print 'Installing'
   pr = subprocess.Popen('powershell install.ps1', cwd=font_directory,
      shell = True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
   (status, error) = pr.communicate()
   print status, error


def installPowerlineFontsOnLinux():
   font_directory = os.path.join(os.environ['HOME'], 'fonts')
   if not os.path.exists(font_directory):
      print 'Cloning Fonts:'
      pr = subprocess.Popen('git clone https://github.com/powerline/fonts.git ' + font_directory,
         shell = True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
      (git_status, error) = pr.communicate()
      print 'Done Cloning'
   else:
      print 'Fonts directory already exists'

   print 'Installing'
   pr = subprocess.Popen('/bin/sh install.sh', cwd=font_directory,
      shell = True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
   (status, error) = pr.communicate()
   print status, error


if __name__ == '__main__':
   if sys.platform.startswith('win'):
      installPowerlineFontsOnWindows()
      print "Finished!"
   elif sys.platform.startswith('linux'):
      installPowerlineFontsOnLinux()
      print "Finished!"
   else:
      print 'OS %s not supported' % sys.platform
