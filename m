Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FBBFC61DB2
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Jun 2025 06:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NlLbsJQ+0pFRnVvn21BoiEpCGdrB6flUi5rRbqpYZlg=; b=InaJHDQuObiWuBJZaXMwwr1wmu
	jlUtFcR96K3SKsL/KKml4t3HFAanQl4yZeM1bGmJCVUd6l1S528ub2iLV2aGnO9y5JI62mu9D5o82
	8XUbGQLIfyGyI/86aYds21AWb5WvSHroeb3k0bDaELRqdsatggEWRa53DaPLuVwdnAu3DGaCFpEjk
	MeNzQippSuW97wv8LOj+zMEZJvw01Ju30DS/4HxhsEToQ2zaYXDMTpl7nw5kVNAzJ+OG6QGibQTL2
	n1HisbaLzdtcv3VYAyrpuM0m8mqgMc4IqRNd8+S1ikZItlBt0mEr7X6bOuUYfFN9Oga47nXTN0eDD
	sOaAsFbQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPxmx-0000000FTXs-12VM;
	Fri, 13 Jun 2025 06:21:19 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPxkz-0000000FTM6-0NJG
	for linux-nvme@lists.infradead.org;
	Fri, 13 Jun 2025 06:19:18 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id E4D7C68CFE; Fri, 13 Jun 2025 08:19:12 +0200 (CEST)
Date: Fri, 13 Jun 2025 08:19:12 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Logan Gunthorpe <logang@deltatee.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/9] block: don't merge different kinds of P2P
 transfers in a single bio
Message-ID: <20250613061912.GA9517@lst.de>
References: <20250610050713.2046316-1-hch@lst.de> <CGME20250610050728epcas5p343c293cd81ffb03b6f12dabfcf2fd8d4@epcas5p3.samsung.com> <20250610050713.2046316-2-hch@lst.de> <c75ac878-376e-497b-b4fe-ddd54733c090@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c75ac878-376e-497b-b4fe-ddd54733c090@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250612_231917_273840_0CC757ED 
X-CRM114-Status: GOOD (  17.23  )
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

On Thu, Jun 12, 2025 at 11:54:21AM +0530, Kanchan Joshi wrote:
> On 6/10/2025 10:36 AM, Christoph Hellwig wrote:
> > --- a/block/bio.c
> > +++ b/block/bio.c
> > @@ -930,8 +930,6 @@ static bool bvec_try_merge_page(struct bio_vec *bv, struct page *page,
> >   		return false;
> >   	if (xen_domain() && !xen_biovec_phys_mergeable(bv, page))
> >   		return false;
> > -	if (!zone_device_pages_have_same_pgmap(bv->bv_page, page))
> > -		return false;
> 
> I did not understand the value of moving this out to its two callers 
> (bio_add_page and bio_integrity_add_page).
> 
> Since this check existed, I am a bit confused. The thing that patch 
> title says - is not a new addition and used to happen earlier too?
> Or is this about setting REQ_NOMERGE in bio?

It is about not merging mismatch pgmaps into a bio, for which it needs
to be in the caller.  The current code only prevents merges into the
same bio_vec.

