Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72E89D116EA
	for <linux-nvme@archiver.kernel.org>; Sat, 29 Nov 2025 02:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4Salk+Bq7Bto6CaKtKUn0rvQi1HOfk6akFnXhArcYZw=; b=MiburEYBZ++P8jauAr/klFAHlf
	MWBw3xvvleEuO1v9F+CPCwSbhr8Cb6kDp2UA+j4cZcCs5S9N/xj7YLCg3BNTfLyv3EjRy+1PX+1/t
	pfrpj6AD/BpJ+Zq2Aly2XaJf20vne3HaLHz00JApSW7B2w0PMpIyIGdlHy8kEnESGdm/Oqc03sCAx
	JbmnvWNo6THa+zEEqHnxsVwQACA8xQaq/sjrrpJpmlTAfUQjuEwq9nSd5nReFtbpEBqzzvuG3E0YF
	VTqGrKb89Wp5FHeEAbFDrOyvNws30Hh8mK4ZsLtVmxxc8X+WPaHJFt/qv9kNmJ8HBfbPOgm2akN2I
	odVuyVbw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vPAly-00000001BQw-1Uq5;
	Sat, 29 Nov 2025 02:33:18 +0000
Received: from mail-qt1-x832.google.com ([2607:f8b0:4864:20::832])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vPAlv-00000001BQY-2y4R
	for linux-nvme@lists.infradead.org;
	Sat, 29 Nov 2025 02:33:16 +0000
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-4ed82ee9e57so31780571cf.0
        for <linux-nvme@lists.infradead.org>; Fri, 28 Nov 2025 18:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764383594; x=1764988394; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Salk+Bq7Bto6CaKtKUn0rvQi1HOfk6akFnXhArcYZw=;
        b=CZnGbNgPIWOVZXPYWFclndNNA2g//qhj3j6k3wchEQexN9X/eazImTvT2idLW4xvw9
         irhq231WIGPV3bO5rcmq1Kgr0VTilWpu5MVM74OMsMXhvjTaTMpcT37kteDLlJDSyGeY
         JSrqKzC+q9riBHF84oufPao3JUmxiSp251k1GYxpZWgCbebacUPg5Ij0aQrL+lSdIP1V
         c8YKQdExNb2nWo0lKdtKX7uiU3A7FfCc6qWMObnQHHj5yuKZRMjgjr5IG3HLHzfpepJQ
         FXXl460+TkcCCMicOBGWK2HbpBFq5rudmgNPkxEICFEa0eDvMIroj0YZJg/iYye91j5d
         x+1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764383594; x=1764988394;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4Salk+Bq7Bto6CaKtKUn0rvQi1HOfk6akFnXhArcYZw=;
        b=h75b8jqSfzXyrx9mM3miQb8YcGyh4n3kxWdpr7hHqE6S6WOrf/UpTs0279mJKFZEgn
         vmH4OVsYzdfforaL0ORk0ERdY1AtP1yGfJYqs+H6TAO73G1HaZQNrwplTbqsPxl9LO04
         vW8SzkC7XXh7i+XZS7R0kjDvD/KsvhTxx/lMlYicWyI7gUfFkkQIHdrnzVkfAmdjA1B8
         9NT+pj+BrheNr3eRl8lqCN0z4rw+2H2k0rCNHSUOT6MpKqlT8HinK8T3KuXG4j8qog9E
         vOynU8Ky9W0j0xAmlYcZJf2+1/h3zUZXPQXGtEQnnwvuXpjfccjd3MyBpPk8D2GoUEB8
         Z+Pg==
X-Forwarded-Encrypted: i=1; AJvYcCWhonYg/LyE9dlNnZAbyBZNCOsR4cy8CoKzmYIXOHuwI1vM5x+07GB6biBTNmXwz3dJRA3y15UjdBao@lists.infradead.org
X-Gm-Message-State: AOJu0Yxz7tCeYC90p1Ylr8qaKnBJxE6udVI3E1uk63Z2RwmQVeSKAGoF
	K/m7ju+y0LQZ9LEh/pJ2Wo18qWYWeH/FWo/O6rd7oPzQfdDGRBzr6Dd8PKN1VParqLGaeDoLBnS
	YCy4NTtFlcN4i0sjd27yYSQ5WeYnlYgo=
X-Gm-Gg: ASbGnctCoTM/F+1TvDiXkDSm3bV6apjm2hjlqUI3EJtByBH5MgePYuKxIMybt/glTD6
	NfBiOBC/YwHHY+8hm5X0ENkjvAEjBn71hfoNh1uvNZg4mPv8eRhR3hA29sb5UWv2Bn9dzB64z46
	nokpE9GbGDsm/TQijCe297ImjVB5Z7h7iG1HtdOPxNZ3t8pNPRfW84ppjYcSIlQp0FaFS9v5MwK
	1gDtBSkPbKNsrKw3dejQbOSsx33d9uZBdGcVHjG7g6NWJPS4rS0ERBwx0bc6zC5Nc2n9g==
X-Google-Smtp-Source: AGHT+IFPyQ3Ox8QMkCC+AFAT7oHRFHqyjDP2jn77IYnsfuFY8QOZCQOTUo4k7dkGxBUwkR6gi0usD4185jOYTHNWGHI=
X-Received: by 2002:ac8:7f47:0:b0:4ee:14c3:4e6e with SMTP id
 d75a77b69052e-4ee58a44b9cmr406211541cf.2.1764383594116; Fri, 28 Nov 2025
 18:33:14 -0800 (PST)
MIME-Version: 1.0
References: <20251128083219.2332407-1-zhangshida@kylinos.cn>
 <20251128083219.2332407-3-zhangshida@kylinos.cn> <CADUfDZqBYdygou9BSgpC+Mg+6+vaE2q-K=i1WJB1+KAeBkS1dg@mail.gmail.com>
 <CANubcdUmUJKeabgagPTWhBd42vzOqx9oxG23FefFJVCcVa_t5A@mail.gmail.com>
In-Reply-To: <CANubcdUmUJKeabgagPTWhBd42vzOqx9oxG23FefFJVCcVa_t5A@mail.gmail.com>
From: Stephen Zhang <starzhangzsd@gmail.com>
Date: Sat, 29 Nov 2025 10:32:38 +0800
X-Gm-Features: AWmQ_bkv6yGPO014px4Ar0BXIBRCkLv-alSslcloxzSsXTYX1dEXbtGPSH-grNc
Message-ID: <CANubcdU2f1+fCL9sYsrwXz-W0dzEsm_+Bds1m3W8=o_sQX30Hw@mail.gmail.com>
Subject: Re: [PATCH v2 02/12] block: prevent race condition on bi_status in __bio_chain_endio
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Johannes.Thumshirn@wdc.com, hch@infradead.org, gruenba@redhat.com, 
	ming.lei@redhat.com, linux-block@vger.kernel.org, 
	linux-bcache@vger.kernel.org, nvdimm@lists.linux.dev, 
	virtualization@lists.linux.dev, linux-nvme@lists.infradead.org, 
	gfs2@lists.linux.dev, ntfs3@lists.linux.dev, linux-xfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zhangshida@kylinos.cn, 
	Andreas Gruenbacher <agruenba@redhat.com>, Gao Xiang <hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251128_183315_795022_49B522F1 
X-CRM114-Status: GOOD (  23.55  )
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

Stephen Zhang <starzhangzsd@gmail.com> =E4=BA=8E2025=E5=B9=B411=E6=9C=8829=
=E6=97=A5=E5=91=A8=E5=85=AD 09:47=E5=86=99=E9=81=93=EF=BC=9A
>
> Caleb Sander Mateos <csander@purestorage.com> =E4=BA=8E2025=E5=B9=B411=E6=
=9C=8829=E6=97=A5=E5=91=A8=E5=85=AD 03:44=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On Fri, Nov 28, 2025 at 12:34=E2=80=AFAM zhangshida <starzhangzsd@gmail=
.com> wrote:
> > >
> > > From: Shida Zhang <zhangshida@kylinos.cn>
> > >
> > > Andreas point out that multiple completions can race setting
> > > bi_status.
> > >
> > > The check (parent->bi_status) and the subsequent write are not an
> > > atomic operation. The value of parent->bi_status could have changed
> > > between the time you read it for the if check and the time you write
> > > to it. So we use cmpxchg to fix the race, as suggested by Christoph.
> > >
> > > Suggested-by: Andreas Gruenbacher <agruenba@redhat.com>
> > > Suggested-by: Christoph Hellwig <hch@infradead.org>
> > > Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
> > > ---
> > >  block/bio.c | 7 +++++--
> > >  1 file changed, 5 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/block/bio.c b/block/bio.c
> > > index 55c2c1a0020..aa43435c15f 100644
> > > --- a/block/bio.c
> > > +++ b/block/bio.c
> > > @@ -313,9 +313,12 @@ EXPORT_SYMBOL(bio_reset);
> > >  static struct bio *__bio_chain_endio(struct bio *bio)
> > >  {
> > >         struct bio *parent =3D bio->bi_private;
> > > +       blk_status_t *status =3D &parent->bi_status;
> >
> > nit: this variable seems unnecessary, just use &parent->bi_status
> > directly in the one place it's needed?
> >
>
> Thanks, Caleb and Andreas. I will integrate your suggestions to:
>
>       if (!bio->bi_status)
>                cmpxchg(&parent->bi_status, 0, bio->bi_status);
>

Sorry, it should be:
      if (bio->bi_status)
              cmpxchg(&parent->bi_status, 0, bio->bi_status);

Thanks,
Shida

> Thanks,
> Shida
>
> > Best,
> > Caleb
> >
> > > +       blk_status_t new_status =3D bio->bi_status;
> > > +
> > > +       if (new_status !=3D BLK_STS_OK)
> > > +               cmpxchg(status, BLK_STS_OK, new_status);
> > >
> > > -       if (bio->bi_status && !parent->bi_status)
> > > -               parent->bi_status =3D bio->bi_status;
> > >         bio_put(bio);
> > >         return parent;
> > >  }
> > > --
> > > 2.34.1
> > >
> > >

