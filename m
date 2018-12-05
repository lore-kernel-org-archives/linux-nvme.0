From: sashal@kernel.org (Sasha Levin)
Date: Wed,  5 Dec 2018 04:35:41 -0500
Subject: [PATCH AUTOSEL 4.19 109/123] nvme: warn when finding multi-port
 subsystems without multipathing enabled
In-Reply-To: <20181205093555.5386-1-sashal@kernel.org>
References: <20181205093555.5386-1-sashal@kernel.org>
Message-ID: <20181205093555.5386-109-sashal@kernel.org>

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit 14a1336e6fff47dd1028b484d6c802105c58e2ee ]

Without CONFIG_NVME_MULTIPATH enabled a multi-port subsystem might
show up as invididual devices and cause problems, warn about it.

Signed-off-by: Christoph Hellwig <hch at lst.de>
Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
Signed-off-by: Sasha Levin <sashal at kernel.org>
---
 drivers/nvme/host/nvme.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index bb4a2003c097..60220de2db52 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -537,6 +537,9 @@ static inline void nvme_mpath_check_last_path(struct nvme_ns *ns)
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
2.17.1
