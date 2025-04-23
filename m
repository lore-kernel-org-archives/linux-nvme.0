Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C333C369D5
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Apr 2025 18:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=01f5gBau2cIUg3e6dlBkZrq8kUYqCcrB3MHd0HW32sc=; b=uyqvmLKwF0tCg2weLpjN/o4uFo
	ykfNTrPd4wnrbICE3u983SWN8uO8+nUwU/we8QHmWQnN/iZmttqA5bSpXE43ll5OdVIWZpk7GGAx5
	QG/qapy1f+cIPkOxh8YXMGsDpyH3cn3lPk+7vPwVVCgzMWbDBgXTcPaKUwmsKhCp0Wc633+KT311h
	Ljuy1LloaJzK9irVEvpeNuWkWEhLJjJelb5wV3qJ4mAa5K9MGcJzgkSrItPZrX+/WtDB9t1RmbE+l
	DilAHoSX6B91ASPWSl+GTTwoMBfYojw5E/5KqwdHfqXKxLJ6kAnnz5eh/HIrkr1dPf64L53WCwiQL
	K3N1Xa9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7ezb-0000000BbUL-1onD;
	Wed, 23 Apr 2025 18:38:43 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7bYv-0000000AtQR-2E5v
	for linux-nvme@lists.infradead.org;
	Wed, 23 Apr 2025 14:58:57 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 03AAA614B6;
	Wed, 23 Apr 2025 14:58:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E6EEC4CEE3;
	Wed, 23 Apr 2025 14:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745420336;
	bh=Cq/9ebClxlVbVqFqG5/6zORZ18/N3r0Ih3h4rsgmibY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rNAIeayXStayTh+kdSzMXaruBcLJXQoaQdrPfgYfteRcWk5W3bpzX/9lOPNmTRawT
	 3Js8n/jzA0KcrggLtIDYykZlPj6Dez+Yrx3Z9APc1t4hhfKysBTJkG0duPuNwBnGks
	 0sGpxPSNXrScaZ1ZIlrdsqsiEWDsoZMPg15dosv1MW/ySTAaOgCmQLtKdBwGsHiVTZ
	 1SBYhdxbfYY3VuqejbFMedI1znQqqlAc4ideI8ClyIhmPZGcJE6eB6IQ4iR3ICvNqX
	 aQmYnghFpNOVpmT0E+j6DR29WFQtH/r3ajJ27yThOcM7hr5AG84maPgUId3dJkxSan
	 aVj53L0H7Llpg==
Date: Wed, 23 Apr 2025 08:58:51 -0600
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
	Nitesh Shetty <nj.shetty@samsung.com>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [PATCH v9 23/24] nvme-pci: convert to blk_rq_dma_map
Message-ID: <aAkAKyr4fbd5sLCH@kbusch-mbp.dhcp.thefacebook.com>
References: <cover.1745394536.git.leon@kernel.org>
 <7c5c5267cba2c03f6650444d4879ba0d13004584.1745394536.git.leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c5c5267cba2c03f6650444d4879ba0d13004584.1745394536.git.leon@kernel.org>
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

On Wed, Apr 23, 2025 at 11:13:14AM +0300, Leon Romanovsky wrote:
> +static bool nvme_try_setup_sgl_simple(struct nvme_dev *dev, struct request *req,
> +				      struct nvme_rw_command *cmnd,
> +				      struct blk_dma_iter *iter)
> +{
> +	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
> +	struct bio_vec bv = req_bvec(req);
> +
> +	if (IS_ENABLED(CONFIG_PCI_P2PDMA) && (req->cmd_flags & REQ_P2PDMA))
> +		return false;
> +
> +	if ((bv.bv_offset & (NVME_CTRL_PAGE_SIZE - 1)) + bv.bv_len >
> +			NVME_CTRL_PAGE_SIZE * 2)
> +		return false;

We don't need this check for SGLs. If we have a single segment, we can
put it in a single SG element no matter how large it is.

