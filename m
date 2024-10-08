Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32F09CF0425
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Oct 2024 20:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=A1uW3r1MFw2iBI+eBbgxCYgnvASA8P/yc+YXArJ5x0k=; b=t5gwG2Mx+icuPCgMiGi2hA5ES1
	bIXh0FDgGIgdPR3Hsu60PHS8hzkmOpm977Z1pvXSq1EFpYjfhyhIvuK1Bu1gYTL4hq3vBXsydkb1E
	/MPN4W9Pn7INYIUGMueEeBkNDLflF+DxmkiN0uTuyWEW6432Wu2DbyjiFCITYiihCQ3FKQ/jzMp89
	LVhJpVSR9etDm55rEE8YGc8oS181DZa03yjZG5aPqXUAj5wdEi8psMDIgJp7lNm5tV8rpJggNJ+yB
	iRBZEKOrfTs9laDeMmOswjEgX5wVT29SLyEI1wdfbNE9dyJfzbbzxr1H1Pe5aMvJ4kyZvi9fqUrl+
	xrJ0ZGjA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1syHJ2-000000077pB-00Vd;
	Tue, 08 Oct 2024 20:59:44 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1syH1J-000000075Tr-2pkD
	for linux-nvme@lists.infradead.org;
	Tue, 08 Oct 2024 20:41:27 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 6A6BE5C5D90;
	Tue,  8 Oct 2024 20:41:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5BE3C4CEC7;
	Tue,  8 Oct 2024 20:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728420084;
	bh=WVLXZiJGcgs+zQoiD/1RpvFYtby80gCSARDd3WBI2HA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZYnJegk1v9R5ZFYizDYHvgiQPp8PqXT+IP3cbGQOFGqzPZntkTwFZKwsL715rAlc/
	 GnmiK8zByCoNbsgE2q0H6rBFXyaINokI7+XpTsLS/Z4lLhwV5z6A5DAUqeiCCbdi7l
	 QpD1l+vpZOxy0yWCtW4ffExi2H8rlaq1X7DhZg/OEV6OvsySDd02tBEGM4eIGsoNGh
	 xL13dzMJl7cnOENjzIYmgEoZTkzvMEPttwIJepzulxgnljDUKgu8+g6aQUIgrIYcnU
	 IL2thIMnykUfvKGHPWpn6QulFrqrEs5EPt/WoogAcCJaECvbV+859meYdhRTzZYOkw
	 rO/N6qsNQFK+w==
Date: Tue, 8 Oct 2024 14:41:21 -0600
From: Keith Busch <kbusch@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/3] nvme-multipath: cannot disconnect controller on
 stuck partition scan
Message-ID: <ZwWY8d3vOLUaYaJ6@kbusch-mbp>
References: <20241007100134.21104-1-hare@kernel.org>
 <20241007100134.21104-3-hare@kernel.org>
 <ZwQmK6dZ_goSQ4Cg@kbusch-mbp>
 <47968bf9-2b98-4e5e-9040-2db6f15d86a6@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47968bf9-2b98-4e5e-9040-2db6f15d86a6@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241008_134125_831322_9BA41931 
X-CRM114-Status: GOOD (  11.61  )
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

On Tue, Oct 08, 2024 at 09:17:47AM +0200, Hannes Reinecke wrote:
> Hmm. Sadly, not really. Still stuck in partition scanning.
>
> Guess we'll need to check if we have paths available before triggering
> partition scan; let me check ...

I think you must have two paths, and the 2nd path cleared the suppress
bit before the 1st one finished its called to device_add_disk(). How
about this one?

---
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 48e7a8906d012..755495f387168 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -586,6 +586,13 @@ static void nvme_requeue_work(struct work_struct *work)
 		container_of(work, struct nvme_ns_head, requeue_work);
 	struct bio *bio, *next;
 
+	if (disk_live(head->disk) &&
+	    test_and_clear_bit(GD_SUPPRESS_PART_SCAN, &head->disk->state)) {
+		mutex_lock(&head->disk->open_mutex);
+		bdev_disk_changed(head->disk, false);
+		mutex_unlock(&head->disk->open_mutex);
+	}
+
 	spin_lock_irq(&head->requeue_lock);
 	next = bio_list_get(&head->requeue_list);
 	spin_unlock_irq(&head->requeue_lock);
@@ -629,6 +636,7 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
 		return PTR_ERR(head->disk);
 	head->disk->fops = &nvme_ns_head_ops;
 	head->disk->private_data = head;
+	set_bit(GD_SUPPRESS_PART_SCAN, &head->disk->state);
 	sprintf(head->disk->disk_name, "nvme%dn%d",
 			ctrl->subsys->instance, head->instance);
 	return 0;
--

