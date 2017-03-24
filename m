From: jsmart2021@gmail.com (jsmart2021@gmail.com)
Date: Thu, 23 Mar 2017 20:44:32 -0700
Subject: [PATCH 2/5] nvme_fc: Add ls aborts on remote port teardown
In-Reply-To: <20170324034435.8761-1-jsmart2021@gmail.com>
References: <20170324034435.8761-1-jsmart2021@gmail.com>
Message-ID: <20170324034435.8761-3-jsmart2021@gmail.com>

From: James Smart <jsmart2021@gmail.com>

remoteport teardown never aborted the LS opertions. Add support.

Signed-off-by: James Smart <james.smart at broadcom.com>
---
 drivers/nvme/host/fc.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 2013713..46594f1 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -61,12 +61,19 @@ struct nvme_fc_queue {
 	unsigned long		flags;
 } __aligned(sizeof(u64));	/* alignment for other things alloc'd with */
 
+enum nvme_fcop_flags {
+	FCOP_FLAGS_TERMIO	= (1 << 0),
+	FCOP_FLAGS_RELEASED	= (1 << 1),
+	FCOP_FLAGS_COMPLETE	= (1 << 2),
+};
+
 struct nvmefc_ls_req_op {
 	struct nvmefc_ls_req	ls_req;
 
 	struct nvme_fc_rport	*rport;
 	struct nvme_fc_queue	*queue;
 	struct request		*rq;
+	u32			flags;
 
 	int			ls_error;
 	struct completion	ls_done;
@@ -491,6 +498,30 @@ nvme_fc_rport_get(struct nvme_fc_rport *rport)
 	return kref_get_unless_zero(&rport->ref);
 }
 
+static int
+nvme_fc_abort_lsops(struct nvme_fc_rport *rport)
+{
+	struct nvmefc_ls_req_op *lsop;
+	unsigned long flags;
+
+restart:
+	spin_lock_irqsave(&rport->lock, flags);
+
+	list_for_each_entry(lsop, &rport->ls_req_list, lsreq_list) {
+		if (!(lsop->flags & FCOP_FLAGS_TERMIO)) {
+			lsop->flags |= FCOP_FLAGS_TERMIO;
+			spin_unlock_irqrestore(&rport->lock, flags);
+			rport->lport->ops->ls_abort(&rport->lport->localport,
+						&rport->remoteport,
+						&lsop->ls_req);
+			goto restart;
+		}
+	}
+	spin_unlock_irqrestore(&rport->lock, flags);
+
+	return 0;
+}
+
 /**
  * nvme_fc_unregister_remoteport - transport entry point called by an
  *                              LLDD to deregister/remove a previously
@@ -526,6 +557,8 @@ nvme_fc_unregister_remoteport(struct nvme_fc_remote_port *portptr)
 
 	spin_unlock_irqrestore(&rport->lock, flags);
 
+	nvme_fc_abort_lsops(rport);
+
 	nvme_fc_rport_put(rport);
 	return 0;
 }
-- 
2.9.3
