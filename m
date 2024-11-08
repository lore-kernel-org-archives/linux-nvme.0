Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBD7FD6406B
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Nov 2024 17:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8WOWX2ViKLpGC5S466nNFKPxXmrIIp9DY7fU8LLtYuo=; b=rrkiil/87gv07JH5m99BXDj0Ua
	0ld0XbnIRbW0wJCesZMwuhoRvVcOORQCkyLlbTtquTyX7CY5pRSXxUqXqtGzz8oN7WkQwGNah3ggb
	DKgmNbaz7vlE4i/slT+X0kgXr9uWVGh0SNyucmLUGj1UCY9PMqHY8hH2CuAOcZYbSeRltUlZF54rs
	NjCfarVBdlBWjIiFrTad2/NHoj2S/OapYEjJKODy3OnkNDDWyALT14XfHI8YSDDIl67ez40UafsWP
	iBbRD0/i8zbnvopfxbdpQ+lE+chAQhqDZp7WUGaCuZPFXNQyUJ4PJmj0S5E8ajsx3V+B9JOfbv7p7
	zf5yo5Kw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t9SVV-0000000BKpR-0QvY;
	Fri, 08 Nov 2024 17:10:49 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t9SFq-0000000BIxY-0XDg
	for linux-nvme@bombadil.infradead.org;
	Fri, 08 Nov 2024 16:54:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=8WOWX2ViKLpGC5S466nNFKPxXmrIIp9DY7fU8LLtYuo=; b=C2lLtvWITVHGHLciF/2Bj25Rqg
	RcI1MAjloGD1+aEhk7MLAtgh5GwL5L1aB0j0k0+28Rg40xQxnAAvHy7xRv2tb9lNPUHTPP9YC2c6J
	brxQpqhitJMvPJ4LErKW6PTJwgXnsUgdU6g44yZUK1FZuBGwA2PaSFH7E8wPyP1tcHRgQW7BlUfzs
	HU543g/tSng67+bcwNqg5cPkEvG4gg80cBf6n9qCu75U1E/ksxVVFHGmYgWbIfALfFA2UepS8d1lD
	v0ZoQY8qwHWAi9/vhAXVCWbRLEuKfQ6DweVyodc8fR8CAHaiqEtxCiXGHQdEznqspMXA1bbo6Bc8h
	i7glbyHw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t9SFm-0000000959i-25EG;
	Fri, 08 Nov 2024 16:54:34 +0000
Date: Fri, 8 Nov 2024 16:54:34 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@meta.com>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, io-uring@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, joshi.k@samsung.com,
	javier.gonz@samsung.com, bvanassche@acm.org
Subject: Re: [PATCHv10 0/9] write hints with nvme fdp, scsi streams
Message-ID: <Zy5CSgNJtgUgBH3H@casper.infradead.org>
References: <20241029151922.459139-1-kbusch@meta.com>
 <20241105155014.GA7310@lst.de>
 <Zy0k06wK0ymPm4BV@kbusch-mbp>
 <20241108141852.GA6578@lst.de>
 <Zy4zgwYKB1f6McTH@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zy4zgwYKB1f6McTH@kbusch-mbp>
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

On Fri, Nov 08, 2024 at 08:51:31AM -0700, Keith Busch wrote:
> On Fri, Nov 08, 2024 at 03:18:52PM +0100, Christoph Hellwig wrote:
> > We're not really duplicating much.  Writing sequential is pretty easy,
> > and tracking reclaim units separately means you need another tracking
> > data structure, and either that or the LBA one is always going to be
> > badly fragmented if they aren't the same.
> 
> You're getting fragmentation anyway, which is why you had to implement
> gc. You're just shifting who gets to deal with it from the controller to
> the host. The host is further from the media, so you're starting from a
> disadvantage. The host gc implementation would have to be quite a bit
> better to justify the link and memory usage necessary for the copies
> (...queue a copy-offload discussion? oom?).

But the filesystem knows which blocks are actually in use.  Sending
TRIM/DISCARD information to the drive at block-level granularity hasn't
worked out so well in the past.  So the drive is the one at a disadvantage
because it has to copy blocks which aren't actually in use.

I like the idea of using copy-offload though.

