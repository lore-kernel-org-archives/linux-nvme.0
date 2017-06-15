From: hch@lst.de (Christoph Hellwig)
Date: Thu, 15 Jun 2017 18:34:57 +0200
Subject: [PATCH 1/6] nvme: remove an misleading comment on strut nvme_ns
In-Reply-To: <20170615163502.10548-1-hch@lst.de>
References: <20170615163502.10548-1-hch@lst.de>
Message-ID: <20170615163502.10548-2-hch@lst.de>

While a NVMe Namespace is somewhat similar to a SCSI Logical Unit (and not
a Logical Unit Number anyway) there are subtile differences.  Remove the
misleading comment.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/nvme.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index f27c58b860f4..9cdd8b78b70b 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -179,9 +179,6 @@ struct nvme_ctrl {
 	struct nvmf_ctrl_options *opts;
 };
 
-/*
- * An NVM Express namespace is equivalent to a SCSI LUN
- */
 struct nvme_ns {
 	struct list_head list;
 
-- 
2.11.0
