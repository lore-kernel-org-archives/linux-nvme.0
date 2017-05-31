From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Wed, 31 May 2017 15:32:13 +0200
Subject: [PATCH v1 3/7] nvmet: implement namespace identify descriptor list
In-Reply-To: <cover.1496237370.git.jthumshirn@suse.de>
References: <cover.1496237370.git.jthumshirn@suse.de>
Message-ID: <d6782789a4c53be2244186588599cc017e3955ea.1496237370.git.jthumshirn@suse.de>

A NVMe Identify NS command with a CNS value of '3' is expecting a list
of Namespace Identification Descriptor structures to be returned to
the host for the namespace requested in the namespace identify
command.

This Namespace Identification Descriptor structure consists of the
type of the namespace identifier, the length of the identifier and the
actual identifier.

Valid types are EUI-64, NGUID and UUID which we have saved in our
nvme_ns structure if they have been configured via configfs. If no
value has been assigened to one of these we return an "invalid opcode"
back to the host to maintain backward compatibiliy with older
implementations without Namespace Identify Descriptor list support.

Signed-off-by: Johannes Thumshirn <jthumshirn at suse.de>
---
 drivers/nvme/target/admin-cmd.c | 63 +++++++++++++++++++++++++++++++++++++++++
 include/linux/nvme.h            | 18 ++++++++++++
 2 files changed, 81 insertions(+)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index ff1f97006322..f53cab51b090 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -367,6 +367,66 @@ static void nvmet_execute_identify_nslist(struct nvmet_req *req)
 	nvmet_req_complete(req, status);
 }
 
+static void nvmet_execute_identify_desclist(struct nvmet_req *req)
+{
+	static const int buf_size = SZ_4K;
+	struct nvmet_ns *ns;
+	struct nvme_ns_nid *ns_nid;
+	u8 *nid_list;
+	u16 status = 0;
+	int pos = 0;
+	const u8 *p;
+
+	ns = nvmet_find_namespace(req->sq->ctrl, req->cmd->identify.nsid);
+	if (!ns) {
+		status = NVME_SC_INVALID_NS | NVME_SC_DNR;
+		goto out;
+	}
+
+	nid_list = kzalloc(buf_size, GFP_KERNEL);
+	if (!nid_list) {
+		status = NVME_SC_INTERNAL;
+		goto out_put_ns;
+	}
+
+	p = nid_list;
+
+	if (memchr_inv(&ns->uuid, 0, sizeof(ns->uuid))) {
+		ns_nid = (struct nvme_ns_nid *)p;
+		ns_nid->nidt = NVME_NIDT_UUID;
+		ns_nid->nidl = NVME_NIDT_UUID_LEN;
+		memcpy(&ns_nid->nid, &ns->uuid, sizeof(ns->uuid));
+		pos += sizeof(struct nvme_ns_nid) + sizeof(ns->uuid);
+		if (pos > buf_size) {
+			status = NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
+			goto out_free_nid_list;
+		}
+		p += pos;
+	}
+	if (memchr_inv(ns->nguid, 0, sizeof(ns->nguid))) {
+		ns_nid = (struct nvme_ns_nid *)p;
+		ns_nid->nidt = NVME_NIDT_NGUID;
+		ns_nid->nidl = NVME_NIDT_NGUID_LEN;
+		memcpy(&ns_nid->nid, &ns->nguid, sizeof(ns->nguid));
+		pos += sizeof(struct nvme_ns_nid) + sizeof(ns->nguid);
+		if (pos > buf_size) {
+			status = NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
+			goto out_free_nid_list;
+		}
+		p += pos;
+	}
+
+	status = nvmet_copy_to_sgl(req, 0, nid_list, buf_size);
+
+out_free_nid_list:
+	kfree(nid_list);
+
+out_put_ns:
+	nvmet_put_namespace(ns);
+out:
+	nvmet_req_complete(req, status);
+}
+
 /*
  * A "mimimum viable" abort implementation: the command is mandatory in the
  * spec, but we are not required to do any useful work.  We couldn't really
@@ -515,6 +575,9 @@ u16 nvmet_parse_admin_cmd(struct nvmet_req *req)
 		case NVME_ID_CNS_NS_ACTIVE_LIST:
 			req->execute = nvmet_execute_identify_nslist;
 			return 0;
+		case NVME_ID_CNS_NS_DESC_LIST:
+			req->execute = nvmet_execute_identify_desclist;
+			return 0;
 		}
 		break;
 	case nvme_admin_abort_cmd:
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index b625bacf37ef..0a62e843ecb0 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -288,6 +288,7 @@ enum {
 	NVME_ID_CNS_NS			= 0x00,
 	NVME_ID_CNS_CTRL		= 0x01,
 	NVME_ID_CNS_NS_ACTIVE_LIST	= 0x02,
+	NVME_ID_CNS_NS_DESC_LIST	= 0x03,
 	NVME_ID_CNS_NS_PRESENT_LIST	= 0x10,
 	NVME_ID_CNS_NS_PRESENT		= 0x11,
 	NVME_ID_CNS_CTRL_NS_LIST	= 0x12,
@@ -314,6 +315,23 @@ enum {
 	NVME_NS_DPS_PI_TYPE3	= 3,
 };
 
+struct nvme_ns_nid {
+	__u8 nidt;
+	__u8 nidl;
+	__le16 reserved;
+	__u8 nid[0];
+};
+
+#define NVME_NIDT_EUI64_LEN	8
+#define NVME_NIDT_NGUID_LEN	16
+#define NVME_NIDT_UUID_LEN	16
+
+enum {
+	NVME_NIDT_EUI64		= 0x01,
+	NVME_NIDT_NGUID		= 0x02,
+	NVME_NIDT_UUID		= 0x03,
+};
+
 struct nvme_smart_log {
 	__u8			critical_warning;
 	__u8			temperature[2];
-- 
2.12.0
