Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A953CD13570
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Oct 2024 06:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2OZJ7SkPw7n9Wr8f1NRoe2VJmBBCCNV3mvrU0RLSSQI=; b=0MO4K7AQSIIWTmKgbiwz2EMaQW
	HQo2rrhpSj+eUX3V/4RpaNnwExvvNAgoEIgbTVXxkOrdeK3+qm+0ys2wL+4PPGEu0uZlgXui17pxC
	Mv7fsPDM6TWIZsD0Ha3c+LmN3Xs8BDGbPlgFEuYptK2wjnYy7FXULawubC8dXz62nkbR0dVFHmCtY
	rksCu0nMYnTwM7of71ursAyo87aF+PjOPxYwuu/NzXgqBf/QAyj1+hOTqPaVdR0v6LYerpDKcUpZo
	Op+iqqh0tIFpYO3/X59vYXcu2Sl4No4/wIeJBH1XXTtOCQm0VVqvDYnvOfbC0B8j4NCScpVa+WwIk
	ui22/1vQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t5JY1-00000009m72-3rWG;
	Mon, 28 Oct 2024 06:48:17 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5JWW-00000009lta-03Mr
	for linux-nvme@bombadil.infradead.org;
	Mon, 28 Oct 2024 06:46:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=2OZJ7SkPw7n9Wr8f1NRoe2VJmBBCCNV3mvrU0RLSSQI=; b=dWRLWWH1NMSgepNomsK1JlYs7d
	+iClSLfbQdSjUTfWDt/V5oso/VOdXM2fvEX67xiBAfZhQOqvH37sD79NmEkeiMdFMEDoSLJ2jAENw
	78h/3fKf1dbHpOGaf2L8K50stfxl9sRKP8oytI3BcyA9NkVueB76A6mEoQOTHI64AFi0CcYXucmH8
	svd7E6Ku3FeoLUiaoUUq84ogG4L9wsWtSLBqr3nvjCsPVCk1cJLF3J+vCrBkZ7LMcUPAdFp6rYWKn
	Nmbo4bgGr8ZeFti6CwwTDTrLhmPJm/uvywWXmiXqOgxgOz4Kk5c9+ek6IK4w8RwiL/KCn8JaeyGOe
	88Dz2DNw==;
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5JWS-00000009ZJT-3qC4
	for linux-nvme@lists.infradead.org;
	Mon, 28 Oct 2024 06:46:42 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 5668FA418B1;
	Mon, 28 Oct 2024 06:44:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EA05C4CEC3;
	Mon, 28 Oct 2024 06:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730097998;
	bh=JxpLCeEPUhJrMkdL0TYudbC/XbTxYSrHktHQOg5tBzY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pXfr6iukpFNitgAKIIVSyCYtDDCh3B1GaWuseUbNm4XLfuvHiPNIEI1RqzgXGCn+r
	 T8x3ffU9NvEGqhEZOlcisSCjWlq5PsrCdXVG8sEw7pR+jCveH56xttouEjDQJDV8WY
	 bx5SFdkmU/eJH7Hrzmkv07xrrIzZ4Y8X8n46X7ryPLmoTBBwUTYHLhLxEw9x3XHUY1
	 Sze57dE6qj3rdN/EwuSVQ8/g13tIxT1HqDmg5aZ6q77NA2Bid5WHDDtaexWJgT2Sgx
	 tKYkFMMAg8RNVBv4t74ApVds33Nr2L4PoRFdOrDOZnsgk8sPPHU+TQP6pn8GBLAoZx
	 12xZsB0TjAqdA==
Date: Mon, 28 Oct 2024 08:46:34 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Srinivasulu Thanneeru <dev.srinivasulu@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Jason Gunthorpe <jgg@ziepe.ca>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	=?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-rdma@vger.kernel.org, iommu@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
	kvm@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 05/18] dma: Provide an interface to allow allocate IOVA
Message-ID: <20241028064634.GE1615717@unreal>
References: <cover.1730037276.git.leon@kernel.org>
 <844f3dcf9c341b8178bfbc90909ef13d11dd2193.1730037276.git.leon@kernel.org>
 <CAMtOeKJeVrELCp5JpYTC64KdfKpbnW9a8QrnL6ziCYL48nc=qQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMtOeKJeVrELCp5JpYTC64KdfKpbnW9a8QrnL6ziCYL48nc=qQ@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241028_064641_225648_700C8C76 
X-CRM114-Status: GOOD (  14.22  )
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

On Mon, Oct 28, 2024 at 09:54:49AM +0530, Srinivasulu Thanneeru wrote:
> On Sun, Oct 27, 2024 at 10:23 PM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > From: Leon Romanovsky <leonro@nvidia.com>
> >
> > The existing .map_page() callback provides both allocating of IOVA
> > and linking DMA pages. That combination works great for most of the
> > callers who use it in control paths, but is less effective in fast
> > paths where there may be multiple calls to map_page().
> 
> Can you please share perf stats with this patch in fast path, if available?

I don't have this data for HMM and VFIO as they have other benefits from this
series except performance. For NVMe, I don't have the data yet, but it will
come https://lore.kernel.org/all/cover.1730037261.git.leon@kernel.org/,
as it is the main performant user of this API.

This is the main reason why NVMe series is marked as RFC yet.

Thanks

