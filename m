Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E48EDCD6E7C
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Jun 2026 15:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=80kSoacOHkF7d44A41oKXfsKsE5R+0n55x/lLTTBUJM=; b=gdzQkzSgFDsm3Vqe+b6WfWkwUe
	3qOwD3zuxPx69Lub89vBOwC45h5dwfXqDi0E8P32G4+5Ov+IyPsjJJ7eZa1lAHh9/BgDoJG2pxjx/
	wv4S2Y0BxYJM0g7wW0ZHMdQzWc1hhjJ04nf+B7yUP03eC2f1WUieZTDjZKTn+zbBKIzBx9kug0Yzo
	b23DCj8ZveROBiuBaCvTCEaZMCwLGhRsLcDUYrXqicXch09lOoCTe27dCGo5AdFjiiapUaxSgPcGS
	qkae6+xcMEgz+W86lcDogLuLayxgW6SmYTqu/3VGuc6/zddf5yRLi7nRr9NBOTmaGTcuKPqfq0t9G
	BfpysfcQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVWCN-00000000nBL-0Rrg;
	Fri, 05 Jun 2026 15:11:03 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVWCK-00000000nAt-394s
	for linux-nvme@lists.infradead.org;
	Fri, 05 Jun 2026 15:11:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780672258;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=80kSoacOHkF7d44A41oKXfsKsE5R+0n55x/lLTTBUJM=;
	b=WDRmFBCChIQzrN5hIhlM7zY061gRPlCCDJ9qE6dagk7G7q3GobzfOEc8E9o/3FZoQnTEy7
	Vitjzo3Q6HUIbNN5ev8GcUF5bl857fSQTQlSjySHUTORK8RtLhBy246O0D1AEg/g3ceO22
	+TV1TV373jjMIsqXmCFG5ADnkEC3CxI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-627-mjz8T9GxOsCV_FH54f6UIA-1; Fri,
 05 Jun 2026 11:10:56 -0400
X-MC-Unique: mjz8T9GxOsCV_FH54f6UIA-1
X-Mimecast-MFC-AGG-ID: mjz8T9GxOsCV_FH54f6UIA_1780672255
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C6D621800589;
	Fri,  5 Jun 2026 15:10:54 +0000 (UTC)
Received: from mlombard-thinkpadt14gen4.rmtit.csb (unknown [10.44.48.19])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 984CF27A;
	Fri,  5 Jun 2026 15:10:52 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: kbusch@kernel.org
Cc: hch@lst.de,
	linux-nvme@lists.infradead.org,
	dwagner@suse.de,
	mlombard@arkamax.eu
Subject: [PATCH] nvme: fix crash and memory leak during invalid cdev teardown
Date: Fri,  5 Jun 2026 17:10:48 +0200
Message-ID: <20260605151048.354313-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 9Y6l83HSTP8jjl3EPAzh2AMwv4RF1YEqsEesZ_7E_Yc_1780672255
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260605_081100_856533_4787EC73 
X-CRM114-Status: GOOD (  19.16  )
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

In the NVMe multipath code, if nvme_add_ns_head_cdev() fails during
nvme_mpath_set_live(), the error is ignored. However, during teardown,
nvme_remove_head() unconditionally calls nvme_cdev_del(). This teardown
asymmetry leads to a kernel panic if the character device was never
successfully initialized.

BUG: kernel NULL pointer dereference, address: 00000000000000d0
 device_del+0x39/0x3c0
 cdev_device_del+0x15/0x50
 nvme_cdev_del+0xe/0x20 [nvme_core]
 nvme_mpath_shutdown_disk+0x38/0x60 [nvme_core]
 nvme_ns_remove+0x177/0x1f0 [nvme_core]
 nvme_remove_namespaces+0xdc/0x130 [nvme_core]
 nvme_do_delete_ctrl+0x71/0xd0 [nvme_core]

Additionally, a memory leak exists in the nvme_cdev_add() failure path.
Previously, dev_set_name() was called before ida_alloc(). If ida_alloc()
subsequently failed, device_initialize() was never called, meaning
put_device() could not be used to clean up the kobject, leaking the
memory allocated by dev_set_name().

*  Introduces the NVME_NSHEAD_CDEV_LIVE and NVME_NS_CDEV_LIVE bits to track
   the successful creation of the character devices. Teardown routines now
   check these bits before attempting deletion.
*  Refactor nvme_cdev_add() to accept the formatted device name as a
   parameter, moving dev_set_name() after the IDA allocation and
   immediately before device_initialize(). This ensures any internally
   allocated strings are safely cleaned up by put_device() upon failure.

Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
---
 drivers/nvme/host/core.c      | 33 +++++++++++++++++++++++++--------
 drivers/nvme/host/multipath.c | 22 ++++++++++++++++------
 drivers/nvme/host/nvme.h      |  4 +++-
 3 files changed, 44 insertions(+), 15 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 72c50d5e938d..451d41c32294 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3856,7 +3856,7 @@ void nvme_cdev_del(struct cdev *cdev, struct device *cdev_device)
 	put_device(cdev_device);
 }
 
-int nvme_cdev_add(struct cdev *cdev, struct device *cdev_device,
+int nvme_cdev_add(char *name, struct cdev *cdev, struct device *cdev_device,
 		const struct file_operations *fops, struct module *owner)
 {
 	int minor, ret;
@@ -3864,6 +3864,12 @@ int nvme_cdev_add(struct cdev *cdev, struct device *cdev_device,
 	minor = ida_alloc(&nvme_ns_chr_minor_ida, GFP_KERNEL);
 	if (minor < 0)
 		return minor;
+
+	ret = dev_set_name(cdev_device, name);
+	if (ret) {
+		ida_free(&nvme_ns_chr_minor_ida, minor);
+		return ret;
+	}
 	cdev_device->devt = MKDEV(MAJOR(nvme_ns_chr_devt), minor);
 	cdev_device->class = &nvme_ns_chr_class;
 	cdev_device->release = nvme_cdev_rel;
@@ -3901,15 +3907,24 @@ static const struct file_operations nvme_ns_chr_fops = {
 static int nvme_add_ns_cdev(struct nvme_ns *ns)
 {
 	int ret;
+	char *name;
 
 	ns->cdev_device.parent = ns->ctrl->device;
-	ret = dev_set_name(&ns->cdev_device, "ng%dn%d",
-			   ns->ctrl->instance, ns->head->instance);
+	name = kasprintf(GFP_KERNEL, "ng%dn%d", ns->ctrl->instance,
+			 ns->head->instance);
+	if (!name)
+		return -ENOMEM;
+
+	ret = nvme_cdev_add(name, &ns->cdev, &ns->cdev_device,
+			    &nvme_ns_chr_fops, ns->ctrl->ops->module);
 	if (ret)
-		return ret;
+		dev_err(ns->ctrl->device, "Unable to create the %s device",
+			name);
+	else
+		set_bit(NVME_NS_CDEV_LIVE, &ns->flags);
 
-	return nvme_cdev_add(&ns->cdev, &ns->cdev_device, &nvme_ns_chr_fops,
-			     ns->ctrl->ops->module);
+	kfree(name);
+	return ret;
 }
 
 static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ctrl *ctrl,
@@ -4285,8 +4300,10 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 	/* guarantee not available in head->list */
 	synchronize_srcu(&ns->head->srcu);
 
-	if (!nvme_ns_head_multipath(ns->head))
-		nvme_cdev_del(&ns->cdev, &ns->cdev_device);
+	if (!nvme_ns_head_multipath(ns->head)) {
+		if (test_and_clear_bit(NVME_NS_CDEV_LIVE, &ns->flags))
+			nvme_cdev_del(&ns->cdev, &ns->cdev_device);
+	}
 
 	nvme_mpath_remove_sysfs_link(ns);
 
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 263161cb8ac0..80b475a779ab 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -620,14 +620,23 @@ static const struct file_operations nvme_ns_head_chr_fops = {
 static int nvme_add_ns_head_cdev(struct nvme_ns_head *head)
 {
 	int ret;
+	char *name;
 
 	head->cdev_device.parent = &head->subsys->dev;
-	ret = dev_set_name(&head->cdev_device, "ng%dn%d",
-			   head->subsys->instance, head->instance);
-	if (ret)
-		return ret;
-	ret = nvme_cdev_add(&head->cdev, &head->cdev_device,
+	name = kasprintf(GFP_KERNEL, "ng%dn%d", head->subsys->instance,
+			 head->instance);
+	if (!name)
+		return -ENOMEM;
+
+	ret = nvme_cdev_add(name, &head->cdev, &head->cdev_device,
 			    &nvme_ns_head_chr_fops, THIS_MODULE);
+	if (ret)
+		dev_err(disk_to_dev(head->disk),
+			"Unable to create the %s device", name);
+	else
+		set_bit(NVME_NSHEAD_CDEV_LIVE, &head->flags);
+
+	kfree(name);
 	return ret;
 }
 
@@ -672,7 +681,8 @@ static void nvme_remove_head(struct nvme_ns_head *head)
 		 */
 		kblockd_schedule_work(&head->requeue_work);
 
-		nvme_cdev_del(&head->cdev, &head->cdev_device);
+		if (test_and_clear_bit(NVME_NSHEAD_CDEV_LIVE, &head->flags))
+			nvme_cdev_del(&head->cdev, &head->cdev_device);
 		synchronize_srcu(&head->srcu);
 		del_gendisk(head->disk);
 	}
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 9ccaed0b9dbf..e7706edb26e9 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -567,6 +567,7 @@ struct nvme_ns_head {
 	unsigned int		delayed_removal_secs;
 #define NVME_NSHEAD_DISK_LIVE		0
 #define NVME_NSHEAD_QUEUE_IF_NO_PATH	1
+#define NVME_NSHEAD_CDEV_LIVE		2
 	struct nvme_ns __rcu	*current_path[];
 #endif
 };
@@ -602,6 +603,7 @@ struct nvme_ns {
 #define NVME_NS_FORCE_RO		3
 #define NVME_NS_READY			4
 #define NVME_NS_SYSFS_ATTR_LINK	5
+#define NVME_NS_CDEV_LIVE		6
 
 	struct cdev		cdev;
 	struct device		cdev_device;
@@ -986,7 +988,7 @@ int nvme_get_log(struct nvme_ctrl *ctrl, u32 nsid, u8 log_page, u8 lsp, u8 csi,
 		void *log, size_t size, u64 offset);
 bool nvme_tryget_ns_head(struct nvme_ns_head *head);
 void nvme_put_ns_head(struct nvme_ns_head *head);
-int nvme_cdev_add(struct cdev *cdev, struct device *cdev_device,
+int nvme_cdev_add(char *name, struct cdev *cdev, struct device *cdev_device,
 		const struct file_operations *fops, struct module *owner);
 void nvme_cdev_del(struct cdev *cdev, struct device *cdev_device);
 int nvme_ioctl(struct block_device *bdev, blk_mode_t mode,
-- 
2.54.0


