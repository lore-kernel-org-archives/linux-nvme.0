Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16E91C3ABA3
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Apr 2025 20:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Pwh48c4CvWu4Mh6c0UxMsCYmgmmJH/KAsrSENlzdaiY=; b=s90mv3xGKsJMM9+6t89iCDucuM
	6iSQ7BjUumYAZ8EpTJFCxW+VZQJKtzBCaZ/8z/pMA5DTKd5Uk+beKsw7bIWiOTTnVG8AomncFFK29
	13LT5wJdeBK0la1I9ybEPS6mrCSs5cUBzRTcgvIts9hTj/fuLi52aIsm3WytfqUoJi5I3i+JS/RE6
	dcq9+JwYfRb7Lrk3gzJtcQyIjl1VZU0hPQiZ21dnc+3xHmWXqvKBMmqar084EnExHflpLrTqczz3H
	z7KR5pA6MzBFz06zUpgoRmTvCEjX3SSLXC/LVMxILx3h5RrVlnXlUPlMznjbDKN7piGP42qHoLQT/
	wYG+syqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9UqI-00000007QV0-2bDb;
	Mon, 28 Apr 2025 20:12:42 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9SJV-0000000767k-16xB
	for linux-nvme@lists.infradead.org;
	Mon, 28 Apr 2025 17:30:42 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id D646D49AFD;
	Mon, 28 Apr 2025 17:30:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78575C4CEE4;
	Mon, 28 Apr 2025 17:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745861438;
	bh=ab2ae8e/65ivTF8ecHo7+deewxqwGOGmR1WVeufmqHc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EFNCyztKW7+/Evx7uEJGPtK2SefAgYmqtED4ANsvGmvDwBuQlhn5S/nOmqu3WBR1z
	 +VFQyVwyP+0O2cMp8wyAXepn0PBELCi0ksp0PKLJBKlMwsEdig7AFEj4wICYu3fAJQ
	 /zZeikIV4GSdae/Y2/DwH4bks++gRwmwp9dpfRTMH4Z1ZCpPgQcQmi4pOO08SmuMpb
	 PTiv7J0eh/bS37eMFbiD7C8K8hWZiVIArkSUuuY+DzvZ8SoAg2vgkigVBG4ZUgJkdE
	 7Vrm2LUXRrJhMi9MPNfGblL+7IObYzGv0HZAEJnZAxGsJP7ubWBtZWh1DwAjICEoUP
	 0fglvd90xB7zw==
Date: Mon, 28 Apr 2025 11:30:34 -0600
From: Keith Busch <kbusch@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Jake Edge <jake@lwn.net>, Jonathan Corbet <corbet@lwn.net>,
	Jason Gunthorpe <jgg@ziepe.ca>, Zhu Yanjun <zyjzyj2000@gmail.com>,
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
Subject: Re: [PATCH v10 23/24] nvme-pci: convert to blk_rq_dma_map
Message-ID: <aA-7Oh4T-mDGvLXh@kbusch-mbp.dhcp.thefacebook.com>
References: <cover.1745831017.git.leon@kernel.org>
 <007e00134d49160d5edab94a72c35b7b91429b09.1745831017.git.leon@kernel.org>
 <aA-w20gOKus5hyAV@kbusch-mbp.dhcp.thefacebook.com>
 <20250428172225.GG5848@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250428172225.GG5848@unreal>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250428_103041_345063_670E0927 
X-CRM114-Status: GOOD (  20.30  )
X-Mailman-Approved-At: Mon, 28 Apr 2025 13:12:39 -0700
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

On Mon, Apr 28, 2025 at 08:22:25PM +0300, Leon Romanovsky wrote:
> On Mon, Apr 28, 2025 at 10:46:19AM -0600, Keith Busch wrote:
> > On Mon, Apr 28, 2025 at 12:22:29PM +0300, Leon Romanovsky wrote:
> > > +	do {
> > > +		if (WARN_ON_ONCE(mapped == entries)) {
> > > +			iter.status = BLK_STS_IOERR;
> > > +			break;
> > > +		}
> > > +		nvme_pci_sgl_set_data(&sg_list[mapped++], &iter);
> > 
> > I think this should say "++mapped" so that the data blocks start at
> > index 1 (continued below...)
> > 
> > > +		iod->total_len += iter.len;
> > > +	} while (blk_rq_dma_map_iter_next(req, dev->dev, &iod->dma_meta_state,
> > > +				 &iter));
> > >  
> > > -out_unmap_sg:
> > > -	dma_unmap_sgtable(dev->dev, &iod->meta_sgt, rq_dma_dir(req), 0);
> > > -out_free_sg:
> > > -	mempool_free(iod->meta_sgt.sgl, dev->iod_meta_mempool);
> > > -	return BLK_STS_RESOURCE;
> > > +	nvme_pci_sgl_set_seg(sg_list, sgl_dma, mapped);
> > 
> > because this here is setting sg_list index 0 to be the segment
> > descriptor.
> > 
> > And you also need to increment sgl_dma to point to the element after
> > sg_list, otherwise it's pointing right back to itself, creating a looped
> > list.
> 
> Thanks for pointing to the difference between data_map and metadata_map,

Yeah, They're different because the SQE has 16 bytes available for the
data map, so the command can fit an SGL descriptor directly in its
submission entry. The metadata field only has 8 bytes in the SQE, so we
have to set it to the address of an external SGL segment descriptor.

