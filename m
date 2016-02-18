From: wenbo.wang@memblaze.com (Wenbo Wang)
Date: Thu, 18 Feb 2016 02:00:47 +0000
Subject: [PATCH-4.5-v3 2/5] NVMe: Fix namespace removal deadlock
In-Reply-To: <1455734215-20396-3-git-send-email-keith.busch@intel.com>
References: <1455734215-20396-1-git-send-email-keith.busch@intel.com>
 <1455734215-20396-3-git-send-email-keith.busch@intel.com>
Message-ID: <BJXPR01MB1997CEFCF124760350CFEEDE0AF0@BJXPR01MB199.CHNPR01.prod.partner.outlook.cn>


> @@ -1300,10 +1305,8 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)  {
> 	struct nvme_ns *ns, *next;
> 
> -	mutex_lock(&ctrl->namespaces_mutex);
> 	list_for_each_entry_safe(ns, next, &ctrl->namespaces, list)
> 		nvme_ns_remove(ns);
>-	mutex_unlock(&ctrl->namespaces_mutex);
>}

Without this mutex, is it safe to run concurrently with nvme_free_ns which manipulates the list?

-----Original Message-----
From: Keith Busch [mailto:keith.busch@intel.com] 
Sent: Thursday, February 18, 2016 2:37 AM
To: linux-nvme at lists.infradead.org; Jens Axboe; Christoph Hellwig
Cc: Sagi Grimberg; Wenbo Wang; Johannes Thumshirn; Keith Busch
Subject: [PATCH-4.5-v3 2/5] NVMe: Fix namespace removal deadlock

This patch makes nvme namespace removal lockless. It is up to the caller to ensure no active namespace scanning is occuring.

The lockless removal allows the driver to cleanup a namespace request_queue if the controller fails during removal. Previously this could deadlock trying to acquire the namespace mutex in order to handle such events.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/core.c | 15 +++++++++------  drivers/nvme/host/nvme.h |  4 ++++
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c index 3cd921e..1b7387d 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -48,6 +48,10 @@ static void nvme_free_ns(struct kref *kref)  {
 	struct nvme_ns *ns = container_of(kref, struct nvme_ns, kref);
 
+	mutex_lock(&ns->ctrl->namespaces_mutex);
+	list_del_init(&ns->list);
+	mutex_unlock(&ns->ctrl->namespaces_mutex);
+
 	if (ns->type == NVME_NS_LIGHTNVM)
 		nvme_nvm_unregister(ns->queue, ns->disk->disk_name);
 
@@ -1179,11 +1183,13 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 
 static void nvme_ns_remove(struct nvme_ns *ns)  {
-	bool kill = nvme_io_incapable(ns->ctrl) &&
-			!blk_queue_dying(ns->queue);
+	bool kill;
 
-	lockdep_assert_held(&ns->ctrl->namespaces_mutex);
+	if (test_and_set_bit(NVME_NS_REMOVING, &ns->flags))
+		return;
 
+	kill = nvme_io_incapable(ns->ctrl) &&
+			!blk_queue_dying(ns->queue);
 	if (kill) {
 		blk_set_queue_dying(ns->queue);
 
@@ -1206,7 +1212,6 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 		blk_mq_abort_requeue_list(ns->queue);
 		blk_cleanup_queue(ns->queue);
 	}
-	list_del_init(&ns->list);
 	nvme_put_ns(ns);
 }
 
@@ -1300,10 +1305,8 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)  {
 	struct nvme_ns *ns, *next;
 
-	mutex_lock(&ctrl->namespaces_mutex);
 	list_for_each_entry_safe(ns, next, &ctrl->namespaces, list)
 		nvme_ns_remove(ns);
-	mutex_unlock(&ctrl->namespaces_mutex);
 }
 
 static DEFINE_IDA(nvme_instance_ida);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h index 9664d07..db413a7 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -112,6 +112,10 @@ struct nvme_ns {
 	bool ext;
 	u8 pi_type;
 	int type;
+	unsigned long flags;
+
+#define NVME_NS_REMOVING 0
+
 	u64 mode_select_num_blocks;
 	u32 mode_select_block_len;
 };
--
2.6.2.307.g37023ba
