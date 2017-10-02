From: hare@suse.de (Hannes Reinecke)
Date: Mon,  2 Oct 2017 15:55:57 +0200
Subject: [PATCH 4/6] nvme: display 'NMIC' namespace attribute
In-Reply-To: <1506952559-1588-1-git-send-email-hare@suse.de>
References: <1506952559-1588-1-git-send-email-hare@suse.de>
Message-ID: <1506952559-1588-5-git-send-email-hare@suse.de>

From: Johannes Thumshirn <jthumshirn@suse.de>

To figure out if a namespace is shared via multipath we need to expose
the 'NMIC' value to sysfs.

Signed-off-by: Johannes Thumshirn <jthumshirn at suse.de>
---
 drivers/nvme/host/core.c | 12 ++++++++++++
 drivers/nvme/host/nvme.h |  1 +
 2 files changed, 13 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 8924f48..955fedf 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2292,6 +2292,16 @@ static inline struct nvme_ns_head *dev_to_ns_head(struct device *dev)
 		return disk->private_data;
 }
 
+static ssize_t nmic_show(struct device *dev, struct device_attribute *attr,
+			 char *buf)
+{
+	struct nvme_ns_head *head = dev_to_ns_head(dev);
+	struct nvme_ns_ids *ids = &head->ids;
+
+	return sprintf(buf, "0x%x\n", ids->nmic);
+}
+static DEVICE_ATTR(nmic, S_IRUGO, nmic_show, NULL);
+
 static ssize_t wwid_show(struct device *dev, struct device_attribute *attr,
 		char *buf)
 {
@@ -2367,6 +2377,7 @@ static ssize_t nsid_show(struct device *dev, struct device_attribute *attr,
 	&dev_attr_nguid.attr,
 	&dev_attr_eui.attr,
 	&dev_attr_nsid.attr,
+	&dev_attr_nmic.attr,
 	NULL,
 };
 
@@ -2663,6 +2674,7 @@ static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ctrl *ctrl,
 	kref_init(&head->ref);
 
 	nvme_report_ns_ids(ctrl, nsid, id, &head->ids);
+	head->ids.nmic = id->nmic;
 
 	ret = __nvme_check_ids(ctrl->subsys, head);
 	if (ret) {
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index a8a79bc..1f195ff 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -222,6 +222,7 @@ struct nvme_ns_ids {
 	u8	eui64[8];
 	u8	nguid[16];
 	uuid_t	uuid;
+	u8 nmic;
 };
 
 /*
-- 
1.8.5.6
