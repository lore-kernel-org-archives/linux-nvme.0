Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F0F0C2BD09
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Jul 2024 04:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hdkSprgXz1TOuzpRa551TU4TlZl7jkQZWLDN1cGr7Gs=; b=qFRsv2yGZOvQVMMx6nrjz8y8l9
	ZYUg5SVaDFoqAKdI9/l/ahxcUM5YLzKrhyVXbjSzaOCtvrNn97qIFqtOShhH4WAV5ulHz7srPvoJK
	kikyvwVgE0E0e6H2/fCPMBjkNqSNwixo9F8kxFgr6E2qhyY8aVprdNe9YhB7y8hSs/WAuDv+E+jWW
	WhubBvM1kmIyuHAeWRtLJNdJrk532ptvLMAqZHe3S8z1vuEYnneiqD5dXK60JhxouQgZPOxs3KdsQ
	r90NicWT5Yna4hmFRG0LNJaUYUK6y6pV+kYU3x4Q55U1gofv8MjHNSJxUy0daLYWMEN5wLlNwQDcB
	wX89cYbA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sS8Io-0000000GQGu-1vYc;
	Fri, 12 Jul 2024 04:54:38 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sS8Il-0000000GQDS-2Y2L
	for linux-nvme@lists.infradead.org;
	Fri, 12 Jul 2024 04:54:37 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1F8DD68BEB; Fri, 12 Jul 2024 06:54:23 +0200 (CEST)
Date: Fri, 12 Jul 2024 06:54:22 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Christoph Hellwig <hch@lst.de>, Leon Romanovsky <leon@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Keith Busch <kbusch@kernel.org>, "Zeng, Oak" <oak.zeng@intel.com>,
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
Message-ID: <20240712045422.GA4774@lst.de>
References: <cover.1719909395.git.leon@kernel.org> <20240705063910.GA12337@lst.de> <20240708235721.GF14050@ziepe.ca> <20240709062015.GB16180@lst.de> <20240709190320.GN14050@ziepe.ca> <20240710062212.GA25895@lst.de> <20240711232917.GR14050@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240711232917.GR14050@ziepe.ca>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240711_215435_812370_63846AA7 
X-CRM114-Status: GOOD (  16.71  )
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

On Thu, Jul 11, 2024 at 08:29:17PM -0300, Jason Gunthorpe wrote:
> So this little detail needs to be taken care of somehow as well, and I
> didn't see it in this RFC.

Yes.  Same about generally not mixing P2P and non-P2P.

> 
> > For the block layer just having one kind per BIO is fine right now,
> > although I could see use cases where people would want to combine
> > them.  We can probably defer that until it is needed, though.
> 
> Do you have an application in mind that would want multi-kind per BIO?

If you are doing say garbage collection in a file system, and do write
that sources data from multiple devices, where some sit directly on the
root port and others behind a switch.

This is all purely hypothetical, and I'm happy to just check for it
and reject it for it now.

