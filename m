From: lizhongfs@gmail.com (Li Zhong)
Date: Mon, 27 May 2019 12:01:59 +0800
Subject: [RFC PATCH] nvme: allowing transition from NVME_CTRL_NEW to
 NVME_CTRL_DELETING
Message-ID: <20190527040159.3631-1-lizhongfs@gmail.com>

It is possible that nvme_remove() being ran concurrently with
nvme_reset_work(), with following sequence:

nvme_probe()
  nvme_init_ctrl()
    //set to NEW
  nvme_async_probe()
                                                      nvme_remove()
                                                        //can not change to
                                                        //DELETING from NEW
    nvme_reset_ctrl_sync()
        nvme_reset_ctrl()
          //change from NEW
          //to RESETTING
                                                       flush reset_work()
                                                       //not yet queued
          queue reset_work
            nvme_reset_work()
              ....                                     ....

With the above running concurrently, then it is possible to cause some
strange issues, like kernel crash with illegal memory accessing
or something like:
kernel: pci 0000:00:1f.0: can't enable device: BAR 0
 [mem 0xc0000000-0xc0003fff] not claimed

This patch fixes it by allowing NVME_CTRL_DELETING state to be set from
NVME_CTRL_NEW state.

Signed-off-by: Li Zhong <lizhongfs at gmail.com>
---
 drivers/nvme/host/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 1b7c2afd84cb..035aa086b26b 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -347,6 +347,7 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 		break;
 	case NVME_CTRL_DELETING:
 		switch (old_state) {
+		case NVME_CTRL_NEW:
 		case NVME_CTRL_LIVE:
 		case NVME_CTRL_ADMIN_ONLY:
 		case NVME_CTRL_RESETTING:
-- 
2.20.1
