Return-Path: <SRS0=nS76=OS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF761C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Sep 2021 19:10:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7913D61209
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Sep 2021 19:10:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7913D61209
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=idZqwVBo0cgR5LBn+c+xaPipVFq9Gam+GODYNzNIy+M=; b=emUMadrqvuMTFI
	1hLe65+OxgRLJl74NQeazU/BzMgfxAj2IoSAz0LaL0USwjkcevzSv4k+goGvBTOylqX7ch8HK6YSf
	XGfQyaLnfaoAvjwxmRcEiEBbmY9bsBAzXblVwlTja5O4lt3siJ63aiQY0O1ctAOVlb4FliGAU9SiL
	V/OFU5mZvg4itsm+FysPYJxnBVMnc2xZxQL0neCHSh1iI6IUfRIczsMJ8UpvG61Jswgffla9azZye
	VoZIsQvcMM94oqYinOkJHvstuBLPD5gjkTwVJSW9ZvYg13q5WITZ2UxOONfP+lXB2fneelQQIqfTQ
	6XLJ3gRcVhratb2DgVDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mVITO-008b89-C9; Tue, 28 Sep 2021 19:09:02 +0000
Received: from mail-il1-x12b.google.com ([2607:f8b0:4864:20::12b])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mVITL-008b6v-CH
 for linux-nvme@lists.infradead.org; Tue, 28 Sep 2021 19:09:00 +0000
Received: by mail-il1-x12b.google.com with SMTP id w1so146641ilv.1
 for <linux-nvme@lists.infradead.org>; Tue, 28 Sep 2021 12:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=EfElY477shD06prhcbkdx9dsGqBCwQCmB0C4j8bm7NE=;
 b=T7zH3yMi0g6yEhgmUnd7mO+Ur7OBh77wHEh6ggvhef5YbyC4wX4RRbWTB44KDdyQtC
 f+qApcKyr3n5Kl16eVfFgQ9tfeyRrR6Elwq6FGHKyACe8YimAJpy7cusTx0oBV41JMIt
 0Hs8ot7T3se64OIay27dLlQhOUiTQMVr0mnUblHvHoq8r+teZ7l8U9BnX5pxcEi+Yk7z
 s5RWLMvLxN8MPYR7eAYwtVLxanwLKsVahoBd3UvKp/b3/2FYvFg85dCO3UV5z34pnkRJ
 KVDkFetoYUVS2clKM8AdqWOtNoT0d0PPUr+04NJyaKP+HVSyA1Hg4mIqDJ4dKgMV/XBl
 XsnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=EfElY477shD06prhcbkdx9dsGqBCwQCmB0C4j8bm7NE=;
 b=mcC6hWb1wakBNJSWbl73QnEkWZjNTRrlejZVuPhOKpeEnR7B9OZvx/YCKqXYC25h95
 1I0zFsVN+LH3xgqq05cCfGMIp+SR0ibJWRNvKLJ+ZBuhheslWsSvvDWCYuOHMqgVZ5+o
 JVIkUKbwYD/KN7/xLXUYCvmeOfiwgwZSfkoRxDAt+APfb+c/wzyNy01JrzqreMduCIoE
 ld4uvbVDBWytuy5PrIyrxLlMg9zzCwuN/SXJtlBevyQPfk1xsU97EhGVr67xoVxWex/h
 /KY9tBexOigmwSc1iJ1D9Thkxu9Rb8dEA5htjUQUnVxd63/XSfAGCP7/g/vLfhZervsT
 fE8g==
X-Gm-Message-State: AOAM532ph8mLIsM6IHIErrLbcTmZNVYS8rpL4G/gv+/5YNmhlyQpLLIw
 Ge78l0usklbpoKViPLZqIgTsjg==
X-Google-Smtp-Source: ABdhPJwirdzukaEVpQtEHLEaN9P3HDIpr/EdIl+V+c/21A4I82mQWg8qeJs2PajODuEvNoAg4jE0MQ==
X-Received: by 2002:a05:6e02:1a6b:: with SMTP id
 w11mr5790685ilv.21.1632856137729; 
 Tue, 28 Sep 2021 12:08:57 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
 by smtp.gmail.com with ESMTPSA id r13sm12324375ilh.80.2021.09.28.12.08.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Sep 2021 12:08:57 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1mVITI-007Fut-4V; Tue, 28 Sep 2021 16:08:56 -0300
Date: Tue, 28 Sep 2021 16:08:56 -0300
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
 Robin Murphy <robin.murphy@arm.com>,
 Martin Oliveira <martin.oliveira@eideticom.com>,
 Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Subject: Re: [PATCH v3 06/20] dma-direct: support PCI P2PDMA pages in
 dma-direct map_sg
Message-ID: <20210928190856.GN3544071@ziepe.ca>
References: <20210916234100.122368-1-logang@deltatee.com>
 <20210916234100.122368-7-logang@deltatee.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210916234100.122368-7-logang@deltatee.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210928_120859_477878_3C54E297 
X-CRM114-Status: GOOD (  30.58  )
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

On Thu, Sep 16, 2021 at 05:40:46PM -0600, Logan Gunthorpe wrote:
> Add PCI P2PDMA support for dma_direct_map_sg() so that it can map
> PCI P2PDMA pages directly without a hack in the callers. This allows
> for heterogeneous SGLs that contain both P2PDMA and regular pages.
> 
> A P2PDMA page may have three possible outcomes when being mapped:
>   1) If the data path between the two devices doesn't go through the
>      root port, then it should be mapped with a PCI bus address
>   2) If the data path goes through the host bridge, it should be mapped
>      normally, as though it were a CPU physical address
>   3) It is not possible for the two devices to communicate and thus
>      the mapping operation should fail (and it will return -EREMOTEIO).
> 
> SGL segments that contain PCI bus addresses are marked with
> sg_dma_mark_pci_p2pdma() and are ignored when unmapped.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>  kernel/dma/direct.c | 44 ++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 38 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 4c6c5e0635e3..fa8317e8ff44 100644
> +++ b/kernel/dma/direct.c
> @@ -13,6 +13,7 @@
>  #include <linux/vmalloc.h>
>  #include <linux/set_memory.h>
>  #include <linux/slab.h>
> +#include <linux/pci-p2pdma.h>
>  #include "direct.h"
>  
>  /*
> @@ -421,29 +422,60 @@ void dma_direct_sync_sg_for_cpu(struct device *dev,
>  		arch_sync_dma_for_cpu_all();
>  }
>  
> +/*
> + * Unmaps segments, except for ones marked as pci_p2pdma which do not
> + * require any further action as they contain a bus address.
> + */
>  void dma_direct_unmap_sg(struct device *dev, struct scatterlist *sgl,
>  		int nents, enum dma_data_direction dir, unsigned long attrs)
>  {
>  	struct scatterlist *sg;
>  	int i;
>  
> -	for_each_sg(sgl, sg, nents, i)
> -		dma_direct_unmap_page(dev, sg->dma_address, sg_dma_len(sg), dir,
> -			     attrs);
> +	for_each_sg(sgl, sg, nents, i) {
> +		if (sg_is_dma_pci_p2pdma(sg)) {
> +			sg_dma_unmark_pci_p2pdma(sg);
> +		} else  {
> +			dma_direct_unmap_page(dev, sg->dma_address,
> +					      sg_dma_len(sg), dir, attrs);
> +		}

If the main usage of this SGL bit is to indicate if it has been DMA
mapped, or not, I think it should be renamed to something clearer.

p2pdma is being used for lots of things now, it feels very
counter-intuitive that P2PDMA pages are not flagged with
something called sg_is_dma_pci_p2pdma().

How about sg_is_dma_unmapped_address() ?
>  
>  	for_each_sg(sgl, sg, nents, i) {
> +		if (is_pci_p2pdma_page(sg_page(sg))) {
> +			map = pci_p2pdma_map_segment(&p2pdma_state, dev, sg);
> +			switch (map) {
> +			case PCI_P2PDMA_MAP_BUS_ADDR:
> +				continue;
> +			case PCI_P2PDMA_MAP_THRU_HOST_BRIDGE:
> +				/*
> +				 * Mapping through host bridge should be
> +				 * mapped normally, thus we do nothing
> +				 * and continue below.
> +				 */
> +				break;
> +			default:
> +				ret = -EREMOTEIO;
> +				goto out_unmap;
> +			}
> +		}
> +
>  		sg->dma_address = dma_direct_map_page(dev, sg_page(sg),
>  				sg->offset, sg->length, dir, attrs);

dma_direct_map_page() can trigger swiotlb and I didn't see this series
dealing with that?

It would probably be fine for now to fail swiotlb_map() for p2p pages?

Jason

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
