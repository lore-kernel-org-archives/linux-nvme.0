From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Fri, 30 Mar 2018 02:57:42 -0400
Subject: [RFC PATCH 3/8] nvmet: add passthru members in target subsys
In-Reply-To: <20180330065747.20962-1-chaitanya.kulkarni@wdc.com>
References: <20180330065747.20962-1-chaitanya.kulkarni@wdc.com>
Message-ID: <20180330065747.20962-4-chaitanya.kulkarni@wdc.com>

This patch adds new structure members to implement NVMeOF
target passthru support.

On the target side, we add nvme_ctrl reference to the
nvmet_subsys. We implement nvme ctrl passthru and attach
passthru ctrl to the nvmet_subsys.

At the time when dynamically target ctrl is created, passthru
ctrl is accessed via subsystem, in this way we can configure
passthru ctrl similar to how namespaces are configured
by default.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 drivers/nvme/target/nvmet.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 417f6c0331cc..584f1bcc5e79 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -160,6 +160,9 @@ struct nvmet_subsys {
 
 	struct config_group	namespaces_group;
 	struct config_group	allowed_hosts_group;
+
+	char			*pt_ctrl_path;
+	struct nvme_ctrl	*pt_ctrl;
 };
 
 static inline struct nvmet_subsys *to_subsys(struct config_item *item)
-- 
2.14.1
