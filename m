From: scott.bauer@intel.com (Scott Bauer)
Date: Thu, 28 Jun 2018 11:10:07 -0600
Subject: [PATCH v2 1/1] nvme: Ensure forward progress during Admin passthru
In-Reply-To: <20180622195914.18575-1-scott.bauer@intel.com>
References: <20180622195914.18575-1-scott.bauer@intel.com>
Message-ID: <20180628171007.2423-1-scott.bauer@intel.com>

If the controller supports effects and goes down during
the passthru admin command we will deadlock during
namespace revalidation.

[  363.488275] INFO: task kworker/u16:5:231 blocked for more than 120 seconds.
[  363.488290]       Not tainted 4.17.0+ #2
[  363.488296] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  363.488303] kworker/u16:5   D    0   231      2 0x80000000
[  363.488331] Workqueue: nvme-reset-wq nvme_reset_work [nvme]
[  363.488338] Call Trace:
[  363.488385]  schedule+0x75/0x190
[  363.488396]  rwsem_down_read_failed+0x1c3/0x2f0
[  363.488481]  call_rwsem_down_read_failed+0x14/0x30
[  363.488504]  down_read+0x1d/0x80
[  363.488523]  nvme_stop_queues+0x1e/0xa0 [nvme_core]
[  363.488536]  nvme_dev_disable+0xae4/0x1620 [nvme]
[  363.488614]  nvme_reset_work+0xd1e/0x49d9 [nvme]
[  363.488911]  process_one_work+0x81a/0x1400
[  363.488934]  worker_thread+0x87/0xe80
[  363.488955]  kthread+0x2db/0x390
[  363.488977]  ret_from_fork+0x35/0x40

Fixes: 84fef62d135b6 ("nvme: check admin passthru command effects")

Signed-off-by: Scott Bauer <scott.bauer at intel.com>
---
 drivers/nvme/host/core.c | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 46df030b2c3f..1ad19f0782db 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -100,6 +100,15 @@ static struct class *nvme_subsys_class;
 static void nvme_ns_remove(struct nvme_ns *ns);
 static int nvme_revalidate_disk(struct gendisk *disk);
 static void nvme_put_subsystem(struct nvme_subsystem *subsys);
+static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
+					   unsigned nsid);
+
+static void nvme_set_queue_dying(struct nvme_ns *ns)
+{
+	blk_set_queue_dying(ns->queue);
+	/* Forcibly unquiesce queues to avoid blocking dispatch */
+	blk_mq_unquiesce_queue(ns->queue);
+}
 
 static void nvme_queue_scan(struct nvme_ctrl *ctrl)
 {
@@ -1151,19 +1160,17 @@ static u32 nvme_passthru_start(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 
 static void nvme_update_formats(struct nvme_ctrl *ctrl)
 {
-	struct nvme_ns *ns, *next;
-	LIST_HEAD(rm_list);
+	struct nvme_ns *ns;
 
-	down_write(&ctrl->namespaces_rwsem);
+	down_read(&ctrl->namespaces_rwsem);
 	list_for_each_entry(ns, &ctrl->namespaces, list) {
-		if (ns->disk && nvme_revalidate_disk(ns->disk)) {
-			list_move_tail(&ns->list, &rm_list);
-		}
+		if (ns->disk && nvme_revalidate_disk(ns->disk))
+			if (!test_and_set_bit(NVME_NS_DEAD, &ns->flags))
+				nvme_set_queue_dying(ns);
 	}
-	up_write(&ctrl->namespaces_rwsem);
+	up_read(&ctrl->namespaces_rwsem);
 
-	list_for_each_entry_safe(ns, next, &rm_list, list)
-		nvme_ns_remove(ns);
+	nvme_remove_invalid_namespaces(ctrl, NVME_NSID_ALL);
 }
 
 static void nvme_passthru_end(struct nvme_ctrl *ctrl, u32 effects)
@@ -3138,7 +3145,7 @@ static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
 
 	down_write(&ctrl->namespaces_rwsem);
 	list_for_each_entry_safe(ns, next, &ctrl->namespaces, list) {
-		if (ns->head->ns_id > nsid)
+		if (ns->head->ns_id > nsid || test_bit(NVME_NS_DEAD, &ns->flags))
 			list_move_tail(&ns->list, &rm_list);
 	}
 	up_write(&ctrl->namespaces_rwsem);
@@ -3550,10 +3557,7 @@ void nvme_kill_queues(struct nvme_ctrl *ctrl)
 		if (!ns->disk || test_and_set_bit(NVME_NS_DEAD, &ns->flags))
 			continue;
 		revalidate_disk(ns->disk);
-		blk_set_queue_dying(ns->queue);
-
-		/* Forcibly unquiesce queues to avoid blocking dispatch */
-		blk_mq_unquiesce_queue(ns->queue);
+		nvme_set_queue_dying(ns);
 	}
 	up_read(&ctrl->namespaces_rwsem);
 }
-- 
2.17.1
