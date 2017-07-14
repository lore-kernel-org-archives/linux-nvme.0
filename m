From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Fri, 14 Jul 2017 14:53:29 +0200
Subject: [PATCH v3 3/3] nvmet: preserve controller serial number between
 reboots
In-Reply-To: <20170714125329.18430-1-jthumshirn@suse.de>
References: <20170714125329.18430-1-jthumshirn@suse.de>
Message-ID: <20170714125329.18430-4-jthumshirn@suse.de>

The NVMe target has no way to preserve controller serial
IDs across reboots which breaks udev scripts doing
SYMLINK+="dev/disk/by-id/nvme-$env{ID_SERIAL}-part%n.

Export the randomly generated serial number via configfs and allow
setting of a serial via configfs to mitigate this breakage.

Signed-off-by: Johannes Thumshirn <jthumshirn at suse.de>
---
 drivers/nvme/target/configfs.c | 22 ++++++++++++++++++++++
 drivers/nvme/target/core.c     |  2 ++
 2 files changed, 24 insertions(+)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index ceee57bb0c24..0a0067e771f5 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -686,9 +686,31 @@ static ssize_t nvmet_subsys_attr_version_store(struct config_item *item,
 }
 CONFIGFS_ATTR(nvmet_subsys_, attr_version);
 
+static ssize_t nvmet_subsys_attr_serial_show(struct config_item *item,
+					     char *page)
+{
+	struct nvmet_subsys *subsys = to_subsys(item);
+
+	return snprintf(page, PAGE_SIZE, "%llx\n", subsys->serial);
+}
+
+static ssize_t nvmet_subsys_attr_serial_store(struct config_item *item,
+					      const char *page, size_t count)
+{
+	struct nvmet_subsys *subsys = to_subsys(item);
+
+	down_write(&nvmet_config_sem);
+	sscanf(page, "%llx\n", &subsys->serial);
+	up_write(&nvmet_config_sem);
+
+	return count;
+}
+CONFIGFS_ATTR(nvmet_subsys_, attr_serial);
+
 static struct configfs_attribute *nvmet_subsys_attrs[] = {
 	&nvmet_subsys_attr_attr_allow_any_host,
 	&nvmet_subsys_attr_attr_version,
+	&nvmet_subsys_attr_attr_serial,
 	NULL,
 };
 
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index f4b02bb4a1a8..60ff5a55c253 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -924,9 +924,11 @@ struct nvmet_subsys *nvmet_subsys_alloc(const char *subsysnqn,
 	if (!subsys)
 		return NULL;
 
+	down_write(&nvmet_config_sem);
 	subsys->ver = NVME_VS(1, 3, 0); /* NVMe 1.3.0 */
 	/* generate a random serial number as our controllers are ephemeral: */
 	get_random_bytes(&subsys->serial, sizeof(subsys->serial));
+	up_write(&nvmet_config_sem);
 
 	switch (type) {
 	case NVME_NQN_NVME:
-- 
2.12.3
