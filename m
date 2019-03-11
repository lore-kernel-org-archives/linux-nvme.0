From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 11 Mar 2019 15:02:26 -0700
Subject: [PATCH v4 2/3] nvme: put ns_head ref if namespace fails allocation
In-Reply-To: <20190311220227.23656-1-sagi@grimberg.me>
References: <20190311220227.23656-1-sagi@grimberg.me>
Message-ID: <20190311220227.23656-3-sagi@grimberg.me>

In case nvme_alloc_ns fails after we initialize ns_head but before we
add the ns to the controller namespaces list we need to explicitly put
the ns_head reference because when we teardown the controller we
won't find it, causing us to leak a dangling subsystem eventually.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index e08979094eb5..4530243ef706 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3314,6 +3314,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	mutex_lock(&ctrl->subsys->lock);
 	list_del_rcu(&ns->siblings);
 	mutex_unlock(&ctrl->subsys->lock);
+	nvme_put_ns_head(ns->head);
  out_free_id:
 	kfree(id);
  out_free_queue:
-- 
2.17.1
