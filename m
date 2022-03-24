Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8563BC433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Mar 2022 06:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nbX5wWmMqP85qGYRaS9ZM+S+SyOB6RllUnVo6h2Ql+Q=; b=eH1WKgKNM1KeiAxKwYRgdVk6k+
	Q1XofDP7VWQJYuYW5cz4NecGcAXPUj92snyF2vmT6QBpmLY+TgbQdWE2H6lJWNCC2lxtEOdJS9NC7
	4y/J6m57r1CGMsqyD99DIC8DIwfagkzSnzfTdN47081/Pl76BVOYed3DFbnuLCTSI/vg0vsJPpUUW
	Npltnv5wac1XuvrLBVgaonzXIHQsANvCbnD4r8HMPBH2JYop5hvHGF1hqWe7JtK4lz2S1BEvP69a/
	Zzyc6C8k8w4i+LpwI/8u1mf4KFsrxKmsqT1ao8ka2VZCshvZ+FCZeg4ev7PSdR5yfiexQJ7JBqxNX
	8PRzf3sQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nXGzE-00Fpwf-FQ; Thu, 24 Mar 2022 06:30:20 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nXGzB-00FpvK-B1
 for linux-nvme@lists.infradead.org; Thu, 24 Mar 2022 06:30:18 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 20F6A68B05; Thu, 24 Mar 2022 07:30:11 +0100 (CET)
Date: Thu, 24 Mar 2022 07:30:11 +0100
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshiiitr@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Kanchan Joshi <joshi.k@samsung.com>,
 Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 sbates@raithlin.com, logang@deltatee.com,
 Pankaj Raghav <pankydev8@gmail.com>,
 Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@javigon.com>,
 Luis Chamberlain <mcgrof@kernel.org>,
 Adam Manzanares <a.manzanares@samsung.com>,
 Anuj Gupta <anuj20.g@samsung.com>
Subject: Re: [PATCH 11/17] block: factor out helper for bio allocation from
 cache
Message-ID: <20220324063011.GA12660@lst.de>
References: <20220308152105.309618-1-joshi.k@samsung.com>
 <CGME20220308152716epcas5p3d38d2372c184259f1a10c969f7e4396f@epcas5p3.samsung.com>
 <20220308152105.309618-12-joshi.k@samsung.com>
 <20220310083503.GE26614@lst.de>
 <CA+1E3rLF7D4jThUPZYbxpXs9LLdQ7Ek=Qy+rXZE=xgwBcLoaWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+1E3rLF7D4jThUPZYbxpXs9LLdQ7Ek=Qy+rXZE=xgwBcLoaWQ@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220323_233017_550167_AB5F1E2A 
X-CRM114-Status: GOOD (  15.12  )
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

On Thu, Mar 10, 2022 at 05:55:02PM +0530, Kanchan Joshi wrote:
> On Thu, Mar 10, 2022 at 2:05 PM Christoph Hellwig <hch@lst.de> wrote:
> >
> > On Tue, Mar 08, 2022 at 08:50:59PM +0530, Kanchan Joshi wrote:
> > > +struct bio *bio_alloc_kiocb(struct kiocb *kiocb, unsigned short nr_vecs,
> > > +                         struct bio_set *bs)
> > > +{
> > > +     if (!(kiocb->ki_flags & IOCB_ALLOC_CACHE))
> > > +             return bio_alloc_bioset(GFP_KERNEL, nr_vecs, bs);
> > > +
> > > +     return bio_from_cache(nr_vecs, bs);
> > > +}
> > >  EXPORT_SYMBOL_GPL(bio_alloc_kiocb);
> >
> > If we go down this route we might want to just kill the bio_alloc_kiocb
> > wrapper.
> 
> Fine, will kill that in v2.

As a headsup,  Mike Snitzer has been doing something similar in the

"block/dm: use BIOSET_PERCPU_CACHE from bio_alloc_bioset"

series.

