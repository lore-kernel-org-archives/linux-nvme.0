Return-Path: <SRS0=w6YM=OR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30918C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Sep 2021 18:50:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF0FE60E09
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Sep 2021 18:50:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EF0FE60E09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=tn1Oiu00vk7x6iCDJrj7MSMmK1cHCoU2qGErJaUrxCw=; b=yhVa8EbG9+vg6N
	Krbdwoen7apRHFkV5R/x7kps/IeCJNByixgWdWbHOIzLxLkeJtW4CP7bRoyvGCjDsDfD9ZIKxFoIF
	UTSDYkhro+848TkisQ0vEIOFink7/2LlrOhy9xLhUM6PebW/ZLqodpXSB+0T5a79Yk0+JXi4dpFuU
	v9fbHAAEIhPp4iM1fsMKE9PmGB0pyOrN+7N682T0eA+hbuRiyOGfbvprYGW7topjgr7lt0AV2WPwR
	XCNWNOkyqu9zJrDRyRgCyV9aVmOR0uIDDm/V64MchCn+DikmmXKIrFACNmCbFYSSrb3VA+Vf1qh3x
	DP9CJT9BaKZd6QHBzB5A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mUvi5-003q51-0e; Mon, 27 Sep 2021 18:50:41 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mUvi2-003q3Q-Gq
 for linux-nvme@lists.infradead.org; Mon, 27 Sep 2021 18:50:39 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id CDAE961058;
 Mon, 27 Sep 2021 18:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1632768638;
 bh=C5XC6h6Q1qc5Qf6BQUNRzYX2mM+5Ej8TnIc335MIf3Y=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=sxhqG2OwJcmYiPbgyuP+0xu6/gEhxQlRDh6b0Q4SBqBqsN4nn+REtn//Bigm2XegR
 ltuanBZSrm5Dt6GJFsiwiA23f1AVvAUrGESKtat3QIvJZJcdHhUShJO+a3JDGkAcOZ
 hBm+bbjGjp1eJ3L8+BW1Hvy5k/t+DXjcmafsp4Qwiq5fz+FPcHdN7cSv1nVdS+iH5j
 4+kUSasJvEa4tLbjzHFbG61XTE6v9SW+4inMLS7Rk3O6gACDrFD9x0m5Kg3tADTBv7
 oK+UBQkgmZxlMMOwZ7wxWruTgiS8aySMoZgqahsIPVSzl9H8IY1XOu/MeIQNBzPO5O
 hg5kqidrgvEnw==
Date: Mon, 27 Sep 2021 13:50:36 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-mm@kvack.org, iommu@lists.linux-foundation.org,
 Stephen Bates <sbates@raithlin.com>, Christoph Hellwig <hch@lst.de>,
 Dan Williams <dan.j.williams@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 John Hubbard <jhubbard@nvidia.com>, Don Dutile <ddutile@redhat.com>,
 Matthew Wilcox <willy@infradead.org>,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 Jakowski Andrzej <andrzej.jakowski@intel.com>,
 Minturn Dave B <dave.b.minturn@intel.com>,
 Jason Ekstrand <jason@jlekstrand.net>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Xiong Jianxin <jianxin.xiong@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Robin Murphy <robin.murphy@arm.com>,
 Martin Oliveira <martin.oliveira@eideticom.com>,
 Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Subject: Re: [PATCH v3 02/20] PCI/P2PDMA: attempt to set map_type if it has
 not been set
Message-ID: <20210927185036.GA668115@bhelgaas>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210916234100.122368-3-logang@deltatee.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210927_115038_611912_34BE9B62 
X-CRM114-Status: GOOD (  18.99  )
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

On Thu, Sep 16, 2021 at 05:40:42PM -0600, Logan Gunthorpe wrote:
> Attempt to find the mapping type for P2PDMA pages on the first
> DMA map attempt if it has not been done ahead of time.
> 
> Previously, the mapping type was expected to be calculated ahead of
> time, but if pages are to come from userspace then there's no
> way to ensure the path was checked ahead of time.
> 
> With this change it's no longer invalid to call pci_p2pdma_map_sg()
> before the mapping type is calculated so drop the WARN_ON when that
> is the case.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Capitalize subject line.

> ---
>  drivers/pci/p2pdma.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index 50cdde3e9a8b..1192c465ba6d 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -848,6 +848,7 @@ static enum pci_p2pdma_map_type pci_p2pdma_map_type(struct dev_pagemap *pgmap,
>  	struct pci_dev *provider = to_p2p_pgmap(pgmap)->provider;
>  	struct pci_dev *client;
>  	struct pci_p2pdma *p2pdma;
> +	int dist;
>  
>  	if (!provider->p2pdma)
>  		return PCI_P2PDMA_MAP_NOT_SUPPORTED;
> @@ -864,6 +865,10 @@ static enum pci_p2pdma_map_type pci_p2pdma_map_type(struct dev_pagemap *pgmap,
>  		type = xa_to_value(xa_load(&p2pdma->map_types,
>  					   map_types_idx(client)));
>  	rcu_read_unlock();
> +
> +	if (type == PCI_P2PDMA_MAP_UNKNOWN)
> +		return calc_map_type_and_dist(provider, client, &dist, false);
> +
>  	return type;
>  }
>  
> @@ -906,7 +911,6 @@ int pci_p2pdma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
>  	case PCI_P2PDMA_MAP_BUS_ADDR:
>  		return __pci_p2pdma_map_sg(p2p_pgmap, dev, sg, nents);
>  	default:
> -		WARN_ON_ONCE(1);
>  		return 0;
>  	}
>  }
> -- 
> 2.30.2
> 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
