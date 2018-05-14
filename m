From: hch@lst.de (Christoph Hellwig)
Date: Mon, 14 May 2018 09:56:39 +0200
Subject: [PATCH 04/11] nvme: always failover on path or transport errors
In-Reply-To: <20180514075646.28823-1-hch@lst.de>
References: <20180514075646.28823-1-hch@lst.de>
Message-ID: <20180514075646.28823-5-hch@lst.de>

NVMe 1.3 TP 4028 introduced a new status code type 3h for
"Path Related Status".  We should always retry on another path for this
class of errors, without even trying to decode them.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/multipath.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index d7b664ae5923..b5a00853fbe2 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -59,6 +59,8 @@ bool nvme_req_needs_failover(struct request *req, blk_status_t error)
 {
 	if (!(req->cmd_flags & REQ_NVME_MPATH))
 		return false;
+	if (nvme_req(req)->status & 0x300)
+		return true;
 	return blk_path_error(error);
 }
 
-- 
2.17.0
