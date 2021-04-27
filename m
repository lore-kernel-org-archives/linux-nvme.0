Return-Path: <SRS0=pISK=JY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 941AAC433ED
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Apr 2021 19:32:19 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02D30613C8
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Apr 2021 19:32:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02D30613C8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=OeGl3lob+2ilFt4AM0pJDbSyDMapE/tmArfq2d2Vyes=; b=eoqWA3hgRqMBL8zoz58ARL4ny
	oxQlxGhvEjIL7EwLlQkQfkn6xck/agNRRql9bBL+MYDsbUWHQBy8a7vLyr+xo1jm1vQdCGiw9c68O
	+oQrPAjrEbBvGe+SXTyM65ufX6GG6OYAT+YTsp5CFrxrMA8rWqYqK1Z8mTqmLwaoEPKkcTvWKQCEO
	cMDBY8KOfEITAwDvS+xRR7sVdlQcToPyXdVouzhpLLF1235PnDk2q35Cqwr5H2UHeqWWHJHg9L1/w
	u7A00AHXD47TjK/dxX72RCcuv3OtH3QbXNo/lTNiXXNNKG9KngVRbhyL04BmZEWNkfqmZbYI1yUkP
	oY/TYQPUg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lbTRE-0027e1-6V; Tue, 27 Apr 2021 19:32:04 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbTRC-0027ds-Mo
 for linux-nvme@desiato.infradead.org; Tue, 27 Apr 2021 19:32:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=Z2dfVSyAhAt8vgpBqMWbMDHuRDstq7cheYx2I0gCKqA=; b=DOaC/2S8KztMUp4bVnGWQefhQK
 iR+m8tWYB0MgNsBzCi7l6+FumLBiMFOl7Q4VzOATnyC8y4MovimGUlt1E7HpbIBFBG6H4lEU+T5Eh
 PZwiDEpHryB1KVAVAUkjaTILqxIcmalVltZcRVB0v8z3Y94s5L7M7nE0wJqKCQAgBWmV67B57m75i
 TN1wNwvdNay+pkDtU3v6+y9SkT14Wc9+qmPKocprlRvvYo2ty9zKV7Rs2nPSAFk15+hT9dH7X/+MC
 XEhu8IULZ1gq3ZBerAKPw9OjK183SOw9vXsHigrUbG3/sr8nwO/l4edV5eThxd4YWdIUVUqwFjUob
 kCSWtYQQ==;
Received: from mail-io1-xd33.google.com ([2607:f8b0:4864:20::d33])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbTRA-00GwYN-8g
 for linux-nvme@lists.infradead.org; Tue, 27 Apr 2021 19:32:01 +0000
Received: by mail-io1-xd33.google.com with SMTP id e186so7706733iof.7
 for <linux-nvme@lists.infradead.org>; Tue, 27 Apr 2021 12:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=Z2dfVSyAhAt8vgpBqMWbMDHuRDstq7cheYx2I0gCKqA=;
 b=f+N9LA0t4CUwDpMHIjT1MaiOY0YP0yEI1fdCq6n/9G2sApcPu0kfC7g65PrZSCas0q
 et2NNQvtx3ytlLSajvn/g9dwQLy9IwqF1tmAC4Z2Wbb5I+Ch5gtBC1EMrWz4jvcK7cRt
 BzVK1SMsB3tJk0fk7jkLyb2kxQrjE4ZWpPcEIZ7o4pMgr6mhJqYb+dQUMgERAwDuQnuT
 HZjT+3IRZb6PI3RPSgOlfb2kyWKwrBOn3yf7eoc9FCkyAhJ/Wgl0HqJKfJ1IUrN5ptMx
 F66dcUTstJRLGIfvFqeC68gHCYIb4UfUh4NvcMqsFPQso8Hhnq5J0oEUDdR/Ozo03mHZ
 ak0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Z2dfVSyAhAt8vgpBqMWbMDHuRDstq7cheYx2I0gCKqA=;
 b=PcXxTuQxO8d0PxUstjCL3xnkpNmVptfYGpid28v6/JJ7iTQ/NLDzMWPpPBUGeK6RY0
 syhbYL/t4uzM6Bx0WPb+C7TZQHoxcnIw36PhH+Nm++SkED9EgynOEcPmU1/LFP2jvkuo
 rcUTQQm5cPwgGhkxVPx5X+lX1WkSR5E4AoTJbvg81UB165y3gi1QSEd8KtHt0cGcZgLk
 N9zXtyP0cgUMByadNSiOlWh8u541j6ReeAu30SU6DNvRkrq1HrkHHvxfzI/xkujbESJ7
 cbXBziN2tUeY1mmGiLkOBJGKZUcGVIUJ0RubeJSdaQFYhlqBE01+/a2bmymbvAj3wGES
 vdvw==
X-Gm-Message-State: AOAM531RIe85G5UIK7DUuNYh6BCnanRs+wGQ/GrSlv40/0sKJZ/tP0pI
 /mpJP28sxbTwhELjVplVxrHzFQ==
X-Google-Smtp-Source: ABdhPJz1PrEuptJElb3400TY97NuVzdikMTMhxSGmMRmyGUliOenKdPiL7SsLe1HAEp58UA3cwiqXQ==
X-Received: by 2002:a5d:84c5:: with SMTP id z5mr20535269ior.33.1619551919040; 
 Tue, 27 Apr 2021 12:31:59 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
 by smtp.gmail.com with ESMTPSA id d8sm340022iow.25.2021.04.27.12.31.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Apr 2021 12:31:58 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1lbTR7-00Dgv4-Ig; Tue, 27 Apr 2021 16:31:57 -0300
Date: Tue, 27 Apr 2021 16:31:57 -0300
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
Subject: Re: [PATCH 05/16] dma-mapping: Introduce dma_map_sg_p2pdma()
Message-ID: <20210427193157.GQ2047089@ziepe.ca>
References: <20210408170123.8788-1-logang@deltatee.com>
 <20210408170123.8788-6-logang@deltatee.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210408170123.8788-6-logang@deltatee.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210427_123200_324898_FE29E748 
X-CRM114-Status: GOOD (  12.64  )
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

On Thu, Apr 08, 2021 at 11:01:12AM -0600, Logan Gunthorpe wrote:
> +/*
> + * dma_maps_sg_attrs returns 0 on error and > 0 on success.
> + * It should never return a value < 0.
> + */

Also it is weird a function that can't return 0 is returning an int type

> +int dma_map_sg_attrs(struct device *dev, struct scatterlist *sg, int nents,
> +		enum dma_data_direction dir, unsigned long attrs)
> +{
> +	int ents;
> +
> +	ents = __dma_map_sg_attrs(dev, sg, nents, dir, attrs);
>  	BUG_ON(ents < 0);

if (WARN_ON(ents < 0))
     return 0;

instead of bug on?

Also, I see only 8 users of this function. How about just fix them all
to support negative returns and use this as the p2p API instead of
adding new API?

Add the opposite logic flag, 'DMA_ATTRS_NO_ERROR' and pass it through
the other api entry callers that can't handle it?

Jason

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
