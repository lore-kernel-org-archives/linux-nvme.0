Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 754C0C369DC
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Apr 2025 13:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VOlYkSD8HWmK4UOhkHxFj+kREAF9xBLPDi+PpoDjw9A=; b=C8B/IwctBUqgmi+OjVaOBotDys
	MeVFDyzvkyWi8jb4OfvIuuUBYTEEmGsQzk0bAOA6Eg6bfgxMIcg+QirJ1aBAKaRAnZG7Kk/HO4laS
	JXrSD85+QqivbVwxyW7fbr3osRzDxnbKEtIcWTSLlzZw/4cXF76oAWdCi+rHHBKFv+ib9faTlGcFF
	AfO6acNt5D5nTcApaLJvE78TLAuaYhjwGdfC3KWtNTUGPhzIK1GVbBEnyuMa3F+aBPZRELKCb07xd
	HpwejYw6Ve1EQZ/e65fsW3SW/i3LG0O/cxdQcLJxx3Bz82lyYlpBRW8ZFEThJ7he33dTCinoW0Lxr
	y9ivyLtQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9O9c-00000006JQ7-1mtf;
	Mon, 28 Apr 2025 13:04:12 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8oL2-00000002awL-1IDI
	for linux-nvme@lists.infradead.org;
	Sat, 26 Apr 2025 22:49:37 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 5755BA4A3EB;
	Sat, 26 Apr 2025 22:44:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E2A6C4CEE2;
	Sat, 26 Apr 2025 22:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745707774;
	bh=nmMFwB0+2Q83FWwoIeN84/Hsbr1BD0MNyu6u3Ztzl+U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dq4DN7sYvzyKsbFrdTgHJyYQ/t0IfLJyjoz6RDjDdoU+n+O0s9VMQ5Fe4sETqQqXu
	 DCeQkOkzWcikGSsz5cSEC9TkTjmCk7WVtWRGMVFf+u/m2XaDyfr5iPT82X6WifKMG2
	 gh1V5xEEIy9jECtkpExskL33+bhy82ETGBU7hbmEoEGMpmALKALDa3hF5i3anZHhG3
	 jVXw8747itRVfwTZvsh4/6M7lMFtHzVL1MAcGeyBOA0lj2Rflt0Cr/LoaF/1k5b43X
	 r6s70MJCK+obsUgmZqZbzwSqcw3Wt8+DvxNsviVfWn0igDvBWICqZ4yqkUwueY0OUR
	 l+77ooG0Rb3eQ==
Date: Sat, 26 Apr 2025 15:49:32 -0700
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
Subject: Re: [PATCH v9 08/24] dma-mapping: add a dma_need_unmap helper
Message-ID: <aA1i_HJ1eimihSI2@bombadil.infradead.org>
References: <cover.1745394536.git.leon@kernel.org>
 <e55ceb86c6529a276484e13b0e6ea58764daf854.1745394536.git.leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e55ceb86c6529a276484e13b0e6ea58764daf854.1745394536.git.leon@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250426_154936_399175_8181B6FA 
X-CRM114-Status: GOOD (  10.96  )
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

On Wed, Apr 23, 2025 at 11:12:59AM +0300, Leon Romanovsky wrote:
> From: Christoph Hellwig <hch@lst.de>
> 
> Add helper that allows a driver to skip calling dma_unmap_*
> if the DMA layer can guarantee that they are no-nops.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Tested-by: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis

