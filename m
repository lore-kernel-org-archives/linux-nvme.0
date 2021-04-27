Return-Path: <SRS0=pISK=JY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23BE7C433B4
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Apr 2021 19:40:46 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 609CC613F5
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Apr 2021 19:40:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 609CC613F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=+2ikLY9Kb322tYmjL4CxOfk6Jisb0Nk4+VPf0bWs0JE=; b=SB7eOYV8OZK2Gp2W6oZb0tvou
	vZ0WySWELd7QGUnPxy7wSB7/MdfRMwhZWkKFusfDdKWP0FmuC1g9Onr0D4jJlPMpd0oJBokMTuxZ8
	IzqXpLedXDxXNqZFvlOYC0EtNtE3SNZGTzeb3SsrDkWLXm3B3y090f/nNLGBuKxBYaVHe+s77KIVD
	0VXqu2BKTwnJinBn4222LDyLjaDGShg88k4pmnnhWnvZpN3h9QECpvV6nP/UBBAn/3gQQzN431Fy2
	A3uWWtZ5K3h7HfqO3dwTuxBan1diSxEs37mUWlGAQQNz47oGMN1jIUAdaXdy6omtwGqftdioOMomp
	idsRv/OyA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lbTZI-0028LR-Um; Tue, 27 Apr 2021 19:40:25 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbTZF-0028L6-Uf
 for linux-nvme@desiato.infradead.org; Tue, 27 Apr 2021 19:40:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=Qjlzws9tOjfG2kgF5PSaus20BHkak4AbpiykyhDCpWc=; b=ql0ny2pGvsw7CC0RfM8d4u1PdX
 q3sVCNf0vHQBFFX9BC3ksNdRAkJBvgWv6mxDwvQxj1SASczoUJjWd2GFf6Mjvc50dEGAOifUzXmnm
 dqFZdkfXWEaV6105GyJ3Df2+PWxyUwcu3VEpHhshf7cE/BBI2m5xlj+Jw9Z3HRw/VWvQOSu9CaFHF
 UO50Yg6NDO5S2rsl0K8m12TiFt3XW403S0HozLatFbQH6LuYpK3BtSCJvZ2BuiwvoaAr2mO2XClr5
 9hynOLwoeXZ+83qlhyzXMLz5H1mVDvOV1+VWK+G9aCc/a9P3w5nX09oMBVieYoGY8F/IWX+LiZCx9
 7wwE9WWw==;
Received: from mail-qk1-x731.google.com ([2607:f8b0:4864:20::731])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbTZA-00Gwtn-Pf
 for linux-nvme@lists.infradead.org; Tue, 27 Apr 2021 19:40:18 +0000
Received: by mail-qk1-x731.google.com with SMTP id i12so29669163qke.3
 for <linux-nvme@lists.infradead.org>; Tue, 27 Apr 2021 12:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=Qjlzws9tOjfG2kgF5PSaus20BHkak4AbpiykyhDCpWc=;
 b=FgJgWNr62C5ZYe5v1vnbBayAlBas9KMfjlI+laH23uWCOINrv2HqPW9/a2+lK1+qpn
 Zdr+bMJ3dVh1M82cRSTI4JbQADrXanZ5JfGjdWIrOPB62lKoHfvu6nr6Gx+k2tmRlxI9
 VnIPeqy1NjUABHuJSDWeU4As9HayrnVGiZr56daurC5uY37+XvT8TZlGM0+FK9uB/Zvv
 YTKfdf8OvZo8ENhSomjWbrDXc8AvVOdpQ72iroWjNxj+tV6CHjB8W81hADxRNQW+tUQ7
 dB77SYRDbWj7e5FkrYJA2fixQk601M0tulsmdtPUJHEnm9ZHX5SNJW5GF5Co+YjnesqM
 4DUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Qjlzws9tOjfG2kgF5PSaus20BHkak4AbpiykyhDCpWc=;
 b=gpIv4Pf7Wlhcy0w3nE6yYuP7CBJibfDGR/fzamhwQSkLB0MD3N2tLrILuYjrXyPOjK
 H2cAcyvPKUBeKBdUueodR9oVxBmILBapjN3b/jGMruRli0D5eKviH0B3wMh+buzle2c5
 tZBSNYrgR89ByS2uIhwtBpLx3lZ+QgSFDbVefnCUg8Dy71oYtNMbyzijwhLLG2+B1xXt
 mF1N6f6fMd1GTTF1Fa41G6H1EU4K0+GriVUZToNTgFao3avtQDAXiA+fJvc9sB86A84i
 mS6DgrnUAFnAZM38tdxpSUvQyRWt4Bpf6kyYRKJusHBcRkZGWiBMDbTsGOPh50lh1i4G
 E8/g==
X-Gm-Message-State: AOAM532hZVZBBU57OGWczy5JRDztu7jXNK4g1yp5Aq2V/za8ALgRL0F+
 lnU4GFff4VIFeO/AAdzbcZcx5Q==
X-Google-Smtp-Source: ABdhPJzTB/kVzpwj6kXVp9NJ/SmSPf5xftMaBkmkgU98M9PRxB8v4F4XSKjG3yTN0WaJic3//dLNPQ==
X-Received: by 2002:a37:ccb:: with SMTP id 194mr7861132qkm.45.1619552415304;
 Tue, 27 Apr 2021 12:40:15 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
 by smtp.gmail.com with ESMTPSA id d3sm605486qtm.56.2021.04.27.12.40.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Apr 2021 12:40:14 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1lbTZ7-00Dh3g-Sk; Tue, 27 Apr 2021 16:40:13 -0300
Date: Tue, 27 Apr 2021 16:40:13 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-mm@kvack.org, iommu@lists.linux-foundation.org,
 Stephen Bates <sbates@raithlin.com>, Christoph Hellwig <hch@lst.de>,
 Dan Williams <dan.j.williams@intel.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 John Hubbard <jhubbard@nvidia.com>, Don Dutile <ddutile@redhat.com>,
 Matthew Wilcox <willy@infradead.org>,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 Jakowski Andrzej <andrzej.jakowski@intel.com>,
 Minturn Dave B <dave.b.minturn@intel.com>,
 Jason Ekstrand <jason@jlekstrand.net>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Xiong Jianxin <jianxin.xiong@intel.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Ira Weiny <ira.weiny@intel.com>,
 Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 09/16] dma-direct: Support PCI P2PDMA pages in dma-direct
 map_sg
Message-ID: <20210427194013.GS2047089@ziepe.ca>
References: <20210408170123.8788-1-logang@deltatee.com>
 <20210408170123.8788-10-logang@deltatee.com>
 <20210427193351.GR2047089@ziepe.ca>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210427193351.GR2047089@ziepe.ca>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210427_124016_861282_A6CDC7CE 
X-CRM114-Status: GOOD (  21.69  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Apr 27, 2021 at 04:33:51PM -0300, Jason Gunthorpe wrote:
> On Thu, Apr 08, 2021 at 11:01:16AM -0600, Logan Gunthorpe wrote:
> > Add PCI P2PDMA support for dma_direct_map_sg() so that it can map
> > PCI P2PDMA pages directly without a hack in the callers. This allows
> > for heterogeneous SGLs that contain both P2PDMA and regular pages.
> > 
> > SGL segments that contain PCI bus addresses are marked with
> > sg_mark_pci_p2pdma() and are ignored when unmapped.
> > 
> > Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> >  kernel/dma/direct.c | 25 ++++++++++++++++++++++---
> >  1 file changed, 22 insertions(+), 3 deletions(-)
> > 
> > diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> > index 002268262c9a..108dfb4ecbd5 100644
> > +++ b/kernel/dma/direct.c
> > @@ -13,6 +13,7 @@
> >  #include <linux/vmalloc.h>
> >  #include <linux/set_memory.h>
> >  #include <linux/slab.h>
> > +#include <linux/pci-p2pdma.h>
> >  #include "direct.h"
> >  
> >  /*
> > @@ -387,19 +388,37 @@ void dma_direct_unmap_sg(struct device *dev, struct scatterlist *sgl,
> >  	struct scatterlist *sg;
> >  	int i;
> >  
> > -	for_each_sg(sgl, sg, nents, i)
> > +	for_each_sg(sgl, sg, nents, i) {
> > +		if (sg_is_pci_p2pdma(sg)) {
> > +			sg_unmark_pci_p2pdma(sg);
> 
> This doesn't seem nice, the DMA layer should only alter the DMA
> portion of the SG, not the other portions. Is it necessary?

Oh, I got it completely wrong what this is for.

This should be named sg_dma_mark_pci_p2p() and similar for other
functions to make it clear it is part of the DMA side of the SG
interface (eg it is like sg_dma_address, sg_dma_len, etc)

Jason

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
