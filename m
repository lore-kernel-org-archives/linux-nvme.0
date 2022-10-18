Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D518C4332F
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Oct 2022 08:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=V1i+ZQl4Y4THZO210D0hR+zLW8ivaq+kCbavH2jLggc=; b=KqVaiEw+n653SgMuK4+NFYnKHk
	eA3mlSRJWT80mDY+qWG11mxYURzAE0ZEqLBcASwQV94Gc5aS0wR6nNS+PkUgxGCeGhDTwQZpSbi78
	NbfqHjRn5VVJHaGYX7vHeALpLbfvt2iZLR4VwQplO82ChBWumIA7pnHaQqdC3ENcBkeJeeRw1K4qj
	yniqIl2p5pbVBno/Eat7c49TpzHohSukx/YgwB+CIawIFQqEL4z5cj9GVvLACD62A4iIEmrTjFbov
	lz0mLeN10vPxXI4aFlqs1OURj0EFl+qOpKtManLd0of5enU02zayHu1PKKCeYYpttWkSXrOQATpG7
	NHbRIh7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okiOO-004YoR-OB; Tue, 18 Oct 2022 08:56:08 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okiOL-004YiO-5g
	for linux-nvme@lists.infradead.org; Tue, 18 Oct 2022 08:56:08 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4246D68C4E; Tue, 18 Oct 2022 10:55:57 +0200 (CEST)
Date: Tue, 18 Oct 2022 10:55:57 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Chao Leng <lengchao@huawei.com>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	kbusch@kernel.org, ming.lei@redhat.com, axboe@kernel.dk
Subject: Re: [PATCH v2 1/2] blk-mq: add tagset quiesce interface
Message-ID: <20221018085557.GA28266@lst.de>
References: <20221013094450.5947-1-lengchao@huawei.com> <20221013094450.5947-2-lengchao@huawei.com> <20221017133906.GA24492@lst.de> <20221017134244.GA24775@lst.de> <b0631151-4081-2fdb-fbb0-eab1db633200@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0631151-4081-2fdb-fbb0-eab1db633200@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221018_015605_414025_5DAD548C 
X-CRM114-Status: GOOD (  17.24  )
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

On Tue, Oct 18, 2022 at 11:39:30AM +0300, Sagi Grimberg wrote:
> The only question in my mind is regarding patch 2/2 with the subtle
> ordering of nvme_set_queue_dying...

I think we need to sort that out as a pre-patch.  There is quite some
history there was a fair amount of dead lock potential earlier, but
I think I sorted quite a lot out there, including a new lock for setting
the gendisk size, which is what the comment refers to.

Something like this:

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 059737c1a2c19..cb7623b5d2c8b 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -5105,21 +5105,21 @@ static void nvme_stop_ns_queue(struct nvme_ns *ns)
 
 /*
  * Prepare a queue for teardown.
- *
- * This must forcibly unquiesce queues to avoid blocking dispatch, and only set
- * the capacity to 0 after that to avoid blocking dispatchers that may be
- * holding bd_butex.  This will end buffered writers dirtying pages that can't
- * be synced.
  */
 static void nvme_set_queue_dying(struct nvme_ns *ns)
 {
 	if (test_and_set_bit(NVME_NS_DEAD, &ns->flags))
 		return;
 
+	/*
+	 * Mark the disk dead to prevent new opens, and set the capacity to 0
+	 * to end buffered writers dirtying pages that can't be synced.
+	 */
 	blk_mark_disk_dead(ns->disk);
-	nvme_start_ns_queue(ns);
-
 	set_capacity_and_notify(ns->disk, 0);
+
+	/* forcibly unquiesce queues to avoid blocking dispatch */
+	nvme_start_ns_queue(ns);
 }
 
 /**

