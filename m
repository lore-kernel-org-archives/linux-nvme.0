From: guanjunxiong@huawei.com (Guan Junxiong)
Date: Tue, 2 May 2017 09:13:14 +0800
Subject: [PATCH 1/2] nvmf: fix the return error code of target if host is not
 allowed
Message-ID: <1493687595-11088-1-git-send-email-guanjunxiong@huawei.com>

nvmf target shall return NVME_SC_CONNECT_INVALID_HOST instead of
the gereal code INVALID_PARAM when the given host nqn is not allowed
to connect. Refer to the 2.2.1 section of the NVMe over Fabrics Spec.
---
 drivers/nvme/target/core.c | 1 +
 1 file changed, 1 insertion(+)

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
