From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 29 Jul 2019 16:32:01 -0700
Subject: [PATCH rfc 2/2] nvme: fix possible use-after-free condition when
 controller reset is racing namespace scanning
In-Reply-To: <20190729233201.27993-1-sagi@grimberg.me>
References: <20190729233201.27993-1-sagi@grimberg.me>
Message-ID: <20190729233201.27993-3-sagi@grimberg.me>

remove ns from ctrl namespaces list before destroying the request queue
as the reset work will unquisce for all the controller namespaces, while
an online scan might remove invalid namespaces resulting from a
concurrent AEN.

While we're at it, move nvme_check_last_path to right after we modify
the multipath reated cleanups.

Reported-by: Hannes Reinecke  <hare at suse.de>
Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 5f6970e7ba73..9f8f8f5feeae 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3406,6 +3406,11 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 	synchronize_rcu(); /* guarantee not available in head->list */
 	nvme_mpath_clear_current_path(ns);
 	synchronize_srcu(&ns->head->srcu); /* wait for concurrent submissions */
+	nvme_mpath_check_last_path(ns);
+
+	down_write(&ns->ctrl->namespaces_rwsem);
+	list_del_init(&ns->list);
+	up_write(&ns->ctrl->namespaces_rwsem);
 
 	if (ns->disk && ns->disk->flags & GENHD_FL_UP) {
 		del_gendisk(ns->disk);
@@ -3414,11 +3419,6 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 			blk_integrity_unregister(ns->disk);
 	}
 
-	down_write(&ns->ctrl->namespaces_rwsem);
-	list_del_init(&ns->list);
-	up_write(&ns->ctrl->namespaces_rwsem);
-
-	nvme_mpath_check_last_path(ns);
 	nvme_put_ns(ns);
 }
 
-- 
2.17.1
