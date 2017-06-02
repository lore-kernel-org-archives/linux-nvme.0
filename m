From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Fri,  2 Jun 2017 11:45:35 +0200
Subject: [PATCH v3 7/8] nvmet: allow overriding the NVMe VS via configfs
In-Reply-To: <20170602094536.25775-1-jthumshirn@suse.de>
References: <20170602094536.25775-1-jthumshirn@suse.de>
Message-ID: <20170602094536.25775-8-jthumshirn@suse.de>

Allow overriding the announced NVMe Version of a via configfs.

This is particularly helpful when debugging new features for the host
or target side without bumping the hard coded version (as the target
might not be fully compliant to the announced version yet).

Signed-off-by: Johannes Thumshirn <jthumshirn at suse.de>
---
 drivers/nvme/target/configfs.c | 34 ++++++++++++++++++++++++++++++++++
 include/linux/nvme.h           |  4 ++++
 2 files changed, 38 insertions(+)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 16f9f6e3a084..45421d4308a4 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -650,8 +650,42 @@ static ssize_t nvmet_subsys_attr_allow_any_host_store(struct config_item *item,
 
 CONFIGFS_ATTR(nvmet_subsys_, attr_allow_any_host);
 
+static ssize_t nvmet_subsys_version_show(struct config_item *item,
+					      char *page)
+{
+	struct nvmet_subsys *subsys = to_subsys(item);
+	int major, minor, tertiary;
+	u32 ver;
+
+	ver = subsys->ver;
+	major = NVME_MAJOR(ver);
+	minor = NVME_MINOR(ver);
+	tertiary = NVME_TERRIARY(ver);
+
+	return snprintf(page, PAGE_SIZE, "%d %d %d\n", major, minor, tertiary);
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
+	ret = sscanf(page, "%d %d %d\n", &major, &minor, &tertiary);
+	if (ret != 3)
+		return -EINVAL;
+
+	subsys->ver = NVME_VS(major, minor, tertiary);
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
index afa6ef484e50..0d6e307a7aa4 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -1069,4 +1069,8 @@ struct nvme_completion {
 #define NVME_VS(major, minor, tertiary) \
 	(((major) << 16) | ((minor) << 8) | (tertiary))
 
+#define NVME_MAJOR(ver)		((ver) >> 16)
+#define NVME_MINOR(ver)		(((ver) >> 8) & 0xff)
+#define NVME_TERRIARY(ver)	((ver) & 0xff)
+
 #endif /* _LINUX_NVME_H */
-- 
2.12.0
