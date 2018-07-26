From: hch@lst.de (Christoph Hellwig)
Date: Thu, 26 Jul 2018 17:35:02 +0200
Subject: [PATCH 6/9] nvmet: keep a port pointer in nvmet_ctrl
In-Reply-To: <20180726153505.4153-1-hch@lst.de>
References: <20180726153505.4153-1-hch@lst.de>
Message-ID: <20180726153505.4153-7-hch@lst.de>

This will be needed for the ANA AEN code.

Signed-off-by: Christoph Hellwig <hch at lst.de>
Reviewed-by: Hannes Reinecke <hare at suse.com>
---
 drivers/nvme/target/core.c  | 2 ++
 drivers/nvme/target/nvmet.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index ddd85715a00a..cbcd19f52121 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -876,6 +876,8 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
 
 	nvmet_init_cap(ctrl);
 
+	ctrl->port = req->port;
+
 	INIT_WORK(&ctrl->async_event_work, nvmet_async_event_work);
 	INIT_LIST_HEAD(&ctrl->async_events);
 
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 688993855402..de12dcbfd3f3 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -140,6 +140,8 @@ struct nvmet_ctrl {
 	u16			cntlid;
 	u32			kato;
 
+	struct nvmet_port	*port;
+
 	u32			aen_enabled;
 	unsigned long		aen_masked;
 	struct nvmet_req	*async_event_cmds[NVMET_ASYNC_EVENTS];
-- 
2.18.0
