From: maxg@mellanox.com (Max Gurtovoy)
Date: Thu, 26 Jan 2017 17:17:28 +0200
Subject: [PATCH 2/2] nvme: Use CNS as 8-bit field and avoid endianness
 conversion
In-Reply-To: <1485443848-29478-1-git-send-email-maxg@mellanox.com>
References: <1485443848-29478-1-git-send-email-maxg@mellanox.com>
Message-ID: <1485443848-29478-2-git-send-email-maxg@mellanox.com>

From: Parav Pandit <parav@mellanox.com>

This patch defines CNS field as 8-bit field and avoids cpu_to/from_le
conversions.
Also initialize nvme_command cns value explicitly to NVME_ID_CNS_NS
for readability (don't rely on the fact that NVME_ID_CNS_NS = 0).

Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
Signed-off-by: Parav Pandit <parav at mellanox.com>
---
 drivers/nvme/host/core.c        |    5 +++--
 drivers/nvme/target/admin-cmd.c |    2 +-
 drivers/nvme/target/discovery.c |    4 ++--
 include/linux/nvme.h            |    4 +++-
 4 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 4300f88..bde2406 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -538,7 +538,7 @@ int nvme_identify_ctrl(struct nvme_ctrl *dev, struct nvme_id_ctrl **id)
 
 	/* gcc-4.4.4 (at least) has issues with initializers and anon unions */
 	c.identify.opcode = nvme_admin_identify;
-	c.identify.cns = cpu_to_le32(NVME_ID_CNS_CTRL);
+	c.identify.cns = NVME_ID_CNS_CTRL;
 
 	*id = kmalloc(sizeof(struct nvme_id_ctrl), GFP_KERNEL);
 	if (!*id)
@@ -556,7 +556,7 @@ static int nvme_identify_ns_list(struct nvme_ctrl *dev, unsigned nsid, __le32 *n
 	struct nvme_command c = { };
 
 	c.identify.opcode = nvme_admin_identify;
-	c.identify.cns = cpu_to_le32(NVME_ID_CNS_NS_ACTIVE_LIST);
+	c.identify.cns = NVME_ID_CNS_NS_ACTIVE_LIST;
 	c.identify.nsid = cpu_to_le32(nsid);
 	return nvme_submit_sync_cmd(dev->admin_q, &c, ns_list, 0x1000);
 }
@@ -570,6 +570,7 @@ int nvme_identify_ns(struct nvme_ctrl *dev, unsigned nsid,
 	/* gcc-4.4.4 (at least) has issues with initializers and anon unions */
 	c.identify.opcode = nvme_admin_identify;
 	c.identify.nsid = cpu_to_le32(nsid);
+	c.identify.cns = NVME_ID_CNS_NS;
 
 	*id = kmalloc(sizeof(struct nvme_id_ns), GFP_KERNEL);
 	if (!*id)
diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 95ae523..f376dc4 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -509,7 +509,7 @@ int nvmet_parse_admin_cmd(struct nvmet_req *req)
 		break;
 	case nvme_admin_identify:
 		req->data_len = 4096;
-		switch (le32_to_cpu(cmd->identify.cns)) {
+		switch (cmd->identify.cns) {
 		case NVME_ID_CNS_NS:
 			req->execute = nvmet_execute_identify_ns;
 			return 0;
diff --git a/drivers/nvme/target/discovery.c b/drivers/nvme/target/discovery.c
index 12f39ee..af8aabf 100644
--- a/drivers/nvme/target/discovery.c
+++ b/drivers/nvme/target/discovery.c
@@ -186,14 +186,14 @@ int nvmet_parse_discovery_cmd(struct nvmet_req *req)
 		}
 	case nvme_admin_identify:
 		req->data_len = 4096;
-		switch (le32_to_cpu(cmd->identify.cns)) {
+		switch (cmd->identify.cns) {
 		case NVME_ID_CNS_CTRL:
 			req->execute =
 				nvmet_execute_identify_disc_ctrl;
 			return 0;
 		default:
 			pr_err("nvmet: unsupported identify cns %d\n",
-				le32_to_cpu(cmd->identify.cns));
+				cmd->identify.cns);
 			return NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
 		}
 	default:
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 3d1c6f1..d718890 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -641,7 +641,9 @@ struct nvme_identify {
 	__le32			nsid;
 	__u64			rsvd2[2];
 	union nvme_data_ptr	dptr;
-	__le32			cns;
+	__u8			cns;
+	__u8			rsvd3;
+	__le16			ctrlid;
 	__u32			rsvd11[5];
 };
 
-- 
1.7.1
