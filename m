Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9084CD5B872
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Oct 2024 15:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1m73G4+wV9nQ5aRCeT6ambeEYraYYBMP0VscpO0QNDI=; b=fVrrCJPKC9Yf1QKp5eYoWvkwYx
	nGB1ZH0NyJFmway2i09YpE51R0uKdPdaGsV9At+OQD0uGJLfXkDPR1xvjOTvN8YpD8CF1vFQXgf5q
	psdiCjjCiUxCW1PV/Msia9XOp2MIf8/DhSeSHQzMeaNdcCoyJyPSc68xB6rWJcguylVuWETq3Ue9o
	jSf1ikhy8O5d86hJEm51TVGwOvz3rTNVq3Rf7KZ6lINm2grVhTUQ+3qNSNrOdCgqF0Br5vqX8lJMt
	JvloBI0u2TVYJ2PPURc7BAorfZUZjQ3dAb3P9W786Pc5X+b0S+/kCULfD3Q+54Hc2v+7IjnXJ/Tq4
	t0cp4atg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t6B6q-00000000zH4-2dyC;
	Wed, 30 Oct 2024 15:59:48 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t6AyG-00000000wmy-49bn
	for linux-nvme@lists.infradead.org;
	Wed, 30 Oct 2024 15:50:58 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id B5DD5227A8E; Wed, 30 Oct 2024 16:50:52 +0100 (CET)
Date: Wed, 30 Oct 2024 16:50:52 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@meta.com>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, io-uring@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, joshi.k@samsung.com,
	javier.gonz@samsung.com, bvanassche@acm.org,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCHv10 9/9] scsi: set permanent stream count in block limits
Message-ID: <20241030155052.GA4984@lst.de>
References: <20241029152654.GC26431@lst.de> <ZyEAb-zgvBlzZiaQ@kbusch-mbp> <20241029153702.GA27545@lst.de> <ZyEBhOoDHKJs4EEY@kbusch-mbp> <20241029155330.GA27856@lst.de> <ZyEL4FOBMr4H8DGM@kbusch-mbp> <20241030045526.GA32385@lst.de> <ZyJTsyDjn6ABVbV0@kbusch-mbp.dhcp.thefacebook.com> <20241030154556.GA4449@lst.de> <ZyJVV6R5Ei0UEiVJ@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyJVV6R5Ei0UEiVJ@kbusch-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241030_085057_196525_568EBE1F 
X-CRM114-Status: GOOD (  14.57  )
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

On Wed, Oct 30, 2024 at 09:48:39AM -0600, Keith Busch wrote:
> What??? You said to map the temperature hints to a write stream. The
> driver offers that here. But you specifically don't want that? I'm so
> confused.

In bdev/fops.c (or file systems if they want to do that) not down in the
driver forced down everyones throat.  Which was the whole point of the
discussion that we're running in circles here.

> > with no way to make actually useful use of the stream separation.
> 
> Have you tried it? The people who actually do easily demonstrate it is
> in fact very useful.

While I've read the claim multiple times, I've not actually seen any
numbers.

