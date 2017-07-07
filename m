From: a.dawn@samsung.com (Arnav Dawn)
Date: Fri, 07 Jul 2017 17:11:44 +0530
Subject: [PATCH v4 0/1]Add Support for FW activation without reset
In-Reply-To: <1497078304-5440-1-git-send-email-a.dawn@samsung.com>
References: <1497078304-5440-1-git-send-email-a.dawn@samsung.com>
 <CGME20170707114112epcas1p293dc44953b942eab9d24fcba69d0fb33@epcas1p2.samsung.com>
Message-ID: <1499427704-15785-1-git-send-email-a.dawn@samsung.com>

This adds Support for handling FW activation without reset.

changs since V3:
1. Moved timeout calculation to the work.
2. Added a delay of 100ms for scheduling fw_act_work
3. Added a check, that the controller is in NVME_CTRL_LIVE state
   before starting queues once PP is cleared or fw activation times out.

Arnav Dawn (1):
  nvme: Add support for FW activation without reset

 drivers/nvme/host/core.c | 69 ++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h | 21 +++++++++++++++
 include/linux/nvme.h     | 10 +++++++
 3 files changed, 100 insertions(+)

-- 
1.9.1
