From: famz@redhat.com (Fam Zheng)
Date: Thu, 30 Jun 2016 09:59:46 +0800
Subject: [PATCH v2 05/12] aoeblk: Generate uevent after attribute available
In-Reply-To: <20160630015953.6888-1-famz@redhat.com>
References: <20160630015953.6888-1-famz@redhat.com>
Message-ID: <20160630015953.6888-6-famz@redhat.com>

It is documented that KOBJ_ADD should be generated after the object's
attributes and children are ready.  We can achieve this with the new
disk_gen_uevents interface.

Signed-off-by: Fam Zheng <famz at redhat.com>
---
 drivers/block/aoe/aoeblk.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/block/aoe/aoeblk.c b/drivers/block/aoe/aoeblk.c
index e91c5f1..f0cf4d6 100644
--- a/drivers/block/aoe/aoeblk.c
+++ b/drivers/block/aoe/aoeblk.c
@@ -417,9 +417,10 @@ aoeblk_gdalloc(void *vp)
 
 	spin_unlock_irqrestore(&d->lock, flags);
 
-	add_disk(gd, true);
+	add_disk(gd, false);
 	aoedisk_add_sysfs(d);
 	aoedisk_add_debugfs(d);
+	disk_gen_uevents(gd);
 
 	spin_lock_irqsave(&d->lock, flags);
 	WARN_ON(!(d->flags & DEVFL_GD_NOW));
-- 
2.9.0
