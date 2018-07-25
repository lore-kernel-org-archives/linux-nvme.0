From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Wed, 25 Jul 2018 07:31:40 +0000
Subject: [PATCH] nvmet: fixup crash on NULL device path
In-Reply-To: <20180725063517.94515-1-hare@suse.de>
References: <20180725063517.94515-1-hare@suse.de>
Message-ID: <BYAPR04MB45029D645E61E4533C76D81E86540@BYAPR04MB4502.namprd04.prod.outlook.com>


Looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>

From: Linux-nvme <linux-nvme-bounces@lists.infradead.org> on behalf of Hannes Reinecke <hare@suse.de>
Sent: Tuesday, July 24, 2018 11:35 PM
To: Christoph Hellwig
Cc: Keith Busch; Hannes Reinecke; Sagi Grimberg; linux-nvme at lists.infradead.org; Hannes Reinecke
Subject: [PATCH] nvmet: fixup crash on NULL device path
? 
 
When writing an empty string into the device_path attribute the kernel
will crash with

nvmet: failed to open block device (null): (-22)
BUG: unable to handle kernel NULL pointer dereference at 0000000000000000

This patch sanitizes the error handling for invalid device path settings.

Signed-off-by: Hannes Reinecke <hare at suse.com>
---
?drivers/nvme/target/configfs.c | 9 +++++++--
?1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 3ba5ea5c4376..b41db23260de 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -311,6 +311,7 @@ static ssize_t nvmet_ns_device_path_store(struct config_item *item,
?{
???????? struct nvmet_ns *ns = to_nvmet_ns(item);
???????? struct nvmet_subsys *subsys = ns->subsys;
+?????? size_t len;
???????? int ret;
?
???????? mutex_lock(&subsys->lock);
@@ -318,10 +319,14 @@ static ssize_t nvmet_ns_device_path_store(struct config_item *item,
???????? if (ns->enabled)
???????????????? goto out_unlock;
?
-?????? kfree(ns->device_path);
+?????? ret = -EINVAL;
+?????? len = strcspn(page, "\n");
+?????? if (!len)
+?????????????? goto out_unlock;
?
+?????? kfree(ns->device_path);
???????? ret = -ENOMEM;
-?????? ns->device_path = kstrndup(page, strcspn(page, "\n"), GFP_KERNEL);
+?????? ns->device_path = kstrndup(page, len, GFP_KERNEL);
???????? if (!ns->device_path)
???????????????? goto out_unlock;
?
-- 
2.12.3


_______________________________________________
Linux-nvme mailing list
Linux-nvme at lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
    
