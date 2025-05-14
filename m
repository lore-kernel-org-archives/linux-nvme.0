Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6A3FC3ABC9
	for <linux-nvme@archiver.kernel.org>; Wed, 14 May 2025 01:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uRnn7fJfLbnwvgCLf/AmF1mELUga1CNPI5N00rjcBkE=; b=pdLeNJfwjSLKuwVyRPJazczLct
	IJ58KHznTUyYeI9EoAGUJCcEDHFtuVBDc2QTWObs5w45ubCbWtkeHAPOo43uVK9DmLdaAjZviNX4F
	w8hzlujzxVYdkn7krTU5UaDWK2iFimZQ/RvE3bx0ax3FKJ1kDAQ7lUV3/AYHaDJChQQUUPQijwmPh
	+OZ2RJ1jKiF19RfhmqIWExxqIeC62eTHMdUnkzf2D0rhvq6YXzKG/2o1x3AzRRbgHFloHzYzZ880k
	hj6ll02YcrHgUNOV4N8BPbxgOFoDVKZlkLIEIwuSZ6KOwWujtJ9D9I1JF1M4yXzOL7eE8HgG8dv6F
	yxwJeajg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uF0XV-0000000Dp5X-3gC3;
	Wed, 14 May 2025 01:04:05 +0000
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uF0XR-0000000Dp59-2Yn3
	for linux-nvme@lists.infradead.org;
	Wed, 14 May 2025 01:04:05 +0000
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-af5f28ecbcaso435845a12.0
        for <linux-nvme@lists.infradead.org>; Tue, 13 May 2025 18:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1747184640; x=1747789440; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uRnn7fJfLbnwvgCLf/AmF1mELUga1CNPI5N00rjcBkE=;
        b=LIArRe0HBq8Kq8kNb9DLfY72RrHROjTLIof2hncviB2wnRNTymikf/mJDsEbcWuD1j
         lEqWooSezF3S2U7aQCqty2ImS1+QWTwU/UMPnQqMgVD4K9reIxoJ8FGUSeByARHO/XCy
         s/dVBRy8X6AIlH3jjwLJDMqH7Mx1xFhGDkZLHFWLiG9DGxvPr0mmSybxHdcZTyKPeWGW
         IiRbZFYI5jZHn8X47S+Sk0CPjU3FaQLgxKLHJR+sPN8W1g8XyAKfEe1t38pFp3LKTYkX
         INsI5+Zii724nEYpxW6p66tiJpJ40UloJyNEgloJJAFoAl7sSOkvtrROJMvr5JM5RzhZ
         ppCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747184640; x=1747789440;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uRnn7fJfLbnwvgCLf/AmF1mELUga1CNPI5N00rjcBkE=;
        b=GK345A2dSsivZVbE4Ocp6ULgS9a05KABcyEpTupkgiSp9Ufeozru2fP7l3iyoB4VTY
         0LUEW7vkuDdSSgAjJimzRuBHUn7WXbX5HEJsvCYenX84XtDmCp14eE32xMrxug9bN9Yc
         otkHmfQS1zswGx6q36uv4QAyePgo+a3oPA4UjubQgfwk1o70+pueNCk2eIUE/ZFxhF9j
         HWB4M0eDDcIhl27yjM6THrDZRrpVjrJPdh7vqnLFMgw5EPUToe2owx2po3JhnNwpN434
         me4sGc7wCxZakCvilfBgGHXgmvoBoer7HEBxJ2lhKUgdCMA5KucXs/2JRNqp8yKK69Dx
         MS7g==
X-Forwarded-Encrypted: i=1; AJvYcCWvjUKRVCnT54dX1zLofcYhIDJ7LrYJJ4y2z+qaQWOGykFLhBWtauuV0h1H+RMCCAGDQdN2zLBEG+xI@lists.infradead.org
X-Gm-Message-State: AOJu0YwRiYKF26WKu9Cs7iFmIZSl1iDlwASYS+fhiiYy8Y5eyvS5cVu+
	uX7vqvpIlupWjWTSsvKkPHX+GHnB5N3eHpjVJhVeRCxZeLgZKUBaPrkIx9o2Bozd2eAEAkhSq29
	1XndFxVo7JS82WeJs0Fxr/z37dkLqeHqSu2/Gbg==
X-Gm-Gg: ASbGncthsXd+mXxBWQS4pMjlfafJJKhWbpuOpOb2l7TkBo7lICS1mm+7XUXCOiVFT9T
	Ms1ONl/aq5HCAV7ok/ir7QlgUMp+j6aGa3Yp1TO3q1XtPqFHiKiG65W/ywRcjwUAUwZ302Fc7WP
	346gFcfRjhzZoPKAq/IdG60DHBLY3e9dg=
X-Google-Smtp-Source: AGHT+IFtMinNxx8p241J4Vvf8zBuw7NvJKTSTROShzb3IWjjFyYjIKwNQoaPaPpVvQ4WT5iHR/pHndm/V8e3n3hoUik=
X-Received: by 2002:a17:902:ef01:b0:223:5525:622f with SMTP id
 d9443c01a7336-231980bf672mr8202935ad.1.1747184640576; Tue, 13 May 2025
 18:04:00 -0700 (PDT)
MIME-Version: 1.0
References: <20250513070025.830930-1-hch@lst.de> <20250513070025.830930-5-hch@lst.de>
In-Reply-To: <20250513070025.830930-5-hch@lst.de>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Tue, 13 May 2025 18:03:48 -0700
X-Gm-Features: AX0GCFv1qFH83VNBE70EliA8IYZxYvSvSMKv9izljKRWs8T-o0zEP1F_feNeIBs
Message-ID: <CADUfDZqybpMVpcCX_ohgxYs8dLt_zPW9UNWztvmRq=W8RcVY-g@mail.gmail.com>
Subject: Re: [PATCH 4/7] nvme-pci: rename the descriptor pools
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, 
	Leon Romanovsky <leon@kernel.org>, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250513_180401_652399_A5FB798F 
X-CRM114-Status: GOOD (  26.17  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, May 13, 2025 at 12:00=E2=80=AFAM Christoph Hellwig <hch@lst.de> wro=
te:
>
> They are used for both PRPs and SGLs, and we use descriptor elsewhere
> when referring to their allocations, so use that name here as well.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>

> ---
>  drivers/nvme/host/pci.c | 84 ++++++++++++++++++++---------------------
>  1 file changed, 42 insertions(+), 42 deletions(-)
>
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index fe859c31e765..773a2e625657 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -113,7 +113,7 @@ static void nvme_dev_disable(struct nvme_dev *dev, bo=
ol shutdown);
>  static void nvme_delete_io_queues(struct nvme_dev *dev);
>  static void nvme_update_attrs(struct nvme_dev *dev);
>
> -struct nvme_prp_dma_pools {
> +struct nvme_descriptor_pools {
>         struct dma_pool *large;
>         struct dma_pool *small;
>  };
> @@ -166,7 +166,7 @@ struct nvme_dev {
>         unsigned int nr_allocated_queues;
>         unsigned int nr_write_queues;
>         unsigned int nr_poll_queues;
> -       struct nvme_prp_dma_pools prp_pools[];
> +       struct nvme_descriptor_pools descriptor_pools[];
>  };
>
>  static int io_queue_depth_set(const char *val, const struct kernel_param=
 *kp)
> @@ -196,7 +196,7 @@ static inline struct nvme_dev *to_nvme_dev(struct nvm=
e_ctrl *ctrl)
>   */
>  struct nvme_queue {
>         struct nvme_dev *dev;
> -       struct nvme_prp_dma_pools prp_pools;
> +       struct nvme_descriptor_pools descriptor_pools;
>         spinlock_t sq_lock;
>         void *sq_cmds;
>          /* only used for poll queues: */
> @@ -400,46 +400,44 @@ static int nvme_pci_npages_prp(void)
>         return DIV_ROUND_UP(8 * nprps, NVME_CTRL_PAGE_SIZE - 8);
>  }
>
> -static struct nvme_prp_dma_pools *
> -nvme_setup_prp_pools(struct nvme_dev *dev, unsigned numa_node)
> +static struct nvme_descriptor_pools *
> +nvme_setup_descriptor_pools(struct nvme_dev *dev, unsigned numa_node)
>  {
> -       struct nvme_prp_dma_pools *prp_pools =3D &dev->prp_pools[numa_nod=
e];
> +       struct nvme_descriptor_pools *pools =3D &dev->descriptor_pools[nu=
ma_node];
>         size_t small_align =3D 256;
>
> -       if (prp_pools->small)
> -               return prp_pools; /* already initialized */
> +       if (pools->small)
> +               return pools; /* already initialized */
>
> -       prp_pools->large =3D dma_pool_create_node("prp list page", dev->d=
ev,
> -                                               NVME_CTRL_PAGE_SIZE,
> -                                               NVME_CTRL_PAGE_SIZE, 0,
> -                                               numa_node);
> -       if (!prp_pools->large)
> +       pools->large =3D dma_pool_create_node("nvme descriptor page", dev=
->dev,
> +                       NVME_CTRL_PAGE_SIZE, NVME_CTRL_PAGE_SIZE, 0, numa=
_node);
> +       if (!pools->large)
>                 return ERR_PTR(-ENOMEM);
>
>         if (dev->ctrl.quirks & NVME_QUIRK_DMAPOOL_ALIGN_512)
>                 small_align =3D 512;
>
>         /* Optimisation for I/Os between 4k and 128k */
> -       prp_pools->small =3D dma_pool_create_node("prp list 256", dev->de=
v,
> -                                               256, small_align, 0, numa=
_node);
> -       if (!prp_pools->small) {
> -               dma_pool_destroy(prp_pools->large);
> -               prp_pools->large =3D NULL;
> +       pools->small =3D dma_pool_create_node("nvme descriptor 256", dev-=
>dev,
> +                       256, small_align, 0, numa_node);
> +       if (!pools->small) {
> +               dma_pool_destroy(pools->large);
> +               pools->large =3D NULL;
>                 return ERR_PTR(-ENOMEM);
>         }
>
> -       return prp_pools;
> +       return pools;
>  }
>
> -static void nvme_release_prp_pools(struct nvme_dev *dev)
> +static void nvme_release_descriptor_pools(struct nvme_dev *dev)
>  {
>         unsigned i;
>
>         for (i =3D 0; i < nr_node_ids; i++) {
> -               struct nvme_prp_dma_pools *prp_pools =3D &dev->prp_pools[=
i];
> +               struct nvme_descriptor_pools *pools =3D &dev->descriptor_=
pools[i];
>
> -               dma_pool_destroy(prp_pools->large);
> -               dma_pool_destroy(prp_pools->small);
> +               dma_pool_destroy(pools->large);
> +               dma_pool_destroy(pools->small);
>         }
>  }
>
> @@ -448,16 +446,16 @@ static int nvme_init_hctx_common(struct blk_mq_hw_c=
tx *hctx, void *data,
>  {
>         struct nvme_dev *dev =3D to_nvme_dev(data);
>         struct nvme_queue *nvmeq =3D &dev->queues[qid];
> -       struct nvme_prp_dma_pools *prp_pools;
> +       struct nvme_descriptor_pools *pools;
>         struct blk_mq_tags *tags;
>
>         tags =3D qid ? dev->tagset.tags[qid - 1] : dev->admin_tagset.tags=
[0];
>         WARN_ON(tags !=3D hctx->tags);
> -       prp_pools =3D nvme_setup_prp_pools(dev, hctx->numa_node);
> -       if (IS_ERR(prp_pools))
> -               return PTR_ERR(prp_pools);
> +       pools =3D nvme_setup_descriptor_pools(dev, hctx->numa_node);
> +       if (IS_ERR(pools))
> +               return PTR_ERR(pools);
>
> -       nvmeq->prp_pools =3D *prp_pools;
> +       nvmeq->descriptor_pools =3D *pools;
>         hctx->driver_data =3D nvmeq;
>         return 0;
>  }
> @@ -602,7 +600,8 @@ static void nvme_free_prps(struct nvme_queue *nvmeq, =
struct request *req)
>                 __le64 *prp_list =3D iod->descriptors[i];
>                 dma_addr_t next_dma_addr =3D le64_to_cpu(prp_list[last_pr=
p]);
>
> -               dma_pool_free(nvmeq->prp_pools.large, prp_list, dma_addr)=
;
> +               dma_pool_free(nvmeq->descriptor_pools.large, prp_list,
> +                               dma_addr);
>                 dma_addr =3D next_dma_addr;
>         }
>  }
> @@ -623,11 +622,11 @@ static void nvme_unmap_data(struct nvme_dev *dev, s=
truct nvme_queue *nvmeq,
>         dma_unmap_sgtable(dev->dev, &iod->sgt, rq_dma_dir(req), 0);
>
>         if (iod->nr_descriptors =3D=3D 0)
> -               dma_pool_free(nvmeq->prp_pools.small, iod->descriptors[0]=
,
> -                             iod->first_dma);
> +               dma_pool_free(nvmeq->descriptor_pools.small,
> +                               iod->descriptors[0], iod->first_dma);
>         else if (iod->nr_descriptors =3D=3D 1)
> -               dma_pool_free(nvmeq->prp_pools.large, iod->descriptors[0]=
,
> -                             iod->first_dma);
> +               dma_pool_free(nvmeq->descriptor_pools.large,
> +                               iod->descriptors[0], iod->first_dma);
>         else
>                 nvme_free_prps(nvmeq, req);
>         mempool_free(iod->sgt.sgl, dev->iod_mempool);
> @@ -683,10 +682,10 @@ static blk_status_t nvme_pci_setup_prps(struct nvme=
_queue *nvmeq,
>
>         nprps =3D DIV_ROUND_UP(length, NVME_CTRL_PAGE_SIZE);
>         if (nprps <=3D (256 / 8)) {
> -               pool =3D nvmeq->prp_pools.small;
> +               pool =3D nvmeq->descriptor_pools.small;
>                 iod->nr_descriptors =3D 0;
>         } else {
> -               pool =3D nvmeq->prp_pools.large;
> +               pool =3D nvmeq->descriptor_pools.large;
>                 iod->nr_descriptors =3D 1;
>         }
>
> @@ -773,10 +772,10 @@ static blk_status_t nvme_pci_setup_sgls(struct nvme=
_queue *nvmeq,
>         }
>
>         if (entries <=3D (256 / sizeof(struct nvme_sgl_desc))) {
> -               pool =3D nvmeq->prp_pools.small;
> +               pool =3D nvmeq->descriptor_pools.small;
>                 iod->nr_descriptors =3D 0;
>         } else {
> -               pool =3D nvmeq->prp_pools.large;
> +               pool =3D nvmeq->descriptor_pools.large;
>                 iod->nr_descriptors =3D 1;
>         }
>
> @@ -921,7 +920,8 @@ static blk_status_t nvme_pci_setup_meta_sgls(struct n=
vme_dev *dev,
>         if (rc)
>                 goto out_free_sg;
>
> -       sg_list =3D dma_pool_alloc(nvmeq->prp_pools.small, GFP_ATOMIC, &s=
gl_dma);
> +       sg_list =3D dma_pool_alloc(nvmeq->descriptor_pools.small, GFP_ATO=
MIC,
> +                       &sgl_dma);
>         if (!sg_list)
>                 goto out_unmap_sg;
>
> @@ -1108,7 +1108,7 @@ static __always_inline void nvme_unmap_metadata(str=
uct nvme_dev *dev,
>                 return;
>         }
>
> -       dma_pool_free(nvmeq->prp_pools.small, iod->meta_descriptor,
> +       dma_pool_free(nvmeq->descriptor_pools.small, iod->meta_descriptor=
,
>                         iod->meta_dma);
>         dma_unmap_sgtable(dev->dev, &iod->meta_sgt, rq_dma_dir(req), 0);
>         mempool_free(iod->meta_sgt.sgl, dev->iod_meta_mempool);
> @@ -3214,8 +3214,8 @@ static struct nvme_dev *nvme_pci_alloc_dev(struct p=
ci_dev *pdev,
>         struct nvme_dev *dev;
>         int ret =3D -ENOMEM;
>
> -       dev =3D kzalloc_node(sizeof(*dev) + nr_node_ids * sizeof(*dev->pr=
p_pools),
> -                          GFP_KERNEL, node);
> +       dev =3D kzalloc_node(sizeof(*dev) + nr_node_ids *
> +                       sizeof(*dev->descriptor_pools), GFP_KERNEL, node)=
;
>         if (!dev)
>                 return ERR_PTR(-ENOMEM);
>         INIT_WORK(&dev->ctrl.reset_work, nvme_reset_work);
> @@ -3432,7 +3432,7 @@ static void nvme_remove(struct pci_dev *pdev)
>         nvme_free_queues(dev, 0);
>         mempool_destroy(dev->iod_mempool);
>         mempool_destroy(dev->iod_meta_mempool);
> -       nvme_release_prp_pools(dev);
> +       nvme_release_descriptor_pools(dev);
>         nvme_dev_unmap(dev);
>         nvme_uninit_ctrl(&dev->ctrl);
>  }
> --
> 2.47.2
>

