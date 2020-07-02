#!/usr/bin/python3

from pathlib import Path
from os import system

# Local Imports
from python_logger import create_logger #pylint: disable=import-error

def main():
  logger = create_logger(Path(__file__).stem)

  if Path('/mnt/config/var_lib_samba').exists():
    logger.info(f'Linking Samba Config to Mounted Config.')
    system('rm -rf /var/lib/samba')
    system('cp -rf /mnt/config/var_lib_samba /var/lib/samba ')
  else:
    logger.info(f'Copying Samba Config to Mounted Config.')
    system('cp -rf /var/lib/samba /mnt/config/var_lib_samba')

if __name__ == "__main__":
  main()
