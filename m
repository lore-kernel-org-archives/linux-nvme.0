From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 12 Jan 2017 12:31:17 +0200
Subject: [PATCH 3/5] nvme: Make controller state visible via sysfs
In-Reply-To: <1484217079-9259-1-git-send-email-sagi@grimberg.me>
References: <1484217079-9259-1-git-send-email-sagi@grimberg.me>
Message-ID: <1484217079-9259-4-git-send-email-sagi@grimberg.me>

Easier for debugging and testing state machine
transitions.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>
Reviewed-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/core.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 8a3c3e32a704..439aebf4473c 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1521,6 +1521,29 @@ static ssize_t nvme_sysfs_show_transport(struct device *dev,
 }
 static DEVICE_ATTR(transport, S_IRUGO, nvme_sysfs_show_transport, NULL);
 
+static ssize_t nvme_sysfs_show_state(struct device *dev,
+				     struct device_attribute *attr,
+				     char *buf)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+	static const char *const state_name[] = {
+		[NVME_CTRL_NEW]		= "new",
+		[NVME_CTRL_LIVE]	= "live",
+		[NVME_CTRL_RESETTING]	= "resetting",
+		[NVME_CTRL_RECONNECTING]= "reconnecting",
+		[NVME_CTRL_DELETING]	= "deleting",
+		[NVME_CTRL_DEAD]	= "dead",
+	};
+
+	if ((unsigned)ctrl->state < ARRAY_SIZE(state_name) &&
+	    state_name[ctrl->state])
+		return sprintf(buf, "%s\n", state_name[ctrl->state]);
+
+	return sprintf(buf, "unknown state\n");
+}
+
+static DEVICE_ATTR(state, S_IRUGO, nvme_sysfs_show_state, NULL);
+
 static ssize_t nvme_sysfs_show_subsysnqn(struct device *dev,
 					 struct device_attribute *attr,
 					 char *buf)
@@ -1553,6 +1576,7 @@ static struct attribute *nvme_dev_attrs[] = {
 	&dev_attr_transport.attr,
 	&dev_attr_subsysnqn.attr,
 	&dev_attr_address.attr,
+	&dev_attr_state.attr,
 	NULL
 };
 
-- 
2.7.4
