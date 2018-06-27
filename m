From: keith.busch@linux.intel.com (Keith Busch)
Date: Wed, 27 Jun 2018 14:27:41 -0600
Subject: [PATCH 1/1] nvme: Ensure forward progress during Admin passthru
In-Reply-To: <20180627190137.GA9697@sbauer-Z170X-UD5>
References: <20180622195914.18575-1-scott.bauer@intel.com>
 <20180622195914.18575-2-scott.bauer@intel.com>
 <20180627191241.GE9361@localhost.localdomain>
 <20180627190137.GA9697@sbauer-Z170X-UD5>
Message-ID: <20180627202741.GF9361@localhost.localdomain>

On Wed, Jun 27, 2018@01:01:38PM -0600, Scott Bauer wrote:
> On Wed, Jun 27, 2018@01:12:42PM -0600, Keith Busch wrote:
> > How about changing the reaction based on success?
> 
> I don't think this will work. The other scenario is the original admin command
> was fine. We enter nvme_update_formats, grab the semaphore as write, issue the
> nvme admin identify, that fails, we enter timeout, and attempt to down_read in
> diasble_dev -> stop queues and get stuck there.
> 
> We need a way where we are not holding a down_write on the semaphore while issuing
> I/O.

Oh right ... Maybe the down_write is a bad idea and we should instead
do something like how nvme_kill_queues works? What do you think of the
following?

---
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 46df030..596ea60 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1152,18 +1152,16 @@ static u32 nvme_passthru_start(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 static void nvme_update_formats(struct nvme_ctrl *ctrl)
 {
 	struct nvme_ns *ns, *next;
-	LIST_HEAD(rm_list);
 
-	down_write(&ctrl->namespaces_rwsem);
+	down_read(&ctrl->namespaces_rwsem);
 	list_for_each_entry(ns, &ctrl->namespaces, list) {
-		if (ns->disk && nvme_revalidate_disk(ns->disk)) {
-			list_move_tail(&ns->list, &rm_list);
-		}
+		if (ns->disk && nvme_revalidate_disk(ns->disk))
+			if (test_bit(NVME_NS_DEAD, &ns->flags))
+				set_capacity(disk, 0);
 	}
-	up_write(&ctrl->namespaces_rwsem);
+	up_read(&ctrl->namespaces_rwsem);
 
-	list_for_each_entry_safe(ns, next, &rm_list, list)
-		nvme_ns_remove(ns);
+	nvme_remove_invalid_namespaces(ctrl, NVME_NSID_ALL);
 }
 
 static void nvme_passthru_end(struct nvme_ctrl *ctrl, u32 effects)
@@ -3138,7 +3136,7 @@ static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
 
 	down_write(&ctrl->namespaces_rwsem);
 	list_for_each_entry_safe(ns, next, &ctrl->namespaces, list) {
-		if (ns->head->ns_id > nsid)
+		if (ns->head->ns_id > nsid || test_bit(NVME_NS_DEAD, &ns->flags))
 			list_move_tail(&ns->list, &rm_list);
 	}
 	up_write(&ctrl->namespaces_rwsem);
-- 
