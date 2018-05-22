From: hare@suse.de (Hannes Reinecke)
Date: Tue, 22 May 2018 11:10:00 +0200
Subject: [PATCHv2 07/11] nvme: always failover on path or transport errors
In-Reply-To: <20180522091004.39620-1-hare@suse.de>
References: <20180522091004.39620-1-hare@suse.de>
Message-ID: <20180522091004.39620-8-hare@suse.de>

From: Christoph Hellwig <hch@lst.de>

NVMe 1.3 TP 4028 introduced a new status code type 3h for
"Path Related Status".  We should always retry on another path for this
class of errors, without even trying to decode them.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/multipath.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 956e0b8e9c4d..2802cbc7b7d0 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -37,6 +37,8 @@ bool nvme_req_needs_failover(struct request *req, blk_status_t error)
 {
 	if (!(req->cmd_flags & REQ_NVME_MPATH))
 		return false;
+	if (nvme_req(req)->status & 0x300)
+		return true;
 	return blk_path_error(error);
 }
 
-- 
2.12.3
