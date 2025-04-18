Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3D98C369AB
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Apr 2025 16:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Apema9hJmPv6bbP4STg4j5++huvkZ85a9+z8ec7sdgk=; b=kFAgtY//RsE0ehHjsRN5i8Gs8k
	oPCb9tLSI3QxvZf32cwdCFMxBIaKQ3Nss02bZCe59P7UxgpD0dFV+DgR38YnSnLPM+rANsQhDc5Bn
	pdWG/mSvjsR1rKS9jbt0oKbuxbTl6O4si19BewXtu72A+rA6ssrBpNPqwlodyS5imQvOoLbE4+nkE
	dIyGjS5U9dYMiY4welqrqRGJLQThn2GjT1Owc/5rgO3X5HvS4fq6q/JaGcSy/qtkP/IwGNpLfRg7Z
	UJRvUSCXZ6mCaSb2y+h5SkvIyQDyrKFsdmB8PPktc78FvQQMAk1WyrE144gssvOCTTnfnf35d3gRI
	v9+64Kqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5ooZ-0000000H1OT-0D61;
	Fri, 18 Apr 2025 16:43:43 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5jlC-0000000FxJs-0YCt
	for linux-nvme@lists.infradead.org;
	Fri, 18 Apr 2025 11:19:54 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id CB66B61120;
	Fri, 18 Apr 2025 11:19:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98E2DC4CEE2;
	Fri, 18 Apr 2025 11:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744975193;
	bh=A7wvqwnqYa5lljVCih9QNkNHMM3IhtbdB0k5O3y2uik=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WdeyXvfarIVDZXIlsrZR6q+ZWN3+pN643rg0mOwmYV5A6pKmeRqB/JWY/8ObUAnJi
	 Y1EqzpJAMsZxftxRUhP7InpbxA68zM7a6DddpAF30J+LhDbBYnrB+4R7SOQ7Z46AGH
	 mSi5EInuDvbHAH3PcbwmhGvxSQxVx4wSnWHM7vjrcR9bDC4KkeIuhcfdENyorCWU9U
	 438m+H5AQfvv/rBCcHLE3C4f92y96s5caeLMC+3sz+c/1NNlmdYlYVYpkbEWVlcolR
	 bcqe1xg8mMIU5XVaCBr+Sxo15YaqwuuASTpzG37swqcijwKEEM/LYAGrbVM4ttt8Qo
	 U7pz/uTfDL03g==
Date: Fri, 18 Apr 2025 14:19:49 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Kanchan Joshi <joshi.k@samsung.com>, Jake Edge <jake@lwn.net>,
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
	Chaitanya Kulkarni <kch@nvidia.com>,
	Nitesh Shetty <nj.shetty@samsung.com>
Subject: Re: [PATCH v8 24/24] nvme-pci: optimize single-segment handling
Message-ID: <20250418111949.GC199604@unreal>
References: <cover.1744825142.git.leon@kernel.org>
 <670389227a033bd5b7c5aa55191aac9943244028.1744825142.git.leon@kernel.org>
 <1284adf3-7e93-4530-9921-408c5eaeb337@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1284adf3-7e93-4530-9921-408c5eaeb337@kernel.org>
X-Mailman-Approved-At: Fri, 18 Apr 2025 09:39:28 -0700
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

On Fri, Apr 18, 2025 at 05:02:38PM +0900, Damien Le Moal wrote:
> On 4/18/25 15:47, Leon Romanovsky wrote:
> > From: Kanchan Joshi <joshi.k@samsung.com>
> > 
> > blk_rq_dma_map API is costly for single-segment requests.
> > Avoid using it and map the bio_vec directly.
> > 
> > Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
> > Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > ---
> >  drivers/nvme/host/pci.c | 65 +++++++++++++++++++++++++++++++++++++----
> >  1 file changed, 60 insertions(+), 5 deletions(-)

<...>

> >  static void nvme_unmap_data(struct nvme_dev *dev, struct request *req)
> >  {
> >  	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
> > +	unsigned int nr_segments = blk_rq_nr_phys_segments(req);
> > +	dma_addr_t dma_addr;
> > +
> > +	if (nr_segments == 1 && (iod->flags & IOD_SINGLE_SEGMENT)) {
> 
> nvme_pci_setup_prps() calls nvme_try_setup_prp_simple() which sets
> IOD_SINGLE_SEGMENT if and only if the req has a single phys segment. So why do
> you need to count the segments again here ? Looking at the flag only should be
> enough, no ?

Yes, you are right. There is no need in extra check of nr_segments and
it is enough to rely on IOD_SINGLE_SEGMENT.

Thanks

