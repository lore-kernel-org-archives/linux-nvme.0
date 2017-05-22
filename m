From: ming.lei@redhat.com (Ming Lei)
Date: Mon, 22 May 2017 23:05:04 +0800
Subject: [PATCH v3 2/3] nvme: avoid to use blk_mq_abort_requeue_list()
In-Reply-To: <20170522150505.452-1-ming.lei@redhat.com>
References: <20170522150505.452-1-ming.lei@redhat.com>
Message-ID: <20170522150505.452-3-ming.lei@redhat.com>

NVMe may add request into requeue list simply and not kick off the
requeue if hw queues are stopped. Then blk_mq_abort_requeue_list()
is called in both nvme_kill_queues() and nvme_ns_remove() for
dealing with this issue.

Unfortunately blk_mq_abort_requeue_list() is absolutely a
race maker, for example, one request may be requeued during
the aborting. So this patch just calls blk_mq_kick_requeue_list() in
nvme_kill_queues() to handle this issue like what nvme_start_queues()
does. Now all requests in requeue list when queues are stopped will be
handled by blk_mq_kick_requeue_list() when queues are restarted, either
in nvme_start_queues() or in nvme_kill_queues().

Cc: stable at vger.kernel.org
Reported-by: Zhang Yi <yizhan at redhat.com>
Reviewed-by: Keith Busch <keith.busch at intel.com>
Reviewed-by: Christoph Hellwig <hch at lst.de>
Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>
Signed-off-by: Ming Lei <ming.lei at redhat.com>
---
 drivers/nvme/host/core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 40d5e4a9e8d7..04e115834702 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2098,7 +2098,6 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 		if (ns->ndev)
 			nvme_nvm_unregister_sysfs(ns);
 		del_gendisk(ns->disk);
-		blk_mq_abort_requeue_list(ns->queue);
 		blk_cleanup_queue(ns->queue);
 	}
 
@@ -2436,7 +2435,6 @@ void nvme_kill_queues(struct nvme_ctrl *ctrl)
 			continue;
 		revalidate_disk(ns->disk);
 		blk_set_queue_dying(ns->queue);
-		blk_mq_abort_requeue_list(ns->queue);
 
 		/*
 		 * Forcibly start all queues to avoid having stuck requests.
@@ -2444,6 +2442,9 @@ void nvme_kill_queues(struct nvme_ctrl *ctrl)
 		 * when the final removal happens.
 		 */
 		blk_mq_start_hw_queues(ns->queue);
+
+		/* draining requests in requeue list */
+		blk_mq_kick_requeue_list(ns->queue);
 	}
 	mutex_unlock(&ctrl->namespaces_mutex);
 }
-- 
2.9.4
