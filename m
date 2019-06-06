From: bvanassche@acm.org (Bart Van Assche)
Date: Thu,  6 Jun 2019 14:28:52 -0700
Subject: [PATCH 0/2] NVMe 1.4 Identify Namespace Support
Message-ID: <20190606212854.122478-1-bvanassche@acm.org>

Hi Keith,

These two patches are what I came up with after having read the Identify
Namespace sections in final draft of version 1.4 of the NVMe. These patches
compile correctly but have not been tested in any other way. Please consider
these patches for kernel version 5.3.

Thanks,

Bart.

Bart Van Assche (2):
  nvme: Introduce NVMe 1.4 Identify Namespace fields in struct
    nvme_id_ns
  nvme: Set physical block size and optimal I/O size according to NVMe
    1.4

 drivers/nvme/host/core.c | 14 ++++++++++++--
 include/linux/nvme.h     | 12 +++++++++---
 2 files changed, 21 insertions(+), 5 deletions(-)

-- 
2.22.0.rc3
