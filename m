Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCC94D13596
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Oct 2024 11:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:Cc:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2q8GANiJ1rQY2IO2E028oZkDcKvNDlvO5hi8LqfzTqM=; b=ysG97c7aVafGnaIoYmdxJC9eYg
	4wjgWx3KzJ5pTh03Ix/MaNp9VbmM7CwahBN5Kd5vkNG7MAj85M4u2ZIAcD7JqNto/Wb4x8A66N15z
	BvgLhAGp9LskuSgfcFVvQP0EM0wznPgJtvTTyXC8GL9dpdKx4XHFw2hjTrBs8GXXNI1NTNl8Co9UF
	Ghga6mDcTQmmqlXKY3CtDx8QSpJ4Y42ZaaA2US/RqxoAXK164CfPzlG/Ugt9lP/revR0pw648M2oI
	4mwGR0INA1bNrKFk8rWiCGhJm0wOBv+MRkpsCFUilp5JqcjtiDXya9gg1LPE0a3Mjp1GZtoWL+rHU
	MYn/Rfsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t5OAF-0000000AbjF-0fH8;
	Mon, 28 Oct 2024 11:44:03 +0000
Received: from mgamail.intel.com ([192.198.163.13])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5F4A-00000009GAA-0oVc
	for linux-nvme@lists.infradead.org;
	Mon, 28 Oct 2024 02:01:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730080870; x=1761616870;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=O3Ovtbf3MrmDzHqqK2oXEfGTFDsY4Dl/uMRNNzQ0jlU=;
  b=FEAgzFUHr3EQeuWhjCD3MszQyI86wPqnDx/ufKLi4m/0yXVv62m/0PdX
   Qb34JnriCtA7T64jegh2/b/ygqDorvKBw2ODy6ltR+yqCqlfmerDhpNG1
   DLqJIUQtzk1ueG0x9u1ZglHJWfAjIAgEiQVV7L2ZsCwCXcsn7qmMBN2ib
   caBi6uRteHLVW07jY7GM7ol+1yuZlXtzwshj0qfK7XQB45iur85AwtdZm
   QFnHEdXxT5aINA4SqwEKL2oEeueg/ApaXiXrTga0JvE74MDtu34m/QmM5
   gxaVbagNjoFTDRRaDpL1fsWSi2xAaK40GBg8JHWj7z597sKNXq5ehYJtH
   A==;
X-CSE-ConnectionGUID: nJQc7NJKShWgBz2GlAxmxg==
X-CSE-MsgGUID: rjPN6imMQCaw2fUil+3B4Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11238"; a="32530619"
X-IronPort-AV: E=Sophos;i="6.11,238,1725346800"; 
   d="scan'208";a="32530619"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2024 19:01:09 -0700
X-CSE-ConnectionGUID: qpBwISFYS46tXapmQ++WeA==
X-CSE-MsgGUID: cTaC7appS+WESSNDD4yrMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,238,1725346800"; 
   d="scan'208";a="104792722"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.238.0.51]) ([10.238.0.51])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2024 19:00:28 -0700
Message-ID: <6a9366a5-7c5b-449c-b259-8e2492aae2a1@linux.intel.com>
Date: Mon, 28 Oct 2024 10:00:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Leon Romanovsky <leonro@nvidia.com>,
 Keith Busch <kbusch@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Logan Gunthorpe <logang@deltatee.com>, Yishai Hadas <yishaih@nvidia.com>,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 Kevin Tian <kevin.tian@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
 iommu@lists.linux.dev, linux-nvme@lists.infradead.org,
 linux-pci@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 07/18] dma-mapping: Implement link/unlink ranges API
To: Leon Romanovsky <leon@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Jason Gunthorpe <jgg@ziepe.ca>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
References: <cover.1730037276.git.leon@kernel.org>
 <b434f2f6d3c601649c9b6973a2ec3ec2149bba37.1730037276.git.leon@kernel.org>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <b434f2f6d3c601649c9b6973a2ec3ec2149bba37.1730037276.git.leon@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241027_190110_314134_018ABDC4 
X-CRM114-Status: GOOD (  14.54  )
X-Mailman-Approved-At: Mon, 28 Oct 2024 04:44:00 -0700
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

On 2024/10/27 22:21, Leon Romanovsky wrote:
> +/**
> + * dma_iova_sync - Sync IOTLB
> + * @dev: DMA device
> + * @state: IOVA state
> + * @offset: offset into the IOVA state to sync
> + * @size: size of the buffer
> + * @ret: return value from the last IOVA operation
> + *
> + * Sync IOTLB for the given IOVA state. This function should be called on
> + * the IOVA-contigous range created by one ore more dma_iova_link() calls
> + * to sync the IOTLB.
> + */
> +int dma_iova_sync(struct device *dev, struct dma_iova_state *state,
> +		size_t offset, size_t size, int ret)
> +{
> +	struct iommu_domain *domain = iommu_get_dma_domain(dev);
> +	struct iommu_dma_cookie *cookie = domain->iova_cookie;
> +	struct iova_domain *iovad = &cookie->iovad;
> +	dma_addr_t addr = state->addr + offset;
> +	size_t iova_start_pad = iova_offset(iovad, addr);
> +
> +	addr -= iova_start_pad;
> +	size = iova_align(iovad, size + iova_start_pad);
> +
> +	if (!ret)
> +		ret = iommu_sync_map(domain, addr, size);
> +	if (ret)
> +		iommu_unmap(domain, addr, size);

It appears strange that mapping is not done in this helper, but
unmapping is added in the failure path. Perhaps I overlooked anything?
To my understanding, it should like below:

	return iommu_sync_map(domain, addr, size);

In the drivers that make use of this interface should do something like
below:

	ret = dma_iova_sync(...);
	if (ret)
		dma_iova_destroy(...)

> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(dma_iova_sync);

Thanks,
baolu

