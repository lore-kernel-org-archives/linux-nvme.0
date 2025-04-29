Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15A4FC369D5
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Apr 2025 02:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=huM/tgGcaZwPudPnaiIVHVl7/1hpre28NQSePvKpSGE=; b=Lq3XamJWs92FIw6dTKKkSvLXbl
	rpY8JOIao+LiHf/zf1ceAqypEf6mUps+sIidAwMqtW1lqnvY7LvCGwwlD3ISLyNkG9KQF/j3Np3Gm
	owK99q/2a/qzMW7IxIKlECv4yMQmm5nnWfYkKsqfymzXN/neZMQRQ28VHu1v3JynYZIfFK31ZWYIE
	PtEZ5M3QcYCek0qsdUBlXIZtgT0DFwuG80+fn+Me78w4nYzeFXUuRu4C+8+r+tdYXGMHyb3mrLwYx
	WwENr9298VcexgL5NGNMJNjwJC9pYslQEO6cseubC1o9BPf8Yrm+I0/hUHV9S0m9x+VHnzW4yrV6l
	0mipxwNw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9ajt-000000086Ba-0lJ0;
	Tue, 29 Apr 2025 02:30:29 +0000
Received: from mgamail.intel.com ([192.198.163.15])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9aTP-0000000841Q-1AkY
	for linux-nvme@lists.infradead.org;
	Tue, 29 Apr 2025 02:13:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745892807; x=1777428807;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=cl37MECxv3M+3URhi+36RMhj2hMQV9W9XGD1Q2/sh04=;
  b=B4L2ARhF6GoDHRyxqyh4tjofpA2OIoFxkb2gRnCKC0AO1UKhRI+TGiZ8
   HNL4yk1PwdezhiF7+cOa89vfA/l/WLXoy4KvDtybeB20Rs4lMdGDS/iXR
   6c5AnTNp/3o/hVBZPn5GSqd6L/9De9txu0n54Ku/na4DDGkSyIhlwjhpq
   tftOS/ODFEu6tbt1BwXAwi43YcKD3TUzpxWBmADZ5SkLL5/8sg0cVkZFL
   WoL18Z04woaPZH7BS9ZESbjjrgf6TQeIHv18HgHUA5grVfM24HHA9PQG3
   eeBT8mxhQoz/Uw0yywD8+DSUORV9hSGrlCfNYshaCu4IMnLbx2bpGOBma
   w==;
X-CSE-ConnectionGUID: HN8xws9kQPuItLjkaucNFw==
X-CSE-MsgGUID: +8UeIlGCS/GoecEKXC4k4g==
X-IronPort-AV: E=McAfee;i="6700,10204,11417"; a="47641311"
X-IronPort-AV: E=Sophos;i="6.15,247,1739865600"; 
   d="scan'208";a="47641311"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2025 19:13:27 -0700
X-CSE-ConnectionGUID: vTMeR4UxT2GBmzm6ilMYHw==
X-CSE-MsgGUID: qu1jwlhkTHumLQTjOKxa+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,247,1739865600"; 
   d="scan'208";a="137721865"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2025 19:13:19 -0700
Message-ID: <abbb616e-9ca2-4811-8721-9aa746a4d600@linux.intel.com>
Date: Tue, 29 Apr 2025 10:09:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 02/24] dma-mapping: move the PCI P2PDMA mapping
 helpers to pci-p2pdma.h
To: Leon Romanovsky <leon@kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc: Jake Edge <jake@lwn.net>, Jonathan Corbet <corbet@lwn.net>,
 Jason Gunthorpe <jgg@ziepe.ca>, Zhu Yanjun <zyjzyj2000@gmail.com>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Bjorn Helgaas <bhelgaas@google.com>, Logan Gunthorpe <logang@deltatee.com>,
 Yishai Hadas <yishaih@nvidia.com>,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 Kevin Tian <kevin.tian@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 linux-rdma@vger.kernel.org, iommu@lists.linux.dev,
 linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
 kvm@vger.kernel.org, linux-mm@kvack.org,
 Niklas Schnelle <schnelle@linux.ibm.com>,
 Chuck Lever <chuck.lever@oracle.com>, Luis Chamberlain <mcgrof@kernel.org>,
 Matthew Wilcox <willy@infradead.org>, Dan Williams
 <dan.j.williams@intel.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Chaitanya Kulkarni <kch@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>
References: <cover.1745831017.git.leon@kernel.org>
 <1c9f2a2e97f77d6eebb5e19651723c0459e0dc29.1745831017.git.leon@kernel.org>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <1c9f2a2e97f77d6eebb5e19651723c0459e0dc29.1745831017.git.leon@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250428_191327_344290_0AB252B1 
X-CRM114-Status: GOOD (  12.52  )
X-Mailman-Approved-At: Mon, 28 Apr 2025 19:30:27 -0700
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

On 4/28/25 17:22, Leon Romanovsky wrote:
> From: Christoph Hellwig<hch@lst.de>
> 
> To support the upcoming non-scatterlist mapping helpers, we need to go
> back to have them called outside of the DMA API.  Thus move them out of
> dma-map-ops.h, which is only for DMA API implementations to pci-p2pdma.h,
> which is for driver use.
> 
> Note that the core helper is still not exported as the mapping is
> expected to be done only by very highlevel subsystem code at least for
> now.
> 
> Signed-off-by: Christoph Hellwig<hch@lst.de>
> Reviewed-by: Logan Gunthorpe<logang@deltatee.com>
> Acked-by: Bjorn Helgaas<bhelgaas@google.com>
> Tested-by: Jens Axboe<axboe@kernel.dk>
> Reviewed-by: Luis Chamberlain<mcgrof@kernel.org>
> Signed-off-by: Leon Romanovsky<leonro@nvidia.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

