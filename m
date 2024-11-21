Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 697B4E64025
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Nov 2024 22:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=utQ/+Wialc2cpyfpIYaR/RBfZ4JfS61QRHO5uJBPAJA=; b=fY6eg5S3Qo7E/7wDUN7OmBcGoI
	l32voNbHfe4trxePcEp43D2uYv/wUSRCrNGxrKuJfHU2EACH8SAkvIVlv2aRKDEjRAAB+82yCjcRq
	xZyzEAlTZ9pzqLZQzq6uoIS9W0za+ZDYRszECR2IHAULldhC10rGj6j1e21GscSaFk+lZ6LCNGGDC
	owfp+SxfJfZekBFqW4sq6q9nng6JskxKPBenxbPVB1le9OYFq9VfFbB7/xZMMOuEQjIldriinQ+re
	0zQsI7zO+oInfVBZknYeyf8Y+qvhzM4AIeC3DJpix1RM6aPC+HW8St3a/wC7omt4J0hgNS3ZshC8O
	n5AnG8ug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tEFJO-000000012TA-0oRd;
	Thu, 21 Nov 2024 22:06:06 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tEFJL-000000012SY-0sI1
	for linux-nvme@lists.infradead.org;
	Thu, 21 Nov 2024 22:06:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732226762;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=utQ/+Wialc2cpyfpIYaR/RBfZ4JfS61QRHO5uJBPAJA=;
	b=DWHhSYSGc8ldF/aNXtlpkgNHUtw3CTYGxegDTlu8I3jZqMW/PMfNjcMMQJFGT4YW4+mDVF
	uvqIVqLGKe+j8tNC0NrW61LWl3ZpBMj+gfpEA8YVHCrye/zlCEmeXuKsxPgS5PaKcGhKFs
	Yl3pe8vsAvspUNrnRto7/bRyye1WJ0c=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-358-P_uwEoMWMEerWW--V2wp_Q-1; Thu,
 21 Nov 2024 17:03:41 -0500
X-MC-Unique: P_uwEoMWMEerWW--V2wp_Q-1
X-Mimecast-MFC-AGG-ID: P_uwEoMWMEerWW--V2wp_Q
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 105EF195419F;
	Thu, 21 Nov 2024 22:03:39 +0000 (UTC)
Received: from bgurney-thinkpadp1gen5.remote.csb (unknown [10.22.65.81])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 95AC430000DF;
	Thu, 21 Nov 2024 22:03:34 +0000 (UTC)
From: Bryan Gurney <bgurney@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me,
	axboe@kernel.dk,
	mpe@ellerman.id.au,
	naveen@kernel.org,
	maddy@linux.ibm.com,
	kernel@xen0n.name
Cc: jmeneghi@redhat.com,
	bmarzins@redhat.com,
	Bryan Gurney <bgurney@redhat.com>
Subject: [PATCH 1/1] nvme: always enable multipath
Date: Thu, 21 Nov 2024 17:03:21 -0500
Message-ID: <20241121220321.40616-1-bgurney@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241121_140603_436968_8FC5873F 
X-CRM114-Status: GOOD (  24.70  )
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

Since device-mapper multipath will no longer be operating on NVMe
devices, there is no longer a need to set CONFIG_NVME_MULTIPATH=n.

Always enable NVMe multipath, remove CONFIG_NVME_MULTIPATH, and use
the code paths that would be used if CONFIG_NVME_MULTIPATH=y.

Reviewed-by: John Meneghini <jmeneghi@redhat.com>
Tested-by: Bryan Gurney <bgurney@redhat.com>
Signed-off-by: Bryan Gurney <bgurney@redhat.com>
---
 arch/loongarch/configs/loongson3_defconfig |  1 -
 arch/powerpc/configs/skiroot_defconfig     |  1 -
 drivers/nvme/host/Kconfig                  |  9 --
 drivers/nvme/host/Makefile                 |  3 +-
 drivers/nvme/host/core.c                   | 17 +---
 drivers/nvme/host/ioctl.c                  |  3 +-
 drivers/nvme/host/multipath.c              | 10 +--
 drivers/nvme/host/nvme.h                   | 97 +---------------------
 drivers/nvme/host/sysfs.c                  |  6 --
 9 files changed, 7 insertions(+), 140 deletions(-)

diff --git a/arch/loongarch/configs/loongson3_defconfig b/arch/loongarch/configs/loongson3_defconfig
index 75b366407a60..91931927645a 100644
--- a/arch/loongarch/configs/loongson3_defconfig
+++ b/arch/loongarch/configs/loongson3_defconfig
@@ -422,7 +422,6 @@ CONFIG_BLK_DEV_RAM_SIZE=8192
 CONFIG_VIRTIO_BLK=y
 CONFIG_BLK_DEV_RBD=m
 CONFIG_BLK_DEV_NVME=y
-CONFIG_NVME_MULTIPATH=y
 CONFIG_NVME_RDMA=m
 CONFIG_NVME_FC=m
 CONFIG_NVME_TCP=m
diff --git a/arch/powerpc/configs/skiroot_defconfig b/arch/powerpc/configs/skiroot_defconfig
index 9d44e6630908..10336c5796c7 100644
--- a/arch/powerpc/configs/skiroot_defconfig
+++ b/arch/powerpc/configs/skiroot_defconfig
@@ -76,7 +76,6 @@ CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=65536
 CONFIG_VIRTIO_BLK=m
 CONFIG_BLK_DEV_NVME=m
-CONFIG_NVME_MULTIPATH=y
 CONFIG_EEPROM_AT24=m
 # CONFIG_CXL is not set
 # CONFIG_OCXL is not set
diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
index 486afe598184..50505bea1ca6 100644
--- a/drivers/nvme/host/Kconfig
+++ b/drivers/nvme/host/Kconfig
@@ -14,15 +14,6 @@ config BLK_DEV_NVME
 	  To compile this driver as a module, choose M here: the
 	  module will be called nvme.
 
-config NVME_MULTIPATH
-	bool "NVMe multipath support"
-	depends on NVME_CORE
-	help
-	   This option enables support for multipath access to NVMe
-	   subsystems.  If this option is enabled only a single
-	   /dev/nvmeXnY device will show up for each NVMe namespace,
-	   even if it is accessible through multiple controllers.
-
 config NVME_VERBOSE_ERRORS
 	bool "NVMe verbose error reporting"
 	depends on NVME_CORE
diff --git a/drivers/nvme/host/Makefile b/drivers/nvme/host/Makefile
index 6414ec968f99..4a3117ec0096 100644
--- a/drivers/nvme/host/Makefile
+++ b/drivers/nvme/host/Makefile
@@ -10,10 +10,9 @@ obj-$(CONFIG_NVME_FC)			+= nvme-fc.o
 obj-$(CONFIG_NVME_TCP)			+= nvme-tcp.o
 obj-$(CONFIG_NVME_APPLE)		+= nvme-apple.o
 
-nvme-core-y				+= core.o ioctl.o sysfs.o pr.o
+nvme-core-y				+= core.o ioctl.o sysfs.o pr.o multipath.o
 nvme-core-$(CONFIG_NVME_VERBOSE_ERRORS)	+= constants.o
 nvme-core-$(CONFIG_TRACING)		+= trace.o
-nvme-core-$(CONFIG_NVME_MULTIPATH)	+= multipath.o
 nvme-core-$(CONFIG_BLK_DEV_ZONED)	+= zns.o
 nvme-core-$(CONFIG_FAULT_INJECTION_DEBUG_FS)	+= fault_inject.o
 nvme-core-$(CONFIG_NVME_HWMON)		+= hwmon.o
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index bfd71511c85f..0a71a1a5af68 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3599,9 +3599,7 @@ static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ctrl *ctrl,
 	size_t size = sizeof(*head);
 	int ret = -ENOMEM;
 
-#ifdef CONFIG_NVME_MULTIPATH
 	size += num_possible_nodes() * sizeof(struct nvme_ns *);
-#endif
 
 	head = kzalloc(size, GFP_KERNEL);
 	if (!head)
@@ -3750,14 +3748,6 @@ static int nvme_init_ns_head(struct nvme_ns *ns, struct nvme_ns_info *info)
 					info->nsid);
 			goto out_put_ns_head;
 		}
-
-		if (!multipath) {
-			dev_warn(ctrl->device,
-				"Found shared namespace %d, but multipathing not supported.\n",
-				info->nsid);
-			dev_warn_once(ctrl->device,
-				"Support for shared namespaces without CONFIG_NVME_MULTIPATH is deprecated and will be removed in Linux 6.0.\n");
-		}
 	}
 
 	list_add_tail_rcu(&ns->siblings, &head->list);
@@ -3855,11 +3845,8 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
 		sprintf(disk->disk_name, "nvme%dc%dn%d", ctrl->subsys->instance,
 			ctrl->instance, ns->head->instance);
 		disk->flags |= GENHD_FL_HIDDEN;
-	} else if (multipath) {
-		sprintf(disk->disk_name, "nvme%dn%d", ctrl->subsys->instance,
-			ns->head->instance);
 	} else {
-		sprintf(disk->disk_name, "nvme%dn%d", ctrl->instance,
+		sprintf(disk->disk_name, "nvme%dn%d", ctrl->subsys->instance,
 			ns->head->instance);
 	}
 
@@ -4457,13 +4444,11 @@ static bool nvme_handle_aen_notice(struct nvme_ctrl *ctrl, u32 result)
 			queue_work(nvme_wq, &ctrl->fw_act_work);
 		}
 		break;
-#ifdef CONFIG_NVME_MULTIPATH
 	case NVME_AER_NOTICE_ANA:
 		if (!ctrl->ana_log_buf)
 			break;
 		queue_work(nvme_wq, &ctrl->ana_work);
 		break;
-#endif
 	case NVME_AER_NOTICE_DISC_CHANGED:
 		ctrl->aen_result = result;
 		break;
diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 64b5542fb3b7..60d14084dcf1 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -676,7 +676,7 @@ int nvme_ns_chr_uring_cmd_iopoll(struct io_uring_cmd *ioucmd,
 		return blk_rq_poll(req, iob, poll_flags);
 	return 0;
 }
-#ifdef CONFIG_NVME_MULTIPATH
+
 static int nvme_ns_head_ctrl_ioctl(struct nvme_ns *ns, unsigned int cmd,
 		void __user *argp, struct nvme_ns_head *head, int srcu_idx,
 		bool open_for_write)
@@ -766,7 +766,6 @@ int nvme_ns_head_chr_uring_cmd(struct io_uring_cmd *ioucmd,
 	srcu_read_unlock(&head->srcu, srcu_idx);
 	return ret;
 }
-#endif /* CONFIG_NVME_MULTIPATH */
 
 int nvme_dev_uring_cmd(struct io_uring_cmd *ioucmd, unsigned int issue_flags)
 {
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index a85d190942bd..da7cb04a3697 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -9,11 +9,6 @@
 #include <trace/events/block.h>
 #include "nvme.h"
 
-bool multipath = true;
-module_param(multipath, bool, 0444);
-MODULE_PARM_DESC(multipath,
-	"turn on native support for multiple controllers per subsystem");
-
 static const char *nvme_iopolicy_names[] = {
 	[NVME_IOPOLICY_NUMA]	= "numa",
 	[NVME_IOPOLICY_RR]	= "round-robin",
@@ -633,7 +628,7 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
 	 * could change after a rescan.
 	 */
 	if (!(ctrl->subsys->cmic & NVME_CTRL_CMIC_MULTI_CTRL) ||
-	    !nvme_is_unique_nsid(ctrl, head) || !multipath)
+	    !nvme_is_unique_nsid(ctrl, head))
 		return 0;
 
 	blk_set_stacking_limits(&lim);
@@ -1039,8 +1034,7 @@ int nvme_mpath_init_identify(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 	int error = 0;
 
 	/* check if multipath is enabled and we have the capability */
-	if (!multipath || !ctrl->subsys ||
-	    !(ctrl->subsys->cmic & NVME_CTRL_CMIC_ANA))
+	if (!ctrl->subsys || !(ctrl->subsys->cmic & NVME_CTRL_CMIC_ANA))
 		return 0;
 
 	/* initialize this in the identify path to cover controller resets */
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 611b02c8a8b3..c9d5dc42436d 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -186,9 +186,7 @@ struct nvme_request {
 	u8			retries;
 	u8			flags;
 	u16			status;
-#ifdef CONFIG_NVME_MULTIPATH
 	unsigned long		start_time;
-#endif
 	struct nvme_ctrl	*ctrl;
 };
 
@@ -355,7 +353,6 @@ struct nvme_ctrl {
 	struct work_struct fw_act_work;
 	unsigned long events;
 
-#ifdef CONFIG_NVME_MULTIPATH
 	/* asymmetric namespace access: */
 	u8 anacap;
 	u8 anatt;
@@ -367,7 +364,6 @@ struct nvme_ctrl {
 	struct timer_list anatt_timer;
 	struct work_struct ana_work;
 	atomic_t nr_active;
-#endif
 
 #ifdef CONFIG_NVME_HOST_AUTH
 	struct work_struct dhchap_auth_work;
@@ -439,9 +435,7 @@ struct nvme_subsystem {
 	u16			vendor_id;
 	u16			awupf;	/* 0's based awupf value. */
 	struct ida		ns_ida;
-#ifdef CONFIG_NVME_MULTIPATH
 	enum nvme_iopolicy	iopolicy;
-#endif
 };
 
 /*
@@ -491,7 +485,6 @@ struct nvme_ns_head {
 	struct device		cdev_device;
 
 	struct gendisk		*disk;
-#ifdef CONFIG_NVME_MULTIPATH
 	struct bio_list		requeue_list;
 	spinlock_t		requeue_lock;
 	struct work_struct	requeue_work;
@@ -500,12 +493,11 @@ struct nvme_ns_head {
 	unsigned long		flags;
 #define NVME_NSHEAD_DISK_LIVE	0
 	struct nvme_ns __rcu	*current_path[];
-#endif
 };
 
 static inline bool nvme_ns_head_multipath(struct nvme_ns_head *head)
 {
-	return IS_ENABLED(CONFIG_NVME_MULTIPATH) && head->disk;
+	return head->disk;
 }
 
 enum nvme_ns_features {
@@ -520,10 +512,8 @@ struct nvme_ns {
 	struct nvme_ctrl *ctrl;
 	struct request_queue *queue;
 	struct gendisk *disk;
-#ifdef CONFIG_NVME_MULTIPATH
 	enum nvme_ana_state ana_state;
 	u32 ana_grpid;
-#endif
 	struct list_head siblings;
 	struct kref kref;
 	struct nvme_ns_head *head;
@@ -937,7 +927,7 @@ extern const struct block_device_operations nvme_bdev_ops;
 
 void nvme_delete_ctrl_sync(struct nvme_ctrl *ctrl);
 struct nvme_ns *nvme_find_path(struct nvme_ns_head *head);
-#ifdef CONFIG_NVME_MULTIPATH
+
 static inline bool nvme_ctrl_use_ana(struct nvme_ctrl *ctrl)
 {
 	return ctrl->ana_log_buf != NULL;
@@ -972,7 +962,6 @@ static inline void nvme_trace_bio_complete(struct request *req)
 		trace_block_bio_complete(ns->head->disk->queue, req->bio);
 }
 
-extern bool multipath;
 extern struct device_attribute dev_attr_ana_grpid;
 extern struct device_attribute dev_attr_ana_state;
 extern struct device_attribute subsys_attr_iopolicy;
@@ -981,88 +970,6 @@ static inline bool nvme_disk_is_ns_head(struct gendisk *disk)
 {
 	return disk->fops == &nvme_ns_head_ops;
 }
-#else
-#define multipath false
-static inline bool nvme_ctrl_use_ana(struct nvme_ctrl *ctrl)
-{
-	return false;
-}
-static inline void nvme_failover_req(struct request *req)
-{
-}
-static inline void nvme_kick_requeue_lists(struct nvme_ctrl *ctrl)
-{
-}
-static inline int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl,
-		struct nvme_ns_head *head)
-{
-	return 0;
-}
-static inline void nvme_mpath_add_disk(struct nvme_ns *ns, __le32 anagrpid)
-{
-}
-static inline void nvme_mpath_remove_disk(struct nvme_ns_head *head)
-{
-}
-static inline bool nvme_mpath_clear_current_path(struct nvme_ns *ns)
-{
-	return false;
-}
-static inline void nvme_mpath_revalidate_paths(struct nvme_ns *ns)
-{
-}
-static inline void nvme_mpath_clear_ctrl_paths(struct nvme_ctrl *ctrl)
-{
-}
-static inline void nvme_mpath_shutdown_disk(struct nvme_ns_head *head)
-{
-}
-static inline void nvme_trace_bio_complete(struct request *req)
-{
-}
-static inline void nvme_mpath_init_ctrl(struct nvme_ctrl *ctrl)
-{
-}
-static inline int nvme_mpath_init_identify(struct nvme_ctrl *ctrl,
-		struct nvme_id_ctrl *id)
-{
-	if (ctrl->subsys->cmic & NVME_CTRL_CMIC_ANA)
-		dev_warn(ctrl->device,
-"Please enable CONFIG_NVME_MULTIPATH for full support of multi-port devices.\n");
-	return 0;
-}
-static inline void nvme_mpath_update(struct nvme_ctrl *ctrl)
-{
-}
-static inline void nvme_mpath_uninit(struct nvme_ctrl *ctrl)
-{
-}
-static inline void nvme_mpath_stop(struct nvme_ctrl *ctrl)
-{
-}
-static inline void nvme_mpath_unfreeze(struct nvme_subsystem *subsys)
-{
-}
-static inline void nvme_mpath_wait_freeze(struct nvme_subsystem *subsys)
-{
-}
-static inline void nvme_mpath_start_freeze(struct nvme_subsystem *subsys)
-{
-}
-static inline void nvme_mpath_default_iopolicy(struct nvme_subsystem *subsys)
-{
-}
-static inline void nvme_mpath_start_request(struct request *rq)
-{
-}
-static inline void nvme_mpath_end_request(struct request *rq)
-{
-}
-static inline bool nvme_disk_is_ns_head(struct gendisk *disk)
-{
-	return false;
-}
-#endif /* CONFIG_NVME_MULTIPATH */
 
 int nvme_ns_get_unique_id(struct nvme_ns *ns, u8 id[16],
 		enum blk_unique_id type);
diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index b68a9e5f1ea3..e32f50f4d9cc 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -255,10 +255,8 @@ static struct attribute *nvme_ns_attrs[] = {
 	&dev_attr_nsid.attr,
 	&dev_attr_metadata_bytes.attr,
 	&dev_attr_nuse.attr,
-#ifdef CONFIG_NVME_MULTIPATH
 	&dev_attr_ana_grpid.attr,
 	&dev_attr_ana_state.attr,
-#endif
 	&dev_attr_io_passthru_err_log_enabled.attr,
 	NULL,
 };
@@ -282,7 +280,6 @@ static umode_t nvme_ns_attrs_are_visible(struct kobject *kobj,
 		if (!memchr_inv(ids->eui64, 0, sizeof(ids->eui64)))
 			return 0;
 	}
-#ifdef CONFIG_NVME_MULTIPATH
 	if (a == &dev_attr_ana_grpid.attr || a == &dev_attr_ana_state.attr) {
 		/* per-path attr */
 		if (nvme_disk_is_ns_head(dev_to_disk(dev)))
@@ -290,7 +287,6 @@ static umode_t nvme_ns_attrs_are_visible(struct kobject *kobj,
 		if (!nvme_ctrl_use_ana(nvme_get_ns_from_dev(dev)->ctrl))
 			return 0;
 	}
-#endif
 	return a->mode;
 }
 
@@ -860,9 +856,7 @@ static struct attribute *nvme_subsys_attrs[] = {
 	&subsys_attr_firmware_rev.attr,
 	&subsys_attr_subsysnqn.attr,
 	&subsys_attr_subsystype.attr,
-#ifdef CONFIG_NVME_MULTIPATH
 	&subsys_attr_iopolicy.attr,
-#endif
 	NULL,
 };
 
-- 
2.45.2


