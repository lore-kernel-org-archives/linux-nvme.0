Return-Path: <SRS0=nS76=OS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F6A4C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Sep 2021 19:17:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB97B6127A
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Sep 2021 19:17:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CB97B6127A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Fon+78cKKppyAyrAoKj/YxQJfR8+4KZGxiXSX+sm16o=; b=sLAv2u0cxanDvZ
	THENb1KM73FyJO8ziquVJIFnSfQ2MNWFGhZRRn92mC+o+Rj7cjPJ3bJFW1DD++TP9MyQ4qUPadfIS
	SpiPZSUum/wttO57ojUj6U//VKI+jTt1OGpdO3iUwkljvYWoDR5M4GXQJNsprccBrEgxzYzdJrT47
	evacHn4bR7s5Ijc7R8XFhgYJ9DNig/6whw+SIA+kfzTDaOu9kIvDDsmqxQwzH9tJwiITc/iYDejNY
	jFWtKwMO7VjAp/kD/cVZcmXOjlwXURUMm5U08xs8mKEa74bkXrH9vm6ldBY3gXYi1cuevws8tyY21
	h1KZCkQe6HxS0K7KZaDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mVIbq-008d6v-PY; Tue, 28 Sep 2021 19:17:46 +0000
Received: from mail-qt1-x82b.google.com ([2607:f8b0:4864:20::82b])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mVIbo-008d5Q-4T
 for linux-nvme@lists.infradead.org; Tue, 28 Sep 2021 19:17:45 +0000
Received: by mail-qt1-x82b.google.com with SMTP id b16so1894394qtt.7
 for <linux-nvme@lists.infradead.org>; Tue, 28 Sep 2021 12:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=7f1QZiONeDrfm8AhTnbc53U7HhkzQ840mRRtmUewnCI=;
 b=jv2OU4dRonKtBmDWObStEgucOWtPlJyqGW207XvuQpqOpfcn92InOEODzxDn3983J8
 NWUMSihLuwJkDTW1ES/IWD1pW4f1IgZWhUtRjvhMkDyUbQyYUzTcg2auWALiBpPMh6T5
 o6Y/op/SaG0z9lus3Le6nGPTcAsbC0wYw1OmeasBeOOIc0Unh8ixnfIYVGFTDQvdWUf7
 ejnTvxk5F1g8wMgxUrGGmpVnriP2WtOERNRAu+rKxEr8b83QkHsd4GVA2mxfZkrmQHOF
 YHUBTillHF8tNjol2rYAKfciv/4RCk/9bFro7e8E17vrA8nf9zNDkX9XT7E2zrdw+Kvq
 T7bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=7f1QZiONeDrfm8AhTnbc53U7HhkzQ840mRRtmUewnCI=;
 b=Vm9gHkZR9p+27btLtmsn/U3uyv3TIOaU5wOaS6Anosfq7JKSiaAJ3nhBNTu6r6lgnn
 fHfUjHiZ6lanSaOIvIdAklW8U3t5xcE0Iv5QQhJsNkuH0yBSptr48ldNQed9r/H8u9cS
 /ywlT27bHf/ygBzLXZfda5oHmSgGg6hRRxdiwFZ99h51Kvgv3pabZzwHHfXOxpX71Xed
 st9ArBy3nX3BfQG8vdA/D+JDd9Aya3reM9eJUeZdsRiJuZe3PtK69yYhuNq6EMCsJcK3
 v2QobuOqJZ+7z1BIRFqoe6BHxCvz2H6EGyNuWTARqwbZQMf7AbNTaJKn5ILWTbMNggme
 dRZA==
X-Gm-Message-State: AOAM533ZWIxPttPhHDnw2UE4LI6KQOCcAaw4mrme/NwEtGvXZKKiNmTW
 7hNS+OLSV053eAvw5ibwRJGIRA==
X-Google-Smtp-Source: ABdhPJzuCBFM9bapdOvbnZSM2ycmiyqPK8ZUR9G41TIe6DE91xtbhVAs4nO11mNSn8qAAkRHmlWp7A==
X-Received: by 2002:ac8:7d4b:: with SMTP id h11mr7542407qtb.333.1632856663191; 
 Tue, 28 Sep 2021 12:17:43 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
 by smtp.gmail.com with ESMTPSA id c6sm5387224qtx.72.2021.09.28.12.17.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Sep 2021 12:17:42 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1mVIbl-007G4o-JW; Tue, 28 Sep 2021 16:17:41 -0300
Date: Tue, 28 Sep 2021 16:17:41 -0300
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
Subject: Re: [PATCH v3 11/20] RDMA/core: introduce
 ib_dma_pci_p2p_dma_supported()
Message-ID: <20210928191741.GQ3544071@ziepe.ca>
References: <20210916234100.122368-1-logang@deltatee.com>
 <20210916234100.122368-12-logang@deltatee.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210916234100.122368-12-logang@deltatee.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210928_121744_210230_36A50B21 
X-CRM114-Status: GOOD (  18.05  )
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

On Thu, Sep 16, 2021 at 05:40:51PM -0600, Logan Gunthorpe wrote:
> Introduce the helper function ib_dma_pci_p2p_dma_supported() to check
> if a given ib_device can be used in P2PDMA transfers. This ensures
> the ib_device is not using virt_dma and also that the underlying
> dma_device supports P2PDMA.
> 
> Use the new helper in nvme-rdma to replace the existing check for
> ib_uses_virt_dma(). Adding the dma_pci_p2pdma_supported() check allows
> switching away from pci_p2pdma_[un]map_sg().
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>  drivers/nvme/target/rdma.c |  2 +-
>  include/rdma/ib_verbs.h    | 11 +++++++++++
>  2 files changed, 12 insertions(+), 1 deletion(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

> +/*
> + * Check if a IB device's underlying DMA mapping supports P2PDMA transfers.
> + */
> +static inline bool ib_dma_pci_p2p_dma_supported(struct ib_device *dev)
> +{
> +	if (ib_uses_virt_dma(dev))
> +		return false;

If someone wants to make rxe/hfi/qib use this stuff then they will
have to teach the the driver to do all the p2p checks and add some
struct ib_device flag

Jason

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
