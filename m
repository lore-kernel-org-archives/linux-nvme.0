From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Thu, 19 Apr 2018 19:43:42 +0200
Subject: [PATCH] nvme: fc: provide a descriptive error
Message-ID: <20180419174342.27307-1-jthumshirn@suse.de>

Provide a descriptive error in case an lport to rport association
isn't found when creating the FC-NVME controller.

Currently it's very hard to debug the reason for a failed connect
attempt without a look at the source.

Signed-off-by: Johannes Thumshirn <jthumshirn at suse.de>

---
This actually happened to Hannes and me becuase of a typo in a
customer demo today, so yes things like this happen unitl we have a
proper way to do auto-connect.
---
 drivers/nvme/host/fc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 6cb26bcf6ec0..8b66879b4ebf 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -3284,6 +3284,8 @@ nvme_fc_create_ctrl(struct device *dev, struct nvmf_ctrl_options *opts)
 	}
 	spin_unlock_irqrestore(&nvme_fc_lock, flags);
 
+	pr_warn("%s: %s - %s combination not found\n",
+		__func__, opts->traddr, opts->host_traddr);
 	return ERR_PTR(-ENOENT);
 }
 
-- 
2.16.3
