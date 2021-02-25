Return-Path: <SRS0=GtbF=H3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37622C433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Feb 2021 11:05:56 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C12F664F0F
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Feb 2021 11:05:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C12F664F0F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=VQ/0Cixpj0bOuQUNYEAdl2VPdc2ZZdZZ91Pf9P9jg7Q=; b=20/6IDgry7YsrNryn/9tO4HPC
	9+OLEqf1E0RDbjjIq696cBMBm9GE25J28IAUXxl+WREX8Bm0XHnYPRdEdFIKEAS7Z5Gzj1LfRQG3k
	+W/x7f76LrvDMfzCewAes7Uph+MtycTrUG+/wjvQzBSzFdEAdzTmqj3O1xMIqcAQOsvY4wHjTZZf5
	uUil6Bfsy85Vh0PPsXIGm9FVL2hTEAwkFHOZzz07TjdloaDbmD9VHvCLMHYlT8/Crz46EoCj+qvlU
	Tk1Zlt5/3OFSk5LJrI85p5VTzWLovFgEOA94TeX2T94xEZ3t/cxo2CheIr/3lxVcEpaXn+tVn7sxa
	10rdRlkeA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lFESl-0007Ma-8F; Thu, 25 Feb 2021 11:05:43 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lFESf-0007KV-IG
 for linux-nvme@lists.infradead.org; Thu, 25 Feb 2021 11:05:39 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 64397AC6E;
 Thu, 25 Feb 2021 11:05:36 +0000 (UTC)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 2/2] nvme: delete disk when last path is gone
Date: Thu, 25 Feb 2021 12:05:34 +0100
Message-Id: <20210225110534.75710-3-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210225110534.75710-1-hare@suse.de>
References: <20210225110534.75710-1-hare@suse.de>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210225_060537_853550_6EF4AF03 
X-CRM114-Status: GOOD (  22.16  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 Hannes Reinecke <hare@suse.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The multipath code currently deletes the disk only after all references
to it are dropped rather than when the last path to that disk is lost.
This differs from the behaviour in the non-multipathed case where the
disk is deleted once the controller is removed.
This has been reported to cause problems with some use cases like MD RAID.

This patch implements an alternative behaviour of deleting the disk when
the last path is gone, ie the same behaviour as non-multipathed nvme
devices. The alternative behaviour can be enabled with the new sysfs
attribute 'no_path_detach'.

Suggested-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/core.c      |  9 ++++++++-
 drivers/nvme/host/multipath.c | 31 ++++++++++++++++++++++++++++++-
 drivers/nvme/host/nvme.h      | 21 ++++++++++++++++++---
 3 files changed, 56 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index ba639049e385..7af6ba18f461 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -541,7 +541,9 @@ static void nvme_free_ns_head(struct kref *ref)
 	struct nvme_ns_head *head =
 		container_of(ref, struct nvme_ns_head, ref);
 
-	nvme_mpath_remove_disk(head);
+	if (!test_bit(NVME_NSHEAD_NO_PATH_DETACH, &head->flags))
+		nvme_mpath_remove_disk(head);
+	nvme_mpath_put_disk(head);
 	ida_simple_remove(&head->subsys->ns_ida, head->instance);
 	cleanup_srcu_struct(&head->srcu);
 	nvme_put_subsystem(head->subsys);
@@ -3464,6 +3466,7 @@ static struct attribute *nvme_ns_id_attrs[] = {
 #ifdef CONFIG_NVME_MULTIPATH
 	&dev_attr_ana_grpid.attr,
 	&dev_attr_ana_state.attr,
+	&dev_attr_no_path_detach.attr,
 #endif
 	NULL,
 };
@@ -3494,6 +3497,10 @@ static umode_t nvme_ns_id_attrs_are_visible(struct kobject *kobj,
 		if (!nvme_ctrl_use_ana(nvme_get_ns_from_dev(dev)->ctrl))
 			return 0;
 	}
+	if (a == &dev_attr_no_path_detach.attr) {
+		if (dev_to_disk(dev)->fops == &nvme_bdev_ops)
+			return 0;
+	}
 #endif
 	return a->mode;
 }
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 0696319adaf6..7d38f9272490 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -641,6 +641,36 @@ static ssize_t ana_state_show(struct device *dev, struct device_attribute *attr,
 }
 DEVICE_ATTR_RO(ana_state);
 
+static ssize_t no_path_detach_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct gendisk *disk = dev_to_disk(dev);
+	struct nvme_ns_head *head = disk->private_data;
+
+	return sprintf(buf, "%d\n",
+		       test_bit(NVME_NSHEAD_NO_PATH_DETACH, &head->flags) ?
+		       1 : 0);
+}
+
+static ssize_t no_path_detach_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct gendisk *disk = dev_to_disk(dev);
+	struct nvme_ns_head *head = disk->private_data;
+	int err, no_path_detach;
+
+	err = kstrtoint(buf, 10, &no_path_detach);
+	if (err || no_path_detach < 0)
+		return -EINVAL;
+	if (no_path_detach)
+		set_bit(NVME_NSHEAD_NO_PATH_DETACH, &head->flags);
+	else
+		clear_bit(NVME_NSHEAD_NO_PATH_DETACH, &head->flags);
+	return count;
+}
+DEVICE_ATTR(no_path_detach, S_IRUGO | S_IWUSR,
+	no_path_detach_show, no_path_detach_store);
+
 static int nvme_lookup_ana_group_desc(struct nvme_ctrl *ctrl,
 		struct nvme_ana_group_desc *desc, void *data)
 {
@@ -702,7 +732,6 @@ void nvme_mpath_remove_disk(struct nvme_ns_head *head)
 		 */
 		head->disk->queue = NULL;
 	}
-	put_disk(head->disk);
 }
 
 int nvme_mpath_init(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 07b34175c6ce..317f8a6cb7f4 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -417,7 +417,8 @@ struct nvme_ns_head {
 	struct work_struct	requeue_work;
 	struct mutex		lock;
 	unsigned long		flags;
-#define NVME_NSHEAD_DISK_LIVE	0
+#define NVME_NSHEAD_DISK_LIVE		0
+#define NVME_NSHEAD_NO_PATH_DETACH	1
 	struct nvme_ns __rcu	*current_path[];
 #endif
 };
@@ -680,8 +681,12 @@ static inline void nvme_mpath_check_last_path(struct nvme_ns *ns)
 {
 	struct nvme_ns_head *head = ns->head;
 
-	if (head->disk && list_empty(&head->list))
-		kblockd_schedule_work(&head->requeue_work);
+	if (head->disk && list_empty(&head->list)) {
+		if (test_bit(NVME_NSHEAD_NO_PATH_DETACH, &head->flags))
+			nvme_mpath_remove_disk(head);
+		else
+			kblockd_schedule_work(&head->requeue_work);
+	}
 }
 
 static inline void nvme_trace_bio_complete(struct request *req)
@@ -692,8 +697,15 @@ static inline void nvme_trace_bio_complete(struct request *req)
 		trace_block_bio_complete(ns->head->disk->queue, req->bio);
 }
 
+static inline void nvme_mpath_put_disk(struct nvme_ns_head *head)
+{
+	if (head->disk)
+		put_disk(head->disk);
+}
+
 extern struct device_attribute dev_attr_ana_grpid;
 extern struct device_attribute dev_attr_ana_state;
+extern struct device_attribute dev_attr_no_path_detach;
 extern struct device_attribute subsys_attr_iopolicy;
 
 #else
@@ -729,6 +741,9 @@ static inline void nvme_mpath_add_disk(struct nvme_ns *ns,
 static inline void nvme_mpath_remove_disk(struct nvme_ns_head *head)
 {
 }
+static inline void nvme_mpath_put_disk(struct nvme_ns_head *head)
+{
+}
 static inline bool nvme_mpath_clear_current_path(struct nvme_ns *ns)
 {
 	return false;
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
