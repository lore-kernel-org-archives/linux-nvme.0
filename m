Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E05A3D11101
	for <linux-nvme@archiver.kernel.org>; Sun,  3 Nov 2024 15:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2Wvx0XOKfGs+Recd6943nsECYiCGgVMKahj+Yyyubsg=; b=fLRdV0RBKhuKMg6NnAPT7oiAwg
	OgqAJUDaG3ujWbx6ObVC3zCOY68aM8fV3XVL5hxT1lcpf71r52ZQ6hyFO5/Ht/Qs05tV+g6ToFdpC
	w2cCauSydjf9InpJvHFhTK+5cmMJgGciQQk7LWx+UeHTJLuZuGdr7QD1x0Sn8+0RV+WbAlSuXuxZd
	hhKNuKbMNot9t6hT7QcJAcM1ljFe8wJmDb/ia5RZhveGIyGKx+vHPDS1eSNRzWDJENWNluOxptA3A
	eV/WTGmL+W5FlHob0ZIqSG06aOcp+XL6EVsp1Ps4BxEhifvhRTB5udPLzbo2z0U1y5dXK157jUz6I
	exlVI7KA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t7cOW-0000000BcJM-1OAd;
	Sun, 03 Nov 2024 15:20:00 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t7cOT-0000000BcIw-2nlf
	for linux-nvme@lists.infradead.org;
	Sun, 03 Nov 2024 15:19:59 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 15F335C4A07;
	Sun,  3 Nov 2024 15:19:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D95DC4CECD;
	Sun,  3 Nov 2024 15:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730647195;
	bh=SfCXMZbNHN7ZBHtRMXT8dYyPlDizsgfBlczM/Izb1OA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j5cWNoE8etENxU7IbfrBszJT10f6EWlfJqpPGvOpaZLTiWI1AidHTPWSL24msep+k
	 At1fyHSehamOum/Kpf4tDMLVsWjyCbFVB1L3+uJPROcdL+JtfpRWtGbmTmmXws4+mU
	 6Tax5d+Pem6waJZPuDXZsKSMbCUFxwDHGiatqmjanHAiNyMOnFy3GO/14wUoY9qDlK
	 mafUcrdLGbf/qNYnEXemxmwc/kgO13ERQSBD0Q59NhZKcEgGCMs/Jsfq3Fei7V6xWc
	 KS0Si/iP8Vl1pnx/fUh5aIOdBMiN7U2MYN4bxu2bUCfSI0yrbv2ocwZ0+G5O8IPgHi
	 San3mdWHVOs/A==
Date: Sun, 3 Nov 2024 17:19:46 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Zhu Yanjun <yanjun.zhu@linux.dev>
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
Subject: Re: [RFC PATCH 2/7] block: don't merge different kinds of P2P
 transfers in a single bio
Message-ID: <20241103151946.GA99170@unreal>
References: <cover.1730037261.git.leon@kernel.org>
 <34d44537a65aba6ede215a8ad882aeee028b423a.1730037261.git.leon@kernel.org>
 <f80e7b54-b897-4df2-a49d-bc6012640a8a@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f80e7b54-b897-4df2-a49d-bc6012640a8a@linux.dev>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241103_071957_818360_7ACB3AF0 
X-CRM114-Status: GOOD (  19.12  )
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

On Sat, Nov 02, 2024 at 08:39:35AM +0100, Zhu Yanjun wrote:
> 在 2024/10/27 15:21, Leon Romanovsky 写道:
> > From: Christoph Hellwig <hch@lst.de>
> > 
> > To get out of the dma mapping helpers having to check every segment for
> > it's P2P status, ensure that bios either contain P2P transfers or non-P2P
> > transfers, and that a P2P bio only contains ranges from a single device.
> > 
> > This means we do the page zone access in the bio add path where it should
> > be still page hot, and will only have do the fairly expensive P2P topology
> > lookup once per bio down in the dma mapping path, and only for already
> > marked bios.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > ---
> >   block/bio.c               | 36 +++++++++++++++++++++++++++++-------
> >   block/blk-map.c           | 32 ++++++++++++++++++++++++--------
> >   include/linux/blk_types.h |  2 ++
> >   3 files changed, 55 insertions(+), 15 deletions(-)

<...>

> > @@ -410,6 +411,7 @@ enum req_flag_bits {
> >   #define REQ_DRV		(__force blk_opf_t)(1ULL << __REQ_DRV)
> >   #define REQ_FS_PRIVATE	(__force blk_opf_t)(1ULL << __REQ_FS_PRIVATE)
> >   #define REQ_ATOMIC	(__force blk_opf_t)(1ULL << __REQ_ATOMIC)
> > +#define REQ_P2PDMA	(__force blk_opf_t)(1ULL << __REQ_P2PDMA)
> 
> #define REQ_P2PDMA	(__force blk_opf_t)BIT_ULL(__REQ_P2PDMA)
> 
> Use BIT_ULL instead of direct left shit.

We keep coding style consistent and all defines above aren't implemented
with BIT_ULL().

Thanks

> 
> Zhu Yanjun
> 
> >   #define REQ_NOUNMAP	(__force blk_opf_t)(1ULL << __REQ_NOUNMAP)
> 

