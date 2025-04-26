Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 144BDC3ABA7
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Apr 2025 13:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vi2pnpjccu/XjMR3GqlprWeJbFeAdaR45wzAOdMIYl0=; b=ccwxmqbR/4NRlO70iq+zuAfsXd
	uu1umGap1X3MTqVR5l9e1VGV2GtbaSIYkrycD00tJzIz/ZxoRn8+4BmE9IcCtV0Hof3zzcF6F0bi6
	CmsoMGJuzEklkCTsbcaMT+sE4ICCV6bvEzvkYk6H1uYmPpTyj/Ateo5Macs4nP2+oiRFyJnFCzWp6
	+87gEfqS12s1+fRlhrk7zZMShsqdzjTs67OPhEp5lG6DdVaVT0sDWMMnO7CedG6eSzEH0jCW/DNTA
	Ubn+h1/tMzGeeXjY1CgS7jeNB1WEz/lg0eJjAlemWegMR+bbxwW5Ekygq1erpVd23BM9d1z3hhnzy
	KtUA2hdw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9O9a-00000006JNr-1LWK;
	Mon, 28 Apr 2025 13:04:10 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8U4L-00000001EUp-1ow7
	for linux-nvme@lists.infradead.org;
	Sat, 26 Apr 2025 01:11:05 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 7088EA4D70C;
	Sat, 26 Apr 2025 01:05:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F060C4CEE4;
	Sat, 26 Apr 2025 01:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745629859;
	bh=GUs6TKtXii+/XXjYUhm5P6PA6lNQdKk+Fhn0VAcFzCg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KxqczATSjba7r4EOiuW4Y78kxeaOmUn3hrN1Qeb61Bk1IEG5UNMQYfKkJP6rYhrV7
	 8AmTGD/13GYjzSccgNMwsaqeRlpmwPv5meAChJXDj5Q06hhFENBCp7oBqxPzuc9ZO0
	 pGKSNgygnGuSGADjucID9fOYBRhKR7ry0z4g2sDjEkMTeG3qIIFlI5culzVUuXi3wA
	 bC8BOIqRt8uMC02v1ZmTGzq2dYb7qx2Xfv5q8Rxtr63FLkVeFvfiizkWxan0m4YeBl
	 KHc2CWUVFGRL3C1kNb40DgyDJqN6VrFEUEYi9ZwapTJakiV2SfEKCIjtwm38N6h5V5
	 f3X4MpEQ8rQEw==
Date: Fri, 25 Apr 2025 18:10:57 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Leon Romanovsky <leonro@nvidia.com>, Jake Edge <jake@lwn.net>,
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
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH v9 05/24] dma-mapping: Provide an interface to allow
 allocate IOVA
Message-ID: <aAwyoXHzhU42P06W@bombadil.infradead.org>
References: <cover.1745394536.git.leon@kernel.org>
 <f08e12b1539b73c9ae27c06afbfe4f0ee3b85609.1745394536.git.leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f08e12b1539b73c9ae27c06afbfe4f0ee3b85609.1745394536.git.leon@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250425_181101_540361_A40F9F42 
X-CRM114-Status: GOOD (  11.39  )
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

The subject reads odd, how about:

dma-mapping: Provide an interface to allocate IOVA

> +/**
> + * dma_iova_free - Free an IOVA space
> + * @dev: Device to free the IOVA space for
> + * @state: IOVA state
> + *
> + * Undoes a successful dma_try_iova_alloc().
> + *
> + * Note that all dma_iova_link() calls need to be undone first.  For callers
> + * that never call dma_iova_unlink(), dma_iova_destroy() can be used instead
> + * which unlinks all ranges and frees the IOVA space in a single efficient
> + * operation.
> + */

Probably does't matter but dma_iova_destroy() doesn't exist yet here.

Other than that:

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis

