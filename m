From: hch@lst.de (Christoph Hellwig)
Date: Sat, 20 May 2017 15:14:44 +0200
Subject: [PATCH 2/3] nvme: replace is_flags field in nvme_ctrl_ops with a
 flags field
In-Reply-To: <20170520131445.16078-1-hch@lst.de>
References: <20170520131445.16078-1-hch@lst.de>
Message-ID: <20170520131445.16078-2-hch@lst.de>

So that we can have more flags for transport-specific behavior.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/core.c   | 2 +-
 drivers/nvme/host/fc.c     | 2 +-
 drivers/nvme/host/nvme.h   | 3 ++-
 drivers/nvme/host/rdma.c   | 2 +-
 drivers/nvme/target/loop.c | 2 +-
 5 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d5e0906262ea..79b78bd67b07 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1605,7 +1605,7 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 	}
 	memcpy(ctrl->psd, id->psd, sizeof(ctrl->psd));
 
-	if (ctrl->ops->is_fabrics) {
+	if (ctrl->ops->flags & NVME_F_FABRICS) {
 		ctrl->icdoff = le16_to_cpu(id->icdoff);
 		ctrl->ioccsz = le32_to_cpu(id->ioccsz);
 		ctrl->iorcsz = le32_to_cpu(id->iorcsz);
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 70e689bf1cad..f126f16722e5 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2645,7 +2645,7 @@ nvme_fc_reset_nvme_ctrl(struct nvme_ctrl *nctrl)
 static const struct nvme_ctrl_ops nvme_fc_ctrl_ops = {
 	.name			= "fc",
 	.module			= THIS_MODULE,
-	.is_fabrics		= true,
+	.flags			= NVME_F_FABRICS,
 	.reg_read32		= nvmf_reg_read32,
 	.reg_read64		= nvmf_reg_read64,
 	.reg_write32		= nvmf_reg_write32,
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 29c708ca9621..7c4b0f6636c5 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -208,7 +208,8 @@ struct nvme_ns {
 struct nvme_ctrl_ops {
 	const char *name;
 	struct module *module;
-	bool is_fabrics;
+	unsigned int flags;
+#define NVME_F_FABRICS			(1 << 0)
 	int (*reg_read32)(struct nvme_ctrl *ctrl, u32 off, u32 *val);
 	int (*reg_write32)(struct nvme_ctrl *ctrl, u32 off, u32 val);
 	int (*reg_read64)(struct nvme_ctrl *ctrl, u32 off, u64 *val);
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index dd1c6deef82f..d05ee21f6400 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1782,7 +1782,7 @@ static int nvme_rdma_reset_ctrl(struct nvme_ctrl *nctrl)
 static const struct nvme_ctrl_ops nvme_rdma_ctrl_ops = {
 	.name			= "rdma",
 	.module			= THIS_MODULE,
-	.is_fabrics		= true,
+	.flags			= NVME_F_FABRICS,
 	.reg_read32		= nvmf_reg_read32,
 	.reg_read64		= nvmf_reg_read64,
 	.reg_write32		= nvmf_reg_write32,
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index feb497134aee..e503cfff0337 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -558,7 +558,7 @@ static int nvme_loop_reset_ctrl(struct nvme_ctrl *nctrl)
 static const struct nvme_ctrl_ops nvme_loop_ctrl_ops = {
 	.name			= "loop",
 	.module			= THIS_MODULE,
-	.is_fabrics		= true,
+	.flags			= NVME_F_FABRICS,
 	.reg_read32		= nvmf_reg_read32,
 	.reg_read64		= nvmf_reg_read64,
 	.reg_write32		= nvmf_reg_write32,
-- 
2.11.0
