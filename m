Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 848FFC369D8
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Apr 2025 18:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/UmQUzXQimpdcBViOB+BzZ6gQqQXWVIH2aIao+hu7NI=; b=ct2Xm0f4BOhh+uXw5UcRTqBOJF
	1w6hiHKm23tayfo1bwZDI+YUtLIFf6LEHbUD6yZnd9ZO73Y7aQqAIMhpv2e+BtXH8ISfY5SOo5dIK
	NCIEma2j20sSDw2iEKPQH+xU9t+yQlQkVUlQbA0Qpfd248DVBQqJjwiIcYYjDr2Pg0Sg9qlnFOH2/
	S8/QBi/c9jcGyaMwOlsJcnYFaskgIGnUiOz4XnUBv3L91+jS1I0CtqFaSmMpuG0W4SJsnyhuEj23R
	ED1/vU2chojxuTT+84iFASPd2PI9LUKq45JcSJSNZQMD7x2q3lgqQfodAV/wpAsKCmvoz7zuKAYo3
	wpe6TsHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7ezd-0000000BbVL-2ovh;
	Wed, 23 Apr 2025 18:38:45 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7dcw-0000000BDvx-3lrZ
	for linux-nvme@lists.infradead.org;
	Wed, 23 Apr 2025 17:11:14 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 097E06113B;
	Wed, 23 Apr 2025 17:10:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEA7BC4CEE2;
	Wed, 23 Apr 2025 17:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745428273;
	bh=wm5GF1+5ZhFui3p0uI/jDDATw03CDOZZzdN2e7V0TSU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WKE+8APYL7laFptOx5V5tlTW6vx8OhdD2WZd+VGxrXtV67FrKncs+kqu+pF5u2EGG
	 UOokgA7a2oH+932TcBKZF7az+Ped9NzAHFBaGnehVleJXvWIBUCJeL1sQ2Qmw7D00x
	 t3RQhR9MeIT9X6K4x10h4rIx8fAT5Xzfh4DWU3ruajS1BQDApG5h93OllIWbkN2aId
	 wdKj+YjyrKbqPlk1S3NqyKmfDMZw+PqaheehQ4VEM2e62rg2kfh4ZmgP8NXJJpagND
	 oUgY6vbnwDC/BH3tlAmiFa7bG+aa9E3K6tCMbaiT1v0F8o94QDy3SA0813/IgeDR3G
	 KIYJwJTivuM1w==
Date: Wed, 23 Apr 2025 20:11:08 +0300
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
Subject: Re: [PATCH v9 23/24] nvme-pci: convert to blk_rq_dma_map
Message-ID: <20250423171108.GK48485@unreal>
References: <cover.1745394536.git.leon@kernel.org>
 <7c5c5267cba2c03f6650444d4879ba0d13004584.1745394536.git.leon@kernel.org>
 <aAkAKyr4fbd5sLCH@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aAkAKyr4fbd5sLCH@kbusch-mbp.dhcp.thefacebook.com>
X-Mailman-Approved-At: Wed, 23 Apr 2025 11:34:49 -0700
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

On Wed, Apr 23, 2025 at 08:58:51AM -0600, Keith Busch wrote:
> On Wed, Apr 23, 2025 at 11:13:14AM +0300, Leon Romanovsky wrote:
> > +static bool nvme_try_setup_sgl_simple(struct nvme_dev *dev, struct request *req,
> > +				      struct nvme_rw_command *cmnd,
> > +				      struct blk_dma_iter *iter)
> > +{
> > +	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
> > +	struct bio_vec bv = req_bvec(req);
> > +
> > +	if (IS_ENABLED(CONFIG_PCI_P2PDMA) && (req->cmd_flags & REQ_P2PDMA))
> > +		return false;
> > +
> > +	if ((bv.bv_offset & (NVME_CTRL_PAGE_SIZE - 1)) + bv.bv_len >
> > +			NVME_CTRL_PAGE_SIZE * 2)
> > +		return false;
> 
> We don't need this check for SGLs. If we have a single segment, we can
> put it in a single SG element no matter how large it is.

Absolutely, removed it and updated my dma-split-wip branch.

Thanks

