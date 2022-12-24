Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E81AC4332F
	for <linux-nvme@archiver.kernel.org>; Sat, 24 Dec 2022 08:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lmUHEYf8bFrxNnNTMUfukWsojK4GI28KYKGOVlj0iYI=; b=1XrZfagWV7t/WVSA/jjCZBlQk8
	AKnoq4uPzVl8h3qQcbGTej7XlM2PAkvOxtW6SY9cqr8psMv4ZZpu6iK+OuPcOiSPLthSHl18QKvaZ
	g45qDWA74hJn6nlVqaqBnNez7QP39QX6buE9V/z3PLjdWfI/6nx2Choj/SCvprDPYig/4RUtzWzoF
	P04IvMoeETD2SHv32ZDDkOAIs5LeKcqwOQ74K/+mZyuI/QFsm+/K+JIcH8JtTRDfEMZFJUhX0FdbJ
	WKJGVGReLq3KbY6cAc6EXrqzsLmmeeo1FdmnMNRfClgDqpmMPEXLHggCRGD5yElZrLqD6CEXKisYX
	mmv3CslA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p8znY-00GOi0-1g; Sat, 24 Dec 2022 08:22:28 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p8yjf-00FsG8-V5; Sat, 24 Dec 2022 07:14:24 +0000
Date: Fri, 23 Dec 2022 23:14:23 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Hugh Dickins <hughd@google.com>
Cc: Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Thorsten Leemhuis <regressions@leemhuis.info>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: 6.2 nvme-pci: something wrong
Message-ID: <Y6amzxU7choHAXWi@infradead.org>
References: <572cfcc0-197a-9ead-9cb-3c5bf5e735@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <572cfcc0-197a-9ead-9cb-3c5bf5e735@google.com>
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

On Fri, Dec 23, 2022 at 09:24:56PM -0800, Hugh Dickins wrote:
> Hi Christoph,
> 
> There's something wrong with the nvme-pci heading for 6.2-rc1:
> no problem booting here on this Lenovo ThinkPad X1 Carbon 5th,
> but under load...
> 
> nvme nvme0: I/O 0 (I/O Cmd) QID 2 timeout, aborting
> nvme nvme0: I/O 1 (I/O Cmd) QID 2 timeout, aborting
> nvme nvme0: I/O 2 (I/O Cmd) QID 2 timeout, aborting
> nvme nvme0: I/O 3 (I/O Cmd) QID 2 timeout, aborting
> nvme nvme0: Abort status: 0x0
> nvme nvme0: Abort status: 0x0
> nvme nvme0: Abort status: 0x0
> nvme nvme0: Abort status: 0x0
> nvme nvme0: I/O 0 QID 2 timeout, reset controller
> 
> ...and more, until I just have to poweroff and reboot.
> 
> Bisection points to your
> 0da7feaa5913 ("nvme-pci: use the tagset alloc/free helpers")
> And that does revert cleanly, giving a kernel which shows no problem.
> 
> I've spent a while comparing old nvme_pci_alloc_tag_set() and new
> nvme_alloc_io_tag_set(), I do not know my way around there at all
> and may be talking nonsense, but it did look as if there might now
> be a difference in the queue_depth, sqsize, q_depth conversions.
> 
> I'm running load successfully with the patch below, but I strongly
> suspect that the right patch will be somewhere else: over to you!

Thanks for the report!  The patch is definitively wrong, ->sqsize
hold one of the awful so called 'zeroes based values' in NVMe,
where 0 means 1, and thus have a built-in one off.  We should
probably convert it to a sane value at read time, but that's a
separate discussion.

I suspect your controller is one of those where we quirk the size,
and the commit you bisected fails to reflects that in the common
sqsizse value.  The patch below should be the minimum fix, and in
the long term, the duplicate bookkeeping for it in the PCI driver
should go away:

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index f0f8027644bbf8..a73c0ee7bd1892 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2536,7 +2536,6 @@ static int nvme_pci_enable(struct nvme_dev *dev)
 
 	dev->q_depth = min_t(u32, NVME_CAP_MQES(dev->ctrl.cap) + 1,
 				io_queue_depth);
-	dev->ctrl.sqsize = dev->q_depth - 1; /* 0's based queue depth */
 	dev->db_stride = 1 << NVME_CAP_STRIDE(dev->ctrl.cap);
 	dev->dbs = dev->bar + 4096;
 
@@ -2577,7 +2576,7 @@ static int nvme_pci_enable(struct nvme_dev *dev)
 		dev_warn(dev->ctrl.device, "IO queue depth clamped to %d\n",
 			 dev->q_depth);
 	}
-
+	dev->ctrl.sqsize = dev->q_depth - 1; /* 0's based queue depth */
 
 	nvme_map_cmb(dev);
 

