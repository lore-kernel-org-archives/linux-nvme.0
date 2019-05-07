From: akinobu.mita@gmail.com (Akinobu Mita)
Date: Wed,  8 May 2019 01:58:32 +0900
Subject: [PATCH v2 5/7] nvme: add facility to check log page attributes
In-Reply-To: <1557248314-4238-1-git-send-email-akinobu.mita@gmail.com>
References: <1557248314-4238-1-git-send-email-akinobu.mita@gmail.com>
Message-ID: <1557248314-4238-6-git-send-email-akinobu.mita@gmail.com>

This provides a facility to check whether the controller supports the
telemetry log pages and log page offset field for the Get Log Page
command.

Cc: Johannes Berg <johannes at sipsolutions.net>
Cc: Keith Busch <keith.busch at intel.com>
Cc: Jens Axboe <axboe at fb.com>
Cc: Christoph Hellwig <hch at lst.de>
Cc: Sagi Grimberg <sagi at grimberg.me>
Cc: Minwoo Im <minwoo.im.dev at gmail.com>
Signed-off-by: Akinobu Mita <akinobu.mita at gmail.com>
---
* v2
- New patch in this version.

 drivers/nvme/host/core.c | 1 +
 drivers/nvme/host/nvme.h | 1 +
 include/linux/nvme.h     | 2 ++
 3 files changed, 4 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 6265d92..42f09d6 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2580,6 +2580,7 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 	} else
 		ctrl->shutdown_timeout = shutdown_timeout;
 
+	ctrl->lpa = id->lpa;
 	ctrl->npss = id->npss;
 	ctrl->apsta = id->apsta;
 	prev_apst_enabled = ctrl->apst_enabled;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 527d645..8711c71 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -195,6 +195,7 @@ struct nvme_ctrl {
 	u32 vs;
 	u32 sgls;
 	u16 kas;
+	u8 lpa;
 	u8 npss;
 	u8 apsta;
 	u32 oaes;
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 5217fe4..c1c4ca5 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -294,6 +294,8 @@ enum {
 	NVME_CTRL_OACS_DIRECTIVES		= 1 << 5,
 	NVME_CTRL_OACS_DBBUF_SUPP		= 1 << 8,
 	NVME_CTRL_LPA_CMD_EFFECTS_LOG		= 1 << 1,
+	NVME_CTRL_LPA_EXTENDED_DATA		= 1 << 2,
+	NVME_CTRL_LPA_TELEMETRY_LOG		= 1 << 3,
 };
 
 struct nvme_lbaf {
-- 
2.7.4
