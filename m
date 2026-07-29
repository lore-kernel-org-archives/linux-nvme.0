Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9835FC54FCD
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jul 2026 11:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ava/4w3ktXQi+uNC/OKwPj0vUaR2yrlikaKmMY3vgcY=; b=BrMVtl/FlLwjdFRDQcdahRYw8q
	P+G/kTxfblajak8KuRiSUHyv8tJ7MSmFNwoIIEG9xBa+sJ1dlR2TKqwXDzc4YfZvmj6z8ePhQ+ZEl
	xDSIGldZ5BVFdSdbskT8lgUuvJnYCsdJYupDEXFWmcJh021zma3z/W5N1qwY21Odfndaji8F3446m
	3KSb1mkOiloJMaoSUsXk1ORNAUCq22kxPs7qSpVW2atH9jMLKq6H8sD8qdjH7hFGtCiscFefSS5/D
	M7j9fuspxF2I7lkKiPuoaGw+sfuV0rDnOrnqnGOouHVJsKsiH5WGvYn08Ssy4Cn4sXd33r7pPdUNP
	nSezz7sA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wp2Vf-00000007jAm-1Ibw;
	Wed, 29 Jul 2026 11:31:39 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wp2VH-00000007j6B-11lN
	for linux-nvme@lists.infradead.org;
	Wed, 29 Jul 2026 11:31:16 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id EEE3A68AFE; Wed, 29 Jul 2026 13:31:08 +0200 (CEST)
Date: Wed, 29 Jul 2026 13:31:08 +0200
From: Christoph Hellwig <hch@lst.de>
To: Anuj Gupta/Anuj Gupta <anuj20.g@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, Pavel Begunkov <asml.silence@gmail.com>,
	Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Tushar Gohad <tushar.gohad@intel.com>,
	William Power <william.power@intel.com>,
	Phil Cayton <phil.cayton@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Benjamin Marzinski <bmarzins@redhat.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	David Sterba <dsterba@suse.com>, Ilya Dryomov <idryomov@gmail.com>,
	dm-devel@lists.linux.dev, nvdimm@lists.linux.dev,
	linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
	cpgs@samsung.com
Subject: Re: [PATCH v4 09/14] nvme-pci: add SGL support for the dmabuf path
Message-ID: <20260729113108.GA31120@lst.de>
References: <cover.1785274111.git.asml.silence@gmail.com> <5c2e9c3bdd3e87c0c9a6e4395ea199002b83fd36.1785274111.git.asml.silence@gmail.com> <CGME20260729072126epcas5p3ad4422a45f1274b71f15dec8bf487fcc@epcas5p3.samsung.com> <20260729072117.GI9534@lst.de> <81412691.21785320403945.JavaMail.epsvc@epcpadp1new>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81412691.21785320403945.JavaMail.epsvc@epcpadp1new>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260729_043115_435628_35256EAE 
X-CRM114-Status: GOOD (  21.68  )
X-Mailman-Approved-At: Wed, 29 Jul 2026 04:31:38 -0700
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

On Wed, Jul 29, 2026 at 03:47:23PM +0530, Anuj Gupta/Anuj Gupta wrote:
> > But I also don't understand what the use case for this function
> > is to start with.  struct sg_table tells us how many segments
> > exist on the DMA side in the nents member, which should be just
> > fine for the SGL threshold calculation.
> 
> sg_table->nents covers the entire exported buffer (<=1GiB), while a
> request only covers a subrange[bi_offset, bi_offset+payload). Using
> nents would overcount the request's segments.

Urgg, yes.

> >> +	if (!entries)
> >> +		return BLK_STS_IOERR;
> >> +	if (entries > NVME_MAX_SEGS)
> >> +		return BLK_STS_AGAIN;
> > 
> > Given that the block layer enforced data in rw/command and the
> > max_segments limit, why do we need the extra check here?
> 
> A dmabuf bio reports nsegs=1 (bio_split_io_at) to the block layer, so 
> max_segments isn't enforced against the SG entries actually spanned by 
> the request. Hence the explicit check.

We'll need to expose the actual nsegs to the block layer and split
based on that.  Otherwise I/O might work or fail based on the device
capabilities.


