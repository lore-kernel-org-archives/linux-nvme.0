From: lijie34@huawei.com (lijie)
Date: Mon, 29 Oct 2018 18:56:46 +0800
Subject: [PATCH] adjust serial number form u64 to u8[20]
Message-ID: <1540810606-17252-1-git-send-email-lijie34@huawei.com>

The serial number displayed on the host side using the nvme list command
is different from the attr_serial at the target side.The serial number is
adjusted from U64 to U8 at the target side to keep the display consistent.
---
 drivers/nvme/target/admin-cmd.c |  4 +---
 drivers/nvme/target/configfs.c  | 10 ++++++++--
 drivers/nvme/target/core.c      |  5 ++++-
 drivers/nvme/target/nvmet.h     |  2 +-
 4 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 1179f63..3cc531e 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -280,9 +280,7 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 	id->vid = 0;
 	id->ssvid = 0;
 
-	memset(id->sn, ' ', sizeof(id->sn));
-	bin2hex(id->sn, &ctrl->subsys->serial,
-		min(sizeof(ctrl->subsys->serial), sizeof(id->sn) / 2));
+	memcpy(id->sn, ctrl->subsys->sn, sizeof(id->sn));
 	memcpy_and_pad(id->mn, sizeof(id->mn), model, sizeof(model) - 1, ' ');
 	memcpy_and_pad(id->fr, sizeof(id->fr),
 		       UTS_RELEASE, strlen(UTS_RELEASE), ' ');
diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index b37a8e3..7bdfccdc 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -789,16 +789,22 @@ static ssize_t nvmet_subsys_attr_serial_show(struct config_item *item,
 {
 	struct nvmet_subsys *subsys = to_subsys(item);
 
-	return snprintf(page, PAGE_SIZE, "%llx\n", subsys->serial);
+	return snprintf(page, PAGE_SIZE, "%.20s\n", subsys->sn);
 }
 
 static ssize_t nvmet_subsys_attr_serial_store(struct config_item *item,
 					      const char *page, size_t count)
 {
 	struct nvmet_subsys *subsys = to_subsys(item);
+	char sn[21];
+
+	if (sscanf(page, "%20s\n", sn) != 1)
+	{
+		return -EINVAL;
+	}
 
 	down_write(&nvmet_config_sem);
-	sscanf(page, "%llx\n", &subsys->serial);
+	memcpy_and_pad(subsys->sn, sizeof(subsys->sn), sn, strlen(sn), ' ');
 	up_write(&nvmet_config_sem);
 
 	return count;
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 0acdff9..6bc8860 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1129,6 +1129,7 @@ struct nvmet_subsys *nvmet_subsys_alloc(const char *subsysnqn,
 		enum nvme_subsys_type type)
 {
 	struct nvmet_subsys *subsys;
+	u64	serial;
 
 	subsys = kzalloc(sizeof(*subsys), GFP_KERNEL);
 	if (!subsys)
@@ -1136,7 +1137,9 @@ struct nvmet_subsys *nvmet_subsys_alloc(const char *subsysnqn,
 
 	subsys->ver = NVME_VS(1, 3, 0); /* NVMe 1.3.0 */
 	/* generate a random serial number as our controllers are ephemeral: */
-	get_random_bytes(&subsys->serial, sizeof(subsys->serial));
+	get_random_bytes(&serial, sizeof(serial));
+	memset(subsys->sn, ' ', sizeof(subsys->sn));
+	bin2hex(subsys->sn, &serial, min(sizeof(serial), sizeof(subsys->sn) / 2));
 
 	switch (type) {
 	case NVME_NQN_NVME:
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 08f7b57..17edb43 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -204,7 +204,7 @@ struct nvmet_subsys {
 	u16			max_qid;
 
 	u64			ver;
-	u64			serial;
+	char			sn[20];
 	char			*subsysnqn;
 
 	struct config_group	group;
-- 
2.6.4.windows.1
