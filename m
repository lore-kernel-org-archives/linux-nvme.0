From: hare@suse.de (Hannes Reinecke)
Date: Wed, 27 Mar 2019 09:09:28 +0100
Subject: [PATCH 2/3] nvme: shorten race window in nvme_ns_remove()
In-Reply-To: <20190327080929.27918-1-hare@suse.de>
References: <20190327080929.27918-1-hare@suse.de>
Message-ID: <20190327080929.27918-3-hare@suse.de>

nvme_ns_remove() sets the 'NVME_NS_REMOVING' bit at first, but
only removes the namespace from the list at the very end.
This opens a rether large race window during which other processes
traversing the namespaces via list_for_each() will access partially
deleted namespaces, causing unpredictable results.
This patch shortens the race window by removing the namespace
from the list as early as possible.

Signed-off-by: Hannes Reinecke <hare at suse.com>
---
 drivers/nvme/host/core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index c583735383ca..8c87ef584e6d 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3316,6 +3316,10 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 	if (test_and_set_bit(NVME_NS_REMOVING, &ns->flags))
 		return;
 
+	down_write(&ns->ctrl->namespaces_rwsem);
+	list_del_init(&ns->list);
+	up_write(&ns->ctrl->namespaces_rwsem);
+
 	nvme_fault_inject_fini(ns);
 	if (ns->disk && ns->disk->flags & GENHD_FL_UP) {
 		del_gendisk(ns->disk);
@@ -3329,10 +3333,6 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 	nvme_mpath_clear_current_path(ns);
 	mutex_unlock(&ns->ctrl->subsys->lock);
 
-	down_write(&ns->ctrl->namespaces_rwsem);
-	list_del_init(&ns->list);
-	up_write(&ns->ctrl->namespaces_rwsem);
-
 	synchronize_srcu(&ns->head->srcu);
 	nvme_mpath_check_last_path(ns);
 	nvme_put_ns(ns);
-- 
2.16.4
