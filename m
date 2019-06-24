From: bvanassche@acm.org (Bart Van Assche)
Date: Mon, 24 Jun 2019 13:05:18 -0700
Subject: [PATCH nvme-cli 0/3] Restore support for older gcc and glibc
Message-ID: <20190624200521.28191-1-bvanassche@acm.org>

Hi Keith,

The three patches in this series fix recently introduced regressions for
older gcc / glibc versions and fix more endianness issues. Please consider
these patches.

Thanks,

Bart.

Bart Van Assche (3):
  nvme-cli: Restore support for older gcc versions
  nvme-cli: Restore RHEL 7 compatibility
  nvme-cli: Fix more endianness issues

 fabrics.c                      |  2 +-
 linux/nvme.h                   |  9 ++--
 nvme-ioctl.c                   | 30 ++++++-------
 nvme-print.c                   | 53 ++++++++++++++---------
 nvme.c                         |  2 +-
 nvme.h                         | 54 ++++++++++++++---------
 plugins/intel/intel-nvme.c     | 16 +++----
 plugins/virtium/virtium-nvme.c |  2 +-
 plugins/wdc/wdc-nvme.c         | 79 +++++++++++++++++-----------------
 9 files changed, 136 insertions(+), 111 deletions(-)

-- 
2.22.0.410.gd8fdbe21b5-goog
