Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3E09C001DE
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Jul 2023 08:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8IvbEBqPk8sCSKcEBjf4lvMB3H85zpLTy8Do46JoVas=; b=Oia2WYjlFc++jvX9+nwX1AkT7g
	P5iBwVV3NzebT+Q+QiOtuVAGrADX8efP22OrBMahW4RX4rq5WrsvyfquMsZaNHAGI1PrD+5geEc1Z
	WkHKmxijWSo/WizBsKONb50ldbTN0Ayiw63nRa/Hfvbl/t0DIbNx1S7KvLkvPVFs5e3yel+4mK/Nc
	lAbCcOtm/V2cM0qEtuQ04+dLlZY5I6LBf66tT88uyeNHzlc9wIe8lbBvUcRnDia+TOBYVk92Iviqc
	sSbmtbLvj2b5t37IdmUhRKUfIlQatWXrcXfxTx8n1CTXZXLcxhmZzur72vqWuPtII6IVqu9zu0CcC
	o7xmkwdA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qM2ky-006Qjy-1n;
	Wed, 19 Jul 2023 08:42:00 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qM2ku-006Qdg-1S
	for linux-nvme@lists.infradead.org;
	Wed, 19 Jul 2023 08:41:58 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5AE7E1FD6C;
	Wed, 19 Jul 2023 08:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1689756112; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8IvbEBqPk8sCSKcEBjf4lvMB3H85zpLTy8Do46JoVas=;
	b=CkwhdIDepAf0o4Teo7Oyf8KwuOQHN5W3XsyCt9D5+Mk4qnMQcnwlzsypATQVyQh4++hrry
	AK9E+OT68TfxOESCmdlnDZ37Fu9la8WlQwQn0aeZarEf+HptAKuDbfcil4SLSvUlp8ZvFD
	szP0e9+8eZ1FwNOcIjRARsQ3II1C0AY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1689756112;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8IvbEBqPk8sCSKcEBjf4lvMB3H85zpLTy8Do46JoVas=;
	b=k9mRFgqDPTSNzw0WFNl3DJ4m/UsB9NG1RGMEh+1YtzgP5gxLUGMWI15NSeZlLKjfDq1Pir
	dROvNUHAo5aekzAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4CDBF1361C;
	Wed, 19 Jul 2023 08:41:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id PQCsEtCht2R8BQAAMHmgww
	(envelope-from <dwagner@suse.de>); Wed, 19 Jul 2023 08:41:52 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v1 1/2] nvme: drop multipath config option
Date: Wed, 19 Jul 2023 10:41:46 +0200
Message-ID: <20230719084147.16272-2-dwagner@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230719084147.16272-1-dwagner@suse.de>
References: <20230719084147.16272-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230719_014156_634459_BD212354 
X-CRM114-Status: GOOD (  22.19  )
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

Commit ce8d78616a6b ("nvme: warn about shared namespaces without
CONFIG_NVME_MULTIPATH") added the message that CONFIG_NVME_MULTIPATH
is going to be removed with 6.0. As we are past this point, let's
remove the option.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/host/Kconfig  |  9 ----
 drivers/nvme/host/Makefile |  4 +-
 drivers/nvme/host/core.c   |  9 +---
 drivers/nvme/host/ioctl.c  |  2 -
 drivers/nvme/host/nvme.h   | 92 +-------------------------------------
 drivers/nvme/host/pr.c     |  3 +-
 drivers/nvme/host/sysfs.c  |  6 ---
 7 files changed, 5 insertions(+), 120 deletions(-)

diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
index 2f6a7f8c94e8..155b326ddf7e 100644
--- a/drivers/nvme/host/Kconfig
+++ b/drivers/nvme/host/Kconfig
@@ -15,15 +15,6 @@ config BLK_DEV_NVME
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
index c7c3cf202d12..86b3304aee26 100644
--- a/drivers/nvme/host/Makefile
+++ b/drivers/nvme/host/Makefile
@@ -10,10 +10,10 @@ obj-$(CONFIG_NVME_FC)			+= nvme-fc.o
 obj-$(CONFIG_NVME_TCP)			+= nvme-tcp.o
 obj-$(CONFIG_NVME_APPLE)		+= nvme-apple.o
 
-nvme-core-y				+= core.o ioctl.o sysfs.o pr.o
+nvme-core-y				+= core.o ioctl.o sysfs.o pr.o \
+					multipath.o
 nvme-core-$(CONFIG_NVME_VERBOSE_ERRORS)	+= constants.o
 nvme-core-$(CONFIG_TRACING)		+= trace.o
-nvme-core-$(CONFIG_NVME_MULTIPATH)	+= multipath.o
 nvme-core-$(CONFIG_BLK_DEV_ZONED)	+= zns.o
 nvme-core-$(CONFIG_FAULT_INJECTION_DEBUG_FS)	+= fault_inject.o
 nvme-core-$(CONFIG_NVME_HWMON)		+= hwmon.o
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 37b6fa746662..d08371967ce3 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3348,9 +3348,7 @@ static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ctrl *ctrl,
 	size_t size = sizeof(*head);
 	int ret = -ENOMEM;
 
-#ifdef CONFIG_NVME_MULTIPATH
 	size += num_possible_nodes() * sizeof(struct nvme_ns *);
-#endif
 
 	head = kzalloc(size, GFP_KERNEL);
 	if (!head)
@@ -3497,13 +3495,10 @@ static int nvme_init_ns_head(struct nvme_ns *ns, struct nvme_ns_info *info)
 			goto out_put_ns_head;
 		}
 
-		if (!multipath) {
+		if (!multipath)
 			dev_warn(ctrl->device,
 				"Found shared namespace %d, but multipathing not supported.\n",
 				info->nsid);
-			dev_warn_once(ctrl->device,
-				"Support for shared namespaces without CONFIG_NVME_MULTIPATH is deprecated and will be removed in Linux 6.0\n.");
-		}
 	}
 
 	list_add_tail_rcu(&ns->siblings, &head->list);
@@ -4124,13 +4119,11 @@ static bool nvme_handle_aen_notice(struct nvme_ctrl *ctrl, u32 result)
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
index 5c3250f36ce7..e3603644fbdd 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -793,7 +793,6 @@ int nvme_ns_chr_uring_cmd_iopoll(struct io_uring_cmd *ioucmd,
 	rcu_read_unlock();
 	return ret;
 }
-#ifdef CONFIG_NVME_MULTIPATH
 static int nvme_ns_head_ctrl_ioctl(struct nvme_ns *ns, unsigned int cmd,
 		void __user *argp, struct nvme_ns_head *head, int srcu_idx,
 		bool open_for_write)
@@ -883,7 +882,6 @@ int nvme_ns_head_chr_uring_cmd(struct io_uring_cmd *ioucmd,
 	srcu_read_unlock(&head->srcu, srcu_idx);
 	return ret;
 }
-#endif /* CONFIG_NVME_MULTIPATH */
 
 int nvme_dev_uring_cmd(struct io_uring_cmd *ioucmd, unsigned int issue_flags)
 {
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index f35647c470af..c7ccab60cf47 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -169,9 +169,7 @@ struct nvme_request {
 	u8			retries;
 	u8			flags;
 	u16			status;
-#ifdef CONFIG_NVME_MULTIPATH
 	unsigned long		start_time;
-#endif
 	struct nvme_ctrl	*ctrl;
 };
 
@@ -336,7 +334,6 @@ struct nvme_ctrl {
 	struct work_struct fw_act_work;
 	unsigned long events;
 
-#ifdef CONFIG_NVME_MULTIPATH
 	/* asymmetric namespace access: */
 	u8 anacap;
 	u8 anatt;
@@ -347,7 +344,6 @@ struct nvme_ctrl {
 	size_t ana_log_size;
 	struct timer_list anatt_timer;
 	struct work_struct ana_work;
-#endif
 
 #ifdef CONFIG_NVME_AUTH
 	struct work_struct dhchap_auth_work;
@@ -412,9 +408,7 @@ struct nvme_subsystem {
 	u16			vendor_id;
 	u16			awupf;	/* 0's based awupf value. */
 	struct ida		ns_ida;
-#ifdef CONFIG_NVME_MULTIPATH
 	enum nvme_iopolicy	iopolicy;
-#endif
 };
 
 /*
@@ -450,7 +444,6 @@ struct nvme_ns_head {
 	struct device		cdev_device;
 
 	struct gendisk		*disk;
-#ifdef CONFIG_NVME_MULTIPATH
 	struct bio_list		requeue_list;
 	spinlock_t		requeue_lock;
 	struct work_struct	requeue_work;
@@ -458,12 +451,11 @@ struct nvme_ns_head {
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
@@ -478,10 +470,8 @@ struct nvme_ns {
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
@@ -874,7 +864,6 @@ extern const struct block_device_operations nvme_bdev_ops;
 
 void nvme_delete_ctrl_sync(struct nvme_ctrl *ctrl);
 struct nvme_ns *nvme_find_path(struct nvme_ns_head *head);
-#ifdef CONFIG_NVME_MULTIPATH
 static inline bool nvme_ctrl_use_ana(struct nvme_ctrl *ctrl)
 {
 	return ctrl->ana_log_buf != NULL;
@@ -914,85 +903,6 @@ extern struct device_attribute dev_attr_ana_grpid;
 extern struct device_attribute dev_attr_ana_state;
 extern struct device_attribute subsys_attr_iopolicy;
 
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
-#endif /* CONFIG_NVME_MULTIPATH */
-
 int nvme_revalidate_zones(struct nvme_ns *ns);
 int nvme_ns_report_zones(struct nvme_ns *ns, sector_t sector,
 		unsigned int nr_zones, report_zones_cb cb, void *data);
diff --git a/drivers/nvme/host/pr.c b/drivers/nvme/host/pr.c
index 391b1465ebfd..fa2ec916a762 100644
--- a/drivers/nvme/host/pr.c
+++ b/drivers/nvme/host/pr.c
@@ -97,8 +97,7 @@ static int nvme_sc_to_pr_err(int nvme_sc)
 static int nvme_send_pr_command(struct block_device *bdev,
 		struct nvme_command *c, void *data, unsigned int data_len)
 {
-	if (IS_ENABLED(CONFIG_NVME_MULTIPATH) &&
-	    bdev->bd_disk->fops == &nvme_ns_head_ops)
+	if (bdev->bd_disk->fops == &nvme_ns_head_ops)
 		return nvme_send_ns_head_pr_command(bdev, c, data, data_len);
 
 	return nvme_send_ns_pr_command(bdev->bd_disk->private_data, c, data,
diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index 212e1b05d298..47aef949c271 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -120,10 +120,8 @@ static struct attribute *nvme_ns_id_attrs[] = {
 	&dev_attr_nguid.attr,
 	&dev_attr_eui.attr,
 	&dev_attr_nsid.attr,
-#ifdef CONFIG_NVME_MULTIPATH
 	&dev_attr_ana_grpid.attr,
 	&dev_attr_ana_state.attr,
-#endif
 	NULL,
 };
 
@@ -146,14 +144,12 @@ static umode_t nvme_ns_id_attrs_are_visible(struct kobject *kobj,
 		if (!memchr_inv(ids->eui64, 0, sizeof(ids->eui64)))
 			return 0;
 	}
-#ifdef CONFIG_NVME_MULTIPATH
 	if (a == &dev_attr_ana_grpid.attr || a == &dev_attr_ana_state.attr) {
 		if (dev_to_disk(dev)->fops != &nvme_bdev_ops) /* per-path attr */
 			return 0;
 		if (!nvme_ctrl_use_ana(nvme_get_ns_from_dev(dev)->ctrl))
 			return 0;
 	}
-#endif
 	return a->mode;
 }
 
@@ -652,9 +648,7 @@ static struct attribute *nvme_subsys_attrs[] = {
 	&subsys_attr_firmware_rev.attr,
 	&subsys_attr_subsysnqn.attr,
 	&subsys_attr_subsystype.attr,
-#ifdef CONFIG_NVME_MULTIPATH
 	&subsys_attr_iopolicy.attr,
-#endif
 	NULL,
 };
 
-- 
2.41.0


