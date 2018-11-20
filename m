From: hch@lst.de (Christoph Hellwig)
Date: Tue, 20 Nov 2018 17:27:33 +0100
Subject: [PATCH 2/3] nvme: warn when finding multi-port subsystems without
 multipathing enabled
In-Reply-To: <20181120162734.2013-1-hch@lst.de>
References: <20181120162734.2013-1-hch@lst.de>
Message-ID: <20181120162734.2013-3-hch@lst.de>

Without CONFIG_NVME_MULTIPATH enabled a multi-port subsystem might
show up as invididual devices and cause problems, warn about it.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/nvme.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 27663ce3044e..f2594d468f29 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -534,6 +534,9 @@ static inline void nvme_mpath_check_last_path(struct nvme_ns *ns)
 static inline int nvme_mpath_init(struct nvme_ctrl *ctrl,
 		struct nvme_id_ctrl *id)
 {
+	if (ctrl->subsys->cmic & (1 << 3))
+		dev_warn(ctrl->device,
+"Please enable CONFIG_NVME_MULTIPATH for full support of multi-port devices.\n");
 	return 0;
 }
 static inline void nvme_mpath_uninit(struct nvme_ctrl *ctrl)
-- 
2.19.1
