Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AC87C48BF6
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Mar 2024 16:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=60EtCnJ2FcNiwpYPsbvwvWYPwkzfqNpyu9Z59YrAUNk=; b=yuoJ8aufvpMck37EIDHv99tZLp
	u10oEAQBp+6pqAEZTV6/B5mkTkUsqFWTWyYPK1BiIeHSlxJF6mDWfKhdU/ZRScCiQrHL+BTcZZDN+
	ZTUa0ToWT/03wuHYJ6WUMVZ+niphWLJrjB+HdlqBFKzLQYXeM2Bs5PJnsS+jb61vfhB55zY2e5Z7S
	r+D41V55OCBb5CdMFR5jHn0WxvDFnH8X5Qm4umoAx7bBjQOWm9gJiyS+okea2X1RR4KK/NrGecckE
	sxwMYiuqTYKWjDrUd0BW/EHQ/u8cgvU3OEbs0IwPMh3fgCmXOkxCUCsMADt5zlciOWPmS7tNKDED+
	QYVN7F4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riGJC-00000005QCD-1DN8;
	Thu, 07 Mar 2024 16:09:26 +0000
Received: from out-187.mta1.migadu.com ([95.215.58.187])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ri6or-00000003CyG-00su
	for linux-nvme@lists.infradead.org;
	Thu, 07 Mar 2024 06:01:31 +0000
Message-ID: <afc34f07-ff4c-4947-a203-ef244dcf43e8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709791277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=60EtCnJ2FcNiwpYPsbvwvWYPwkzfqNpyu9Z59YrAUNk=;
	b=UdrEz7IpJ/hQTxYW/BcPojv+mE+JtKstiGC5/ykSqHqvqIVDyZD9EJtSOWlo6ETYFVgqq8
	fosDmVE2Q9bLFrmKiozlqtdTnlwbbSCfR4CsiQiKbX+TKJa6MWcCol072W3TBMYup5s85G
	WD3PQttcSGwrC7B3Ln676VsoeTLnDmg=
Date: Thu, 7 Mar 2024 07:01:10 +0100
MIME-Version: 1.0
Subject: Re: [RFC RESEND 00/16] Split IOMMU DMA mapping operation to two steps
To: Leon Romanovsky <leon@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Robin Murphy <robin.murphy@arm.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Yishai Hadas <yishaih@nvidia.com>,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 Kevin Tian <kevin.tian@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 linux-rdma@vger.kernel.org, iommu@lists.linux.dev,
 linux-nvme@lists.infradead.org, kvm@vger.kernel.org, linux-mm@kvack.org,
 Bart Van Assche <bvanassche@acm.org>,
 Damien Le Moal <damien.lemoal@opensource.wdc.com>,
 Amir Goldstein <amir73il@gmail.com>,
 "josef@toxicpanda.com" <josef@toxicpanda.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "daniel@iogearbox.net" <daniel@iogearbox.net>,
 Dan Williams <dan.j.williams@intel.com>, "jack@suse.com" <jack@suse.com>,
 Leon Romanovsky <leonro@nvidia.com>, Zhu Yanjun <zyjzyj2000@gmail.com>
References: <cover.1709635535.git.leon@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <cover.1709635535.git.leon@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240306_220129_365525_933D3A26 
X-CRM114-Status: GOOD (  25.07  )
X-Mailman-Approved-At: Thu, 07 Mar 2024 08:09:15 -0800
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

在 2024/3/5 12:18, Leon Romanovsky 写道:
> This is complimentary part to the proposed LSF/MM topic.
> https://lore.kernel.org/linux-rdma/22df55f8-cf64-4aa8-8c0b-b556c867b926@linux.dev/T/#m85672c860539fdbbc8fe0f5ccabdc05b40269057

I am interested in this topic. Hope I can join the meeting to discuss 
this topic.

Zhu Yanjun

> 
> This is posted as RFC to get a feedback on proposed split, but RDMA, VFIO and
> DMA patches are ready for review and inclusion, the NVMe patches are still in
> progress as they require agreement on API first.
> 
> Thanks
> 
> -------------------------------------------------------------------------------
> The DMA mapping operation performs two steps at one same time: allocates
> IOVA space and actually maps DMA pages to that space. This one shot
> operation works perfectly for non-complex scenarios, where callers use
> that DMA API in control path when they setup hardware.
> 
> However in more complex scenarios, when DMA mapping is needed in data
> path and especially when some sort of specific datatype is involved,
> such one shot approach has its drawbacks.
> 
> That approach pushes developers to introduce new DMA APIs for specific
> datatype. For example existing scatter-gather mapping functions, or
> latest Chuck's RFC series to add biovec related DMA mapping [1] and
> probably struct folio will need it too.
> 
> These advanced DMA mapping APIs are needed to calculate IOVA size to
> allocate it as one chunk and some sort of offset calculations to know
> which part of IOVA to map.
> 
> Instead of teaching DMA to know these specific datatypes, let's separate
> existing DMA mapping routine to two steps and give an option to advanced
> callers (subsystems) perform all calculations internally in advance and
> map pages later when it is needed.
> 
> In this series, three users are converted and each of such conversion
> presents different positive gain:
> 1. RDMA simplifies and speeds up its pagefault handling for
>     on-demand-paging (ODP) mode.
> 2. VFIO PCI live migration code saves huge chunk of memory.
> 3. NVMe PCI avoids intermediate SG table manipulation and operates
>     directly on BIOs.
> 
> Thanks
> 
> [1] https://lore.kernel.org/all/169772852492.5232.17148564580779995849.stgit@klimt.1015granger.net
> 
> Chaitanya Kulkarni (2):
>    block: add dma_link_range() based API
>    nvme-pci: use blk_rq_dma_map() for NVMe SGL
> 
> Leon Romanovsky (14):
>    mm/hmm: let users to tag specific PFNs
>    dma-mapping: provide an interface to allocate IOVA
>    dma-mapping: provide callbacks to link/unlink pages to specific IOVA
>    iommu/dma: Provide an interface to allow preallocate IOVA
>    iommu/dma: Prepare map/unmap page functions to receive IOVA
>    iommu/dma: Implement link/unlink page callbacks
>    RDMA/umem: Preallocate and cache IOVA for UMEM ODP
>    RDMA/umem: Store ODP access mask information in PFN
>    RDMA/core: Separate DMA mapping to caching IOVA and page linkage
>    RDMA/umem: Prevent UMEM ODP creation with SWIOTLB
>    vfio/mlx5: Explicitly use number of pages instead of allocated length
>    vfio/mlx5: Rewrite create mkey flow to allow better code reuse
>    vfio/mlx5: Explicitly store page list
>    vfio/mlx5: Convert vfio to use DMA link API
> 
>   Documentation/core-api/dma-attributes.rst |   7 +
>   block/blk-merge.c                         | 156 ++++++++++++++
>   drivers/infiniband/core/umem_odp.c        | 219 +++++++------------
>   drivers/infiniband/hw/mlx5/mlx5_ib.h      |   1 +
>   drivers/infiniband/hw/mlx5/odp.c          |  59 +++--
>   drivers/iommu/dma-iommu.c                 | 129 ++++++++---
>   drivers/nvme/host/pci.c                   | 220 +++++--------------
>   drivers/vfio/pci/mlx5/cmd.c               | 252 ++++++++++++----------
>   drivers/vfio/pci/mlx5/cmd.h               |  22 +-
>   drivers/vfio/pci/mlx5/main.c              | 136 +++++-------
>   include/linux/blk-mq.h                    |   9 +
>   include/linux/dma-map-ops.h               |  13 ++
>   include/linux/dma-mapping.h               |  39 ++++
>   include/linux/hmm.h                       |   3 +
>   include/rdma/ib_umem_odp.h                |  22 +-
>   include/rdma/ib_verbs.h                   |  54 +++++
>   kernel/dma/debug.h                        |   2 +
>   kernel/dma/direct.h                       |   7 +-
>   kernel/dma/mapping.c                      |  91 ++++++++
>   mm/hmm.c                                  |  34 +--
>   20 files changed, 870 insertions(+), 605 deletions(-)
> 


