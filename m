Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA1B6C369AB
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Apr 2025 07:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dt9fduLH9NEHHaOhhRr4oEvzLy9Mdk820DitIcXke4k=; b=mNZKzbrXe9i3ez5Rdgamvu2J1R
	oSY34IEN7auwY1uzWWrQCBvl3FDzPtVRHXirJQ25H3plQ9xDbymIArtBdaSHL7hwNrUr4zKBq87k4
	Ia8qaocsN1hs6W4I68Qjz7MzGvuqBcPxI5PY1RKKae2UCQiVg2KdbsW+CPE+Bvup1/RS5VGUQ53fM
	uyaYydog9djta27K/6R9tnxCh189QbuQTx1WRfJr4dYmyV8blWrbj++lV8R5Q4ASTo8ZqPwEX9fIZ
	D0cZvYeC4a1rigTxCIgxmqisBoo+3hrjc9QdE7EPseOfNJdTxZzblrqfkwBw6BOQfLmhIjyyy1mNZ
	GY+54zvg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7rFV-0000000DE9c-0jwa;
	Thu, 24 Apr 2025 07:43:57 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7qut-0000000D8qk-13KY
	for linux-nvme@lists.infradead.org;
	Thu, 24 Apr 2025 07:22:40 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 9D1EA5C5F18;
	Thu, 24 Apr 2025 07:20:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D07BC4CEEC;
	Thu, 24 Apr 2025 07:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745479358;
	bh=pkWE6sGGOL/lS7z2PofBZdgR94MWvVoyVMrCsfmGWMk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WoDzuOVNM5Th9/6MPQtwK/rt0LHybLoQmVej7xUL7pi/+grRTLzz3YO22zNR2UUpv
	 L0Bn1mEP+wHrMmXMnVi+xdnrx+pb56/i+NwcME8rl7+krJ8X06sAa4KiT0AJGFeGhO
	 zvG4gVJvRX6aT9o2FnS7IA1RJT+icqhZ42NzdhXqk+vXT48zoVpYbdHXg/hsIbpVVW
	 mb5tmX1IUQBMyuSJU93RCrakk1F6JJ/M7rFzDCbJQt3wrlrbWfV338F+OcjU+P+e3j
	 bzNLphJk97vP+hv977iF8cPx4g8hsnK1XXRSn4AkJbQ0zy97kvPiSWubQUhNoqskr/
	 o45akYSgJ5EsQ==
Date: Thu, 24 Apr 2025 10:22:34 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>, Jake Edge <jake@lwn.net>,
	Jonathan Corbet <corbet@lwn.net>, Zhu Yanjun <zyjzyj2000@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	=?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
	iommu@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-pci@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH v9 11/24] mm/hmm: provide generic DMA managing logic
Message-ID: <20250424072234.GN48485@unreal>
References: <cover.1745394536.git.leon@kernel.org>
 <3abc42885831f841dd5dfe78d7c4e56c620670ea.1745394536.git.leon@kernel.org>
 <20250423172856.GM1213339@ziepe.ca>
 <20250424071545.GM48485@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424071545.GM48485@unreal>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250424_002239_392774_A95DD5D0 
X-CRM114-Status: GOOD (  15.91  )
X-Mailman-Approved-At: Thu, 24 Apr 2025 00:42:45 -0700
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

On Thu, Apr 24, 2025 at 10:15:45AM +0300, Leon Romanovsky wrote:
> On Wed, Apr 23, 2025 at 02:28:56PM -0300, Jason Gunthorpe wrote:
> > On Wed, Apr 23, 2025 at 11:13:02AM +0300, Leon Romanovsky wrote:
> > > From: Leon Romanovsky <leonro@nvidia.com>

<...>

> > > +bool hmm_dma_unmap_pfn(struct device *dev, struct hmm_dma_map *map, size_t idx)
> > > +{
> > > +	struct dma_iova_state *state = &map->state;
> > > +	dma_addr_t *dma_addrs = map->dma_list;
> > > +	unsigned long *pfns = map->pfn_list;
> > > +	unsigned long attrs = 0;
> > > +
> > > +#define HMM_PFN_VALID_DMA (HMM_PFN_VALID | HMM_PFN_DMA_MAPPED)
> > > +	if ((pfns[idx] & HMM_PFN_VALID_DMA) != HMM_PFN_VALID_DMA)
> > > +		return false;
> > > +#undef HMM_PFN_VALID_DMA
> > 
> > If a v10 comes I'd put this in a const function level variable:
> > 
> >           const unsigned int HMM_PFN_VALID_DMA = HMM_PFN_VALID | HMM_PFN_DMA_MAPPED;

diff --git a/mm/hmm.c b/mm/hmm.c
index c0bee5aa00fc..a8bf097677f3 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -807,15 +807,14 @@ EXPORT_SYMBOL_GPL(hmm_dma_map_pfn);
  */
 bool hmm_dma_unmap_pfn(struct device *dev, struct hmm_dma_map *map, size_t idx)
 {
+       const unsigned long valid_dma = HMM_PFN_VALID | HMM_PFN_DMA_MAPPED;
        struct dma_iova_state *state = &map->state;
        dma_addr_t *dma_addrs = map->dma_list;
        unsigned long *pfns = map->pfn_list;
        unsigned long attrs = 0;
 
-#define HMM_PFN_VALID_DMA (HMM_PFN_VALID | HMM_PFN_DMA_MAPPED)
-       if ((pfns[idx] & HMM_PFN_VALID_DMA) != HMM_PFN_VALID_DMA)
+       if ((pfns[idx] & valid_dma) != valid_dma)
                return false;
-#undef HMM_PFN_VALID_DMA
 
        if (pfns[idx] & HMM_PFN_P2PDMA_BUS)
                ; /* no need to unmap bus address P2P mappings */

