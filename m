From: ming.lei@redhat.com (Ming Lei)
Date: Wed, 24 Apr 2019 19:02:21 +0800
Subject: [PATCH V7 9/9] nvme: hold request queue's refcount in ns's whole
 lifetime
In-Reply-To: <20190424110221.17435-1-ming.lei@redhat.com>
References: <20190424110221.17435-1-ming.lei@redhat.com>
Message-ID: <20190424110221.17435-10-ming.lei@redhat.com>

Hennes reported the following kernel oops:

    There is a race condition between namespace rescanning and
    controller reset; during controller reset all namespaces are
    quiesed vie nams_stop_ctrl(), and after reset all namespaces
    are unquiesced again.
    When namespace scanning was active by the time controller reset
    was triggered the rescan code will call nvme_ns_remove(), which
    then will cause a kernel crash in nvme_start_ctrl() as it'll trip
    over uninitialized namespaces.

Patch "blk-mq: free hw queue's resource in hctx's release handler"
should make this issue quite difficult to trigger. However it can't
kill the issue completely becasue pre-condition of that patch is to
hold request queue's refcount before calling block layer API, and
there is still a small window between blk_cleanup_queue() and removing
the ns from the controller namspace list in nvme_ns_remove().

Hold request queue's refcount until the ns is freed, then the above race
can be avoided completely. Given the 'namespaces_rwsem' is always held
to retrieve ns for starting/stopping request queue, this lock can prevent
namespaces from being freed.

Cc: Dongli Zhang <dongli.zhang at oracle.com>
Cc: James Smart <james.smart at broadcom.com>
Cc: Bart Van Assche <bart.vanassche at wdc.com>
Cc: linux-scsi at vger.kernel.org,
Cc: Martin K . Petersen <martin.petersen at oracle.com>,
Cc: Christoph Hellwig <hch at lst.de>,
Cc: James E . J . Bottomley <jejb at linux.vnet.ibm.com>,
Reported-by: Hannes Reinecke <hare at suse.com>
Reviewed-by: Hannes Reinecke <hare at suse.com>
Reviewed-by: Keith Busch <keith.busch at intel.com>
Tested-by: James Smart <james.smart at broadcom.com>
Signed-off-by: Ming Lei <ming.lei at redhat.com>
---
 drivers/nvme/host/core.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 248ff3b48041..82cda6602ca7 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -406,6 +406,7 @@ static void nvme_free_ns(struct kref *kref)
 		nvme_nvm_unregister(ns);
 
 	put_disk(ns->disk);
+	blk_put_queue(ns->queue);
 	nvme_put_ns_head(ns->head);
 	nvme_put_ctrl(ns->ctrl);
 	kfree(ns);
@@ -3229,6 +3230,11 @@ static int nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 		goto out_free_ns;
 	}
 
+	if (!blk_get_queue(ns->queue)) {
+		ret = -ENXIO;
+		goto out_free_queue;
+	}
+
 	blk_queue_flag_set(QUEUE_FLAG_NONROT, ns->queue);
 	if (ctrl->ops->flags & NVME_F_PCI_P2PDMA)
 		blk_queue_flag_set(QUEUE_FLAG_PCI_P2PDMA, ns->queue);
@@ -3245,7 +3251,7 @@ static int nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	id = nvme_identify_ns(ctrl, nsid);
 	if (!id) {
 		ret = -EIO;
-		goto out_free_queue;
+		goto out_put_queue;
 	}
 
 	if (id->ncap == 0) {
@@ -3304,6 +3310,8 @@ static int nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	nvme_put_ns_head(ns->head);
  out_free_id:
 	kfree(id);
+ out_put_queue:
+	blk_put_queue(ns->queue);
  out_free_queue:
 	blk_cleanup_queue(ns->queue);
  out_free_ns:
-- 
2.9.5
