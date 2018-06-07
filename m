From: hare@suse.de (Hannes Reinecke)
Date: Thu,  7 Jun 2018 10:38:46 +0200
Subject: [PATCH 2/3] nvme: do not access request after calling
 blk_mq_end_request()
In-Reply-To: <20180607083847.51019-1-hare@suse.de>
References: <20180607083847.51019-1-hare@suse.de>
Message-ID: <20180607083847.51019-3-hare@suse.de>

After calling blk_mq_end_request() the request should be considered
freed, so accessing it afterwards might lead to use-after-free error.

Signed-off-by: Hannes Reinecke <hare at suse.com>
---
 drivers/nvme/host/multipath.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 7f34ae260ca9..87bd60b49bbc 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -51,6 +51,7 @@ void nvme_failover_req(struct request *req)
 	struct nvme_ns *ns = req->q->queuedata;
 	struct device *dev = disk_to_dev(ns->disk);
 	unsigned long flags;
+	unsigned int nvme_status = nvme_req(req)->status & 0x7ff;
 	enum nvme_ana_state ana_state;
 	bool ana_state_changed = false;
 
@@ -64,7 +65,7 @@ void nvme_failover_req(struct request *req)
 	 * caused the error:
 	 */
 	ana_state = READ_ONCE(ns->ctrl->ana_state[ns->anagrpid]);
-	switch (nvme_req(req)->status & 0x7ff) {
+	switch (nvme_status) {
 	case NVME_SC_ANA_TRANSITION:
 		if (ana_state != NVME_ANA_CHANGE) {
 			nvme_update_ana_state(ns, NVME_ANA_CHANGE);
-- 
2.12.3
