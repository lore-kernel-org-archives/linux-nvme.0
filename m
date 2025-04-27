Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B3D4C3ABA5
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Apr 2025 13:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8KbY0DweL7rNaV0qI8g9vMm4PDDdst0OE8lEAyUoyHw=; b=MVps3a4ub0W4w1Z8UUnU6IoUuJ
	Prw6AfWYvmxyz+yDsKPl1U2ZaPVDyiX/BF2UWnYWiglBQU1Bbx+SEGw0ACSSTr7FriXZNnQswBXXm
	8zgKzufTnP0g8vlSN6OGzOkgDrxlOgbZ0mxoZej/WKUOLHZR7AE7eqmB1hmoPNRNLT7GO3pA5Lwtx
	AEg4gEbHCIMmCTZvLoL3s7JrULkh/weWnisF08lbaKk5GtJmarrdWVMswF15doge9VjpxCnTWkS6Q
	OBl88IiOXdBrNmhWuHQjiqdxZ9QVCj2IUEJpfHh+G8Zv+ERxlvuGjhMgfp7Z86DdJsS/mDAxThOP3
	+qUyV9TQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9O9d-00000006JQq-0u4E;
	Mon, 28 Apr 2025 13:04:13 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8w9p-000000034qb-45TK
	for linux-nvme@lists.infradead.org;
	Sun, 27 Apr 2025 07:10:34 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 7DF2F61166;
	Sun, 27 Apr 2025 07:10:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7284DC4CEE3;
	Sun, 27 Apr 2025 07:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745737832;
	bh=CGnsiRcgcTLWNshlRKt3+TY3846/zeQqAZXDX5kQlSo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M96skoYCIAliV9mE/cHFjQyXeYgIKCso7ocEVoV4QwsavwZFE3rfEM0dziGcjOR6b
	 7kjkhtEE/0EQdgXtARUS6cI7T75h7ppRVSbbVbM6R6qxPwg9Sg1vSFr6VbnyOZQ57g
	 o/iTgqG/YLNmmypwMR2+p+Nr3hxoD01W7r5hdZeZwzGeiH97kZ/4Ut5fcVkg1wzjts
	 hXvK19kK7wEZSW5jdM0EDEgy9k/RevkU6uLUiXDosGVulyNXnwwR8BBoNXzP3d0oXt
	 HjLpbmZL7Uu8naYplITM7UrID84hix6jY7jTs9NC+PEEEgVOxLpTdYZy8aECiq9kdG
	 KVcDCKntZyoxA==
Date: Sun, 27 Apr 2025 10:10:26 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
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
Message-ID: <20250427071026.GA5848@unreal>
References: <cover.1745394536.git.leon@kernel.org>
 <7c5c5267cba2c03f6650444d4879ba0d13004584.1745394536.git.leon@kernel.org>
 <20250423092437.GA1895@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250423092437.GA1895@lst.de>
X-Mailman-Approved-At: Mon, 28 Apr 2025 05:19:59 -0700
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

On Wed, Apr 23, 2025 at 11:24:37AM +0200, Christoph Hellwig wrote:
> I don't think the meta SGL handling is quite right yet, and the
> single segment data handling also regressed.  

If my testing is correct, my dma-split-wip branch passes all tests,
including single segment.

Thanks

