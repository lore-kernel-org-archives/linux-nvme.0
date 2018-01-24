From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Wed, 24 Jan 2018 21:24:42 +0900
Subject: [PATCH 0/2] nvme-cli: add support for an abort command with
 documentation
Message-ID: <1516796682-31793-1-git-send-email-minwoo.im.dev@gmail.com>

It would be convenient to use abort command by a subcommand.
This command will strongly used by device developers to test device.

Minwoo Im (2):
  nvme-cli: add support for an abort command
  nvme-cli: add documentation for abort command

 Documentation/cmds-main.txt   |   2 +
 Documentation/nvme-abort.1    |  80 ++++
 Documentation/nvme-abort.html | 834 ++++++++++++++++++++++++++++++++++++++++++
 Documentation/nvme-abort.txt  |  51 +++
 nvme-builtin.h                |   1 +
 nvme-ioctl.c                  |  13 +
 nvme-ioctl.h                  |   1 +
 nvme.c                        |  50 +++
 8 files changed, 1032 insertions(+)
 create mode 100644 Documentation/nvme-abort.1
 create mode 100644 Documentation/nvme-abort.html
 create mode 100644 Documentation/nvme-abort.txt

-- 
2.7.4
