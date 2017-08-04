From: guanjunxiong@huawei.com (Guan Junxiong)
Date: Fri, 4 Aug 2017 17:27:47 +0800
Subject: [PATCH RESENT] nvmet: fix the return error code of target if host is
 not allowed
Message-ID: <1501838867-14780-1-git-send-email-guanjunxiong@huawei.com>

nvmf target shall return NVME_SC_CONNECT_INVALID_HOST instead of
the gereal code INVALID_PARAM when the given host nqn is not allowed
to connect. Refer to the 2.2.1 section of the NVMe over Fabrics Spec.

Signed-off-by: Guan Junxiong <guanjunxiong at huawei.com>
Reviewed-by: Christoph Hellwig <hch at lst.de>
Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
---

Changes from V1:
* subjuect : nvmf -> nvmet
* add reviewed-tags 

Hi, Christoph and Sagi, 
This patch has been missed up for about two month. Although the linux
nvme target is somehow broken, but it is useful as a loop /rdma loop
target for simulation. 

Best Regards

Guan Junxiong 



 drivers/nvme/target/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index f4b02bb4a1a8..ea7eb00dcb87 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -749,6 +749,7 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
 			hostnqn, subsysnqn);
 		req->rsp->result.u32 = IPO_IATTR_CONNECT_DATA(hostnqn);
 		up_read(&nvmet_config_sem);
+		status = NVME_SC_CONNECT_INVALID_HOST | NVME_SC_DNR;
 		goto out_put_subsystem;
 	}
 	up_read(&nvmet_config_sem);
-- 
2.11.1
