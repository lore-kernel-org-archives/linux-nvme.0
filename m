From: hch@lst.de (Christoph Hellwig)
Date: Wed, 18 Oct 2017 18:52:49 +0200
Subject: [PATCH 08/17] nvme: use kref_get_unless_zero in nvme_find_get_ns
In-Reply-To: <20171018165258.23212-1-hch@lst.de>
References: <20171018165258.23212-1-hch@lst.de>
Message-ID: <20171018165258.23212-9-hch@lst.de>

For kref_get_unless_zero to protect against lookup vs free races we need
to use it in all places where we aren't guaranteed to already hold a
reference.  There is no such guarantee in nvme_find_get_ns, so switch to
kref_get_unless_zero in this function.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index bdae1e4fcd0b..3f51bd0326b5 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2290,7 +2290,8 @@ static struct nvme_ns *nvme_find_get_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	mutex_lock(&ctrl->namespaces_mutex);
 	list_for_each_entry(ns, &ctrl->namespaces, list) {
 		if (ns->ns_id == nsid) {
-			kref_get(&ns->kref);
+			if (!kref_get_unless_zero(&ns->kref))
+				continue;
 			ret = ns;
 			break;
 		}
-- 
2.14.1
