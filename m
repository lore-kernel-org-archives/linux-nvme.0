From: hch@lst.de (Christoph Hellwig)
Date: Mon, 11 Jun 2018 16:11:36 +0200
Subject: [PATCH 07/10] nvmet: keep a port pointer in nvmet_ctrl
In-Reply-To: <20180611141139.30462-1-hch@lst.de>
References: <20180611141139.30462-1-hch@lst.de>
Message-ID: <20180611141139.30462-8-hch@lst.de>

This will be needed for the ANA AEN code.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/target/core.c  | 2 ++
 drivers/nvme/target/nvmet.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index a03da764ecae..b5aafe55b752 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -862,6 +862,8 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
 
 	nvmet_init_cap(ctrl);
 
+	ctrl->port = req->port;
+
 	INIT_WORK(&ctrl->async_event_work, nvmet_async_event_work);
 	INIT_LIST_HEAD(&ctrl->async_events);
 
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 480dfe10fad9..f5748c01f9e8 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -138,6 +138,8 @@ struct nvmet_ctrl {
 	u16			cntlid;
 	u32			kato;
 
+	struct nvmet_port	*port;
+
 	u32			aen_enabled;
 	unsigned long		aen_masked;
 	struct nvmet_req	*async_event_cmds[NVMET_ASYNC_EVENTS];
-- 
2.17.1
