From: jay.e.sternberg@intel.com (Jay Sternberg)
Date: Tue, 16 Oct 2018 10:11:19 -0700
Subject: [PATCH v2 07/11] nvmet: Add parent to nvmet_referral_disable
In-Reply-To: <1539709883-12424-1-git-send-email-jay.e.sternberg@intel.com>
References: <1539709883-12424-1-git-send-email-jay.e.sternberg@intel.com>
Message-ID: <1539709883-12424-8-git-send-email-jay.e.sternberg@intel.com>

To be used when Discovery Change notifications occur

Signed-off-by: Jay Sternberg <jay.e.sternberg at intel.com>
Reviewed-by: Phil Cayton <phil.cayton at intel.com>
---
v2 - unchanged

 drivers/nvme/target/configfs.c  | 5 +++--
 drivers/nvme/target/discovery.c | 2 +-
 drivers/nvme/target/nvmet.h     | 2 +-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index b37a8e3..df841e0 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -889,7 +889,7 @@ static ssize_t nvmet_referral_enable_store(struct config_item *item,
 	if (enable)
 		nvmet_referral_enable(parent, port);
 	else
-		nvmet_referral_disable(port);
+		nvmet_referral_disable(parent, port);
 
 	return count;
 inval:
@@ -915,9 +915,10 @@ static ssize_t nvmet_referral_enable_store(struct config_item *item,
 
 static void nvmet_referral_release(struct config_item *item)
 {
+	struct nvmet_port *parent = to_nvmet_port(item->ci_parent->ci_parent);
 	struct nvmet_port *port = to_nvmet_port(item);
 
-	nvmet_referral_disable(port);
+	nvmet_referral_disable(parent, port);
 	kfree(port);
 }
 
diff --git a/drivers/nvme/target/discovery.c b/drivers/nvme/target/discovery.c
index df609ef..9ae8208 100644
--- a/drivers/nvme/target/discovery.c
+++ b/drivers/nvme/target/discovery.c
@@ -31,7 +31,7 @@ void nvmet_referral_enable(struct nvmet_port *parent, struct nvmet_port *port)
 	up_write(&nvmet_config_sem);
 }
 
-void nvmet_referral_disable(struct nvmet_port *port)
+void nvmet_referral_disable(struct nvmet_port *parent, struct nvmet_port *port)
 {
 	down_write(&nvmet_config_sem);
 	if (!list_empty(&port->entry)) {
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index dd7e5223..dbde3ad 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -410,7 +410,7 @@ void nvmet_send_ana_event(struct nvmet_subsys *subsys,
 void nvmet_disable_port(struct nvmet_port *port);
 
 void nvmet_referral_enable(struct nvmet_port *parent, struct nvmet_port *port);
-void nvmet_referral_disable(struct nvmet_port *port);
+void nvmet_referral_disable(struct nvmet_port *parent, struct nvmet_port *port);
 
 u16 nvmet_copy_to_sgl(struct nvmet_req *req, off_t off, const void *buf,
 		size_t len);
-- 
1.8.3.1
