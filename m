From: keith.busch@intel.com (Keith Busch)
Date: Fri, 27 Oct 2017 13:51:22 -0600
Subject: [PATCH urgent-4.14] nvme: Fix setting logical block format when
 revalidating
Message-ID: <20171027195122.1810-1-keith.busch@intel.com>

Revalidating the disk needs to set the logical block format and capacity,
otherwise it can't figure out if the users modified anything about
the namespace.

Fixes: cdbff4f26bd9 ("nvme: remove nvme_revalidate_ns")

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 5a14cc7f28ee..37f9039bb9ca 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1249,6 +1249,7 @@ static int nvme_revalidate_disk(struct gendisk *disk)
 		goto out;
 	}
 
+	__nvme_revalidate_disk(disk, id);
 	nvme_report_ns_ids(ctrl, ns->ns_id, id, eui64, nguid, &uuid);
 	if (!uuid_equal(&ns->uuid, &uuid) ||
 	    memcmp(&ns->nguid, &nguid, sizeof(ns->nguid)) ||
-- 
2.13.6
