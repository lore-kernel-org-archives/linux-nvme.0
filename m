Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EECBDC4332F
	for <linux-nvme@archiver.kernel.org>; Sun, 25 Dec 2022 07:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=twAXp15EP92U8CY+1GARtaxT1yyqVN5KY/uqb5CNqGE=; b=VdSt+RZYScw1zS4vc0BXxxj8TN
	OJDL1PKDLEyFM1DDcIwpFk8Xf06JKHDkONzrVyaPuMVBgvdM5K0uNKKhHHywDKBTAm7rcS7k7DGze
	R9AlF++FW7Zd8ob4clH0C5dtQuNcekKvrqXpIRiLaHBeCzeMDaTGcFUMU277tqnCYxydCjnh4YVN9
	0aIhFjKNkqUkFdv5KfBm4YYnx0INi9jEfqUgo3B6uB9OrftxfTkBSxqJmSEx64mkbLkpW1t41o0yJ
	0L8xyz7JP3i25J0xowEsdG/xbsVRyo5xRDd+jfIGD+5mhmNGe4UXUvs0RdwSyQ9OSNUS3frryrBzj
	O00xVTYA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p9LGE-008Nuf-HZ; Sun, 25 Dec 2022 07:17:30 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p9JaM-007OWV-C7; Sun, 25 Dec 2022 05:30:10 +0000
Date: Sat, 24 Dec 2022 21:30:10 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Keith Busch <kbusch@kernel.org>
Cc: Hugh Dickins <hughd@google.com>, Christoph Hellwig <hch@infradead.org>,
	Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Thorsten Leemhuis <regressions@leemhuis.info>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: 6.2 nvme-pci: something wrong
Message-ID: <Y6ff4tpk1Su/Q9bP@infradead.org>
References: <572cfcc0-197a-9ead-9cb-3c5bf5e735@google.com>
 <Y6d37vGSCKvfJhzD@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y6d37vGSCKvfJhzD@kbusch-mbp.dhcp.thefacebook.com>
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

On Sat, Dec 24, 2022 at 03:06:38PM -0700, Keith Busch wrote:
> Your observation is a queue-wrap condition that makes it impossible for
> the controller know there are new commands.
> 
> Your patch does look like the correct thing to do. The "zero means one"
> thing is a confusing distraction, I think. It makes more sense if you
> consider sqsize as the maximum number of tags we can have outstanding at
> one time and it looks like all the drivers set it that way. We're
> supposed to leave one slot empty for a full NVMe queue, so adding one
> here to report the total number slots isn't right since that would allow
> us to fill all slots.

Yes, and pcie did actually do the ‐ 1 from q_depth, so we should
drop the +1 for sqsize.  And add back the missing BLK_MQ_MAX_DEPTH.
But we still need to keep sqsize updated as well.

> Fabrics drivers have been using this method for a while, though, so
> interesting they haven't had a simiar problem.

Fabrics doesn't have a real queue and thus no actual wrap, so
I don't think they will be hit as bad by this.

So we'll probably need something like this, split into two patches.
And then for 6.2 clean up the sqsize vs q_depth mess for real.

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 95c488ea91c303..5b723c65fbeab5 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4926,7 +4926,7 @@ int nvme_alloc_io_tag_set(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set,
 
 	memset(set, 0, sizeof(*set));
 	set->ops = ops;
-	set->queue_depth = ctrl->sqsize + 1;
+	set->queue_depth = min_t(unsigned, ctrl->sqsize, BLK_MQ_MAX_DEPTH - 1);
 	/*
 	 * Some Apple controllers requires tags to be unique across admin and
 	 * the (only) I/O queue, so reserve the first 32 tags of the I/O queue.
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index f0f8027644bbf8..ec5e1c578a710b 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2332,10 +2332,12 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 	if (dev->cmb_use_sqes) {
 		result = nvme_cmb_qdepth(dev, nr_io_queues,
 				sizeof(struct nvme_command));
-		if (result > 0)
+		if (result > 0) {
 			dev->q_depth = result;
-		else
+			dev->ctrl.sqsize = dev->q_depth - 1;
+		} else {
 			dev->cmb_use_sqes = false;
+		}
 	}
 
 	do {
@@ -2536,7 +2538,6 @@ static int nvme_pci_enable(struct nvme_dev *dev)
 
 	dev->q_depth = min_t(u32, NVME_CAP_MQES(dev->ctrl.cap) + 1,
 				io_queue_depth);
-	dev->ctrl.sqsize = dev->q_depth - 1; /* 0's based queue depth */
 	dev->db_stride = 1 << NVME_CAP_STRIDE(dev->ctrl.cap);
 	dev->dbs = dev->bar + 4096;
 
@@ -2577,7 +2578,7 @@ static int nvme_pci_enable(struct nvme_dev *dev)
 		dev_warn(dev->ctrl.device, "IO queue depth clamped to %d\n",
 			 dev->q_depth);
 	}
-
+	dev->ctrl.sqsize = dev->q_depth - 1; /* 0's based queue depth */
 
 	nvme_map_cmb(dev);
 

