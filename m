From: susobhan.dey@gmail.com (Susobhan Dey)
Date: Mon, 24 Sep 2018 00:31:11 -0700
Subject: [PATCH v2] NVMe multipath Added configarable failover progression time
In-Reply-To: <f7534931-eb78-aa7c-6ede-a617d8258e37@grimberg.me>
References: <f7534931-eb78-aa7c-6ede-a617d8258e37@grimberg.me>
Message-ID: <20180924073111.17132-1-susobhan.dey@gmail.com>

Added a module parameter failover_tt to tell multipather
how long it should wait before sending commands to next
available path. The whole reason of adding it, not all
architecture can handle IOs in active/active fashion even
though next path is live/accessible it can't handle IOs
immediately. We should give some time to underneath controller
to make itself active. ANA gives them the provision,using ANA
it is possible to advertise path status. Say for example if
path is in transition then host will requeue the commands till
path become optimized/unoptimized if no other path is optimized.
So this is a host side additional provision where multipather
will wait for sometime for example 10 sec and by that time controller
should be active to handle IOs. Whole point is controller is live
does not necessarily mean that controller is active.

Signed-off-by: Susobhan Dey <susobhan.dey at gmail.com>
---
 drivers/nvme/host/multipath.c | 59 +++++++++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h      | 19 ++++++++++-
 2 files changed, 77 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 5a9562881d4e..dbe5d24a3a14 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -20,6 +20,11 @@ module_param(multipath, bool, 0444);
 MODULE_PARM_DESC(multipath,
 	"turn on native support for multiple controllers per subsystem");
 
+unsigned int failover_tt = 0;
+module_param(failover_tt, uint, 0644);
+MODULE_PARM_DESC(failover_tt,
+	"failover progression time.");
+
 inline bool nvme_ctrl_use_ana(struct nvme_ctrl *ctrl)
 {
 	return multipath && ctrl->subsys && (ctrl->subsys->cmic & (1 << 3));
@@ -47,6 +52,22 @@ void nvme_set_disk_name(char *disk_name, struct nvme_ns *ns,
 	}
 }
 
+/*
+ * when fo_work executes that eventually means that failover_tt is
+ * over. Now multipather can send IOs to next live path.
+ * hence inside the function we clear failover progress bit of mpath
+ * so that multipath_make_request can choose current path and send
+ * IOs down
+ */
+static void nvme_mpath_fo_work(struct work_struct *work)
+{
+	struct nvme_ns_head *head =
+		container_of(to_delayed_work(work), struct nvme_ns_head, fo_work);
+	nvme_mpath_clear_fo_in_progress(head);
+	/* kick requeue list as path is now available */
+	kblockd_schedule_work(&head->requeue_work);
+}
+
 void nvme_failover_req(struct request *req)
 {
 	struct nvme_ns *ns = req->q->queuedata;
@@ -58,6 +79,22 @@ void nvme_failover_req(struct request *req)
 	spin_unlock_irqrestore(&ns->head->requeue_lock, flags);
 	blk_mq_end_request(req, 0);
 
+	/*
+	 * if user configure failover_tt, meaning next path is
+	 * not immediately available to serve IOs. In that case 
+	 * multipather has to wait till failover_tt before pushing
+	 * IOs to next live path.
+	 */
+	if (failover_tt)
+	{
+		/* set failover progression bit of mpath NS */
+		if (!nvme_mpath_set_fo_in_progress(ns->head))
+		{
+			INIT_DELAYED_WORK(&ns->head->fo_work, nvme_mpath_fo_work);
+			schedule_delayed_work(&ns->head->fo_work,failover_tt*HZ);
+		}
+	}
+
 	switch (status & 0x7ff) {
 	case NVME_SC_ANA_TRANSITION:
 	case NVME_SC_ANA_INACCESSIBLE:
@@ -141,12 +178,34 @@ static inline bool nvme_path_is_optimized(struct nvme_ns *ns)
 		ns->ana_state == NVME_ANA_OPTIMIZED;
 }
 
+static inline bool nvme_fo_is_in_progress(struct nvme_ns_head *head)
+{
+	/*
+	 * if failover_tt is not given, implicitly assume progression
+	 * time is 0. so multipather immediately choose next path
+	 * start sending IOs to that.
+	 */
+	if (!failover_tt)
+		return false;
+	if (test_bit(NVME_NS_FAILOVER_IN_PROGRESS, &head->flags))
+		return true;
+	return false;
+}
+
 inline struct nvme_ns *nvme_find_path(struct nvme_ns_head *head)
 {
 	struct nvme_ns *ns = srcu_dereference(head->current_path, &head->srcu);
+	/*
+	 * if failover_tt is configured then it will check failover
+	 * progression status. default it has no effect.
+	 */
+	if (nvme_fo_is_in_progress(head))
+		return NULL;
 
 	if (unlikely(!ns || !nvme_path_is_optimized(ns)))
+	{
 		ns = __nvme_find_path(head);
+	}
 	return ns;
 }
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index bb4a2003c097..c23d5f46db6e 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -283,7 +283,10 @@ struct nvme_ns_head {
 	struct bio_list		requeue_list;
 	spinlock_t		requeue_lock;
 	struct work_struct	requeue_work;
+	struct delayed_work     fo_work;
 	struct mutex		lock;
+#define NVME_NS_FAILOVER_IN_PROGRESS 4
+	unsigned long flags;
 #endif
 	struct list_head	list;
 	struct srcu_struct      srcu;
@@ -478,10 +481,17 @@ void nvme_mpath_stop(struct nvme_ctrl *ctrl);
 static inline void nvme_mpath_clear_current_path(struct nvme_ns *ns)
 {
 	struct nvme_ns_head *head = ns->head;
-
 	if (head && ns == rcu_access_pointer(head->current_path))
 		rcu_assign_pointer(head->current_path, NULL);
 }
+static inline int nvme_mpath_set_fo_in_progress(struct nvme_ns_head *head)
+{
+	return (test_and_set_bit(NVME_NS_FAILOVER_IN_PROGRESS, &head->flags));
+}
+static inline void nvme_mpath_clear_fo_in_progress(struct nvme_ns_head *head)
+{
+	test_and_clear_bit(NVME_NS_FAILOVER_IN_PROGRESS, &head->flags);
+}
 struct nvme_ns *nvme_find_path(struct nvme_ns_head *head);
 
 static inline void nvme_mpath_check_last_path(struct nvme_ns *ns)
@@ -534,6 +544,13 @@ static inline void nvme_mpath_clear_current_path(struct nvme_ns *ns)
 static inline void nvme_mpath_check_last_path(struct nvme_ns *ns)
 {
 }
+static inline int nvme_mpath_set_fo_in_progress(struct nvme_ns_head *head)
+{
+	return 0
+}
+static inline void nvme_mpath_clear_fo_in_progress(struct nvme_ns_head *head)
+{
+}
 static inline int nvme_mpath_init(struct nvme_ctrl *ctrl,
 		struct nvme_id_ctrl *id)
 {
-- 
2.17.1
