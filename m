From: lijie34@huawei.com (lijie)
Date: Tue, 23 Oct 2018 11:24:55 +0800
Subject: [PATCH] nvmet:added support for identifying controller list
Message-ID: <1540265095-11360-1-git-send-email-lijie34@huawei.com>

This patch implements the support for identifying controller list and
namespace attached controller list on the target.
---
 drivers/nvme/target/admin-cmd.c | 83 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 82 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 498ce25..565b009 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -540,6 +540,81 @@ static void nvmet_execute_identify_desclist(struct nvmet_req *req)
 	nvmet_req_complete(req, status);
 }
 
+static void nvmet_execute_identify_nsctrllist(struct nvmet_req *req)
+{
+	static const int buf_size = 4096;
+	struct nvmet_subsys *subsys = req->sq->ctrl->subsys;
+	struct nvmet_ctrl *ctrl;
+	struct nvmet_ns *ns;
+	__le16 min_cntlid = le16_to_cpu(req->cmd->identify.ctrlid);
+	__le16 *list;
+	__le16 i = 0;
+	u16 status = 0;
+
+	list = kzalloc(buf_size, GFP_KERNEL);
+	if (!list) {
+		status = NVME_SC_INTERNAL;
+		goto out;
+	}
+
+	mutex_lock(&subsys->lock);
+	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
+		if (ctrl->cntlid < min_cntlid)
+			continue;
+
+		ns = nvmet_find_namespace(ctrl, req->cmd->identify.nsid);
+		if (unlikely(!ns))
+			continue;
+		nvmet_put_namespace(ns);
+		list[++i] = cpu_to_le16(ctrl->cntlid);
+		if (i == buf_size / sizeof(__le16))
+			break;
+	}
+	list[0] = cpu_to_le16(i);
+	mutex_unlock(&subsys->lock);
+
+	status = nvmet_copy_to_sgl(req, 0, list, buf_size);
+
+	kfree(list);
+out:
+	nvmet_req_complete(req, status);
+}
+
+static void nvmet_execute_identify_ctrllist(struct nvmet_req *req)
+{
+	static const int buf_size = 4096;
+	struct nvmet_subsys *subsys = req->sq->ctrl->subsys;
+	struct nvmet_ctrl *ctrl;
+	__le16 min_cntid = le16_to_cpu(req->cmd->identify.ctrlid);
+	__le16 *list;
+
+	u16 status = 0;
+	__le16 i = 0;
+
+	list = kzalloc(buf_size, GFP_KERNEL);
+	if (!list) {
+		status = NVME_SC_INTERNAL;
+		goto out;
+	}
+
+	mutex_lock(&subsys->lock);
+	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
+		if (ctrl->cntlid < min_cntid)
+			continue;
+		list[++i] = cpu_to_le16(ctrl->cntlid);
+		if (i == buf_size / sizeof(__le16))
+			break;
+	}
+	list[0] = cpu_to_le16(i);
+	mutex_unlock(&subsys->lock);
+
+	status = nvmet_copy_to_sgl(req, 0, list, buf_size);
+
+	kfree(list);
+out:
+	nvmet_req_complete(req, status);
+}
+
 /*
  * A "minimum viable" abort implementation: the command is mandatory in the
  * spec, but we are not required to do any useful work.  We couldn't really
@@ -810,7 +885,13 @@ u16 nvmet_parse_admin_cmd(struct nvmet_req *req)
 		case NVME_ID_CNS_NS_DESC_LIST:
 			req->execute = nvmet_execute_identify_desclist;
 			return 0;
-		}
+		case NVME_ID_CNS_CTRL_NS_LIST:
+			req->execute = nvmet_execute_identify_nsctrllist;
+			return 0;
+		case NVME_ID_CNS_CTRL_LIST:
+			req->execute = nvmet_execute_identify_ctrllist;
+			return 0;
+        }
 		break;
 	case nvme_admin_abort_cmd:
 		req->execute = nvmet_execute_abort;
-- 
2.6.4.windows.1
