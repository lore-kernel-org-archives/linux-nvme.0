Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A281C54E67
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Mar 2024 15:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UVsTc5C9/FhivAdoyZVDRCC5uwGwzmvGccuOt9lmP44=; b=e3t2vI1mrj0lQ/yqOkCyvoGh5u
	CHlAxYx6/R4yqlO5fYS/PdwzE+s5h0wflsTbVC9uO4ak/5j89e6xVzwBb9hq2oNRfOdLjuKTnNiSG
	gPPDXwPwGkOfKDwlLcfuj5caVHpcpfGh2BoVdVI1vvvfREUnDXYf/II1dOlpu/pYKb7ua3oZ69sxU
	y/mL68Nvzg8PBUUEakuwhvi1W0sIYZXxsWw/sf2oJrIWalN4IjNhPSmHIRjKOY0NfnxIXh9H42ShI
	s3FuOxSe8ofj0V78sUEFL5Fvw6E8n1kpQOlD8f0kByz37cDcvtiENuwIGRFWMAR/8C876NBrSYx5c
	1oD6Iceg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rkQMq-0000000Aa5I-14dy;
	Wed, 13 Mar 2024 15:18:08 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rjFaT-0000000FSwT-20bp
	for linux-nvme@lists.infradead.org;
	Sun, 10 Mar 2024 09:35:23 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id DF59860AFA;
	Sun, 10 Mar 2024 09:35:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0B84C433F1;
	Sun, 10 Mar 2024 09:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710063318;
	bh=A56j1ShXDrhKO97iz6szIVzteEyqKgRDBPAwzXDzikI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U5txpaxjWhNjC2+i4ewRBUTMbOl9INv+8VjxpWaxk1WEUrjJg3az83iYX2Mn4D5SW
	 yc6zUeCxxSQMhZvCdnpcpuT+AYCkhv/mL7iK7m+UeKVcbupJn2l7VTPaYgCjgBMOA/
	 BVU6BAh38XlKsUBRkSdAb8irqFKw0ZmI0R/LcvETKy/DSscUI1S6TDxF2MskopGD0N
	 xWRfW9nVMxCaiAkZIpVfqgVBd2dslnlH2l6ODPwVzq2OuPr97rODqlhU5Xm7KbNrxR
	 R7fTvQEaz2EW6Wj0d9pT+Nk4jaz7CJCi9Qxf7jgVSWm1t3UiO2ayk7llGARr05mmDQ
	 jSKO3qAwJxGPw==
Date: Sun, 10 Mar 2024 11:35:13 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	=?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
	iommu@lists.linux.dev, linux-nvme@lists.infradead.org,
	kvm@vger.kernel.org, linux-mm@kvack.org,
	Bart Van Assche <bvanassche@acm.org>,
	Damien Le Moal <damien.lemoal@opensource.wdc.com>,
	Amir Goldstein <amir73il@gmail.com>,
	"josef@toxicpanda.com" <josef@toxicpanda.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>,
	Dan Williams <dan.j.williams@intel.com>,
	"jack@suse.com" <jack@suse.com>, Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: Re: [RFC RESEND 00/16] Split IOMMU DMA mapping operation to two steps
Message-ID: <20240310093513.GB12921@unreal>
References: <20240306154328.GM9225@ziepe.ca>
 <20240306162022.GB28427@lst.de>
 <20240306174456.GO9225@ziepe.ca>
 <20240306221400.GA8663@lst.de>
 <20240307000036.GP9225@ziepe.ca>
 <20240307150505.GA28978@lst.de>
 <20240307210116.GQ9225@ziepe.ca>
 <20240308164920.GA17991@lst.de>
 <20240308202342.GZ9225@ziepe.ca>
 <20240309161418.GA27113@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240309161418.GA27113@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240310_013521_687329_7FBF475E 
X-CRM114-Status: GOOD (  23.57  )
X-Mailman-Approved-At: Wed, 13 Mar 2024 08:18:06 -0700
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

On Sat, Mar 09, 2024 at 05:14:18PM +0100, Christoph Hellwig wrote:
> On Fri, Mar 08, 2024 at 04:23:42PM -0400, Jason Gunthorpe wrote:
> > > The DMA API callers really need to know what is P2P or not for
> > > various reasons.  And they should generally have that information
> > > available, either from pin_user_pages that needs to special case
> > > it or from the in-kernel I/O submitter that build it from P2P and
> > > normal memory.
> > 
> > I think that is a BIO thing. RDMA just calls with FOLL_PCI_P2PDMA and
> > shoves the resulting page list into in a scattertable. It never checks
> > if any returned page is P2P - it has no reason to care. dma_map_sg()
> > does all the work.
> 
> Right now it does, but that's not really a good interface.  If we have
> a pin_user_pages variant that only pins until the next relevant P2P
> boundary and tells you about we can significantly simplify the overall
> interface.

And you will need to have a way to instruct that pin_user_pages() variant
to continue anyway, because you asked for FOLL_PCI_P2PDMA. Without that
force, you will have !FOLL_PCI_P2PDMA behaviour.

When you say "simplify the overall interface", which interface do you mean?

Thanks

