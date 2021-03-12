Return-Path: <SRS0=WLLZ=IK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60438C433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Mar 2021 15:52:11 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 145C564FFA
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Mar 2021 15:52:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 145C564FFA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=1auCUaWCeCBjRXSfYgtXexURhuHZcTkm3OPVngHVooc=; b=NIQDrS4u2UgHtRdRJRpxlLzSm
	K6MAgsmLXY1Gu23cmD9HdP122t6E3hbHFB+LrT+QHjGkKslrQWaoyjwZUNJYZs5Cc1cg1FV3vwGg1
	DQDtw7l8xAMdrOKO0FOilWXyFNjDll6ybY71VLm4dXZI+WQszLDyDlpneNKrl5iXe9G5kz9AoL8x8
	ShMBWFOaY30DoTLYLRQveXtADCiybOqg3zAA+bn5214tiuW+6mm4BWO6qmNJXIRiPlFYddSUgvwMT
	ZnDmodHIzGXdYE6/60tf/CErAfRhtwLU2wLZp6yaO6otkmWpSVUkX0u2tZD4vcEu+Vmc5XAddtS9v
	ZPq2Eqa2A==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lKk52-00Bs9M-7F; Fri, 12 Mar 2021 15:52:00 +0000
Received: from foss.arm.com ([217.140.110.172])
 by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
 id 1lKk4u-00Bs7w-3W
 for linux-nvme@lists.infradead.org; Fri, 12 Mar 2021 15:51:55 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 79DA01FB;
 Fri, 12 Mar 2021 07:51:47 -0800 (PST)
Received: from [10.57.52.136] (unknown [10.57.52.136])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 38D593F7D7;
 Fri, 12 Mar 2021 07:51:43 -0800 (PST)
Subject: Re: [RFC PATCH v2 00/11] Add support to dma_map_sg for P2PDMA
To: Logan Gunthorpe <logang@deltatee.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org
Cc: Minturn Dave B <dave.b.minturn@intel.com>,
 John Hubbard <jhubbard@nvidia.com>, Dave Hansen
 <dave.hansen@linux.intel.com>, Ira Weiny <iweiny@intel.com>,
 Matthew Wilcox <willy@infradead.org>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Jason Ekstrand <jason@jlekstrand.net>,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 Dan Williams <dan.j.williams@intel.com>, Stephen Bates
 <sbates@raithlin.com>, Jakowski Andrzej <andrzej.jakowski@intel.com>,
 Christoph Hellwig <hch@lst.de>, Xiong Jianxin <jianxin.xiong@intel.com>
References: <20210311233142.7900-1-logang@deltatee.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <6b9be188-1ec7-527c-ae47-3f5b4e153758@arm.com>
Date: Fri, 12 Mar 2021 15:51:37 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210311233142.7900-1-logang@deltatee.com>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210312_155152_454280_D84D3396 
X-CRM114-Status: GOOD (  36.94  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2021-03-11 23:31, Logan Gunthorpe wrote:
> Hi,
> 
> This is a rework of the first half of my RFC for doing P2PDMA in userspace
> with O_DIRECT[1].
> 
> The largest issue with that series was the gross way of flagging P2PDMA
> SGL segments. This RFC proposes a different approach, (suggested by
> Dan Williams[2]) which uses the third bit in the page_link field of the
> SGL.
> 
> This approach is a lot less hacky but comes at the cost of adding a
> CONFIG_64BIT dependency to CONFIG_PCI_P2PDMA and using up the last
> scarce bit in the page_link. For our purposes, a 64BIT restriction is
> acceptable but it's not clear if this is ok for all usecases hoping
> to make use of P2PDMA.
> 
> Matthew Wilcox has already suggested (off-list) that this is the wrong
> approach, preferring a new dma mapping operation and an SGL replacement. I
> don't disagree that something along those lines would be a better long
> term solution, but it involves overcoming a lot of challenges to get
> there. Creating a new mapping operation still means adding support to more
> than 25 dma_map_ops implementations (many of which are on obscure
> architectures) or creating a redundant path to fallback with dma_map_sg()
> for every driver that uses the new operation. This RFC is an approach
> that doesn't require overcoming these blocks.

I don't really follow that argument - you're only adding support to two 
implementations with the awkward flag, so why would using a dedicated 
operation instead be any different? Whatever callers need to do if 
dma_pci_p2pdma_supported() says no, they could equally do if 
dma_map_p2p_sg() (or whatever) returns -ENXIO, no?

We don't try to multiplex .map_resource through .map_page, so there 
doesn't seem to be any good reason to force that complexity on .map_sg 
either. And having a distinct API from the outset should make it a lot 
easier to transition to better "list of P2P memory regions" data 
structures in future without rewriting the whole world. As it is, there 
are potential benefits in a P2P interface which can define its own 
behaviour - for instance if threw out the notion of segment merging it 
could save a load of bother by just maintaining the direct correlation 
between pages and DMA addresses.

Robin.

> Any alternative ideas or feedback is welcome.
> 
> These patches are based on v5.12-rc2 and a git branch is available here:
> 
>    https://github.com/sbates130272/linux-p2pmem/  p2pdma_dma_map_ops_rfc
> 
> A branch with the patches from the previous RFC that add userspace
> O_DIRECT support is available at the same URL with the name
> "p2pdma_dma_map_ops_rfc+user" (however, none of the issues with those
> extra patches from the feedback of the last posting have been fixed).
> 
> Thanks,
> 
> Logan
> 
> [1] https://lore.kernel.org/linux-block/20201106170036.18713-1-logang@deltatee.com/
> [2] https://lore.kernel.org/linux-block/CAPcyv4ifGcrdOtUt8qr7pmFhmecGHqGVre9G0RorGczCGVECQQ@mail.gmail.com/
> 
> --
> 
> Logan Gunthorpe (11):
>    PCI/P2PDMA: Pass gfp_mask flags to upstream_bridge_distance_warn()
>    PCI/P2PDMA: Avoid pci_get_slot() which sleeps
>    PCI/P2PDMA: Attempt to set map_type if it has not been set
>    PCI/P2PDMA: Introduce pci_p2pdma_should_map_bus() and
>      pci_p2pdma_bus_offset()
>    lib/scatterlist: Add flag for indicating P2PDMA segments in an SGL
>    dma-direct: Support PCI P2PDMA pages in dma-direct map_sg
>    dma-mapping: Add flags to dma_map_ops to indicate PCI P2PDMA support
>    iommu/dma: Support PCI P2PDMA pages in dma-iommu map_sg
>    block: Add BLK_STS_P2PDMA
>    nvme-pci: Check DMA ops when indicating support for PCI P2PDMA
>    nvme-pci: Convert to using dma_map_sg for p2pdma pages
> 
>   block/blk-core.c            |  2 +
>   drivers/iommu/dma-iommu.c   | 63 +++++++++++++++++++++-----
>   drivers/nvme/host/core.c    |  3 +-
>   drivers/nvme/host/nvme.h    |  2 +-
>   drivers/nvme/host/pci.c     | 38 +++++++---------
>   drivers/pci/Kconfig         |  2 +-
>   drivers/pci/p2pdma.c        | 89 +++++++++++++++++++++++++++++++------
>   include/linux/blk_types.h   |  7 +++
>   include/linux/dma-map-ops.h |  3 ++
>   include/linux/dma-mapping.h |  5 +++
>   include/linux/pci-p2pdma.h  | 11 +++++
>   include/linux/scatterlist.h | 49 ++++++++++++++++++--
>   kernel/dma/direct.c         | 35 +++++++++++++--
>   kernel/dma/mapping.c        | 21 +++++++--
>   14 files changed, 271 insertions(+), 59 deletions(-)
> 
> 
> base-commit: a38fd8748464831584a19438cbb3082b5a2dab15
> --
> 2.20.1
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
> 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
