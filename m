From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Fri,  2 Jun 2017 11:45:33 +0200
Subject: [PATCH v3 5/8] nvme: get list of namespace descriptors
In-Reply-To: <20170602094536.25775-1-jthumshirn@suse.de>
References: <20170602094536.25775-1-jthumshirn@suse.de>
Message-ID: <20170602094536.25775-6-jthumshirn@suse.de>

If a target identifies itself as NVMe 1.3 compliant, try to get the
list of Namespace Identification Descriptors and populate the UUID,
NGUID and EUI64 fileds in the NVMe namespace structure with these
values.

Signed-off-by: Johannes Thumshirn <jthumshirn at suse.de>
---
 drivers/nvme/host/core.c | 87 ++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h |  1 +
 2 files changed, 88 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 7b254be16887..37047841da0e 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -643,6 +643,85 @@ int nvme_identify_ctrl(struct nvme_ctrl *dev, struct nvme_id_ctrl **id)
 	return error;
 }
 
+static void nvme_parse_ns_descs(struct nvme_ns *ns, void *data)
+{
+	int pos;
+	int len;
+
+	for (pos = 0; pos < NVME_IDENTIFY_DATA_SIZE; pos += len) {
+		struct nvme_ns_identifier_hdr *cur = data + pos;
+
+		if (cur->nidl == 0)
+			break;
+
+		switch (cur->nidt) {
+		case NVME_NIDT_EUI64:
+			if (cur->nidl != NVME_NIDT_EUI64_LEN) {
+				dev_warn(ns->ctrl->dev,
+					 "Target returned bogus length: %d for NVME_NIDT_EUI64\n",
+					 cur->nidl);
+				return;
+			}
+			len = NVME_NIDT_EUI64_LEN;
+			memcpy(ns->eui, data + pos + sizeof(*cur), len);
+			break;
+		case NVME_NIDT_NGUID:
+			if (cur->nidl != NVME_NIDT_NGUID_LEN) {
+				dev_warn(ns->ctrl->dev,
+					 "Target returned bogus length: %d for NVME_NIDT_NGUID\n",
+					 cur->nidl);
+				return;
+			}
+			len = NVME_NIDT_NGUID_LEN;
+			memcpy(ns->nguid, data + pos + sizeof(*cur), len);
+			break;
+		case NVME_NIDT_UUID:
+			if (cur->nidl != NVME_NIDT_UUID_LEN) {
+				dev_warn(ns->ctrl->dev,
+					 "Target returned bogus length: %d for NVME_NIDT_UUID\n",
+					 cur->nidl);
+				return;
+			}
+			len = NVME_NIDT_UUID_LEN;
+			memcpy(ns->uuid, data + pos + sizeof(*cur), len);
+			break;
+		default:
+			dev_warn(ns->ctrl->dev,
+				 "Invalid Namespace Identification Descriptor Type: %d\n",
+				 cur->nidt);
+			return;
+		}
+
+		len += sizeof(*cur);
+	}
+}
+
+static int nvme_identify_ns_descs(struct nvme_ns *ns, unsigned nsid)
+{
+	struct nvme_command c = { };
+	int status;
+	void *data;
+
+	c.identify.opcode = nvme_admin_identify;
+	c.identify.nsid = cpu_to_le32(nsid);
+	c.identify.cns = NVME_ID_CNS_NS_DESC_LIST;
+
+	data = kzalloc(NVME_IDENTIFY_DATA_SIZE, GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	status = nvme_submit_sync_cmd(ns->ctrl->admin_q, &c, data,
+				      NVME_IDENTIFY_DATA_SIZE);
+	if (status)
+		goto free_data;
+
+	nvme_parse_ns_descs(ns, data);
+
+free_data:
+	kfree(data);
+	return status;
+}
+
 static int nvme_identify_ns_list(struct nvme_ctrl *dev, unsigned nsid, __le32 *ns_list)
 {
 	struct nvme_command c = { };
@@ -1017,6 +1096,14 @@ static int nvme_revalidate_ns(struct nvme_ns *ns, struct nvme_id_ns **id)
 		memcpy(ns->eui, (*id)->eui64, sizeof(ns->eui));
 	if (ns->ctrl->vs >= NVME_VS(1, 2, 0))
 		memcpy(ns->nguid, (*id)->nguid, sizeof(ns->nguid));
+	if (ns->ctrl->vs >= NVME_VS(1, 3, 0)) {
+		 /* Don't treat error as fatal we potentially
+		  * already have a NGUID or EUI-64
+		  */
+		if (nvme_identify_ns_descs(ns, ns->ns_id))
+			dev_warn(ns->ctrl->dev,
+				 "%s: Identify Descriptors failed\n", __func__);
+	}
 
 	return 0;
 }
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 5004f0c41397..7007521e8194 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -190,6 +190,7 @@ struct nvme_ns {
 
 	u8 eui[8];
 	u8 nguid[16];
+	u8 uuid[16];
 
 	unsigned ns_id;
 	int lba_shift;
-- 
2.12.0
