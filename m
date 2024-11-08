Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29657D64080
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Nov 2024 19:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2mf7KL6RauZLJCGVMslddkfvUkwUMRQBSzo8JS8PbOo=; b=4jDGP9/ANo31zg5TIjitUNgeri
	Vwq9Epxb3+fZe/450rd6GYv16E1Jdafi4ILryQVJeWrdPAKC5rgLrS/MvKhWMOr7Dc4pAQjKgUJrC
	6ykIACVBpgCclHHZFThtkp4VABmjI03ojMZEuPwnrnG5AHQQA02bEXWwy2BAObUMz6COgHvem8TDF
	GKqnJMC0+Gh0VftWF+WIbnwdjV5/A39WgPHbsYN0GthVs+Of3lhoaeMm9b4pXS1nl8gVGm6w5Nviw
	5v1naKJZvji12W2yPmNZ5opfCAuFv0j1GTwWOywJ+0ggZZgfdxhjol/nNNUIxJlx1/iF7Dbw9N1DT
	wxgFB4IA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t9UkW-0000000BkRQ-3eqy;
	Fri, 08 Nov 2024 19:34:28 +0000
Received: from ms.lwn.net ([2600:3c01:e000:3a1::42])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t9UkU-0000000BkQl-1nyW
	for linux-nvme@lists.infradead.org;
	Fri, 08 Nov 2024 19:34:27 +0000
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 443C842C17
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1731094462; bh=2mf7KL6RauZLJCGVMslddkfvUkwUMRQBSzo8JS8PbOo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=dnsz5YfGWANp6sFnIUKjORH9aQENZDGixeRFgCKU+EHYtfew50seKAGvAytaFY9oj
	 05nxCVWbEfcD++04BAkjYS67T71ZQKhzyu6q3WZ8JM+Nq5axZuGUldvxslQ6IDBgXj
	 4TWkgRvZmPQDP4+rVCptcrXwBOfBXoMDeUZRH8Wp3ugkYqZvGKmWHOgN92MEiBDxr5
	 9u5STRUt+O2euSBwkgcMhfsaH0RnwMEO/iN2P0oM2sZd22f5AUcPoAVVdjXDvknK/o
	 T3zwqzKkVrYA3KBU7u+ycHZvQ7dYicPF4vGfmge7fq9Ntn0IbVNJL2+Ng+Nux9U4bj
	 j2d2WZj3WBcbQ==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 443C842C17;
	Fri,  8 Nov 2024 19:34:22 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Leon Romanovsky <leon@kernel.org>, Jens Axboe <axboe@kernel.dk>, Jason
 Gunthorpe <jgg@ziepe.ca>, Robin Murphy <robin.murphy@arm.com>, Joerg
 Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Christoph Hellwig
 <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: Keith Busch <kbusch@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Logan Gunthorpe <logang@deltatee.com>, Yishai Hadas <yishaih@nvidia.com>,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>, Kevin Tian
 <kevin.tian@intel.com>, Alex Williamson <alex.williamson@redhat.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>, =?utf-8?B?SsOpcsO0bWU=?=
 Glisse
 <jglisse@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
 iommu@lists.linux.dev, linux-nvme@lists.infradead.org,
 linux-pci@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v1 09/17] docs: core-api: document the IOVA-based API
In-Reply-To: <881ef0bcf9aa971e995fbdd00776c5140a7b5b3d.1730298502.git.leon@kernel.org>
References: <cover.1730298502.git.leon@kernel.org>
 <881ef0bcf9aa971e995fbdd00776c5140a7b5b3d.1730298502.git.leon@kernel.org>
Date: Fri, 08 Nov 2024 12:34:21 -0700
Message-ID: <87ttchwmde.fsf@trenco.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241108_113426_493615_D2520AB7 
X-CRM114-Status: GOOD (  19.51  )
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

Leon Romanovsky <leon@kernel.org> writes:

> From: Christoph Hellwig <hch@lst.de>
>
> Add an explanation of the newly added IOVA-based mapping API.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  Documentation/core-api/dma-api.rst | 70 ++++++++++++++++++++++++++++++
>  1 file changed, 70 insertions(+)
>
> diff --git a/Documentation/core-api/dma-api.rst b/Documentation/core-api/dma-api.rst
> index 8e3cce3d0a23..6095696a65a7 100644
> --- a/Documentation/core-api/dma-api.rst
> +++ b/Documentation/core-api/dma-api.rst
> @@ -530,6 +530,76 @@ routines, e.g.:::
>  		....
>  	}
>  
> +Part Ie - IOVA-based DMA mappings
> +---------------------------------
> +
> +These APIs allow a very efficient mapping when using an IOMMU.  They are an
> +optional path that requires extra code and are only recommended for drivers
> +where DMA mapping performance, or the space usage for storing the DMA addresses
> +matter.  All the consideration from the previous section apply here as well.
> +
> +::
> +
> +    bool dma_iova_try_alloc(struct device *dev, struct dma_iova_state *state,
> +		phys_addr_t phys, size_t size);
> +
> +Is used to try to allocate IOVA space for mapping operation.  If it returns
> +false this API can't be used for the given device and the normal streaming
> +DMA mapping API should be used.  The ``struct dma_iova_state`` is allocated
> +by the driver and must be kept around until unmap time.

So, I see that you have nice kernel-doc comments for these; why not just
pull them in here with a kernel-doc directive rather than duplicating
the information?

Thanks,

jon

