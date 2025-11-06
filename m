Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41B64CCFA0D
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Nov 2025 03:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tdTVOQ5C6+I6zTXTkQAAntlGv9zzOWGKY2nCqub+/QI=; b=tZywX6MjCtmV8b2BLwFX+/vLRm
	BKU8wlEY9mGpnMQ0z/JCEP08A7zzIv2kezOWxq/2U/L228mBnP6b0YudUeXXG8c3jpzbVo68nXIih
	0Ey8PeAIq2/x5sHrRfnJi3rsQeYLOhBGh3wbljNS/wPgxZ9rhS9jHXgCoX2IXxKyrlIZ/Xz87529z
	xsD8ryYjaHZG7W6JF+JiOvH/fU+5c4zzwuedlPKh9K+vw9s0ydVD5re3vQ+dlSoLXIn9kRVSHhjFN
	zRrSdLx2XczPHQWIUr5V5KHeZ70m+HqamDvWbRTEF0ettxhH2nD3SWhDiq0SmvZFCOeyvajCw4tL+
	7GvmOtQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGqGV-0000000EnWE-0m9H;
	Thu, 06 Nov 2025 03:02:23 +0000
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGqGS-0000000EnVf-0xre
	for linux-nvme@lists.infradead.org;
	Thu, 06 Nov 2025 03:02:21 +0000
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-b70fb7b54cdso78256966b.1
        for <linux-nvme@lists.infradead.org>; Wed, 05 Nov 2025 19:02:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762398138; x=1763002938; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tdTVOQ5C6+I6zTXTkQAAntlGv9zzOWGKY2nCqub+/QI=;
        b=Uq/9wETijs/71nUec+r0jMVV+lgo+7zKTKKoIXe2rw/i3uMB97h5tWhMPmSm5o37Hy
         ZoBHOm3ETj0rY9qOFrpPFpxodj7qvZlkYLMULXw0oN/uSTKzbYXMSKkbjDxWMftWAohv
         Acp7w/ODnI7aTuONvog4RhHhveop8lXNzB9LW0xVSY6gg3x+/QNFKEk1p5/o8KB+9ziE
         UjfMSL0p7k4jahkG2CftwfvTYdGjOjf1+puC5TcAPuEDnusUKyk8fU0mB5r/MLGG0HWm
         BlMwKHav6AN2CGB8RCYrwEJ8+zd617pH/Ruh0rjZJPblKwn3q3BmjBluyLUhc13ow0O1
         2weA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762398138; x=1763002938;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tdTVOQ5C6+I6zTXTkQAAntlGv9zzOWGKY2nCqub+/QI=;
        b=DMYySStmc9zQGh5d+SSJDCKUSkNa6JsCrAn960qMLWTFbbWo3XDB2jzG7YTzg0061b
         EQqoPjQjj7HBZTUBDM7ZVjd8YB6zMfxd17IXcFAFkbn36MeZiWty75sfU7aWdnHjZRqV
         k6W/FDFD63loVaQsPYJfMuQTiOZBjwdRTSYK+Xi9fCbK4CEvkKzChpEQfiggXJW0RPK0
         nRBkYFsy69gVOFubs0t2U89NZfvdptUZ4QZYYDcDvw7M6cST2geOHEqYFYhH/DxVfqt/
         KFQjK05LLiczWp7hFoB/bc/ZoLAf4P6wBwItDWU/mZT0hKlr4ci7L8DTzGD18VnOqXay
         OMPA==
X-Forwarded-Encrypted: i=1; AJvYcCUtB+EENZf9kvyha8Mv1xpahGcnSN68sT2OxC7yVfRpErhls7Cqcvqb5Je7AX9WxuSx20BWhtRzbOmO@lists.infradead.org
X-Gm-Message-State: AOJu0YxqR7RkLqiR2KKmagkXo2trnb2ZgeTsci83EUnxXOvWkKPbN2FS
	xKR3OJQNhe9qa2itzIoVTvKxrjl1SrRnMKktx00mfcMkcE2e35RxilQNLeZThQ+6nAQ96DTC+5l
	oY6gwef60zDAMCD/mUlu8d5oIVRAtG2Y=
X-Gm-Gg: ASbGncuS6rEMBPYwh+54PT1ZzVxlLTCbn/xH/kNR2UWdlMFvhw0gDi8YIsQ6hX99qtA
	glpy95MNEOw8czH0OUvYbFvsc3xTuae8BxzTpgdMUCZj8XBhLXobYbDsuasWFQbOuXoVLrlNtu7
	NsmrsclVryCObbSJkkA3xYsDDTGfzGgOcnk7PSzG/qcI9Pv8KmNIhNPCEaZ3VNCd9MP9F9mxMtz
	6w+tvYIZSw7+gxZRQ6V/egMOlcV8M6VH5Kk5m1Og5ruYRw3W8tShGEuFaZBsOnNO/nArLqPYG4d
	PWnI6NdS87A4puc=
X-Google-Smtp-Source: AGHT+IEj9m5ZkaxmPEyaM29/PZON51jtee+49+ZR5dFaEI08ZZsdq2jvMbQ+D4eQUShG1eHFYMyFG9ITbmJGz6KZXw0=
X-Received: by 2002:a17:907:7284:b0:b72:6383:4c57 with SMTP id
 a640c23a62f3a-b7265688425mr496965366b.55.1762398138199; Wed, 05 Nov 2025
 19:02:18 -0800 (PST)
MIME-Version: 1.0
References: <20251104231414.1150771-1-alistair.francis@wdc.com> <20251105132023.GC19044@lst.de>
In-Reply-To: <20251105132023.GC19044@lst.de>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 6 Nov 2025 13:01:51 +1000
X-Gm-Features: AWmQ_blU2RdEZd9t9U93QfcNDb_wTd4nmog6RFwVnxgAE9dHZ0GjWIC6Zcaxd-0
Message-ID: <CAKmqyKOuR4jyJyY3ypqMMbghBioG3u3xECJnsmM_sRtcOeeaug@mail.gmail.com>
Subject: Re: [PATCH v2] nvmet-auth: update sc_c in target host hash calculation
To: Christoph Hellwig <hch@lst.de>
Cc: hare@suse.de, kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me, 
	kch@nvidia.com, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251105_190220_290290_6E878428 
X-CRM114-Status: GOOD (  19.85  )
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

On Wed, Nov 5, 2025 at 11:20=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> >  4 files changed, 6 insertions(+), 2 deletions(-)
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
>
> I'm really confused about both the existing code and this fixup.

Mostly just to keep the original style from the fixes commit from the host =
code.
7e091add9c43 ("nvme-auth: update sc_c in host response")

>
> Why isn't chap->sc_c directly passed to crypto_shash_update here?
> Why do we need to memset buf when only a single byte is passed to
> crypto_shash_update?
>
> >       ret =3D crypto_shash_update(shash, buf, 2);
> >       if (ret)
> >               goto out;
> > -     *buf =3D sc_c;
> > +     *buf =3D req->sq->sc_c;
> >       ret =3D crypto_shash_update(shash, buf, 1);
>
> Just pass it directly here?

We can directly pass it. The rest of the code is copying data into
`buf` so I went with that way as it matches the existing code. I feel
it also makes it clear that it's just a const input and we aren't
editing it in crypto_shash_update().

>
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
>
> just have a
>
>         sttic const u8 zero =3D 0;
>
> and use that here instead of the memset?

We don't actually need this memset at all, it's a mistake from my
rebase, I'll drop it.

Do you still want me to just directly pass req->sq->sc_c in?

Alistair

