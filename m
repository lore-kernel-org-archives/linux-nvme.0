Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D40CC4332F
	for <linux-nvme@archiver.kernel.org>; Sat, 24 Dec 2022 22:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4UGgvDYwkEzkWlAoJg7VVnlO9d0ObHmSrmzZPksKgQg=; b=jA8vJ2BzMNhm8uf6FL43iInQVp
	Trn1VOyVqVh5UPTkUz9RAIWRE8PLf1IvbvOHtIrhCIzRH0KEeemshuh83vuHY0YR2ifOSFYXzR1PQ
	jMjz7xeZClj+ZmLVC47I3eWnkufuKWQkPKHUZ8MaitH3/mjQUqGrveL3edUDJGUwIzsg9E6VaxsVG
	vFiO+fyZfYGGaD+8l+l3WMgy7apZ+dQneVsxdBfzyeUF4V7WhQM2Q+UJIpo49ySst0N7ZJ771KgK/
	qDCJKHY7/XG17mGFsanIsDALsiy6fb1xfa6qzTTxZZC5WRPtxEwrIdHbTM+dLWKr7bU8NxCinrezp
	QL5nmM9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p9CfQ-003blC-7F; Sat, 24 Dec 2022 22:06:56 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p9CfH-003bhC-UO
	for linux-nvme@lists.infradead.org; Sat, 24 Dec 2022 22:06:49 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id F2DAA60B0C;
	Sat, 24 Dec 2022 22:06:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FE9CC433D2;
	Sat, 24 Dec 2022 22:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1671919602;
	bh=FDRW/65+iOIG+xRl7DZC4z2D8oXawEPLvY0Logj1h7I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=azEswh39v0IPU+yFWhK/l7jZnBdIuQyRXDASQsXm26TOOIzxu45HD40/Jn/oOhOxB
	 l8kSRtNTPKTH4KrhYFqQD8IwI59cyqoCffkqxPjuPgu6GZu2fP7ihtHA/8EfiUCPdm
	 igs7kG3lysEgaOhZICnOxgh12LqqdfXwzz1RE/+HUO4/xEW7UY9PjwGB+BR8JCvbrQ
	 wpne5B4xhd0oFoRhz/ea7mYjO8NAKeh8CBQMgP0PRr9cscfG1cfmom0YJ+S8eXIZcx
	 KQ4RoXlKeKdjA6ifcFhSS5mJIcfUZAczlIElcgldw4z4ZTmIjjs0tI+5HTtvgddYpV
	 jj/HBtGAatVFQ==
Date: Sat, 24 Dec 2022 15:06:38 -0700
From: Keith Busch <kbusch@kernel.org>
To: Hugh Dickins <hughd@google.com>
Cc: Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Thorsten Leemhuis <regressions@leemhuis.info>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: 6.2 nvme-pci: something wrong
Message-ID: <Y6d37vGSCKvfJhzD@kbusch-mbp.dhcp.thefacebook.com>
References: <572cfcc0-197a-9ead-9cb-3c5bf5e735@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <572cfcc0-197a-9ead-9cb-3c5bf5e735@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221224_140648_098212_F97C48C5 
X-CRM114-Status: GOOD (  23.61  )
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
> 
> Hugh
> 
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -4926,7 +4926,7 @@ int nvme_alloc_io_tag_set(struct nvme_ct
>  
>  	memset(set, 0, sizeof(*set));
>  	set->ops = ops;
> -	set->queue_depth = ctrl->sqsize + 1;
> +	set->queue_depth = ctrl->sqsize;

Your observation is a queue-wrap condition that makes it impossible for
the controller know there are new commands.

Your patch does look like the correct thing to do. The "zero means one"
thing is a confusing distraction, I think. It makes more sense if you
consider sqsize as the maximum number of tags we can have outstanding at
one time and it looks like all the drivers set it that way. We're
supposed to leave one slot empty for a full NVMe queue, so adding one
here to report the total number slots isn't right since that would allow
us to fill all slots.

Fabrics drivers have been using this method for a while, though, so
interesting they haven't had a simiar problem.

