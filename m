Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AD1FCA1002
	for <linux-nvme@archiver.kernel.org>; Sat,  6 Sep 2025 18:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Q2ZdB7VokBOK/lOhO1dUKgUR3rSn7R22gOZYkbmWGWQ=; b=Um9ojf42Ea2aNxdYlJHlih5CLr
	HA9DO1IugbC3/iZbFNP7Kypl7QH2GhteaJ8gw8FnnBXPSMDLNwwi833YE84Vl620kp/tH4qqxL8+O
	sPA6gt1UL4RjeFaBCx/eXSFyAHHtkA88VANogJZBNhH7QlgFTjMP0r9Fc11BwhjPdDWJrX/7yIZT/
	aNX+EaDy8u5RwPnRa/lGkNzOLbQuc7Z+Ld2BCjNzNF5EQfXCNXC2089LQ8eMN2JWSM1TsfM7Ziy1T
	AfL599ONg1ZFkux21x0JF99KC/GA7gvWS/aEiCbBnOyVqBHeMWc6HgIOqgUcBRO9o884gbdhc+Oci
	X/87+F2Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uuy2x-00000008IzF-3PQ6;
	Sat, 06 Sep 2025 18:53:59 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uuaOm-00000003X1p-3vfE
	for linux-nvme@lists.infradead.org;
	Fri, 05 Sep 2025 17:38:57 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 7274460218;
	Fri,  5 Sep 2025 17:38:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AA22C4CEF1;
	Fri,  5 Sep 2025 17:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757093935;
	bh=RwgI6iOiiGGaVq5ryV0ZWpJOK9YgvvrfbQAyHKlknns=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ld3/+CXFzo5ZlgBaEJAAJ7n8ftGIf1vPmYVyQ1Q0lHbk30C+f/zGBCjYcCjqKGMkP
	 ws0j93C+g7AZ/Qe51tbRHlFMkxmG8V2HiTKDDiIWpTC2x67XRe77cJRX2O/0Emokq3
	 empFPEdzGq6Yu1WtRJ7c3H3VguQh/C6NxRnBxnFK+dgTB/PoKfshLNhSffqo96FEeK
	 5gqAp6J/XAgqm8C64dBl5bC3cJKCuXlyMRuLkxNADtvKhMqMkGQ2Y7tGhP772p1Ynd
	 b5DRxNZc712LsAvfWwUYrOIy6AN49OJHPTqpk5krnaWlYW3AAU/MPcrMbpxJdoJz6O
	 DAfHVEkZTDmug==
Date: Fri, 5 Sep 2025 20:38:50 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>, Danilo Krummrich <dakr@kernel.org>,
	iommu@lists.linux.dev, Jason Wang <jasowang@redhat.com>,
	Jens Axboe <axboe@kernel.dk>, Joerg Roedel <joro@8bytes.org>,
	Jonathan Corbet <corbet@lwn.net>, Juergen Gross <jgross@suse.com>,
	kasan-dev@googlegroups.com, Keith Busch <kbusch@kernel.org>,
	linux-block@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-nvme@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	linux-trace-kernel@vger.kernel.org,
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
Subject: Re: [PATCH v4 00/16] dma-mapping: migrate to physical address-based
 API
Message-ID: <20250905173850.GB25881@unreal>
References: <cover.1755624249.git.leon@kernel.org>
 <CGME20250829131641eucas1p2ddd687e4e8c16a2bc64a293b6364fa6f@eucas1p2.samsung.com>
 <20250829131625.GK9469@nvidia.com>
 <7557f31e-1504-4f62-b00b-70e25bb793cb@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7557f31e-1504-4f62-b00b-70e25bb793cb@samsung.com>
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

On Fri, Sep 05, 2025 at 06:20:51PM +0200, Marek Szyprowski wrote:
> On 29.08.2025 15:16, Jason Gunthorpe wrote:
> > On Tue, Aug 19, 2025 at 08:36:44PM +0300, Leon Romanovsky wrote:
> >
> >> This series does the core code and modern flows. A followup series
> >> will give the same treatment to the legacy dma_ops implementation.
> > I took a quick check over this to see that it is sane.  I think using
> > phys is an improvement for most of the dma_ops implemenations.
> >
> >    arch/sparc/kernel/pci_sun4v.c
> >    arch/sparc/kernel/iommu.c
> >      Uses __pa to get phys from the page, never touches page
> >
> >    arch/alpha/kernel/pci_iommu.c
> >    arch/sparc/mm/io-unit.c
> >    drivers/parisc/ccio-dma.c
> >    drivers/parisc/sba_iommu.c
> >      Does page_addres() and later does __pa on it. Doesn't touch struct page
> >
> >    arch/x86/kernel/amd_gart_64.c
> >    drivers/xen/swiotlb-xen.c
> >    arch/mips/jazz/jazzdma.c
> >      Immediately does page_to_phys(), never touches struct page
> >
> >    drivers/vdpa/vdpa_user/vduse_dev.c
> >      Does page_to_phys() to call iommu_map()
> >
> >    drivers/xen/grant-dma-ops.c
> >      Does page_to_pfn() and nothing else
> >
> >    arch/powerpc/platforms/ps3/system-bus.c
> >     This is a maze but I think it wants only phys and the virt is only
> >     used for debug prints.
> >
> > The above all never touch a KVA and just want a phys_addr_t.
> >
> > The below are touching the KVA somehow:
> >
> >    arch/sparc/mm/iommu.c
> >    arch/arm/mm/dma-mapping.c
> >      Uses page_address to cache flush, would be happy with phys_to_virt()
> >      and a PhysHighMem()
> >
> >    arch/powerpc/kernel/dma-iommu.c
> >    arch/powerpc/platforms/pseries/vio.c
> >     Uses iommu_map_page() which wants phys_to_virt(), doesn't touch
> >     struct page
> >
> >    arch/powerpc/platforms/pseries/ibmebus.c
> >      Returns phys_to_virt() as dma_addr_t.
> >
> > The two PPC ones are weird, I didn't figure out how that was working..
> >
> > It would be easy to make map_phys patches for about half of these, in
> > the first grouping. Doing so would also grant those arches
> > map_resource capability.
> >
> > Overall I didn't think there was any reduction in maintainability in
> > these places. Most are improvements eliminating code, and some are
> > just switching to phys_to_virt() from page_address(), which we could
> > further guard with DMA_ATTR_MMIO and a check for highmem.
> 
> Thanks for this summary.
> 
> However I would still like to get an answer for the simple question - 
> why all this work cannot be replaced by a simple use of dma_map_resource()?
> 
> I've checked the most advertised use case in 
> https://git.kernel.org/pub/scm/linux/kernel/git/leon/linux-rdma.git/log/?h=dmabuf-vfio 
> and I still don't see the reason why it cannot be based 
> on dma_map_resource() API? I'm aware of the little asymmetry of the 
> client calls is such case, indeed it is not preety, but this should work 
> even now:
> 
> phys = phys_vec[i].paddr;
> 
> if (is_mmio)
>      dma_map_resource(phys, len, ...);
> else
>      dma_map_page(phys_to_page(phys), offset_in_page(phys), ...);
> 
> What did I miss?

"Even now" can't work mainly because both of these interfaces don't
support p2p case (PCI_P2PDMA_MAP_BUS_ADDR).

It is unclear how to extend them without introducing new functions
and/or changing whole kernel. In PCI_P2PDMA_MAP_BUS_ADDR case, there
is no struct page, so dma_map_page() is unlikely to be possible to
extend and dma_map_resource() has no direct way to access PCI
bus_offset. In theory, it is doable, but will be layer violation as DMA
will need to rely on PCI layer for address calculations.

If we don't extend, in general case (for HMM, RDMA and NVMe) end result will be something like that:
if (...PCI_P2PDMA_MAP_BUS_ADDR)
  pci_p2pdma_bus_addr_map
else if (mmio)
  dma_map_resource
else              <- this case is not applicable to VFIO-DMABUF
  dma_map_page

In case, we will somehow extend these functions to support it, we will
lose very important optimization where we are performing one IOTLB
sync for whole DMABUF region == dma_iova_state, and I was told that
it is very large region.

  103         for (i = 0; i < priv->nr_ranges; i++) {
  <...>
  107                 } else if (dma_use_iova(state)) {
  108                         ret = dma_iova_link(attachment->dev, state,
  109                                             phys_vec[i].paddr, 0,
  110                                             phys_vec[i].len, dir, attrs);
  111                         if (ret)
  112                                 goto err_unmap_dma;
  113
  114                         mapped_len += phys_vec[i].len;
  <...>
  132         }
  133
  134         if (state && dma_use_iova(state)) {
  135                 WARN_ON_ONCE(mapped_len != priv->size);
  136                 ret = dma_iova_sync(attachment->dev, state, 0, mapped_len);

> 
> I'm not against this rework, but I would really like to know the 
> rationale. I know that the 2-step dma-mapping API also use phys 
> addresses and this is the same direction.

This series is continuation of 2-step dma-mapping API. The plan to
provide dma_map_phys() was from the beginning.

Thanks

