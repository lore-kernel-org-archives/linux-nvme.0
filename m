From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Tue,  6 Jun 2017 16:36:17 +0200
Subject: [PATCH v5 9/9] nvmet: allow overriding the NVMe VS via configfs
In-Reply-To: <20170606143617.32143-1-jthumshirn@suse.de>
References: <20170606143617.32143-1-jthumshirn@suse.de>
Message-ID: <20170606143617.32143-10-jthumshirn@suse.de>

Allow overriding the announced NVMe Version of a via configfs.

This is particularly helpful when debugging new features for the host
or target side without bumping the hard coded version (as the target
might not be fully compliant to the announced version yet).

Signed-off-by: Johannes Thumshirn <jthumshirn at suse.de>
Reviewed-by: Hannes Reinecke <hare at suse.com>
---
 drivers/nvme/target/configfs.c | 37 +++++++++++++++++++++++++++++++++++++
 include/linux/nvme.h           |  4 ++++
 2 files changed, 41 insertions(+)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 83bfe28fe7da..61995e0cd0c1 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -650,8 +650,45 @@ static ssize_t nvmet_subsys_attr_allow_any_host_store(struct config_item *item,
 
 CONFIGFS_ATTR(nvmet_subsys_, attr_allow_any_host);
 
+static ssize_t nvmet_subsys_version_show(struct config_item *item,
+					      char *page)
+{
+	struct nvmet_subsys *subsys = to_subsys(item);
+
+	if (NVME_TERTIARY(subsys->ver))
+		return snprintf(page, PAGE_SIZE, "%d.%d.%d\n",
+				(int)NVME_MAJOR(subsys->ver),
+				(int)NVME_MINOR(subsys->ver),
+				(int)NVME_TERTIARY(subsys->ver));
+	else
+		return snprintf(page, PAGE_SIZE, "%d.%d\n",
+				(int)NVME_MAJOR(subsys->ver),
+				(int)NVME_MINOR(subsys->ver));
+}
+
+static ssize_t nvmet_subsys_version_store(struct config_item *item,
+					       const char *page, size_t count)
+{
+	struct nvmet_subsys *subsys = to_subsys(item);
+	int major, minor, tertiary;
+	int ret;
+
+
+	ret = sscanf(page, "%d.%d.%d\n", &major, &minor, &tertiary);
+	if (ret != 2 && ret != 3)
+		return -EINVAL;
+
+	down_write(&nvmet_config_sem);
+	subsys->ver = NVME_VS(major, minor, tertiary);
+	up_write(&nvmet_config_sem);
+
+	return count;
+}
+CONFIGFS_ATTR(nvmet_subsys_, version);
+
 static struct configfs_attribute *nvmet_subsys_attrs[] = {
 	&nvmet_subsys_attr_attr_allow_any_host,
+	&nvmet_subsys_attr_version,
 	NULL,
 };
 
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 22da030a28c6..667077ded7eb 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -1070,4 +1070,8 @@ struct nvme_completion {
 #define NVME_VS(major, minor, tertiary) \
 	(((major) << 16) | ((minor) << 8) | (tertiary))
 
+#define NVME_MAJOR(ver)		((ver) >> 16)
+#define NVME_MINOR(ver)		(((ver) >> 8) & 0xff)
+#define NVME_TERTIARY(ver)	((ver) & 0xff)
+
 #endif /* _LINUX_NVME_H */
-- 
2.12.3
