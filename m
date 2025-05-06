Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 710C2C3ABBE
	for <linux-nvme@archiver.kernel.org>; Tue,  6 May 2025 20:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1WRNweJbn4r/3TvWDCNLlpaWwC6HbAU8UMzkpb3TS/E=; b=3JlfLAMne46q0X/UO1h91hnwoF
	uPS9mJk/E1XAuP2dXPLVpxUuAi/0mXBg+K7ExKu3HoPazOfqsdHl/Cj8MKD80KxWvcLQYZ+/z4dNM
	jeWieUAftYwtjT514sfvT8Emge4PWzuppXFnDzTXZv5P6OonZlbFVCdA4gpGplGiXaqtM3e/i1177
	y6KTFPu14GNXhXxDBVHpdPGQ/Pg6v4vc0yodhESe8OPG/uyuvKo8U4LKz4HWlAaLnYaWDl1YR5EfB
	E1hnoCtHFSc1VOPJvwWCqWz3WE6fjCO5zthwUXRU8FsxawMtpTO6TUVWy49DA1SKz7PdcvM4vVAcJ
	tuXUPO2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCOZI-0000000DK9c-2yGo;
	Tue, 06 May 2025 20:07:08 +0000
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCKwB-0000000Cde7-3TpQ
	for linux-nvme@lists.infradead.org;
	Tue, 06 May 2025 16:14:33 +0000
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-b1faa09bae7so400585a12.1
        for <linux-nvme@lists.infradead.org>; Tue, 06 May 2025 09:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1746548071; x=1747152871; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1WRNweJbn4r/3TvWDCNLlpaWwC6HbAU8UMzkpb3TS/E=;
        b=SxuLKQNz4UNqukL8lwv7SRgDPCRxowWaNeJ/3vCQgqzVxsIZ+HfsNexr5jiEzXmgcl
         XeKljjvZgQBv75OqMl+ov3Telp3C0dLwgWb5ZC9aB4wGwg+5rEf6lEU+6A3OqdZEyFxx
         o1LnC4FhJ/iUSGYpFzbcGL5Qxc6y+TLD9zQcz4Td1dysRfNGxrscG21PJvWQApR2Zfl7
         2kpvte4UoHNOkN0C0yLC89zA2/ZxC9gCF3mX76z69o8jC0mYbiwxFWK50BbIVD0jKzqM
         rFS6/b2Ox+MOqLmAWYkGL/8Ldj5pDY9EfgNdUonexn5Umdz2TIoLvcYOE/c0Qevolfe7
         vzdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746548071; x=1747152871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1WRNweJbn4r/3TvWDCNLlpaWwC6HbAU8UMzkpb3TS/E=;
        b=uNdwBykpzxoFGTQe/iUWvEChsleJQuDI4zMDZeN+Jao6WZe5zQQSeYdF3uhlxW60M0
         vYlUqXMXotfM31afU0t3ZVcbW554EK3zpbf9OcZdvUIxLjTM1lYSPmmnCBmNzKwIaBjf
         I6lsikeNjzoS4OfLQV4YmnTwbcFtnn1bBynYrT+XJTVflIepqSiXOqSkybQjCnycEZZ4
         K00/V2MSxzFsbFV2L2Mgu1n7Jl8tBqfCF9sgAgHcD5ORF6sG8MXqfhT+T0jRNeYt/ryb
         E+xKqdrD6W+/s6zKqNc3th+nLw1qPyk5HShTDk9P7D+wi+GLGvZg2HY6w3yMx/mtaCiG
         3OLg==
X-Forwarded-Encrypted: i=1; AJvYcCX+o3wsTCce2evj8eRX8sXsgcfurpiTfpYn28ZGHP0Hc24rtDqV/IyTQ6gRFiIODIQ1PNf56HDxCta6@lists.infradead.org
X-Gm-Message-State: AOJu0YzTWU1cZPzeQd+/Qh2LA7AqGjV4TgAvci15nSiL7hSy9X9SDwoP
	DJUtN9Ru4x1wVSSXOte48X2fq+wM77n0zyEWcx59Gqu7YeopKyaIxnRwZUti1tgQoI3gh5+qq58
	/iyvXOl+a6yuSY0J9jZoIINzn7niHPqEXdbTLWA==
X-Gm-Gg: ASbGncu/3R7N/s8euuFldu1oXpBbnsqjbeZN+dJWblWNS+FCG5q7eigXoEiUwtHh4yF
	2LlkMrUU13AzvrjNL+MlFcClY3mt8Aiv7/AA81cWTczE8Q53Gsx1s1PBFx+zWnAUS4SUje6EldI
	gE+TsnUllQ3LweUAMkeI7L
X-Google-Smtp-Source: AGHT+IGomfxFuIVXIAJx2LE0nyDyaX/EDbj1YgVtK5jOGH1/g4wQgUzQAReH/W/vN9YObV6vQ1hyrrqDB71RRmZm9tk=
X-Received: by 2002:a17:90b:1a89:b0:2fe:b77a:2eba with SMTP id
 98e67ed59e1d1-30aac173ebcmr39388a91.1.1746548070717; Tue, 06 May 2025
 09:14:30 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20250506122653epcas5p1824d4af64d0b599fde2de831d8ebf732@epcas5p1.samsung.com>
 <20250506121732.8211-1-joshi.k@samsung.com> <20250506121732.8211-12-joshi.k@samsung.com>
In-Reply-To: <20250506121732.8211-12-joshi.k@samsung.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Tue, 6 May 2025 09:14:19 -0700
X-Gm-Features: ATxdqUGbCedLb2BDJsLzNQ4a09UlvzPN29Syr7Nwkf-EIDAeNNy85cp_G9DdiZA
Message-ID: <CADUfDZrWstGcx+EqsmaQvSJJrMAK-Ls+HtGyS8j3okZQ+N4FKQ@mail.gmail.com>
Subject: Re: [PATCH v16 11/11] nvme: use fdp streams if write stream is provided
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, asml.silence@gmail.com, 
	io-uring@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-nvme@lists.infradead.org, 
	Hannes Reinecke <hare@suse.de>, Nitesh Shetty <nj.shetty@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250506_091431_865276_DA3183B8 
X-CRM114-Status: GOOD (  21.92  )
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

On Tue, May 6, 2025 at 5:31=E2=80=AFAM Kanchan Joshi <joshi.k@samsung.com> =
wrote:
>
> From: Keith Busch <kbusch@kernel.org>
>
> Maps a user requested write stream to an FDP placement ID if possible.
>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Reviewed-by: Nitesh Shetty <nj.shetty@samsung.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
> ---
>  drivers/nvme/host/core.c | 31 ++++++++++++++++++++++++++++++-
>  drivers/nvme/host/nvme.h |  1 +
>  2 files changed, 31 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index f25e03ff03df..52331a14bce1 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -672,6 +672,7 @@ static void nvme_free_ns_head(struct kref *ref)
>         ida_free(&head->subsys->ns_ida, head->instance);
>         cleanup_srcu_struct(&head->srcu);
>         nvme_put_subsystem(head->subsys);
> +       kfree(head->plids);
>         kfree(head);
>  }
>
> @@ -995,6 +996,18 @@ static inline blk_status_t nvme_setup_rw(struct nvme=
_ns *ns,
>         if (req->cmd_flags & REQ_RAHEAD)
>                 dsmgmt |=3D NVME_RW_DSM_FREQ_PREFETCH;
>
> +       if (op =3D=3D nvme_cmd_write && ns->head->nr_plids) {
> +               u16 write_stream =3D req->bio->bi_write_stream;
> +
> +               if (WARN_ON_ONCE(write_stream > ns->head->nr_plids))
> +                       return BLK_STS_INVAL;
> +
> +               if (write_stream) {
> +                       dsmgmt |=3D ns->head->plids[write_stream - 1] << =
16;
> +                       control |=3D NVME_RW_DTYPE_DPLCMT;
> +               }
> +       }
> +
>         if (req->cmd_flags & REQ_ATOMIC && !nvme_valid_atomic_write(req))
>                 return BLK_STS_INVAL;
>
> @@ -2240,7 +2253,7 @@ static int nvme_query_fdp_info(struct nvme_ns *ns, =
struct nvme_ns_info *info)
>         struct nvme_fdp_config fdp;
>         struct nvme_command c =3D {};
>         size_t size;
> -       int ret;
> +       int i, ret;
>
>         /*
>          * The FDP configuration is static for the lifetime of the namesp=
ace,
> @@ -2280,6 +2293,22 @@ static int nvme_query_fdp_info(struct nvme_ns *ns,=
 struct nvme_ns_info *info)
>         }
>
>         head->nr_plids =3D le16_to_cpu(ruhs->nruhsd);
> +       if (!head->nr_plids)
> +               goto free;
> +
> +       head->plids =3D kcalloc(head->nr_plids, sizeof(head->plids),
> +                             GFP_KERNEL);

Should this be sizeof(*head->plids)?

Best,
Caleb

> +       if (!head->plids) {
> +               dev_warn(ctrl->device,
> +                        "failed to allocate %u FDP placement IDs\n",
> +                        head->nr_plids);
> +               head->nr_plids =3D 0;
> +               ret =3D -ENOMEM;
> +               goto free;
> +       }
> +
> +       for (i =3D 0; i < head->nr_plids; i++)
> +               head->plids[i] =3D le16_to_cpu(ruhs->ruhsd[i].pid);
>  free:
>         kfree(ruhs);
>         return ret;
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 3e14daa4ed3e..7aad581271c7 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -498,6 +498,7 @@ struct nvme_ns_head {
>         struct gendisk          *disk;
>
>         u16                     nr_plids;
> +       u16                     *plids;
>  #ifdef CONFIG_NVME_MULTIPATH
>         struct bio_list         requeue_list;
>         spinlock_t              requeue_lock;
> --
> 2.25.1
>
>

