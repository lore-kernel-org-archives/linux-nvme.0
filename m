From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Tue, 30 May 2017 10:08:18 +0200
Subject: [PATCH 3/7] nvmet: add eui64 field to nvme_ns and populate via
 configfs
In-Reply-To: <cover.1496131397.git.jthumshirn@suse.de>
References: <cover.1496131397.git.jthumshirn@suse.de>
Message-ID: <fe6439add636d3fd31ef357230101819ae7f5090.1496131397.git.jthumshirn@suse.de>

Add the EUI-64 field from the NVMe Namespace Identification Descriptor
to the nvmet_ns structure and allow it's population via configfs.

Signed-off-by: Johannes Thumshirn <jthumshirn at suse.de>
---
 drivers/nvme/target/configfs.c | 48 ++++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/target/nvmet.h    |  1 +
 2 files changed, 49 insertions(+)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 0529a36501f4..0c6351253c3f 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -305,6 +305,53 @@ static ssize_t nvmet_ns_device_path_store(struct config_item *item,
 
 CONFIGFS_ATTR(nvmet_ns_, device_path);
 
+static ssize_t nvmet_ns_device_eui64_show(struct config_item *item, char *page)
+{
+	return sprintf(page, "%8phN\n", &to_nvmet_ns(item)->eui64);
+}
+
+static ssize_t nvmet_ns_device_eui64_store(struct config_item *item,
+					   const char *page, size_t count)
+{
+	struct nvmet_ns *ns = to_nvmet_ns(item);
+	struct nvmet_subsys *subsys = ns->subsys;
+	u8 eui64[8];
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
+	for (i = 0; i < 8; i++) {
+		if (p + 2 > page + count) {
+			ret = -EINVAL;
+			goto out_unlock;
+		}
+		if (!isxdigit(p[0]) || !isxdigit(p[1])) {
+			ret = -EINVAL;
+			goto out_unlock;
+		}
+
+		eui64[i] = (hex_to_bin(p[0]) << 4) | hex_to_bin(p[1]);
+		p += 2;
+
+		if (*p == '-')
+			p++;
+	}
+
+	memcpy(&ns->eui64, eui64, sizeof(eui64));
+out_unlock:
+	mutex_unlock(&subsys->lock);
+	return ret ? ret : count;
+}
+
+CONFIGFS_ATTR(nvmet_ns_, device_eui64);
+
 static ssize_t nvmet_ns_device_uuid_show(struct config_item *item, char *page)
 {
 	return sprintf(page, "%pUb\n", &to_nvmet_ns(item)->uuid);
@@ -427,6 +474,7 @@ static struct configfs_attribute *nvmet_ns_attrs[] = {
 	&nvmet_ns_attr_device_path,
 	&nvmet_ns_attr_device_nguid,
 	&nvmet_ns_attr_device_uuid,
+	&nvmet_ns_attr_device_eui64,
 	&nvmet_ns_attr_enable,
 	NULL,
 };
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 6ef7db521716..ee936c2f394a 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -47,6 +47,7 @@ struct nvmet_ns {
 	loff_t			size;
 	u8			nguid[16];
 	u8			uuid[16];
+	u8			eui64[8];
 
 	bool			enabled;
 	struct nvmet_subsys	*subsys;
-- 
2.12.0
