From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Tue, 30 May 2017 10:08:17 +0200
Subject: [PATCH 2/7] nvmet: add uuid field to nvme_ns and populate via configfs
In-Reply-To: <cover.1496131397.git.jthumshirn@suse.de>
References: <cover.1496131397.git.jthumshirn@suse.de>
Message-ID: <4aecbc794651073b2812341dc63e1f2918cc6a82.1496131397.git.jthumshirn@suse.de>

Add the UUID field from the NVMe Namespace Identification Descriptor
to the nvmet_ns structure and allow it's population via configfs.

Signed-off-by: Johannes Thumshirn <jthumshirn at suse.de>
---
 drivers/nvme/target/configfs.c | 48 ++++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/target/nvmet.h    |  1 +
 2 files changed, 49 insertions(+)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index be8c800078e2..0529a36501f4 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -305,11 +305,58 @@ static ssize_t nvmet_ns_device_path_store(struct config_item *item,
 
 CONFIGFS_ATTR(nvmet_ns_, device_path);
 
+static ssize_t nvmet_ns_device_uuid_show(struct config_item *item, char *page)
+{
+	return sprintf(page, "%pUb\n", &to_nvmet_ns(item)->uuid);
+}
+
+static ssize_t nvmet_ns_device_uuid_store(struct config_item *item,
+					  const char *page, size_t count)
+{
+	struct nvmet_ns *ns = to_nvmet_ns(item);
+	struct nvmet_subsys *subsys = ns->subsys;
+	u8 uuid[16];
+	const char *p = page;
+	int i;
+	int ret = 0;
+
+
+	mutex_lock(&subsys->lock);
+	if (ns->enabled) {
+		ret = -EBUSY;
+		goto out_unlock;
+	}
+
+	for (i = 0; i < 16; i++) {
+		if (p + 2 > page + count) {
+			ret = -EINVAL;
+			goto out_unlock;
+		}
+		if (!isxdigit(p[0]) || !isxdigit(p[1])) {
+			ret = -EINVAL;
+			goto out_unlock;
+		}
+
+		uuid[i] = (hex_to_bin(p[0]) << 4) | hex_to_bin(p[1]);
+		p += 2;
+
+		if (*p == '-' || *p == ':')
+			p++;
+	}
+
+	memcpy(&ns->uuid, uuid, sizeof(uuid));
+out_unlock:
+	mutex_unlock(&subsys->lock);
+	return ret ? ret : count;
+}
+
 static ssize_t nvmet_ns_device_nguid_show(struct config_item *item, char *page)
 {
 	return sprintf(page, "%pUb\n", &to_nvmet_ns(item)->nguid);
 }
 
+CONFIGFS_ATTR(nvmet_ns_, device_uuid);
+
 static ssize_t nvmet_ns_device_nguid_store(struct config_item *item,
 		const char *page, size_t count)
 {
@@ -379,6 +426,7 @@ CONFIGFS_ATTR(nvmet_ns_, enable);
 static struct configfs_attribute *nvmet_ns_attrs[] = {
 	&nvmet_ns_attr_device_path,
 	&nvmet_ns_attr_device_nguid,
+	&nvmet_ns_attr_device_uuid,
 	&nvmet_ns_attr_enable,
 	NULL,
 };
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index cfc5c7fb0ab7..6ef7db521716 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -46,6 +46,7 @@ struct nvmet_ns {
 	u32			blksize_shift;
 	loff_t			size;
 	u8			nguid[16];
+	u8			uuid[16];
 
 	bool			enabled;
 	struct nvmet_subsys	*subsys;
-- 
2.12.0
