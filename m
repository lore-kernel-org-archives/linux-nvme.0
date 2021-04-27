Return-Path: <SRS0=pISK=JY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59CCAC433ED
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Apr 2021 19:48:19 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0D38613F6
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Apr 2021 19:48:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0D38613F6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=LMka8ZQ7E1x8LYAFfLKQumzXQCHvAzGl1kmGla9tG4k=; b=JMGyrAuWTEp0wNzWj3WbaTkCb
	YvfPFovxi4YpNzgSmmmClk8wD5pufInfC0PiSAdXSUO3cpAGXEeDaNRfJX+azrBaYEqgKGHOxmgGS
	B0xBX/qt9XN2SUHFhH1s7fv3dUnY8M/aXJg9PV4L+IVcjQrmeVpwI89YMSk1ZPXxKeX2VHSDujEks
	EfVRDgkO1P24hwZAdphcccjB0p6cXJduFDpl6GNKiz0QI4LEh94Ir1ICVQyMDSZBYBJUkq7Privmf
	Zqp1wPnVCvHTTrUH19R4Wm+SObQ7eMjJXd0RuvF4pxPZB/us6RJkmktNbXJphertEro/e+xQHzPOl
	MQ4TTx+6w==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lbTgj-0028vI-Dw; Tue, 27 Apr 2021 19:48:05 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbTgg-0028vA-32
 for linux-nvme@desiato.infradead.org; Tue, 27 Apr 2021 19:48:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=AjrAoCiFehNYhoJcuGAEBZrhhpGrqdOWIeMvT8fZfQE=; b=VcS+qQ4ThjQKwl3FQXHpBeM4pe
 qCtN9PTz4Kcsl0WVl5QoPocJhzud/Qd11UfL0ykB39VDOZndt/s72pxLcLQ6qb3m3W2iU9+my7BtM
 WgZM2hymWOt6sQP3OWeuLlCN395DO8KWxeaXfJ1d5lPwbesk+SZYGzcV0JXE4U+Hd3XYZArBbx34W
 voMet41AZ+Ghv4420pGlROzT0Bebti24F7VYyZNxIdG3pl83Xqcd9JgeJp3mZYCdVT4y/iigR4IPa
 lov/df9dILsOocF3YMwONoNQUMSsDPmpsGBsQwdb0ERyfldQ3BE8fBphfQ1l8TpW/+gq46MXZ3yFN
 azjFhx/A==;
Received: from mail-qk1-x736.google.com ([2607:f8b0:4864:20::736])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbTgc-00GxCv-0h
 for linux-nvme@lists.infradead.org; Tue, 27 Apr 2021 19:48:00 +0000
Received: by mail-qk1-x736.google.com with SMTP id u20so29075619qku.10
 for <linux-nvme@lists.infradead.org>; Tue, 27 Apr 2021 12:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=AjrAoCiFehNYhoJcuGAEBZrhhpGrqdOWIeMvT8fZfQE=;
 b=graEdUl6h9bRI6879DOV+jpvit1zfjy1sguqq286DV1F/2+gigtoCBWC3FM8vofgQl
 frU5tmA5Yo5liP+gMHQyrmUq7cN1npCBY2bA3DqaAxH06CuLnP0NWeNuc8kjlvuN1iJn
 RdKbTcJWt7HM17bR6iMbdLR+Jh0BXdc3dZvBEz4QmXJ6kQmenIxZg2f5iyAHzEGw5iRb
 rqTOz8C5voOg+HeAyWzUJQcZ/iGz5ZMG+AB4pgyf8vAxm5rXA349KgOhQxhfMCafKqsg
 8i7gUoB/5zWgVNo8NelgGibkEKBeWRzNqnyj5N71rIYwMTksaYGDH0BittbK3OmOjGkd
 CYWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=AjrAoCiFehNYhoJcuGAEBZrhhpGrqdOWIeMvT8fZfQE=;
 b=Z8OdnvQPgckHBN++GCyTnnoIDgpGSw8zxZWuQQCjSr9kAEL+zN9CNOY5g0YXfvQiki
 d+VuAICXA/ufwVqi+Fuphp9Yxd2foKXC1Q5u/NK6AtyHrnr2d2YmL3Jd0y1rp3VTxZnw
 y9H1+1VL6wbIyJF6JteAx0CnsLJQ+T0MhLBUq7bQQnySJXY94DbCwpkzVgagDhU1zhII
 hk+h6vX2NRl8qQVf50zOitb1R6G1K/yRJuYH+7k3/cwowvv3tlTehmf7f3bht7ImVdVB
 gwRhLFCLRY1ulcBwO0YYlXF4PJRTyR3tSZRw7/6ay2ZCd+HEgLZzeQw5XT2FhMZkpGYS
 dKWA==
X-Gm-Message-State: AOAM533j8bY8Ju7D2uCLi4l/n+M0za3ptsK654xiZsMJZdfxozB9rzqh
 tWQxScB74u6ZdLQbMesaSe5Hng==
X-Google-Smtp-Source: ABdhPJw/yRbsqLsGFNvUPkPPJ1aCygnt+iyVESC5mkhFcaOFoCh8V5g49hIvCNxFvRyeXQBLFWfZKw==
X-Received: by 2002:a37:41ce:: with SMTP id
 o197mr25280932qka.122.1619552875839; 
 Tue, 27 Apr 2021 12:47:55 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
 by smtp.gmail.com with ESMTPSA id d19sm625708qtd.29.2021.04.27.12.47.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Apr 2021 12:47:55 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1lbTgX-00DhBD-OP; Tue, 27 Apr 2021 16:47:53 -0300
Date: Tue, 27 Apr 2021 16:47:53 -0300
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
Subject: Re: [PATCH 14/16] nvme-rdma: Ensure dma support when using p2pdma
Message-ID: <20210427194753.GU2047089@ziepe.ca>
References: <20210408170123.8788-1-logang@deltatee.com>
 <20210408170123.8788-15-logang@deltatee.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210408170123.8788-15-logang@deltatee.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210427_124758_083678_B6D5310F 
X-CRM114-Status: GOOD (  16.72  )
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

On Thu, Apr 08, 2021 at 11:01:21AM -0600, Logan Gunthorpe wrote:
> Ensure the dma operations support p2pdma before using the RDMA
> device for P2PDMA. This allows switching the RDMA driver from
> pci_p2pdma_map_sg() to dma_map_sg_p2pdma().
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>  drivers/nvme/target/rdma.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
> index 6c1f3ab7649c..3ec7e77e5416 100644
> +++ b/drivers/nvme/target/rdma.c
> @@ -414,7 +414,8 @@ static int nvmet_rdma_alloc_rsp(struct nvmet_rdma_device *ndev,
>  	if (ib_dma_mapping_error(ndev->device, r->send_sge.addr))
>  		goto out_free_rsp;
>  
> -	if (!ib_uses_virt_dma(ndev->device))
> +	if (!ib_uses_virt_dma(ndev->device) &&
> +	    dma_pci_p2pdma_supported(&ndev->device->dev))

ib_uses_virt_dma() should not be called by nvme and this is using the
wrong device pointer to query for DMA related properties.

I suspect this wants a ib_dma_pci_p2p_dma_supported() wrapper like
everything else.

Jason

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
