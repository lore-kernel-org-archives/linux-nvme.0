Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A991AD12D7C
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Nov 2024 07:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oNsOYhwe3JW6hSfJ5efdvKMwFIkCKEG0xoFj9AtdPRE=; b=a5+aPWdXMXKjlnmgFT/dzoKcdP
	x5WPAXPwEj+mdQGQrPspJOvkTerkEP83psI6CDipUL3xOmaF3uUGnTDZfaZNd8UnniIieoYUK+36X
	Nru7V1XWC91v8TsOjG8my8pd9d56GNapJpOKqcvq1OgLYP9oc4BghUR3Ro7GAc7qf+iTKnUFveM4M
	qv/fE1J9cqSqfIeKnLgP714NEhJU3aEt5FQxEpEM0v1ER7pUMm5iLF7/s7f07VuAjfPAUpMqLLO1f
	ZOFryGJ08khpfbrI4YHeq0/1xBipXggD3MECZS+UJG2rudiEs2aBFRce6HPVMVHbMAHlcaYSWk6/J
	I21IJw/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tAOlW-0000000GfAJ-1l5G;
	Mon, 11 Nov 2024 07:23:14 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tAO5J-0000000GVid-1TqR
	for linux-nvme@lists.infradead.org;
	Mon, 11 Nov 2024 06:39:39 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3F82B68C7B; Mon, 11 Nov 2024 07:39:32 +0100 (CET)
Date: Mon, 11 Nov 2024 07:39:32 +0100
From: Christoph Hellwig <hch@lst.de>
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: Leon Romanovsky <leon@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Jason Gunthorpe <jgg@ziepe.ca>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Leon Romanovsky <leonro@nvidia.com>,
	Keith Busch <kbusch@kernel.org>,
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
Subject: Re: [PATCH v1 04/17] dma-mapping: Add check if IOVA can be used
Message-ID: <20241111063932.GC23992@lst.de>
References: <cover.1730298502.git.leon@kernel.org> <9515f330b9615de92a1864ab46acbd95e32634b6.1730298502.git.leon@kernel.org> <5ea594b3-7451-4553-92c1-2590c8baef20@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ea594b3-7451-4553-92c1-2590c8baef20@linux.dev>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241110_223937_711851_FBF8ED66 
X-CRM114-Status: GOOD (  13.40  )
X-Mailman-Approved-At: Sun, 10 Nov 2024 23:23:12 -0800
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

On Sun, Nov 10, 2024 at 04:09:11PM +0100, Zhu Yanjun wrote:
>> +
>> +/*
>> + * Use the high bit to mark if we used swiotlb for one or more ranges.
>> + */
>> +#define DMA_IOVA_USE_SWIOTLB		(1ULL << 63)
>
> A trivial problem.
> In the above macro, using BIT_ULL(63) is better?

No, and can people please stop suggesting it?  That macro is so fucking
pointless that it's revolting,


