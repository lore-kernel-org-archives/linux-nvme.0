From: hare@suse.de (Hannes Reinecke)
Date: Mon,  2 Oct 2017 15:55:54 +0200
Subject: [PATCH 1/6] nvme: display 'CMIC' controller attribute
In-Reply-To: <1506952559-1588-1-git-send-email-hare@suse.de>
References: <1506952559-1588-1-git-send-email-hare@suse.de>
Message-ID: <1506952559-1588-2-git-send-email-hare@suse.de>

To figure out if a controller is multipath capable (ie if the
controller supports namespace sharing) we need to expose the CMIC
value to sysfs.

Signed-off-by: Hannes Reinecke <hare at suse.com>
---
 drivers/nvme/host/core.c | 12 ++++++++++++
 drivers/nvme/host/nvme.h |  1 +
 2 files changed, 13 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index c296f27..b1e61c9 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2061,6 +2061,7 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 	atomic_set(&ctrl->abort_limit, id->acl + 1);
 	ctrl->vwc = id->vwc;
 	ctrl->cntlid = le16_to_cpup(&id->cntlid);
+	ctrl->cmic = id->cmic;
 	if (id->mdts)
 		max_hw_sectors = 1 << (id->mdts + page_shift - 9);
 	else
@@ -2486,6 +2487,16 @@ static ssize_t nvme_sysfs_show_address(struct device *dev,
 }
 static DEVICE_ATTR(address, S_IRUGO, nvme_sysfs_show_address, NULL);
 
+static ssize_t nvme_sysfs_show_cmic(struct device *dev,
+				    struct device_attribute *attr,
+				    char *buf)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+
+	return snprintf(buf, PAGE_SIZE, "%d\n", ctrl->cmic);
+}
+static DEVICE_ATTR(cmic, S_IRUGO, nvme_sysfs_show_cmic, NULL);
+
 static struct attribute *nvme_dev_attrs[] = {
 	&dev_attr_reset_controller.attr,
 	&dev_attr_rescan_controller.attr,
@@ -2498,6 +2509,7 @@ static ssize_t nvme_sysfs_show_address(struct device *dev,
 	&dev_attr_subsysnqn.attr,
 	&dev_attr_address.attr,
 	&dev_attr_state.attr,
+	&dev_attr_cmic.attr,
 	NULL
 };
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index febc21d..10fffbc 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -170,6 +170,7 @@ struct nvme_ctrl {
 	u16 kas;
 	u8 npss;
 	u8 apsta;
+	u8 cmic;
 	unsigned int shutdown_timeout;
 	unsigned int kato;
 	bool subsystem;
-- 
1.8.5.6
