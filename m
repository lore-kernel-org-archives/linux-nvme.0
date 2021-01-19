Return-Path: <SRS0=ulAu=GW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E95EC433DB
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Jan 2021 23:13:08 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1492022CAD
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Jan 2021 23:13:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1492022CAD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=5FguIGTF229tD8IKAY+8XrR4oyNN9B+IfNgakdHovS8=; b=IbUDHQB4MGoIcatRky0D1aDXW
	a+MPQCq/N3QfMJEWiTIP6kGVHc7PTBcGqCcdzdm+N8TbSDNWvJAUDJNj6g4OOEsQIhQcVF5dlvZ74
	pQ4xMkMTKS6ddk7UkTwtH94jJ0o2FR1foC2Mx6uNgNL/gjQ8xsyCmIY6YfdwvAm6Xl23xrZDvSXvh
	8mwJEYTj5F+x9oixip8ie8ivErwoJb5bHurBgCH4pki8h/uzCmekbrKlk2IWVer4di8xKi8TPxhBQ
	512eq5AC5igl8xB0RIEFJg2tngA4H2PTAqw34Sjb25zBvfFc6e5cjU95BRz0HyxNxKVVfyv8L/RqR
	0pBzXSo4w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l20B1-00042M-B3; Tue, 19 Jan 2021 23:12:43 +0000
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l20Ay-00041K-Sl
 for linux-nvme@lists.infradead.org; Tue, 19 Jan 2021 23:12:41 +0000
Received: by mail-wm1-x335.google.com with SMTP id e15so1231800wme.0
 for <linux-nvme@lists.infradead.org>; Tue, 19 Jan 2021 15:12:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=kJdfqz839OeseYYkmWz4yh6z5zvAjLz0yxVJ3bu4P2g=;
 b=smpsCbyHn0NnsknFBhgrLWNcTjBC2cOujZNIGIWjZUwrWZr3wtfLtSfdNEpdyXlrFc
 bTnGqluXpZ5/C8tyKdBVD8q8yX29bHUL0CJAiinunPPHQIT/VDNVd1npwF1v0r5N6rcn
 fdS2dswwTfgbBiZbKXJc4TKbqE+RxWFUXpITUA8fARK/B1Nms2Ct0O88BnZtQ6Z6rz0J
 G/xWFWFvwy4ovmUHlmdAy0LkdYk5hcBUEW+NCq4RtP2I72tbXzc10XJsoV9zzh9Db5QH
 OAQsUCrcgydDrGNAGLr35SVdRUcfL+AuY3/SxCyx5KaWst19r6ci+s73/8AtGMcZjU0e
 5O3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=kJdfqz839OeseYYkmWz4yh6z5zvAjLz0yxVJ3bu4P2g=;
 b=nLpUaoLfOFXS6WUdxh5+ckNrZt6aNnpi3XVFCC8YiQ56vsTTs09SdfdbYKJ7fCjiOK
 aRAyyIDPLbdvNLKPtP+m5THwqcWh6f9M4es5noNh/aWmr7LEdiLgCwOgfH8ZxHwJL58r
 UcVLvT+tjLVLh5qasytB2j5gUIUk1hskRLA7BGhUNL+x/Vmmj3nPlU2BiOHEkyuAxwqa
 SY5naZf83hYNtmbYZh4zDPHYyckeZFUGcc6yx4YrnauBdojPmaoWp9DucFaNhAOWoupN
 40PUbOgqlSL08OOndKqTpca1dbbPUTnY8ADYMSa6ZtfA5XBXuoSKSLIHsvdWw1MANwJ5
 ak/w==
X-Gm-Message-State: AOAM532eXaYsqp2u+C8sBc9Agkl8bzL2PYWbWnmfUTQJCCPaGa7jtNHT
 5TKjcUzMfjSia3WZd1jjSH5lFW/cYDAy1CWohpLA7w==
X-Google-Smtp-Source: ABdhPJxTe6K+eqd0wxGdLv0AWWP9UYN9ZNOZKj8crhBvfDwZyzy2FzLxMxXw8Y7IY7riTOkOJecfM8Rcy1ApAJBqhCE=
X-Received: by 2002:a05:600c:2110:: with SMTP id
 u16mr1621013wml.65.1611097956708; 
 Tue, 19 Jan 2021 15:12:36 -0800 (PST)
MIME-Version: 1.0
References: <20210119175336.4016923-1-marcorr@google.com>
 <20210119180024.GA28024@lst.de>
In-Reply-To: <20210119180024.GA28024@lst.de>
From: Marc Orr <marcorr@google.com>
Date: Tue, 19 Jan 2021 15:12:25 -0800
Message-ID: <CAA03e5GeGRLcLzp8d6pOC7UnQq9mZYzgW9rQgV3XHMb5gfsLWQ@mail.gmail.com>
Subject: Re: [PATCH] nvme: fix handling mapping failure
To: Christoph Hellwig <hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210119_181240_955316_12B7317F 
X-CRM114-Status: GOOD (  26.52  )
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
Cc: sagi@grimberg.me, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, axboe@fb.com, stable@vger.kernel.org,
 kbusch@kernel.org, Jianxiong Gao <jxgao@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Jan 19, 2021 at 10:00 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Tue, Jan 19, 2021 at 09:53:36AM -0800, Marc Orr wrote:
> > This patch ensures that when `nvme_map_data()` fails to map the
> > addresses in a scatter/gather list:
> >
> > * The addresses are not incorrectly unmapped. The underlying
> > scatter/gather code unmaps the addresses after detecting a failure.
> > Thus, unmapping them again in the driver is a bug.
> > * The DMA pool allocations are not deallocated when they were never
> > allocated.
> >
> > The bug that motivated this patch was the following sequence, which
> > occurred within the NVMe driver, with the kernel flag `swiotlb=force`.
> >
> > * NVMe driver calls dma_direct_map_sg()
> > * dma_direct_map_sg() fails part way through the scatter gather/list
> > * dma_direct_map_sg() calls dma_direct_unmap_sg() to unmap any entries
> >   succeeded.
> > * NVMe driver calls dma_direct_unmap_sg(), redundantly, leading to a
> >   double unmap, which is a bug.
> >
> > Before this patch, I observed intermittent application- and VM-level
> > failures when running a benchmark, fio, in an AMD SEV guest. This patch
> > resolves the failures.
>
> I think the right way to fix this is to just do a proper unwind insted
> of calling a catchall function.  Can you try this patch?

Done. It works great, thanks! Shall I send out a v2 with what you've proposed?

> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 25456d02eddb8c..47d7075053b6b2 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -842,7 +842,7 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
>         sg_init_table(iod->sg, blk_rq_nr_phys_segments(req));
>         iod->nents = blk_rq_map_sg(req->q, req, iod->sg);
>         if (!iod->nents)
> -               goto out;
> +               goto out_free_sg;
>
>         if (is_pci_p2pdma_page(sg_page(iod->sg)))
>                 nr_mapped = pci_p2pdma_map_sg_attrs(dev->dev, iod->sg,
> @@ -851,16 +851,25 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
>                 nr_mapped = dma_map_sg_attrs(dev->dev, iod->sg, iod->nents,
>                                              rq_dma_dir(req), DMA_ATTR_NO_WARN);
>         if (!nr_mapped)
> -               goto out;
> +               goto out_free_sg;
>
>         iod->use_sgl = nvme_pci_use_sgls(dev, req);
>         if (iod->use_sgl)
>                 ret = nvme_pci_setup_sgls(dev, req, &cmnd->rw, nr_mapped);
>         else
>                 ret = nvme_pci_setup_prps(dev, req, &cmnd->rw);
> -out:
>         if (ret != BLK_STS_OK)
> -               nvme_unmap_data(dev, req);
> +               goto out_dma_unmap;
> +       return BLK_STS_OK;
> +
> +out_dma_unmap:
> +       if (is_pci_p2pdma_page(sg_page(iod->sg)))
> +               pci_p2pdma_unmap_sg(dev->dev, iod->sg, iod->nents,
> +                                   rq_dma_dir(req));
> +       else
> +               dma_unmap_sg(dev->dev, iod->sg, iod->nents, rq_dma_dir(req));

Do you think it's worth hoisting this sg unmap snippet into a helper
that can be called from both here, as well as nvme_unmap_data()?

> +out_free_sg:
> +       mempool_free(iod->sg, dev->iod_mempool);
>         return ret;
>  }
>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
