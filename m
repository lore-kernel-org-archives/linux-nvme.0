From: sujithpshankar@gmail.com (Sujith Pandel)
Date: Fri, 4 Sep 2015 10:24:48 +0530
Subject: [PATCH] NVMe:Expose model attribute in sysfs
In-Reply-To: <alpine.LNX.2.00.1509011717550.23840@localhost.lm.intel.com>
References: <20150825045412.GA20360@localhost.localdomain>
 <alpine.LNX.2.00.1508251510330.3969@localhost.lm.intel.com>
 <20150901165554.GB12201@localhost.localdomain>
 <alpine.LNX.2.00.1509011717550.23840@localhost.lm.intel.com>
Message-ID: <20150904045439.GA10044@localhost.localdomain>

Hi Keith,
On Tue, Sep 01, 2015@12:25:48PM -0500, Keith Busch wrote:
> >> But if we're going to have more than one sysfs entry, we can manage
> >> this easier using attribute groups instead. There are lots of examples
> >> in the kernel for this, like scsi_sysfs.c or blk-mq-sysfs.c
> >
> > Since there are only two sysfs attributes here as of now,
> > I will be going with your former suggestion of using a new goto label.
> 
> Aww, that just forces the person who finds a need to add a third entry
> to implement a better design, or maybe he/she will use the same reasoning
> to shift that problem to the next person.
> 
> The "zero, one, infinity rule" puts 2 in the same catagory as infinity.
 
:) Appreciate the way you and David are making me (a kernel newbie) interested to contribute more on this one.
Hoping that this turns out to be my first kernel-patch!

Does this approach look okay?
If any new attributes are required, it can be added in the existing array or else,
have to create a new group and call sysfs_create_group()/sysfs_remove_group() on it.

Please let me know your thoughts on this.

--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -3151,6 +3151,44 @@ static ssize_t nvme_sysfs_reset(struct device *dev,
 }
 static DEVICE_ATTR(reset_controller, S_IWUSR, NULL, nvme_sysfs_reset);

+#define nvme_string_attr(name)                                             \
+static ssize_t  name##_show(struct device *dev,                            \
+                struct device_attribute *attr, char *buf)                  \
+{                                                                          \
+        struct nvme_dev *ndev = dev_get_drvdata(dev);                      \
+        return sprintf(buf, "%.*s\n", (int)sizeof(ndev->name), ndev->name);\
+}                                                                          \
+static DEVICE_ATTR(name, S_IRUGO, name##_show, NULL);
+
+/*
+ * Device string attributes.
+ * Can add serial and firmware_rev attributes here.
+ */
+nvme_string_attr(model);
+
+static struct attribute *nvme_dev_attrs[] = {
+        &dev_attr_reset_controller.attr,
+        &dev_attr_model.attr,
+        NULL
+};
+
+static struct attribute_group nvme_dev_attrs_group = {
+        .attrs = nvme_dev_attrs,
+};
+
+void nvme_remove_sysfs_files(struct device *dev)
+{
+        sysfs_remove_group(&dev->kobj, &nvme_dev_attrs_group);
+}
+
+/*
+ * Create sysfs entries for device attributes.
+ */
+int nvme_create_sysfs_files(struct device *dev)
+{
+        return sysfs_create_group(&dev->kobj, &nvme_dev_attrs_group);
+}
+
 static void nvme_async_probe(struct work_struct *work);
 static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
@@ -3197,7 +3235,7 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
        get_device(dev->device);
        dev_set_drvdata(dev->device, dev);

-       result = device_create_file(dev->device, &dev_attr_reset_controller);
+       result = nvme_create_sysfs_files(dev->device);
        if (result)
                goto put_dev;

@@ -3208,6 +3246,7 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
        return 0;

  put_dev:
+       nvme_remove_sysfs_files(dev->device);
        device_destroy(nvme_class, MKDEV(nvme_char_major, dev->instance));
        put_device(dev->device);
  release_pools:
@@ -3259,7 +3298,7 @@ static void nvme_remove(struct pci_dev *pdev)
        flush_work(&dev->probe_work);
        flush_work(&dev->reset_work);
        flush_work(&dev->scan_work);
-       device_remove_file(dev->device, &dev_attr_reset_controller);
+       nvme_remove_sysfs_files(dev->device);
        nvme_dev_remove(dev);
        nvme_dev_shutdown(dev);
        nvme_dev_remove_admin(dev);


Regards,
Sujith
