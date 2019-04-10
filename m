From: yuyufen@huawei.com (Yufen Yu)
Date: Wed, 10 Apr 2019 16:00:35 +0800
Subject: [PATCH RFC 6/6] nvme-fabrics: use flag NVME_ADMIN_QID
In-Reply-To: <20190410080035.82529-1-yuyufen@huawei.com>
References: <20190410080035.82529-1-yuyufen@huawei.com>
Message-ID: <20190410080035.82529-7-yuyufen@huawei.com>

Signed-off-by: Yufen Yu <yuyufen at huawei.com>
---
 drivers/nvme/host/fabrics.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index d4cb826f58ff..bd15fc616ca8 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -374,7 +374,7 @@ int nvmf_connect_admin_queue(struct nvme_ctrl *ctrl)
 	memset(&cmd, 0, sizeof(cmd));
 	cmd.connect.opcode = nvme_fabrics_command;
 	cmd.connect.fctype = nvme_fabrics_type_connect;
-	cmd.connect.qid = 0;
+	cmd.connect.qid = NVME_ADMIN_QID;
 	cmd.connect.sqsize = cpu_to_le16(NVME_AQ_DEPTH - 1);
 
 	/*
-- 
2.16.2.dirty
