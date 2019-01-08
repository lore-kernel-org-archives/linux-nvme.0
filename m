From: andrew.smirnov@gmail.com (Andrey Smirnov)
Date: Mon,  7 Jan 2019 19:08:49 -0800
Subject: [PATCH] nvme-core: don't initlialize ctrl->cntlid twice
Message-ID: <20190108030849.12870-1-andrew.smirnov@gmail.com>

ctrl->cntlid will already be initialized from id->cntlid for
non-NVME_F_FABRICS controllers few lines below. For NVME_F_FABRICS
controllers this field should already be initialized, otherwise the
check

	if (ctrl->cntlid != le16_to_cpu(id->cntlid))

below will always be a no-op.

Cc: Keith Busch <keith.busch at intel.com>
Cc: Jens Axboe <axboe at fb.com>
Cc: Christoph Hellwig <hch at lst.de>
Cc: Sagi Grimberg <sagi at grimberg.me>
Cc: linux-nvme at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
Signed-off-by: Andrey Smirnov <andrew.smirnov at gmail.com>
---

I created this patch just from readying NVMe code. Appologies for the
noise if I misread/misinterpreted things and this assignment is
actually necessary.

Thanks,
Andrey Smirnov

 drivers/nvme/host/core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 2e65be8b1387..1ec87b30fad1 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2397,7 +2397,6 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 	ctrl->oaes = le32_to_cpu(id->oaes);
 	atomic_set(&ctrl->abort_limit, id->acl + 1);
 	ctrl->vwc = id->vwc;
-	ctrl->cntlid = le16_to_cpup(&id->cntlid);
 	if (id->mdts)
 		max_hw_sectors = 1 << (id->mdts + page_shift - 9);
 	else
-- 
2.20.1
