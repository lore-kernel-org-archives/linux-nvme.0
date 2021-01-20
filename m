Return-Path: <SRS0=qJQi=GX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 222EDC433DB
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Jan 2021 15:20:11 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97C7D2339D
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Jan 2021 15:20:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97C7D2339D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=fpobA7/jxtbX6lBT80ojVqFemUBFwFpP9MdVYfwxn34=; b=dhFwSxsHGV0oLXSMbvbE73QzD
	x8TsObDB4CKKIr/xLQnKAG5G/+w7jillJjNpHE01FDIzJjjZ6qcc2b4R/EJCbFnLYHMu+RG+HMqqj
	iYO98CVJkD3X0hxekbcKzqG4Ih+sgSp7NuUB9IgXQ2WXXfSZYC0RA1d8rZrHZnFT9PcNSUX+G4FKQ
	Gx/kwWoUca+X2No+qnxLBbxDZ7ryvng+mIefVR4JdnNR1Qoh5kzqU2+aEjo/AgcLy5DSU9nZaKfvX
	6fhJPaUmrajO8AuQAEi82FXs2baZdiYwkRUmQ8OTc+TV6t0XfRbY61+Eo+0uHpItvAyOln/nCIwD9
	V3XEz5Urw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l2FGx-00059O-Kb; Wed, 20 Jan 2021 15:19:51 +0000
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l2FGu-000593-ET
 for linux-nvme@lists.infradead.org; Wed, 20 Jan 2021 15:19:49 +0000
Received: by mail-wr1-x434.google.com with SMTP id a12so23437534wrv.8
 for <linux-nvme@lists.infradead.org>; Wed, 20 Jan 2021 07:19:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=02lpwE8mJbgIWd4VaYLHxMcemFjPSmV7V0E7yEZKL+U=;
 b=nNH9+dZ7FHTvqdwkIj4ODTMQK8n6/MDlmnPEvcYzTlPlHtNgXedne9SvlZHDfnrsG+
 nGC63kgDMPijo4fajFpvCn6e/+8zzr0NNmzBqHJ+6XZ4ELxr711mpbYeT9dm5fGH0bHp
 zwb2tLRqJjrNRjTm24A+KvLeTCF21STprZqMJvLzJGJuiRQ6M1tHtfuzsbofnRMDkI5e
 z5gxVfKzNxgvmAVChw6ZhIWTL5H1GpXiUhAqVaKzomAZl0Y1dkjoQdpN3Htruy5Qkjuf
 wO0yO9ZflXdh/ppQ4U75JmzZOzcXb690rCBazC5AfRZSj+5gWCrF9CfoLks8+romulUV
 ro1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=02lpwE8mJbgIWd4VaYLHxMcemFjPSmV7V0E7yEZKL+U=;
 b=ZFXulVHqsxbu9VmHCX+rSqddtohAR+25O9OAhCsGsbgCLncUn1xEgcdPNn2IiYf1lQ
 lrD9/C2H3JXYjwoFN5cA8Rob19FFkx9HRdDD39NnixcRKtW5TT5P3ynsh+rBVpxOVSJu
 tws+fyL1Fqk5NAPm0eowkgRMKkZgoFoXCU+XJBB32yWk/XeWq4V3kh5jsEXdWcdyQw2S
 aaPFua45BEw1ebP0spNdX4akbegEH/Q+sDKicOeOo+9WbLdSSmDKy5mkbn72qCoywYqe
 iqdH6WIf+GQkf7mxWnSGTT0jm2CTlGV1Wb4IMpxdEj5UWioFBV5Cbv79xbQpAuJu69/V
 YgWQ==
X-Gm-Message-State: AOAM5315gHW7tsgpzf93x84yQQABYj1nA118hGHN6ZxH0x/QgUh/9mxq
 ZBSBzZgdhgp9YcF6hR8FMmVERCCrMlmH50mR0aQL93hRe24=
X-Google-Smtp-Source: ABdhPJztZT3jmTVBaju65l04ZEdw+NEZkAKTvXOOXZTUh0w7ckYilV9Dd9djW/Kd8kRvexGZgBW1QvkBVzz2mDHMZG4=
X-Received: by 2002:adf:ee4d:: with SMTP id w13mr9850264wro.216.1611155986490; 
 Wed, 20 Jan 2021 07:19:46 -0800 (PST)
MIME-Version: 1.0
References: <20210120094915.3198346-1-hch@lst.de>
 <20210120094915.3198346-2-hch@lst.de>
In-Reply-To: <20210120094915.3198346-2-hch@lst.de>
From: Marc Orr <marcorr@google.com>
Date: Wed, 20 Jan 2021 07:19:34 -0800
Message-ID: <CAA03e5FYn0Z2gQhOBVRCyffeNs8iQ=2ZUVgZbig5b6xe60iE4g@mail.gmail.com>
Subject: Re: [PATCH 1/2] nvme-pci: refactor nvme_unmap_data
To: Christoph Hellwig <hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210120_101948_848754_057BE609 
X-CRM114-Status: GOOD (  21.66  )
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
Cc: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Jan 20, 2021 at 1:49 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Split out three helpers from nvme_unmap_data that will allow finer grained
> unwinding from nvme_map_data.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/nvme/host/pci.c | 77 ++++++++++++++++++++++++++---------------
>  1 file changed, 49 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 25456d02eddb8c..e29ece9e4d4b8e 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -543,50 +543,71 @@ static inline bool nvme_pci_use_sgls(struct nvme_dev *dev, struct request *req)
>         return true;
>  }
>
> -static void nvme_unmap_data(struct nvme_dev *dev, struct request *req)
> +static void nvme_free_prps(struct nvme_dev *dev, struct request *req)
>  {
> -       struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
>         const int last_prp = NVME_CTRL_PAGE_SIZE / sizeof(__le64) - 1;
> -       dma_addr_t dma_addr = iod->first_dma, next_dma_addr;
> +       struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
> +       dma_addr_t dma_addr = iod->first_dma;
>         int i;
>
> -       if (iod->dma_len) {
> -               dma_unmap_page(dev->dev, dma_addr, iod->dma_len,
> -                              rq_dma_dir(req));
> -               return;
> +       for (i = 0; i < iod->npages; i++) {
> +               __le64 *prp_list = nvme_pci_iod_list(req)[i];
> +               dma_addr_t next_dma_addr = le64_to_cpu(prp_list[last_prp]);
> +
> +               dma_pool_free(dev->prp_page_pool, prp_list, dma_addr);
> +               dma_addr = next_dma_addr;
>         }
>
> -       WARN_ON_ONCE(!iod->nents);
> +}
>
> -       if (is_pci_p2pdma_page(sg_page(iod->sg)))
> -               pci_p2pdma_unmap_sg(dev->dev, iod->sg, iod->nents,
> -                                   rq_dma_dir(req));
> -       else
> -               dma_unmap_sg(dev->dev, iod->sg, iod->nents, rq_dma_dir(req));
> +static void nvme_free_sgls(struct nvme_dev *dev, struct request *req)
> +{
> +       const int last_sg = SGES_PER_PAGE - 1;
> +       struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
> +       dma_addr_t dma_addr = iod->first_dma;
> +       int i;
>
> +       for (i = 0; i < iod->npages; i++) {
> +               struct nvme_sgl_desc *sg_list = nvme_pci_iod_list(req)[i];
> +               dma_addr_t next_dma_addr = le64_to_cpu((sg_list[last_sg]).addr);
>
> -       if (iod->npages == 0)
> -               dma_pool_free(dev->prp_small_pool, nvme_pci_iod_list(req)[0],
> -                       dma_addr);
> +               dma_pool_free(dev->prp_page_pool, sg_list, dma_addr);
> +               dma_addr = next_dma_addr;
> +       }
>
> -       for (i = 0; i < iod->npages; i++) {
> -               void *addr = nvme_pci_iod_list(req)[i];
> +}
>
> -               if (iod->use_sgl) {
> -                       struct nvme_sgl_desc *sg_list = addr;
> +static void nvme_unmap_sg(struct nvme_dev *dev, struct request *req)
> +{
> +       struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
>
> -                       next_dma_addr =
> -                           le64_to_cpu((sg_list[SGES_PER_PAGE - 1]).addr);
> -               } else {
> -                       __le64 *prp_list = addr;
> +       if (is_pci_p2pdma_page(sg_page(iod->sg)))
> +               pci_p2pdma_unmap_sg(dev->dev, iod->sg, iod->nents,
> +                                   rq_dma_dir(req));
> +       else
> +               dma_unmap_sg(dev->dev, iod->sg, iod->nents, rq_dma_dir(req));
> +}
>
> -                       next_dma_addr = le64_to_cpu(prp_list[last_prp]);
> -               }
> +static void nvme_unmap_data(struct nvme_dev *dev, struct request *req)
> +{
> +       struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
>
> -               dma_pool_free(dev->prp_page_pool, addr, dma_addr);
> -               dma_addr = next_dma_addr;
> +       if (iod->dma_len) {
> +               dma_unmap_page(dev->dev, iod->first_dma, iod->dma_len,
> +                              rq_dma_dir(req));
> +               return;
>         }
>
> +       WARN_ON_ONCE(!iod->nents);
> +
> +       nvme_unmap_sg(dev, req);
> +       if (iod->npages == 0)
> +               dma_pool_free(dev->prp_small_pool, nvme_pci_iod_list(req)[0],
> +                             iod->first_dma);
> +       else if (iod->use_sgl)
> +               nvme_free_sgls(dev, req);
> +       else
> +               nvme_free_prps(dev, req);
>         mempool_free(iod->sg, dev->iod_mempool);
>  }

Reviewed-by: Marc Orr <marcorr@google.com>

>
> --
> 2.29.2
>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
