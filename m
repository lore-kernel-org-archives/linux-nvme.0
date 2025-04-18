Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1516C369AB
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Apr 2025 16:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=llIYarjLr33QmseFzyvD6GLcZCMxkLnldD/Y5Bv2ZDo=; b=OD6/9x01A1+XcAm+t4kJrlCRCW
	8g26PGe66UfNAynoiXyXgDSK8QwN/zIMi0VeRnfyoWxXEdlOWfszxB6TAcBnlgTQ3Q+zdm4eltJF9
	Ilt3/pCJbbyb/e/5EbKZAuhWBUpmI/QI1kG2Des29mm3QL5ubnK4bUi7IgB9WgETbDAzcwJ9URNav
	FSt28pl2rPo4g1kgKHk0Rk+UMW0XCMQi4wHIcpVVAN7+U+vC83jt0eSsrzRyhK1xqZrs1txZk2xMU
	OvbEGpyfjW1vI2LJMGfIqkHaHWqvkHTXkErhuwSnP4pcCQhzP+HuOVE/jNIh/rzTOVsya5djH1mlB
	5srYIm7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5ooX-0000000H1MH-0ddx;
	Fri, 18 Apr 2025 16:43:41 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5ji9-0000000FwwM-3U45
	for linux-nvme@lists.infradead.org;
	Fri, 18 Apr 2025 11:16:45 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id CF72C61137;
	Fri, 18 Apr 2025 11:16:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 900E0C4CEE2;
	Fri, 18 Apr 2025 11:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744975003;
	bh=dvINVulNQm/q8ensffkaywCQHGoNQIxMaLroxrA224U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WQ/C0ZYEmhZxfgAy6oSrCwtec97rYq+IQy72i0QXVT4Nic+OEanmNLKKsvIIV8Ekj
	 1x7gsGqeeh1osAlFFL0KDLYmWqa0wjQIuod7vLi1OTJlGC5z4qe7QRZ5wj4SS2nqE7
	 +SH+NS44ZZFAhuBE2ycaahgJLhmerUsAv+G4MIEsX1IMHt8ijPEtQJjO7xQyt6BtQo
	 tyiaXeqr34eQH5l7zL728IAWC+FUE2oBIwfQLJxm+CM1SCDOXGLW0mSvG5V+8GFATT
	 SZvt1I0LYqXvIMwiZgIyzpqRSI5Z5otseG0yxNbcvWknZp/i/ZkFcDocEdXEtgjD/p
	 CTvTVJqZ7YpdQ==
Date: Fri, 18 Apr 2025 14:16:39 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>
Cc: Jake Edge <jake@lwn.net>, Jonathan Corbet <corbet@lwn.net>,
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
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH v8 00/24] Provide a new two step DMA mapping API
Message-ID: <20250418111639.GB199604@unreal>
References: <cover.1744825142.git.leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1744825142.git.leon@kernel.org>
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

On Fri, Apr 18, 2025 at 09:47:30AM +0300, Leon Romanovsky wrote:
> Following recent on site LSF/MM 2025 [1] discussion, the overall
> response was extremely positive with many people expressed their
> desire to see this series merged, so they can base their work on it.
> 
> It includes, but not limited:
>  * Luis's "nvme-pci: breaking the 512 KiB max IO boundary":
>    https://lore.kernel.org/all/20250320111328.2841690-1-mcgrof@kernel.org/
>  * Chuck's NFS conversion to use one structure (bio_vec) for all types
>    of RPC transports:
>    https://lore.kernel.org/all/913df4b4-fc4a-409d-9007-088a3e2c8291@oracle.com
>  * Matthew's vision for the world without struct page:
>    https://lore.kernel.org/all/20250320111328.2841690-1-mcgrof@kernel.org/

The link here should be https://lore.kernel.org/all/Z-WRQOYEvOWlI34w@casper.infradead.org/

>  * Confidential computing roadmap from Dan:
>    https://lore.kernel.org/all/6801a8e3968da_71fe29411@dwillia2-xfh.jf.intel.com.notmuch

Thanks

