From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 18 Jul 2019 17:31:00 -0700
Subject: [PATCH 2/2] nvme-core: Fix deadlock when deleting the ctrl while
 scanning
In-Reply-To: <c52f80b1-e154-b11f-a868-e3209e4ccb2d@grimberg.me>
References: <20190718225132.5865-1-logang@deltatee.com>
 <20190718225132.5865-2-logang@deltatee.com>
 <c52f80b1-e154-b11f-a868-e3209e4ccb2d@grimberg.me>
Message-ID: <ba6d1a56-8f86-4060-a167-6d67435e1a88@grimberg.me>

> [1]:
Or actually:
--
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 76cd3dd8736a..a0e2072fe73e 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3576,6 +3576,12 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
         struct nvme_ns *ns, *next;
         LIST_HEAD(ns_list);

+       mutex_lock(&ctrl->scan_lock);
+       list_for_each_entry(ns, &ctrl->namespaces, list)
+               if (nvme_mpath_clear_current_path(ns))
+                       kblockd_schedule_work(&ns->head->requeue_work);
+       mutex_lock(&ctrl->scan_lock);
+
         /* prevent racing with ns scanning */
         flush_work(&ctrl->scan_work);

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index a9a927677970..0e7e41381388 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -109,18 +109,22 @@ static const char *nvme_ana_state_names[] = {
         [NVME_ANA_CHANGE]               = "change",
  };

-void nvme_mpath_clear_current_path(struct nvme_ns *ns)
+bool nvme_mpath_clear_current_path(struct nvme_ns *ns)
  {
         struct nvme_ns_head *head = ns->head;
+       bool changed = false;
         int node;

         if (!head)
-               return;
+               return changed;

         for_each_node(node) {
-               if (ns == rcu_access_pointer(head->current_path[node]))
+               if (ns == rcu_access_pointer(head->current_path[node])) {
                         rcu_assign_pointer(head->current_path[node], NULL);
+                       changed = true;
+               }
         }
+       return changed;
  }

  static bool nvme_path_is_disabled(struct nvme_ns *ns)
@@ -231,6 +235,24 @@ inline struct nvme_ns *nvme_find_path(struct 
nvme_ns_head *head)
         return ns;
  }

+static bool nvme_available_path(struct nvme_ns_head *head)
+{
+       struct nvme_ns *ns;
+
+       list_for_each_entry_rcu(ns, &head->list, siblings) {
+               switch (ns->ctrl->state) {
+               case NVME_CTRL_LIVE:
+               case NVME_CTRL_RESETTING:
+               case NVME_CTRL_CONNECTING:
+                       /* fallthru */
+                       return true;
+               default:
+                       break;
+               }
+       }
+       return false;
+}
+
  static blk_qc_t nvme_ns_head_make_request(struct request_queue *q,
                 struct bio *bio)
  {
@@ -257,14 +279,14 @@ static blk_qc_t nvme_ns_head_make_request(struct 
request_queue *q,
                                       disk_devt(ns->head->disk),
                                       bio->bi_iter.bi_sector);
                 ret = direct_make_request(bio);
-       } else if (!list_empty_careful(&head->list)) {
-               dev_warn_ratelimited(dev, "no path available - requeuing 
I/O\n");
+       } else if (nvme_available_path(head)) {
+               dev_warn_ratelimited(dev, "no usable path - requeuing 
I/O\n");

                 spin_lock_irq(&head->requeue_lock);
                 bio_list_add(&head->requeue_list, bio);
                 spin_unlock_irq(&head->requeue_lock);
         } else {
-               dev_warn_ratelimited(dev, "no path - failing I/O\n");
+               dev_warn_ratelimited(dev, "no available path - failing 
I/O\n");

                 bio->bi_status = BLK_STS_IOERR;
                 bio_endio(bio);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 716a876119c8..915179368d30 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -496,7 +496,7 @@ void nvme_mpath_remove_disk(struct nvme_ns_head *head);
  int nvme_mpath_init(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id);
  void nvme_mpath_uninit(struct nvme_ctrl *ctrl);
  void nvme_mpath_stop(struct nvme_ctrl *ctrl);
-void nvme_mpath_clear_current_path(struct nvme_ns *ns);
+bool nvme_mpath_clear_current_path(struct nvme_ns *ns);
  struct nvme_ns *nvme_find_path(struct nvme_ns_head *head);

  static inline void nvme_mpath_check_last_path(struct nvme_ns *ns)
--
