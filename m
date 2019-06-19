From: bvanassche@acm.org (Bart Van Assche)
Date: Wed, 19 Jun 2019 10:36:48 -0700
Subject: [PATCH nvme-cli 00/13] Static checker fixes and NVMe 1.4 support
Message-ID: <20190619173701.8263-1-bvanassche@acm.org>

Hi Keith,

This patch series is what I came up with after having analyzed the output
of 'sparse' for the nvme-cli source code. This patch series also includes
two patches that add support for the new NVMe 1.4 Identify Namespace fields.

Thanks,

Bart.

Bart Van Assche (13):
  Remove superfluous casts
  Use NULL instead of 0 where a pointer is expected
  huawei: Declare local functions static
  seagate: Declare local functions static
  virtium: Declare local symbols static
  lightnvm: Fix an endianness issue
  virtium: Fix an endianness issue
  wdc: Fix endianness bugs
  Avoid using arrays with a variable length
  nvme-cli: Rework the code for getting and setting NVMf properties
  nvme-cli: Skip properties that are not supported
  Introduce NVMe 1.4 Identify Namespace fields in struct nvme_id_ns
  nvme-cli: Report the NVMe 1.4 NPWG, NPWA, NPDG, NPDA and NOWS fields

 fabrics.c                      |   2 +-
 linux/nvme.h                   |   7 +-
 nvme-ioctl.c                   | 126 +++++++++++++++++----------------
 nvme-ioctl.h                   |   2 +-
 nvme-lightnvm.c                |   2 +-
 nvme-models.c                  |   1 +
 nvme-print.c                   |  51 +++++++------
 plugins/huawei/huawei-nvme.c   |   3 +-
 plugins/intel/intel-nvme.c     |  16 ++---
 plugins/seagate/seagate-nvme.c |  58 +++++++--------
 plugins/virtium/virtium-nvme.c |  14 ++--
 plugins/wdc/wdc-nvme.c         |  88 ++++++++++++-----------
 12 files changed, 200 insertions(+), 170 deletions(-)

-- 
2.22.0.rc3
