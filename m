From: hch@lst.de (Christoph Hellwig)
Date: Sat, 21 Nov 2015 08:28:24 +0100
Subject: [PATCH 06/16] nvme: make nvme_alloc_request more generic
In-Reply-To: <1448090914-13121-1-git-send-email-hch@lst.de>
References: <1448090914-13121-1-git-send-email-hch@lst.de>
Message-ID: <1448090914-13121-7-git-send-email-hch@lst.de>

Add a flags parameter that is passed through to blk_mq_alloc_request, and
mark it non-static for future users in pci.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/core.c | 10 +++++-----
 drivers/nvme/host/nvme.h |  2 ++
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 53cf507..dd3e469 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -77,13 +77,13 @@ static struct nvme_ns *nvme_get_ns_from_disk(struct gendisk *disk)
 	return ns;
 }
 
-static struct request *nvme_alloc_request(struct request_queue *q,
-		struct nvme_command *cmd)
+struct request *nvme_alloc_request(struct request_queue *q,
+		struct nvme_command *cmd, unsigned int flags)
 {
 	bool write = cmd->common.opcode & 1;
 	struct request *req;
 
-	req = blk_mq_alloc_request(q, write, 0);
+	req = blk_mq_alloc_request(q, write, flags);
 	if (IS_ERR(req))
 		return req;
 
@@ -110,7 +110,7 @@ int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 	struct request *req;
 	int ret;
 
-	req = nvme_alloc_request(q, cmd);
+	req = nvme_alloc_request(q, cmd, 0);
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 
@@ -150,7 +150,7 @@ int __nvme_submit_user_cmd(struct request_queue *q, struct nvme_command *cmd,
 	void *meta = NULL;
 	int ret;
 
-	req = nvme_alloc_request(q, cmd);
+	req = nvme_alloc_request(q, cmd, 0);
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 84bde22..52ccf95 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -205,6 +205,8 @@ int nvme_init_identify(struct nvme_ctrl *ctrl);
 void nvme_scan_namespaces(struct nvme_ctrl *ctrl);
 void nvme_remove_namespaces(struct nvme_ctrl *ctrl);
 
+struct request *nvme_alloc_request(struct request_queue *q,
+		struct nvme_command *cmd, unsigned int flags);
 int nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 		void *buf, unsigned bufflen);
 int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
-- 
1.9.1
