From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue,  6 Feb 2018 11:46:34 +0200
Subject: [PATCH] nvmet: don't allow referral to match parent traddr+trsvcid
Message-ID: <20180206094634.13126-1-sagi@grimberg.me>

No way this can work and most likely cause endless recursion
for hosts that trying to discover referrals as well.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/target/configfs.c  | 13 ++++++++-----
 drivers/nvme/target/discovery.c | 14 +++++++++++++-
 drivers/nvme/target/nvmet.h     |  2 +-
 3 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 615a89c7cbc0..0edd37683f88 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -842,17 +842,20 @@ static ssize_t nvmet_referral_enable_store(struct config_item *item,
 	struct nvmet_port *port = to_nvmet_port(item);
 	bool enable;
 
-	if (strtobool(page, &enable))
+	if (strtobool(page, &enable)) {
+		pr_err("Invalid value '%s' for enable\n", page);
 		goto inval;
+	}
 
-	if (enable)
-		nvmet_referral_enable(parent, port);
-	else
+	if (enable) {
+		if (nvmet_referral_enable(parent, port))
+			goto inval;
+	} else {
 		nvmet_referral_disable(port);
+	}
 
 	return count;
 inval:
-	pr_err("Invalid value '%s' for enable\n", page);
 	return -EINVAL;
 }
 
diff --git a/drivers/nvme/target/discovery.c b/drivers/nvme/target/discovery.c
index a72425d8bce0..85feb05de7e1 100644
--- a/drivers/nvme/target/discovery.c
+++ b/drivers/nvme/target/discovery.c
@@ -20,15 +20,27 @@ struct nvmet_subsys *nvmet_disc_subsys;
 
 u64 nvmet_genctr;
 
-void nvmet_referral_enable(struct nvmet_port *parent, struct nvmet_port *port)
+int nvmet_referral_enable(struct nvmet_port *parent, struct nvmet_port *port)
 {
+	int ret = 0;
 	down_write(&nvmet_config_sem);
 	if (list_empty(&port->entry)) {
+		if (!memcmp(parent->disc_addr.traddr, port->disc_addr.traddr,
+			    NVMF_TRADDR_SIZE) &&
+		    !memcmp(parent->disc_addr.trsvcid, port->disc_addr.trsvcid,
+			    NVMF_TRSVCID_SIZE)) {
+			pr_err("referral with the same traddr (%s) and trsvcid (%s)\n",
+				parent->disc_addr.traddr, parent->disc_addr.trsvcid);
+			ret = -EINVAL;
+			goto out;
+		}
 		list_add_tail(&port->entry, &parent->referrals);
 		port->enabled = true;
 		nvmet_genctr++;
 	}
+out:
 	up_write(&nvmet_config_sem);
+	return ret;
 }
 
 void nvmet_referral_disable(struct nvmet_port *port)
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index a6e191ff34ba..51a5ab99b85d 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -315,7 +315,7 @@ void nvmet_unregister_transport(struct nvmet_fabrics_ops *ops);
 int nvmet_enable_port(struct nvmet_port *port);
 void nvmet_disable_port(struct nvmet_port *port);
 
-void nvmet_referral_enable(struct nvmet_port *parent, struct nvmet_port *port);
+int nvmet_referral_enable(struct nvmet_port *parent, struct nvmet_port *port);
 void nvmet_referral_disable(struct nvmet_port *port);
 
 u16 nvmet_copy_to_sgl(struct nvmet_req *req, off_t off, const void *buf,
-- 
2.14.1
