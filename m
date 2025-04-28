Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A523C369D5
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Apr 2025 20:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5GZBa/47FHII5r3Bd/vKP2S9Pm6ZZUX7GYk9R5ZvQu0=; b=tA63wBZ9BmqimES3lMBgNp3tPr
	mrP83eZJMamqQfLG66GCHhEMRLjQ2L0/0LOoc7FXnp2DTquXvYiab3wqU+N1ZrxZ0OcoVF/e1BahA
	JC3FRhekPeW4WSlJcNfwM68C4JCpLS0hdJd/KGOPMc544v4z1RYGL0ApvSXFLawQMkq3YWtXKvtXM
	boFWP5Dto+aD2nfcGvnWAKhHgQ3mr/+s2AG0hIdoT8V13SATXhG0VenZi5zagein4wrX2nPKtzDgj
	w7Zsc19RQTVa2QSQSPnzMnHYLPLhGU3dB+mshZlHjo8fFl/TvXIxcqYCc7ZbvV3ni5k3VpcqdI73w
	ZcNWuchg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9UqK-00000007QWq-45UR;
	Mon, 28 Apr 2025 20:12:44 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9SBa-000000074jN-3onP
	for linux-nvme@lists.infradead.org;
	Mon, 28 Apr 2025 17:22:33 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 36268A4B537;
	Mon, 28 Apr 2025 17:17:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C8E4C4CEE4;
	Mon, 28 Apr 2025 17:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745860949;
	bh=gYg74JiB5JakFxosXZhQLQiNqGZNU3mPT/z4lhxtdMs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dCCvX7rC72JWr7s0YvTI7g9kE+dAdbJ9qPCeyBTmld4lQ3lxym1bm5n7CK23ZbPA3
	 4ZspxkotQfcA+i0UwXLwN+ARCHDhSheR12H/DrKO3QMjiR9Ix5T+qkG3Wq7c95k8Tz
	 ocl6oT61kcsd5Tad4FjMD4Pn4uru4Gg4+Eu1WtxWXOO184jGJ4GXBgm5SoZb6Op0pi
	 QZXhP9YFwutRlAOVwL49o6dg7f+L4Eee5j6ByGmpfbcxHXRKiLSTIAztxNr7Di0lAf
	 zRT0ZI+MoU0PfyQuo6YBGUoloJs2gfsBYCL/17f3Mc9Ve1W2QoJQtDaZJQRRe0I+AR
	 DNToLbBLnWQGA==
Date: Mon, 28 Apr 2025 20:22:25 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Keith Busch <kbusch@kernel.org>
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
Message-ID: <20250428172225.GG5848@unreal>
References: <cover.1745831017.git.leon@kernel.org>
 <007e00134d49160d5edab94a72c35b7b91429b09.1745831017.git.leon@kernel.org>
 <aA-w20gOKus5hyAV@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aA-w20gOKus5hyAV@kbusch-mbp.dhcp.thefacebook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250428_102231_073652_3BCB875C 
X-CRM114-Status: GOOD (  17.65  )
X-Mailman-Approved-At: Mon, 28 Apr 2025 13:12:44 -0700
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

On Mon, Apr 28, 2025 at 10:46:19AM -0600, Keith Busch wrote:
> On Mon, Apr 28, 2025 at 12:22:29PM +0300, Leon Romanovsky wrote:
> > +	do {
> > +		if (WARN_ON_ONCE(mapped == entries)) {
> > +			iter.status = BLK_STS_IOERR;
> > +			break;
> > +		}
> > +		nvme_pci_sgl_set_data(&sg_list[mapped++], &iter);
> 
> I think this should say "++mapped" so that the data blocks start at
> index 1 (continued below...)
> 
> > +		iod->total_len += iter.len;
> > +	} while (blk_rq_dma_map_iter_next(req, dev->dev, &iod->dma_meta_state,
> > +				 &iter));
> >  
> > -out_unmap_sg:
> > -	dma_unmap_sgtable(dev->dev, &iod->meta_sgt, rq_dma_dir(req), 0);
> > -out_free_sg:
> > -	mempool_free(iod->meta_sgt.sgl, dev->iod_meta_mempool);
> > -	return BLK_STS_RESOURCE;
> > +	nvme_pci_sgl_set_seg(sg_list, sgl_dma, mapped);
> 
> because this here is setting sg_list index 0 to be the segment
> descriptor.
> 
> And you also need to increment sgl_dma to point to the element after
> sg_list, otherwise it's pointing right back to itself, creating a looped
> list.

Thanks for pointing to the difference between data_map and metadata_map,
I see it now:
        sgl_dma += sizeof(*sg_list);
	nvme_pci_sgl_set_seg(sg_list, sgl_dma, entries);
	for_each_sg(sgl, sg, entries, i)
	        nvme_pci_sgl_set_data(&sg_list[i + 1], sg);

Thanks

> 
> > +	if (unlikely(iter.status))
> > +		nvme_unmap_metadata(dev, req);
> > +	return iter.status;
> >  }

