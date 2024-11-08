Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57404D64085
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Nov 2024 20:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SdL8Q8EQQQJJ8xM8160z/ZDZmIkZmULZbC6xpHvhB2g=; b=3X8MGtHXyRGqAoKfaJDAnerJD0
	GRfMpAIJQCgLeCK2gVyL5hEdl92Ueupx1BfRnfiwHeL0x2Zu5rP8qjQ8w9cVBC/YGnGV7XGW5YGt8
	TYuQzWhNLQ7uMNcUeZYFJPzhc6obAXFvr225vwUAqgJzhoIE6N1kWCMLxDGMS+eEbeyp1u4a3MtzY
	bDu6BQYD+3lznWwOtyQEluXBgaxIw84FzYQJyxnW1NQl5oy2GLclJUbF5M7y73++OPqi7iXd66/Hb
	tqVFqj3KDyIzL2HXCj/iIFR58MFNFLHJ3fpumPvBSB5Wi73eEGaBjk2gqid8Bcp0SfD0HR0sRSAyM
	hcB6DGXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t9VMK-0000000Bqrd-2jfD;
	Fri, 08 Nov 2024 20:13:32 +0000
Received: from ms.lwn.net ([45.79.88.28])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t9VMH-0000000BqrJ-3OYl
	for linux-nvme@lists.infradead.org;
	Fri, 08 Nov 2024 20:13:30 +0000
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 5DC3F42C17
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1731096808; bh=SdL8Q8EQQQJJ8xM8160z/ZDZmIkZmULZbC6xpHvhB2g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=SGj7NgT5pCq9qMZMXNJKG2UgQ/lP9zZE4YbKvUXqgPrUznXNr6/HcfYciET1a180c
	 4CQEBIeK0nih1ZtSbGeYgYPx/hYb6yPDREd8OyH5nekdazyQhbd0FntwwvCDHijkAQ
	 AiRe9/OS3QLp/eLystk6jgqxf76GfzScZi/3peY4z6raTJ/W27faMyuX0o0Qblo8bn
	 kulpZfzb4/cWAHAGIm0JQYi2CeCfIdC74UulY5RY8yhiiQV9VTsz3uVWHk/HuMjiz7
	 crwtMtMpBsv4BAZjxgb2arxdBkDSSgw/l0R41+5urv/u4+CiW8A60jFzuPQy7tWs5l
	 BT3AAiFW7pn8Q==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 5DC3F42C17;
	Fri,  8 Nov 2024 20:13:28 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Leon Romanovsky <leon@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Jason Gunthorpe <jgg@ziepe.ca>, Robin
 Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon
 <will@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg
 <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>, Bjorn Helgaas
 <bhelgaas@google.com>, Logan Gunthorpe <logang@deltatee.com>, Yishai Hadas
 <yishaih@nvidia.com>, Shameer Kolothum
 <shameerali.kolothum.thodi@huawei.com>, Kevin Tian <kevin.tian@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>, Marek Szyprowski
 <m.szyprowski@samsung.com>, =?utf-8?B?SsOpcsO0bWU=?= Glisse
 <jglisse@redhat.com>, Andrew
 Morton <akpm@linux-foundation.org>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 linux-rdma@vger.kernel.org, iommu@lists.linux.dev,
 linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
 kvm@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v1 09/17] docs: core-api: document the IOVA-based API
In-Reply-To: <20241108200355.GC189042@unreal>
References: <cover.1730298502.git.leon@kernel.org>
 <881ef0bcf9aa971e995fbdd00776c5140a7b5b3d.1730298502.git.leon@kernel.org>
 <87ttchwmde.fsf@trenco.lwn.net> <20241108200355.GC189042@unreal>
Date: Fri, 08 Nov 2024 13:13:27 -0700
Message-ID: <87h68hwkk8.fsf@trenco.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241108_121329_869127_3D7198C9 
X-CRM114-Status: UNSURE (   9.75  )
X-CRM114-Notice: Please train this message.
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

>> So, I see that you have nice kernel-doc comments for these; why not just
>> pull them in here with a kernel-doc directive rather than duplicating
>> the information?
>
> Can I you please point me to commit/lore link/documentation with example
> of such directive and I will do it?

Documentation/doc-guide/kernel-doc.rst has all the information you need.
It could be as simple as replacing your inline descriptions with:

  .. kernel-doc:: drivers/iommu/dma-iommu.c
     :export:

That will pull in documentation for other, unrelated functions, though;
assuming you don't want those, something like:

  .. kernel-doc:: drivers/iommu/dma-iommu.c
     :identifiers: dma_iova_try_alloc dma_iova_free ...

Then do a docs build and see the nice results you get :)

Thanks,

jon

