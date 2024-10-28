Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 968DCD339AF
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Oct 2024 18:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XkRQbbGrVf4rrr5cMxTvJOT45oNcYX7llT98sSv7VZo=; b=ey4+UO3hDyKyt7
	66Lr8kYHA3BLHG97bAEIEB/ZC/j921c4WMb72DFI+tG9C8xLD9RvCq/pu9CEeGvXHEJIeirjrF2ko
	JQicr8cFVPNT9+txvszdZ+Et/ZSS4IyMA6NkX64uLoIMqbIz8TjpBW0BogfjItVvNFkalsj202/R+
	R/Puh7mo4eS8oWPa1tBkOmEbDUloNkIs/lzJvt/YHWud4clE73W+1p6K3Gq1a9sHIe8ny39BRGDPV
	IojryUv+Rly/72YUWm/K7Dxlev+nlfhAvBOFHiDYYP3ayvy0LNvmU3vnhtofEMBzAUnrtEiYCrroW
	Cm4JRt4WNt0yRc3evlZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t5UGN-0000000BmK9-0aGW;
	Mon, 28 Oct 2024 18:14:47 +0000
Received: from ale.deltatee.com ([204.191.154.188])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5UDH-0000000BlU9-3YL9
	for linux-nvme@lists.infradead.org;
	Mon, 28 Oct 2024 18:11:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=XkRQbbGrVf4rrr5cMxTvJOT45oNcYX7llT98sSv7VZo=; b=JDRSep6mTleN4lkjA/J5iVMkPF
	enS4BrqlKpXbUgGqj0gabosZW4pW3JjatpcFhM3DewTJK7z2aAAQVvoOHfRG/cTtVotC207Q8IteD
	y61OMLXkHOQF9oMjKtKYq2pRcintw+ND38R50Dr1WBpiurGK2jzQCpfX6Kjf+96dinFHyVhIrrH00
	6irNqWX9Bvna8pEgCL4qasIeorvDZbuO1vkEIi4h/AR2RSvixYRIYlgi0obvTHIxWc8HfI+MuG85h
	EB6WlZ71HR4+V6Cpi2WJoAAa1FCmqsr+QgpfGVgfQWMWrd3M1aPok7jNXxZOtoMskN5+ZjbxkFfKb
	qnN+84Og==;
Received: from d104-157-31-28.abhsia.telus.net ([104.157.31.28] helo=[192.168.1.250])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <logang@deltatee.com>)
	id 1t5UCs-002ZVS-2K;
	Mon, 28 Oct 2024 12:11:11 -0600
Message-ID: <d6dec059-bcc8-4f86-81fa-ba7d77478161@deltatee.com>
Date: Mon, 28 Oct 2024 12:11:10 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Leon Romanovsky <leon@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Jason Gunthorpe <jgg@ziepe.ca>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: Keith Busch <kbusch@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Yishai Hadas <yishaih@nvidia.com>,
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
References: <cover.1730037276.git.leon@kernel.org>
 <27698e7cc55f6ca5371c3d86c50fd3afce9afddd.1730037276.git.leon@kernel.org>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <27698e7cc55f6ca5371c3d86c50fd3afce9afddd.1730037276.git.leon@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 104.157.31.28
X-SA-Exim-Rcpt-To: leon@kernel.org, axboe@kernel.dk, jgg@ziepe.ca, robin.murphy@arm.com, joro@8bytes.org, will@kernel.org, hch@lst.de, sagi@grimberg.me, kbusch@kernel.org, bhelgaas@google.com, yishaih@nvidia.com, shameerali.kolothum.thodi@huawei.com, kevin.tian@intel.com, alex.williamson@redhat.com, m.szyprowski@samsung.com, jglisse@redhat.com, akpm@linux-foundation.org, corbet@lwn.net, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, linux-rdma@vger.kernel.org, iommu@lists.linux.dev, linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH 02/18] dma-mapping: move the PCI P2PDMA mapping helpers to
 pci-p2pdma.h
X-SA-Exim-Version: 4.2.1 (built Wed, 06 Jul 2022 17:57:39 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241028_111135_972776_2E19EA7F 
X-CRM114-Status: GOOD (  13.81  )
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



On 2024-10-27 08:21, Leon Romanovsky wrote:
> From: Christoph Hellwig <hch@lst.de>
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
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Also looks good. Thanks!

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

