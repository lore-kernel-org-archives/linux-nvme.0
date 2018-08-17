From: Bart.VanAssche@wdc.com (Bart Van Assche)
Date: Fri, 17 Aug 2018 20:04:50 +0000
Subject: [PATCH 2/5] nvme: register ns_id attributes as default sysfs
 groups
In-Reply-To: <20180817070013.GD11170@lst.de>
References: <20180814073305.87255-1-hare@suse.de>
 <20180814073305.87255-3-hare@suse.de>
 <5a4aab8b5f509d8090ad10107b01d11285fe1528.camel@wdc.com>
 <e4c9ba55-ad92-dcb2-1126-38e5ea4c0a13@suse.de>
 <f9ad4ed4685e51a7b0378f11d3ce9d0a76235095.camel@wdc.com>
 <20180817070013.GD11170@lst.de>
Message-ID: <e3861d6482bef5595720c4e296a1c0e864226323.camel@wdc.com>

On Fri, 2018-08-17@09:00 +0200, hch@lst.de wrote:
> On Tue, Aug 14, 2018@03:44:57PM +0000, Bart Van Assche wrote:
> > On Tue, 2018-08-14@17:39 +0200, Hannes Reinecke wrote:
> > > While I have considered having nvme_nvm_register_sysfs() returning a
> > > pointer I would then have to remove the 'static' declaration from the
> > > nvm_dev_attr_group_12/20.
> > > Which I didn't really like, either.
> > 
> > Hmm ... I don't see why the static declaration would have to be removed from
> > nvm_dev_attr_group_12/20 if nvme_nvm_register_sysfs() would return a pointer?
> > Am I perhaps missing something?
> 
> No, I think that would be the preferable approach IFF patching the global
> table of groups would be viable.  I don't think it is, though - we can
> have both normal NVMe and LightNVM devices in the same system, so we
> can't just patch it over.
> 
> So we'll need three different attribut group arrays:
> 
> const struct attribute_group *nvme_ns_id_attr_groups[] = {
> 	&nvme_ns_id_attr_group,
> 	NULL,
> };
> 
> const struct attribute_group *lightnvm12_ns_id_attr_groups[] = {
> 	&nvme_ns_id_attr_group,
> 	&nvm_dev_attr_group_12,
> 	NULL,
> };
> 
> const struct attribute_group *lightnvm20_ns_id_attr_groups[] = {
> 	&nvme_ns_id_attr_group,
> 	&nvm_dev_attr_group_20,
> 	NULL,
> };
> 
> and a function to select which one to use.

Hello Christoph,

How about applying the patch below on top of Hannes' patch? The patch below
has the advantage that it completely separates the open channel sysfs
attributes from the NVMe core sysfs attributes - the open channel code
doesn't have to know anything about the NVMe core sysfs attributes and the
NVMe core does not have to know anything about the open channel sysfs
attributes.

Thanks,

Bart.


diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 8e26d98e9a8f..e0a9e1c5b30e 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2736,7 +2736,9 @@ const struct attribute_group nvme_ns_id_attr_group = {
 
 const struct attribute_group *nvme_ns_id_attr_groups[] = {
 	&nvme_ns_id_attr_group,
-	NULL, /* Will be filled in by lightnvm if present */
+#ifdef CONFIG_NVM
+	&nvme_nvm_attr_group,
+#endif
 	NULL,
 };
 
@@ -3105,8 +3107,6 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 
 	nvme_get_ctrl(ctrl);
 
-	if (ns->ndev)
-		nvme_nvm_register_sysfs(ns);
 	device_add_disk(ctrl->device, ns->disk, nvme_ns_id_attr_groups);
 
 	nvme_mpath_add_disk(ns, id);
diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index 7bf2f9da6293..b7b19d3561a4 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -1190,10 +1190,29 @@ static NVM_DEV_ATTR_12_RO(multiplane_modes);
 static NVM_DEV_ATTR_12_RO(media_capabilities);
 static NVM_DEV_ATTR_12_RO(max_phys_secs);
 
-static struct attribute *nvm_dev_attrs_12[] = {
+/* 2.0 values */
+static NVM_DEV_ATTR_20_RO(groups);
+static NVM_DEV_ATTR_20_RO(punits);
+static NVM_DEV_ATTR_20_RO(chunks);
+static NVM_DEV_ATTR_20_RO(clba);
+static NVM_DEV_ATTR_20_RO(ws_min);
+static NVM_DEV_ATTR_20_RO(ws_opt);
+static NVM_DEV_ATTR_20_RO(maxoc);
+static NVM_DEV_ATTR_20_RO(maxocpu);
+static NVM_DEV_ATTR_20_RO(mw_cunits);
+static NVM_DEV_ATTR_20_RO(write_typ);
+static NVM_DEV_ATTR_20_RO(write_max);
+static NVM_DEV_ATTR_20_RO(reset_typ);
+static NVM_DEV_ATTR_20_RO(reset_max);
+
+static struct attribute *nvm_dev_attrs[] = {
+	/* version agnostic attrs */
 	&dev_attr_version.attr,
 	&dev_attr_capabilities.attr,
+	&dev_attr_read_typ.attr,
+	&dev_attr_read_max.attr,
 
+	/* 1.2 attrs */
 	&dev_attr_vendor_opcode.attr,
 	&dev_attr_device_mode.attr,
 	&dev_attr_media_manager.attr,
@@ -1208,8 +1227,6 @@ static struct attribute *nvm_dev_attrs_12[] = {
 	&dev_attr_page_size.attr,
 	&dev_attr_hw_sector_size.attr,
 	&dev_attr_oob_sector_size.attr,
-	&dev_attr_read_typ.attr,
-	&dev_attr_read_max.attr,
 	&dev_attr_prog_typ.attr,
 	&dev_attr_prog_max.attr,
 	&dev_attr_erase_typ.attr,
@@ -1218,33 +1235,7 @@ static struct attribute *nvm_dev_attrs_12[] = {
 	&dev_attr_media_capabilities.attr,
 	&dev_attr_max_phys_secs.attr,
 
-	NULL,
-};
-
-static const struct attribute_group nvm_dev_attr_group_12 = {
-	.name		= "lightnvm",
-	.attrs		= nvm_dev_attrs_12,
-};
-
-/* 2.0 values */
-static NVM_DEV_ATTR_20_RO(groups);
-static NVM_DEV_ATTR_20_RO(punits);
-static NVM_DEV_ATTR_20_RO(chunks);
-static NVM_DEV_ATTR_20_RO(clba);
-static NVM_DEV_ATTR_20_RO(ws_min);
-static NVM_DEV_ATTR_20_RO(ws_opt);
-static NVM_DEV_ATTR_20_RO(maxoc);
-static NVM_DEV_ATTR_20_RO(maxocpu);
-static NVM_DEV_ATTR_20_RO(mw_cunits);
-static NVM_DEV_ATTR_20_RO(write_typ);
-static NVM_DEV_ATTR_20_RO(write_max);
-static NVM_DEV_ATTR_20_RO(reset_typ);
-static NVM_DEV_ATTR_20_RO(reset_max);
-
-static struct attribute *nvm_dev_attrs_20[] = {
-	&dev_attr_version.attr,
-	&dev_attr_capabilities.attr,
-
+	/* 2.0 attrs */
 	&dev_attr_groups.attr,
 	&dev_attr_punits.attr,
 	&dev_attr_chunks.attr,
@@ -1255,8 +1246,6 @@ static struct attribute *nvm_dev_attrs_20[] = {
 	&dev_attr_maxocpu.attr,
 	&dev_attr_mw_cunits.attr,
 
-	&dev_attr_read_typ.attr,
-	&dev_attr_read_max.attr,
 	&dev_attr_write_typ.attr,
 	&dev_attr_write_max.attr,
 	&dev_attr_reset_typ.attr,
@@ -1265,25 +1254,35 @@ static struct attribute *nvm_dev_attrs_20[] = {
 	NULL,
 };
 
-static const struct attribute_group nvm_dev_attr_group_20 = {
-	.name		= "lightnvm",
-	.attrs		= nvm_dev_attrs_20,
-};
-
-void nvme_nvm_register_sysfs(struct nvme_ns *ns)
+static umode_t nvm_dev_attrs_visible(struct kobject *kobj,
+				     struct attribute *attr, int index)
 {
+	struct device *dev = container_of(kobj, struct device, kobj);
+	struct gendisk *disk = dev_to_disk(dev);
+	struct nvme_ns *ns = disk->private_data;
 	struct nvm_dev *ndev = ns->ndev;
-	struct nvm_geo *geo = &ndev->geo;
+	struct device_attribute *dev_attr =
+		container_of(attr, typeof(*dev_attr), attr);
 
-	if (!ndev)
-		return;
+	if (dev_attr->show == nvm_dev_attr_show)
+		return attr->mode;
 
-	switch (geo->major_ver_id) {
+	switch (ndev ? ndev->geo.major_ver_id : 0) {
 	case 1:
-		nvme_ns_id_attr_groups[1] = &nvm_dev_attr_group_12;
+		if (dev_attr->show == nvm_dev_attr_show_12)
+			return attr->mode;
 		break;
 	case 2:
-		nvme_ns_id_attr_groups[1] = &nvm_dev_attr_group_20;
+		if (dev_attr->show == nvm_dev_attr_show_20)
+			return attr->mode;
 		break;
 	}
+
+	return 0;
 }
+
+const struct attribute_group nvm_dev_attr_group = {
+	.name		= "lightnvm",
+	.attrs		= nvm_dev_attrs,
+	.is_visible	= nvm_dev_attrs_visible,
+};
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 9ba6d67d8e0a..2503f8fd54da 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -551,7 +551,7 @@ static inline void nvme_mpath_stop(struct nvme_ctrl *ctrl)
 void nvme_nvm_update_nvm_info(struct nvme_ns *ns);
 int nvme_nvm_register(struct nvme_ns *ns, char *disk_name, int node);
 void nvme_nvm_unregister(struct nvme_ns *ns);
-void nvme_nvm_register_sysfs(struct nvme_ns *ns);
+extern const struct attribute_group nvme_nvm_attr_group;
 int nvme_nvm_ioctl(struct nvme_ns *ns, unsigned int cmd, unsigned long arg);
 #else
 static inline void nvme_nvm_update_nvm_info(struct nvme_ns *ns) {};
@@ -562,7 +562,6 @@ static inline int nvme_nvm_register(struct nvme_ns *ns, char *disk_name,
 }
 
 static inline void nvme_nvm_unregister(struct nvme_ns *ns) {};
-static inline void nvme_nvm_register_sysfs(struct nvme_ns *ns) {};
 static inline int nvme_nvm_ioctl(struct nvme_ns *ns, unsigned int cmd,
 							unsigned long arg)
 {
