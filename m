From: mb@lightnvm.io (=?UTF-8?q?Matias=20Bj=C3=B8rling?=)
Date: Fri,  9 Feb 2018 10:27:15 +0100
Subject: [PATCH V2 0/4] lightnvm: base 2.0 implementation
Message-ID: <20180209092719.10679-1-mb@lightnvm.io>

A couple of patches for 2.0 support for the lightnvm subsystem. They
form the basis for integrating 2.0 support.

For the rest of the support, Javier has code that implements report
chunk and sets up the LBA format data structure. He also has a bunch
of patches that brings pblk up to speed.

The first two patches is preparation for the 2.0 work. The third patch
implements the 2.0 data structures, the geometry command, and exposes
the sysfs attributes that comes with the 2.0 specification. Note that
the attributes between 1.2 and 2.0 are different, and it is expected
that user-space shall use the version sysfs attribute to know which
attributes will be available.

The last patch implements support for using the nvme namespace logical
block and metadata fields and sync it with the internal lightnvm
identify structures.

Changes since v1:

 - pr_err fix from Randy.
 - Address type fix from Javier.
 - Also CC the nvme mailing list.

Matias Bj?rling (4):
  lightnvm: make 1.2 data structures explicit
  lightnvm: flatten nvm_id_group into nvm_id
  lightnvm: add 2.0 geometry identification
  nvme: lightnvm: add late setup of block size and metadata

 drivers/lightnvm/core.c      |  33 ++-
 drivers/nvme/host/core.c     |   2 +
 drivers/nvme/host/lightnvm.c | 508 ++++++++++++++++++++++++++++++++-----------
 drivers/nvme/host/nvme.h     |   2 +
 include/linux/lightnvm.h     |  64 +++---
 5 files changed, 428 insertions(+), 181 deletions(-)

-- 
2.11.0
