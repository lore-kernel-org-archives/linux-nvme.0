From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Sun,  9 Dec 2018 21:50:07 -0800
Subject: [PATCH 08/12] nvmet: add error log support for fabrics-cmd
In-Reply-To: <20181210055011.3146-1-chaitanya.kulkarni@wdc.com>
References: <20181210055011.3146-1-chaitanya.kulkarni@wdc.com>
Message-ID: <20181210055011.3146-9-chaitanya.kulkarni@wdc.com>

This patch adds the support to maintain error log page for the fabrics
prop get, prop set, and admin connect commands. Here we also update the
discovery.c and add update set/get features and parse functions to
support error log page.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 drivers/nvme/target/discovery.c   | 10 +++++++
 drivers/nvme/target/fabrics-cmd.c | 50 +++++++++++++++++++++++--------
 2 files changed, 47 insertions(+), 13 deletions(-)

diff --git a/drivers/nvme/target/discovery.c b/drivers/nvme/target/discovery.c
index e1bb254671de..d2cb71a0b419 100644
--- a/drivers/nvme/target/discovery.c
+++ b/drivers/nvme/target/discovery.c
@@ -259,6 +259,8 @@ static void nvmet_execute_disc_set_features(struct nvmet_req *req)
 						  NVMET_DISC_AEN_CFG_OPTIONAL);
 		break;
 	default:
+		req->error_loc =
+			offsetof(struct nvme_common_command, cdw10);
 		stat = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
 		break;
 	}
@@ -279,6 +281,8 @@ static void nvmet_execute_disc_get_features(struct nvmet_req *req)
 		nvmet_get_feat_async_event(req);
 		break;
 	default:
+		req->error_loc =
+			offsetof(struct nvme_common_command, cdw10);
 		stat = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
 		break;
 	}
@@ -293,6 +297,8 @@ u16 nvmet_parse_discovery_cmd(struct nvmet_req *req)
 	if (unlikely(!(req->sq->ctrl->csts & NVME_CSTS_RDY))) {
 		pr_err("got cmd %d while not ready\n",
 		       cmd->common.opcode);
+		req->error_loc =
+			offsetof(struct nvme_common_command, opcode);
 		return NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
 	}
 
@@ -323,6 +329,8 @@ u16 nvmet_parse_discovery_cmd(struct nvmet_req *req)
 		default:
 			pr_err("unsupported get_log_page lid %d\n",
 			       cmd->get_log_page.lid);
+			req->error_loc =
+				offsetof(struct nvme_get_log_page_command, lid);
 		return NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
 		}
 	case nvme_admin_identify:
@@ -335,10 +343,12 @@ u16 nvmet_parse_discovery_cmd(struct nvmet_req *req)
 		default:
 			pr_err("unsupported identify cns %d\n",
 			       cmd->identify.cns);
+			req->error_loc = offsetof(struct nvme_identify, cns);
 			return NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
 		}
 	default:
 		pr_err("unhandled cmd %d\n", cmd->common.opcode);
+		req->error_loc = offsetof(struct nvme_common_command, opcode);
 		return NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
 	}
 
diff --git a/drivers/nvme/target/fabrics-cmd.c b/drivers/nvme/target/fabrics-cmd.c
index ee7d84621d65..993a84e67a3a 100644
--- a/drivers/nvme/target/fabrics-cmd.c
+++ b/drivers/nvme/target/fabrics-cmd.c
@@ -17,23 +17,26 @@
 
 static void nvmet_execute_prop_set(struct nvmet_req *req)
 {
+	u64 val = le64_to_cpu(req->cmd->prop_set.value);
 	u16 status = 0;
 
-	if (!(req->cmd->prop_set.attrib & 1)) {
-		u64 val = le64_to_cpu(req->cmd->prop_set.value);
-
-		switch (le32_to_cpu(req->cmd->prop_set.offset)) {
-		case NVME_REG_CC:
-			nvmet_update_cc(req->sq->ctrl, val);
-			break;
-		default:
-			status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
-			break;
-		}
-	} else {
+	if (req->cmd->prop_set.attrib & 1) {
+		req->error_loc =
+			offsetof(struct nvmf_property_set_command, attrib);
 		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
+		goto out;
 	}
 
+	switch (le32_to_cpu(req->cmd->prop_set.offset)) {
+	case NVME_REG_CC:
+		nvmet_update_cc(req->sq->ctrl, val);
+		break;
+	default:
+		req->error_loc =
+			offsetof(struct nvmf_property_set_command, offset);
+		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
+	}
+out:
 	nvmet_req_complete(req, status);
 }
 
@@ -69,6 +72,16 @@ static void nvmet_execute_prop_get(struct nvmet_req *req)
 		}
 	}
 
+
+	if (status && req->cmd->prop_get.attrib & 1) {
+		req->error_loc =
+			offsetof(struct nvmf_property_get_command, offset);
+	} else {
+		req->error_loc =
+			offsetof(struct nvmf_property_get_command, attrib);
+	}
+
+
 	req->rsp->result.u64 = cpu_to_le64(val);
 	nvmet_req_complete(req, status);
 }
@@ -89,6 +102,7 @@ u16 nvmet_parse_fabrics_cmd(struct nvmet_req *req)
 	default:
 		pr_err("received unknown capsule type 0x%x\n",
 			cmd->fabrics.fctype);
+		req->error_loc = offsetof(struct nvmf_common_command, fctype);
 		return NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
 	}
 
@@ -105,10 +119,12 @@ static u16 nvmet_install_queue(struct nvmet_ctrl *ctrl, struct nvmet_req *req)
 	old = cmpxchg(&req->sq->ctrl, NULL, ctrl);
 	if (old) {
 		pr_warn("queue already connected!\n");
+		req->error_loc = offsetof(struct nvmf_connect_command, opcode);
 		return NVME_SC_CONNECT_CTRL_BUSY | NVME_SC_DNR;
 	}
 	if (!sqsize) {
 		pr_warn("queue size zero!\n");
+		req->error_loc = offsetof(struct nvmf_connect_command, sqsize);
 		return NVME_SC_CONNECT_INVALID_PARAM | NVME_SC_DNR;
 	}
 
@@ -157,6 +173,7 @@ static void nvmet_execute_admin_connect(struct nvmet_req *req)
 	if (c->recfmt != 0) {
 		pr_warn("invalid connect version (%d).\n",
 			le16_to_cpu(c->recfmt));
+		req->error_loc = offsetof(struct nvmf_connect_command, recfmt);
 		status = NVME_SC_CONNECT_FORMAT | NVME_SC_DNR;
 		goto out;
 	}
@@ -171,8 +188,13 @@ static void nvmet_execute_admin_connect(struct nvmet_req *req)
 
 	status = nvmet_alloc_ctrl(d->subsysnqn, d->hostnqn, req,
 				  le32_to_cpu(c->kato), &ctrl);
-	if (status)
+	if (status) {
+		if (status == (NVME_SC_INVALID_FIELD | NVME_SC_DNR))
+			req->error_loc =
+				offsetof(struct nvme_common_command, opcode);
 		goto out;
+	}
+
 	uuid_copy(&ctrl->hostid, &d->hostid);
 
 	status = nvmet_install_queue(ctrl, req);
@@ -259,11 +281,13 @@ u16 nvmet_parse_connect_cmd(struct nvmet_req *req)
 	if (cmd->common.opcode != nvme_fabrics_command) {
 		pr_err("invalid command 0x%x on unconnected queue.\n",
 			cmd->fabrics.opcode);
+		req->error_loc = offsetof(struct nvme_common_command, opcode);
 		return NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
 	}
 	if (cmd->fabrics.fctype != nvme_fabrics_type_connect) {
 		pr_err("invalid capsule type 0x%x on unconnected queue.\n",
 			cmd->fabrics.fctype);
+		req->error_loc = offsetof(struct nvmf_common_command, fctype);
 		return NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
 	}
 
-- 
2.17.0
