From: hare@suse.de (Hannes Reinecke)
Date: Wed, 27 Mar 2019 09:09:27 +0100
Subject: [PATCH 1/3] nvme: do not quiesce or unquiesce invalid namespaces
In-Reply-To: <20190327080929.27918-1-hare@suse.de>
References: <20190327080929.27918-1-hare@suse.de>
Message-ID: <20190327080929.27918-2-hare@suse.de>

nvme_(start,stop)_queues() might race with namespace scanning.
As namespaces might be removed during scanning, but the removal
from the list is not atomic, those functions might trip
over namespaces which are partially deleted, causing really
interesting kernel crashes.
So validate the namespaces in nvme_(start,stop)_queues().

Signed-off-by: Hannes Reinecke <hare at suse.com>
---
 drivers/nvme/host/core.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 470601980794..c583735383ca 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3857,8 +3857,11 @@ void nvme_stop_queues(struct nvme_ctrl *ctrl)
 	struct nvme_ns *ns;
 
 	down_read(&ctrl->namespaces_rwsem);
-	list_for_each_entry(ns, &ctrl->namespaces, list)
+	list_for_each_entry(ns, &ctrl->namespaces, list) {
+		if (test_bit(NVME_NS_REMOVING, &ns->flags))
+			continue;
 		blk_mq_quiesce_queue(ns->queue);
+	}
 	up_read(&ctrl->namespaces_rwsem);
 }
 EXPORT_SYMBOL_GPL(nvme_stop_queues);
@@ -3868,8 +3871,11 @@ void nvme_start_queues(struct nvme_ctrl *ctrl)
 	struct nvme_ns *ns;
 
 	down_read(&ctrl->namespaces_rwsem);
-	list_for_each_entry(ns, &ctrl->namespaces, list)
+	list_for_each_entry(ns, &ctrl->namespaces, list) {
+		if (test_bit(NVME_NS_REMOVING, &ns->flags))
+			continue;
 		blk_mq_unquiesce_queue(ns->queue);
+	}
 	up_read(&ctrl->namespaces_rwsem);
 }
 EXPORT_SYMBOL_GPL(nvme_start_queues);
-- 
2.16.4
