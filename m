From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Tue, 14 May 2019 02:03:38 +0900
Subject: [PATCH V2 0/4] nvme-cli: Introduce nvme-status mapping with errno
Message-ID: <20190513170342.9497-1-minwoo.im.dev@gmail.com>

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

Changes to previous C1:
  - make switch-case inline in nvme-status (Chaitanya)

Minwoo Im (4):
  nvme.h: Fix typos in status code values
  nvme-status: Introduce nvme status module to map errno
  nvme: Return errno mapped for nvme error status
  fabrics: Return errno mapped for fabrics error status

 Makefile      |   3 +-
 fabrics.c     |  24 +++++--
 linux/nvme.h  |  10 ++-
 nvme-print.c  |   4 +-
 nvme-status.c | 147 +++++++++++++++++++++++++++++++++++++++++
 nvme-status.h |  14 ++++
 nvme.c        | 180 ++++++++++++++++++++++++++++++--------------------
 7 files changed, 303 insertions(+), 79 deletions(-)
 create mode 100644 nvme-status.c
 create mode 100644 nvme-status.h

-- 
2.21.0
