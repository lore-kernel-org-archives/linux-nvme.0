From: israelr@mellanox.com (Israel Rukshin)
Date: Tue, 10 Oct 2017 14:40:33 +0300
Subject: [PATCH 4/4] nvmet: Add feature close connection from target side
In-Reply-To: <1507635633-16665-1-git-send-email-israelr@mellanox.com>
References: <1507635633-16665-1-git-send-email-israelr@mellanox.com>
Message-ID: <1507635633-16665-5-git-send-email-israelr@mellanox.com>

This allows the user to close any connection from target side
by writing to the file "force_close" at the controller folder.
Full path:
/config/nvmet/subsystems/<SUBSYSTEM_NAME>/controllers/<CTRL_ID>/force_close

Signed-off-by: Israel Rukshin <israelr at mellanox.com>
Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
---
 drivers/nvme/target/configfs.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index a0942c3..cb45f6c 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -496,10 +496,23 @@ static ssize_t nvmet_ctrl_trsvcid_show(struct config_item *item, char *page)
 
 CONFIGFS_ATTR_RO(nvmet_ctrl_, trsvcid);
 
+static ssize_t nvmet_ctrl_force_close_store(struct config_item *item,
+		const char *page, size_t count)
+{
+	struct nvmet_ctrl *ctrl = to_nvmet_ctrl(item);
+
+	ctrl->ops->delete_ctrl(ctrl);
+
+	return count;
+}
+
+CONFIGFS_ATTR_WO(nvmet_ctrl_, force_close);
+
 static struct configfs_attribute *nvmet_ctrl_attrs[] = {
 	&nvmet_ctrl_attr_hostnqn,
 	&nvmet_ctrl_attr_traddr,
 	&nvmet_ctrl_attr_trsvcid,
+	&nvmet_ctrl_attr_force_close,
 	NULL,
 };
 
-- 
1.8.4.3
