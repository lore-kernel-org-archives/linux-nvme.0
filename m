From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 12 Aug 2019 20:13:36 -0700
Subject: [PATCH] nvme-multipath: fix possible I/O hang when paths are updated
Message-ID: <20190813031336.26503-1-sagi@grimberg.me>

From: Anton Eidelman <anton@lightbitslabs.com>

nvme_state_set_live() making a path available triggers requeue_work
in order to resubmit requests that ended up on requeue_list when no
paths were available.

This requeue_work may race with concurrent nvme_ns_head_make_request()
that do not observe the live path yet.
Such concurrent requests may by made by either:
- New IO submission.
- Requeue_work triggered by nvme_failover_req() or another ana_work.

A race may cause requeue_work capture the state of requeue_list before
more requests get onto the list. These requests will stay on the list
forever unless requeue_work is triggered again.

In order to prevent such race, nvme_state_set_live() should
synchronize_srcu(&head->srcu) before triggering the requeue_work and
prevent nvme_ns_head_make_request referencing an old snapshot of the
path list.

Signed-off-by: Anton Eidelman <anton at lightbitslabs.com>
Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
Note that without this patch, constant ANA path updates
can cause I/O to hang even if the controllers are fully
accessible.

 drivers/nvme/host/multipath.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 888d4543894e..af831d3d15d0 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -428,6 +428,7 @@ static void nvme_mpath_set_live(struct nvme_ns *ns)
 		srcu_read_unlock(&head->srcu, srcu_idx);
 	}
 
+	synchronize_srcu(&ns->head->srcu);
 	kblockd_schedule_work(&ns->head->requeue_work);
 }
 
-- 
2.17.1
