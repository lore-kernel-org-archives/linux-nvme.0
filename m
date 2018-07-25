From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Wed, 25 Jul 2018 07:35:45 +0000
Subject: [PATCH] nvmet: only check for filebacking on -ENOTBLK
In-Reply-To: <20180725063445.94447-1-hare@suse.de>
References: <20180725063445.94447-1-hare@suse.de>
Message-ID: <BYAPR04MB4502353B18234D2C7BB03DC286540@BYAPR04MB4502.namprd04.prod.outlook.com>

Thanks, looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>


From: Linux-nvme <linux-nvme-bounces@lists.infradead.org> on behalf of Hannes Reinecke <hare@suse.de>
Sent: Tuesday, July 24, 2018 11:34 PM
To: Christoph Hellwig
Cc: Keith Busch; Hannes Reinecke; Sagi Grimberg; linux-nvme at lists.infradead.org; Hannes Reinecke
Subject: [PATCH] nvmet: only check for filebacking on -ENOTBLK
? 
 
We only need to check for a file-backed namespace if
nvmet_bdev_ns_enable() returns -ENOTBLK. For any other error
it's pointless as the open() error will remain the same.

Signed-off-by: Hannes Reinecke <hare at suse.com>
---
?drivers/nvme/target/core.c | 2 +-
?1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index ddd85715a00a..a216d7eb1050 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -344,7 +344,7 @@ int nvmet_ns_enable(struct nvmet_ns *ns)
???????????????? goto out_unlock;
?
???????? ret = nvmet_bdev_ns_enable(ns);
-?????? if (ret)
+?????? if (ret == -ENOTBLK)
???????????????? ret = nvmet_file_ns_enable(ns);
???????? if (ret)
???????????????? goto out_unlock;
-- 
2.12.3


_______________________________________________
Linux-nvme mailing list
Linux-nvme at lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme


Linux-nvme Info Page - lists.infradead.org
lists.infradead.org
To see the collection of prior postings to the list, visit the Linux-nvme Archives.. Using Linux-nvme: To post a message to all the list members, send email to linux-nvme at lists.infradead.org.

    
