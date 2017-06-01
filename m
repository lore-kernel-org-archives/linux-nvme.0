From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Thu,  1 Jun 2017 13:17:48 +0200
Subject: [PATCH v2 6/8] nvme: provide UUID value to userspace
In-Reply-To: <20170601111750.20880-1-jthumshirn@suse.de>
References: <20170601111750.20880-1-jthumshirn@suse.de>
Message-ID: <20170601111750.20880-7-jthumshirn@suse.de>

Now that we have a way for getting the UUID from a target, provide it
to userspace as well.

Unfortunately there is already a sysfs attribute called UUID which is
a misnomer as it holds the NGUID value. So instead of creating yet
another wrong name, create a new 'nguid' sysfs attribute for the
NGUID. For the UUID attribute add a check wheter the namespace has a
UUID assigned to it and return this or return the NGUID to maintain
backwards compatibility. This should give userspace a chance to catch
up.

Signed-off-by: Johannes Thumshirn <jthumshirn at suse.de>
Reviewed-by: Christoph Hellwig <hch at lst.de>
Reviewed-by: Hannes Reinecke <hare at suse.com>
---
 drivers/nvme/host/core.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 37047841da0e..3aa5b12680e5 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1887,11 +1887,28 @@ static ssize_t wwid_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR(wwid, S_IRUGO, wwid_show, NULL);
 
+static ssize_t nguid_show(struct device *dev, struct device_attribute *attr,
+			  char *buf)
+{
+	struct nvme_ns *ns = nvme_get_ns_from_dev(dev);
+	return sprintf(buf, "%pU\n", ns->nguid);
+}
+static DEVICE_ATTR(nguid, S_IRUGO, nguid_show, NULL);
+
 static ssize_t uuid_show(struct device *dev, struct device_attribute *attr,
 								char *buf)
 {
 	struct nvme_ns *ns = nvme_get_ns_from_dev(dev);
-	return sprintf(buf, "%pU\n", ns->nguid);
+
+	/* For backward compatibility expose the NGUID to userspace if
+	 * we have no UUID set
+	 */
+	if (!memchr_inv(ns->uuid, 0, sizeof(ns->uuid))) {
+		printk_ratelimited(KERN_WARNING
+				   "No UUID available providing old NGUID\n");
+		return sprintf(buf, "%pU\n", ns->nguid);
+	}
+	return sprintf(buf, "%pU\n", ns->uuid);
 }
 static DEVICE_ATTR(uuid, S_IRUGO, uuid_show, NULL);
 
@@ -1914,6 +1931,7 @@ static DEVICE_ATTR(nsid, S_IRUGO, nsid_show, NULL);
 static struct attribute *nvme_ns_attrs[] = {
 	&dev_attr_wwid.attr,
 	&dev_attr_uuid.attr,
+	&dev_attr_nguid.attr,
 	&dev_attr_eui.attr,
 	&dev_attr_nsid.attr,
 	NULL,
@@ -1926,6 +1944,11 @@ static umode_t nvme_ns_attrs_are_visible(struct kobject *kobj,
 	struct nvme_ns *ns = nvme_get_ns_from_dev(dev);
 
 	if (a == &dev_attr_uuid.attr) {
+		if (!memchr_inv(ns->uuid, 0, sizeof(ns->uuid)) ||
+		    !memchr_inv(ns->nguid, 0, sizeof(ns->nguid)))
+			return 0;
+	}
+	if (a == &dev_attr_nguid.attr) {
 		if (!memchr_inv(ns->nguid, 0, sizeof(ns->nguid)))
 			return 0;
 	}
-- 
2.12.0
