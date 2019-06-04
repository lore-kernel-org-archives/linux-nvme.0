From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Wed,  5 Jun 2019 00:40:28 +0900
Subject: [PATCH V6 0/6] nvme-cli: Introduce nvme-status mapping with errno
Message-ID: <20190604154034.23386-1-minwoo.im.dev@gmail.com>

Hi,

The first three patches have been added in this series to make sure
the previous ununiformed return type and positions in the subcommands.
Some commands used to return the negative error values in case of
internal errors, but some didn't.  Also returning in the middle of the
subcommands are not proper for the errno-mapping which is introduced
here.  The first three patches are going to fix them first.

This patchset introduces nvme-status module to manage mapping
relationships between nvme error status and errno.  It cannot be
directly mapped in 1:1, but we can figure out what kind of errors
happended by the return value of nvme-cli.

NVMe status fields are 16bits to indicate, but UNIX return value from
main() will be parsed in 8bits so that we need to do something about
return value to indicate nvme error status.

This patch series has been tested with:
  - nvme pcie device controller/namespaces
  - nvme loop target with nvme-fabrics

The branch on github can be found at:
  https://github.com/minwooim/nvme-cli.git for-1.9/return-negative-errno-v6

Please review.
Thanks,

Changes to previous V5:
  - The first patch has been updated being without an whitespace in
    front of new label("ret") in a function.  The other lables added
    followed the existing style in where it belongs to.
    The default style would be great to follow the kernel style which
    is non-space label, as suggested by Chaitanya.
  - The second patch has been updated to have "out" named label just
    like the others in that file(fabrics).
  - No functional changed in this version 6.  Only style change has been
    applied.

Changes to previous V4:
  - Add the first three patches before introducing errno mapping module.

Changes to previous V3:
  - Fix to return 0 when given error is 0 which means success.
    (Chaitanya)

Changes to previous V2:
  - do not overwrite the err local variable, instead returning the
    converted errno mapped directly.
  - return ECOMM in case of linux internal err which indicates the
    negative values from in the middle of the subcommand.

Changes to previous V1:
  - make switch-case inline in nvme-status (Chaitanya)


Minwoo Im (6):
  nvme: Do not return in the middle of the subcommand
  fabrics: Do not return in the middle of the subcommand
  nvme: Return negative error value for internal errors
  nvme-status: Introduce nvme status module to map errno
  nvme: Return errno mapped for nvme error status
  fabrics: Return errno mapped for fabrics error status

 Makefile      |   3 +-
 fabrics.c     |  46 ++--
 linux/nvme.h  |   6 +
 nvme-status.c | 155 +++++++++++
 nvme-status.h |  14 +
 nvme.c        | 701 ++++++++++++++++++++++++++++++--------------------
 6 files changed, 622 insertions(+), 303 deletions(-)
 create mode 100644 nvme-status.c
 create mode 100644 nvme-status.h

-- 
2.21.0
