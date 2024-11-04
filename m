Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA7FCD132A3
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Nov 2024 09:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cejgD+JsxZqAlNgtg45X0wzmaS1EcMCbAdOV/14Efl8=; b=pdrr7zr0vF4PZvtd8XXPz44qgw
	9pFP3sD8KpN793vdGorRPN0S15Rk/J/D4sx7ZyNcEsgIseJeEvlUg2zFIAOyGxKM4aruLh/tMev7F
	1tfLEHI+sBPrcZdzy9Qky6WFbm1GU4LTzWq0hBk01ATdLCfGjwI61J9wqG6BKT3zT1/wzGN0Jth8O
	0RWD7w5QijFxJsP4FIceJgl1gA3RHjJqFfsk2l7smc/OIVLLWuvPhF2NMFYE17/jtxSsldKtthh3f
	ZZ+of5Zk01td5mdQunvDzFiYAm+o3D2UqObzO4y6aBjvswcM4BFsYKE2v5W/yXVG1OtT9UjJ3qmXL
	nbE4BJ2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t7tJO-0000000D8wT-1Wlh;
	Mon, 04 Nov 2024 09:23:50 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t7tBX-0000000D7m1-3Wbg
	for linux-nvme@lists.infradead.org;
	Mon, 04 Nov 2024 09:15:45 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 95A03227AAD; Mon,  4 Nov 2024 10:15:38 +0100 (CET)
Date: Mon, 4 Nov 2024 10:15:38 +0100
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Leon Romanovsky <leon@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Jason Gunthorpe <jgg@ziepe.ca>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	=?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-rdma@vger.kernel.org, iommu@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
	kvm@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v1 08/17] dma-mapping: add a dma_need_unmap helper
Message-ID: <20241104091538.GB25041@lst.de>
References: <cover.1730298502.git.leon@kernel.org> <00385b3557fa074865d37b0ac613d2cb28bcb741.1730298502.git.leon@kernel.org> <7e362d8b-c02a-4327-9c5d-af1c4725ddc7@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e362d8b-c02a-4327-9c5d-af1c4725ddc7@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241104_011544_050772_C63363D3 
X-CRM114-Status: GOOD (  21.57  )
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

On Thu, Oct 31, 2024 at 09:18:11PM +0000, Robin Murphy wrote:
>>   +/**
>> + * dma_need_unmap - does this device need dma_unmap_* operations
>> + * @dev: device to check
>> + *
>> + * If this function returns %false, drivers can skip calling dma_unmap_* after
>> + * finishing an I/O.  This function must be called after all mappings that might
>> + * need to be unmapped have been performed.
>
> In terms of the unmap call itself, why don't we just use dma_skip_sync to 
> short-cut dma_direct_unmap_*() and make sure it's as cheap as possible?
>
> In terms of not having to unmap implying not having to store addresses at 
> all, it doesn't seem super-useful when you still have to store them for 
> long enough to find out that you don't :/

I don't fully understand the comment, mostly because the way I read the
two sentences appear to contradict each other.

Bypassing dma_direct_unmap_ is not the important part, because it already
is pretty cheap.  Storing the addresses is not.

That being said now that we never check need_unmap in the iova path
it might make sense to not have a separate helper, but it needs to
be exposed and documented.


