From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 12 Jan 2017 12:31:15 +0200
Subject: [PATCH 1/5] nvmet: delete controllers deletion upon subsystem release
In-Reply-To: <1484217079-9259-1-git-send-email-sagi@grimberg.me>
References: <1484217079-9259-1-git-send-email-sagi@grimberg.me>
Message-ID: <1484217079-9259-2-git-send-email-sagi@grimberg.me>

No reason for them to be kept around if we are
deleting the subsystem, so instead of passively
wait for the host to disconnect, actively delete
the controllers.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>
Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
Reviewed-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/target/configfs.c |  1 +
 drivers/nvme/target/core.c     | 10 ++++++++++
 drivers/nvme/target/nvmet.h    |  1 +
 3 files changed, 12 insertions(+)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 6f5074153dcd..be8c800078e2 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -631,6 +631,7 @@ static void nvmet_subsys_release(struct config_item *item)
 {
 	struct nvmet_subsys *subsys = to_subsys(item);
 
+	nvmet_subsys_del_ctrls(subsys);
 	nvmet_subsys_put(subsys);
 }
 
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index b1d66ed655c9..4a367549eb93 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -935,6 +935,16 @@ static void nvmet_subsys_free(struct kref *ref)
 	kfree(subsys);
 }
 
+void nvmet_subsys_del_ctrls(struct nvmet_subsys *subsys)
+{
+	struct nvmet_ctrl *ctrl;
+
+	mutex_lock(&subsys->lock);
+	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry)
+		ctrl->ops->delete_ctrl(ctrl);
+	mutex_unlock(&subsys->lock);
+}
+
 void nvmet_subsys_put(struct nvmet_subsys *subsys)
 {
 	kref_put(&subsys->ref, nvmet_subsys_free);
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 23d5eb1c944f..cc7ad06b43a7 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -282,6 +282,7 @@ void nvmet_ctrl_put(struct nvmet_ctrl *ctrl);
 struct nvmet_subsys *nvmet_subsys_alloc(const char *subsysnqn,
 		enum nvme_subsys_type type);
 void nvmet_subsys_put(struct nvmet_subsys *subsys);
+void nvmet_subsys_del_ctrls(struct nvmet_subsys *subsys);
 
 struct nvmet_ns *nvmet_find_namespace(struct nvmet_ctrl *ctrl, __le32 nsid);
 void nvmet_put_namespace(struct nvmet_ns *ns);
-- 
2.7.4
