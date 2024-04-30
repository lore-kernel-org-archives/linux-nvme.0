Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91B3BC10F16
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Apr 2024 04:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ItSQ26q2YZUEpV+ZFz+IP6EN2hihJvGt6vO5eficMMg=; b=y93bBmW6IM5+cQlDCyFG0ubKBP
	nMUV4nHR5nEO813oNsGKqPoFyf8q3BeG87k2LFsFA5z9/M5mBOfzyiji3gdH0dPVNUwg/z20ECnU0
	p+6G/Xo9tsSHHnTL06pi6zfsV+fUCSWRui2VAl49xotNVQVcyUykkeTL/iRDmYgLNCef2cB0l5ujD
	69J9btaxmAvXlUvtmX3cNls0HArKBKBSvK1j40sD0woleucZ5H8I5HQT0pa6SOX0e/Ecw193sj87d
	ohrL9KpHyHqY7BAiJeYmqv6xtctq37SBTzjdEKSzOKWLDXDe994h14+vDSsj71dIEsMmvQsdhx4Ie
	wOr+gt9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s1fRJ-000000054iS-12HL;
	Tue, 30 Apr 2024 04:50:01 +0000
Received: from mail-vk1-xa35.google.com ([2607:f8b0:4864:20::a35])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s1fRE-000000054gy-10Ql
	for linux-nvme@lists.infradead.org;
	Tue, 30 Apr 2024 04:49:59 +0000
Received: by mail-vk1-xa35.google.com with SMTP id 71dfb90a1353d-4db24342894so1908288e0c.0
        for <linux-nvme@lists.infradead.org>; Mon, 29 Apr 2024 21:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714452589; x=1715057389; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ItSQ26q2YZUEpV+ZFz+IP6EN2hihJvGt6vO5eficMMg=;
        b=gGfq9iqsp56Lf49ZzJ0ifgEbIp5fJ5I/T9d4c18JtSNS8eRdNeA8k+/34d755Dwjvo
         KnmqeyTHWXdcxgnCeLJEoeJ7Y3oQZCuwTx2jX+fkv1Wx7BcMNIJrea0Ydq6qso3bRDG8
         BgytuCuK+sx9CJVLzEY9EFR/e3Wz7jRDwk0rMXnce0Df9GkzHOSz5Z+GW9NVvCHJ/NyS
         TOJezt2Ibxl7qJWCZv/XH4UXhvbI+00POf1n1F0ZytWEbE62g4dB04kEMiIoqzIeeg0G
         Dgtt08MMGbFjDM7HIE1KbUtCu01PuOv5riAOC/2Vpr0Ejau1OOqeydtfeQhekiTaar1g
         tVkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714452589; x=1715057389;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ItSQ26q2YZUEpV+ZFz+IP6EN2hihJvGt6vO5eficMMg=;
        b=gdQ9aLuUqFtbj1G+z7Ri8QRee5qDZ8nnBFfkfSvRHxNCN374W1P2tu0+R0DOuO0GaB
         dlitYPs1uzX0NipDwY7oIHDI5We3hsyhhRKKkr9OLipCWC9wCuav6qLxXpBv69U1s68x
         VRak1mQ5IoDbigdPK5V/F1FiL+g369vW3Z8Y9XWRi2zDxPMdNvPJ2H9EQdEyv86oYSsk
         nuuekOAxzVWNSzw8/Ac4zEyP9OhugrO/AABC0GeupqJdwZQ06krfTjYaIUVUFdmddFuo
         y+p4yYcRIx870RZH1ef9K1iJhqB0lW+7WE37FIzbyJQjtS8uockbrY0Q44AYiXwUiTRU
         KgqA==
X-Forwarded-Encrypted: i=1; AJvYcCW5kqVlYAVLMMUZpZcFTZW5eO8cZsFWuKcAigG340ttNGtM0Syir3rN5GLv2U7PRCJbxxWreD+4vEeGQZGgc/apW85cOyAeYag5XxXYnEk=
X-Gm-Message-State: AOJu0Yy2LV1tGaY45DmZYOJFwPC3vq9gHxeaRo95Rn1Wyd8bKtoshts/
	nQaWb1/hkMiXwW8ib7q+VvkLKdzLBwZN7u0N2Mkp+wG2KnIEGyA+3sqTgRU9lAlA5zCwBfewj0Y
	y70cvys02NvQ/9qdGncgijBSCmg==
X-Google-Smtp-Source: AGHT+IHKK4t2ubCHumP7WUtBKSZVKeZq+sjUYYsc1kZ1RQ+IcYNueimW5Fsgr0LeARPqeFQsWnC5m355rqj0sHr1YVY=
X-Received: by 2002:a05:6122:918:b0:4d4:2398:51a2 with SMTP id
 j24-20020a056122091800b004d4239851a2mr10993915vka.8.1714452587133; Mon, 29
 Apr 2024 21:49:47 -0700 (PDT)
MIME-Version: 1.0
References: <19d1b52a-f43e-5b41-ff1d-5257c7b3492@redhat.com>
In-Reply-To: <19d1b52a-f43e-5b41-ff1d-5257c7b3492@redhat.com>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Tue, 30 Apr 2024 10:19:10 +0530
Message-ID: <CACzX3AsAwXorQ2H90L61oT0cut0GLL0O82zecy+o_p3mkSR=BQ@mail.gmail.com>
Subject: Re: [PATCH] block: change rq_integrity_vec to respect the iterator
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, 
	Mike Snitzer <snitzer@kernel.org>, linux-block@vger.kernel.org, dm-devel@lists.linux.dev, 
	linux-nvme@lists.infradead.org, Kanchan Joshi <joshi.k@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240429_214956_378125_1A9BFDE4 
X-CRM114-Status: GOOD (  29.62  )
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

On Tue, Apr 30, 2024 at 12:07=E2=80=AFAM Mikulas Patocka <mpatocka@redhat.c=
om> wrote:
>
> Hi
>
> I am changing dm-crypt, so that it can store the autenticated encryption
> tag directly into the NVMe metadata (without using dm-integrity). This
> will improve performance significantly, because we can avoid journaling
> done by dm-integrity. I've got it working, but I've found this bug, so I'=
m
> sending a patch for it.
>
> Mikulas
>
>
> From: Mikulas Patocka <mpatocka@redhat.com>
>
> If we allocate a bio that is larger than NVMe maximum request size, attac=
h
> integrity metadata to it and send it to the NVMe subsystem, the integrity
> metadata will be corrupted.
>
> Splitting the bio works correctly. The function bio_split will clone the
> bio, trim the size of the first bio and advance the iterator of the secon=
d
> bio.
>
> However, the function rq_integrity_vec has a bug - it returns the first
> vector of the bio's metadata and completely disregards the metadata
> iterator that was advanced when the bio was split. Thus, the second bio
> uses the same metadata as the first bio and this leads to metadata
> corruption.
>
> This commit changes rq_integrity_vec, so that it calls mp_bvec_iter_bvec
> instead of returning the first vector. mp_bvec_iter_bvec reads the
> iterator and advances the vector by the iterator.

We also encountered this issue with split and had a similar solution [1]
This needs a fixes tag too.
fixes <2a876f5e25e8e> ("block: add a rq_integrity_vec helper")

>
> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
>
> ---
>  drivers/nvme/host/pci.c       |    6 +++---
>  include/linux/blk-integrity.h |   12 ++++++------
>  2 files changed, 9 insertions(+), 9 deletions(-)
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
> @@ -109,11 +109,11 @@ static inline bool blk_integrity_rq(stru
>   * Return the first bvec that contains integrity data.  Only drivers tha=
t are
>   * limited to a single integrity segment should use this helper.
>   */

The comment here needs to be updated. rq_integrity_vec now becomes an
iter based operation that can be used by drivers with multiple
integrity segments.

> -static inline struct bio_vec *rq_integrity_vec(struct request *rq)
> +static inline struct bio_vec rq_integrity_vec(struct request *rq)
>  {
> -       if (WARN_ON_ONCE(queue_max_integrity_segments(rq->q) > 1))
> -               return NULL;
> -       return rq->bio->bi_integrity->bip_vec;
> +       WARN_ON_ONCE(queue_max_integrity_segments(rq->q) > 1);
> +       return mp_bvec_iter_bvec(rq->bio->bi_integrity->bip_vec,
> +                                rq->bio->bi_integrity->bip_iter);
>  }
>  #else /* CONFIG_BLK_DEV_INTEGRITY */
>  static inline int blk_rq_count_integrity_sg(struct request_queue *q,
> @@ -177,9 +177,9 @@ static inline int blk_integrity_rq(struc
>         return 0;
>  }
>
> -static inline struct bio_vec *rq_integrity_vec(struct request *rq)
> +static inline struct bio_vec rq_integrity_vec(struct request *rq)
>  {
> -       return NULL;
> +       BUG();
>  }
>  #endif /* CONFIG_BLK_DEV_INTEGRITY */
>  #endif /* _LINUX_BLK_INTEGRITY_H */
>
>
[1] https://lore.kernel.org/linux-block/20240425183943.6319-6-joshi.k@samsu=
ng.com/
--
Anuj Gupta

