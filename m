Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E096C38142
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Feb 2023 06:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QhoEEdcmEd4jafQzYcqirtrCqUWueHYoCIUIjD3ij1k=; b=XgQ3hhS7YK8f2wCUGWF27jg2p/
	C5Rkel3Gv5KS79/Cl6pw2u/DXWhaELixDQzyFeI7REJlX4LBC75k4G2J6H/Ifns6tkbXgROxSQR2b
	Eb5HV0nbofHVJQCq8vZTo71DFEXinhy8WK1nKCCer9OW5DxM268VEBwA2HPY9Mj+y+LZ6K36OpxqN
	4c8xsfXWt8/IAwY0a0UtkP1K+V7JC7vG92AgQWABfCcVv/x7a7m9En5A0LR7LqsRLwqw356dyFZkb
	F4M+CxInjiDMsY4ZQx0U+GY4pVg1IY0XDpEmcH9XarqcvBDSiOpk0AVAfDrkKKnU6d5fQ8T2MRO7r
	nx3OHb9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pN6ab-00ASmR-QF; Wed, 01 Feb 2023 06:27:25 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pN6aa-00ASm5-3C; Wed, 01 Feb 2023 06:27:24 +0000
Date: Tue, 31 Jan 2023 22:27:24 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@infradead.org>,
	John Meneghini <jmeneghi@redhat.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: nvme/pcie hot plug results in /dev name change
Message-ID: <Y9oGTKCFlOscbPc2@infradead.org>
References: <472fe309-f0f9-65bf-1ad1-8a92a349e973@redhat.com>
 <Y8sKv7q+UEbz5ddD@kbusch-mbp.dhcp.thefacebook.com>
 <Y8uN4V8uW2qS+xHR@infradead.org>
 <Y9ZKNb4UKwg5zF4j@T590>
 <Y9lEF7oY+aQw2POp@kbusch-mbp.dhcp.thefacebook.com>
 <Y9nPa2ZBc80g2LcA@T590>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="+XfcWiSn8b5Lwv7T"
Content-Disposition: inline
In-Reply-To: <Y9nPa2ZBc80g2LcA@T590>
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


--+XfcWiSn8b5Lwv7T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 01, 2023 at 10:33:15AM +0800, Ming Lei wrote:
> > The native nvme multipath looks like it could be leveraged to improving that
> > user experience if we wanted to make that layer an option for non-multipath
> > devices.
> 
> Can you share the basic idea? Will nvme mulitpath hold the io error and
> not propagate to upper layer until new device is probed? What if the
> new device is probed late, and IO has been timed out and err is returned
> to upper layer?

Attached is what I did, but I'm really not sure it is the right final
approach.

--+XfcWiSn8b5Lwv7T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-nvme-split-ANA-attribute-handling-from-nvme_ns_id_at.patch"

From 7016fc46f29463871b68348088384b3d0ceeba91 Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Sun, 30 Oct 2022 18:17:28 +0100
Subject: nvme: split ANA attribute handling from nvme_ns_id_attr_group

Use a separate attribute group for the ANA attributes that aren't shown
on the multipath-device instead of just hiding them at runtime.
While this is a little more code, it keeps the separation clear.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c      | 22 +++++++-------------
 drivers/nvme/host/multipath.c | 38 ++++++++++++++++++++++++++++++++---
 drivers/nvme/host/nvme.h      | 14 ++-----------
 3 files changed, 44 insertions(+), 30 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 14568ae308fba5..2eab4d1b521edb 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3432,10 +3432,6 @@ static struct attribute *nvme_ns_id_attrs[] = {
 	&dev_attr_nguid.attr,
 	&dev_attr_eui.attr,
 	&dev_attr_nsid.attr,
-#ifdef CONFIG_NVME_MULTIPATH
-	&dev_attr_ana_grpid.attr,
-	&dev_attr_ana_state.attr,
-#endif
 	NULL,
 };
 
@@ -3458,24 +3454,20 @@ static umode_t nvme_ns_id_attrs_are_visible(struct kobject *kobj,
 		if (!memchr_inv(ids->eui64, 0, sizeof(ids->eui64)))
 			return 0;
 	}
-#ifdef CONFIG_NVME_MULTIPATH
-	if (a == &dev_attr_ana_grpid.attr || a == &dev_attr_ana_state.attr) {
-		if (dev_to_disk(dev)->fops != &nvme_bdev_ops) /* per-path attr */
-			return 0;
-		if (!nvme_ctrl_use_ana(nvme_get_ns_from_dev(dev)->ctrl))
-			return 0;
-	}
-#endif
+
 	return a->mode;
 }
 
-static const struct attribute_group nvme_ns_id_attr_group = {
+const struct attribute_group nvme_ns_id_attr_group = {
 	.attrs		= nvme_ns_id_attrs,
 	.is_visible	= nvme_ns_id_attrs_are_visible,
 };
 
-const struct attribute_group *nvme_ns_id_attr_groups[] = {
+static const struct attribute_group *nvme_disk_attr_groups[] = {
 	&nvme_ns_id_attr_group,
+#ifdef CONFIG_NVME_MULTIPATH
+	&nvme_ns_ana_attr_group,
+#endif
 	NULL,
 };
 
@@ -4250,7 +4242,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
 	up_write(&ctrl->namespaces_rwsem);
 	nvme_get_ctrl(ctrl);
 
-	if (device_add_disk(ctrl->device, ns->disk, nvme_ns_id_attr_groups))
+	if (device_add_disk(ctrl->device, ns->disk, nvme_disk_attr_groups))
 		goto out_cleanup_ns_from_list;
 
 	if (!nvme_ns_head_multipath(ns->head))
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 0ea7e441e080f2..96ea23f1e374f0 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -50,6 +50,11 @@ void nvme_mpath_default_iopolicy(struct nvme_subsystem *subsys)
 	subsys->iopolicy = iopolicy;
 }
 
+static inline bool nvme_ctrl_use_ana(struct nvme_ctrl *ctrl)
+{
+	return ctrl->ana_log_buf != NULL;
+}
+
 void nvme_mpath_unfreeze(struct nvme_subsystem *subsys)
 {
 	struct nvme_ns_head *h;
@@ -443,6 +448,11 @@ static const struct file_operations nvme_ns_head_chr_fops = {
 	.uring_cmd_iopoll = nvme_ns_head_chr_uring_cmd_iopoll,
 };
 
+static const struct attribute_group *nvme_mpath_disk_attr_groups[] = {
+	&nvme_ns_id_attr_group,
+	NULL,
+};
+
 static int nvme_add_ns_head_cdev(struct nvme_ns_head *head)
 {
 	int ret;
@@ -539,7 +549,7 @@ static void nvme_mpath_set_live(struct nvme_ns *ns)
 	 */
 	if (!test_and_set_bit(NVME_NSHEAD_DISK_LIVE, &head->flags)) {
 		rc = device_add_disk(&head->subsys->dev, head->disk,
-				     nvme_ns_id_attr_groups);
+				     nvme_mpath_disk_attr_groups);
 		if (rc) {
 			clear_bit(NVME_NSHEAD_DISK_LIVE, &ns->flags);
 			return;
@@ -780,7 +790,7 @@ static ssize_t ana_grpid_show(struct device *dev, struct device_attribute *attr,
 {
 	return sysfs_emit(buf, "%d\n", nvme_get_ns_from_dev(dev)->ana_grpid);
 }
-DEVICE_ATTR_RO(ana_grpid);
+static DEVICE_ATTR_RO(ana_grpid);
 
 static ssize_t ana_state_show(struct device *dev, struct device_attribute *attr,
 		char *buf)
@@ -789,7 +799,29 @@ static ssize_t ana_state_show(struct device *dev, struct device_attribute *attr,
 
 	return sysfs_emit(buf, "%s\n", nvme_ana_state_names[ns->ana_state]);
 }
-DEVICE_ATTR_RO(ana_state);
+static DEVICE_ATTR_RO(ana_state);
+
+static struct attribute *nvme_ns_ana_attrs[] = {
+	&dev_attr_ana_grpid.attr,
+	&dev_attr_ana_state.attr,
+	NULL,
+};
+
+static umode_t nvme_ns_ana_attr_is_visible(struct kobject *kobj,
+		struct attribute *a, int n)
+{
+	struct device *dev = container_of(kobj, struct device, kobj);
+
+	if (!nvme_ctrl_use_ana(nvme_get_ns_from_dev(dev)->ctrl))
+		return 0;
+
+	return a->mode;
+}
+
+const struct attribute_group nvme_ns_ana_attr_group = {
+	.attrs		= nvme_ns_ana_attrs,
+	.is_visible	= nvme_ns_ana_attr_is_visible,
+};
 
 static int nvme_lookup_ana_group_desc(struct nvme_ctrl *ctrl,
 		struct nvme_ana_group_desc *desc, void *data)
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 00d3b438efe3f3..c656643ba0eead 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -855,17 +855,13 @@ int nvme_ns_head_chr_uring_cmd(struct io_uring_cmd *ioucmd,
 int nvme_getgeo(struct block_device *bdev, struct hd_geometry *geo);
 int nvme_dev_uring_cmd(struct io_uring_cmd *ioucmd, unsigned int issue_flags);
 
-extern const struct attribute_group *nvme_ns_id_attr_groups[];
+extern const struct attribute_group nvme_ns_id_attr_group;
+extern const struct attribute_group nvme_ns_ana_attr_group;
 extern const struct pr_ops nvme_pr_ops;
 extern const struct block_device_operations nvme_ns_head_ops;
 
 struct nvme_ns *nvme_find_path(struct nvme_ns_head *head);
 #ifdef CONFIG_NVME_MULTIPATH
-static inline bool nvme_ctrl_use_ana(struct nvme_ctrl *ctrl)
-{
-	return ctrl->ana_log_buf != NULL;
-}
-
 void nvme_mpath_unfreeze(struct nvme_subsystem *subsys);
 void nvme_mpath_wait_freeze(struct nvme_subsystem *subsys);
 void nvme_mpath_start_freeze(struct nvme_subsystem *subsys);
@@ -894,16 +890,10 @@ static inline void nvme_trace_bio_complete(struct request *req)
 }
 
 extern bool multipath;
-extern struct device_attribute dev_attr_ana_grpid;
-extern struct device_attribute dev_attr_ana_state;
 extern struct device_attribute subsys_attr_iopolicy;
 
 #else
 #define multipath false
-static inline bool nvme_ctrl_use_ana(struct nvme_ctrl *ctrl)
-{
-	return false;
-}
 static inline void nvme_failover_req(struct request *req)
 {
 }
-- 
2.39.0


--+XfcWiSn8b5Lwv7T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="0002-nvme-allow-pinning-shared-namespaces.patch"

From 76e56c0c5a1e6bb3d9d4d11255a5bc4db634e28b Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Sun, 30 Oct 2022 18:39:53 +0100
Subject: nvme: allow pinning shared namespaces

Add a sysfs attribute to pin a ns_head.  While pinned the ns_head
will not go away even if no namespace currently exists.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c      | 11 ++++--
 drivers/nvme/host/multipath.c | 63 +++++++++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h      |  1 +
 3 files changed, 72 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 2eab4d1b521edb..32f2e394dd6dc9 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3897,8 +3897,12 @@ static struct nvme_ns_head *nvme_find_ns_head(struct nvme_ctrl *ctrl,
 		 */
 		if (h->ns_id != nsid || !nvme_is_unique_nsid(ctrl, h))
 			continue;
-		if (!list_empty(&h->list) && nvme_tryget_ns_head(h))
-			return h;
+		if (list_empty(&h->list) &&
+		    !test_bit(NVME_NSHEAD_PINNED, &h->flags))
+			continue;
+		if (!nvme_tryget_ns_head(h))
+			continue;
+		return h;
 	}
 
 	return NULL;
@@ -4294,7 +4298,8 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 
 	mutex_lock(&ns->ctrl->subsys->lock);
 	list_del_rcu(&ns->siblings);
-	if (list_empty(&ns->head->list)) {
+	if (list_empty(&ns->head->list) &&
+	    !test_bit(NVME_NSHEAD_PINNED, &ns->head->flags)) {
 		list_del_init(&ns->head->entry);
 		last_path = true;
 	}
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 96ea23f1e374f0..9dbbd3a4398598 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -448,8 +448,71 @@ static const struct file_operations nvme_ns_head_chr_fops = {
 	.uring_cmd_iopoll = nvme_ns_head_chr_uring_cmd_iopoll,
 };
 
+static ssize_t pin_show(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	struct gendisk *disk = dev_to_disk(dev);
+	struct nvme_ns_head *head = disk->private_data;
+
+	return sysfs_emit(buf, "%d\n",
+			  test_bit(NVME_NSHEAD_PINNED, &head->flags));
+}
+
+static ssize_t pin_store(struct device *dev, struct device_attribute *attr,
+		const char *buf, size_t count)
+{
+	struct gendisk *disk = dev_to_disk(dev);
+	struct nvme_ns_head *head = disk->private_data;
+	bool shutdown = false;
+	ssize_t ret = 0;
+	bool pin;
+
+	ret = kstrtobool(buf, &pin);
+	if (ret)
+		return ret;
+
+	if (pin) {
+		if (!nvme_tryget_ns_head(head))
+			return -EINVAL;
+		if (test_and_set_bit(NVME_NSHEAD_PINNED, &head->flags)) {
+			ret = -EINVAL;
+			goto out_put_head;
+		}
+		return count;
+	}
+
+	if (!test_and_clear_bit(NVME_NSHEAD_PINNED, &head->flags))
+		return -EINVAL;
+
+	mutex_lock(&head->subsys->lock);
+	if (list_empty(&head->list)) {
+		list_del_init(&head->entry);
+		shutdown = true;
+	}
+	mutex_unlock(&head->subsys->lock);
+	if (shutdown)
+		nvme_mpath_shutdown_disk(head);
+
+out_put_head:
+	nvme_put_ns_head(head);
+	if (ret)
+		return ret;
+	return count;
+}
+static DEVICE_ATTR_RW(pin);
+
+static struct attribute *nvme_mpath_disk_attrs[] = {
+	&dev_attr_pin.attr,
+	NULL,
+};
+
+const struct attribute_group nvme_mpath_disk_attr_group = {
+	.attrs		= nvme_mpath_disk_attrs,
+};
+
 static const struct attribute_group *nvme_mpath_disk_attr_groups[] = {
 	&nvme_ns_id_attr_group,
+	&nvme_mpath_disk_attr_group,
 	NULL,
 };
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index c656643ba0eead..1e0ec8ef4d842a 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -442,6 +442,7 @@ struct nvme_ns_head {
 	struct mutex		lock;
 	unsigned long		flags;
 #define NVME_NSHEAD_DISK_LIVE	0
+#define NVME_NSHEAD_PINNED	1
 	struct nvme_ns __rcu	*current_path[];
 #endif
 };
-- 
2.39.0


--+XfcWiSn8b5Lwv7T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="0003-HACK-allow-running-multipath-code-for-non-shared-nam.patch"

From 9ceb1ab63aeab757dab5f78f62a2b467dc34e103 Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Mon, 31 Oct 2022 10:34:44 +0100
Subject: HACK: allow running multipath code for non-shared namespaces

---
 drivers/nvme/host/core.c      | 4 ++--
 drivers/nvme/host/multipath.c | 3 +--
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 32f2e394dd6dc9..3e4ddbc373db80 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1447,7 +1447,7 @@ static int nvme_ns_info_from_identify(struct nvme_ctrl *ctrl,
 	if (ret)
 		return ret;
 	info->anagrpid = id->anagrpid;
-	info->is_shared = id->nmic & NVME_NS_NMIC_SHARED;
+	info->is_shared = true;
 	info->is_readonly = id->nsattr & NVME_NS_ATTR_RO;
 	info->is_ready = true;
 	if (ctrl->quirks & NVME_QUIRK_BOGUS_NID) {
@@ -1483,7 +1483,7 @@ static int nvme_ns_info_from_id_cs_indep(struct nvme_ctrl *ctrl,
 	ret = nvme_submit_sync_cmd(ctrl->admin_q, &c, id, sizeof(*id));
 	if (!ret) {
 		info->anagrpid = id->anagrpid;
-		info->is_shared = id->nmic & NVME_NS_NMIC_SHARED;
+		info->is_shared = true;
 		info->is_readonly = id->nsattr & NVME_NS_ATTR_RO;
 		info->is_ready = id->nstat & NVME_NSTAT_NRDY;
 	}
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 9dbbd3a4398598..0cb8d5c853156e 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -562,8 +562,7 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
 	 * We also do this for private namespaces as the namespace sharing flag
 	 * could change after a rescan.
 	 */
-	if (!(ctrl->subsys->cmic & NVME_CTRL_CMIC_MULTI_CTRL) ||
-	    !nvme_is_unique_nsid(ctrl, head) || !multipath)
+	if (!nvme_is_unique_nsid(ctrl, head) || !multipath)
 		return 0;
 
 	head->disk = blk_alloc_disk(ctrl->numa_node);
-- 
2.39.0


--+XfcWiSn8b5Lwv7T--

