Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41F30EA813A
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Feb 2026 16:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6MdSVXl8RWks7nPV1PzvzGPfJDC4ruADqbIx9uS/avo=; b=QGiskzbHr5lMeDZKBVK/NvJ85O
	xzvwbQsyCfhWA+Pt3NWpd+b0ktOKxyG/fwp46dDBwEEqAqlfu2gykt2c+zH6MjcRUNYmIfUe1QVD/
	y6MYhLbTu+sSZptFRkTVFrf1Z32pDUnS3XrULc/de7mOJaTCa6HkezEMTwOPLF8S9UNzoQW2yuumj
	IC/BFnYXJkcKyMXmAyFJFImzMj1Xi+aL53+L2ENHLoJxgObKIYyg5/4tSb9xNuFphcHOlTMu7QXH+
	2ee3i1cDBDaV6TKLqa7mGTlYHNSuIJbj1r23r+5qpECElCYt9Xdly6vkBII2aunT/tRTuuDhAM9ht
	kbi07bIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vpqB3-0000000HB2Q-2hni;
	Tue, 10 Feb 2026 16:01:25 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vpqAw-0000000HB1f-0xcn;
	Tue, 10 Feb 2026 16:01:23 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 2910C439AA;
	Tue, 10 Feb 2026 16:01:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F983C19421;
	Tue, 10 Feb 2026 16:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770739277;
	bh=K3DXxvJ6FVQs/z6PXfq5PjWLrYk64mlcmilSRWH8Gu4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tSIqE/py5qSrzsPCv9NZ7D+h2TqKee2r1uwzqr8SGBAsPOR1LNl7i1WAWZFUznuh/
	 JsADInzYEHPuzgK2IYzDXF/lGjtM6mQWOIOGC9XLlsoWvtABRGd6cqFiO7/E0ED2wj
	 Xf2fQxLLWyO5mvtbNVMgp0LDP+dcFrscctWr1y+rhydyw6ZVu6RNcc6NJ7jM5Z4Ez/
	 5SotcOGMA8of/XN/+gPWNZh/3EI9MkvAD52KAk0hyAuhTuYVWKwdVKtwYK+IIkly4U
	 0RZ4dSJCZn6VWxsTeIE9RtlsHVVCBbTVJUGH2OPZsn2jxYPOqm5xZAgS3hkvHxOgGT
	 zlF/BMg69MLXg==
Date: Tue, 10 Feb 2026 09:01:14 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Yu Kuai <yukuai@fnnas.com>, axboe@kernel.dk, sagi@grimberg.me,
	sven@kernel.org, j@jannau.net, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, tj@kernel.org, nilay@linux.ibm.com,
	ming.lei@redhat.com, neal@gompa.dev, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Daniel Wagner <dwagner@suse.de>
Subject: Re: [PATCH 3/4] nvme-apple: move blk_mq_update_nr_hw_queues after
 nvme_unfreeze
Message-ID: <aYtWSscg6L9xxlzc@kbusch-mbp>
References: <20260209082953.3053721-1-yukuai@fnnas.com>
 <20260209082953.3053721-4-yukuai@fnnas.com>
 <20260209145832.GC18315@lst.de>
 <aYn-xwFHCpd7sITJ@kbusch-mbp>
 <e3e7d95b-2712-4365-922d-731449e7193a@fnnas.com>
 <aYtKFNm-wRKn6l66@kbusch-mbp>
 <20260210154108.GB2484@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260210154108.GB2484@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260210_080118_284981_AA4E4CDE 
X-CRM114-Status: GOOD (  19.01  )
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

On Tue, Feb 10, 2026 at 04:41:08PM +0100, Christoph Hellwig wrote:
> On Tue, Feb 10, 2026 at 08:09:08AM -0700, Keith Busch wrote:
> > If you leave the queue quiesced, pending IO will form requests that are
> > entered and waiting in the block layer. You can't freeze a queue with
> > entered requests.
> > 
> > We unquiesce first to flush any pending IO that had entered during the
> > prior reset. It's not the best way to handle this situation. It would be
> > smarter to steal the bio's from all the entered requests, then end those
> > requests, then resubmit the bios after the hw queues are initialized. We
> > don't do that because no one's really complained, probably because the
> > queue counts don't usually change after a reset.
> 
> FYI, Daniel Wagner had been thinking about doing this reinsert for
> something (I forgot what exactly), and this kind of reinserting from
> kblockd would also finally make REQ_NOWAIT practically useful for
> file system initiated writes.  So I hope we can eventually get to it,
> and it should help to sort out various problems.

I took a moment to craft a test by modifying the poll_queues parameter
at runtime, say from 1 -> 0, then start a controller reset. Turns out
the driver is a bit broken here. A hipri job will poll a non-polled
queue after the reset, causing a double completion with the now irq
driven queue, and the entire blk-mq map is messed up, too. Oops!

