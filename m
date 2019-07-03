From: hare@suse.de (Hannes Reinecke)
Date: Wed,  3 Jul 2019 15:12:31 +0200
Subject: [PATCH 1/2] nvme-multipath: check singular list in
 vme_round_robin_path()
In-Reply-To: <20190703131232.58595-1-hare@suse.de>
References: <20190703131232.58595-1-hare@suse.de>
Message-ID: <20190703131232.58595-2-hare@suse.de>

When we have a singular list in nvme_round_robin_path() we still
need to check its validity.

Signed-off-by: Hannes Reinecke <hare at suse.com>
---
 drivers/nvme/host/multipath.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 499acf07d61a..c8cc82639327 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -178,8 +178,12 @@ static struct nvme_ns *nvme_round_robin_path(struct nvme_ns_head *head,
 {
 	struct nvme_ns *ns, *found, *fallback = NULL;
 
-	if (list_is_singular(&head->list))
+	if (list_is_singular(&head->list)) {
+		if (old->ctrl->state != NVME_CTRL_LIVE ||
+		    test_bit(NVME_NS_ANA_PENDING, &old->flags))
+			return NULL;
 		return old;
+	}
 
 	for (ns = nvme_next_ns(head, old);
 	     ns != old;
-- 
2.16.4
