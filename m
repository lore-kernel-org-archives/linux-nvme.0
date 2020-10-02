Return-Path: <SRS0=oqNq=DJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D238CC35257
	for <linux-nvme@archiver.kernel.org>; Fri,  2 Oct 2020 16:06:45 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E3CA206FA
	for <linux-nvme@archiver.kernel.org>; Fri,  2 Oct 2020 16:06:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="1Hz/xUjL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E3CA206FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=nvNDtWJxrZpucW9dqdABEqY0BHdYgB59BdhLuypLLq4=; b=1Hz/xUjLdK/hg08Ju9E1malMUD
	4SjxhxnWv0kmuz4GGTETZh4iAxaC19iM2ayeiylvErkgCPCkBzOXhoyg3+3Gwa6jhwqf2ys5HjjOc
	rtdWUg0G5updzLKzcqcj65S82VuSmVoGFupevCAQpYngy4JAWfXkjoOeLBXr6m/fenUNs5A3g137/
	LC16Da+zTcVgsMXZR3W+a4fAjTVZbNGCOiwpPIqO5Q4wnBLFOrQn0N3Sc5KIpGlbp4vkoaGleNTPU
	eBuOt/wW+qdY4aOyf4x436Uw8gH5ptVqbU0r4NJtXBoJZW05wc3ONYRnixf8Zgao0J2gcbHf9ZJ/r
	4qauvUKQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kONZy-0000Ca-FP; Fri, 02 Oct 2020 16:06:42 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kONZv-0000B4-KA
 for linux-nvme@lists.infradead.org; Fri, 02 Oct 2020 16:06:41 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 020FFAC65;
 Fri,  2 Oct 2020 16:06:37 +0000 (UTC)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Subject: [RFC PATCH] nvme: add 'queue_if_no_path' semantics
Date: Fri,  2 Oct 2020 18:06:34 +0200
Message-Id: <20201002160634.11821-1-hare@suse.de>
X-Mailer: git-send-email 2.16.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201002_120640_105026_F2A70F69 
X-CRM114-Status: GOOD (  22.40  )
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
Cc: linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <keith.busch@wdc.com>, Hannes Reinecke <hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Currently namespaces behave differently depending on the 'CMIC'
setting. If CMIC is zero, the device is removed once the last path
goes away. If CMIC has the multipath bit set, the device is retained
even if the last path is removed.
This is okay for fabrics, where one can do an explicit disconnect
to remove the device, but for nvme-pci this induces a regression
with PCI hotplug.
When the NVMe device is opened (eg by MD), the NVMe device is not
removed after a PCI hot-remove. Hence MD will not be notified about
the event, and will continue to consider this device as operational.
Consequently, upon PCI hot-add the device shows up as a new NVMe
device, and MD will fail to reattach the device.
So this patch adds NVME_NSHEAD_QUEUE_IF_NO_PATH flag to the nshead
to restore the original behaviour for non-fabrics NVMe devices.

Suggested-by: Keith Busch <keith.busch@wdc.com>
Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/core.c      | 42 ++++++++++++++++++++++++++++++++++-
 drivers/nvme/host/multipath.c |  5 ++++-
 drivers/nvme/host/nvme.h      |  3 ++-
 3 files changed, 47 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 385b10317873..87589f0adea3 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -474,7 +474,11 @@ static void nvme_free_ns_head(struct kref *ref)
 	struct nvme_ns_head *head =
 		container_of(ref, struct nvme_ns_head, ref);
 
-	nvme_mpath_remove_disk(head);
+	if (head->disk) {
+		if (test_bit(NVME_NSHEAD_QUEUE_IF_NO_PATH, &head->flags))
+			nvme_mpath_remove_disk(head);
+		put_disk(head->disk);
+	}
 	ida_simple_remove(&head->subsys->ns_ida, head->instance);
 	cleanup_srcu_struct(&head->srcu);
 	nvme_put_subsystem(head->subsys);
@@ -3345,12 +3349,42 @@ static ssize_t nsid_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RO(nsid);
 
+static ssize_t queue_if_no_path_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct nvme_ns_head *head = dev_to_ns_head(dev);
+
+	return sprintf(buf, "%s\n",
+		       test_bit(NVME_NSHEAD_QUEUE_IF_NO_PATH, &head->flags) ?
+		       "on" : "off");
+}
+
+static ssize_t queue_if_no_path_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct nvme_ns_head *head = dev_to_ns_head(dev);
+	int queue_if_no_path, err;
+
+	err = kstrtoint(buf, 10, &queue_if_no_path);
+	if (err)
+		return -EINVAL;
+
+	else if (queue_if_no_path <= 0)
+		clear_bit(NVME_NSHEAD_QUEUE_IF_NO_PATH, &head->flags);
+	else
+		set_bit(NVME_NSHEAD_QUEUE_IF_NO_PATH, &head->flags);
+	return count;
+}
+static DEVICE_ATTR(queue_if_no_path, S_IRUGO | S_IWUSR,
+	queue_if_no_path_show, queue_if_no_path_store);
+
 static struct attribute *nvme_ns_id_attrs[] = {
 	&dev_attr_wwid.attr,
 	&dev_attr_uuid.attr,
 	&dev_attr_nguid.attr,
 	&dev_attr_eui.attr,
 	&dev_attr_nsid.attr,
+	&dev_attr_queue_if_no_path.attr,
 #ifdef CONFIG_NVME_MULTIPATH
 	&dev_attr_ana_grpid.attr,
 	&dev_attr_ana_state.attr,
@@ -3377,6 +3411,10 @@ static umode_t nvme_ns_id_attrs_are_visible(struct kobject *kobj,
 		if (!memchr_inv(ids->eui64, 0, sizeof(ids->eui64)))
 			return 0;
 	}
+	if (a == &dev_attr_queue_if_no_path.attr) {
+		if (dev_to_disk(dev)->fops == &nvme_fops)
+			return 0;
+	}
 #ifdef CONFIG_NVME_MULTIPATH
 	if (a == &dev_attr_ana_grpid.attr || a == &dev_attr_ana_state.attr) {
 		if (dev_to_disk(dev)->fops != &nvme_fops) /* per-path attr */
@@ -3685,6 +3723,8 @@ static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ctrl *ctrl,
 	head->subsys = ctrl->subsys;
 	head->ns_id = nsid;
 	head->ids = *ids;
+	if (ctrl->ops->flags & NVME_F_FABRICS)
+		set_bit(NVME_NSHEAD_QUEUE_IF_NO_PATH, &head->flags);
 	kref_init(&head->ref);
 
 	ret = __nvme_check_ids(ctrl->subsys, head);
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 74896be40c17..05c4fbc35bb2 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -682,6 +682,10 @@ void nvme_mpath_remove_disk(struct nvme_ns_head *head)
 {
 	if (!head->disk)
 		return;
+	if (test_bit(NVME_NSHEAD_QUEUE_IF_NO_PATH, &head->flags)) {
+		kblockd_schedule_work(&head->requeue_work);
+		return;
+	}
 	if (head->disk->flags & GENHD_FL_UP)
 		del_gendisk(head->disk);
 	blk_set_queue_dying(head->disk->queue);
@@ -697,7 +701,6 @@ void nvme_mpath_remove_disk(struct nvme_ns_head *head)
 		 */
 		head->disk->queue = NULL;
 	}
-	put_disk(head->disk);
 }
 
 int nvme_mpath_init(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 566776100126..baf4a84918d8 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -411,6 +411,7 @@ struct nvme_ns_head {
 	struct mutex		lock;
 	unsigned long		flags;
 #define NVME_NSHEAD_DISK_LIVE	0
+#define NVME_NSHEAD_QUEUE_IF_NO_PATH 1
 	struct nvme_ns __rcu	*current_path[];
 #endif
 };
@@ -670,7 +671,7 @@ static inline void nvme_mpath_check_last_path(struct nvme_ns *ns)
 	struct nvme_ns_head *head = ns->head;
 
 	if (head->disk && list_empty(&head->list))
-		kblockd_schedule_work(&head->requeue_work);
+		nvme_mpath_remove_disk(head);
 }
 
 static inline void nvme_trace_bio_complete(struct request *req,
-- 
2.26.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
