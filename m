Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56A86C369CB
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Apr 2025 17:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=l8sRLC6UVSm24vNkdQycXdmY0wx1+hh4Raw1PMph5OE=; b=drsMBChGcH2zTwyabOMS5AkWhO
	TR5K321aHOSDk4rmwKtOc4hhsR9a7QmvxVJEzukiaMFI5Bzsoct0nA8BHnP4ka5F5Vq0nJuhU7j/m
	nkywwIc75QQ82351w86dcw5Ko/lnDdS3Wx9yr5GN9KScBwT3WV3BEHVXUxwWf7TYosWN2H/0hDu8Y
	syCjX5rz9v0gFqGEwU1VYVnSTS5eUfHw/iRTdatvqf12hJ2OANJsLcvhjW6jXUA/nendPPLnHOnXJ
	SPe/4+bGB+m4F8SktGJRENETq64fzG/1Gh5NqYDpCE4tFIosiqdZ2Wz6Vymr/aKtJwXHa4auJ75xz
	PS3xfaLg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7eN9-0000000BRy8-0VRC;
	Wed, 23 Apr 2025 17:58:59 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7cJj-0000000B11b-3wrk
	for linux-nvme@lists.infradead.org;
	Wed, 23 Apr 2025 15:47:22 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8A79D68C4E; Wed, 23 Apr 2025 17:47:12 +0200 (CEST)
Date: Wed, 23 Apr 2025 17:47:12 +0200
From: Christoph Hellwig <hch@lst.de>
To: Leon Romanovsky <leon@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Jens Axboe <axboe@kernel.dk>, Jake Edge <jake@lwn.net>,
	Jonathan Corbet <corbet@lwn.net>, Jason Gunthorpe <jgg@ziepe.ca>,
	Zhu Yanjun <zyjzyj2000@gmail.com>,
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
	Chaitanya Kulkarni <kch@nvidia.com>,
	Nitesh Shetty <nj.shetty@samsung.com>
Subject: Re: [PATCH v9 23/24] nvme-pci: convert to blk_rq_dma_map
Message-ID: <20250423154712.GA32009@lst.de>
References: <cover.1745394536.git.leon@kernel.org> <7c5c5267cba2c03f6650444d4879ba0d13004584.1745394536.git.leon@kernel.org> <20250423092437.GA1895@lst.de> <20250423100314.GH48485@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250423100314.GH48485@unreal>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250423_084720_134903_28C1E44D 
X-CRM114-Status: GOOD (  17.32  )
X-Mailman-Approved-At: Wed, 23 Apr 2025 10:47:25 -0700
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

On Wed, Apr 23, 2025 at 01:03:14PM +0300, Leon Romanovsky wrote:
> On Wed, Apr 23, 2025 at 11:24:37AM +0200, Christoph Hellwig wrote:
> > I don't think the meta SGL handling is quite right yet, and the
> > single segment data handling also regressed.  Totally untested
> > patch below, I'll try to allocate some testing time later today.
> 
> Christoph,
> 
> Can we please progress with the DMA patches and leave NVMe for later?
> NVMe is one the users for new DMA API, let's merge API first.

We'll need to merge the block/nvme patches through the block tree
anyway to avoid merges from hell, so yes.


