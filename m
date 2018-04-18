From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Wed, 18 Apr 2018 14:59:58 -0400
Subject: [PATCH 07/20] nvmet: add sync I/O configfs attr for ns
In-Reply-To: <20180418190011.3973-1-chaitanya.kulkarni@wdc.com>
References: <20180418190011.3973-1-chaitanya.kulkarni@wdc.com>
Message-ID: <20180418190011.3973-8-chaitanya.kulkarni@wdc.com>

This patch adds a configfs attribute to the ns to optionally
switch the mode between O_SYNC and O_DIRECT.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 drivers/nvme/target/configfs.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index e6b2d2af81b6..bc95be1276c6 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -406,11 +406,38 @@ static ssize_t nvmet_ns_enable_store(struct config_item *item,
 
 CONFIGFS_ATTR(nvmet_ns_, enable);
 
+static ssize_t nvmet_ns_sync_show(struct config_item *item, char *page)
+{
+	return sprintf(page, "%d\n", to_nvmet_ns(item)->sync);
+}
+
+static ssize_t nvmet_ns_sync_store(struct config_item *item,
+		const char *page, size_t count)
+{
+	struct nvmet_ns *ns = to_nvmet_ns(item);
+	bool sync;
+	int ret = 0;
+
+	if (strtobool(page, &sync))
+		return -EINVAL;
+
+	if (ns->filp && ns->sync != sync) {
+		nvmet_ns_disable(ns);
+		ns->sync = sync;
+		ret = nvmet_ns_enable(ns);
+	}
+
+	return ret ? ret : count;
+}
+
+CONFIGFS_ATTR(nvmet_ns_, sync);
+
 static struct configfs_attribute *nvmet_ns_attrs[] = {
 	&nvmet_ns_attr_device_path,
 	&nvmet_ns_attr_device_nguid,
 	&nvmet_ns_attr_device_uuid,
 	&nvmet_ns_attr_enable,
+	&nvmet_ns_attr_sync,
 	NULL,
 };
 
-- 
2.14.1
