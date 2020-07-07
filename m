Return-Path: <SRS0=+gr8=AS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2679C433DF
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Jul 2020 10:57:46 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FC3F206DF
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Jul 2020 10:57:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BugRNEsc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FC3F206DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=0+IRQDZc4L97g3EUQ28APEQINhnEQBFDmV48+djtdFg=; b=BugRNEscRFlIbPMPs3JbL3HoI
	OrSURpy3GE4lLOHnL89V2gyukRH8PQxh+p2lpmTnps8QlhUkCJvhvlM9ZnmvH9KHfadSwBTP5L6mh
	BUW/fSUm1Dw2t5y2CRus1CzrWZMnnX1X4nCdRdgbeP0ZjeioZ2czY8GnMmzjduJEWlOTvdAfO2QXb
	l9gJCvjqm4HuNpzjVKGg0fAYr4crH1Uw4fbq+1okP/BqN8PrRGPTYWAtWplTKEavq9QtlYhtUYVzD
	Nw0WQpErVb/8UpbCWek0GpeXdXG3MflM4A08XyjDcH3Qf/p2bpURbfzif9KScdbtsnu/epjd4pY7d
	7ff07uILA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jslIG-0001B6-99; Tue, 07 Jul 2020 10:57:44 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jslIC-0001AO-Sy
 for linux-nvme@lists.infradead.org; Tue, 07 Jul 2020 10:57:42 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id DD8E1ACC3;
 Tue,  7 Jul 2020 10:57:38 +0000 (UTC)
Date: Tue, 7 Jul 2020 12:57:35 +0200
From: Anthony Iliopoulos <ailiop@suse.com>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH v2 for-5.8-rc 1/6] nvme: fix possible deadlock when I/O
 is blocked
Message-ID: <20200707105735.GA16868@technoir>
References: <20200624001853.5408-1-sagi@grimberg.me>
 <20200624001853.5408-2-sagi@grimberg.me>
 <20200624062902.GA17594@lst.de>
 <84583b2e-d59b-01bc-1737-5db107999d84@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <84583b2e-d59b-01bc-1737-5db107999d84@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200707_065741_139570_C98CFADF 
X-CRM114-Status: GOOD (  32.92  )
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
Cc: Keith Busch <kbusch@kernel.org>, Anton Eidelman <anton@lightbitslabs.com>,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Jun 23, 2020 at 11:54:31PM -0700, Sagi Grimberg wrote:
> 
> > > Revert fab7772bfbcf ("nvme-multipath: revalidate nvme_ns_head gendisk
> > > in nvme_validate_ns")
> > > 
> > > When adding a new namespace to the head disk (via nvme_mpath_set_live)
> > > we will see partition scan which triggers I/O on the mpath device node.
> > > This process will usually be triggered from the scan_work which holds
> > > the scan_lock. If I/O blocks (if we got ana change currently have only
> > > available paths but none are accessible) this can deadlock on the head
> > > disk bd_mutex as both partition scan I/O takes it, and head disk revalidation
> > > takes it to check for resize (also triggered from scan_work on a different
> > > path). See trace [1].
> > > 
> > > This is no longer needed since commit cb224c3af4df ("nvme: Convert to
> > > use set_capacity_revalidate_and_notify") which already updates resize
> > > info without unnecessarily revalidating the disk.
> > 
> > Did you look if any other revalidation gets skipped this way? E.g.
> > LBA size change?
> > 
> >  From purely the size POV this looks good, though.
> 
> The only reason the revalidate was added was to update on a size change,
> which is redundant.

The revalidation is still required there in order to update the blockdev
size when multipath is enabled. With this revert, the behavior regressed
back to before fab7772bfbcf, so the size isn't updated under multipath
when the device is in use (e.g. mounted), it will only be effectively
updated next time it is mounted as a side-effect of blkdev_open on first
opener. This prevents online resizing of filesystems.

> And if you look at revalidate, it only calls fops->revalidate_disk
> (which is a noop in the mpath device) and checks the size change.

The mpath gendisk doesn't have a revalidate_disk fop indeed, but call to
check_disk_size_change was needed to update its size. Otherwise, the
size change isn't reflected externally to userspace before next mount.
cb224c3af4df doesn't fix this as it skips revalidate and thus also skips
updating the size.

The issue is that under CONFIG_NVME_MULTIPATH=y the ns->disk becomes a
hidden gendisk (see nvme_set_disk_name) and thus doesn't have a backing
bdev, while ns->head->disk becomes the "visible" one to userspace (with
a backing bdev), and therefore needs its bdev->bd_inode->i_size updated
when resized.

The following patch seems to be working, although I'm not sufficiently
familiar with the code to tell if this won't cause any other deadlocks
with some confidence:

From 607221431d99503fa7ff0091bf6277d946ef9930 Mon Sep 17 00:00:00 2001
From: Anthony Iliopoulos <ailiop@suse.com>
Date: Tue, 7 Jul 2020 12:42:54 +0200
Subject: nvme: explicitly update mpath disk capacity on revalidation

Commit 3b4b19721ec652 ("nvme: fix possible deadlock when I/O is
blocked") reverted multipath head disk revalidation due to deadlocks
caused by holding the bd_mutex during revalidate.

Updating the multipath disk blockdev size is still required though for
userspace to be able to observe any resizing while the device is
mounted. Directly update the bdev inode size to avoid unnecessarily
holding the bdev->bd_mutex.

Fixes: 3b4b19721ec652 ("nvme: fix possible deadlock when I/O is
blocked")

Signed-off-by: Anthony Iliopoulos <ailiop@suse.com>
---
 drivers/nvme/host/core.c |  1 +
 drivers/nvme/host/nvme.h | 13 +++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 8410d03b940d74..add040168e67e2 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1980,6 +1980,7 @@ static int __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
 	if (ns->head->disk) {
 		nvme_update_disk_info(ns->head->disk, ns, id);
 		blk_queue_stack_limits(ns->head->disk->queue, ns->queue);
+		nvme_mpath_update_disk_size(ns->head->disk);
 	}
 #endif
 	return 0;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 2ef8d501e2a87c..1de3f9b827aa56 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -604,6 +604,16 @@ static inline void nvme_trace_bio_complete(struct request *req,
 		trace_block_bio_complete(ns->head->disk->queue, req->bio);
 }

+static inline void nvme_mpath_update_disk_size(struct gendisk *disk)
+{
+	struct block_device *bdev = bdget_disk(disk, 0);
+
+	if (bdev) {
+		bd_set_size(bdev, get_capacity(disk) << SECTOR_SHIFT);
+		bdput(bdev);
+	}
+}
+
 extern struct device_attribute dev_attr_ana_grpid;
 extern struct device_attribute dev_attr_ana_state;
 extern struct device_attribute subsys_attr_iopolicy;
@@ -679,6 +689,9 @@ static inline void nvme_mpath_wait_freeze(struct nvme_subsystem *subsys)
 static inline void nvme_mpath_start_freeze(struct nvme_subsystem *subsys)
 {
 }
+static inline void nvme_mpath_update_disk_size(struct gendisk *disk)
+{
+}
 #endif /* CONFIG_NVME_MULTIPATH */

 #ifdef CONFIG_NVM
--
2.27.0

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
