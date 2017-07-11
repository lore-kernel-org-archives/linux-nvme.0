From: a.dawn@samsung.com (Arnav Dawn)
Date: Tue, 11 Jul 2017 19:14:35 +0530
Subject: [PATCH v5 0/1] Add Support for FW activation without reset
In-Reply-To: <1499427704-15785-1-git-send-email-a.dawn@samsung.com>
References: <1499427704-15785-1-git-send-email-a.dawn@samsung.com>
 <CGME20170711134400epcas5p305b45833e74d9189db6cc863e1c3abd7@epcas5p3.samsung.com>
Message-ID: <1499780675-9869-1-git-send-email-a.dawn@samsung.com>

This adds Support for handling FW activation without reset.

Changes since V4:
1> Removed reading of CC register from devicei to ctrl_config. 
2> Moved Nvme_get_pp_statust to core.c
3> Moved buffer alloc and dealloc to nvme_get_fw_slot_info 
   added a helper function to calculate dw10 for get fw slot info.
4> Changed fw_act_work type from delayed worked to work.
5> Removed AER completion case for Image Load Error.

Arnav Dawn (1):
  nvme: Add support for FW activation without reset

 drivers/nvme/host/core.c | 78 ++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h |  2 ++
 include/linux/nvme.h     |  9 ++++++
 3 files changed, 89 insertions(+)

-- 
1.9.1
