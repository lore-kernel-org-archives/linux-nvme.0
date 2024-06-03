Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85FE8C25B75
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Jun 2024 16:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gmVt+zRf5HDzmy5BGVb1iNkMXtAfU8YSXemBM2r9RPo=; b=Q+mcmjqrs9xgZZBm1aReee6Bup
	12qL6RNKwIPPZJ3ro2f6H4uamFnIMbYAkIHM5y0a4QXUJi4I3bG8lDVnV78WenetZ01qAf3IS+C17
	2scRuTwgA/YYQT90cXb6UqrprQrQctqNOHNYVLo1C+9Uz1eXzvxWmWGnrPliPaWEIuDeFdSMZMTFN
	1ATWOVvWfILXSbCUbHwxZUCuTNo9yJxQfWpdfh5kapOA6HezOfwtxYhbMWVMm0Syx5oXVlLJ7zQqD
	g4dlkEue+Wf30z+Jk58YN5oea8RKPYkAd/OueATrkNxxDAWZNjURU1N5YGZcE81ZduRy+3GF2kNq3
	wx6ZXN7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEAhf-0000000HPAq-1VAV;
	Mon, 03 Jun 2024 16:38:35 +0000
Received: from mail-vk1-xa35.google.com ([2607:f8b0:4864:20::a35])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEAhc-0000000HPAH-0evr
	for linux-nvme@lists.infradead.org;
	Mon, 03 Jun 2024 16:38:34 +0000
Received: by mail-vk1-xa35.google.com with SMTP id 71dfb90a1353d-4eb167e9175so346764e0c.1
        for <linux-nvme@lists.infradead.org>; Mon, 03 Jun 2024 09:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717432710; x=1718037510; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gmVt+zRf5HDzmy5BGVb1iNkMXtAfU8YSXemBM2r9RPo=;
        b=Ao8+y4mTlKWWmyNbmTrOEKofZwMxD14t3te0WBaEY11uByNbGuHSQXam96VG90SYZp
         hd4WwDKSHZ72c43up5LcvGz5ouJV4aWp/RJQi25BYrJqbcyOkgtWIP1NofAOjCr+Q2ZP
         W2lSHKGT8+nZ8mOsYDDkggxv945iUJvP2T4dBLbhEOLp/CCUVqfUxCWXp9Fb1T4jgsKI
         Os6IOlIQB6XL5EoYschzPoe2DaLsm9CSpAnfq6qIKrYmXl8QkRz2/mvreZhA5b5YWAAG
         VTyqdtx8KCjdmNkTs9gMar5+NfiCaq3KFC/vWbYfORprV7auZcvjDcBp/Gra8B8j7SWo
         mQoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717432710; x=1718037510;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gmVt+zRf5HDzmy5BGVb1iNkMXtAfU8YSXemBM2r9RPo=;
        b=VaLMgVKZskTTtXuvJMoF0L3nd398g/WLQ3xp5sO3XowqrHr+8sti7XvCKrjcewibaX
         yOW1NZ95JLm5RWQuK96aAji66d9k7TVuy5lLzsW5zcoSBsP+/oNQ1lzpJll8F2b5GcaF
         QTgA/0LO/vZh27kPS8So9LhFawzxVyCKLexRi6N/DEK8HKchfcM3WH4+Xbz7HydQiztM
         Fi4cTW0IFoi2KutzDkImWm711m8FVA57DgThy+R2SRc7QmeFxDGg8AONplK7WJUbYlk6
         9+JutIPdARPbiN1q5lY/eHWO0g9H/g+MZuFWjRXBJS8OzPcdrZMn8Pzeeu/AmGoBzZqn
         gx4g==
X-Forwarded-Encrypted: i=1; AJvYcCVUn235FoSkijmu3O/abXJ4VilzOAmFVdocEhKQEa4YKRuTNfApeTANyHYDAk+xY5eIWyHvlzc21pmIM9eNGDGlVJ1qV03nb1X2XWu7cFg=
X-Gm-Message-State: AOJu0YyhDZozrwvCNtUkhsD4nmMGvORF5TsbOYwzSYfhJr1SiqEwtlfi
	lXKvIe7iT5hCffChEXQZlYL8rBHrVwW6rQWtZhAWslrlOnsnfMMi6ne6LiromwxhZ0ph2y9Io5g
	Lbw7+jXu02EYlFJbn2GacvovTKQ==
X-Google-Smtp-Source: AGHT+IElysqrqxRL/8QRnPtUhB/HUw65r9f5t1Ma1Xz8cgSkiEE7X0TUmoS9qum5rjp7pfEgfHtO0s+Oc4SGIMy4zz4=
X-Received: by 2002:ac5:cdaa:0:b0:4dc:d7aa:ccf9 with SMTP id
 71dfb90a1353d-4eb02ededd7mr6994674e0c.12.1717432709978; Mon, 03 Jun 2024
 09:38:29 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20240513084939epcas5p4530be8e7fc62b8d4db694d6b5bca3a19@epcas5p4.samsung.com>
 <20240513084222.8577-1-anuj20.g@samsung.com>
In-Reply-To: <20240513084222.8577-1-anuj20.g@samsung.com>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Mon, 3 Jun 2024 22:07:53 +0530
Message-ID: <CACzX3AuJ3gOV63FyK+0vPvn4WxeY5+QdzUG_XNw2iGKtC2CuPw@mail.gmail.com>
Subject: Re: [PATCH v2] block: unmap and free user mapped integrity via submitter
To: Anuj Gupta <anuj20.g@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org, 
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, 
	martin.petersen@oracle.com, Kanchan Joshi <joshi.k@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240603_093832_259041_7803A3AB 
X-CRM114-Status: GOOD (  28.75  )
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

On Mon, May 13, 2024 at 3:02=E2=80=AFPM Anuj Gupta <anuj20.g@samsung.com> w=
rote:
>
> The user mapped intergity is copied back and unpinned by
> bio_integrity_free which is a low-level routine. Do it via the submitter
> rather than doing it in the low-level block layer code, to split the
> submitter side from the consumer side of the bio.
>
> Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
> ---
> Changes in v2:
> - create a helper for unmap logic (Keith)
> - return if integrity is not user-mapped (Jens)
> - v1: https://lore.kernel.org/linux-block/20240510094429.2489-1-anuj20.g@=
samsung.com/
> ---
>  block/bio-integrity.c     | 26 ++++++++++++++++++++++++--
>  drivers/nvme/host/ioctl.c | 15 +++++++++++----
>  include/linux/bio.h       |  4 ++++
>  3 files changed, 39 insertions(+), 6 deletions(-)
>
> diff --git a/block/bio-integrity.c b/block/bio-integrity.c
> index 2e3e8e04961e..8b528e12136f 100644
> --- a/block/bio-integrity.c
> +++ b/block/bio-integrity.c
> @@ -144,16 +144,38 @@ void bio_integrity_free(struct bio *bio)
>         struct bio_integrity_payload *bip =3D bio_integrity(bio);
>         struct bio_set *bs =3D bio->bi_pool;
>
> +       if (bip->bip_flags & BIP_INTEGRITY_USER)
> +               return;
>         if (bip->bip_flags & BIP_BLOCK_INTEGRITY)
>                 kfree(bvec_virt(bip->bip_vec));
> -       else if (bip->bip_flags & BIP_INTEGRITY_USER)
> -               bio_integrity_unmap_user(bip);
>
>         __bio_integrity_free(bs, bip);
>         bio->bi_integrity =3D NULL;
>         bio->bi_opf &=3D ~REQ_INTEGRITY;
>  }
>
> +/**
> + * bio_integrity_unmap_free_user - Unmap and free bio user integrity pay=
load
> + * @bio:       bio containing bip to be unmapped and freed
> + *
> + * Description: Used to unmap and free the user mapped integrity portion=
 of a
> + * bio. Submitter attaching the user integrity buffer is responsible for
> + * unmapping and freeing it during completion.
> + */
> +void bio_integrity_unmap_free_user(struct bio *bio)
> +{
> +       struct bio_integrity_payload *bip =3D bio_integrity(bio);
> +       struct bio_set *bs =3D bio->bi_pool;
> +
> +       if (WARN_ON_ONCE(!(bip->bip_flags & BIP_INTEGRITY_USER)))
> +               return;
> +       bio_integrity_unmap_user(bip);
> +       __bio_integrity_free(bs, bip);
> +       bio->bi_integrity =3D NULL;
> +       bio->bi_opf &=3D ~REQ_INTEGRITY;
> +}
> +EXPORT_SYMBOL(bio_integrity_unmap_free_user);
> +
>  /**
>   * bio_integrity_add_page - Attach integrity metadata
>   * @bio:       bio to update
> diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
> index 499a8bb7cac7..2dff5933cae9 100644
> --- a/drivers/nvme/host/ioctl.c
> +++ b/drivers/nvme/host/ioctl.c
> @@ -111,6 +111,13 @@ static struct request *nvme_alloc_user_request(struc=
t request_queue *q,
>         return req;
>  }
>
> +static void nvme_unmap_bio(struct bio *bio)
> +{
> +       if (bio_integrity(bio))
> +               bio_integrity_unmap_free_user(bio);
> +       blk_rq_unmap_user(bio);
> +}
> +
>  static int nvme_map_user_request(struct request *req, u64 ubuffer,
>                 unsigned bufflen, void __user *meta_buffer, unsigned meta=
_len,
>                 u32 meta_seed, struct io_uring_cmd *ioucmd, unsigned int =
flags)
> @@ -157,7 +164,7 @@ static int nvme_map_user_request(struct request *req,=
 u64 ubuffer,
>
>  out_unmap:
>         if (bio)
> -               blk_rq_unmap_user(bio);
> +               nvme_unmap_bio(bio);
>  out:
>         blk_mq_free_request(req);
>         return ret;
> @@ -195,7 +202,7 @@ static int nvme_submit_user_cmd(struct request_queue =
*q,
>         if (result)
>                 *result =3D le64_to_cpu(nvme_req(req)->result.u64);
>         if (bio)
> -               blk_rq_unmap_user(bio);
> +               nvme_unmap_bio(bio);
>         blk_mq_free_request(req);
>
>         if (effects)
> @@ -406,7 +413,7 @@ static void nvme_uring_task_cb(struct io_uring_cmd *i=
oucmd,
>         struct nvme_uring_cmd_pdu *pdu =3D nvme_uring_cmd_pdu(ioucmd);
>
>         if (pdu->bio)
> -               blk_rq_unmap_user(pdu->bio);
> +               nvme_unmap_bio(pdu->bio);
>         io_uring_cmd_done(ioucmd, pdu->status, pdu->result, issue_flags);
>  }
>
> @@ -432,7 +439,7 @@ static enum rq_end_io_ret nvme_uring_cmd_end_io(struc=
t request *req,
>          */
>         if (blk_rq_is_poll(req)) {
>                 if (pdu->bio)
> -                       blk_rq_unmap_user(pdu->bio);
> +                       nvme_unmap_bio(pdu->bio);
>                 io_uring_cmd_iopoll_done(ioucmd, pdu->result, pdu->status=
);
>         } else {
>                 io_uring_cmd_do_in_task_lazy(ioucmd, nvme_uring_task_cb);
> diff --git a/include/linux/bio.h b/include/linux/bio.h
> index d5379548d684..818e93612947 100644
> --- a/include/linux/bio.h
> +++ b/include/linux/bio.h
> @@ -731,6 +731,7 @@ static inline bool bioset_initialized(struct bio_set =
*bs)
>                 bip_for_each_vec(_bvl, _bio->bi_integrity, _iter)
>
>  int bio_integrity_map_user(struct bio *bio, void __user *ubuf, ssize_t l=
en, u32 seed);
> +void bio_integrity_unmap_free_user(struct bio *bio);
>  extern struct bio_integrity_payload *bio_integrity_alloc(struct bio *, g=
fp_t, unsigned int);
>  extern int bio_integrity_add_page(struct bio *, struct page *, unsigned =
int, unsigned int);
>  extern bool bio_integrity_prep(struct bio *);
> @@ -807,6 +808,9 @@ static inline int bio_integrity_map_user(struct bio *=
bio, void __user *ubuf,
>  {
>         return -EINVAL;
>  }
> +static inline void bio_integrity_unmap_free_user(struct bio *bio)
> +{
> +}
>
>  #endif /* CONFIG_BLK_DEV_INTEGRITY */
>
> --
> 2.25.1
>
>
Hi Jens,
This has got the necessary reviews. Can this be picked up?
Or do you see anything missing?

