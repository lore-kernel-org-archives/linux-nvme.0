From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Tue, 30 May 2017 10:08:21 +0200
Subject: [PATCH 6/7] nvme: get list of namespace descriptors
In-Reply-To: <cover.1496131397.git.jthumshirn@suse.de>
References: <cover.1496131397.git.jthumshirn@suse.de>
Message-ID: <b870714887588e54047977165757c9ace592b307.1496131397.git.jthumshirn@suse.de>

If a target identifies itself as NVMe 1.3 compliant, try to get the
list of Namespace Identification Descriptors and populate the UUID,
NGUID and EUI64 fileds in the NVMe namespace structure with these
values.

Signed-off-by: Johannes Thumshirn <jthumshirn at suse.de>
---
 drivers/nvme/host/core.c | 88 ++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h |  1 +
 2 files changed, 89 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 7b254be16887..d2365f7ea612 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -643,6 +643,71 @@ int nvme_identify_ctrl(struct nvme_ctrl *dev, struct nvme_id_ctrl **id)
 	return error;
 }
 
+static void nvme_parse_ns_descs(struct nvme_ns *ns, void *ns_nid)
+{
+	struct nvme_ns_nid *cur;
+	const u8 *p;
+	int pos = 0;
+	int len;
+
+	p = (u8 *)ns_nid;
+
+	for (;;) {
+		cur = (struct nvme_ns_nid *)p;
+
+		switch (cur->nidl) {
+		case 0:
+			return;
+		case 8:
+		case 16:
+			break;
+		default:
+			dev_warn(ns->ctrl->dev,
+				 "Target returned bogus Namespace Identification Descriptor length: %d\n",
+				 cur->nidl);
+			return;
+
+		}
+
+		switch (cur->nidt) {
+		case NVME_NIDT_EUI64:
+			len = 8;
+			memcpy(ns->eui, cur->nid, len);
+			break;
+		case NVME_NIDT_NGUID:
+			len = 16;
+			memcpy(ns->nguid, cur->nid, len);
+			break;
+		case NVME_NIDT_UUID:
+			len = 16;
+			memcpy(ns->uuid, cur->nid, len);
+			break;
+		default:
+			dev_warn(ns->ctrl->dev,
+				 "Invalid Namespace Identification Descriptor Type: %d\n",
+				 cur->nidt);
+			return;
+		}
+
+		pos += sizeof(struct nvme_ns_nid) + len;
+		if (pos >= 4096)
+			return;
+		p += pos;
+	}
+}
+
+static int nvme_identify_ns_descs(struct nvme_ctrl *dev, unsigned nsid,
+				  void *ns_nid)
+{
+	struct nvme_command c = { };
+
+	c.identify.opcode = nvme_admin_identify;
+	c.identify.nsid = cpu_to_le32(nsid);
+	c.identify.cns = NVME_ID_CNS_NS_DESC_LIST;
+
+	return nvme_submit_sync_cmd(dev->admin_q, &c, ns_nid, 4096);
+}
+
 static int nvme_identify_ns_list(struct nvme_ctrl *dev, unsigned nsid, __le32 *ns_list)
 {
 	struct nvme_command c = { };
@@ -1017,6 +1082,29 @@ static int nvme_revalidate_ns(struct nvme_ns *ns, struct nvme_id_ns **id)
 		memcpy(ns->eui, (*id)->eui64, sizeof(ns->eui));
 	if (ns->ctrl->vs >= NVME_VS(1, 2, 0))
 		memcpy(ns->nguid, (*id)->nguid, sizeof(ns->nguid));
+	if (ns->ctrl->vs >= NVME_VS(1, 3, 0)) {
+		void *ns_nid;
+		int ret;
+
+
+		ns_nid = kzalloc(4096, GFP_KERNEL);
+		if (!ns_nid) {
+			dev_warn(ns->ctrl->dev,
+				 "%s: Identify Descriptors failed\n", __func__);
+			return 0;
+		}
+
+		ret = nvme_identify_ns_descs(ns->ctrl, ns->ns_id, ns_nid);
+		if (ret) {
+			dev_warn(ns->ctrl->dev,
+				 "%s: Identify Descriptors failed\n", __func__);
+			 /* Don't treat error as fatal we potentially
+			  * already have a NGUID or EUI-64 */
+			return 0;
+		}
+		nvme_parse_ns_descs(ns, ns_nid);
+		kfree(ns_nid);
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
