From: hch@lst.de (Christoph Hellwig)
Date: Wed, 14 Nov 2018 16:47:16 +0100
Subject: [PATCH] nvmet: mark nvmet_genctr static
Message-ID: <20181114154716.27290-1-hch@lst.de>

Signed-off-by: Christoph Hellwig <hch at lst.de>
---

The discovery controller series from Jay means we now only use
nvmet_genctr inside discovery.c

 drivers/nvme/target/discovery.c | 2 +-
 drivers/nvme/target/nvmet.h     | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvme/target/discovery.c b/drivers/nvme/target/discovery.c
index eb45ebc3ac2c..4d8757ae8210 100644
--- a/drivers/nvme/target/discovery.c
+++ b/drivers/nvme/target/discovery.c
@@ -18,7 +18,7 @@
 
 struct nvmet_subsys *nvmet_disc_subsys;
 
-u64 nvmet_genctr;
+static u64 nvmet_genctr;
 
 static void __nvmet_disc_changed(struct nvmet_port *port,
 				 struct nvmet_ctrl *ctrl)
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 31474940e373..03988fe9d915 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -470,7 +470,6 @@ int __init nvmet_init_discovery(void);
 void nvmet_exit_discovery(void);
 
 extern struct nvmet_subsys *nvmet_disc_subsys;
-extern u64 nvmet_genctr;
 extern struct rw_semaphore nvmet_config_sem;
 
 extern u32 nvmet_ana_group_enabled[NVMET_MAX_ANAGRPS + 1];
-- 
2.19.1
