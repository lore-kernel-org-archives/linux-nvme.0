Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B66B7D42BAC
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Nov 2024 16:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fAMTDrIie0NJKvUC2/N97ba2JyudaMlhmIGtcU+yftc=; b=Q3BDoBnIj38VNlHCsrRNBb844d
	bPRMmlpRkj8mzDF+a5VodY+/5heLuDDemNonr5Rsr5pnw/mynwS2B8nY4mcZV8eTAtkT6w6l4tRUy
	ihny0n/Q/m8KYtyxKLyJwjr+CnfPL8OTfOVZ6Y3Mg/+zuB9Xwy5WrJJsvIk2re7Qe/tTXLaQhEram
	sehVC89rZYGHbS/xJvtZ2Tx8CDNlGAyTcc1Me3OPmlnjOtFwTaddQxK02m1djNZfBVwdyLwHk+LKW
	hhdgX3wjHUC7qDU6njXeAP+NsI1P/sufHiN7wAifWPi48LWfHh5WO5O8IRD6kHiSQlwYcxIGZdtk5
	CIadvEBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tAu6b-00000004E5Q-3Ghm;
	Tue, 12 Nov 2024 16:51:05 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tAu6X-00000004E4K-1VSu
	for linux-nvme@lists.infradead.org;
	Tue, 12 Nov 2024 16:51:03 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7689768D0A; Tue, 12 Nov 2024 17:50:54 +0100 (CET)
Date: Tue, 12 Nov 2024 17:50:54 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Kanchan Joshi <joshi.k@samsung.com>,
	Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
	axboe@kernel.dk, martin.petersen@oracle.com, asml.silence@gmail.com,
	javier.gonz@samsung.com
Subject: Re: [PATCHv11 0/9] write hints with nvme fdp and scsi streams
Message-ID: <20241112165054.GA19355@lst.de>
References: <20241108193629.3817619-1-kbusch@meta.com> <CGME20241111103051epcas5p341a23ed677f2dfd6bc6d4e5c4826327b@epcas5p3.samsung.com> <20241111102914.GA27870@lst.de> <7a2f6231-bb35-4438-ba50-3f9c4cc9789a@samsung.com> <20241112133439.GA4164@lst.de> <ZzNlaXZTn3Pjiofn@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZzNlaXZTn3Pjiofn@kbusch-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241112_085101_571888_359F6A6E 
X-CRM114-Status: GOOD (  23.83  )
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

On Tue, Nov 12, 2024 at 07:25:45AM -0700, Keith Busch wrote:
> > I feel like banging my head against the wall.  No, passing through write
> > streams is simply not acceptable without the file system being in
> > control.  I've said and explained this in detail about a dozend times
> > and the file system actually needing to do data separation for it's own
> > purpose doesn't go away by ignoring it.
> 
> But that's just an ideological decision that doesn't jive with how
> people use these.

Sorry, but no it is not.  The file system is the entity that owns the
block device, and it is the layer that manages the block device.
Bypassing it is an layering violation that creates a lot of problems
and solves none at all.

> The applications know how they use their data better
> than the filesystem,

That is a very bold assumption, and a clear indication that you are
actually approaching this with a rather idiological hat.  If your
specific application actually thinks it knows the storage better than
the file system that you are using you probably should not be using
that file system.  Use a raw block device or even better passthrough
or spdk if you really know what you are doing (or at least thing so).

Otherwise you need to agree that the file system is the final arbiter
of the underlying device resource.  Hint: if you have an application
that knows that it is doing (there actually are a few of those) it's
usually not hard to actually work with file system people to create
abstractions that don't poke holes into layering but still give the
applications what you want.  There's also the third option of doing
something like what Damien did with zonefs and actually create an
abstraction for what what your are doing.

> so putting the filesystem in the way to force
> streams look like zones is just a unnecessary layer of indirection
> getting in the way.

Can you please stop this BS?  Even if a file system doesn't treat
write streams like zones keeps LBA space and physical allocation units
entirely separate (for which I see no good reason, but others might
disagree) you still need the file system in control of the hardware
resources.


