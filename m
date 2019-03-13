From: hch@lst.de (Christoph Hellwig)
Date: Wed, 13 Mar 2019 18:54:57 +0100
Subject: [PATCH 04/17] nvme: put ns_head ref if namespace fails allocation
In-Reply-To: <20190313175510.20725-1-hch@lst.de>
References: <20190313175510.20725-1-hch@lst.de>
Message-ID: <20190313175510.20725-5-hch@lst.de>

From: Sagi Grimberg <sagi@grimberg.me>

In case nvme_alloc_ns fails after we initialize ns_head but before we
add the ns to the controller namespaces list we need to explicitly put
the ns_head reference because when we teardown the controller we
won't find it, causing us to leak a dangling subsystem eventually.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index dc1641247b17..d57a84f45ed0 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3304,6 +3304,7 @@ static int nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	mutex_lock(&ctrl->subsys->lock);
 	list_del_rcu(&ns->siblings);
 	mutex_unlock(&ctrl->subsys->lock);
+	nvme_put_ns_head(ns->head);
  out_free_id:
 	kfree(id);
  out_free_queue:
-- 
2.20.1
