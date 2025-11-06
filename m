Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E162CCFA0D
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Nov 2025 02:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Tlk/ug0JgPSr2/LEI0WtcL8rXm2ERpWKIu4XhoKULa8=; b=VA5zA/uC33MgtYM2QLOaKbg6sg
	trFqdOGlVElLLgzRJ8NIlfNOVh7MkkSCGYV8+114Ss0yOxQjIyBsKvPuKHVziVocIiqvyp/BLD4uR
	oRKwCuVjVw9+nzw2f2PuLOAdUwtg8v0owcscIhGcGTgnwW5xbAyQyFIE+sIWHO/nDlonZr55HUewf
	ZpBF9JlF1uB/wpBTYDF1czx0cS7vZbXU+GDQfdvMToZN67XTQOMPHDmsRTn03+075Rg/fl6UKMqHb
	/QNrxKFgmHzTIV+clN0TPfIsp/RQJYrBAqlFXWG6WiX/NvssKTuycA959dG1xOuu0GIb+G1BpkjZd
	QEtvJgnw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGq9w-0000000En3Y-0JOo;
	Thu, 06 Nov 2025 02:55:36 +0000
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGq9t-0000000En2z-3dmv
	for linux-nvme@lists.infradead.org;
	Thu, 06 Nov 2025 02:55:35 +0000
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-6408f9cb1dcso713542a12.3
        for <linux-nvme@lists.infradead.org>; Wed, 05 Nov 2025 18:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762397732; x=1763002532; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tlk/ug0JgPSr2/LEI0WtcL8rXm2ERpWKIu4XhoKULa8=;
        b=ZyQkQ/14JFESAd8Qclgmc//BVuDaXN/i4tL0ChDR8DkOLZEk0nSrkS3WJnQafDqmMJ
         J5BK5pLFd5u/3BIF4CjVQeozaufh6vIonVOjRAPb/kz/XHoBt2MuJ2fN2sVrBAz+Kf3G
         obvhnYRjKxGw9UWyWyENsIZRHUwHIxeYCy1C6Be4ZtfhybNg+Q151ll2U2vsF1QWtk7J
         mA8eaq+GYm2ZGAKUn6xW9YEvsEiW7x+eQTtiAUEP49K89qFG7krhTNEbMKUcedCHE43x
         bT5bNLrdNVLQ5eH8nv3w3et/478T+iRW1esbHV4gXGshtKkp0O6Zjdx+hpjbN4rVBjnV
         /JxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762397732; x=1763002532;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tlk/ug0JgPSr2/LEI0WtcL8rXm2ERpWKIu4XhoKULa8=;
        b=ro7OZfZHtIbnUPqJHD8AON+mwyJYXhOmnKJJ8FYuOdqUP+65gTQNjvtQ6TrRVtSOs4
         Wwi2PCenRVAr8zNEopEzbTVJay+hFGRhZ35E23DBqjiVW1Ba95RP9T3tJxvp/Xz4I2+x
         ZGFYfrR0FzTybc+jW4LFHx1tfEt2Qu0lCIXTOIhVm+4+ISD/k4AYhG5nEILFT/8CCSl4
         79oKR9JOsZGvAiKUzOjEsuIHLWXr9GP+8aSZmkkA6S3MSJ1nqDqH+wo1xA0qJJ1UEpm3
         wW5q3+T9b/Gczg5tO1YQdLH6K8usq4CXsUHFmklukAmS965iA1ex4kyiwEjxvX0uhsnv
         Rj/A==
X-Forwarded-Encrypted: i=1; AJvYcCWh+SdBEjSuAxJBmRUMK8hpa1V89YGHjzMb+y2sTgEZhWGyDejLkuUkWR5pjt2FBs/bvuaPgNfIoPGc@lists.infradead.org
X-Gm-Message-State: AOJu0Yx0mPFvRJjwPIR5WvFMr512X8WIPBLMOmOeqYnHZP/bWzO0QNQl
	nih5MFF7TwknYsz0JZTr3lM689mh79c0JLcWJA8ioGewM5Ci8tSPLbvMfT1bwZrPo/5ldA8cY2y
	4spxc/WSYf+f1faCHT3i9n4BHio/WnVY=
X-Gm-Gg: ASbGncsbZVkoLcB8Fd8h5cFOpSmH4CZB16OYhQEC79jfq8yG6ZzEmsQeMpraBwMgu7o
	/HsX/pSw5+IHe0ZHTg5p7hqcEXWUMf7N9opkZnPfNZUjpnq8NIkLjQ+5+55eSwvwGIJE/+gKXi3
	XFM72hgWbESqMlxb0klTHyVqfxBHeuDYQ92q71qH7UQMR8/qPWggUwtDoc1Hrus0YTJvWtQYxMn
	W9cwPRgqbYnsJNF4gWsqHCZ1bIrsRGVFlf11u3M4OwlKGZcViliy4t2JN+gN/9uBdXrnoLuOx/d
	/nRKTQjteYmN51T/EiMoR9VrzA==
X-Google-Smtp-Source: AGHT+IHA+7AGTg05JB1vLt2XrUjagvVvtpOglKMuwX3Og02E6bEEagClfceX/hELr6wRF2qmpna20dsF9kRJoVyrtFY=
X-Received: by 2002:a17:906:f58d:b0:b72:52c2:b8e2 with SMTP id
 a640c23a62f3a-b72653b9b85mr522952966b.26.1762397731465; Wed, 05 Nov 2025
 18:55:31 -0800 (PST)
MIME-Version: 1.0
References: <20251104231414.1150771-1-alistair.francis@wdc.com> <31a4e5f0-43e1-4aed-af84-715aca53fa1b@suse.de>
In-Reply-To: <31a4e5f0-43e1-4aed-af84-715aca53fa1b@suse.de>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 6 Nov 2025 12:55:05 +1000
X-Gm-Features: AWmQ_bm_EKk5XRW7XS4RKJsgEiVgBQB3O8X5XRCIc4C-Nz9KT0_E157CqAjKTng
Message-ID: <CAKmqyKM+ntRgu5ovaWh6c2ffTG2k=_YBTNapBbm2C-BoaNayXw@mail.gmail.com>
Subject: Re: [PATCH v2] nvmet-auth: update sc_c in target host hash calculation
To: Hannes Reinecke <hare@suse.de>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, 
	kch@nvidia.com, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251105_185533_933664_39A09859 
X-CRM114-Status: GOOD (  25.95  )
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

On Wed, Nov 5, 2025 at 5:29=E2=80=AFPM Hannes Reinecke <hare@suse.de> wrote=
:
>
> On 11/5/25 00:14, alistair23@gmail.com wrote:
> > From: Alistair Francis <alistair.francis@wdc.com>
> >
> > Commit 7e091add9c43 "nvme-auth: update sc_c in host response" added
> > the sc_c variable to the dhchap queue context structure which is
> > appropriately set during negotiate and then used in the host response.
> >
> > This breaks secure concat connections with a Linux target as the target
> > code wasn't updated at the same time. This patch fixes this by adding a
> > new sc_c variable to the host hash calculations.
> >
> > Fixes: 7e091add9c43 ("nvme-auth: update sc_c in host response")
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > ---
> > v2:
> >   - Rebase on v6.18-rc4
> >   - Add Fixes tag
> >
> >   drivers/nvme/host/auth.c               | 1 +
> >   drivers/nvme/target/auth.c             | 5 +++--
> >   drivers/nvme/target/fabrics-cmd-auth.c | 1 +
> >   drivers/nvme/target/nvmet.h            | 1 +
> >   4 files changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
> > index a01178caf15b..19980122d3d5 100644
> > --- a/drivers/nvme/host/auth.c
> > +++ b/drivers/nvme/host/auth.c
> > @@ -492,6 +492,7 @@ static int nvme_auth_dhchap_setup_host_response(str=
uct nvme_ctrl *ctrl,
> >       ret =3D crypto_shash_update(shash, buf, 2);
> >       if (ret)
> >               goto out;
> > +     memset(buf, 0, sizeof(buf));
> >       *buf =3D chap->sc_c;
> >       ret =3D crypto_shash_update(shash, buf, 1);
> >       if (ret)
> > diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
> > index 02c23998e13c..f54a1425262d 100644
> > --- a/drivers/nvme/target/auth.c
> > +++ b/drivers/nvme/target/auth.c
> > @@ -298,7 +298,7 @@ int nvmet_auth_host_hash(struct nvmet_req *req, u8 =
*response,
> >       const char *hash_name;
> >       u8 *challenge =3D req->sq->dhchap_c1;
> >       struct nvme_dhchap_key *transformed_key;
> > -     u8 buf[4], sc_c =3D ctrl->concat ? 1 : 0;
> > +     u8 buf[4];
> >       int ret;
> >
> >       hash_name =3D nvme_auth_hmac_name(ctrl->shash_id);
> > @@ -367,7 +367,7 @@ int nvmet_auth_host_hash(struct nvmet_req *req, u8 =
*response,
> >       ret =3D crypto_shash_update(shash, buf, 2);
> >       if (ret)
> >               goto out;
> > -     *buf =3D sc_c;
> > +     *buf =3D req->sq->sc_c;
> >       ret =3D crypto_shash_update(shash, buf, 1);
> >       if (ret)
> >               goto out;
> > @@ -378,6 +378,7 @@ int nvmet_auth_host_hash(struct nvmet_req *req, u8 =
*response,
> >       ret =3D crypto_shash_update(shash, ctrl->hostnqn, strlen(ctrl->ho=
stnqn));
> >       if (ret)
> >               goto out;
> > +     memset(buf, 0, sizeof(buf));
> >       ret =3D crypto_shash_update(shash, buf, 1);
> >       if (ret)
> >               goto out;
> > diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/targ=
et/fabrics-cmd-auth.c
> > index 5d7d913927d8..16894302ebe1 100644
> > --- a/drivers/nvme/target/fabrics-cmd-auth.c
> > +++ b/drivers/nvme/target/fabrics-cmd-auth.c
> > @@ -43,6 +43,7 @@ static u8 nvmet_auth_negotiate(struct nvmet_req *req,=
 void *d)
> >                data->auth_protocol[0].dhchap.halen,
> >                data->auth_protocol[0].dhchap.dhlen);
> >       req->sq->dhchap_tid =3D le16_to_cpu(data->t_id);
> > +     req->sq->sc_c =3D le16_to_cpu(data->sc_c);
> >       if (data->sc_c !=3D NVME_AUTH_SECP_NOSC) {
> >               if (!IS_ENABLED(CONFIG_NVME_TARGET_TCP_TLS))
> >                       return NVME_AUTH_DHCHAP_FAILURE_CONCAT_MISMATCH;
>
> Hmm. Storing 'sc_c' directly does away with the need for the 'concat'
> controller setting.
> Can't we just drop that and use 'sq->sc_c' directly when checking if
> secure concatenation is enabled?

I think we could drop ctrl->concat, but I feel like maybe that should
be a merge window change instead of late in the RC window.

Alistair

>
> > diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
> > index 73da823a91fb..20be2fe43307 100644
> > --- a/drivers/nvme/target/nvmet.h
> > +++ b/drivers/nvme/target/nvmet.h
> > @@ -159,6 +159,7 @@ struct nvmet_sq {
> >       bool                    authenticated;
> >       struct delayed_work     auth_expired_work;
> >       u16                     dhchap_tid;
> > +     u8                      sc_c;
> >       u8                      dhchap_status;
> >       u8                      dhchap_step;
> >       u8                      *dhchap_c1;
> Cheers,Hannes
>
> --
> Dr. Hannes Reinecke                  Kernel Storage Architect
> hare@suse.de                                +49 911 74053 688
> SUSE Software Solutions GmbH, Frankenstr. 146, 90461 N=C3=BCrnberg
> HRB 36809 (AG N=C3=BCrnberg), GF: I. Totev, A. McDonald, W. Knoblich

