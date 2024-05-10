Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A37AC25B75
	for <linux-nvme@archiver.kernel.org>; Fri, 10 May 2024 18:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+2PXq+bIzUymL2/4umrGV5LlclRd9rNx+xV5yojQvxw=; b=0dAcfcDxqme5Be802JRURJqL1z
	NSVwMN9se0eC6DRqbmF2QIamfJoC8pmN3tZI/6d9aHpIHFNRGW7LNKhy9qregfBYFnrtNKhtX8YYK
	yUmhgcx0nTjxCbOOovj1ly9gqP2RTFh4Gwqd4wM1iF/JCDHrM+SrMf+fI5tSBdeH7h1d/C4MUA2V3
	ahrkDLR19Alqo1i5SD+vY97Hsnr1joNepflplOOulk4z67zOWsS5WjDeFcCc8YCeBZcWK/4OhKhdg
	hWuXNTNWkwuIHUxL1knJNSrF4bnyByR4Apo+GcvSqCrLkCW9WTv34OCm43pJQ/GcQe9B1/tWWriqu
	t4fVcEXg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5VDH-00000006Ad7-3USE;
	Fri, 10 May 2024 18:43:23 +0000
Received: from mail-ua1-x929.google.com ([2607:f8b0:4864:20::929])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5VDB-00000006AZz-2Cbd
	for linux-nvme@lists.infradead.org;
	Fri, 10 May 2024 18:43:18 +0000
Received: by mail-ua1-x929.google.com with SMTP id a1e0cc1a2514c-7f7809ae952so563133241.0
        for <linux-nvme@lists.infradead.org>; Fri, 10 May 2024 11:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715366590; x=1715971390; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+2PXq+bIzUymL2/4umrGV5LlclRd9rNx+xV5yojQvxw=;
        b=HiG526aPOVS0fWcX78R9XOPPf8Pth3XaMq4WkwUvuQhF6nsDRA3KArONtuyAm1u5lW
         ajSyiTqJh8nQ1aM76zTHRkKgrV4m/T6vuyaCx9FeItIUHwMZvMZ5yusMcOnN0RgF3kku
         O4dFmsNp6ZObZNKviJzksTlimw4UUwRftzwmBhn6+S/nRmd7TCsUehT0QO+gnz87c8zZ
         4uyXlEP9kOWTbK2vZkU0aa3CwBXHuj7fzazHO0xSsKBJDj8qdjY9rdHXaD5HjjmRjVot
         JJ/MimcgPq4eUuPvPScdhjP0lNYzKuv84ivWXkj69QqrLJby39PfVH+8L6cJg1KuYcYm
         BkDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715366590; x=1715971390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+2PXq+bIzUymL2/4umrGV5LlclRd9rNx+xV5yojQvxw=;
        b=pJ+OcQfeLgmZkiiR4tuTFgbVzUloxwJwDYxxOcaWl6S0EhjaZsaThG/pmpNbLr+l0h
         qafCWNn/vlb5Bbk3DzGwMIXNVD1s9MhoExMw+gDWsbPhQSD87ND5BjiwU0fXIwIDyrbo
         43HGvAAczux/tHr5larJJxc//GOTjp+xSFm2zkT3MnqaX3yRQDC49HTiEwQphRL2hA/q
         p0Yhirlbr1WRENReZy9LEY9xveQ2hbk/ChqecIy9aqgkKtO3MmNDcrPWonkZDg+xted6
         SIAZaHS3QSzHZvbycPsdGSTz8V9EO0tc5cRVUnHWc5gbq4ha/49jpr0u5DVQEw6gXOQS
         GAuA==
X-Forwarded-Encrypted: i=1; AJvYcCXQ6XPLGjpZ4ckDBdaISjIGrkAHGroDgYPDmZB9Yfw9LmKL8QzOoWzP1j7MFsW9JhE0hEAbtODNJRg+W0c/7RrZkoGOQHQ84YSdr+V7wXA=
X-Gm-Message-State: AOJu0YxRiWefcTgjGaYpbWbBNfk7NunqkbkhkGk4wnHWJzeFZhPG/NW7
	q7vGHig26gatAcsYLlox6GzC3KLTycnkWlBLhnFJ4XISoKOmH5koHTwe/XlkLuYv7Efifq7wXvl
	sv35T+oBlqQyp7/u11+j9WlH5Sg==
X-Google-Smtp-Source: AGHT+IEwweXm3f+VrqqIlTVGCBZKVeLCLG0TLyc0fxrDlFxQj/tbsLoTuQ89oNhN2w4m0P2hOANktDi8/YyWUJaxLRc=
X-Received: by 2002:a05:6122:3c47:b0:4c0:24e6:f49d with SMTP id
 71dfb90a1353d-4df8829dbacmr4045538e0c.1.1715366588674; Fri, 10 May 2024
 11:43:08 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20240510095142epcas5p4fde65328020139931417f83ccedbce90@epcas5p4.samsung.com>
 <20240510094429.2489-1-anuj20.g@samsung.com> <6936aab2-a8b1-42a8-a9e5-6df1e212df7f@kernel.dk>
In-Reply-To: <6936aab2-a8b1-42a8-a9e5-6df1e212df7f@kernel.dk>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Sat, 11 May 2024 00:12:31 +0530
Message-ID: <CACzX3AvhZHsT7qAcWNU5pHDraHpfoAyspH3NP0oAdqbrhZ1d-A@mail.gmail.com>
Subject: Re: [PATCH] block: unmap and free user mapped integrity via submitter
To: Jens Axboe <axboe@kernel.dk>
Cc: Anuj Gupta <anuj20.g@samsung.com>, hch@lst.de, kbusch@kernel.org, 
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, 
	martin.petersen@oracle.com, Kanchan Joshi <joshi.k@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240510_114317_605390_62361768 
X-CRM114-Status: GOOD (  15.34  )
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

On Fri, May 10, 2024 at 7:15=E2=80=AFPM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 5/10/24 3:44 AM, Anuj Gupta wrote:
> > +/**
> > + * bio_integrity_unmap_free_user - Unmap and free bio user integrity p=
ayload
> > + * @bio:     bio containing bip to be unmapped and freed
> > + *
> > + * Description: Used to unmap and free the user mapped integrity porti=
on of a
> > + * bio. Submitter attaching the user integrity buffer is responsible f=
or
> > + * unmapping and freeing it during completion.
> > + */
> > +void bio_integrity_unmap_free_user(struct bio *bio)
> > +{
> > +     struct bio_integrity_payload *bip =3D bio_integrity(bio);
> > +     struct bio_set *bs =3D bio->bi_pool;
> > +
> > +     WARN_ON(!(bip->bip_flags & BIP_INTEGRITY_USER));
> > +     bio_integrity_unmap_user(bip);
> > +     __bio_integrity_free(bs, bip);
> > +     bio->bi_integrity =3D NULL;
> > +     bio->bi_opf &=3D ~REQ_INTEGRITY;
> > +}
> > +EXPORT_SYMBOL(bio_integrity_unmap_free_user);
>
> Should this be a
>
>         if (WARN_ON_ONCE(!(bip->bip_flags & BIP_INTEGRITY_USER)))
>                 return;
>
> ?

Right, I will fix this in the next version.

>
> --
> Jens Axboe
>
--
Anuj Gupta

