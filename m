Return-Path: <SRS0=nS76=OS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CDA9C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Sep 2021 18:49:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1035D60F9D
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Sep 2021 18:49:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1035D60F9D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kP8FHS0mLhLERt8sFaLQvU49suFLbEAFyfy67kZd6xU=; b=QmjLj0k6ezcmhI
	1oEU4i6tOAHdN7A+evZd06z5QkHYVS6fd8slvRBkl/l2ZMyp+VIyp/88sBpNEOBTYpRcWMngGFCer
	+1NgObfvYjjYypfUfciVCccqzh82BEUk0uBFpLh2ii4f8tx+P5h4Wv/XvSMcIVGcb/5oWLuNQiqCO
	lBL/xPmc+hry7QrTtuPh7Y3eCoIFYdr1xh6LwqitlR96ETeCHUTy1eaolL2s+g4DAhEsD7+w/57pE
	kN+9x7NKG4+nWTWA3GeRalxwxRZiANWaOb0TsShruxtKXcWsxPW7sR8YRazd6+opZ++d0XyKU4BuG
	hZ6Z1198KBmSJtGWdCCQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mVI9u-008WLx-FX; Tue, 28 Sep 2021 18:48:54 +0000
Received: from mail-qt1-x82e.google.com ([2607:f8b0:4864:20::82e])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mVI9r-008WKa-8R
 for linux-nvme@lists.infradead.org; Tue, 28 Sep 2021 18:48:52 +0000
Received: by mail-qt1-x82e.google.com with SMTP id r16so20817023qtw.11
 for <linux-nvme@lists.infradead.org>; Tue, 28 Sep 2021 11:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=V9OdhKHkz+bDWOgw519ym53HGQqRyLuvFdP/XrS7z5w=;
 b=U6Cle1ar5YMOX4vRLBQAyCUIzflL0rP5DDqpOBJE+YXNQaN+2OCi9d0Iy1j+ZqEb0q
 ldJaiLHkalWypayZHQx3L3YPO9DcOqCmj/7fnNa9sm7+IILMYJgnEeoBHOfV3+5sIA1G
 7PoT13IhlGy54nJMnWjX2JC+DO7VxjDE7MqR0TIZG4kkDyH5MeFimp+WrD7+H8fZcSrr
 rjU6GjV1RHVgJefkq1bsjD7HjG42edUR2AMuNMVNVDWGsf2VmvclfT7eJ7t5/82dwAMV
 kHPwsALEwDASPTTgXVp7pyVtxMvNs1y+xdofJ6ktmPZVIieklzttcPQ7dqgixshVYpDP
 cjwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=V9OdhKHkz+bDWOgw519ym53HGQqRyLuvFdP/XrS7z5w=;
 b=wnvCM80xVKvI0UOJXgMXk+EbtdzUd+E44unzFXUUZUxvyCg8v/pIdpy/tg8ClVfl4H
 hMJN5COG5O+iQl/oDQCbSV2Q9DigRExqB5PyNNG+fPJtrdoMw8PCmY4jFIjkmKxpUT62
 IVvREAfh4wQiY7BGOIejCkc7813li9AfP4f6QhSxQtzuKAsOgVKjO7cFfueqZgj4mJqe
 T6tmG2q9ZH9cGcHySWjFtVljwbioLN/pHDQ1EvDGC9ug5P3Mumi/F2rO+S88CFp+WMy/
 AYsazAO30uOAU53RYjqT+KYCZm9QuS3gfIcBd7KOinC2G+BsRK3GZSPPxlLOt5vQ7lWt
 ouNQ==
X-Gm-Message-State: AOAM5313zbAQ506SpCkEtV4Mf2sbUGWfNkG20C7DVvJa/LSWF2FIWmP9
 b0wDTvt64W5V991/simNXpVw8g==
X-Google-Smtp-Source: ABdhPJxMh4uLV/Co2Bi0Uj4NMD1oETxTUQz1ehKuaeVQOMiXGKhC5tKssJhY1an+RZ/0cNTGVGgAwg==
X-Received: by 2002:ac8:46c8:: with SMTP id h8mr7389965qto.341.1632854929767; 
 Tue, 28 Sep 2021 11:48:49 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
 by smtp.gmail.com with ESMTPSA id b65sm15601470qkc.46.2021.09.28.11.48.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Sep 2021 11:48:49 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1mVI9o-007FZ4-5q; Tue, 28 Sep 2021 15:48:48 -0300
Date: Tue, 28 Sep 2021 15:48:48 -0300
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
Subject: Re: [PATCH v3 03/20] PCI/P2PDMA: make pci_p2pdma_map_type() non-static
Message-ID: <20210928184848.GK3544071@ziepe.ca>
References: <20210916234100.122368-1-logang@deltatee.com>
 <20210916234100.122368-4-logang@deltatee.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210916234100.122368-4-logang@deltatee.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210928_114851_343525_AF5A6183 
X-CRM114-Status: GOOD (  16.56  )
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

On Thu, Sep 16, 2021 at 05:40:43PM -0600, Logan Gunthorpe wrote:
> +enum pci_p2pdma_map_type {
> +	/*
> +	 * PCI_P2PDMA_MAP_UNKNOWN: Used internally for indicating the mapping
> +	 * type hasn't been calculated yet. Functions that return this enum
> +	 * never return this value.
> +	 */
> +	PCI_P2PDMA_MAP_UNKNOWN = 0,
> +
> +	/*
> +	 * PCI_P2PDMA_MAP_NOT_SUPPORTED: Indicates the transaction will
> +	 * traverse the host bridge and the host bridge is not in the
> +	 * whitelist. DMA Mapping routines should return an error when

I gather we are supposed to type allowlist now

> +	 * this is returned.
> +	 */
> +	PCI_P2PDMA_MAP_NOT_SUPPORTED,
> +
> +	/*
> +	 * PCI_P2PDMA_BUS_ADDR: Indicates that two devices can talk to
> +	 * eachother directly through a PCI switch and the transaction will

'each other'

> +	 * not traverse the host bridge. Such a mapping should program
> +	 * the DMA engine with PCI bus addresses.
> +	 */
> +	PCI_P2PDMA_MAP_BUS_ADDR,
> +
> +	/*
> +	 * PCI_P2PDMA_MAP_THRU_HOST_BRIDGE: Indicates two devices can talk
> +	 * to eachother, but the transaction traverses a host bridge on the

'each other'

> +	 * whitelist. In this case, a normal mapping either with CPU physical
> +	 * addresses (in the case of dma-direct) or IOVA addresses (in the
> +	 * case of IOMMUs) should be used to program the DMA engine.
> +	 */
> +	PCI_P2PDMA_MAP_THRU_HOST_BRIDGE,
> +};

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
