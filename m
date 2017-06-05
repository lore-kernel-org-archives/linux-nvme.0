From: ming.lei@redhat.com (Ming Lei)
Date: Mon,  5 Jun 2017 23:59:20 +0800
Subject: [PATCH v4 06/11] nvme: host: unquiesce queue in nvme_kill_queues()
In-Reply-To: <20170605155925.7896-1-ming.lei@redhat.com>
References: <20170605155925.7896-1-ming.lei@redhat.com>
Message-ID: <20170605155925.7896-7-ming.lei@redhat.com>

When nvme_kill_queues() is run, queues may be in
quiesced state, so we forcibly unquiesce queues to avoid
blocking dispatch, and I/O hang can be avoided in
remove path.

Peviously we use blk_mq_start_stopped_hw_queues() as
counterpart of blk_mq_quiesce_queue(), now we have
introduced blk_mq_unquiesce_queue(), so use it explicitly.

Cc: linux-nvme at lists.infradead.org
Signed-off-by: Ming Lei <ming.lei at redhat.com>
---
 drivers/nvme/host/core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index c3f189e54d10..d4e5fc95da4b 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2438,6 +2438,9 @@ void nvme_kill_queues(struct nvme_ctrl *ctrl)
 	struct nvme_ns *ns;
 
 	mutex_lock(&ctrl->namespaces_mutex);
+
+	/* Forcibly unquiesce queues to avoid blocking dispatch */
+	blk_mq_unquiesce_queue(ctrl->admin_q);
 	list_for_each_entry(ns, &ctrl->namespaces, list) {
 		/*
 		 * Revalidating a dead namespace sets capacity to 0. This will
@@ -2448,6 +2451,9 @@ void nvme_kill_queues(struct nvme_ctrl *ctrl)
 		revalidate_disk(ns->disk);
 		blk_set_queue_dying(ns->queue);
 
+		/* Forcibly unquiesce queues to avoid blocking dispatch */
+		blk_mq_unquiesce_queue(ns->queue);
+
 		/*
 		 * Forcibly start all queues to avoid having stuck requests.
 		 * Note that we must ensure the queues are not stopped
-- 
2.9.4
