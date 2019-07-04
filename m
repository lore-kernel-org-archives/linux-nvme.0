From: hare@suse.de (Hannes Reinecke)
Date: Thu,  4 Jul 2019 08:10:47 +0200
Subject: [PATCH 2/2] nvme-multipath: do not select namespaces which are about
 to be removed
In-Reply-To: <20190704061047.94976-1-hare@suse.de>
References: <20190704061047.94976-1-hare@suse.de>
Message-ID: <20190704061047.94976-3-hare@suse.de>

nvme_ns_remove() will first set the NVME_NS_REMOVING flag before removing
it from the list at the very last step.
So to avoid selecting a namespace in nvme_find_path() which is about to be
removed check the NVME_NS_REMOVING flag, too, when selecting a new path.

Signed-off-by: Hannes Reinecke <hare at suse.com>
---
 drivers/nvme/host/multipath.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 9b6dc11fa559..a9a927677970 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -126,7 +126,8 @@ void nvme_mpath_clear_current_path(struct nvme_ns *ns)
 static bool nvme_path_is_disabled(struct nvme_ns *ns)
 {
 	return ns->ctrl->state != NVME_CTRL_LIVE ||
-		test_bit(NVME_NS_ANA_PENDING, &ns->flags);
+		test_bit(NVME_NS_ANA_PENDING, &ns->flags) ||
+		test_bit(NVME_NS_REMOVING, &ns->flags);
 }
 
 static struct nvme_ns *__nvme_find_path(struct nvme_ns_head *head, int node)
-- 
2.16.4
