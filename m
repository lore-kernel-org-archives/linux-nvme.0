Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42380C30653
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Jul 2024 10:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OP6M/6puZZYAtzxWxYhbePS6Z+ry0FzEZ2Qz5InwK/8=; b=cVAbZq0niyLwpRIiKm8cLTvQ2f
	8yYE6yOBLziODNZk0WQFEEdCpD7WcRYXxSrKpuepDSL4tQSURPi87MdBJnG3CT+ixYND7dj3VLANL
	/iGE26bhR/xa8e+IB7h5pYp/vKD4+cCXJJCe1MGa0AVd1IzjJ+SENDE3SI1Lhr+xTtTXB3qqAQAmj
	pp1/fkvjVFDu0oGGRzg0Ek21t5L7rJ2cgARrnqX5tDNMhdKdGp+4MczVBfLJ4s8Q1N1Qyl+qHGw0N
	0bXlAN3rkkujWDwTfO4f0xVEfGyVFR+GtF/aRseop8TXPCVhIOtFmMYntovr8DF8rSlBTraPnjxUJ
	T4dVlhFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOxbi-00000009t8y-15rS;
	Wed, 03 Jul 2024 10:53:02 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOxbf-00000009t7L-3hGl
	for linux-nvme@lists.infradead.org;
	Wed, 03 Jul 2024 10:53:01 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 9D9F8621CD;
	Wed,  3 Jul 2024 10:52:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 836CAC4AF0B;
	Wed,  3 Jul 2024 10:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720003978;
	bh=pPz+aKLXZOghQ7VtjQHusi+fj+NpFq4VHkcVX8X3bH8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nYd4RQLPNWY78pIbNAILafDzME2V0q1JxD04RIMzYEVRTvt89jlLKvJriZcMCuH2T
	 w96uRRv/Q4LrMA7qbS+tVVzGZ8TbYD4a7uxMEPOOXtyhfAZjqiLtWvl7qwC+YZD5Ba
	 v6Hluy8LaijXySSMoswEpGvrCLN3gkwpFP2bG31B2uIuuhMWFdHvJ6hmi9njK5bywp
	 geNwo4OuHZBuA495qG+lQBMrzBgxPLYgn8KinCmvDBq9hmAZenc9g0C6DeVOsibSX2
	 IVVgir3Al85xqpIrwp6ua76xZvzC0FWDuHMKCBDh5k2QhOV31v4/Nqa/LhITpDNtHG
	 1wsaj+G6o4oiw==
Date: Wed, 3 Jul 2024 13:52:53 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Jason Gunthorpe <jgg@ziepe.ca>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Keith Busch <kbusch@kernel.org>,
	"Zeng, Oak" <oak.zeng@intel.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	=?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, iommu@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
	kvm@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH v1 00/18] Provide a new two step DMA API mapping API
Message-ID: <20240703105253.GA95824@unreal>
References: <cover.1719909395.git.leon@kernel.org>
 <20240703054238.GA25366@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240703054238.GA25366@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240703_035300_007317_18C2F458 
X-CRM114-Status: GOOD (  12.79  )
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

On Wed, Jul 03, 2024 at 07:42:38AM +0200, Christoph Hellwig wrote:
> I just tried to boot this on my usual qemu test setup with emulated
> nvme devices, and it dead-loops with messages like this fairly late
> in the boot cycle:
> 
> [   43.826627] iommu: unaligned: iova 0xfff7e000 pa 0x000000010be33650 size 0x1000 min_pagesz 0x1000
> [   43.826982] dma_mapping_error -12
> 
> passing intel_iommu=off instead of intel_iommu=on (expectedly) makes
> it go away.

Can you please share your kernel command line and qemu?
On my and Chaitanya setups it works fine.

Thanks

