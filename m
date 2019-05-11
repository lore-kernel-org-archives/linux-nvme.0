From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Sun, 12 May 2019 04:37:09 +0900
Subject: [PATCH RFC 0/4] nvme-cli: Introduce nvme-status mapping with errno
Message-ID: <20190511193713.29516-1-minwoo.im.dev@gmail.com>

Hi,

This patchset introduces nvme-status module to manage mapping
relationships between nvme error status and errno.  It cannot be
directly mapped in 1:1, but we can figure out what kind of errors
happended by the return value of nvme-cli.

NVMe status fields are 16bits to indicate, but UNIX return value from
main() will be parsed in 8bits so that we need to do something about
return value to indicate nvme error status.

Please review.
Thanks,

Minwoo Im (4):
  nvme.h: Fix typos in status code values
  nvme-status: Introduce nvme status module to map errno
  nvme: Return errno mapped for nvme error status
  fabrics: Return errno mapped for fabrics error status

 Makefile      |   3 +-
 fabrics.c     |  24 +++++--
 linux/nvme.h  |  10 ++-
 nvme-print.c  |   4 +-
 nvme-status.c | 127 +++++++++++++++++++++++++++++++++++
 nvme-status.h |  14 ++++
 nvme.c        | 180 ++++++++++++++++++++++++++++++--------------------
 7 files changed, 283 insertions(+), 79 deletions(-)
 create mode 100644 nvme-status.c
 create mode 100644 nvme-status.h

-- 
2.17.1
