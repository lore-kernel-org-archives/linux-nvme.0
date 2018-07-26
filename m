From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Wed, 25 Jul 2018 21:18:40 -0700
Subject: [PATCH V2 0/2] nvme-cli: add ana-log support
Message-ID: <20180726041842.9668-1-chaitanya.kulkarni@wdc.com>

This allows reading NVMe Asynchronous Namespace Access log page
support to the nvme-cli.

Changes Since V1:-

1. Add JSON output format support.
2. Use RAE bit to retain the AEN when reading the ANA log page.
3. Fix for the Christoph's comments.

Regards,
Chaitanya

Chaitanya Kulkarni (2):
  nvme-cli: add minimal ana-log page support
  nvme-cli: add ana-log documentation

 Documentation/nvme-ana-log.1    |  82 ++++
 Documentation/nvme-ana-log.html | 826 ++++++++++++++++++++++++++++++++
 Documentation/nvme-ana-log.txt  |  45 ++
 linux/nvme.h                    |  52 +-
 nvme-builtin.h                  |   1 +
 nvme-ioctl.c                    |   8 +
 nvme-ioctl.h                    |   1 +
 nvme-print.c                    | 130 ++++-
 nvme-print.h                    |   2 +
 nvme.c                          |  77 +++
 10 files changed, 1219 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/nvme-ana-log.1
 create mode 100644 Documentation/nvme-ana-log.html
 create mode 100644 Documentation/nvme-ana-log.txt

-- 
2.17.0
