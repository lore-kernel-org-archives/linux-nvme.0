From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 19 Nov 2018 14:11:13 -0800
Subject: [PATCH v4 2/4] nvmet: don't override treq upon modification.
In-Reply-To: <20181119221116.23749-1-sagi@grimberg.me>
References: <20181119221116.23749-1-sagi@grimberg.me>
Message-ID: <20181119221116.23749-3-sagi@grimberg.me>

Only override the allowed parts of it.

Reviewed-by: Hannes Reinecke <hare at suse.com>
Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/target/configfs.c | 11 +++++++----
 include/linux/nvme.h           |  2 ++
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index d37fd7713bbc..260a401db01c 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -153,7 +153,8 @@ CONFIGFS_ATTR(nvmet_, addr_traddr);
 static ssize_t nvmet_addr_treq_show(struct config_item *item,
 		char *page)
 {
-	switch (to_nvmet_port(item)->disc_addr.treq) {
+	switch (to_nvmet_port(item)->disc_addr.treq &
+		NVME_TREQ_SECURE_CHANNEL_MASK) {
 	case NVMF_TREQ_NOT_SPECIFIED:
 		return sprintf(page, "not specified\n");
 	case NVMF_TREQ_REQUIRED:
@@ -169,6 +170,7 @@ static ssize_t nvmet_addr_treq_store(struct config_item *item,
 		const char *page, size_t count)
 {
 	struct nvmet_port *port = to_nvmet_port(item);
+	u8 treq = port->disc_addr.treq & ~NVME_TREQ_SECURE_CHANNEL_MASK;
 
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
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index e7d731776f62..72a6b00a98d6 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -63,6 +63,8 @@ enum {
 	NVMF_TREQ_NOT_REQUIRED	= 2,	/* Not Required */
 };
 
+#define NVME_TREQ_SECURE_CHANNEL_MASK 0x3
+
 /* RDMA QP Service Type codes for Discovery Log Page entry TSAS
  * RDMA_QPTYPE field
  */
-- 
2.17.1
