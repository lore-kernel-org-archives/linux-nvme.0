From: keith.busch@intel.com (Keith Busch)
Date: Fri,  5 Oct 2018 08:57:06 -0600
Subject: [PATCH] nvme: Remove ns sibling before clearing path
Message-ID: <20181005145706.24030-1-keith.busch@intel.com>

The code had been clearing a namespace being deleted as the current
path while that namespace was still in the path siblings list. It is
possible a new IO could set that namespace back to the current path
since it appeared to be an eligable path to select, which may result in
a use-after-free error.

This patch ensures a namespace being removed is not eligable to be reset
as a current path prior to clearing it as the current path.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 2db33a752e2b..db808d60749d 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3145,8 +3145,8 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 	}
 
 	mutex_lock(&ns->ctrl->subsys->lock);
-	nvme_mpath_clear_current_path(ns);
 	list_del_rcu(&ns->siblings);
+	nvme_mpath_clear_current_path(ns);
 	mutex_unlock(&ns->ctrl->subsys->lock);
 
 	down_write(&ns->ctrl->namespaces_rwsem);
-- 
2.14.4
