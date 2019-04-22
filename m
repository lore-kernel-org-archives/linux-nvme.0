From: sashal@kernel.org (Sasha Levin)
Date: Mon, 22 Apr 2019 15:41:57 -0400
Subject: [PATCH AUTOSEL 5.0 90/98] nvmet: fix error flow during ns enable
In-Reply-To: <20190422194205.10404-1-sashal@kernel.org>
References: <20190422194205.10404-1-sashal@kernel.org>
Message-ID: <20190422194205.10404-90-sashal@kernel.org>

From: Max Gurtovoy <maxg@mellanox.com>

[ Upstream commit a536b49785759bf99465fdf6e248d34322123fcd ]

In case we fail to enable p2pmem on the current namespace, disable the
backing store device before exiting.

Cc: Stephen Bates <sbates at raithlin.com>
Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
Signed-off-by: Christoph Hellwig <hch at lst.de>
Signed-off-by: Sasha Levin (Microsoft) <sashal at kernel.org>
---
 drivers/nvme/target/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 02c63c463222..7bad21a2283f 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -517,7 +517,7 @@ int nvmet_ns_enable(struct nvmet_ns *ns)
 
 	ret = nvmet_p2pmem_ns_enable(ns);
 	if (ret)
-		goto out_unlock;
+		goto out_dev_disable;
 
 	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry)
 		nvmet_p2pmem_ns_add_p2p(ctrl, ns);
@@ -558,7 +558,7 @@ out_unlock:
 out_dev_put:
 	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry)
 		pci_dev_put(radix_tree_delete(&ctrl->p2p_ns_map, ns->nsid));
-
+out_dev_disable:
 	nvmet_ns_dev_disable(ns);
 	goto out_unlock;
 }
-- 
2.19.1
