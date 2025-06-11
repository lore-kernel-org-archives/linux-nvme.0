Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E007EC61DB2
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Jun 2025 03:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=egPqLwudUsSteUN/diUigW34fmjofEblaq6Pw+j8dlk=; b=TD+y2pzKmM6cU15+XBc/iMjWsF
	uga3Ezm192IC/zMQBpliaEjlNrS5kUMliCGfODJpUE38ynn/76YoQa8njUQSSRsEK9raMGjacg1+e
	SCPujMyYwmop1+NzEClxWS1u2X9rkq8pe0+N1WP/pPxaoLb0B3oY0M5KnnSqVU4xvU2P5hquvCFvP
	/kClIsyhi+p5gYhSZPWmGTMY6M1Sq3lcz1dJRY8uHxlLEjG+GKOTH0henV4DEoCsTk+N1GlxMOJ9b
	IqFCxmIzNOqUBo9TITNsTigQRAeTXwKml7psHgjlbath+M32/h80lHaDQCEPKIJlP+KXNikZuMc/6
	ut/ThwMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPCOS-00000008l54-2J6k;
	Wed, 11 Jun 2025 03:44:52 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPCN6-00000008knE-1PTq
	for linux-nvme@lists.infradead.org;
	Wed, 11 Jun 2025 03:43:29 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7A32C68C4E; Wed, 11 Jun 2025 05:43:16 +0200 (CEST)
Date: Wed, 11 Jun 2025 05:43:16 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Leon Romanovsky <leon@kernel.org>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Logan Gunthorpe <logang@deltatee.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/9] block: don't merge different kinds of P2P
 transfers in a single bio
Message-ID: <20250611034316.GA2869@lst.de>
References: <20250610050713.2046316-1-hch@lst.de> <20250610050713.2046316-2-hch@lst.de> <aEhROl2D89kFX8C7@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEhROl2D89kFX8C7@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250610_204328_521459_DDE98F47 
X-CRM114-Status: GOOD (  17.22  )
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

On Tue, Jun 10, 2025 at 09:37:30AM -0600, Keith Busch wrote:
> On Tue, Jun 10, 2025 at 07:06:39AM +0200, Christoph Hellwig wrote:
> > To get out of the DMA mapping helpers having to check every segment for
> > it's P2P status, ensure that bios either contain P2P transfers or non-P2P
> > transfers, and that a P2P bio only contains ranges from a single device.
> 
> I may be out of the loop here. Is this an optimization to make something
> easier for the DMA layer?

Yes.  P2P that is based on a bus address (i.e. using a switch) uses
a completely different way to DMA MAP than the normal IOMMU or
direct mapping.  So the optimization of collapsing all host physical
addresses into an iova can't work once it is present.

> I don't think there's any fundamental reason
> why devices like nvme couldn't handle a command that uses memory mixed
> among multiple devices and/or host memory, at least.

Sure, devices don't even see if an IOVA is P2P or not, this is all
host side.


