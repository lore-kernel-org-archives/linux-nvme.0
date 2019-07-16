From: hare@suse.de (Hannes Reinecke)
Date: Tue, 16 Jul 2019 09:18:30 +0200
Subject: [PATCH] nvme-multipath: sanitize nvme_update_ana_state()
Message-ID: <20190716071830.22672-1-hare@suse.de>

Commit 04e70bd4a026 ("nvme-multipath: do not select namespaces
which are about to be removed") introduced checks when traversing
the list of namespaces to avoid tripping over invalid namespaces.
A similar check is needed in nvme_update_ana_state() to skip updates
for any namespaces which will be removed.
With that we should also remove the WARN_ON() at the end of the
iteration; this will also be errorneously triggered if ANA Change AENS
are received during scanning.

Signed-off-by: Hannes Reinecke <hare at suse.com>
---
 drivers/nvme/host/multipath.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index a9a927677970..78415f2909cd 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -449,6 +449,8 @@ static int nvme_update_ana_state(struct nvme_ctrl *ctrl,
 
 	down_write(&ctrl->namespaces_rwsem);
 	list_for_each_entry(ns, &ctrl->namespaces, list) {
+		if (test_bit(NVME_NS_REMOVING, &ns->flags))
+			continue;
 		if (ns->head->ns_id != le32_to_cpu(desc->nsids[n]))
 			continue;
 		nvme_update_ns_ana_state(desc, ns);
@@ -456,7 +458,6 @@ static int nvme_update_ana_state(struct nvme_ctrl *ctrl,
 			break;
 	}
 	up_write(&ctrl->namespaces_rwsem);
-	WARN_ON_ONCE(n < nr_nsids);
 	return 0;
 }
 
-- 
2.16.4
