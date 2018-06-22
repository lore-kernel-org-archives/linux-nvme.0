From: scott.bauer@intel.com (Scott Bauer)
Date: Fri, 22 Jun 2018 13:59:14 -0600
Subject: [PATCH 1/1] nvme: Ensure forward progress during Admin passthru
In-Reply-To: <20180622195914.18575-1-scott.bauer@intel.com>
References: <20180622195914.18575-1-scott.bauer@intel.com>
Message-ID: <20180622195914.18575-2-scott.bauer@intel.com>

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
 drivers/nvme/host/core.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 46df030b2c3f..19a729ccc30e 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1152,18 +1152,20 @@ static u32 nvme_passthru_start(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 static void nvme_update_formats(struct nvme_ctrl *ctrl)
 {
 	struct nvme_ns *ns, *next;
-	LIST_HEAD(rm_list);
+	LIST_HEAD(ns_list);
 
 	down_write(&ctrl->namespaces_rwsem);
-	list_for_each_entry(ns, &ctrl->namespaces, list) {
-		if (ns->disk && nvme_revalidate_disk(ns->disk)) {
-			list_move_tail(&ns->list, &rm_list);
-		}
-	}
+	list_splice_init(&ctrl->namespaces, &ns_list);
 	up_write(&ctrl->namespaces_rwsem);
 
-	list_for_each_entry_safe(ns, next, &rm_list, list)
-		nvme_ns_remove(ns);
+	list_for_each_entry_safe(ns, next, &ns_list, list) {
+		if (ns->disk && nvme_revalidate_disk(ns->disk))
+			nvme_ns_remove(ns);
+	}
+
+	down_write(&ctrl->namespaces_rwsem);
+	list_splice_init(&ns_list, &ctrl->namespaces);
+	up_write(&ctrl->namespaces_rwsem);
 }
 
 static void nvme_passthru_end(struct nvme_ctrl *ctrl, u32 effects)
-- 
2.17.1
