From: jsmart2021@gmail.com (James Smart)
Date: Fri, 20 Oct 2017 16:17:07 -0700
Subject: [PATCH v2 2/4] nvme: add helper to compare options to controller
In-Reply-To: <20171020231709.3183-1-jsmart2021@gmail.com>
References: <20171020231709.3183-1-jsmart2021@gmail.com>
Message-ID: <20171020231709.3183-3-jsmart2021@gmail.com>

Adds a helper function that compares the host and subsytem
specified in a connect options list vs a controller.

Signed-off-by: James Smart <james.smart at broadcom.com>
---
 drivers/nvme/host/fabrics.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index a7590cc59ba2..42232e731f19 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -133,6 +133,18 @@ struct nvmf_transport_ops {
 					struct nvmf_ctrl_options *opts);
 };
 
+static inline bool
+nvmf_ctlr_matches_baseopts(struct nvme_ctrl *ctrl,
+			struct nvmf_ctrl_options *opts)
+{
+	if (strcmp(opts->subsysnqn, ctrl->opts->subsysnqn) ||
+	    strcmp(opts->host->nqn, ctrl->opts->host->nqn) ||
+	    memcmp(&opts->host->id, &ctrl->opts->host->id, sizeof(uuid_t)))
+		return false;
+
+	return true;
+}
+
 int nvmf_reg_read32(struct nvme_ctrl *ctrl, u32 off, u32 *val);
 int nvmf_reg_read64(struct nvme_ctrl *ctrl, u32 off, u64 *val);
 int nvmf_reg_write32(struct nvme_ctrl *ctrl, u32 off, u32 val);
-- 
2.13.1
