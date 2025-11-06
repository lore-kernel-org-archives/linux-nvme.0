Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68ACFCCFA13
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Nov 2025 23:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZOUOWyN3SQvZiS/RbaKwiZi9YRB0sBMbqUhJ8OtdPmE=; b=N7ts9wiidj8462yvR75Uojzvdx
	HLMLpi8mHpi4rE/xvDgjDkF3HHbbStHxkgH1nlWEWC/fI9FG5DQRsVM8zMFK3AhOJLFchXhek8piA
	YDLc/XZrJHDoHk7T3kz6O6AJB3OfPNIiuKSM6NNbYeAXlDFjOd8z1f3snFHtp9O3gAkE2tcT+wCDc
	2nJvWlXwQ6xsTOZLokUzMYENbnndadIysJTal6LHixTotsd7hrezp5YLlNrcGDY0FCxAwSMNbHDhb
	A30zmRzvdn7nBucwq/IJtpyac0t/QKOafuZDLnIGRzhre5Rcms21GIPWcIKIuxcwpJVVllTAayreD
	3kwOlh9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vH9FS-0000000GMLA-30EX;
	Thu, 06 Nov 2025 23:18:34 +0000
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vH9FR-0000000GMKe-05TE
	for linux-nvme@lists.infradead.org;
	Thu, 06 Nov 2025 23:18:34 +0000
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-64080ccf749so281102a12.2
        for <linux-nvme@lists.infradead.org>; Thu, 06 Nov 2025 15:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762471111; x=1763075911; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZOUOWyN3SQvZiS/RbaKwiZi9YRB0sBMbqUhJ8OtdPmE=;
        b=nU00LbYPK4C5BbGEotllvBycMxeRtpFqXR4ml3uyWlYYQ0+tKdWxJKj55h9NLA5Y4b
         X7G986v14mE5jQyAAKtC1zmARb3Ob8CIEnTwiIIseuwR9CbNdIb6m9nAWK4brWE/TTLL
         c4MUFru5Fj0onrP8oEeeX2MYl8A0pRpScPmMWVIPGguaROy3E9O8RaAnECJ5b4odz9z7
         3+51+XyB/FT0f/bIZb1yXEs7EPwAcfeAxfMI5H4L7eshOJV1qz5mq3VOHVqddP+ugu9r
         UmFGMW0JDySj0cLrfndmomZZJaJZkl8tjeo3nNJb/zNUKgreZEz/28UeM49Ac3MpU91J
         qrZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762471111; x=1763075911;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZOUOWyN3SQvZiS/RbaKwiZi9YRB0sBMbqUhJ8OtdPmE=;
        b=Q7gm1G2pIBjtz5hBpkwgwSHS9rtiCFDolMgNZO32fX5OVD1izm8OPDnKqKV4I4Eh9y
         r0M/tVRy92DcrS05ULA0stw9SLGtlrQXraGMf+YT00snNsiPzMD0L2lQ8W9uOw25mvlv
         3nCATvpgjbrz5GYRMsMORaN3YfWgEYv5OOUU9y8AI80RbSPmfCkbsaZO8hgaKxeuIvRn
         RPun2K5Z+Ezj/lCo3KFY88D4U6M5XQVl4ALVzHFcMJr3/5HD5BepfoRXahjjgBsV2c+O
         Vg1U+MizhqlTEDWKfYySL0tpO7rS1h+bgk/nqAbXuHVVl24YeRHRszOSS4E/M8i6Ulbh
         Y7yw==
X-Forwarded-Encrypted: i=1; AJvYcCXGYuKEnUxmYrYcBtmLETzToF/Cd6zu9kyc/ukY1yL2yxmeTvLxGdhVfPvSOEj0h/xe5l3nG/ZXnISq@lists.infradead.org
X-Gm-Message-State: AOJu0YyXSbhhU6rMD+NHgvuFTPBW667/tIyi7eB1fBuwVZVFqMhbs3/W
	aFxcdEI6xdv1dtvxV6siugLyCJb0oS3Mi9WJd00yKj0v3NO6JhQUcT8sLk/pjspLFbz6d7rjGcR
	9+qg/B8dmg2JWXJUkNXAs7d8mPCCtsa+KXA==
X-Gm-Gg: ASbGncvHovTAkPmtd8bYRYXTb7cxb+m8AvpnLEN+YmZBaX7AhXTFWlNIyinPqWpa2/r
	HXAlOTow1nlpT8ioyfUrF5m9ReX/6II39lFpvAYe0QzHhFgdK4ou2KLnGv65qymy/iMxQLq/ouh
	5SIK3ZgqKAOtEHzTLaJOiZFwDW5t3xuaQnnszNmADrnr7Bus6kfTdQLy1Z9LXHM8ex1urGJ+/5F
	JzLvW7pmImTvGNlJqkD2ydY0qjiTCSfocVYvU96n93IsgvpAw4J7PVjDKinYyEcvPiNgGDYoOgf
	1X8D5iF5KWIEBHU=
X-Google-Smtp-Source: AGHT+IFQ3p9ssmPv8Jm7gFsQL6RL6oReE2y+7vSXZxGI2qjE3DMYEWlLAqv+wQJCw4Kqxr8DuM1E/gWRvm7feQCSeeI=
X-Received: by 2002:a17:907:6e94:b0:b72:6fec:5d0e with SMTP id
 a640c23a62f3a-b72c08dca97mr94592666b.13.1762471111104; Thu, 06 Nov 2025
 15:18:31 -0800 (PST)
MIME-Version: 1.0
References: <20251104231414.1150771-1-alistair.francis@wdc.com> <adba53a05329dc8399c3bd49c7bcd5eff5e69574.camel@gmail.com>
In-Reply-To: <adba53a05329dc8399c3bd49c7bcd5eff5e69574.camel@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 7 Nov 2025 09:18:04 +1000
X-Gm-Features: AWmQ_bm5LInA_pSlrz_9pdkVaeGS-Cw3yi_cxhx174Xg7NOZ-pKujDIKCUNvg0k
Message-ID: <CAKmqyKOMFdKqcYN1Nuz224nczaQMmXhk=H6Vx6n+XLRpeVQdNA@mail.gmail.com>
Subject: Re: [PATCH v2] nvmet-auth: update sc_c in target host hash calculation
To: Martin George <martinus.gpy@gmail.com>
Cc: hare@suse.de, kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, 
	sagi@grimberg.me, kch@nvidia.com, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251106_151833_081542_16E4DAD7 
X-CRM114-Status: GOOD (  28.85  )
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

On Thu, Nov 6, 2025 at 11:05=E2=80=AFPM Martin George <martinus.gpy@gmail.c=
om> wrote:
>
> On Wed, 2025-11-05 at 09:14 +1000, alistair23@gmail.com wrote:
> > From: Alistair Francis <alistair.francis@wdc.com>
> >
> > Commit 7e091add9c43 "nvme-auth: update sc_c in host response" added
> > the sc_c variable to the dhchap queue context structure which is
> > appropriately set during negotiate and then used in the host
> > response.
> >
> > This breaks secure concat connections with a Linux target as the
> > target
> > code wasn't updated at the same time. This patch fixes this by adding
> > a
> > new sc_c variable to the host hash calculations.
> >
> > Fixes: 7e091add9c43 ("nvme-auth: update sc_c in host response")
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > ---
> > v2:
> >  - Rebase on v6.18-rc4
> >  - Add Fixes tag
> >
> >  drivers/nvme/host/auth.c               | 1 +
> >  drivers/nvme/target/auth.c             | 5 +++--
> >  drivers/nvme/target/fabrics-cmd-auth.c | 1 +
> >  drivers/nvme/target/nvmet.h            | 1 +
> >  4 files changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
> > index a01178caf15b..19980122d3d5 100644
> > --- a/drivers/nvme/host/auth.c
> > +++ b/drivers/nvme/host/auth.c
> > @@ -492,6 +492,7 @@ static int
> > nvme_auth_dhchap_setup_host_response(struct nvme_ctrl *ctrl,
> >       ret =3D crypto_shash_update(shash, buf, 2);
> >       if (ret)
> >               goto out;
> > +     memset(buf, 0, sizeof(buf));
> >       *buf =3D chap->sc_c;
> >       ret =3D crypto_shash_update(shash, buf, 1);
> >       if (ret)
>
> This memset in host/auth.c doesn't seem to serve any purpose. Also
> given your patch is intended to modify the target behavior for sc_c
> handling, maybe you should restrict the patch to target side updates
> alone.
>
> All the memset cleanup in both the host/auth.c & target/auth.c should
> ideally be done in a separate patch, and not part of this current
> patch.

Yeah, I realised I don't actually need any of them. They have been removed =
in v3

>
> > diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
> > index 02c23998e13c..f54a1425262d 100644
> > --- a/drivers/nvme/target/auth.c
> > +++ b/drivers/nvme/target/auth.c
> > @@ -298,7 +298,7 @@ int nvmet_auth_host_hash(struct nvmet_req *req,
> > u8 *response,
> >       const char *hash_name;
> >       u8 *challenge =3D req->sq->dhchap_c1;
> >       struct nvme_dhchap_key *transformed_key;
> > -     u8 buf[4], sc_c =3D ctrl->concat ? 1 : 0;
> > +     u8 buf[4];
> >       int ret;
> >
> >       hash_name =3D nvme_auth_hmac_name(ctrl->shash_id);
> > @@ -367,7 +367,7 @@ int nvmet_auth_host_hash(struct nvmet_req *req,
> > u8 *response,
> >       ret =3D crypto_shash_update(shash, buf, 2);
> >       if (ret)
> >               goto out;
> > -     *buf =3D sc_c;
> > +     *buf =3D req->sq->sc_c;
> >       ret =3D crypto_shash_update(shash, buf, 1);
> >       if (ret)
> >               goto out;
> > @@ -378,6 +378,7 @@ int nvmet_auth_host_hash(struct nvmet_req *req,
> > u8 *response,
> >       ret =3D crypto_shash_update(shash, ctrl->hostnqn, strlen(ctrl-
> > >hostnqn));
> >       if (ret)
> >               goto out;
> > +     memset(buf, 0, sizeof(buf));
> >       ret =3D crypto_shash_update(shash, buf, 1);
> >       if (ret)
> >               goto out;
> > diff --git a/drivers/nvme/target/fabrics-cmd-auth.c
> > b/drivers/nvme/target/fabrics-cmd-auth.c
> > index 5d7d913927d8..16894302ebe1 100644
> > --- a/drivers/nvme/target/fabrics-cmd-auth.c
> > +++ b/drivers/nvme/target/fabrics-cmd-auth.c
> > @@ -43,6 +43,7 @@ static u8 nvmet_auth_negotiate(struct nvmet_req
> > *req, void *d)
> >                data->auth_protocol[0].dhchap.halen,
> >                data->auth_protocol[0].dhchap.dhlen);
> >       req->sq->dhchap_tid =3D le16_to_cpu(data->t_id);
> > +     req->sq->sc_c =3D le16_to_cpu(data->sc_c);
>
> Given sc_c is an unsigned 8bit int, is there really a need to make this
> endian safe by calling le16_to_cpu()?

No, it's not required. Fixed in v3.

Alistair

>
> -Martin
>

