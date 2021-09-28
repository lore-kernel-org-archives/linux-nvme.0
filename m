Return-Path: <SRS0=nS76=OS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 203F4C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Sep 2021 18:56:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4D4B61246
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Sep 2021 18:56:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C4D4B61246
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tIL45ia/i3UrB3RAPnPt4Xuij5QD2iZt1TQeiX8KcN0=; b=zwtQ4L+ynxOaz0
	mijJ405whgO5qxceZ/TTcanMytHo1EjNZcaMkWxZdFTQAgd5wpXy4Kwfv0CPJwAfPLKAHXS/68rSh
	C6aP977IV9OxKYAEkW73gozmI4iNQloCnde2zgr5G9eqirMuX97Iyz91khzpap6Xril9f67RF0MHq
	CMitM7kRQt6xCxta0kZuTPUnY4FsNdht7ykNqcxodWoAM384zk6dVDNryGpBTzuAXmTAZCGOlFFrv
	Uvf1h82YNCJA5AILoOgHFAoRyJofXb6hDsNG4TLmAJ5OKoLADXAM9Y9FFTNkJoWGBAbkSaizy412O
	dS2CTkq7QokuOh+GxlZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mVIGl-008XbF-9f; Tue, 28 Sep 2021 18:55:59 +0000
Received: from mail-qt1-x831.google.com ([2607:f8b0:4864:20::831])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mVIGh-008XZ4-ER
 for linux-nvme@lists.infradead.org; Tue, 28 Sep 2021 18:55:57 +0000
Received: by mail-qt1-x831.google.com with SMTP id l13so20912933qtv.3
 for <linux-nvme@lists.infradead.org>; Tue, 28 Sep 2021 11:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=ebZlYMj5MQ2pOTOwk0j9IKlcwdjsdmrFMDz+5vItq+c=;
 b=QmduZpNQDgW0HX/nW9RkW9k4dvojdWvu6yI+Y+rCA9o9oH5bVLI6TsHunUzrSn1qan
 PHU5+AW3MXramsIkU+ZDSrxmYZBvYuQYjMJ8ZK3HTUAC/kk+ABbFI4PQo0l6PK6M7nRv
 n9Qd+JTkspzOmRVuSE1NXDvXPcxu9E655NnWfHIdpbSyUqeZ7AB0M+jzXvboydl8/4mW
 Q+dh5+5Bb8TwSQyJYjXU55dzd2f6hLFNFMramZxQUeiowu7DX/YyaxsNVUfw6W0sCx/t
 RtayIzeJe4Z2LkvZb8z0oxWAhpakBOql79f7LUXTsyzSQH6U2cnhDUwgm442Ri1+Tm5t
 65Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ebZlYMj5MQ2pOTOwk0j9IKlcwdjsdmrFMDz+5vItq+c=;
 b=0PAdIna2uwDZKpvwzWayZIoOWJPbpTcaxe2qLvgmwphZQT1We0yMZzfNn50ELrKghd
 U9RPK5Mxl3l5vbhTfuqH4l+/xeejsX2+mqwvJmAgnjJe5FjoOh6PfJF2EmETAd+ZBp7J
 hAbT3YhSR4T63iv+Z/DgRYeC4igXE+nQzP4+Hqpn5BsSDEXgk9etY6xgCneQGeNTtEBG
 ZFK+iDY59nUONvzZ5hufdWyKGI7VA0ELnL3H8BdshjkI9L18+pUAcBlfemKKFv0XCXZ8
 SJ2usOSkf9Vude2QE0xESmeICTXkV6t8Bny0xS4robReMInhIjUbdMyxgwYzy8hrqkeZ
 MnDg==
X-Gm-Message-State: AOAM533VV3gToTr1tKOojE34X/80MeUg8z6uRZeXWZsws8sOIC/+s/K2
 8eQSduIyysj2CzIVEcETKboS+g==
X-Google-Smtp-Source: ABdhPJzc93AKyHeS6K7zWxJdqrv7pkOmkEPKPPpfQfpspxPiIl8jo/No84ral2c1mS98kp4huyOz7g==
X-Received: by 2002:ac8:7eee:: with SMTP id r14mr7427193qtc.56.1632855354397; 
 Tue, 28 Sep 2021 11:55:54 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
 by smtp.gmail.com with ESMTPSA id bm27sm15284065qkb.6.2021.09.28.11.55.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Sep 2021 11:55:53 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1mVIGe-007Fgc-Tq; Tue, 28 Sep 2021 15:55:52 -0300
Date: Tue, 28 Sep 2021 15:55:52 -0300
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
Subject: Re: [PATCH v3 04/20] PCI/P2PDMA: introduce helpers for dma_map_sg
 implementations
Message-ID: <20210928185552.GL3544071@ziepe.ca>
References: <20210916234100.122368-1-logang@deltatee.com>
 <20210916234100.122368-5-logang@deltatee.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210916234100.122368-5-logang@deltatee.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210928_115555_526635_721807C6 
X-CRM114-Status: GOOD (  27.15  )
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

On Thu, Sep 16, 2021 at 05:40:44PM -0600, Logan Gunthorpe wrote:
> Add pci_p2pdma_map_segment() as a helper for simple dma_map_sg()
> implementations. It takes an scatterlist segment that must point to a
> pci_p2pdma struct page and will map it if the mapping requires a bus
> address.
> 
> The return value indicates whether the mapping required a bus address
> or whether the caller still needs to map the segment normally. If the
> segment should not be mapped, -EREMOTEIO is returned.
> 
> This helper uses a state structure to track the changes to the
> pgmap across calls and avoid needing to lookup into the xarray for
> every page.
> 
> Also add pci_p2pdma_map_bus_segment() which is useful for IOMMU
> dma_map_sg() implementations where the sg segment containing the page
> differs from the sg segment containing the DMA address.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>  drivers/pci/p2pdma.c       | 59 ++++++++++++++++++++++++++++++++++++++
>  include/linux/pci-p2pdma.h | 21 ++++++++++++++
>  2 files changed, 80 insertions(+)
> 
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index b656d8c801a7..58c34f1f1473 100644
> +++ b/drivers/pci/p2pdma.c
> @@ -943,6 +943,65 @@ void pci_p2pdma_unmap_sg_attrs(struct device *dev, struct scatterlist *sg,
>  }
>  EXPORT_SYMBOL_GPL(pci_p2pdma_unmap_sg_attrs);
>  
> +/**
> + * pci_p2pdma_map_segment - map an sg segment determining the mapping type
> + * @state: State structure that should be declared outside of the for_each_sg()
> + *	loop and initialized to zero.
> + * @dev: DMA device that's doing the mapping operation
> + * @sg: scatterlist segment to map
> + *
> + * This is a helper to be used by non-iommu dma_map_sg() implementations where
> + * the sg segment is the same for the page_link and the dma_address.
> + *
> + * Attempt to map a single segment in an SGL with the PCI bus address.
> + * The segment must point to a PCI P2PDMA page and thus must be
> + * wrapped in a is_pci_p2pdma_page(sg_page(sg)) check.
> + *
> + * Returns the type of mapping used and maps the page if the type is
> + * PCI_P2PDMA_MAP_BUS_ADDR.
> + */
> +enum pci_p2pdma_map_type
> +pci_p2pdma_map_segment(struct pci_p2pdma_map_state *state, struct device *dev,
> +		       struct scatterlist *sg)
> +{
> +	if (state->pgmap != sg_page(sg)->pgmap) {
> +		state->pgmap = sg_page(sg)->pgmap;
> +		state->map = pci_p2pdma_map_type(state->pgmap, dev);
> +		state->bus_off = to_p2p_pgmap(state->pgmap)->bus_offset;
> +	}

Is this safe? I was just talking with Joao about this,

 https://lore.kernel.org/r/20210928180150.GI3544071@ziepe.ca

API wise I absolutely think this should be safe as written, but is it
really?

Does pgmap ensure that a positive refcount struct page always has a
valid pgmap pointer (and thus the mess in gup can be deleted) or does
this need to get the pgmap as well to keep it alive?

Jason

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
