Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B0EACA101C
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Sep 2025 18:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wxLWaOMzyFn1TCsduloGVD+a0ZYJgwe6TduwxzO1EKw=; b=p38473COv/bJut/Hjp3hGdxvRP
	+ap3g4ns0mwYvduMmoR36wpA/SZlbKGr3CxRbKlV0BYLYokmPafjrXRaW8e1Iy6dPkdV/aLjCaawQ
	vkVVaxw3WpDAG8Ecxxy5v1qVWFSXAe4JmQlCFXlkmjbWU7TdaVaxc+fk8P8OBvE+8wkuuYSGYMq4w
	mChGrPUt3xfCggooxExoQ9UUN/9P0vHFkEmwdzyah+iGJKWTV0O4AvwwJT985oIixyPMpWWkRMCau
	ypgqi9XvEUJFgG5poKdAhcQX1JEIskP+QbOOm7WlBI4hkzOcQnaXBcQyLis1Vkybr9G9HC4ef4bBe
	fO+VGGEA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uuEkL-0000000DaO9-1zL4;
	Thu, 04 Sep 2025 18:31:45 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utZ2U-00000002I90-077q
	for linux-nvme@lists.infradead.org;
	Tue, 02 Sep 2025 21:59:43 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 55E3F405D0;
	Tue,  2 Sep 2025 21:59:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A15CEC4CEED;
	Tue,  2 Sep 2025 21:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756850381;
	bh=zUOixGI5e23gDVx/zmq/5QWAYGpvZZ1gzj0irhRA2AU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t/Eu3RveeWFJ7QPQZS0HMJnJ18RJisbVk4Pk4B2mkUogsXCsDnOh5nmkT6QJ4KkpV
	 WAD5v3cszsJls2vJneW0RL/RKpho+ZzAZhFpATDVsn7wwLvJDFu6zSx6RUEKSctSsY
	 MYZrvd5dFbrPEZmkILy8ZxDbNlA6Ej38GRHuRquE0I86IxDtV1kdU0Sm1EDnwtGqEF
	 c1keYzFalxZPfGjORlUbEIAtFrtMdhOixv+lPDaKzXO5a+aOyNEdMKgtKZcG+wqmef
	 IRgJjgP6zlr77O2RCDhrfy6xxK73ZGX0o3JyM4rB09vZuyTewz4+/r6JUDL31Kg2Mp
	 O1zPH9rjxq5Aw==
Date: Tue, 2 Sep 2025 15:59:37 -0600
From: Keith Busch <kbusch@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Leon Romanovsky <leon@kernel.org>, Leon Romanovsky <leonro@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>, Danilo Krummrich <dakr@kernel.org>,
	iommu@lists.linux.dev, Jason Wang <jasowang@redhat.com>,
	Jens Axboe <axboe@kernel.dk>, Joerg Roedel <joro@8bytes.org>,
	Jonathan Corbet <corbet@lwn.net>, Juergen Gross <jgross@suse.com>,
	kasan-dev@googlegroups.com, linux-block@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-nvme@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org, linux-trace-kernel@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, rust-for-linux@vger.kernel.org,
	Sagi Grimberg <sagi@grimberg.me>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	virtualization@lists.linux.dev, Will Deacon <will@kernel.org>,
	xen-devel@lists.xenproject.org
Subject: Re: [PATCH v4 14/16] block-dma: migrate to dma_map_phys instead of
 map_page
Message-ID: <aLdoyWevrQMQUGyz@kbusch-mbp>
References: <cover.1755624249.git.leon@kernel.org>
 <CGME20250819173845eucas1p221cd6842839f5e7130f131cd341df566@eucas1p2.samsung.com>
 <22b824931bc8ba090979ab902e4c1c2ec8327b65.1755624249.git.leon@kernel.org>
 <2d8e67b2-4ab2-4c1f-9ef3-470810f99d07@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d8e67b2-4ab2-4c1f-9ef3-470810f99d07@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250902_145942_088086_7B79682E 
X-CRM114-Status: GOOD (  14.15  )
X-Mailman-Approved-At: Thu, 04 Sep 2025 09:33:17 -0700
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

On Tue, Sep 02, 2025 at 10:49:48PM +0200, Marek Szyprowski wrote:
> On 19.08.2025 19:36, Leon Romanovsky wrote:
> > @@ -87,8 +87,8 @@ static bool blk_dma_map_bus(struct blk_dma_iter *iter, struct phys_vec *vec)
> >   static bool blk_dma_map_direct(struct request *req, struct device *dma_dev,
> >   		struct blk_dma_iter *iter, struct phys_vec *vec)
> >   {
> > -	iter->addr = dma_map_page(dma_dev, phys_to_page(vec->paddr),
> > -			offset_in_page(vec->paddr), vec->len, rq_dma_dir(req));
> > +	iter->addr = dma_map_phys(dma_dev, vec->paddr, vec->len,
> > +			rq_dma_dir(req), 0);
> >   	if (dma_mapping_error(dma_dev, iter->addr)) {
> >   		iter->status = BLK_STS_RESOURCE;
> >   		return false;
> 
> I wonder where is the corresponding dma_unmap_page() call and its change 
> to dma_unmap_phys()...

You can't do that in the generic layer, so it's up to the caller. The
dma addrs that blk_dma_iter yield are used in a caller specific
structure. For example, for NVMe, it goes into an NVMe PRP. The generic
layer doesn't know what that is, so the driver has to provide the
unmapping.

