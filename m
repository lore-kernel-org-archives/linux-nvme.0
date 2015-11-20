From: mlin@kernel.org (Ming Lin)
Date: Thu, 19 Nov 2015 16:21:05 -0800
Subject: [RFC PATCH 6/9] nvmet: add a "parse_extra_admin_cmd" hook
In-Reply-To: <1447978868-17138-1-git-send-email-mlin@kernel.org>
References: <1447978868-17138-1-git-send-email-mlin@kernel.org>
Message-ID: <1447978868-17138-7-git-send-email-mlin@kernel.org>

From: Ming Lin <ming.l@ssi.samsung.com>

This is used to execute controller specific cmd parse code

Signed-off-by: Ming Lin <ming.l at ssi.samsung.com>
---
 drivers/nvme/target/admin-cmd.c | 7 +++++++
 drivers/nvme/target/nvmet.h     | 3 +++
 2 files changed, 10 insertions(+)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index d9db0d4..f009c77 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -346,6 +346,13 @@ int nvmet_parse_admin_cmd(struct nvmet_req *req)
 		req->data = 0;
 		return 0;
 #endif
+	default:
+		if (req->sq->ctrl->parse_extra_admin_cmd) {
+			int ret = req->sq->ctrl->parse_extra_admin_cmd(req);
+
+			if (!ret)
+				return 0;
+		}
 	}
 
 	pr_err("nvmet: unhandled cmd %d\n", cmd->common.opcode);
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index eac008b..ef79813 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -44,6 +44,8 @@ struct nvmet_sq {
 	u16			size;
 };
 
+struct nvmet_req;
+
 struct nvmet_ctrl {
 	struct nvmet_subsys	*subsys;
 	struct nvmet_cq		**cqs;
@@ -62,6 +64,7 @@ struct nvmet_ctrl {
 
 	void			*opaque;
 	void			(*start)(void *);
+	int			(*parse_extra_admin_cmd)(struct nvmet_req *);
 };
 
 struct nvmet_subsys {
-- 
1.9.1
