From: jsmart2021@gmail.com (jsmart2021@gmail.com)
Date: Thu,  4 May 2017 11:07:36 -0700
Subject: [RFC 6/7] nvme_fc: move remote port get/put/free location
In-Reply-To: <20170504180737.5472-1-jsmart2021@gmail.com>
References: <20170504180737.5472-1-jsmart2021@gmail.com>
Message-ID: <20170504180737.5472-7-jsmart2021@gmail.com>

From: James Smart <jsmart2021@gmail.com>

move nvme_fc_rport_get/put and rport free to higher in the file to
avoid adding prototypes to resolve references in upcoming code additions

Signed-off-by: James Smart <james.smart at broadcom.com>
---
 drivers/nvme/host/fc.c | 78 +++++++++++++++++++++++++-------------------------
 1 file changed, 39 insertions(+), 39 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index a666f87e2437..484b7d55676c 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -394,6 +394,45 @@ nvme_fc_unregister_localport(struct nvme_fc_local_port *portptr)
 }
 EXPORT_SYMBOL_GPL(nvme_fc_unregister_localport);
 
+static void
+nvme_fc_free_rport(struct kref *ref)
+{
+	struct nvme_fc_rport *rport =
+		container_of(ref, struct nvme_fc_rport, ref);
+	struct nvme_fc_lport *lport =
+			localport_to_lport(rport->remoteport.localport);
+	unsigned long flags;
+
+	WARN_ON(rport->remoteport.port_state != FC_OBJSTATE_DELETED);
+	WARN_ON(!list_empty(&rport->ctrl_list));
+
+	/* remove from lport list */
+	spin_lock_irqsave(&nvme_fc_lock, flags);
+	list_del(&rport->endp_list);
+	spin_unlock_irqrestore(&nvme_fc_lock, flags);
+
+	/* let the LLDD know we've finished tearing it down */
+	lport->ops->remoteport_delete(&rport->remoteport);
+
+	ida_simple_remove(&lport->endp_cnt, rport->remoteport.port_num);
+
+	kfree(rport);
+
+	nvme_fc_lport_put(lport);
+}
+
+static void
+nvme_fc_rport_put(struct nvme_fc_rport *rport)
+{
+	kref_put(&rport->ref, nvme_fc_free_rport);
+}
+
+static int
+nvme_fc_rport_get(struct nvme_fc_rport *rport)
+{
+	return kref_get_unless_zero(&rport->ref);
+}
+
 /**
  * nvme_fc_register_remoteport - transport entry point called by an
  *                              LLDD to register the existence of a NVME
@@ -481,45 +520,6 @@ nvme_fc_register_remoteport(struct nvme_fc_local_port *localport,
 }
 EXPORT_SYMBOL_GPL(nvme_fc_register_remoteport);
 
-static void
-nvme_fc_free_rport(struct kref *ref)
-{
-	struct nvme_fc_rport *rport =
-		container_of(ref, struct nvme_fc_rport, ref);
-	struct nvme_fc_lport *lport =
-			localport_to_lport(rport->remoteport.localport);
-	unsigned long flags;
-
-	WARN_ON(rport->remoteport.port_state != FC_OBJSTATE_DELETED);
-	WARN_ON(!list_empty(&rport->ctrl_list));
-
-	/* remove from lport list */
-	spin_lock_irqsave(&nvme_fc_lock, flags);
-	list_del(&rport->endp_list);
-	spin_unlock_irqrestore(&nvme_fc_lock, flags);
-
-	/* let the LLDD know we've finished tearing it down */
-	lport->ops->remoteport_delete(&rport->remoteport);
-
-	ida_simple_remove(&lport->endp_cnt, rport->remoteport.port_num);
-
-	kfree(rport);
-
-	nvme_fc_lport_put(lport);
-}
-
-static void
-nvme_fc_rport_put(struct nvme_fc_rport *rport)
-{
-	kref_put(&rport->ref, nvme_fc_free_rport);
-}
-
-static int
-nvme_fc_rport_get(struct nvme_fc_rport *rport)
-{
-	return kref_get_unless_zero(&rport->ref);
-}
-
 static int
 nvme_fc_abort_lsops(struct nvme_fc_rport *rport)
 {
-- 
2.11.0
