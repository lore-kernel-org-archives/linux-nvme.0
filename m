Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96A58C369CB
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Apr 2025 13:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eHvWlcuiL0DT39PbQ7Bxakxi2Hia5cahlA+E0m8XJZA=; b=4v1iAOy+/d4GArCx8WwbBeT5dR
	6GR0rFngIrYmPv6Cv8GhNz60Yj7cBtS7l+WT5SB5w2abOUfiB/iOHUHL1J0j3ASTr1RjdNEJ4S4Ta
	3Q0Vxl/dAGMZSQLPI6MXx3i+P+ui9iEC03MPLKYxXOJqPLA6OTdEu1DVrxXmKeKxnGkFLoaW6NKnn
	pbQeoauXkPI5D6iwD4HKCVNrmfA4hRFa3wnz4hj6fJOxKHtADG7WD37rCNEXpJi0cxGato7rb3TcM
	cFU9nRd3Q23qXjnlO02YdvlG6gpER4GvyWu6mzXC1v4p/BV/v9QtPnm0mawhBlerjo+2fQfrx6yJo
	+dH5nrEw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7Zn6-0000000AX8S-2Cg4;
	Wed, 23 Apr 2025 13:05:28 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7Wwq-0000000A6TK-1LJK
	for linux-nvme@lists.infradead.org;
	Wed, 23 Apr 2025 10:03:21 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 3E4924A5B6;
	Wed, 23 Apr 2025 10:03:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 306B7C4CEF0;
	Wed, 23 Apr 2025 10:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745402599;
	bh=ngFXadZZHp3LPPaxf54ODFSjNSzh1Ht+VnoqS5cPk+c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hZVOvTXyIaWu4bWId/pgxHxX3JrlaR2NClh5I234YwqF4+sVvvroq/dIj+b8OjPW3
	 8orSr5dvocbOlvIf0eFunxzGREOoUPlzqIip2kuqN0MhBpEz0dNLFk9675T/YjxGz+
	 RpafWcy0eGJ6cWbhqqpSjQkJNob79JzSWhPiR9jAtFbZN6VWaYovYldutOlXgPlHkY
	 DDy7D7JXKoau0CdAa1x6kIMY8EFuRXqN0o+H/pshkFrr5423vPoezWmpzPSxrwuAnP
	 GDNBoXhQDCW3daIwdE2ndGPPWwR835rpe3Wze8PBHYJYp2ZHjHNeCXv2uyCrCUPv4I
	 aEpVIWzBnV4Aw==
Date: Wed, 23 Apr 2025 13:03:14 +0300
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
Message-ID: <20250423100314.GH48485@unreal>
References: <cover.1745394536.git.leon@kernel.org>
 <7c5c5267cba2c03f6650444d4879ba0d13004584.1745394536.git.leon@kernel.org>
 <20250423092437.GA1895@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250423092437.GA1895@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250423_030320_388798_44B2A6A1 
X-CRM114-Status: GOOD (  10.47  )
X-Mailman-Approved-At: Wed, 23 Apr 2025 06:00:03 -0700
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
> single segment data handling also regressed.  Totally untested
> patch below, I'll try to allocate some testing time later today.

Christoph,

Can we please progress with the DMA patches and leave NVMe for later?
NVMe is one the users for new DMA API, let's merge API first.

Thanks

