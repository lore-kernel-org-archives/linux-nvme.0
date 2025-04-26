Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77434C369DC
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Apr 2025 13:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=N9OKLboyRSWd9iZcPYqjA5xqgR2wK92sFoH7sofxhbE=; b=NmrTemvAHR0Qlv/280+QCK8FUj
	rAB0DaBloltEevtjH3+ABDBwJewnLLbAx9TkdwVcWzS77dLkldY7s7NUHaWnaUU/ZbHdYKn4+l0M0
	S8xd7Z/YkKRYJwg0y8GAwg5ROlk/bHHgK+l4mDrAnWPBKPo/tubGhEaRRrkEy1O8OpxfPZmQup5W4
	17hYG+fgnMN4yQF+5Oa3jjWwaOC+iuGztr8GbkGq+CqUs33ukJLTbiWXbOxJsknyhQWUkhn4rf5EC
	98uR4qOvxqEpAtR3Kpf6nNlQrzqhusycHgamxp4JcVj5kuDNvL+ACTsFj8LH9ffx1zvUgR3xf5mXx
	VdHuohXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9O9X-00000006JLl-2mK3;
	Mon, 28 Apr 2025 13:04:07 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8TIx-00000001Box-0ayN
	for linux-nvme@lists.infradead.org;
	Sat, 26 Apr 2025 00:22:04 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 1E5D95C6C9A;
	Sat, 26 Apr 2025 00:19:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6A96C4CEE4;
	Sat, 26 Apr 2025 00:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745626921;
	bh=h50G9mpEZaBwJcj8NBjbBVE9qsIsc9fyuWGRd2gmBsM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uSx9KLDJxnN6lYn0LOZiC4gIIRTMcevzUKTtv7QtHq94vnzWzXAWCWK4YS8t/lvCv
	 alHXKJFiqiZH5uLDlN+4stNQPEDcFlWuzLtnpyGxFQaHCXmY/sJ3NasmNfPQ10XOsD
	 wUw2k76EwWqC8e0qBP5fC1orpyG4CQVrSTzu1rraBPS49Yf+gV2ATcRoe77STUECZ4
	 KJl2G7PvDJa9oNMl3b9jsvgxkMxCD7AlH1dhdpNSZwOELkRM++Hgq3UOE+eTSBx7Az
	 pefT0sVbAaXyzhhHb4ziaDfP3nFsriO8NgoukTNrsqDiCzAfPrcBbyGzvg66JNeo6z
	 O2DMUdv81udLg==
Date: Fri, 25 Apr 2025 17:21:59 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>, Jake Edge <jake@lwn.net>,
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
	Matthew Wilcox <willy@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [PATCH v9 01/24] PCI/P2PDMA: Refactor the p2pdma mapping helpers
Message-ID: <aAwnJwLeOs7rfkHL@bombadil.infradead.org>
References: <cover.1745394536.git.leon@kernel.org>
 <3a962f9039f0265de939f4c81924ee8208fc93a6.1745394536.git.leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a962f9039f0265de939f4c81924ee8208fc93a6.1745394536.git.leon@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250425_172203_225844_DB234F2A 
X-CRM114-Status: GOOD (  18.31  )
X-Mailman-Approved-At: Mon, 28 Apr 2025 05:19:58 -0700
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

On Wed, Apr 23, 2025 at 11:12:52AM +0300, Leon Romanovsky wrote:
> From: Christoph Hellwig <hch@lst.de>
> 
> The current scheme with a single helper to determine the P2P status
> and map a scatterlist segment force users to always use the map_sg
> helper to DMA map, which we're trying to get away from because they
> are very cache inefficient.
> 
> Refactor the code so that there is a single helper that checks the P2P
> state for a page, including the result that it is not a P2P page to
> simplify the callers, and a second one to perform the address translation
> for a bus mapped P2P transfer that does not depend on the scatterlist
> structure.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> Tested-by: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Might make it easier for patch review to split off adding
__pci_p2pdma_update_state() in a seprate patch first. Other than that,
looks good.

Reviewed-by: Luis Chamberlain <mcgrof@kenrel.org>

  Luis

