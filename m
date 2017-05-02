From: guanjunxiong@huawei.com (Guan Junxiong)
Date: Tue, 2 May 2017 09:13:15 +0800
Subject: [PATCH 2/2] nvmf: keep track of nvmet connect error status
In-Reply-To: <1493687595-11088-1-git-send-email-guanjunxiong@huawei.com>
References: <1493687595-11088-1-git-send-email-guanjunxiong@huawei.com>
Message-ID: <1493687595-11088-2-git-send-email-guanjunxiong@huawei.com>

To let the host know what happends to the connection establishment,
adjust the behavior of nvmf_log_connect_error to make more connect
specifig error codes human-readble.
---
 drivers/nvme/host/fabrics.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 916d1360..1f315987 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -337,6 +337,24 @@ static void nvmf_log_connect_error(struct nvme_ctrl *ctrl,
 			}
 		}
 		break;
+
+	case NVME_SC_CONNECT_INVALID_HOST:
+		dev_err(ctrl->device,
+				"Connect for subsystem %s is not allowed, hostnqn : %s\n",
+				data->subsysnqn, data->hostnqn);
+		break;
+
+	case NVME_SC_CONNECT_CTRL_BUSY:
+		dev_err(ctrl->device,
+				"Connect command failed : controller is busy or not available\n");
+		break;
+
+	case NVME_SC_CONNECT_FORMAT:
+		dev_err(ctrl->device,
+				"Connect incompatible format : %d",
+				cmd->connect.recfmt);
+		break;
+
 	default:
 		dev_err(ctrl->device,
 			"Connect command failed, error wo/DNR bit: %d\n",
-- 
2.11.1
