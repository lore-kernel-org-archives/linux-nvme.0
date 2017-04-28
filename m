From: guanjunxiong@huawei.com (Guan Junxiong)
Date: Fri, 28 Apr 2017 13:15:30 +0800
Subject: [PATCH] nvme-fabrics: keep track of nvmet connect error status
Message-ID: <1493356530-8224-1-git-send-email-guanjunxiong@huawei.com>

nvmf target shall return NVME_SC_CONNECT_INVALID_HOST instead of
the general code INVALID_PARAM. Also, to let the host know what
happends to the connection establishment, adjust the behavior of
nvmf_log_connect_error to make more connect specific error codes
human-readble.
---
 drivers/nvme/host/fabrics.c | 18 ++++++++++++++++++
 drivers/nvme/target/core.c  |  1 +
 2 files changed, 19 insertions(+)

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
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index fc5ba2f9..e6c5a47f 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -713,6 +713,7 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
 			hostnqn, subsysnqn);
 		req->rsp->result.u32 = IPO_IATTR_CONNECT_DATA(hostnqn);
 		up_read(&nvmet_config_sem);
+		status = NVME_SC_CONNECT_INVALID_HOST | NVME_SC_DNR;
 		goto out_put_subsystem;
 	}
 	up_read(&nvmet_config_sem);
-- 
2.11.1
