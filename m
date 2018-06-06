From: hch@lst.de (Christoph Hellwig)
Date: Wed,  6 Jun 2018 16:33:11 +0200
Subject: [PATCH 10/10] host fold
In-Reply-To: <20180606143311.23076-1-hch@lst.de>
References: <20180606143311.23076-1-hch@lst.de>
Message-ID: <20180606143311.23076-11-hch@lst.de>

---
 drivers/nvme/host/multipath.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index d30229a21c97..f88cc4e401c8 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -62,14 +62,16 @@ void nvme_failover_req(struct request *req)
 	 */
 	switch (nvme_req(req)->status & 0x7ff) {
 	case NVME_SC_ANA_TRANSITION:
-		/*
-		 * XXX: We should verify the controller doesn't die on during
-		 * the transition.  But that means we per-group timeout from
-		 * when we first hit the change state, so this won't be
-		 * entirely trivial..
-		 */
-		nvme_update_ana_state(ns, NVME_ANA_CHANGE);
+	{
+		enum nvme_ana_state old;
+
+		old = xchg(&ns->ctrl->ana_state[ns->anagrpid], NVME_ANA_CHANGE);
+		if (old != NVME_ANA_CHANGE) {
+			// XXX start timer
+			;
+		}
 		break;
+	}
 	case NVME_SC_ANA_PERSISTENT_LOSS:
 		nvme_update_ana_state(ns, NVME_ANA_PERSISTENT_LOSS);
 		break;
@@ -141,7 +143,6 @@ inline struct nvme_ns *nvme_find_path(struct nvme_ns_head *head)
 	ns = __nvme_find_path(head, NVME_ANA_OPTIMIZED);
 	if (!ns)
 		ns = __nvme_find_path(head, NVME_ANA_NONOPTIMIZED);
-	/* XXX: try an inaccessible path as last resort per 8.18.3.3 */
 	return ns;
 }
 
-- 
2.14.2
