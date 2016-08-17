From: famz@redhat.com (Fam Zheng)
Date: Wed, 17 Aug 2016 15:15:13 +0800
Subject: [PATCH 13/15] aoeblk: Pass attribute group to device_add_disk
In-Reply-To: <1471418115-3654-1-git-send-email-famz@redhat.com>
References: <1471418115-3654-1-git-send-email-famz@redhat.com>
Message-ID: <1471418115-3654-14-git-send-email-famz@redhat.com>

Previously after device_add_disk returns, the KOBJ_ADD uevent is already
emitted. Adding attributes after that is a poor usage of kobject, and
in practice may result in race conditions with userspace, for
example udev checks availability of certain attributes and initializes
/dev entries conditionally.

device_add_disk can handle adding attribute group better, so use it.

Signed-off-by: Fam Zheng <famz at redhat.com>
---
 drivers/block/aoe/aoeblk.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/block/aoe/aoeblk.c b/drivers/block/aoe/aoeblk.c
index 4edfff2..d1b7541 100644
--- a/drivers/block/aoe/aoeblk.c
+++ b/drivers/block/aoe/aoeblk.c
@@ -177,7 +177,7 @@ static struct attribute *aoe_attrs[] = {
 	NULL,
 };
 
-static const struct attribute_group attr_group = {
+static struct attribute_group attr_group = {
 	.attrs = aoe_attrs,
 };
 
@@ -219,11 +219,6 @@ aoedisk_rm_debugfs(struct aoedev *d)
 	d->debugfs = NULL;
 }
 
-static int
-aoedisk_add_sysfs(struct aoedev *d)
-{
-	return sysfs_create_group(&disk_to_dev(d->gd)->kobj, &attr_group);
-}
 void
 aoedisk_rm_sysfs(struct aoedev *d)
 {
@@ -417,8 +412,7 @@ aoeblk_gdalloc(void *vp)
 
 	spin_unlock_irqrestore(&d->lock, flags);
 
-	device_add_disk(NULL, gd, NULL);
-	aoedisk_add_sysfs(d);
+	device_add_disk(NULL, gd, &attr_group);
 	aoedisk_add_debugfs(d);
 
 	spin_lock_irqsave(&d->lock, flags);
-- 
2.7.4
