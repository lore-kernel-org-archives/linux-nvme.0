Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26C89C54755
	for <linux-nvme@archiver.kernel.org>; Wed, 14 May 2025 18:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3iLlRhtf8MJnFCYhA6HuBxkDbzg3A2S1bcAMkjhMgpA=; b=jNDux0NSejAiMOyvGBP9IbAkqo
	lQ63+mFfeFC7aM/BNHL1ISvxQxtqdWn+XvYe+FOSTeCvUDG7LPlYnRRbI7JmToiiPUM7cvoFNXPe5
	7A1UbPheci3ZYmgxhI3hqwFHL+AyZ6Io8XwZ3zDMCyZWncyYQ4K1Gob0xg1zeIeW9Fg1jKI9AAfqR
	a1VaHMeFAhEPPN77u2Y3yAvzqmQMT4/ORbFctuKaiX3xqe/thHnKrzGQHZFhH6BwOEWwwLP99dxwO
	Q/JJ9GjCRcREI2uH9GGwpjFZBR1A4A8J3RAtE1uF2qNO74zeX/RBNvM2ra+FTw1PwjxS6Ym12nJ+5
	J305qEkg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFGvS-0000000G1yV-2dfd;
	Wed, 14 May 2025 18:33:54 +0000
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFGD4-0000000FwFW-0KIH
	for linux-nvme@lists.infradead.org;
	Wed, 14 May 2025 17:48:09 +0000
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-22fa82144bfso115495ad.1
        for <linux-nvme@lists.infradead.org>; Wed, 14 May 2025 10:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1747244881; x=1747849681; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3iLlRhtf8MJnFCYhA6HuBxkDbzg3A2S1bcAMkjhMgpA=;
        b=RRm7fXGQhCR60xyJ7xJ24cpoU2cqZQ4aqX5IvoFZg4lzfMQM+ppkCc6k4GPt6qPrCG
         K2fEOQ5rlvKBjn1975cnUBCyB1YkNSaM3cnUk8Cwo5xBM3Ge3BUygdMl3JjGjcW0J9Mj
         bweazItW5HGHtfcNl+idtUZ3A49Afy55DU/6fORd5tWEdfornnvwATkNBJF/z64ruP7s
         Iks2a2/Jar8h9VgbpIhsNGZoITJoQuHi1pekw3RTCbfK1rcsZCR4bqlQOsUsHtPzaIdp
         uFZEjxRAWrouqd5aEIJ0BAWL0rwZcKkmm/v8rPJsqkioLq/99v19VSZKlEKmmp25Vyct
         9IAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747244881; x=1747849681;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3iLlRhtf8MJnFCYhA6HuBxkDbzg3A2S1bcAMkjhMgpA=;
        b=rrrM6dhOtJtTbded9XyGt2fGpIkRd4TKOb48ZgU/yBF6l2HX1Fsel2HwF42D6DBYzo
         cOuYORb7RJ1CXEz+brE6Xub/HkOkVmdUq1RrYUHVmKA1pcy6co+MYvUhq3paJuYC5IbZ
         +9/pyIxbL+FQSU0y0SE7UJGhCXZJVWeLo1fH+p3tYg48bhBFhDiNL/BS/G9GgKIpLm2h
         BccMoNH1mOaf9yolQOyi/0g+lzWNZwhAnOQhwAKVCYH/jUd4ce1V5yufyOgcy2f1FDqF
         /nBU0iTriBUzUf6iTYS4eAF+a/opYJbHntZLQPFH/4+MwwJDV/CzxvvgH1dHLsCgdcON
         LXdA==
X-Forwarded-Encrypted: i=1; AJvYcCVDXomLk5gZj4B5f/2RON3YdIwhflSio9EZQDDNwRr8uS0KMx6FEt7Bv7/5bOtnsO3mCApuXIKgnYNE@lists.infradead.org
X-Gm-Message-State: AOJu0YyNXcPUCMK13sFwxu99/JJ8cYQ+hjLsLVGVsVLF0RCXL7vrN0P/
	6K8+jgHfOFqgP2RWbD7XcVRRqPy/xW1b6ozc2AAZCRNsySRv2kJ8NR9dY7S47I/syIz1gj2egzC
	l38tjujVPIMAk6L0XhFAMN4QMvwCZxhMqSq9AuA==
X-Gm-Gg: ASbGncu5bnuupCitur+/NUn2a4ijdtx8ippcjn1/phoOAm8bg+PozyFC9Wp5nh5q7pF
	Tis7cUGwxpxcs/903SQZ1R/mYK0Ls2nxS3nue2nGYZAEgpPhiyneIivwIamzk6dG3tUiWk9ptDh
	AQ5R6wdOSdAgSnORBSmH9tNB+QdN2/jVsS
X-Google-Smtp-Source: AGHT+IEOHDaaxrK11FdiKxt3UibI92Geo/QgAd25u8J9hFSp09zCNYCwK26qCA6Nuw9DVAwKBf2ZRQfamv/pawbvLoI=
X-Received: by 2002:a17:903:22d0:b0:21f:356:758f with SMTP id
 d9443c01a7336-231980bf647mr27489995ad.3.1747244880613; Wed, 14 May 2025
 10:48:00 -0700 (PDT)
MIME-Version: 1.0
References: <20250513070025.830930-1-hch@lst.de> <20250513070025.830930-6-hch@lst.de>
In-Reply-To: <20250513070025.830930-6-hch@lst.de>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Wed, 14 May 2025 10:47:48 -0700
X-Gm-Features: AX0GCFv3IDpZlBOXnVgp0ZCdkMBzNPQ5tVG_na6dnntQNhSwQc6His7_N4_L9x8
Message-ID: <CADUfDZoh1RR058MZkjdwhEYiY56XWpejXtkMt7eES6rkA9boPw@mail.gmail.com>
Subject: Re: [PATCH 5/7] nvme-pci: use a better encoding for small prp pool allocations
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, 
	Leon Romanovsky <leon@kernel.org>, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250514_104802_243737_3B2B7213 
X-CRM114-Status: GOOD (  29.70  )
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
> Add a separate flag to encode that the transfer is using the small
> page sized pool, and use a normal 0..n count for the number of
> descriptors.
>
> Contains improvements and suggestions from Kanchan Joshi
> <joshi.k@samsung.com> and Leon Romanovsky <leonro@nvidia.com>.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/nvme/host/pci.c | 82 ++++++++++++++++++++---------------------
>  1 file changed, 39 insertions(+), 43 deletions(-)
>
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 773a2e625657..16e2ce25da83 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -229,6 +229,9 @@ struct nvme_queue {
>  enum nvme_iod_flags {
>         /* this command has been aborted by the timeout handler */
>         IOD_ABORTED             =3D 1U << 0,
> +
> +       /* uses the small descriptor pool */
> +       IOD_SMALL_DESCRIPTOR            =3D 1U << 1,
>  };
>
>  /*
> @@ -238,7 +241,7 @@ struct nvme_iod {
>         struct nvme_request req;
>         struct nvme_command cmd;
>         u8 flags;
> -       s8 nr_descriptors;
> +       u8 nr_descriptors;
>         unsigned int dma_len;   /* length of single DMA segment mapping *=
/
>         dma_addr_t first_dma;
>         dma_addr_t meta_dma;
> @@ -589,13 +592,27 @@ static inline bool nvme_pci_use_sgls(struct nvme_de=
v *dev, struct request *req,
>         return true;
>  }
>
> -static void nvme_free_prps(struct nvme_queue *nvmeq, struct request *req=
)
> +static inline struct dma_pool *nvme_dma_pool(struct nvme_queue *nvmeq,
> +               struct nvme_iod *iod)
> +{
> +       if (iod->flags & IOD_SMALL_DESCRIPTOR)
> +               return nvmeq->descriptor_pools.small;
> +       return nvmeq->descriptor_pools.large;
> +}
> +
> +static void nvme_free_descriptors(struct nvme_queue *nvmeq, struct reque=
st *req)

Feels like this name change from "prps" to "descriptors" belongs
better in the prior commit "nvme-pci: rename the descriptor pools"?

Best,
Caleb

>  {
>         const int last_prp =3D NVME_CTRL_PAGE_SIZE / sizeof(__le64) - 1;
>         struct nvme_iod *iod =3D blk_mq_rq_to_pdu(req);
>         dma_addr_t dma_addr =3D iod->first_dma;
>         int i;
>
> +       if (iod->nr_descriptors =3D=3D 1) {
> +               dma_pool_free(nvme_dma_pool(nvmeq, iod), iod->descriptors=
[0],
> +                               dma_addr);
> +               return;
> +       }
> +
>         for (i =3D 0; i < iod->nr_descriptors; i++) {
>                 __le64 *prp_list =3D iod->descriptors[i];
>                 dma_addr_t next_dma_addr =3D le64_to_cpu(prp_list[last_pr=
p]);
> @@ -620,15 +637,7 @@ static void nvme_unmap_data(struct nvme_dev *dev, st=
ruct nvme_queue *nvmeq,
>         WARN_ON_ONCE(!iod->sgt.nents);
>
>         dma_unmap_sgtable(dev->dev, &iod->sgt, rq_dma_dir(req), 0);
> -
> -       if (iod->nr_descriptors =3D=3D 0)
> -               dma_pool_free(nvmeq->descriptor_pools.small,
> -                               iod->descriptors[0], iod->first_dma);
> -       else if (iod->nr_descriptors =3D=3D 1)
> -               dma_pool_free(nvmeq->descriptor_pools.large,
> -                               iod->descriptors[0], iod->first_dma);
> -       else
> -               nvme_free_prps(nvmeq, req);
> +       nvme_free_descriptors(nvmeq, req);
>         mempool_free(iod->sgt.sgl, dev->iod_mempool);
>  }
>
> @@ -650,7 +659,6 @@ static blk_status_t nvme_pci_setup_prps(struct nvme_q=
ueue *nvmeq,
>                 struct request *req, struct nvme_rw_command *cmnd)
>  {
>         struct nvme_iod *iod =3D blk_mq_rq_to_pdu(req);
> -       struct dma_pool *pool;
>         int length =3D blk_rq_payload_bytes(req);
>         struct scatterlist *sg =3D iod->sgt.sgl;
>         int dma_len =3D sg_dma_len(sg);
> @@ -658,7 +666,7 @@ static blk_status_t nvme_pci_setup_prps(struct nvme_q=
ueue *nvmeq,
>         int offset =3D dma_addr & (NVME_CTRL_PAGE_SIZE - 1);
>         __le64 *prp_list;
>         dma_addr_t prp_dma;
> -       int nprps, i;
> +       int i;
>
>         length -=3D (NVME_CTRL_PAGE_SIZE - offset);
>         if (length <=3D 0) {
> @@ -680,27 +688,23 @@ static blk_status_t nvme_pci_setup_prps(struct nvme=
_queue *nvmeq,
>                 goto done;
>         }
>
> -       nprps =3D DIV_ROUND_UP(length, NVME_CTRL_PAGE_SIZE);
> -       if (nprps <=3D (256 / 8)) {
> -               pool =3D nvmeq->descriptor_pools.small;
> -               iod->nr_descriptors =3D 0;
> -       } else {
> -               pool =3D nvmeq->descriptor_pools.large;
> -               iod->nr_descriptors =3D 1;
> -       }
> +       if (DIV_ROUND_UP(length, NVME_CTRL_PAGE_SIZE) <=3D
> +           256 / sizeof(__le64))
> +               iod->flags |=3D IOD_SMALL_DESCRIPTOR;
>
> -       prp_list =3D dma_pool_alloc(pool, GFP_ATOMIC, &prp_dma);
> -       if (!prp_list) {
> -               iod->nr_descriptors =3D -1;
> +       prp_list =3D dma_pool_alloc(nvme_dma_pool(nvmeq, iod), GFP_ATOMIC=
,
> +                       &prp_dma);
> +       if (!prp_list)
>                 return BLK_STS_RESOURCE;
> -       }
> -       iod->descriptors[0] =3D prp_list;
> +       iod->descriptors[iod->nr_descriptors++] =3D prp_list;

This is slightly more expensive than the existing code because the
compiler can't tell that iod->nr_descriptors is initially 0. How about
keeping this as iod->descriptors[0] =3D prp_list and setting
iod->nr_descriptors =3D 1 on the next line?

>         iod->first_dma =3D prp_dma;
>         i =3D 0;
>         for (;;) {
>                 if (i =3D=3D NVME_CTRL_PAGE_SIZE >> 3) {
>                         __le64 *old_prp_list =3D prp_list;
> -                       prp_list =3D dma_pool_alloc(pool, GFP_ATOMIC, &pr=
p_dma);
> +
> +                       prp_list =3D dma_pool_alloc(nvme_dma_pool(nvmeq, =
iod),
> +                                       GFP_ATOMIC, &prp_dma);
>                         if (!prp_list)
>                                 goto free_prps;
>                         iod->descriptors[iod->nr_descriptors++] =3D prp_l=
ist;
> @@ -727,7 +731,7 @@ static blk_status_t nvme_pci_setup_prps(struct nvme_q=
ueue *nvmeq,
>         cmnd->dptr.prp2 =3D cpu_to_le64(iod->first_dma);
>         return BLK_STS_OK;
>  free_prps:
> -       nvme_free_prps(nvmeq, req);
> +       nvme_free_descriptors(nvmeq, req);
>         return BLK_STS_RESOURCE;
>  bad_sgl:
>         WARN(DO_ONCE(nvme_print_sgl, iod->sgt.sgl, iod->sgt.nents),
> @@ -756,7 +760,6 @@ static blk_status_t nvme_pci_setup_sgls(struct nvme_q=
ueue *nvmeq,
>                 struct request *req, struct nvme_rw_command *cmd)
>  {
>         struct nvme_iod *iod =3D blk_mq_rq_to_pdu(req);
> -       struct dma_pool *pool;
>         struct nvme_sgl_desc *sg_list;
>         struct scatterlist *sg =3D iod->sgt.sgl;
>         unsigned int entries =3D iod->sgt.nents;
> @@ -771,21 +774,14 @@ static blk_status_t nvme_pci_setup_sgls(struct nvme=
_queue *nvmeq,
>                 return BLK_STS_OK;
>         }
>
> -       if (entries <=3D (256 / sizeof(struct nvme_sgl_desc))) {
> -               pool =3D nvmeq->descriptor_pools.small;
> -               iod->nr_descriptors =3D 0;
> -       } else {
> -               pool =3D nvmeq->descriptor_pools.large;
> -               iod->nr_descriptors =3D 1;
> -       }
> +       if (entries <=3D 256 / sizeof(*sg_list))
> +               iod->flags |=3D IOD_SMALL_DESCRIPTOR;
>
> -       sg_list =3D dma_pool_alloc(pool, GFP_ATOMIC, &sgl_dma);
> -       if (!sg_list) {
> -               iod->nr_descriptors =3D -1;
> +       sg_list =3D dma_pool_alloc(nvme_dma_pool(nvmeq, iod), GFP_ATOMIC,
> +                       &sgl_dma);
> +       if (!sg_list)
>                 return BLK_STS_RESOURCE;
> -       }
> -
> -       iod->descriptors[0] =3D sg_list;
> +       iod->descriptors[iod->nr_descriptors++] =3D sg_list;
>         iod->first_dma =3D sgl_dma;
>
>         nvme_pci_sgl_set_seg(&cmd->dptr.sgl, sgl_dma, entries);
> @@ -982,7 +978,7 @@ static blk_status_t nvme_prep_rq(struct nvme_dev *dev=
, struct request *req)
>         blk_status_t ret;
>
>         iod->flags =3D 0;
> -       iod->nr_descriptors =3D -1;
> +       iod->nr_descriptors =3D 0;
>         iod->sgt.nents =3D 0;
>         iod->meta_sgt.nents =3D 0;
>
> --
> 2.47.2
>

