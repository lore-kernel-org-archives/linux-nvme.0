From: a.dawn@samsung.com (Arnav Dawn)
Date: Sat, 10 Jun 2017 12:35:44 +0530
Subject: [PATCH V3 0/2] Support for FW activation without reset
References: <CGME20170610070549epcas1p4fae7273b007148b52d31bf62cbb07b74@epcas1p4.samsung.com>
Message-ID: <1497078344-5509-1-git-send-email-a.dawn@samsung.com>

This series adds support for handling Firmware activation without
reset.

Changes since V2
1) Move get_log_page to scsi.c as get_smart_log_page.
2) Add helper function for checking ctrl PP status.
3) Minor cleanups.

Arnav Dawn (2):
  nvme: Rename and move get_log_page to nvme/scsi
  nvme: Add support for Fw activation without reset

 drivers/nvme/host/core.c | 90 +++++++++++++++++++++++++++++++++++-------------
 drivers/nvme/host/nvme.h | 23 ++++++++++++-
 drivers/nvme/host/scsi.c | 27 +++++++++++++--
 include/linux/nvme.h     | 10 ++++++
 4 files changed, 124 insertions(+), 26 deletions(-)

-- 
1.9.1
