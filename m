From: hare@suse.de (Hannes Reinecke)
Date: Mon, 16 Jul 2018 12:58:37 +0200
Subject: [PATCH 5/5] nvme-multipath: parse entire ANA log page in
 nvme_set_ns_ana_state()
In-Reply-To: <20180716105837.101125-1-hare@suse.de>
References: <20180716105837.101125-1-hare@suse.de>
Message-ID: <20180716105837.101125-6-hare@suse.de>

We need to parse the entire ANA log page, otherwise later namespaces
will not be updates with the new ANA state.

Signed-off-by: Hannes Reinecke <hare at suse.com>
---
 drivers/nvme/host/multipath.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 3ba7a975fd2a..b92f0a6048c2 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -486,10 +486,8 @@ static int nvme_set_ns_ana_state(struct nvme_ctrl *ctrl,
 {
 	struct nvme_ns *ns = data;
 
-	if (ns->ana_grpid == le32_to_cpu(desc->grpid)) {
+	if (ns->ana_grpid == le32_to_cpu(desc->grpid))
 		nvme_update_ns_ana_state(desc, ns);
-		return -ENXIO; /* just break out of the loop */
-	}
 
 	return 0;
 }
-- 
2.12.3
