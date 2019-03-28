From: maxg@mellanox.com (Max Gurtovoy)
Date: Thu, 28 Mar 2019 12:54:03 +0200
Subject: [PATCH 1/1] nvmet: fix error flow during ns enable
Message-ID: <1553770443-23616-1-git-send-email-maxg@mellanox.com>

In case we fail to enable p2pmem on the current namespace, disable the
backing store device before exiting.

Cc: Stephen Bates <sbates at raithlin.com>
Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
---
 drivers/nvme/target/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 2d73b66..b3e765a 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -509,7 +509,7 @@ int nvmet_ns_enable(struct nvmet_ns *ns)
 
 	ret = nvmet_p2pmem_ns_enable(ns);
 	if (ret)
-		goto out_unlock;
+		goto out_dev_disable;
 
 	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry)
 		nvmet_p2pmem_ns_add_p2p(ctrl, ns);
@@ -550,7 +550,7 @@ int nvmet_ns_enable(struct nvmet_ns *ns)
 out_dev_put:
 	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry)
 		pci_dev_put(radix_tree_delete(&ctrl->p2p_ns_map, ns->nsid));
-
+out_dev_disable:
 	nvmet_ns_dev_disable(ns);
 	goto out_unlock;
 }
-- 
1.8.3.1
