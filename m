From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Sun,  4 Jun 2017 12:36:44 +0200
Subject: [PATCH v4 3/8] nvmet: implement namespace identify descriptor list
In-Reply-To: <20170604103649.22130-1-jthumshirn@suse.de>
References: <20170604103649.22130-1-jthumshirn@suse.de>
Message-ID: <20170604103649.22130-4-jthumshirn@suse.de>

A NVMe Identify NS command with a CNS value of '3' is expecting a list
of Namespace Identification Descriptor structures to be returned to
the host for the namespace requested in the namespace identify
command.

This Namespace Identification Descriptor structure consists of the
type of the namespace identifier, the length of the identifier and the
actual identifier.

Valid types are NGUID and UUID which we have saved in our nvme_ns
structure if they have been configured via configfs. If no value has
been assigened to one of these we return an "invalid opcode" back to
the host to maintain backward compatibiliy with older implementations
without Namespace Identify Descriptor list support.

Also as the Namespace Identify Descriptor list is the only mandatory
feature change between 1.2.1 and 1.3.0 we can bump the advertised
version as well.

Signed-off-by: Johannes Thumshirn <jthumshirn at suse.de>
---
 drivers/nvme/target/admin-cmd.c | 53 +++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/target/core.c      |  3 ++-
 drivers/nvme/target/nvmet.h     |  1 +
 3 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index ff1f97006322..833b5ef935c3 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -367,6 +367,56 @@ static void nvmet_execute_identify_nslist(struct nvmet_req *req)
 	nvmet_req_complete(req, status);
 }
 
+static void nvmet_execute_identify_desclist(struct nvmet_req *req)
+{
+	struct nvmet_ns *ns;
+	struct nvme_ns_identifier_hdr hdr;
+	u16 status = 0;
+	off_t off = 0;
+
+	ns = nvmet_find_namespace(req->sq->ctrl, req->cmd->identify.nsid);
+	if (!ns) {
+		status = NVME_SC_INVALID_NS | NVME_SC_DNR;
+		goto out;
+	}
+
+	if (memchr_inv(&ns->uuid, 0, sizeof(ns->uuid))) {
+		memset(&hdr, 0, sizeof(hdr));
+		hdr.nidt = NVME_NIDT_UUID;
+		hdr.nidl = NVME_NIDT_UUID_LEN;
+		status = nvmet_copy_to_sgl(req, off, &hdr, sizeof(hdr));
+		if (status)
+			goto out_put_ns;
+		off += sizeof(hdr);
+
+		status = nvmet_copy_to_sgl(req, off, &ns->uuid,
+					   sizeof(ns->uuid));
+		if (status)
+			goto out_put_ns;
+		off += sizeof(ns->uuid);
+	}
+	if (memchr_inv(ns->nguid, 0, sizeof(ns->nguid))) {
+		memset(&hdr, 0, sizeof(hdr));
+		hdr.nidt = NVME_NIDT_NGUID;
+		hdr.nidl = NVME_NIDT_NGUID_LEN;
+		status = nvmet_copy_to_sgl(req, off, &hdr, sizeof(hdr));
+		if (status)
+			goto out_put_ns;
+		off += sizeof(hdr);
+
+		status = nvmet_copy_to_sgl(req, off, &ns->nguid,
+					   sizeof(ns->nguid));
+		if (status)
+			goto out_put_ns;
+		off += sizeof(ns->nguid);
+	}
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
@@ -515,6 +565,9 @@ u16 nvmet_parse_admin_cmd(struct nvmet_req *req)
 		case NVME_ID_CNS_NS_ACTIVE_LIST:
 			req->execute = nvmet_execute_identify_nslist;
 			return 0;
+		case NVME_ID_CNS_NS_DESC_LIST:
+			req->execute = nvmet_execute_identify_desclist;
+			return 0;
 		}
 		break;
 	case nvme_admin_abort_cmd:
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index eb9399ac97cf..1a9c17c7dc59 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -380,6 +380,7 @@ struct nvmet_ns *nvmet_ns_alloc(struct nvmet_subsys *subsys, u32 nsid)
 
 	ns->nsid = nsid;
 	ns->subsys = subsys;
+	uuid_be_gen(&ns->uuid);
 
 	return ns;
 }
@@ -926,7 +927,7 @@ struct nvmet_subsys *nvmet_subsys_alloc(const char *subsysnqn,
 	if (!subsys)
 		return NULL;
 
-	subsys->ver = NVME_VS(1, 2, 1); /* NVMe 1.2.1 */
+	subsys->ver = NVME_VS(1, 3, 0); /* NVMe 1.3.0 */
 
 	switch (type) {
 	case NVME_NQN_NVME:
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index cfc5c7fb0ab7..4c6cb5ea1186 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -46,6 +46,7 @@ struct nvmet_ns {
 	u32			blksize_shift;
 	loff_t			size;
 	u8			nguid[16];
+	uuid_be			uuid;
 
 	bool			enabled;
 	struct nvmet_subsys	*subsys;
-- 
2.12.0
