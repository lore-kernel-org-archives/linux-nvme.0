From: hch@lst.de (Christoph Hellwig)
Date: Sat, 20 May 2017 15:13:56 +0200
Subject: [PATCH 3/4] nvme: save hmpre and hmmin in struct nvme_ctrl
In-Reply-To: <20170520131357.15929-1-hch@lst.de>
References: <20170520131357.15929-1-hch@lst.de>
Message-ID: <20170520131357.15929-4-hch@lst.de>

We'll need the later for the HMB support.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/core.c | 2 ++
 drivers/nvme/host/nvme.h | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d5e0906262ea..0f7fada284da 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1625,6 +1625,8 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 		}
 	} else {
 		ctrl->cntlid = le16_to_cpu(id->cntlid);
+		ctrl->hmpre = le32_to_cpu(id->hmpre);
+		ctrl->hmmin = le32_to_cpu(id->hmmin);
 	}
 
 	kfree(id);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 29c708ca9621..605f25b5145e 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -166,6 +166,9 @@ struct nvme_ctrl {
 	/* Power saving configuration */
 	u64 ps_max_latency_us;
 
+	u32 hmpre;
+	u32 hmmin;
+
 	/* Fabrics only */
 	u16 sqsize;
 	u32 ioccsz;
-- 
2.11.0
