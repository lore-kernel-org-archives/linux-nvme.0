Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 574CACD3445
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Nov 2025 02:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=t65DqIpLR2XJc52MvkU8Zhi1oYYMgA74171ikGaz3IA=; b=K8MSE/3DgnVXEMgo3i4Oz6I8e+
	9UD3QEF2QfuoaXWvoUHPtWsWxEo6WAY8+NNludaW9mvg2AJragVsk2zsXPu3GZL8EMDdEz7rQCaMF
	yW4F3dSB9fSbwvBLqlMxJ0SIh1qLb7ZQ73F24sJO7QfWZOrRwJd9hrvRB+ybzzbdXGIkcD6XXNOFk
	DHazpg0DP/QHfKmtrf5t0eNgzebOk8BIqcJqJsLKr+Z4C85pTO5zDHcDWx8UiCCOtjawinr7NRsRS
	90aBDg4if28GLDdBgaIEkL80n/6ZE/bL8cuOhhkLFQPWOHBg90dec9Pf2eJgWszpH7JQOLKUKPZBY
	/oZItRag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJMlS-00000009mgu-0Uc8;
	Thu, 13 Nov 2025 02:08:46 +0000
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJMlP-00000009mgT-1FuJ
	for linux-nvme@lists.infradead.org;
	Thu, 13 Nov 2025 02:08:44 +0000
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-b728a43e410so40229066b.1
        for <linux-nvme@lists.infradead.org>; Wed, 12 Nov 2025 18:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762999721; x=1763604521; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t65DqIpLR2XJc52MvkU8Zhi1oYYMgA74171ikGaz3IA=;
        b=WL2fjUJc3voSxyaC1HGDtzWJC1WwjGyEwcOFMZNUSzmpvxbb/ifBtjZ01csS661rYS
         S08gN4eXAA6L/amg7UOTedULKALL+lEBxS8tlbl5XrC0fGu9iVkby3OUYXYMlaORotb1
         E5Q+JcE40nYvkkgWZ21kJGaPQr1OyLoR139Q2yuCxHFXMcnpjAzivU521RRduMw8+6mI
         rlSKHrmzZRTcUkwxvYaCSJXN0Ls49b8pY3ebdlngUMOO3fGHBXfKb7BAm3ugU+DN0LSc
         e0iAHQvJrA+lxtfqfTnS1mUqqGAMnWdgsmCzVOYX4wZJCBEDVV0sZydUkNNx8zztpCex
         SFwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762999721; x=1763604521;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t65DqIpLR2XJc52MvkU8Zhi1oYYMgA74171ikGaz3IA=;
        b=RH/vtWg03ZB0k9+UKK+A229rPhQBi3JTbZaWGn9RdQiH1Im5Hurb+LSt1qL7kEsPBW
         wXPoOGmw8pQganOB/DurP+BH+F36M0RQCVoebo1IfvT2lMmkwBbmdGAg9DtmW3ZwCPG+
         sLUG27SGz0ElwElNOR6IojPkxiryxw3QT3ZvHds2zCM8gFaBEFqjVK2kMyBMR5laNg/e
         Kcaq3sLmuKIcL1Ibu/oLwrZsNtAua7ozEFTfHHGk8EbkBYQ1qE1jYKS9tBV+1K5SrAd/
         gzyETov8VrONxPDn24dZodXnOTgr42M7K2B2tprw61H0p4ThIBQS1fEWXVS1qthFEcBe
         fYKg==
X-Forwarded-Encrypted: i=1; AJvYcCUZuFqwuhSoTXq+hgzMby9WE1XIhv81qZUY0d3ZAwEsOwIaqf1if3fw8cgU187JaPQNwm6iLm2uWGRC@lists.infradead.org
X-Gm-Message-State: AOJu0YwJB0fwWuLZImH28QTq42uR2i951G6XnwZlUg+HKr2U2VMLtKw0
	Jf/uKTuiBo+IB9o5sEhWvCNHM8e918Xa6YOe39OhJcGoEVuwP9NTFjHFKADBhCZajKmAaQTkSAF
	OlEX95Yl7BGhFKPfRNQiezAeClmcGe+c=
X-Gm-Gg: ASbGnctZbjNEvPy+dI6NSaby2M9NpNWrwQXSN9pA/1yFXbZWkZ578HVhApY3I6uQkxH
	HFCXZZDG6H44EEcQTEnljzKDwHVT6ub6K/KpF9niogxb/pgobi79D+r5cNefGEKH65ak2v+MlNQ
	dbV1kdBruMbTsBFrP1k0Pqw4iFD5Yx874BqXCfhkMhS+0zd+/c8mhlsSQ4FvH3YT2kf0ICjBKSb
	ieuGsX0oahN29LHtoN3z1cW2VZLGdTHhInDXh0tVuqZTqZN32eWKdKrBvqs3W9e+tZA92UT5W63
	sxQ25MTfeGJzqmc=
X-Google-Smtp-Source: AGHT+IFyNWhr/4Git6cscpcGTem+aU8tvSmWDpBf45NHHKnDkHzsi0qx1de/+ZvskwSE8Sn5fra35DX3byqBpX8Be5Q=
X-Received: by 2002:a17:906:6a0a:b0:b72:b289:6de3 with SMTP id
 a640c23a62f3a-b7331af6e23mr526654966b.58.1762999720784; Wed, 12 Nov 2025
 18:08:40 -0800 (PST)
MIME-Version: 1.0
References: <20251111234519.3467440-1-alistair.francis@wdc.com>
 <20251111234519.3467440-4-alistair.francis@wdc.com> <caadfcbb-8964-4447-a93d-8e49b4c14c7e@suse.de>
In-Reply-To: <caadfcbb-8964-4447-a93d-8e49b4c14c7e@suse.de>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 13 Nov 2025 12:08:14 +1000
X-Gm-Features: AWmQ_bkFf-G8MuLmGZPhefsEFyG89yAqq4VscB5fW2rNoawjSt9VITO75ff2oo8
Message-ID: <CAKmqyKNzi7OAq49b-aa1H8++ReTvWnHKBDwA88ionJshhOVp9g@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] nvme: Expose the tls_configured sysfs for secure
 concat connections
To: Hannes Reinecke <hare@suse.de>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, 
	kch@nvidia.com, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251112_180843_371949_E51630F3 
X-CRM114-Status: GOOD (  19.24  )
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

On Wed, Nov 12, 2025 at 5:08=E2=80=AFPM Hannes Reinecke <hare@suse.de> wrot=
e:
>
> On 11/12/25 00:45, alistair23@gmail.com wrote:
> > From: Alistair Francis <alistair.francis@wdc.com>
> >
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > ---
> > v2:
> >   - New patch
> >
> >   drivers/nvme/host/sysfs.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
> > index 29430949ce2f..6d10e12136d0 100644
> > --- a/drivers/nvme/host/sysfs.c
> > +++ b/drivers/nvme/host/sysfs.c
> > @@ -838,7 +838,7 @@ static umode_t nvme_tls_attrs_are_visible(struct ko=
bject *kobj,
> >           !ctrl->opts->tls && !ctrl->opts->concat)
> >               return 0;
> >       if (a =3D=3D &dev_attr_tls_configured_key.attr &&
> > -         (!ctrl->opts->tls_key || ctrl->opts->concat))
> > +         !ctrl->opts->concat)
> >               return 0;
> >       if (a =3D=3D &dev_attr_tls_keyring.attr &&
> >           !ctrl->opts->keyring)
>
> ??
>
> How can you have a configured TLS Key for secure concatenation?

I'm not sure I follow

`ctrl->opts->tls_key` is directly set at the end of the
`nvme_auth_secure_concat()` function, so it will be set for secure
concatenation.

> We generate the keys from the DH-CHAP key material, don't we?

I haven't checked that closely, but the key seems to be generated from
the CHAP hash id

Alistair

>
> Cheers,
>
> Hannes
> --
> Dr. Hannes Reinecke                  Kernel Storage Architect
> hare@suse.de                                +49 911 74053 688
> SUSE Software Solutions GmbH, Frankenstr. 146, 90461 N=C3=BCrnberg
> HRB 36809 (AG N=C3=BCrnberg), GF: I. Totev, A. McDonald, W. Knoblich

