From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Fri,  7 Jun 2019 04:45:08 +0900
Subject: [RFC PATCH V7 3/7] nvme: trace: put cid with le16_to_cpu()
In-Reply-To: <20190606194512.11020-1-minwoo.im.dev@gmail.com>
References: <20190606194512.11020-1-minwoo.im.dev@gmail.com>
Message-ID: <20190606194512.11020-4-minwoo.im.dev@gmail.com>

The CID(Command Identifier) is in 16bits so that we need to convert it
to cpu's one.

Cc: Keith Busch <kbusch at kernel.org>
Cc: Christoph Hellwig <hch at lst.de>
Cc: Sagi Grimberg <sagi at grimberg.me>
Signed-off-by: Minwoo Im <minwoo.im.dev at gmail.com>
---
 drivers/nvme/host/trace.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/trace.h b/drivers/nvme/host/trace.h
index 62ee29107c32..59323e68c393 100644
--- a/drivers/nvme/host/trace.h
+++ b/drivers/nvme/host/trace.h
@@ -59,7 +59,7 @@ TRACE_EVENT(nvme_setup_cmd,
 		__entry->qid = nvme_req_qid(req);
 		__entry->opcode = cmd->common.opcode;
 		__entry->flags = cmd->common.flags;
-		__entry->cid = cmd->common.command_id;
+		__entry->cid = le16_to_cpu(cmd->common.command_id);
 		__entry->nsid = le32_to_cpu(cmd->common.nsid);
 		__entry->metadata = le64_to_cpu(cmd->common.metadata);
 		__assign_disk_name(__entry->disk, req->rq_disk);
-- 
2.21.0
