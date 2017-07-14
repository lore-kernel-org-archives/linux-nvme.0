From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Fri, 14 Jul 2017 13:00:04 +0200
Subject: [PATCH 2/2] nvmet: preserve controller serial number between reboots
In-Reply-To: <20170714110004.11886-1-jthumshirn@suse.de>
References: <20170714110004.11886-1-jthumshirn@suse.de>
Message-ID: <20170714110004.11886-3-jthumshirn@suse.de>

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
index a358ecd93e11..9f19f0bde8f2 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -686,9 +686,31 @@ static ssize_t nvmet_subsys_version_store(struct config_item *item,
 }
 CONFIGFS_ATTR(nvmet_subsys_, version);
 
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
 	&nvmet_subsys_attr_version,
+	&nvmet_subsys_attr_attr_serial,
 	NULL,
 };
 
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index e3ceff3d2d17..d38f4b9861c1 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -767,8 +767,10 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
 	memcpy(ctrl->subsysnqn, subsysnqn, NVMF_NQN_SIZE);
 	memcpy(ctrl->hostnqn, hostnqn, NVMF_NQN_SIZE);
 
+	down_read(&nvmet_config_sem);
 	if (!subsys->serial)
 		get_random_bytes(&subsys->serial, sizeof(subsys->serial));
+	up_read(&nvmet_config_sem);
 
 	kref_init(&ctrl->ref);
 	ctrl->subsys = subsys;
-- 
2.12.3
