From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun,  2 Jul 2017 11:20:51 +0300
Subject: [PATCH v2 2/3] nvme-rdma: remove redundant empty device add callout
In-Reply-To: <1498983652-18250-1-git-send-email-sagi@grimberg.me>
References: <1498983652-18250-1-git-send-email-sagi@grimberg.me>
Message-ID: <1498983652-18250-3-git-send-email-sagi@grimberg.me>

Now that its not needed, we can simply not assign it.

Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>
Reviewed-by: Christoph Hellwig <hch at lst.de>
Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/rdma.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 6d4119dfbdaa..934183f80fff 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1956,10 +1956,6 @@ static struct nvmf_transport_ops nvme_rdma_transport = {
 	.create_ctrl	= nvme_rdma_create_ctrl,
 };
 
-static void nvme_rdma_add_one(struct ib_device *ib_device)
-{
-}
-
 static void nvme_rdma_remove_one(struct ib_device *ib_device, void *client_data)
 {
 	struct nvme_rdma_ctrl *ctrl;
@@ -1981,7 +1977,6 @@ static void nvme_rdma_remove_one(struct ib_device *ib_device, void *client_data)
 
 static struct ib_client nvme_rdma_ib_client = {
 	.name   = "nvme_rdma",
-	.add = nvme_rdma_add_one,
 	.remove = nvme_rdma_remove_one
 };
 
-- 
2.7.4
