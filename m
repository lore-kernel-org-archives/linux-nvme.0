From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 27 Sep 2018 18:15:36 -0700
Subject: [PATCH 3/4] nvme-core: cache controller attributes
In-Reply-To: <20180928011537.30069-1-sagi@grimberg.me>
References: <20180928011537.30069-1-sagi@grimberg.me>
Message-ID: <20180928011537.30069-4-sagi@grimberg.me>

We get the controller attributes in identify, cache
them as we'll need them for traffic based keep alive
support.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/core.c | 1 +
 drivers/nvme/host/nvme.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index ef6748f4ff47..6bb6214c0634 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2409,6 +2409,7 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 	ctrl->sgls = le32_to_cpu(id->sgls);
 	ctrl->kas = le16_to_cpu(id->kas);
 	ctrl->max_namespaces = le32_to_cpu(id->mnan);
+	ctrl->ctratt = le32_to_cpu(id->ctratt);
 
 	if (id->rtd3e) {
 		/* us -> s */
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index bb4a2003c097..ee1c4fc0249c 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -193,6 +193,7 @@ struct nvme_ctrl {
 	u8 apsta;
 	u32 oaes;
 	u32 aen_result;
+	u32 ctratt;
 	unsigned int shutdown_timeout;
 	unsigned int kato;
 	bool subsystem;
-- 
2.17.1
