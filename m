From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Wed,  1 Aug 2018 20:28:17 -0700
Subject: [PATCH V3 0/2] nvme-cli: add ana-log page support
Message-ID: <20180802032819.6558-1-chaitanya.kulkarni@wdc.com>

This patch series implements ANA-LOG-PAGE support for nvme-cli.

Regards,
Chaitanya

Changes since V2:-
1. Add CMIC and ANACAP decoding.
2. Incorporate comments from Hannes.

Changes since V1:-
1. Add JSON support.
2. Incorporate comments from Christoph.

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
 nvme-print.c                    | 170 ++++++-
 nvme-print.h                    |   2 +
 nvme.c                          |  77 +++
 10 files changed, 1257 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/nvme-ana-log.1
 create mode 100644 Documentation/nvme-ana-log.html
 create mode 100644 Documentation/nvme-ana-log.txt

-- 
2.17.0
