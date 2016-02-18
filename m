From: keith.busch@intel.com (Keith Busch)
Date: Thu, 18 Feb 2016 15:10:11 +0000
Subject: NVMe wwid revisited
In-Reply-To: <20160218132856.GA5150@lst.de>
References: <56C5C15C.8030903@suse.de>
 <20160218132856.GA5150@lst.de>
Message-ID: <20160218151010.GA4901@localhost.localdomain>

On Thu, Feb 18, 2016@02:28:56PM +0100, Christoph Hellwig wrote:
> On Thu, Feb 18, 2016@02:04:28PM +0100, Hannes Reinecke wrote:
> > Which, of course, raises the question: What _is_ the correct
> > identification?
> > Implement it according to the translation spec, leaving out the 'T10
> > Vendor Identification' field?
> > Or implement it with the correct designator type?
> 
> Leave it as-is, given a certain Linux distributor started using it for
> their udev rules and we'd otherwise break their setup.

We mentioned exposing a single sysfs handle that provides the unique so
the user doesn't have to check/concat multiple files or use the deprecated
NVMe SG_IO interface.

Does the below patch look alright? It uses either 64 or 128 bit EUI if
provided, or concats other parts to make a unique (and long!) identifier
if the namespace doesn't support its own unique id.

Here's a couple examples with a 1.0 controller and a 1.2 controller
(I don't have a 1.1 controller; no EUI-64 example):

  1.0:
    # cat /sys/block/nvme0n1/wwid
    nvme.8086-43564654343032333030324b38303043474e-494e54454c205353445045444d443830304734-00000001

  1.2:
    # cat /sys/block/nvme1n2/wwid
    eui.5cd2e400000000000000000000000100000002

---
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index face31f..93ec2e0 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -872,6 +876,7 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 		return -EIO;
 	}
 
+	ctrl->vid = le16_to_cpu(id->vid);
 	ctrl->oncs = le16_to_cpup(&id->oncs);
 	atomic_set(&ctrl->abort_limit, id->acl + 1);
 	ctrl->vwc = id->vwc;
@@ -1008,6 +1013,30 @@ static ssize_t nvme_sysfs_reset(struct device *dev,
 }
 static DEVICE_ATTR(reset_controller, S_IWUSR, NULL, nvme_sysfs_reset);
 
+static ssize_t wwid_show(struct device *dev, struct device_attribute *attr,
+								char *buf)
+{
+	struct nvme_ns *ns = dev_to_disk(dev)->private_data;
+	struct nvme_ctrl *ctrl = ns->ctrl;
+	int serial_len = sizeof(ctrl->serial);
+	int model_len = sizeof(ctrl->model);
+
+	if (memchr_inv(ns->uuid, 0, sizeof(ns->uuid)))
+		return sprintf(buf, "eui.%16phN\n", ns->uuid);
+
+	if (memchr_inv(ns->eui, 0, sizeof(ns->eui)))
+		return sprintf(buf, "eui.%8phN\n", ns->eui);
+
+	while (ctrl->serial[serial_len - 1] == ' ')
+		serial_len--;
+	while (ctrl->model[model_len - 1] == ' ')
+		model_len--;
+
+	return sprintf(buf, "nvme.%04x-%*phN-%*phN-%08x\n", ctrl->vid,
+		serial_len, ctrl->serial, model_len, ctrl->model, ns->ns_id);
+}
+static DEVICE_ATTR(wwid, S_IRUGO, wwid_show, NULL);
+
 static ssize_t uuid_show(struct device *dev, struct device_attribute *attr,
 								char *buf)
 {
@@ -1033,6 +1062,7 @@ static ssize_t nsid_show(struct device *dev, struct device_attribute *attr,
 static DEVICE_ATTR(nsid, S_IRUGO, nsid_show, NULL);
 
 static struct attribute *nvme_ns_attrs[] = {
+	&dev_attr_wwid.attr,
 	&dev_attr_uuid.attr,
 	&dev_attr_eui.attr,
 	&dev_attr_nsid.attr,
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index dcdc2d7..b50e591 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -84,6 +84,7 @@ struct nvme_ctrl {
 	u32 max_hw_sectors;
 	u32 stripe_size;
 	u16 oncs;
+	u16 vid;
 	atomic_t abort_limit;
 	u8 event_limit;
 	u8 vwc;
---
