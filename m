From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 19 Nov 2018 19:00:10 -0800
Subject: [PATCH v2 08/14] nvmet: Add install_queue callout
In-Reply-To: <20181120030019.31738-1-sagi@grimberg.me>
References: <20181120030019.31738-1-sagi@grimberg.me>
Message-ID: <20181120030019.31738-10-sagi@grimberg.me>

From: Sagi Grimberg <sagi@lightbitslabs.com>

nvmet-tcp will implement it to allocate queue commands which
are only known at nvmf connect time (sq size).

Signed-off-by: Sagi Grimberg <sagi at lightbitslabs.com>
---
 drivers/nvme/target/fabrics-cmd.c | 9 +++++++++
 drivers/nvme/target/nvmet.h       | 1 +
 2 files changed, 10 insertions(+)

diff --git a/drivers/nvme/target/fabrics-cmd.c b/drivers/nvme/target/fabrics-cmd.c
index 328ae46d8344..86ebf191b035 100644
--- a/drivers/nvme/target/fabrics-cmd.c
+++ b/drivers/nvme/target/fabrics-cmd.c
@@ -121,6 +121,15 @@ static u16 nvmet_install_queue(struct nvmet_ctrl *ctrl, struct nvmet_req *req)
 		req->rsp->sq_head = cpu_to_le16(0xffff);
 	}
 
+	if (ctrl->ops->install_queue) {
+		u16 ret = ctrl->ops->install_queue(req->sq);
+		if (ret) {
+			pr_err("failed to install queue %d cntlid %d ret %x\n",
+				qid, ret, ctrl->cntlid);
+			return ret;
+		}
+	}
+
 	return 0;
 }
 
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 547108c41ce9..957eb7edb902 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -279,6 +279,7 @@ struct nvmet_fabrics_ops {
 	void (*delete_ctrl)(struct nvmet_ctrl *ctrl);
 	void (*disc_traddr)(struct nvmet_req *req,
 			struct nvmet_port *port, char *traddr);
+	u16 (*install_queue)(struct nvmet_sq *nvme_sq);
 };
 
 #define NVMET_MAX_INLINE_BIOVEC	8
-- 
2.17.1
