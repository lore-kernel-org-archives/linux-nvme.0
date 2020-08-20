Return-Path: <SRS0=ANWg=B6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66198C433E3
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Aug 2020 05:15:29 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 391A020786
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Aug 2020 05:15:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Cuv5C9Pe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 391A020786
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Nn4XiOxNrC00lm6ICNPXClq3LVMobrPp68Elnw++WYQ=; b=Cuv5C9PeHEpizqkrmIOlNzwx5
	J1oYvOGW/X/4Qp3FV9MwjkR5avrQUG+4zQS3ZFddu5stve8PXdwrRk13hlKzVbeW27SRPnrhNZ476
	8ImK/BvJADuxUoGtiK42Ws88ImFU1f+NoK6ADY0H18JWBZ6r70a5RN2tMY//mapnGqDBsuKVZIJxR
	mzDFSLwFsjulBJnibwx4cGn3Pe5TcmhvBiM+xiLS+Zwr4z5+fR4s14vKd4luWEUstFwr0bnXXHJuZ
	GfDZzO/kVUO9goI/ObCKthCfFzHcWRw5hogqgfxEfM5G4DCSCRx21gqFiQBkqdI+KxpRYXAs7/iie
	epUY47l9A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k8cv4-0006I9-R9; Thu, 20 Aug 2020 05:15:22 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k8cuz-0006GO-9u; Thu, 20 Aug 2020 05:15:17 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id A894C68BEB; Thu, 20 Aug 2020 07:15:12 +0200 (CEST)
Date: Thu, 20 Aug 2020 07:15:12 +0200
From: Christoph Hellwig <hch@lst.de>
To: Tomasz Figa <tfiga@chromium.org>
Subject: Re: [PATCH 19/28] dma-mapping: replace DMA_ATTR_NON_CONSISTENT
 with dma_{alloc, free}_pages
Message-ID: <20200820051512.GA5141@lst.de>
References: <20200819065555.1802761-1-hch@lst.de>
 <20200819065555.1802761-20-hch@lst.de>
 <CAAFQd5Bbp-eAVKS1MKS8xtrT4ZoOmBPfZyw9mys=eOmDb6r8Lw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAAFQd5Bbp-eAVKS1MKS8xtrT4ZoOmBPfZyw9mys=eOmDb6r8Lw@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200820_011517_473217_33F14F45 
X-CRM114-Status: GOOD (  20.46  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: alsa-devel@alsa-project.org, linux-ia64@vger.kernel.org,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 nouveau@lists.freedesktop.org, linux-nvme@lists.infradead.org,
 linux-mips@vger.kernel.org,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 linux-mm@kvack.org, Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
 Joonyoung Shim <jy0922.shim@samsung.com>, linux-scsi@vger.kernel.org,
 Kyungmin Park <kyungmin.park@samsung.com>, Ben Skeggs <bskeggs@redhat.com>,
 Matt Porter <mporter@kernel.crashing.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>,
 Tom Lendacky <thomas.lendacky@amd.com>, Pawel Osciak <pawel@osciak.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <linux-arm-kernel@lists.infradead.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-parisc@vger.kernel.org,
 netdev@vger.kernel.org, Seung-Woo Kim <sw0312.kim@samsung.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Aug 19, 2020 at 05:03:52PM +0200, Tomasz Figa wrote:
> >
> > -Warning: These pieces of the DMA API should not be used in the
> > -majority of cases, since they cater for unlikely corner cases that
> > -don't belong in usual drivers.
> > +These APIs allow to allocate pages that can be used like normal pages
> > +in the kernel direct mapping, but are guaranteed to be DMA addressable.
> 
> Could we elaborate a bit more on what "like normal pages in kernel
> direct mapping" mean from the driver perspective?

It mostly means you can call virt_to_page and then do anything you'd
do with a page struct.  Unlike dma_alloc_attrs that just return an
opaque virtual address that the caller is not allowed to poke into.

> There is one aspect that the existing dma_alloc_attrs() handles, but
> this new function doesn't: IOMMU support. The function will always
> allocate a physically-contiguous block memory, which is a costly
> operation and not even guaranteed to succeed, even if enough free
> memory is available.
> 
> Modern SoCs employ IOMMUs to avoid the need to allocate
> physically-contiguous memory and those happen to be also the devices
> that could benefit from non-coherent allocations a lot. One of the
> tasks of the DMA API was making it possible to allocate suitable
> memory for a given device, without having the driver know about the
> SoC integration details, such as the presence of an IOMMU.

This is completely out of scope for this API exactly because it
guarantees a page in the direct mapping.  But see my previous mail
in reply to Robin on how you can implement the funtionality you
want right now without any help from the dma-mapping subsystem.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
