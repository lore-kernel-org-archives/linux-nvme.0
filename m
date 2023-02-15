Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F18BC636D4
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Feb 2023 22:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jgD2mlrjTccZ7fuHbsycdsluglpD2GBIKytal56Ai7E=; b=gPf5N0fuOKR1V3Mpa5aw0PfQhg
	guyzvBLVGqpl0stX0aAOPT2AV5TagZ/Mx3OQJ3J3m+wnJKmsthsj/QX5o9609HkQmL/nQVpVgQ1nD
	zxQCPBsI2kuS9UEiS3/Qb8xQ1aIpvY1aO3zMdlvuI5JxXUl8VHqTsKtP8lzxyvWLUuZ7rR4EDOmx0
	lSYQdQiceNkxeV61eywv/5xCso2v25V59I+cNol3mkWXwL0Mk1XhBzuYRor8V/IAa4O9E1cTdlYKg
	pYzYYcX/L3W0B4pYHFW2u8KP7rzkDnzFiAyxY9tnPJ/RKnR26RGvG5nDJtKAZjfKOdIsxc/shEwVP
	wJJxaLcQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pSQ6d-007fQ6-7s; Wed, 15 Feb 2023 22:18:27 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pSQ6Z-007fOc-Kf
	for linux-nvme@lists.infradead.org; Wed, 15 Feb 2023 22:18:25 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 77FB5B82423;
	Wed, 15 Feb 2023 22:18:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE591C433EF;
	Wed, 15 Feb 2023 22:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1676499500;
	bh=q+uqS8hy6swrhhdyVS6RT4qWc3jW7nMN8PfVdIBf9BU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q4uOzlpILdEYetY+9PJN5XE9sRMKbzEkVYHEJGY237tvxzd90H4ULAq6q9ehoam4Q
	 E6LDuaSrrqa8BmT8s/DSMXqpDUyhkMZexrMTbTEDcMeETClVmkQUqDmkERA81OYAT2
	 3vPRTgfG6ba8B6whamv3j/NRdGMhKfh+ybhfxMr1waFhd7IoXlsUt+YivuRUVdDRwM
	 qrX0AljPEsgXCZREdMRmngBPUoni51vzMDGSsstwJhdtpABusZkqewBEMoxG53B/wz
	 rhbU7LZIGxZqsm+iRHm+bfVmh5j8GwB/vZ7tBfPHDaFHVkdVMliBew/9x71/Q7pTLP
	 De+N1GL/pMizg==
Date: Wed, 15 Feb 2023 15:18:17 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Ming Lei <ming.lei@redhat.com>, John Meneghini <jmeneghi@redhat.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: nvme/pcie hot plug results in /dev name change
Message-ID: <Y+1aKcQgbskA2tra@kbusch-mbp.dhcp.thefacebook.com>
References: <472fe309-f0f9-65bf-1ad1-8a92a349e973@redhat.com>
 <Y8sKv7q+UEbz5ddD@kbusch-mbp.dhcp.thefacebook.com>
 <Y8uN4V8uW2qS+xHR@infradead.org>
 <Y9ZKNb4UKwg5zF4j@T590>
 <Y9lEF7oY+aQw2POp@kbusch-mbp.dhcp.thefacebook.com>
 <Y9nPa2ZBc80g2LcA@T590>
 <Y9oGTKCFlOscbPc2@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9oGTKCFlOscbPc2@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230215_141823_983372_0DC63A5E 
X-CRM114-Status: GOOD (  29.76  )
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

On Tue, Jan 31, 2023 at 10:27:24PM -0800, Christoph Hellwig wrote:
> On Wed, Feb 01, 2023 at 10:33:15AM +0800, Ming Lei wrote:
> > > The native nvme multipath looks like it could be leveraged to improving that
> > > user experience if we wanted to make that layer an option for non-multipath
> > > devices.
> > 
> > Can you share the basic idea? Will nvme mulitpath hold the io error and
> > not propagate to upper layer until new device is probed? What if the
> > new device is probed late, and IO has been timed out and err is returned
> > to upper layer?
> 
> Attached is what I did, but I'm really not sure it is the right final
> approach.

Just adding my proof-of-concept attempt to this below. It uses a hard-coded 10
second delay before proceeding with deletion. There may be some unlikely race
conditions with this, but the concept works. I tested mounting a single path
nvme namespace, and quick remove-add sequences while running file fio on the
filesystem. Everything proceeded seemlessly with no need to remount.

---
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 8698410aeb843..faccbd8bbb310 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3974,7 +3974,7 @@ static struct nvme_ns_head *nvme_find_ns_head(struct nvme_ctrl *ctrl,
 		 */
 		if (h->ns_id != nsid || !nvme_is_unique_nsid(ctrl, h))
 			continue;
-		if (!list_empty(&h->list) && nvme_tryget_ns_head(h))
+		if (nvme_tryget_ns_head(h))
 			return h;
 	}
 
@@ -4185,7 +4185,8 @@ static int nvme_init_ns_head(struct nvme_ns *ns, struct nvme_ns_info *info)
 		}
 	} else {
 		ret = -EINVAL;
-		if (!info->is_shared || !head->shared) {
+		if ((!info->is_shared || !head->shared) &&
+		    !list_empty(&head->list)) {
 			dev_err(ctrl->device,
 				"Duplicate unshared namespace %d\n",
 				info->nsid);
@@ -4350,8 +4351,6 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
 
 static void nvme_ns_remove(struct nvme_ns *ns)
 {
-	bool last_path = false;
-
 	if (test_and_set_bit(NVME_NS_REMOVING, &ns->flags))
 		return;
 
@@ -4371,10 +4370,6 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 
 	mutex_lock(&ns->ctrl->subsys->lock);
 	list_del_rcu(&ns->siblings);
-	if (list_empty(&ns->head->list)) {
-		list_del_init(&ns->head->entry);
-		last_path = true;
-	}
 	mutex_unlock(&ns->ctrl->subsys->lock);
 
 	/* guarantee not available in head->list */
@@ -4388,8 +4383,7 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 	list_del_init(&ns->list);
 	up_write(&ns->ctrl->namespaces_rwsem);
 
-	if (last_path)
-		nvme_mpath_shutdown_disk(ns->head);
+	nvme_mpath_shutdown_disk(ns->head);
 	nvme_put_ns(ns);
 }
 
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index fc39d01e7b63b..c74d0326b285c 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -387,7 +387,8 @@ static void nvme_ns_head_submit_bio(struct bio *bio)
 		trace_block_bio_remap(bio, disk_devt(ns->head->disk),
 				      bio->bi_iter.bi_sector);
 		submit_bio_noacct(bio);
-	} else if (nvme_available_path(head)) {
+	} else if (nvme_available_path(head) ||
+		   delayed_work_pending(&head->remove_work)) {
 		dev_warn_ratelimited(dev, "no usable path - requeuing I/O\n");
 
 		spin_lock_irq(&head->requeue_lock);
@@ -505,6 +506,23 @@ static void nvme_requeue_work(struct work_struct *work)
 	}
 }
 
+static void nvme_remove_head_work(struct work_struct *work)
+{
+	struct nvme_ns_head *head = container_of(to_delayed_work(work),
+					struct nvme_ns_head, remove_work);
+
+	if (!list_empty(&head->list))
+		return;
+
+	list_del_init(&head->entry);
+	kblockd_schedule_work(&head->requeue_work);
+	if (test_bit(NVME_NSHEAD_DISK_LIVE, &head->flags)) {
+		nvme_cdev_del(&head->cdev, &head->cdev_device);
+		del_gendisk(head->disk);
+	}
+	nvme_put_ns_head(head);
+}
+
 int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
 {
 	bool vwc = false;
@@ -513,14 +531,14 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
 	bio_list_init(&head->requeue_list);
 	spin_lock_init(&head->requeue_lock);
 	INIT_WORK(&head->requeue_work, nvme_requeue_work);
+	INIT_DELAYED_WORK(&head->remove_work, nvme_remove_head_work);
 
 	/*
 	 * Add a multipath node if the subsystems supports multiple controllers.
 	 * We also do this for private namespaces as the namespace sharing flag
 	 * could change after a rescan.
 	 */
-	if (!(ctrl->subsys->cmic & NVME_CTRL_CMIC_MULTI_CTRL) ||
-	    !nvme_is_unique_nsid(ctrl, head) || !multipath)
+	if (!nvme_is_unique_nsid(ctrl, head) || !multipath)
 		return 0;
 
 	head->disk = blk_alloc_disk(ctrl->numa_node);
@@ -553,6 +571,7 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
 	if (ctrl->vwc & NVME_CTRL_VWC_PRESENT)
 		vwc = true;
 	blk_queue_write_cache(head->disk->queue, vwc, vwc);
+	nvme_tryget_ns_head(head);
 	return 0;
 }
 
@@ -871,13 +890,9 @@ void nvme_mpath_add_disk(struct nvme_ns *ns, __le32 anagrpid)
 
 void nvme_mpath_shutdown_disk(struct nvme_ns_head *head)
 {
-	if (!head->disk)
+	if (!list_empty(&head->list) || !head->disk)
 		return;
-	kblockd_schedule_work(&head->requeue_work);
-	if (test_bit(NVME_NSHEAD_DISK_LIVE, &head->flags)) {
-		nvme_cdev_del(&head->cdev, &head->cdev_device);
-		del_gendisk(head->disk);
-	}
+	queue_delayed_work(nvme_wq, &head->remove_work, 10 * HZ);
 }
 
 void nvme_mpath_remove_disk(struct nvme_ns_head *head)
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index bf46f122e9e1e..f6d7d826cd48a 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -446,6 +446,9 @@ struct nvme_ns_head {
 	struct work_struct	requeue_work;
 	struct mutex		lock;
 	unsigned long		flags;
+
+	struct delayed_work	remove_work;
+
 #define NVME_NSHEAD_DISK_LIVE	0
 	struct nvme_ns __rcu	*current_path[];
 #endif
--

