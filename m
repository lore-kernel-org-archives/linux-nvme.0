From: famz@redhat.com (Fam Zheng)
Date: Thu, 30 Jun 2016 09:59:53 +0800
Subject: [PATCH v2 12/12] nvme: Generate uevent after attribute available
In-Reply-To: <20160630015953.6888-1-famz@redhat.com>
References: <20160630015953.6888-1-famz@redhat.com>
Message-ID: <20160630015953.6888-13-famz@redhat.com>

It is documented that KOBJ_ADD should be generated after the object's
attributes and children are ready.  We can achieve this with the new
disk_gen_uevents interface.

Signed-off-by: Fam Zheng <famz at redhat.com>
---
 drivers/nvme/host/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index fd70894..2655521 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1462,11 +1462,12 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	if (ns->type == NVME_NS_LIGHTNVM)
 		return;
 
-	add_disk(ns->disk, true);
+	add_disk(ns->disk, false);
 	if (sysfs_create_group(&disk_to_dev(ns->disk)->kobj,
 					&nvme_ns_attr_group))
 		pr_warn("%s: failed to create sysfs group for identification\n",
 			ns->disk->disk_name);
+	disk_gen_uevents(ns->disk);
 	return;
  out_free_disk:
 	kfree(disk);
-- 
2.9.0
