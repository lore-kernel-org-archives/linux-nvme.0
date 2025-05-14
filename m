Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BD2EC3ABC9
	for <linux-nvme@archiver.kernel.org>; Wed, 14 May 2025 01:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=k3iXrSndzXvlQ5G5Qb5scx/sT90oJiWDIfI2KCfIItw=; b=mKPX7L4Nbp46judEbIMwyG7eoW
	jb4zF4nlP1i1i7jgQLMW0BtWuSmtzaLy0VBJY96NCx96zIi3qVR4yr+Xeb/tDgkI4o3FakWjZZ7xs
	+qFm5HPprIr011PfIyGVo9PxD8H9vjnzD/K0A9EhhoeANnW0paTEEQ5DeyOJ4C9a8yg8ZHzXHPNn8
	eC03oKwa9wMon9ywbtEF7+HBwOvqxRbC5o1oCyeuVZFyy0Jze9UVepBAKchoZzFemDL7PlROmqYBt
	n/xtGqAaKhfMXwWliUk9DZRg8AP+VaZ3JBB4Sn7isba+4IQDG3jsGzkmvVXYKsOCthGp3Q3/6DFDP
	wwjsOYeQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uF0ak-0000000DpIs-2tc7;
	Wed, 14 May 2025 01:07:26 +0000
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uF0ai-0000000DpIV-2OOn
	for linux-nvme@lists.infradead.org;
	Wed, 14 May 2025 01:07:26 +0000
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-22eed3b3cabso7372585ad.2
        for <linux-nvme@lists.infradead.org>; Tue, 13 May 2025 18:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1747184844; x=1747789644; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k3iXrSndzXvlQ5G5Qb5scx/sT90oJiWDIfI2KCfIItw=;
        b=HYJjVk8qWPESLuHpDcCWkiv951ZwfIsxzKqNAxfVJsuHBOFLPAePnYXhchxce03haP
         sWRSrSf6L/ZmGHEa2voF8o/r4wiA4d1MeXN554MQnG0YAd6euY/tzw+17BvPXN0IRMAt
         eZePyA0a4dAClRngO5XASighXxjJVSqsfaDGrqN+aQ0K+IKL0utJDwwBHve8XZqRgX9G
         WSyka6WiV3tpM1/+HHRbyjCQ8dzQ/uh8+84JpShI75ftCZFoPh8WiJFw+KXB8anBYbNJ
         9vUMlTL7mvkGxwGtskUjT9UuSKPLFJdJTdT4qcMs3F+GZXopiJFlwi+Nks04nj3mWwE1
         MTow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747184844; x=1747789644;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k3iXrSndzXvlQ5G5Qb5scx/sT90oJiWDIfI2KCfIItw=;
        b=Wr9XBtV9THXzXXabzOFOXbd6CBvbiIOWPJaaS5oxNEOCirjxS3qUon10L83ngUAfwq
         KmA+ehrg+pTVf2W3rjyxt5ljYq2NevAW1A8Zdy2D+kI01PNkfHNFiq9nwnk0KQTtKdMg
         Gn5rMAVW50yu4lMbY6zoNdgCkMVaZ+ESZY3kobvBh6YiUxfpyjCVkt2+vl3RfZmVZJCr
         wQJazKfGCVH/3Kxs/FCtWRUBuBaby0Fsj7m3SRJtQu3noWuuwSoh9IDLNeu4e5qRGX/b
         J3jZuWs6QO6euFwVuu5t4t5SsatPbLQOxX+6SL+Px4N1ra1pTwa/34Hgow4m6fotj9yv
         k+qw==
X-Forwarded-Encrypted: i=1; AJvYcCUDEevLfSO/xVNC88ifFANL6qlxs6QTkLq3Own+uje+8d1nq17GLMESimUE5dFk+fP3l8u5MchR6q94@lists.infradead.org
X-Gm-Message-State: AOJu0YzImJer2gyQiLzF+wq0qqVWh9r8ramqMcqLlt6UG9RcCMEsk3n/
	vEI9lybQESQ/MMaH/DGmR0crb8rligqll/DI768qnvlqpTvIuVDMWkiJuQzthzInxmtiE4bZpzw
	HbairIjMEprQoA9JKHP63CRxv5f9RzivncCW4ng==
X-Gm-Gg: ASbGncscvXax+4Ni1ZT6FNRioaXDYE6TjD5d1w+HoyxoVlAaWwoSLZKeX0m1a/BmJTA
	Z59D/idD6nOGwC1oaHjYqx0F5TaKGTO9naJ4nY+azb7izsGlYzxlSFhoj1bF5lIGfSpaDc6dhVq
	MBgRmM4UXuSreqLANnsW0/KZp08BqtvoQ=
X-Google-Smtp-Source: AGHT+IFqa/DCoO7EzJFZ5aRSsVC0NwQV2g9fu6w1cWv2sBQfzkTmYRacOTGKWkftuKym1otkY1PYlIF7whGhGTX1SpU=
X-Received: by 2002:a17:903:1b45:b0:22e:361e:7572 with SMTP id
 d9443c01a7336-23198105395mr7904295ad.7.1747184843529; Tue, 13 May 2025
 18:07:23 -0700 (PDT)
MIME-Version: 1.0
References: <20250513070025.830930-1-hch@lst.de> <20250513070025.830930-4-hch@lst.de>
In-Reply-To: <20250513070025.830930-4-hch@lst.de>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Tue, 13 May 2025 18:07:11 -0700
X-Gm-Features: AX0GCFvTqjUOwPxLfQzSY-Nx6zyv-LUJ8giudRA9zMMBcSfM3xzZJJjkbSrtCEY
Message-ID: <CADUfDZr+CffCFTafw5BB8q3otr=Sw8GxP81_YxxBKUAmQkAbhQ@mail.gmail.com>
Subject: Re: [PATCH 3/7] nvme-pci: remove struct nvme_descriptor
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, 
	Leon Romanovsky <leon@kernel.org>, linux-nvme@lists.infradead.org, 
	Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250513_180724_613256_AA6861EC 
X-CRM114-Status: GOOD (  29.77  )
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
> There is no real point in having a union of two pointer types here, just
> use a void pointer as we mix and match types between the arms of the
> union between the allocation and freeing side already.
>
> Also rename the nr_allocations field to nr_descriptors to better describe
> what it does.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> [leon: ported forward to include metadata SGL support]
> Signed-off-by: Leon Romanovsky <leon@kernel.org>
> Tested-by: Jens Axboe <axboe@kernel.dk>
> ---
>  drivers/nvme/host/pci.c | 57 +++++++++++++++++------------------------
>  1 file changed, 24 insertions(+), 33 deletions(-)
>
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 51430f5e6a66..fe859c31e765 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -44,7 +44,7 @@
>  #define NVME_MAX_KB_SZ 8192
>  #define NVME_MAX_SEGS  128
>  #define NVME_MAX_META_SEGS 15
> -#define NVME_MAX_NR_ALLOCATIONS        5
> +#define NVME_MAX_NR_DESCRIPTORS        5
>
>  static int use_threaded_interrupts;
>  module_param(use_threaded_interrupts, int, 0444);
> @@ -225,11 +225,6 @@ struct nvme_queue {
>         struct completion delete_done;
>  };
>
> -union nvme_descriptor {
> -       struct nvme_sgl_desc    *sg_list;
> -       __le64                  *prp_list;
> -};
> -
>  /* bits for iod->flags */
>  enum nvme_iod_flags {
>         /* this command has been aborted by the timeout handler */
> @@ -238,23 +233,19 @@ enum nvme_iod_flags {
>
>  /*
>   * The nvme_iod describes the data in an I/O.
> - *
> - * The sg pointer contains the list of PRP/SGL chunk allocations in addi=
tion
> - * to the actual struct scatterlist.
>   */
>  struct nvme_iod {
>         struct nvme_request req;
>         struct nvme_command cmd;
>         u8 flags;
> -       s8 nr_allocations;      /* PRP list pool allocations. 0 means sma=
ll
> -                                  pool in use */
> +       s8 nr_descriptors;
>         unsigned int dma_len;   /* length of single DMA segment mapping *=
/
>         dma_addr_t first_dma;
>         dma_addr_t meta_dma;
>         struct sg_table sgt;
>         struct sg_table meta_sgt;
> -       union nvme_descriptor meta_list;
> -       union nvme_descriptor list[NVME_MAX_NR_ALLOCATIONS];
> +       void *meta_descriptor;

It looks like only the sg_list variant of meta_list is currently used.
Should this just be a struct nvme_sgl_desc *?

Best,
Caleb


> +       void *descriptors[NVME_MAX_NR_DESCRIPTORS];
>  };
>
>  static inline unsigned int nvme_dbbuf_size(struct nvme_dev *dev)
> @@ -607,8 +598,8 @@ static void nvme_free_prps(struct nvme_queue *nvmeq, =
struct request *req)
>         dma_addr_t dma_addr =3D iod->first_dma;
>         int i;
>
> -       for (i =3D 0; i < iod->nr_allocations; i++) {
> -               __le64 *prp_list =3D iod->list[i].prp_list;
> +       for (i =3D 0; i < iod->nr_descriptors; i++) {
> +               __le64 *prp_list =3D iod->descriptors[i];
>                 dma_addr_t next_dma_addr =3D le64_to_cpu(prp_list[last_pr=
p]);
>
>                 dma_pool_free(nvmeq->prp_pools.large, prp_list, dma_addr)=
;
> @@ -631,11 +622,11 @@ static void nvme_unmap_data(struct nvme_dev *dev, s=
truct nvme_queue *nvmeq,
>
>         dma_unmap_sgtable(dev->dev, &iod->sgt, rq_dma_dir(req), 0);
>
> -       if (iod->nr_allocations =3D=3D 0)
> -               dma_pool_free(nvmeq->prp_pools.small, iod->list[0].sg_lis=
t,
> +       if (iod->nr_descriptors =3D=3D 0)
> +               dma_pool_free(nvmeq->prp_pools.small, iod->descriptors[0]=
,
>                               iod->first_dma);
> -       else if (iod->nr_allocations =3D=3D 1)
> -               dma_pool_free(nvmeq->prp_pools.large, iod->list[0].sg_lis=
t,
> +       else if (iod->nr_descriptors =3D=3D 1)
> +               dma_pool_free(nvmeq->prp_pools.large, iod->descriptors[0]=
,
>                               iod->first_dma);
>         else
>                 nvme_free_prps(nvmeq, req);
> @@ -693,18 +684,18 @@ static blk_status_t nvme_pci_setup_prps(struct nvme=
_queue *nvmeq,
>         nprps =3D DIV_ROUND_UP(length, NVME_CTRL_PAGE_SIZE);
>         if (nprps <=3D (256 / 8)) {
>                 pool =3D nvmeq->prp_pools.small;
> -               iod->nr_allocations =3D 0;
> +               iod->nr_descriptors =3D 0;
>         } else {
>                 pool =3D nvmeq->prp_pools.large;
> -               iod->nr_allocations =3D 1;
> +               iod->nr_descriptors =3D 1;
>         }
>
>         prp_list =3D dma_pool_alloc(pool, GFP_ATOMIC, &prp_dma);
>         if (!prp_list) {
> -               iod->nr_allocations =3D -1;
> +               iod->nr_descriptors =3D -1;
>                 return BLK_STS_RESOURCE;
>         }
> -       iod->list[0].prp_list =3D prp_list;
> +       iod->descriptors[0] =3D prp_list;
>         iod->first_dma =3D prp_dma;
>         i =3D 0;
>         for (;;) {
> @@ -713,7 +704,7 @@ static blk_status_t nvme_pci_setup_prps(struct nvme_q=
ueue *nvmeq,
>                         prp_list =3D dma_pool_alloc(pool, GFP_ATOMIC, &pr=
p_dma);
>                         if (!prp_list)
>                                 goto free_prps;
> -                       iod->list[iod->nr_allocations++].prp_list =3D prp=
_list;
> +                       iod->descriptors[iod->nr_descriptors++] =3D prp_l=
ist;
>                         prp_list[0] =3D old_prp_list[i - 1];
>                         old_prp_list[i - 1] =3D cpu_to_le64(prp_dma);
>                         i =3D 1;
> @@ -783,19 +774,19 @@ static blk_status_t nvme_pci_setup_sgls(struct nvme=
_queue *nvmeq,
>
>         if (entries <=3D (256 / sizeof(struct nvme_sgl_desc))) {
>                 pool =3D nvmeq->prp_pools.small;
> -               iod->nr_allocations =3D 0;
> +               iod->nr_descriptors =3D 0;
>         } else {
>                 pool =3D nvmeq->prp_pools.large;
> -               iod->nr_allocations =3D 1;
> +               iod->nr_descriptors =3D 1;
>         }
>
>         sg_list =3D dma_pool_alloc(pool, GFP_ATOMIC, &sgl_dma);
>         if (!sg_list) {
> -               iod->nr_allocations =3D -1;
> +               iod->nr_descriptors =3D -1;
>                 return BLK_STS_RESOURCE;
>         }
>
> -       iod->list[0].sg_list =3D sg_list;
> +       iod->descriptors[0] =3D sg_list;
>         iod->first_dma =3D sgl_dma;
>
>         nvme_pci_sgl_set_seg(&cmd->dptr.sgl, sgl_dma, entries);
> @@ -935,7 +926,7 @@ static blk_status_t nvme_pci_setup_meta_sgls(struct n=
vme_dev *dev,
>                 goto out_unmap_sg;
>
>         entries =3D iod->meta_sgt.nents;
> -       iod->meta_list.sg_list =3D sg_list;
> +       iod->meta_descriptor =3D sg_list;
>         iod->meta_dma =3D sgl_dma;
>
>         cmnd->flags =3D NVME_CMD_SGL_METASEG;
> @@ -991,7 +982,7 @@ static blk_status_t nvme_prep_rq(struct nvme_dev *dev=
, struct request *req)
>         blk_status_t ret;
>
>         iod->flags =3D 0;
> -       iod->nr_allocations =3D -1;
> +       iod->nr_descriptors =3D -1;
>         iod->sgt.nents =3D 0;
>         iod->meta_sgt.nents =3D 0;
>
> @@ -1117,8 +1108,8 @@ static __always_inline void nvme_unmap_metadata(str=
uct nvme_dev *dev,
>                 return;
>         }
>
> -       dma_pool_free(nvmeq->prp_pools.small, iod->meta_list.sg_list,
> -                     iod->meta_dma);
> +       dma_pool_free(nvmeq->prp_pools.small, iod->meta_descriptor,
> +                       iod->meta_dma);
>         dma_unmap_sgtable(dev->dev, &iod->meta_sgt, rq_dma_dir(req), 0);
>         mempool_free(iod->meta_sgt.sgl, dev->iod_meta_mempool);
>  }
> @@ -3842,7 +3833,7 @@ static int __init nvme_init(void)
>         BUILD_BUG_ON(IRQ_AFFINITY_MAX_SETS < 2);
>         BUILD_BUG_ON(NVME_MAX_SEGS > SGES_PER_PAGE);
>         BUILD_BUG_ON(sizeof(struct scatterlist) * NVME_MAX_SEGS > PAGE_SI=
ZE);
> -       BUILD_BUG_ON(nvme_pci_npages_prp() > NVME_MAX_NR_ALLOCATIONS);
> +       BUILD_BUG_ON(nvme_pci_npages_prp() > NVME_MAX_NR_DESCRIPTORS);
>
>         return pci_register_driver(&nvme_driver);
>  }
> --
> 2.47.2
>

