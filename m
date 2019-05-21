From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Wed, 22 May 2019 01:36:56 +0900
Subject: [PATCH V4 0/3] nvme-cli: Introduce nvme-status mapping with errno
Message-ID: <20190521163659.24577-1-minwoo.im.dev@gmail.com>

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

Changes to previous V3:
  - Fix to return 0 when given error is 0 which means success. (Chaitanya)

Changes to previous V2:
  - do not overwrite the err local variable, instead returning the
    converted errno mapped directly.
  - return ECOMM in case of linux internal err which indicates the
    negative values from in the middle of the subcommand.

Changes to previous V1:
  - make switch-case inline in nvme-status (Chaitanya)

Minwoo Im (3):
  nvme-status: Introduce nvme status module to map errno
  nvme: Return errno mapped for nvme error status
  fabrics: Return errno mapped for fabrics error status

 Makefile      |   3 +-
 fabrics.c     |  18 ++++--
 linux/nvme.h  |   6 ++
 nvme-status.c | 155 ++++++++++++++++++++++++++++++++++++++++++++++++++
 nvme-status.h |  14 +++++
 nvme.c        | 108 ++++++++++++++---------------------
 6 files changed, 233 insertions(+), 71 deletions(-)
 create mode 100644 nvme-status.c
 create mode 100644 nvme-status.h

-- 
2.21.0
