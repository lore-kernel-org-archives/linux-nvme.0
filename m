Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F97BCA101F
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Sep 2025 18:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cns0fXIAbt1EqvizSg/wAnSv3SWVs6AXpQ/9VbxT1xc=; b=haEpGJTaCRu/lzf8lj4iN4JpuY
	WN1iETAyZ0C6fa94+RRNL2KNppXBStL1dZ77TZuSm+2S8+kO324/DetOPM+u/Ju/veBQjPLzq+NJC
	jw0yQpLSZqK6Z8YGRyi6QA166/Xia0OzKT9SrnefG+t3xMLTGthJ2Zp1q29tpB0TRBdEwIQcviUEz
	38BJnlbuVvMXylVPrQxN3+/2FwoE94+z/UA1mHPPR9nhsLUCsXSfp70oYJcJvZTHl/tqHpHsEUsRL
	XvBheYCmiE4urjYkJfWHF4Rz+PqBweHMNqoF/Y9c5M365s4/C9No59ArgyvQSls+LxmT464pH/SQX
	1vj4hbUw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uuEkK-0000000DaLa-1BNT;
	Thu, 04 Sep 2025 18:31:44 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utXwy-00000001zJz-1z93
	for linux-nvme@lists.infradead.org;
	Tue, 02 Sep 2025 20:49:58 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250902204951euoutp019772216366e471dce5ab670ff270a1c3~hkk2PqBI40583005830euoutp01b;
	Tue,  2 Sep 2025 20:49:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250902204951euoutp019772216366e471dce5ab670ff270a1c3~hkk2PqBI40583005830euoutp01b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1756846191;
	bh=cns0fXIAbt1EqvizSg/wAnSv3SWVs6AXpQ/9VbxT1xc=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=TCSDXZF2Z62YcDiWqMDDa7Dv+pRBN+EUSjgrFZ1mzkO8tak0poyAI0nhbznKNDhqf
	 D8kNvQjhwMLyfbECL2R2+e0uzHGZze/5arbNIj/FB7PwNbK4vxp5cjSUYa4Wb+jDZr
	 M4rtfp2Rgp2ma7OWloLOB4f81ua8G4Rw/nxkJvc0=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250902204950eucas1p1185c6ab6c55958183bb0c347b0396b5b~hkk1r34Tc3157531575eucas1p1q;
	Tue,  2 Sep 2025 20:49:50 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250902204948eusmtip14b51a6d907c8deca19aa6660d162e2c8~hkkz6C6Li1369313693eusmtip1I;
	Tue,  2 Sep 2025 20:49:48 +0000 (GMT)
Message-ID: <2d8e67b2-4ab2-4c1f-9ef3-470810f99d07@samsung.com>
Date: Tue, 2 Sep 2025 22:49:48 +0200
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH v4 14/16] block-dma: migrate to dma_map_phys instead of
 map_page
To: Leon Romanovsky <leon@kernel.org>
Cc: Leon Romanovsky <leonro@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>, Alexander Potapenko
	<glider@google.com>, Alex Gaynor <alex.gaynor@gmail.com>, Andrew Morton
	<akpm@linux-foundation.org>, Christoph Hellwig <hch@lst.de>, Danilo
	Krummrich <dakr@kernel.org>, iommu@lists.linux.dev, Jason Wang
	<jasowang@redhat.com>, Jens Axboe <axboe@kernel.dk>, Joerg Roedel
	<joro@8bytes.org>, Jonathan Corbet <corbet@lwn.net>, Juergen Gross
	<jgross@suse.com>, kasan-dev@googlegroups.com, Keith Busch
	<kbusch@kernel.org>, linux-block@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-nvme@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	linux-trace-kernel@vger.kernel.org, Madhavan Srinivasan
	<maddy@linux.ibm.com>, Masami Hiramatsu <mhiramat@kernel.org>, Michael
	Ellerman <mpe@ellerman.id.au>, "Michael S. Tsirkin" <mst@redhat.com>, Miguel
	Ojeda <ojeda@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	rust-for-linux@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>, Stefano
	Stabellini <sstabellini@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
	virtualization@lists.linux.dev, Will Deacon <will@kernel.org>,
	xen-devel@lists.xenproject.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <22b824931bc8ba090979ab902e4c1c2ec8327b65.1755624249.git.leon@kernel.org>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20250902204950eucas1p1185c6ab6c55958183bb0c347b0396b5b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250819173845eucas1p221cd6842839f5e7130f131cd341df566
X-EPHeader: CA
X-CMS-RootMailID: 20250819173845eucas1p221cd6842839f5e7130f131cd341df566
References: <cover.1755624249.git.leon@kernel.org>
	<CGME20250819173845eucas1p221cd6842839f5e7130f131cd341df566@eucas1p2.samsung.com>
	<22b824931bc8ba090979ab902e4c1c2ec8327b65.1755624249.git.leon@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250902_134957_090168_3856A8AA 
X-CRM114-Status: GOOD (  18.42  )
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

On 19.08.2025 19:36, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
>
> After introduction of dma_map_phys(), there is no need to convert
> from physical address to struct page in order to map page. So let's
> use it directly.
>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>   block/blk-mq-dma.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/block/blk-mq-dma.c b/block/blk-mq-dma.c
> index ad283017caef..37e2142be4f7 100644
> --- a/block/blk-mq-dma.c
> +++ b/block/blk-mq-dma.c
> @@ -87,8 +87,8 @@ static bool blk_dma_map_bus(struct blk_dma_iter *iter, struct phys_vec *vec)
>   static bool blk_dma_map_direct(struct request *req, struct device *dma_dev,
>   		struct blk_dma_iter *iter, struct phys_vec *vec)
>   {
> -	iter->addr = dma_map_page(dma_dev, phys_to_page(vec->paddr),
> -			offset_in_page(vec->paddr), vec->len, rq_dma_dir(req));
> +	iter->addr = dma_map_phys(dma_dev, vec->paddr, vec->len,
> +			rq_dma_dir(req), 0);
>   	if (dma_mapping_error(dma_dev, iter->addr)) {
>   		iter->status = BLK_STS_RESOURCE;
>   		return false;

I wonder where is the corresponding dma_unmap_page() call and its change 
to dma_unmap_phys()...

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


