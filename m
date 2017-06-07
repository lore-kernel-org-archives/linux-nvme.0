From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Wed,  7 Jun 2017 11:45:33 +0200
Subject: [PATCH v6 06/10] nvmet: add uuid field to nvme_ns and populate via
 configfs
In-Reply-To: <20170607094536.32419-1-jthumshirn@suse.de>
References: <20170607094536.32419-1-jthumshirn@suse.de>
Message-ID: <20170607094536.32419-7-jthumshirn@suse.de>

Add the UUID field from the NVMe Namespace Identification Descriptor
to the nvmet_ns structure and allow it's population via configfs.

Signed-off-by: Johannes Thumshirn <jthumshirn at suse.de>
Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
Reviewed-by: Hannes Reinecke <hare at suse.com>
---
 drivers/nvme/target/configfs.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index be8c800078e2..83bfe28fe7da 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -305,11 +305,41 @@ static ssize_t nvmet_ns_device_path_store(struct config_item *item,
 
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
+	int ret = 0;
+
+
+	mutex_lock(&subsys->lock);
+	if (ns->enabled) {
+		ret = -EBUSY;
+		goto out_unlock;
+	}
+
+
+	if (uuid_parse(page, &ns->uuid))
+		ret = -EINVAL;
+
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
@@ -379,6 +409,7 @@ CONFIGFS_ATTR(nvmet_ns_, enable);
 static struct configfs_attribute *nvmet_ns_attrs[] = {
 	&nvmet_ns_attr_device_path,
 	&nvmet_ns_attr_device_nguid,
+	&nvmet_ns_attr_device_uuid,
 	&nvmet_ns_attr_enable,
 	NULL,
 };
-- 
2.12.3
