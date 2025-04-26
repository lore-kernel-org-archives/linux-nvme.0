Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65FCFC369D5
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Apr 2025 13:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=q7nNMthSWdB+UW6yIRVmiWWSgCBxm//eZaxQKCelyU4=; b=3He4/L74HUb65seLs3MwllN7dH
	Idx3p/G5YX4JAxuZjYfB8mPryojpPE+sbhX0sdYGMjJ9ZEz0/8uQwH3Nzk35f2A88m64wvPmdaA8a
	UI9a1s5kqhqkLD4nynF2XMKjlFO9WIgkC739kAMfXOMv6vh02kOkiomL4UVnoGwJxY2l5HCETq9dc
	IGkbn1GgxcXeZY6yXwmGw7VqiardP8cC0RKS0DGvVtNqp79jK/A5G7eSJF2+HUSGdS62kAvs674Dk
	Q6vAfQ750/A/Tsg2fZ8o35py0DOrc3pzCH7J2kkxl/P1r1D3bpEGwkS0Eqa5oBl54aQWboOE1giMl
	Zur3B3XQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9O9Y-00000006JMm-3n0q;
	Mon, 28 Apr 2025 13:04:08 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8Tm2-00000001DJn-2oH6
	for linux-nvme@lists.infradead.org;
	Sat, 26 Apr 2025 00:52:06 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 8328E61127;
	Sat, 26 Apr 2025 00:51:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF217C4CEE4;
	Sat, 26 Apr 2025 00:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745628724;
	bh=vS960RN8eoznhuaOAbkLk3VNvo6fl9t3ybOtAhS+oxI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o0knlVacjd58fKaCv8W4WgMSAjurA8qjNdSrVkIqhnTxhCS2Xljmgu2cICXBDsYYr
	 OfXyt6i600xsrD20SrzjLSVs+N4otmMZ84yBX4K/P6PYEbfRjJDtkPhxXLK0RgWJll
	 3CdpyOs1DtyoAmEHFuDJ6Qg34sSmxKxo3O6IiObCP8Zp4VQZ+Tjqw/E1IKwoBHhsIk
	 Q2jkrzUFV5ZON9p1uYvMAV2yZO5y0BluyblQjBpeKYxVpi70Ty1ZWVNV6EB4MDnNj8
	 DqN8txJfMQy3COKXPJWUCYsvWcNg8LLurWldjBa586FP8IuXAYU+kVIBUCJqYa0N0f
	 Gm2ccqz/e76xw==
Date: Fri, 25 Apr 2025 17:52:02 -0700
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
Subject: Re: [PATCH v9 03/24] iommu: generalize the batched sync after map
 interface
Message-ID: <aAwuMuR3tpWtyCTa@bombadil.infradead.org>
References: <cover.1745394536.git.leon@kernel.org>
 <2ce6a74ddf5e13a7fdb731984aa781a15f17749d.1745394536.git.leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ce6a74ddf5e13a7fdb731984aa781a15f17749d.1745394536.git.leon@kernel.org>
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

On Wed, Apr 23, 2025 at 11:12:54AM +0300, Leon Romanovsky wrote:
> From: Christoph Hellwig <hch@lst.de>
> 
> For the upcoming IOVA-based DMA API we want to use the interface batch the
> sync after mapping multiple entries from dma-iommu without having a
> scatterlist.

This reads odd, how about:

For the upcoming IOVA-based DMA API, we want to batch the sync operation
after mapping multiple entries from dma-iommu without requiring a
scatterlist.

Other than that:

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis

