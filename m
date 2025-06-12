Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E47AC71136
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Jun 2025 05:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PGaS6DBCXW060sohbVGDzEURj3exqIpMFbexOfAE2zo=; b=MLZeKbxxuMQ2w7pxFbsCS1dXwc
	nP0vwptthJAwFP3uIRISQSprs7tbNYzDcpsa0njJ1TN8MD+pC6Y2KuFGiReQmhmVDuREOUwLgpcSR
	E4ABw2ia74WoLH+VVseVq6Cxadujn80/ZvIujYBDlVT7ZSLzYBQoDWt3IwRMTvn8NnmYASD+75Mw+
	ZxkrazR84PxedFDrCsZb4I1XFmi04l+UcI5XdIOsmg2RqakqQpi8OoSTiO+BqtGVhQWirVzECMc6H
	f970X13cXTgWwvo9fejPSNKBuBi70o0qFoM/yu6OqpY0i9wHLPv08PjI00/6WwwR/voh49e6r63y1
	Fv4ht03w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPa5f-0000000CCEk-1Ymy;
	Thu, 12 Jun 2025 05:03:03 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPa5c-0000000CCDk-2UdI
	for linux-nvme@lists.infradead.org;
	Thu, 12 Jun 2025 05:03:02 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 27A4E68D09; Thu, 12 Jun 2025 07:02:57 +0200 (CEST)
Date: Thu, 12 Jun 2025 07:02:56 +0200
From: Christoph Hellwig <hch@lst.de>
To: Daniel Gomez <da.gomez@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Leon Romanovsky <leon@kernel.org>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Logan Gunthorpe <logang@deltatee.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 7/9] nvme-pci: convert the data mapping blk_rq_dma_map
Message-ID: <20250612050256.GH12863@lst.de>
References: <20250610050713.2046316-1-hch@lst.de> <20250610050713.2046316-8-hch@lst.de> <5c4f1a7f-b56f-4a97-a32e-fa2ded52922a@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5c4f1a7f-b56f-4a97-a32e-fa2ded52922a@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250611_220301_115330_C271D898 
X-CRM114-Status: GOOD (  14.34  )
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

On Wed, Jun 11, 2025 at 02:15:10PM +0200, Daniel Gomez wrote:
> >  #define NVME_MAX_SEGS \
> > -	min(NVME_CTRL_PAGE_SIZE / sizeof(struct nvme_sgl_desc), \
> > -	    (PAGE_SIZE / sizeof(struct scatterlist)))
> > +	(NVME_CTRL_PAGE_SIZE / sizeof(struct nvme_sgl_desc))
> 
> The 8 MiB max transfer size is only reachable if host segments are at least 32k.
> But I think this limitation is only on the SGL side, right?

Yes, PRPs don't really have the concept of segments to start with.

> Adding support to
> multiple SGL segments should allow us to increase this limit 256 -> 2048.
> 
> Is this correct?

Yes.  Note that plenty of hardware doesn't really like chained SGLs too
much and you might get performance degradation.


