Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 111A7C25B78
	for <linux-nvme@archiver.kernel.org>; Tue, 28 May 2024 03:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tMwY3jSjxqwMDaKFlhd/s9pzladNU9TjXZV/5WHBypU=; b=kuwCFtD2k8dW1gdNJRHAB+tQE6
	vVoqXjmUtCdgTKSSCfTuB4V5tf6S96jIS460KoUV49flmWPzxS+ydxAo3WKnJtk6M6ZIhITwdUCYN
	wlQMfIeP/Ft6t2OTaxw6pVPvxC6tjFZ6hs8nG73o17sNl9TRaOnV/EBx+COCSol80k2xdaMSLTB+5
	OmwhXHZxof0kFe3U7xrd0F+xaKpAzHrzUr4OqEhzuX9A9PmuFtDjZXp1DKh8sFORGje4tnpyuWgv+
	mMxW63qOKMoxqXztarA7r29Zzum4+931+mLdqdIM2r7ocEnzo8p6oV6hgVDnlI00CYS81mMSf2gaO
	ddGtSzSg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sBnp7-0000000GyFq-1nYT;
	Tue, 28 May 2024 03:48:29 +0000
Received: from mail-vk1-xa2d.google.com ([2607:f8b0:4864:20::a2d])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sBnoy-0000000GyFN-1PEO
	for linux-nvme@lists.infradead.org;
	Tue, 28 May 2024 03:48:21 +0000
Received: by mail-vk1-xa2d.google.com with SMTP id 71dfb90a1353d-4e4f02f4c6fso101389e0c.2
        for <linux-nvme@lists.infradead.org>; Mon, 27 May 2024 20:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716868097; x=1717472897; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tMwY3jSjxqwMDaKFlhd/s9pzladNU9TjXZV/5WHBypU=;
        b=J75W+LSYgE9XVpF12JFFS1iPOXiyCg0nyE+gnPoL1e+AxG7i68umVf/9V7CIIZCE18
         55Jb8i/fcljgZ0/HFlCAS8EgjGegClEn8VjIfGgEFTjhwOI3h5/Unv6nBqBxq2WnQ5N3
         rc+tkb4lJG/XqyYJUI/mjiXzR3ta9IoK7oXBx9ljhZ375hHNHexI8sRhdV2K9+E91Sm0
         fUeT6cW7Lgdqp59SaPTvez2RdyZsI1U+/whQ90uTttMZvQDX8V1SWrucwPhbdE6SyRVO
         9pCq8A71mhRfrSplylxmGpyl7f1lmxtSMscCmFXimawl5bZhkk2OR/36pni9b8agke07
         Vxug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716868097; x=1717472897;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tMwY3jSjxqwMDaKFlhd/s9pzladNU9TjXZV/5WHBypU=;
        b=R/fosbD9ldpylMwmZC6TCEJA1q2lA7VIjrX/M3504iBpn/v5oHMpSJkdGAULka78h8
         5JTjLb1uOaMkky93vDb/gg+FEJ3x1DxGC3ROW/iHledy8Cy7q/ZrDV83o6t2mwEw+yqz
         lq6LnM35DoAm+kXT3yP1sya0irQ2e9khBGGTjHTxnFNqBuxN8oNaR/wdyWBreyJiuP1H
         0iWKaHMAzu2mlls+WG+318llPtwi5f8wuVOfruI61GzpnCSbfofkAFRKc1giOQH+E2Tt
         XVugUrYTF2MbkPLL0OOgXR3GYTGfk+CyDHPgSh8yV0NIhKUivtAG7YcydQaPAMlpTjoh
         PwNQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+G2mv36OVhD1cyCYZIZLmExqNaFLqtBivR5nMU9i1lbxkQhZmKrlheQsdaGJD11XAELFaAuvDa+B4FGsm/yaOBkA9/sS14Oj35klDl4k=
X-Gm-Message-State: AOJu0YyAGnEQkAoLfpP72SIEi74OD6mldMcC1Ote5og7jpY6uUlzvQNA
	HkV7raJwNoQ53i6rRleR6/WxPc/6usLdN++2lvOG179wYaS5CWcySEKpDkBYT7FvztQLnsWAgVo
	aJU+hwXHaIl2x22GxhbldxG13Ww==
X-Google-Smtp-Source: AGHT+IEebTthiV+k9KwZYbfA6UqXjceghKuE5RhC9df1UxBYQNbJVxSNh4yrualQ39ZzH38xtnqX/A3NTiH2tP5u528=
X-Received: by 2002:a05:6122:3c54:b0:4e4:e998:bf88 with SMTP id
 71dfb90a1353d-4e4f02e3f3dmr10489613e0c.13.1716868097258; Mon, 27 May 2024
 20:48:17 -0700 (PDT)
MIME-Version: 1.0
References: <719d2e-b0e6-663c-ec38-acf939e4a04b@redhat.com> <49d1afaa-f934-6ed2-a678-e0d428c63a65@redhat.com>
In-Reply-To: <49d1afaa-f934-6ed2-a678-e0d428c63a65@redhat.com>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Tue, 28 May 2024 09:17:40 +0530
Message-ID: <CACzX3AvanzKyVFsyWOLyQMXo8oYOX=fggPaW_Uej+KUNfhMmFA@mail.gmail.com>
Subject: Re: [PATCH 1/2 v4] block: change rq_integrity_vec to respect the iterator
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, Mike Snitzer <snitzer@kernel.org>, Milan Broz <gmazyland@gmail.com>, 
	linux-block@vger.kernel.org, dm-devel@lists.linux.dev, 
	linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240527_204820_422670_3A6276EA 
X-CRM114-Status: GOOD (  26.94  )
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

On Mon, May 27, 2024 at 9:10=E2=80=AFPM Mikulas Patocka <mpatocka@redhat.co=
m> wrote:
>
> If we allocate a bio that is larger than NVMe maximum request size,
> attach integrity metadata to it and send it to the NVMe subsystem, the
> integrity metadata will be corrupted.
>
> Splitting the bio works correctly. The function bio_split will clone the
> bio, trim the iterator of the first bio and advance the iterator of the
> second bio.
>
> However, the function rq_integrity_vec has a bug - it returns the first
> vector of the bio's metadata and completely disregards the metadata
> iterator that was advanced when the bio was split. Thus, the second bio
> uses the same metadata as the first bio and this leads to metadata
> corruption.
>
> This commit changes rq_integrity_vec, so that it calls mp_bvec_iter_bvec
> instead of returning the first vector. mp_bvec_iter_bvec reads the
> iterator and uses it to build a bvec for the current position in the
> iterator.
>
> The "queue_max_integrity_segments(rq->q) > 1" check was removed, because
> the updated rq_integrity_vec function works correctly with multiple
> segments.
>
> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
>
> ---
>  drivers/nvme/host/pci.c       |    6 +++---
>  include/linux/blk-integrity.h |   14 +++++++-------
>  2 files changed, 10 insertions(+), 10 deletions(-)
>
> Index: linux-2.6/drivers/nvme/host/pci.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/drivers/nvme/host/pci.c
> +++ linux-2.6/drivers/nvme/host/pci.c
> @@ -825,9 +825,9 @@ static blk_status_t nvme_map_metadata(st
>                 struct nvme_command *cmnd)
>  {
>         struct nvme_iod *iod =3D blk_mq_rq_to_pdu(req);
> +       struct bio_vec bv =3D rq_integrity_vec(req);
>
> -       iod->meta_dma =3D dma_map_bvec(dev->dev, rq_integrity_vec(req),
> -                       rq_dma_dir(req), 0);
> +       iod->meta_dma =3D dma_map_bvec(dev->dev, &bv, rq_dma_dir(req), 0)=
;
>         if (dma_mapping_error(dev->dev, iod->meta_dma))
>                 return BLK_STS_IOERR;
>         cmnd->rw.metadata =3D cpu_to_le64(iod->meta_dma);
> @@ -966,7 +966,7 @@ static __always_inline void nvme_pci_unm
>                 struct nvme_iod *iod =3D blk_mq_rq_to_pdu(req);
>
>                 dma_unmap_page(dev->dev, iod->meta_dma,
> -                              rq_integrity_vec(req)->bv_len, rq_dma_dir(=
req));
> +                              rq_integrity_vec(req).bv_len, rq_dma_dir(r=
eq));
>         }
>
>         if (blk_rq_nr_phys_segments(req))
> Index: linux-2.6/include/linux/blk-integrity.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/include/linux/blk-integrity.h
> +++ linux-2.6/include/linux/blk-integrity.h
> @@ -106,14 +106,13 @@ static inline bool blk_integrity_rq(stru
>  }
>
>  /*
> - * Return the first bvec that contains integrity data.  Only drivers tha=
t are
> - * limited to a single integrity segment should use this helper.
> + * Return the current bvec that contains the integrity data. bip_iter ma=
y be
> + * advanced to iterate over the integrity data.
>   */
> -static inline struct bio_vec *rq_integrity_vec(struct request *rq)
> +static inline struct bio_vec rq_integrity_vec(struct request *rq)
>  {
> -       if (WARN_ON_ONCE(queue_max_integrity_segments(rq->q) > 1))
> -               return NULL;
> -       return rq->bio->bi_integrity->bip_vec;
> +       return mp_bvec_iter_bvec(rq->bio->bi_integrity->bip_vec,
> +                                rq->bio->bi_integrity->bip_iter);
>  }
>  #else /* CONFIG_BLK_DEV_INTEGRITY */
>  static inline int blk_rq_count_integrity_sg(struct request_queue *q,
> @@ -179,7 +178,8 @@ static inline int blk_integrity_rq(struc
>
>  static inline struct bio_vec *rq_integrity_vec(struct request *rq)
>  {
> -       return NULL;
> +       /* the optimizer will remove all calls to this function */
> +       return (struct bio_vec){ };
>  }
>  #endif /* CONFIG_BLK_DEV_INTEGRITY */
>  #endif /* _LINUX_BLK_INTEGRITY_H */
>

Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>

