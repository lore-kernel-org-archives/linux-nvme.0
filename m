From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 14 Nov 2018 10:25:31 -0800
Subject: [PATCH v3 2/4] nvmet: don't override treq upon modification.
In-Reply-To: <20181114182534.28807-1-sagi@grimberg.me>
References: <20181114182534.28807-1-sagi@grimberg.me>
Message-ID: <20181114182534.28807-3-sagi@grimberg.me>

Only override the allowed parts of it.

Reviewed-by: Hannes Reinecke <hare at suse.com>
Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/target/configfs.c | 11 +++++++----
 drivers/nvme/target/nvmet.h    |  2 ++
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index d37fd7713bbc..a98ab935b537 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -153,7 +153,8 @@ CONFIGFS_ATTR(nvmet_, addr_traddr);
 static ssize_t nvmet_addr_treq_show(struct config_item *item,
 		char *page)
 {
-	switch (to_nvmet_port(item)->disc_addr.treq) {
+	switch (to_nvmet_port(item)->disc_addr.treq &
+		NVMET_TREQ_SECURE_CHANNEL_MASK) {
 	case NVMF_TREQ_NOT_SPECIFIED:
 		return sprintf(page, "not specified\n");
 	case NVMF_TREQ_REQUIRED:
@@ -169,6 +170,7 @@ static ssize_t nvmet_addr_treq_store(struct config_item *item,
 		const char *page, size_t count)
 {
 	struct nvmet_port *port = to_nvmet_port(item);
+	u8 treq = port->disc_addr.treq & ~NVMET_TREQ_SECURE_CHANNEL_MASK;
 
 	if (port->enabled) {
 		pr_err("Cannot modify address while enabled\n");
@@ -177,15 +179,16 @@ static ssize_t nvmet_addr_treq_store(struct config_item *item,
 	}
 
 	if (sysfs_streq(page, "not specified")) {
-		port->disc_addr.treq = NVMF_TREQ_NOT_SPECIFIED;
+		treq |= NVMF_TREQ_NOT_SPECIFIED;
 	} else if (sysfs_streq(page, "required")) {
-		port->disc_addr.treq = NVMF_TREQ_REQUIRED;
+		treq |= NVMF_TREQ_REQUIRED;
 	} else if (sysfs_streq(page, "not required")) {
-		port->disc_addr.treq = NVMF_TREQ_NOT_REQUIRED;
+		treq |= NVMF_TREQ_NOT_REQUIRED;
 	} else {
 		pr_err("Invalid value '%s' for treq\n", page);
 		return -EINVAL;
 	}
+	port->disc_addr.treq = treq;
 
 	return count;
 }
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 613a37683eae..abc603fa725d 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -56,6 +56,8 @@
 #define IPO_IATTR_CONNECT_SQE(x)	\
 	(cpu_to_le32(offsetof(struct nvmf_connect_command, x)))
 
+#define NVMET_TREQ_SECURE_CHANNEL_MASK 0x3
+
 struct nvmet_ns {
 	struct list_head	dev_link;
 	struct percpu_ref	ref;
-- 
2.17.1
