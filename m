Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3992DC54E64
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Mar 2024 15:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xXL8mTjTP5S9vZ7aNebXqUEU0f1h4hEFoj78rP+4Kx4=; b=w1pfS/ZE45KfexZJAfEJj9zS1S
	oX884l/wSWLV/xkqSOjm1J1RKKu/kH2pmU2o7vf/kB2aK6vMMg3jtWvRewI4Jh+jtOvutdG9MEaX/
	mbqLFyUZ9PmEtS01xD8tkFaohluQ+mIGPNMhxSYBaLfY4UpMzB387UaYccR+nqxAR7TvyCoeTkECA
	5Wt3MvzPf9qe0VjmxwmJaRsKXP6hUkFdj9f6nj5jZ37Jp5icXn8p+RmSssfwgshHlK9S4pPgto2Z7
	kZAZSBlwf0GoSPXTcieid58fOyd3tjhHKm9j5WJFl+YVRgnoJisuNzOyzPQBTsoRAyNBebwQBzwJ7
	facRjjEg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rprM3-0000000ESHF-1ydC;
	Thu, 28 Mar 2024 15:07:47 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1roX4r-0000000Dny0-2dGX
	for linux-nvme@lists.infradead.org;
	Sun, 24 Mar 2024 23:16:36 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 38CAF68D13; Mon, 25 Mar 2024 00:16:12 +0100 (CET)
Date: Mon, 25 Mar 2024 00:16:11 +0100
From: Christoph Hellwig <hch@lst.de>
To: Leon Romanovsky <leon@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	=?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
	iommu@lists.linux.dev, linux-nvme@lists.infradead.org,
	kvm@vger.kernel.org, linux-mm@kvack.org,
	Bart Van Assche <bvanassche@acm.org>,
	Damien Le Moal <damien.lemoal@opensource.wdc.com>,
	Amir Goldstein <amir73il@gmail.com>,
	"josef@toxicpanda.com" <josef@toxicpanda.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>,
	Dan Williams <dan.j.williams@intel.com>,
	"jack@suse.com" <jack@suse.com>, Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: Re: [RFC RESEND 00/16] Split IOMMU DMA mapping operation to two
 steps
Message-ID: <20240324231611.GB20765@lst.de>
References: <20240307000036.GP9225@ziepe.ca> <20240307150505.GA28978@lst.de> <20240307210116.GQ9225@ziepe.ca> <20240308164920.GA17991@lst.de> <20240308202342.GZ9225@ziepe.ca> <20240309161418.GA27113@lst.de> <20240319153620.GB66976@ziepe.ca> <20240320085536.GA14887@unreal> <20240321224013.GB22663@lst.de> <20240322174617.GD14887@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240322174617.GD14887@unreal>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240324_161634_331190_E0362DB0 
X-CRM114-Status: GOOD (  16.72  )
X-Mailman-Approved-At: Thu, 28 Mar 2024 08:07:42 -0700
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

On Fri, Mar 22, 2024 at 07:46:17PM +0200, Leon Romanovsky wrote:
> > As far as I can tell it totally misses the point.  Which is not to never
> > return non-P2P if the flag is set, but to return either all P2P or non-P2
> > P and not create a boundary in the single call.
> 
> You are treating FOLL_PCI_P2PDMA as a hint, but in iov_iter_extract_user_pages()
> you set it only for p2p queues. I was under impression that you want only p2p pages
> in these queues.

FOLL_PCI_P2PDMA is an indicator that the caller can cope with P2P
pages.  Most callers simply can't.


