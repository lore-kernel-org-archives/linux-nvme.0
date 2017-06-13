From: guanjunxiong@huawei.com (Guan Junxiong)
Date: Tue, 13 Jun 2017 10:51:24 +0800
Subject: [PATCH v3] nvmf: keep track of nvmet connect error status
Message-ID: <1497322284-12852-1-git-send-email-guanjunxiong@huawei.com>

To let the host know what happends to the connection establishment,
adjust the behavior of nvmf_log_connect_error to make more connect
specifig error codes human-readble.

Signed-off-by: Guan Junxiong <guanjunxiong at huawei.com>
Reviewed-by: Sagi Grimberg <sagi at grimberg.me>

---
 drivers/nvme/host/fabrics.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 990e6fb..c5dd883 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -337,6 +337,24 @@ static void nvmf_log_connect_error(struct nvme_ctrl *ctrl,
 			}
 		}
 		break;
+
+	case NVME_SC_CONNECT_INVALID_HOST:
+		dev_err(ctrl->device,
+			"Connect for subsystem %s is not allowed, hostnqn : %s\n",
+			data->subsysnqn, data->hostnqn);
+		break;
+
+	case NVME_SC_CONNECT_CTRL_BUSY:
+		dev_err(ctrl->device,
+			"Connect command failed : controller is busy or not available\n");
+		break;
+
+	case NVME_SC_CONNECT_FORMAT:
+		dev_err(ctrl->device,
+			"Connect incompatible format : %d",
+			cmd->connect.recfmt);
+		break;
+
 	default:
 		dev_err(ctrl->device,
 			"Connect command failed, error wo/DNR bit: %d\n",
-- 
2.6.4.windows.1

Change log form v2:
1. add Signed-off-by line. (Christoph)
2. add Reviewed-by tag from Sagi. (Christoph)

Change log from v1:
1. Fix up the indentation issue by deleting one more TAB. (Christoph)
