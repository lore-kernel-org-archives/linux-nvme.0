From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Sun, 12 Aug 2018 22:59:18 -0700
Subject: [PATCH V4 0/2] nvme-cli: ana log support
Message-ID: <20180813055920.22414-1-chaitanya.kulkarni@wdc.com>

Hi,

This adds nvme-ana-log support for nvme-cli. Please consider this for
inclusion so we can start using nvme-cli for ANA related testcases.

Regards,
Chaitanya
 
Changes since V3:-

1. Fix the comments from Minwoo Im.
2. Generate the patch series on the top of
   http://lists.infradead.org/pipermail/linux-nvme/2018-August/019635.html.

Chaitanya Kulkarni (2):
  nvme-cli: add minimal ana-log page support
  nvme-cli: add ana-log documentation

 Documentation/nvme-ana-log.1    |  77 +++
 Documentation/nvme-ana-log.html | 815 ++++++++++++++++++++++++++++++++
 Documentation/nvme-ana-log.txt  |  41 ++
 linux/nvme.h                    |  52 +-
 nvme-builtin.h                  |   1 +
 nvme-ioctl.c                    |   8 +
 nvme-ioctl.h                    |   1 +
 nvme-print.c                    | 170 ++++++-
 nvme-print.h                    |   2 +
 nvme.c                          |  72 +++
 10 files changed, 1232 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/nvme-ana-log.1
 create mode 100644 Documentation/nvme-ana-log.html
 create mode 100644 Documentation/nvme-ana-log.txt

-- 
2.17.0
