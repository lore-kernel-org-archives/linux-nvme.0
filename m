Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBF24E7DF0F
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Feb 2026 17:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AHybV3doxleWHkR/bk785MWqGcxVGFlonO2D/UGWE6Q=; b=ZvJVLh2w9tW5pApUH/okMstylB
	+GKeF8hWA3uL7zmK14f/1HXVy9CzlMVSAXUJwi5LY6TeLT2tv8QWEJXB84w35zIyeYGPEsZP3168p
	pUDim03ndI4LGoGlGEk59K8ZAyUqxbR2d6o4tdZ/QBqXaDM6x2FwbDqO0eXxPpmnz2A0mtKy9jch+
	Ur0wV5MwamfY11TEeGHG7F+19pF/8HiETKyt7BWGlaKey/GZR6xy4NdO9uBqNwp3Il4UUa5glZ0kg
	ndJ4RXw9J76HS0jz33n8eN8j2Eo/Sc4MnZ8i3DLY2ymTfQdkDRCfHwez0Xi5m9wx6jObsJYcvNIgw
	AfkUo5BQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vmxUQ-00000005LT7-0JpG;
	Mon, 02 Feb 2026 17:13:30 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vmxUN-00000005LSn-3bhn
	for linux-nvme@lists.infradead.org;
	Mon, 02 Feb 2026 17:13:29 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id A86EE4372D;
	Mon,  2 Feb 2026 17:13:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0331EC116C6;
	Mon,  2 Feb 2026 17:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770052406;
	bh=PnTeSEz/9pjprKiZcct6cCdCrR2nu+Q2US70gjU2hzI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=efyVT4MmoBoIf9WD108SCrIdqsSzieOnfwoWnz9AkYkccIfV9kRfDX6XRrXJJDc4t
	 Wewq/KwtZT9e7qlbh8DhLNDkjnpl1w9gd25yaIKGA3hHlZ2uE1aqgO61E8dF5lsahA
	 tU1CqY/UCbcCkm1D4mziGz5DMwAOMslDzFJYFCcZ8OX7QhqquhGD8S7k3UIBwQrC+o
	 CiOGI1Ur+L3pCmCw4J8Qr8hVMNGPt/ZjveCIL0v1CRGZYd1QiVPvfTym1Gi9TYIR1f
	 QL7u7T6u+hSHt26jPsMvc7pjztrUxXAtGl2WZ1XQHezG2yDL8uTjpV77q+2w0iLoVI
	 VHzSaufqcPAtQ==
Date: Mon, 2 Feb 2026 10:13:24 -0700
From: Keith Busch <kbusch@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Pradeep P V K <pradeep.pragallapati@oss.qualcomm.com>,
	axboe@kernel.dk, sagi@grimberg.me, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, nitin.rawat@oss.qualcomm.com,
	Leon Romanovsky <leon@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux.dev
Subject: Re: [PATCH V1] nvme-pci: Fix NULL pointer dereference in
 nvme_pci_prp_iter_next
Message-ID: <aYDbNC1z81D3lZ2r@kbusch-mbp>
References: <20260202143548.GA19313@lst.de>
 <dc34c246-d6ba-4c2e-8593-6fe32a616174@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc34c246-d6ba-4c2e-8593-6fe32a616174@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260202_091328_220415_347E6F99 
X-CRM114-Status: GOOD (  19.05  )
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

On Mon, Feb 02, 2026 at 03:16:50PM +0000, Robin Murphy wrote:
> On 2026-02-02 2:35 pm, Christoph Hellwig wrote:
> > On Mon, Feb 02, 2026 at 06:27:38PM +0530, Pradeep P V K wrote:
> > > Fix a NULL pointer dereference that occurs in nvme_pci_prp_iter_next()
> > > when SWIOTLB bounce buffering becomes active during runtime.
> > > 
> > > The issue occurs when SWIOTLB activation changes the device's DMA
> > > mapping requirements at runtime,
> > > 
> > > creating a mismatch between
> > > iod->dma_vecs allocation and access logic.
> > > 
> > > The problem manifests when:
> > > 1. Device initially operates with dma_skip_sync=true
> > >     (coherent DMA assumed)
> > > 2. First SWIOTLB mapping occurs due to DMA address limitations,
> > >     memory encryption, or IOMMU bounce buffering requirements
> > > 3. SWIOTLB calls dma_reset_need_sync(), permanently setting
> > >     dma_skip_sync=false
> > > 4. Subsequent I/Os now have dma_need_unmap()=true, requiring
> > >     iod->dma_vecs
> > 
> > I think this patch just papers over the bug.  If dma_need_unmap
> > can't be trusted before the dma_map_* call, we've not saved
> > the unmap information and the unmap won't work properly.
> 
> The dma_need_unmap() kerneldoc says:
> 
> "This function must be called after all mappings that might
>  need to be unmapped have been performed."
> 
> Trying to infer anything from it beforehand is definitely a bug in the
> caller.

Well that doesn't really make sense. No matter how many mappings the
driver has done, there will always be more. ?

