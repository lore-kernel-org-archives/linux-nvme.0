Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 041B0CA1012
	for <linux-nvme@archiver.kernel.org>; Sat,  6 Sep 2025 18:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=r+uJO0KPgHoqZtk4UB2d6cw6Lk6DbEyEjBWC0P92zgA=; b=4RRch3GeNZiHKZOrb45wcKvAdJ
	p1/VmCcd2+oR2Yq7H56q4UpUz2QDVsCo+ebEwrBUPnPvsspcvnMTE/8zXItW1V9bUZJQroavq04Wu
	l/iQfyY11xmA2TJnrtHQvcUkPRDBVYM1zDI0M+TYmVyzu+BedPs79qUpcCiznb/ZxhwmJlZ4AbxsS
	W9NfUlHZIoOCe8iGKgv60wNSEI2GhllIqr5Aku4k61a5HPY+SYOTVs/4hHL9gBaf5LzBNlPqfvgfC
	/qdp96o1/rcZtArAYcLoGQ2Q8naUNC25HFdFPk1oQdFplHw6/yAIPzEpG5dEjxeNVSGrldYwqtHYI
	xkQiPRRw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uuy2v-00000008Ixg-1I7B;
	Sat, 06 Sep 2025 18:53:57 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uuZBM-0000000347i-3Aij
	for linux-nvme@lists.infradead.org;
	Fri, 05 Sep 2025 16:21:03 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250905162054euoutp02e77d244e0cafd5d952c3328dee47f20d~ib14B25gK1750017500euoutp02R;
	Fri,  5 Sep 2025 16:20:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250905162054euoutp02e77d244e0cafd5d952c3328dee47f20d~ib14B25gK1750017500euoutp02R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1757089254;
	bh=r+uJO0KPgHoqZtk4UB2d6cw6Lk6DbEyEjBWC0P92zgA=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=BH1gDTlm5/u+/rXGc9JT+K9NjInJASEOMUNJK2lpN97zPJKhgFZ4BwyWAKG5fWJ4U
	 SwthcsWnGvBGq4ZFisO0dXzRvPNenkJ22SKsGAEN3TZeM/LeDo1/zUbv9zcz1Jnd3W
	 ZVdWIWrJTUMJGFYQL2lzvf5ASBpb6d4tBQU3KY7E=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250905162053eucas1p1b9fec0adff4c7d35b6b6add1249d881b~ib13cmmn22364123641eucas1p1e;
	Fri,  5 Sep 2025 16:20:53 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250905162051eusmtip1e4d21f9bc61a423579ce48c4e618b6af~ib11sI1Nb2344623446eusmtip1s;
	Fri,  5 Sep 2025 16:20:51 +0000 (GMT)
Message-ID: <7557f31e-1504-4f62-b00b-70e25bb793cb@samsung.com>
Date: Fri, 5 Sep 2025 18:20:51 +0200
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH v4 00/16] dma-mapping: migrate to physical address-based
 API
To: Jason Gunthorpe <jgg@nvidia.com>, Leon Romanovsky <leon@kernel.org>
Cc: Abdiel Janulgue <abdiel.janulgue@gmail.com>, Alexander Potapenko
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
In-Reply-To: <20250829131625.GK9469@nvidia.com>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250905162053eucas1p1b9fec0adff4c7d35b6b6add1249d881b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250829131641eucas1p2ddd687e4e8c16a2bc64a293b6364fa6f
X-EPHeader: CA
X-CMS-RootMailID: 20250829131641eucas1p2ddd687e4e8c16a2bc64a293b6364fa6f
References: <cover.1755624249.git.leon@kernel.org>
	<CGME20250829131641eucas1p2ddd687e4e8c16a2bc64a293b6364fa6f@eucas1p2.samsung.com>
	<20250829131625.GK9469@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250905_092101_052282_2823156F 
X-CRM114-Status: GOOD (  28.45  )
X-Mailman-Approved-At: Sat, 06 Sep 2025 11:45:19 -0700
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

On 29.08.2025 15:16, Jason Gunthorpe wrote:
> On Tue, Aug 19, 2025 at 08:36:44PM +0300, Leon Romanovsky wrote:
>
>> This series does the core code and modern flows. A followup series
>> will give the same treatment to the legacy dma_ops implementation.
> I took a quick check over this to see that it is sane.  I think using
> phys is an improvement for most of the dma_ops implemenations.
>
>    arch/sparc/kernel/pci_sun4v.c
>    arch/sparc/kernel/iommu.c
>      Uses __pa to get phys from the page, never touches page
>
>    arch/alpha/kernel/pci_iommu.c
>    arch/sparc/mm/io-unit.c
>    drivers/parisc/ccio-dma.c
>    drivers/parisc/sba_iommu.c
>      Does page_addres() and later does __pa on it. Doesn't touch struct page
>
>    arch/x86/kernel/amd_gart_64.c
>    drivers/xen/swiotlb-xen.c
>    arch/mips/jazz/jazzdma.c
>      Immediately does page_to_phys(), never touches struct page
>
>    drivers/vdpa/vdpa_user/vduse_dev.c
>      Does page_to_phys() to call iommu_map()
>
>    drivers/xen/grant-dma-ops.c
>      Does page_to_pfn() and nothing else
>
>    arch/powerpc/platforms/ps3/system-bus.c
>     This is a maze but I think it wants only phys and the virt is only
>     used for debug prints.
>
> The above all never touch a KVA and just want a phys_addr_t.
>
> The below are touching the KVA somehow:
>
>    arch/sparc/mm/iommu.c
>    arch/arm/mm/dma-mapping.c
>      Uses page_address to cache flush, would be happy with phys_to_virt()
>      and a PhysHighMem()
>
>    arch/powerpc/kernel/dma-iommu.c
>    arch/powerpc/platforms/pseries/vio.c
>     Uses iommu_map_page() which wants phys_to_virt(), doesn't touch
>     struct page
>
>    arch/powerpc/platforms/pseries/ibmebus.c
>      Returns phys_to_virt() as dma_addr_t.
>
> The two PPC ones are weird, I didn't figure out how that was working..
>
> It would be easy to make map_phys patches for about half of these, in
> the first grouping. Doing so would also grant those arches
> map_resource capability.
>
> Overall I didn't think there was any reduction in maintainability in
> these places. Most are improvements eliminating code, and some are
> just switching to phys_to_virt() from page_address(), which we could
> further guard with DMA_ATTR_MMIO and a check for highmem.

Thanks for this summary.

However I would still like to get an answer for the simple question - 
why all this work cannot be replaced by a simple use of dma_map_resource()?

I've checked the most advertised use case in 
https://git.kernel.org/pub/scm/linux/kernel/git/leon/linux-rdma.git/log/?h=dmabuf-vfio 
and I still don't see the reason why it cannot be based 
on dma_map_resource() API? I'm aware of the little asymmetry of the 
client calls is such case, indeed it is not preety, but this should work 
even now:

phys = phys_vec[i].paddr;

if (is_mmio)
     dma_map_resource(phys, len, ...);
else
     dma_map_page(phys_to_page(phys), offset_in_page(phys), ...);

What did I miss?

I'm not against this rework, but I would really like to know the 
rationale. I know that the 2-step dma-mapping API also use phys 
addresses and this is the same direction.

This patchset focuses only on the dma_map_page -> dma_map_phys rework. 
There are also other interfaces, like dma_alloc_pages() and so far 
nothing has been proposed for them so far.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


