Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B98BCC71155
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Jun 2025 12:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UVEPxsiQhZZo2RmjLpYW2xuH5PAVOY2IdylDRDa/i1Y=; b=SFFcAZtqxTvd/Yc80Wb3gPKZur
	khVXl8rwAF0bmnsrYaEbA21A5QzydwDoAT0BK7pHh9fc9imSIn2BOatl1ifkvFbC22i4IZhtDLjfJ
	qvnqD+zZR4YLJrhECMI6SFlmBK4nz02t6IHEUVkxLolXsWhcl7nnFzVpZ+myxnkUuih8FoOmOiKDv
	FELm3zqvAWjPX3ZkuqbPwXBQQkPoLLujXtkJX0hR3P3rSikiiZ5UYId8QbiflK/YaanHuhdl3LhYQ
	itjR9S05qPjFquceVecZuiYpqJKvu0h7pfhyllj7MH4cQ1t074PNAoQDuE55+VLpDNCuub1heuS1P
	WvlekjMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uR97P-00000004OYB-0Ad1;
	Mon, 16 Jun 2025 12:39:19 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uR87K-00000004DXj-3RWa
	for linux-nvme@lists.infradead.org;
	Mon, 16 Jun 2025 11:35:12 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 99CB368D07; Mon, 16 Jun 2025 13:35:06 +0200 (CEST)
Date: Mon, 16 Jun 2025 13:35:05 +0200
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
Message-ID: <20250616113505.GA22121@lst.de>
References: <20250610050713.2046316-1-hch@lst.de> <20250610050713.2046316-8-hch@lst.de> <871b014b-e308-4f20-9701-5581beee91ed@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871b014b-e308-4f20-9701-5581beee91ed@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250616_043510_996929_94B7840F 
X-CRM114-Status: GOOD (  14.66  )
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

On Mon, Jun 16, 2025 at 09:49:47AM +0200, Daniel Gomez wrote:
> >  #define NVME_MAX_SEGS \
> > -	min(NVME_CTRL_PAGE_SIZE / sizeof(struct nvme_sgl_desc), \
> > -	    (PAGE_SIZE / sizeof(struct scatterlist)))
> > +	(NVME_CTRL_PAGE_SIZE / sizeof(struct nvme_sgl_desc))
> 
> IIRC, I've seen in the commit history going from PAGE_SIZE to CC.MPS for
> different cases in the driver. PRPs requires contiguous regions to be CC.MPS,
> i.e use NVME_CTRL_PAGE_SIZE for PRP lists and entries. But I think that is not a
> limit for SGLs. Can we use PAGE_SIZE here?

Sure.  Separate unrelated patch, though.

