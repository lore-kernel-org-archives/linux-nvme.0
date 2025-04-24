Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 674CFC369C2
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Apr 2025 12:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/XklnL33mAqjfgTc8xOBHGB4/KdOSZM8qUFg0CXXjsY=; b=J7uqOhZGqR5UuTtRSLB+NbdFNO
	9BoAnhqwx/masvvrLXNN+sWUIyvQsKBZks7KVlWIZT+ndJdItzdzmaLz+0YFSvXMCJNuD3DTPSmS5
	wSZ1if+7+iJHvV+Rd45NHQDgWr9xVWAySnOvhbN67N+c/D5V08fsQodR6DdMqWzf5U7ks74yt5/be
	kXtal7n0krXHFEyrefHkjRpksK2XsCPI7/20cY5YnxREyc07IUnHMW8WapakU1Wiiv1jLaGa0Xcby
	JVqrPAUm6/LSn4TdkgT43/7+96Ul6VWl9aVDbnAcFD1r3alkdb6RN/xBeLoXZBa/+gYRfNjUoFBZU
	IKq0zNRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7vSB-0000000DzPI-3D4Y;
	Thu, 24 Apr 2025 12:13:19 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7rfv-0000000DI8q-3EBr
	for linux-nvme@bombadil.infradead.org;
	Thu, 24 Apr 2025 08:11:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/XklnL33mAqjfgTc8xOBHGB4/KdOSZM8qUFg0CXXjsY=; b=SUFYmVg3cqQ8Ry5XJuH/xDsYuR
	IIjblSuts7/kmD3EWrSz8IHNAY0wNT7kP/xwSk1CIeIyZwpsCms2PNBMVUC0D4YZa3CGST/RE0dFl
	o58FXXa//FZO7yJi4mma2jsKKAchRDTRLru7AfYWQWVT/p2ybBcUD7P+qNjZvO5ZN9Ra55czEA6RN
	UWNxzvPOVwz7CpoOh78Omik382Q2E0DaoOoDYcjDgoNh5UW1RsTxhn1Wdu4HBPHv5MUwRl+7wD/sD
	uCOKEC3YygOkxYRttUqnnsex052xUuK34wZu3YyZEry+zy4xZEyvCaHgnnG1YDjK3aqx7bftVnrph
	tBrmlaFQ==;
Received: from verein.lst.de ([213.95.11.211])
	by desiato.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u7rfr-0000000BbQD-2u7B
	for linux-nvme@lists.infradead.org;
	Thu, 24 Apr 2025 08:11:14 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2F45667373; Thu, 24 Apr 2025 10:11:01 +0200 (CEST)
Date: Thu, 24 Apr 2025 10:11:01 +0200
From: Christoph Hellwig <hch@lst.de>
To: Leon Romanovsky <leon@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Mika =?iso-8859-1?Q?Penttil=E4?= <mpenttil@redhat.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>, Jake Edge <jake@lwn.net>,
	Jonathan Corbet <corbet@lwn.net>, Zhu Yanjun <zyjzyj2000@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	=?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
	iommu@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-pci@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH v9 10/24] mm/hmm: let users to tag specific PFN with
 DMA mapped bit
Message-ID: <20250424081101.GA22989@lst.de>
References: <cover.1745394536.git.leon@kernel.org> <0a7c1e06269eee12ff8912fe0da4b7692081fcde.1745394536.git.leon@kernel.org> <7185c055-fc9e-4510-a9bf-6245673f2f92@redhat.com> <20250423181706.GT1213339@ziepe.ca> <36891b0e-d5fa-4cf8-a181-599a20af1da3@redhat.com> <20250423233335.GW1213339@ziepe.ca> <20250424080744.GP48485@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424080744.GP48485@unreal>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250424_091111_819248_03DD81C1 
X-CRM114-Status: GOOD (  14.02  )
X-Mailman-Approved-At: Thu, 24 Apr 2025 04:18:00 -0700
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

On Thu, Apr 24, 2025 at 11:07:44AM +0300, Leon Romanovsky wrote:
> > I see, so yes order occupies 5 bits [-4,-5,-6,-7,-8] and the
> > DMA_MAPPED overlaps, it should be 9 not 7 because of the backwardness.
> 
> Thanks for the fix.

Maybe we can use the chance to make the scheme less fragile?  i.e.
put flags in the high bits and derive the first valid bit from the
pfn order?

