From: mwilck@suse.com (Martin Wilck)
Date: Thu, 28 Sep 2017 21:33:23 +0200
Subject: [PATCH 1/3] nvme: fix visibility of "uuid" ns attribute
Message-ID: <20170928193323.24545-1-mwilck@suse.com>

"uuid" must be invisible if both ns->uuid and ns->nguid are unset,
not if either one is.

Fixes: d934f9848a77 "nvme: provide UUID value to userspace"
Signed-off-by: Martin Wilck <mwilck at suse.com>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index bb2aad078637..5a14cc7f28ee 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2136,7 +2136,7 @@ static umode_t nvme_ns_attrs_are_visible(struct kobject *kobj,
 	struct nvme_ns *ns = nvme_get_ns_from_dev(dev);
 
 	if (a == &dev_attr_uuid.attr) {
-		if (uuid_is_null(&ns->uuid) ||
+		if (uuid_is_null(&ns->uuid) &&
 		    !memchr_inv(ns->nguid, 0, sizeof(ns->nguid)))
 			return 0;
 	}
-- 
2.14.0
