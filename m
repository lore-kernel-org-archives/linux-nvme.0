From: guanjunxiong@huawei.com (Guan Junxiong)
Date: Mon, 4 Dec 2017 22:06:42 +0800
Subject: [PATCH 0/2] nvme-cli: add options to set/get property of NVMf
Message-ID: <1512396404-18872-1-git-send-email-guanjunxiong@huawei.com>

Hi all,

To make it easy to use, this two patches add the support to set/get the
properties for NVMe over Fabric. 

Patch 1/2  makes use of show-regs option which only supports PCIe previously
to support NVMf.
Patch 2/2  adds new option named set-property to support setting the property 
of NVMf. IMO, it is the responsibility of kernel to try to avoid malicious
operation such as setting NRSS from the user space. So I ignore this in
the nvme-cli.

Welcome any comments.

Thanks


Guan Junxiong (2):
  nvme-cli: add support to get properties for NVMe over Fabric
  nvme-cli: support to set the property for NVMe over Fabric

 Documentation/nvme-set-property.1    |  51 +++
 Documentation/nvme-set-property.html | 814 +++++++++++++++++++++++++++++++++++
 Documentation/nvme-set-property.txt  |  34 ++
 Documentation/nvme-show-regs.1       |  13 +-
 Documentation/nvme-show-regs.txt     |  23 +-
 nvme-builtin.h                       |   3 +-
 nvme-ioctl.c                         |  94 ++++
 nvme-ioctl.h                         |   2 +
 nvme-print.c                         | 134 +++---
 nvme-print.h                         |   3 +-
 nvme.c                               |  77 +++-
 11 files changed, 1173 insertions(+), 75 deletions(-)
 create mode 100644 Documentation/nvme-set-property.1
 create mode 100644 Documentation/nvme-set-property.html
 create mode 100644 Documentation/nvme-set-property.txt

-- 
2.11.1
