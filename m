From: hch@lst.de (Christoph Hellwig)
Date: Thu,  1 Jun 2017 13:27:28 +0200
Subject: [PATCH 3/4] nvme: save hmpre and hmmin in struct nvme_ctrl
In-Reply-To: <20170601112729.9726-1-hch@lst.de>
References: <20170601112729.9726-1-hch@lst.de>
Message-ID: <20170601112729.9726-4-hch@lst.de>

We'll need the later for the HMB support.

Signed-off-by: Christoph Hellwig <hch at lst.de>
Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/core.c | 2 ++
 drivers/nvme/host/nvme.h | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index a60926410438..759980573153 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1637,6 +1637,8 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 		}
 	} else {
 		ctrl->cntlid = le16_to_cpu(id->cntlid);
+		ctrl->hmpre = le32_to_cpu(id->hmpre);
+		ctrl->hmmin = le32_to_cpu(id->hmmin);
 	}
 
 	kfree(id);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 9d6a070d4391..7f2a9c434540 100644
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
