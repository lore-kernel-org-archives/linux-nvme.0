From: vishal.l.verma@linux.intel.com (Vishal Verma)
Date: Mon, 13 May 2013 14:55:18 -0600
Subject: [PATCH] NVMe: Fix a signedness bug in nvme_trans_modesel_get_mp
Message-ID: <1368478518-5892-1-git-send-email-vishal.l.verma@linux.intel.com>

nvme_trans_modesel_get_mp() was defined with a unsigned return
type, but can return signed values.

Reported-by: Dan Carpenter <dan.carpenter at oracle.com>
Signed-off-by: Vishal Verma <vishal.l.verma at linux.intel.com>
---
 drivers/block/nvme-scsi.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/block/nvme-scsi.c b/drivers/block/nvme-scsi.c
index fed54b0..b08639a 100644
--- a/drivers/block/nvme-scsi.c
+++ b/drivers/block/nvme-scsi.c
@@ -1654,7 +1654,7 @@ static void nvme_trans_modesel_save_bd(struct nvme_ns *ns, u8 *parm_list,
 	}
 }
 
-static u16 nvme_trans_modesel_get_mp(struct nvme_ns *ns, struct sg_io_hdr *hdr,
+static int nvme_trans_modesel_get_mp(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 					u8 *mode_page, u8 page_code)
 {
 	int res = SNTI_TRANSLATION_SUCCESS;
-- 
1.7.0.4
