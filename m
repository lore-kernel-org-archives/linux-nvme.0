Return-Path: <SRS0=qJQi=GX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C33B3C433DB
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Jan 2021 15:24:03 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 742CB2336D
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Jan 2021 15:24:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 742CB2336D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=fJ+1WpzHgqukDmZi/NRgp6km4JF68i25FchMMvsTyE8=; b=Eio+zk0A9JxCbJuMLJoQf2PuE
	bS4a40Zj8OomczOX1vHqMy8Gklv9tmDE28yRbbTmpFFjWaDpsKn48rmZKFd8e/0Ob8qap3lucP14s
	tTR9XjSfWDsRZBqLOFHAL6oI7jFI34HWDqm/vIo73aI+vf+DNGejBv98Y19l9isQhaio3aVmgMALC
	H1ZGzFFT4pCyycD+GfDS8/lNcN60CpElH7jkjm0NYjCGVWY39bWfORfHChGsa2Lp93cnfxumNJDvR
	Bw4xQ6dS1rZ7mLdqvFn+BaaKOJvsT1g27yqFPhT4guGk7wDl7H+HBA97hB1LueWkeJhAD/WrNX4/q
	wR1NqCavw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l2FKr-0005MP-RE; Wed, 20 Jan 2021 15:23:53 +0000
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l2FKq-0005M1-3m
 for linux-nvme@lists.infradead.org; Wed, 20 Jan 2021 15:23:52 +0000
Received: by mail-wr1-x42c.google.com with SMTP id a1so2173019wrq.6
 for <linux-nvme@lists.infradead.org>; Wed, 20 Jan 2021 07:23:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=EyVyUw84UNnjHlxL9x6M4okmeqlFndl4L385NvS5Piw=;
 b=p/liRKz7PzEPWZZBCaMnkzajewgANbqYBpWoX2HUtZNgZfWwJWyLCg5GU2iCcXGigl
 aSBJQQbOZtLUoarMXogeUz844fpL8FmcWe/JeDcA59TBDMXMGxWDTODMb8L015DNSwVe
 A2ORoLi69X7SIGL1VKJZTu1J6F3273mRWyRTJsiOCJfbBLI1lWYnven2vhn4l0S8o//M
 WHqr/FBQ3MKLKbMFfeTlg6taQb7cr5OiO30W9YMOuSF3++QbZwnXhtIPYRBJFT35z6id
 cyijY40HGCce35Ysu9sLDZzG4F+hJdJt4LLnAyc1aWl+d9HFlaUkAcGPQ2qzYfkZyUoA
 vN8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=EyVyUw84UNnjHlxL9x6M4okmeqlFndl4L385NvS5Piw=;
 b=uaEySz9lzKF5nEmrD/oXV+nwUs036LhzSvn3fs4dmiRCyO86S/9tqZtA5vXc/bfr4L
 zJNstZ9uF827zDJjZiMCK433YeFtpGrRurnpYDv68rp2+UD7fjxzN76MqgNBc/xvhU3u
 +YTMJ8Vg5yB7LGoNDIlREurQILAOS6UaD8Zqzhow7Zz6EZncu2re2I7ZDAMA9N+OuUFH
 Nqe2+MBFmPuOa+4s0g0D64vfeLupo80ejB0w8JcJAVQl+b4RuH+bHZt19LCFwSliXc2R
 11DreWK2dukVAcsBQ3BjWqLCjAl4HOsrnJtxuvPWqaEB3d+xfi2/6En+YcW/Qw4F9xpx
 39zA==
X-Gm-Message-State: AOAM532GJDrVSFRk7S0T+33YZ509GK/tr0CCGGTU2CHo3wYC9JnOwldl
 wQeLdUEuEX4Xe3K8JdTr2uTs6V4Oaacu3LX3rtJEow6WnXE=
X-Google-Smtp-Source: ABdhPJzrrw4IdLp5ULlNlolhCSEQcWR4Zjk99sfA52lBV/gPQLH6rnbgrKueOe5vBTBsF4I97BGOy59607NejUeZUdg=
X-Received: by 2002:a05:6000:104d:: with SMTP id
 c13mr9698219wrx.127.1611156230450; 
 Wed, 20 Jan 2021 07:23:50 -0800 (PST)
MIME-Version: 1.0
References: <20210120094915.3198346-1-hch@lst.de>
 <20210120094915.3198346-3-hch@lst.de>
In-Reply-To: <20210120094915.3198346-3-hch@lst.de>
From: Marc Orr <marcorr@google.com>
Date: Wed, 20 Jan 2021 07:23:39 -0800
Message-ID: <CAA03e5Hb49rpNq2A8hmvo6tVrLnon0yAUiZvWvd8THCXyDQ-kg@mail.gmail.com>
Subject: Re: [PATCH 2/2] nvme-pci: fix error unwind in nvme_map_data
To: Christoph Hellwig <hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210120_102352_224904_8DB01523 
X-CRM114-Status: GOOD (  19.17  )
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
> Properly unwind step by step using refactored helpers from nvme_unmap_data
> to avoid a potential double dma_unmap on a mapping failure.
>
> Reported-by: Marc Orr <marcorr@google.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Should these patches go to stable?

> ---
>  drivers/nvme/host/pci.c | 28 ++++++++++++++++++----------
>  1 file changed, 18 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index e29ece9e4d4b8e..4e93d1b52df202 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -683,7 +683,7 @@ static blk_status_t nvme_pci_setup_prps(struct nvme_dev *dev,
>                         __le64 *old_prp_list = prp_list;
>                         prp_list = dma_pool_alloc(pool, GFP_ATOMIC, &prp_dma);
>                         if (!prp_list)
> -                               return BLK_STS_RESOURCE;
> +                               goto free_prps;
>                         list[iod->npages++] = prp_list;
>                         prp_list[0] = old_prp_list[i - 1];
>                         old_prp_list[i - 1] = cpu_to_le64(prp_dma);
> @@ -703,14 +703,14 @@ static blk_status_t nvme_pci_setup_prps(struct nvme_dev *dev,
>                 dma_addr = sg_dma_address(sg);
>                 dma_len = sg_dma_len(sg);
>         }
> -
>  done:
>         cmnd->dptr.prp1 = cpu_to_le64(sg_dma_address(iod->sg));
>         cmnd->dptr.prp2 = cpu_to_le64(iod->first_dma);
> -
>         return BLK_STS_OK;
> -
> - bad_sgl:
> +free_prps:
> +       nvme_free_prps(dev, req);
> +       return BLK_STS_RESOURCE;
> +bad_sgl:
>         WARN(DO_ONCE(nvme_print_sgl, iod->sg, iod->nents),
>                         "Invalid SGL for payload:%d nents:%d\n",
>                         blk_rq_payload_bytes(req), iod->nents);
> @@ -782,7 +782,7 @@ static blk_status_t nvme_pci_setup_sgls(struct nvme_dev *dev,
>
>                         sg_list = dma_pool_alloc(pool, GFP_ATOMIC, &sgl_dma);
>                         if (!sg_list)
> -                               return BLK_STS_RESOURCE;
> +                               goto free_sgls;
>
>                         i = 0;
>                         nvme_pci_iod_list(req)[iod->npages++] = sg_list;
> @@ -795,6 +795,9 @@ static blk_status_t nvme_pci_setup_sgls(struct nvme_dev *dev,
>         } while (--entries > 0);
>
>         return BLK_STS_OK;
> +free_sgls:
> +       nvme_free_sgls(dev, req);
> +       return BLK_STS_RESOURCE;
>  }
>
>  static blk_status_t nvme_setup_prp_simple(struct nvme_dev *dev,
> @@ -863,7 +866,7 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
>         sg_init_table(iod->sg, blk_rq_nr_phys_segments(req));
>         iod->nents = blk_rq_map_sg(req->q, req, iod->sg);
>         if (!iod->nents)
> -               goto out;
> +               goto out_free_sg;
>
>         if (is_pci_p2pdma_page(sg_page(iod->sg)))
>                 nr_mapped = pci_p2pdma_map_sg_attrs(dev->dev, iod->sg,
> @@ -872,16 +875,21 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
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

nit: Naming this label out_sg_unmap or out_unmap_sg might be a little
more clear, since the line below doesn't have the word dma anywhere.

> +       nvme_unmap_sg(dev, req);
> +out_free_sg:
> +       mempool_free(iod->sg, dev->iod_mempool);
>         return ret;
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
