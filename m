From: sagi@lightbitslabs.com (Sagi Grimberg)
Date: Thu, 15 Nov 2018 09:16:17 -0800
Subject: [PATCH 05/11] nvmet: Add install_queue callout
In-Reply-To: <20181115171626.9306-1-sagi@lightbitslabs.com>
References: <20181115171626.9306-1-sagi@lightbitslabs.com>
Message-ID: <20181115171626.9306-6-sagi@lightbitslabs.com>

nvmet-tcp will implement it to allocate queue commands which
are only known at nvmf connect time (sq size).

Signed-off-by: Sagi Grimberg <sagi at lightbitslabs.com>
---
 drivers/nvme/target/fabrics-cmd.c | 9 +++++++++
 drivers/nvme/target/nvmet.h       | 1 +
 2 files changed, 10 insertions(+)

diff --git a/drivers/nvme/target/fabrics-cmd.c b/drivers/nvme/target/fabrics-cmd.c
index 1f05d8507e35..a84668e8939c 100644
--- a/drivers/nvme/target/fabrics-cmd.c
+++ b/drivers/nvme/target/fabrics-cmd.c
@@ -117,6 +117,15 @@ static u16 nvmet_install_queue(struct nvmet_ctrl *ctrl, struct nvmet_req *req)
 	nvmet_sq_setup(ctrl, req->sq, qid, sqsize + 1,
 			!!(c->cattr & NVME_CONNECT_DISABLE_SQFLOW));
 
+	if (ctrl->ops->install_queue) {
+		int ret = ctrl->ops->install_queue(req->sq);
+		if (ret) {
+			pr_err("failed to install queue %d cntlid %d ret %d\n",
+				qid, ret, ctrl->cntlid);
+			return NVME_SC_CONNECT_INVALID_PARAM | NVME_SC_DNR;
+		}
+	}
+
 	return 0;
 }
 
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index abc603fa725d..1362afe6e0b3 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -281,6 +281,7 @@ struct nvmet_fabrics_ops {
 	void (*delete_ctrl)(struct nvmet_ctrl *ctrl);
 	void (*disc_traddr)(struct nvmet_req *req,
 			struct nvmet_port *port, char *traddr);
+	int (*install_queue)(struct nvmet_sq *nvme_sq);
 };
 
 #define NVMET_MAX_INLINE_BIOVEC	8
-- 
2.17.1
