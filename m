Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18453CD5BD5
	for <linux-nvme@archiver.kernel.org>; Wed, 27 May 2026 14:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=12E+o/9cHsXcfLrDyligmh/JRjACkIAU2r0KqeVDaSI=; b=XNMhcnKZz0aA1r7YAGqLi+DrW/
	lJsnuDbX4Jz77ZbNIOc/jPemWp91T0oRDeu4yippRlXy2P7AwsuDp5jaZbB2r9tE4ULXLJpEpTm7v
	x62ZaztpRkoCsmXcayjdhPbMxIyEZlwtshe6Q9kN2Wt387/c+snwKJDV3Zr7Peq9JtlsT1txSC1xK
	GyCahk8NL+RP1fsHwgnDNzzWl3UkShtMcapsrr/ckteb1n+I7083FrYX1DIqqpqPzyXK0EVVezVqL
	BT9EAxyDXjZM4yd8nyLa6zlfzCz/CigQ2an444XLPbkoYVmOsvajQDcNijgfpQMtcuhnxq03K+nIN
	Ym3ney2Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSEs7-00000004G4J-0PoO;
	Wed, 27 May 2026 14:04:35 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSEs4-00000004G3a-2VpB
	for linux-nvme@lists.infradead.org;
	Wed, 27 May 2026 14:04:33 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id CCB9968BEB; Wed, 27 May 2026 16:04:27 +0200 (CEST)
Date: Wed, 27 May 2026 16:04:27 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@meta.com>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	axboe@kernel.dk, tom.leiming@gmail.com, coshi036@gmail.com,
	Igor.Achkinazi@dell.com, dlemoal@kernel.org
Subject: Re: [PATCH RFC 5/5] block, nvme: add failed_bio callback for
 multipath bio failover
Message-ID: <20260527140427.GA12705@lst.de>
References: <20260519172326.3462354-1-kbusch@meta.com> <20260519172326.3462354-6-kbusch@meta.com> <20260520072746.GD14937@lst.de> <ag3ORafKCTyn7TBA@kbusch-mbp> <ag3Sweie8nWMpmqq@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ag3Sweie8nWMpmqq@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260527_070432_785636_6D7EA3D0 
X-CRM114-Status: GOOD (  19.95  )
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

Sorry for the late reply, took me a bit to catch up after conference
travel last week and a public holiday on Monday.

On Wed, May 20, 2026 at 09:26:57AM -0600, Keith Busch wrote:
> > Yes, and in the case being addressed here, the "zero capacity" setting
> > is path specific, hence the driver wants to attempt a failover. I
> > imagine general capacity violations are not path specific though, so
> > this is kind of a weird case.
> 
> Oh, and it's not just the zero capacity IO error that multipath wants to
> hanlde. It's also that we've marked the path's disk dead, so there's a
> race if bio_queue_enter() will call bio_io_error() that this patch
> handles. I should have mentioned that case too, which wasn't handled
> with the BIO_REMAPPED flag suggestion.

Well, how do we know the bio actually is owned by the driver?  Callers
both in file systems and remapping block drivers can call bio_io_error
before calling into the driver that owns bi_bdev.

I guess we'd need some flag to desіgnate it is owned by the driver,
and bio_set_dev would have to clear it.

Alternatively we could pas a bdev to bio_submit* and only update
bi_bdev just before the bio is passed to the driver.  Given that
the idea to set the bdev at allocation time didn't work out this
might be sensible, but it will cause a lot of churn.

