Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D53A9CEE33A
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Oct 2024 17:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zKSI3/S8uBAtmeuGZhHtYuUgaL3iuX2ougucoXIgIAg=; b=10uGfqNTbDoB617ptBJk1ydYH7
	zKcVqtYgfMCbgujG9W+NgNERYzxh0RzwYLCM+Zb5dzfDomJuLb1wY2AR5Ztk0OLeq8xZ/Sx14pcGP
	k+fC7a1xngz2VCO7zdxIYzw9u5ewmrX33TjBoD+yu5TyHRvYJX8NoXaH1g75R39cV1n18LgfwACeh
	HELhtK2MC0g5SDJXZZTAgs5KkMbbRaBJZUh2Wk1D1GaPJZztM0J0ed3iE4uTLZcP7QJcXSL1WRWzJ
	pOSycEub/hNUXGMJRx+kOBLjamRERvMzisqnXL2Z8AHbAtGeb7vfpgmHNZik182X87x+SYjWpHjYR
	+ozX591w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1syar5-0000000AHBU-3GLO;
	Wed, 09 Oct 2024 17:52:11 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1syaYD-0000000ABf2-0cWf
	for linux-nvme@bombadil.infradead.org;
	Wed, 09 Oct 2024 17:32:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=zKSI3/S8uBAtmeuGZhHtYuUgaL3iuX2ougucoXIgIAg=; b=JSGmqa1eG3h4YIt+XPbsQxLds6
	QPgv65Gg47pZ4MFce/BifbOwA7G7d1E5EEDDIh7UhrAzkvXs2Ex1IvroGVwT5M/lAcAOhWJxzGK4F
	FlRNoT+C8sY7gYuLm2ixQU/6ND4Tf6oDhpVBZN8WNL0A2CwSpueL4RwsYju2NF10eTwtEN62BUiPx
	Q56A7tmFfRERZYOlq15I6U4rILx0oxfXkacRA+vRqxScXjXFhwIoajPKTeFTfzJtgfw4v2CKz29d6
	QlwPOVIxcQriiNoPn1jXHiPVCCSm1KZTmGwpQPKVplqmWtsT4S9Er/VEWWY8A+sA7tVJ74ktL5Gb0
	KBvrRyPw==;
Received: from nyc.source.kernel.org ([147.75.193.91])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1syaY9-000000053cz-1jRO
	for linux-nvme@lists.infradead.org;
	Wed, 09 Oct 2024 17:32:39 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 47CF1A443B7;
	Wed,  9 Oct 2024 17:32:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29E2DC4CEC3;
	Wed,  9 Oct 2024 17:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728495155;
	bh=mq42HDtRTA1CK6eKSiX9gN1PrYEs5GFFmGBytKQcSYM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oAz+U6Akcc9HiBvCJWaHe+XGm3jKgKCVKy0KkZQm2BSVEk0U0oNbLC25umx/5TauE
	 eCqi+R+DtSeKuTDlNcLQtD4bX+3zuiaUYD9gGQCUNQugl+JH6TYA4rQ/E4WxyjR7ja
	 sX13VT0Zs4AeyvssxqFvb8X7qh8pkC8aC3E1VVJ3lKqXnBtXWoo7wJM8T8zPIesrMd
	 nyFVIIUntpoitQmNDtfFZy+xG57+juZPJoolJtEFLouDyHo2Lwj/JiSagetP8l3NwU
	 PbA1xr92nlZXcmNzV/DUFv93uniErqL8jY4FhfZKntkiOXgaVm0fnv5L/V1kpAPN1f
	 YnrYmGS2MwlCA==
Date: Wed, 9 Oct 2024 11:32:32 -0600
From: Keith Busch <kbusch@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/3] nvme-multipath: cannot disconnect controller on
 stuck partition scan
Message-ID: <Zwa-MBS6wn_dGxge@kbusch-mbp>
References: <20241007100134.21104-1-hare@kernel.org>
 <20241007100134.21104-3-hare@kernel.org>
 <ZwQmK6dZ_goSQ4Cg@kbusch-mbp>
 <47968bf9-2b98-4e5e-9040-2db6f15d86a6@suse.de>
 <ZwWY8d3vOLUaYaJ6@kbusch-mbp>
 <3b8ff898-9529-4506-8c5d-0fcf3423730f@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b8ff898-9529-4506-8c5d-0fcf3423730f@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241009_183238_523642_225816BA 
X-CRM114-Status: GOOD (  16.23  )
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

On Wed, Oct 09, 2024 at 08:23:45AM +0200, Hannes Reinecke wrote:
> With my testcase _all_ paths return NS_NOT_READY during partition scan, so
> I/O is constantly bounced between paths, and partition scan never returns.
> Doesn't matter where you call it, it's stuck.

Assuming you mean a differet status, like NVME_SC_INTERNAL_PATH_ERROR, I
can recreate a stuck scan. Let me get one more shot at fixing this by
suppressing the scan to another context. This one is successful in my
tests:

---
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 48e7a8906d012..e1fd53ff2c0ca 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -580,6 +580,20 @@ static int nvme_add_ns_head_cdev(struct nvme_ns_head *head)
 	return ret;
 }
 
+static void nvme_scan_work(struct work_struct *work)
+{
+	struct nvme_ns_head *head =
+		container_of(work, struct nvme_ns_head, scan_work);
+
+	if (WARN_ON_ONCE(!test_and_clear_bit(GD_SUPPRESS_PART_SCAN,
+					     &head->disk->state)))
+		return;
+
+	mutex_lock(&head->disk->open_mutex);
+	bdev_disk_changed(head->disk, false);
+	mutex_unlock(&head->disk->open_mutex);
+}
+
 static void nvme_requeue_work(struct work_struct *work)
 {
 	struct nvme_ns_head *head =
@@ -606,6 +620,7 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
 	bio_list_init(&head->requeue_list);
 	spin_lock_init(&head->requeue_lock);
 	INIT_WORK(&head->requeue_work, nvme_requeue_work);
+	INIT_WORK(&head->scan_work, nvme_scan_work);
 
 	/*
 	 * Add a multipath node if the subsystems supports multiple controllers.
@@ -629,6 +644,7 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
 		return PTR_ERR(head->disk);
 	head->disk->fops = &nvme_ns_head_ops;
 	head->disk->private_data = head;
+	set_bit(GD_SUPPRESS_PART_SCAN, &head->disk->state);
 	sprintf(head->disk->disk_name, "nvme%dn%d",
 			ctrl->subsys->instance, head->instance);
 	return 0;
@@ -655,6 +671,7 @@ static void nvme_mpath_set_live(struct nvme_ns *ns)
 			return;
 		}
 		nvme_add_ns_head_cdev(head);
+		kblockd_schedule_work(&head->scan_work);
 	}
 
 	mutex_lock(&head->lock);
@@ -974,14 +991,14 @@ void nvme_mpath_shutdown_disk(struct nvme_ns_head *head)
 		return;
 	if (test_and_clear_bit(NVME_NSHEAD_DISK_LIVE, &head->flags)) {
 		nvme_cdev_del(&head->cdev, &head->cdev_device);
+		/*
+		 * requeue I/O after NVME_NSHEAD_DISK_LIVE has been cleared
+		 * to allow multipath to fail all I/O.
+		 */
+		synchronize_srcu(&head->srcu);
+		kblockd_schedule_work(&head->requeue_work);
 		del_gendisk(head->disk);
 	}
-	/*
-	 * requeue I/O after NVME_NSHEAD_DISK_LIVE has been cleared
-	 * to allow multipath to fail all I/O.
-	 */
-	synchronize_srcu(&head->srcu);
-	kblockd_schedule_work(&head->requeue_work);
 }
 
 void nvme_mpath_remove_disk(struct nvme_ns_head *head)
@@ -991,6 +1008,7 @@ void nvme_mpath_remove_disk(struct nvme_ns_head *head)
 	/* make sure all pending bios are cleaned up */
 	kblockd_schedule_work(&head->requeue_work);
 	flush_work(&head->requeue_work);
+	flush_work(&head->scan_work);
 	put_disk(head->disk);
 }
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 313a4f978a2cf..ff3d092dbdb6d 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -494,6 +494,7 @@ struct nvme_ns_head {
 	struct bio_list		requeue_list;
 	spinlock_t		requeue_lock;
 	struct work_struct	requeue_work;
+	struct work_struct	scan_work;
 	struct mutex		lock;
 	unsigned long		flags;
 #define NVME_NSHEAD_DISK_LIVE	0
--

