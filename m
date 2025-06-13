Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ADC5C71135
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Jun 2025 06:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=F0GL3Q5mRNhCMKrN9W6m1THpNEqI2G1bYt7olK0ZcDk=; b=uSRHEv9ktEu02K39Dhr3zYEFHF
	DSDBn33K72CsDBGEgyoT+8dfl6Qo3lp5KOzQtfDFCrnmoGZE67LUG1Bn16jcdNScMuJABrQWEa6uk
	AqKydKbesqmcVjf/Mo9effBgzv1If9hsJoLMlM/UbEEsDs3zREAA6XUYfAw2BSeS5I0FYXFTFP70i
	Un1h+4IhxnjLD6xl6E5YZilVuGfQ7G/80/LSxvsXvSKiKZSqOLNwCNoY8aoGq6iDa22YpuyOBz89d
	lgzIktfmM3LfuW1rpdWs4M85K7yN6aD7x7nVdkukaRYZ0daSltvUnJVkFB9+9d6/+wrL/MmOlW6Fk
	MXcSKkKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPxmw-0000000FTXj-2TLy;
	Fri, 13 Jun 2025 06:21:18 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPxjS-0000000FT8B-440s
	for linux-nvme@lists.infradead.org;
	Fri, 13 Jun 2025 06:17:44 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8D2BD68D0D; Fri, 13 Jun 2025 08:17:34 +0200 (CEST)
Date: Fri, 13 Jun 2025 08:17:34 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Logan Gunthorpe <logang@deltatee.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/9] block: add scatterlist-less DMA mapping helpers
Message-ID: <20250613061734.GA9482@lst.de>
References: <20250610050713.2046316-1-hch@lst.de> <CGME20250610050727epcas5p3d2b58ed1a8224a141d819fdc985d1a0c@epcas5p3.samsung.com> <20250610050713.2046316-3-hch@lst.de> <e7e6235b-99c3-478d-887e-4b2c9a1a14f4@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7e6235b-99c3-478d-887e-4b2c9a1a14f4@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250612_231743_149249_907DA9FD 
X-CRM114-Status: GOOD (  15.02  )
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

On Thu, Jun 12, 2025 at 12:05:18PM +0530, Kanchan Joshi wrote:
> On 6/10/2025 10:36 AM, Christoph Hellwig wrote:
> > +static bool blk_dma_map_bus(struct request *req, struct device *dma_dev,
> 
> Both are not used in the function body.

I'll fix it.

> > + */
> > +bool blk_rq_dma_map_iter_start(struct request *req, struct device *dma_dev,
> > +		struct dma_iova_state *state, struct blk_dma_iter *iter)
> > +{
> > +	unsigned int total_len = blk_rq_payload_bytes(req);
> > +	struct phys_vec vec;
> > +
> > +	iter->iter.bio = req->bio;
> > +	iter->iter.iter = req->bio->bi_iter;
> > +	memset(&iter->p2pdma, 0, sizeof(iter->p2pdma));
> Should this (or maybe p2pdma field itself) be compiled out using 
> CONFIG_PCI_P2PDMA.

We could, but is it really worth the effort?

