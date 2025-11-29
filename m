Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C99B1D116EA
	for <linux-nvme@archiver.kernel.org>; Sat, 29 Nov 2025 01:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gTMvUg1UMZTZ4C3O9OiBQ8cOr6Brx+qDSX2glns7W/k=; b=aiBpRyX674NCviUbZZSgaxJUB0
	ner3U8+FxSmGT0kdSnOuGQAhHTHfomoA56cOZydDFJz8ghFLilTgN4JbQ7u3Vqu5MqDwdQr+k9T3Y
	Rrlnoxs+2quE4/QKS2CFTJtekAeFUERX2EMxyN6ehxXcrUKMbvb9p0FTRT6+k4Tzqd/rTuL3R37u4
	LNGPfmyJiDGzYwTLwd5rGMZhmymF6HeMV3uxpV3GK6taF3a4vqEJRCOZvRivSOOzqb+YpP2z0jJ2A
	JK9pPtemWFovtMiFVFWpLBnBFD6sFqE7bCGpSPsmoZqlKKCXmuPznBlEcm4e9PpsPMSKrkzGtfxCq
	6e8uQCeA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vPA4I-000000019E7-3Mce;
	Sat, 29 Nov 2025 01:48:10 +0000
Received: from mail-qk1-x72d.google.com ([2607:f8b0:4864:20::72d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vPA4F-000000019Dk-3maq
	for linux-nvme@lists.infradead.org;
	Sat, 29 Nov 2025 01:48:09 +0000
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-8a3eac7ca30so143495585a.2
        for <linux-nvme@lists.infradead.org>; Fri, 28 Nov 2025 17:48:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764380886; x=1764985686; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gTMvUg1UMZTZ4C3O9OiBQ8cOr6Brx+qDSX2glns7W/k=;
        b=AZzrJW34lSP+iS8ImEiQyNzzTQZy/z5ib2bzUUyhPyOOXFvxb55s4Byty41a3WRNZ7
         XNT6mBktHFiY9jzW1G01YXbKRStp3xwv9G0TvNXEbzHiAjJ5r3xHiCUv0wLeCZQiLPdd
         e9O13NfpvCdKSedNb+apKmqJkvNk++qr3zAnFw49kXWJMq2HoHgfDrArEXgT8IZL0Q/q
         PlevYVsWeAgI2ON93+cYlXN6MGUe5VGOilo1wZasGhndgWr5TjAHt/Piny2q1/6dnTFz
         WSWkk295u1IVUleFfkxfoUBDzSu5PNXwYh+2NgMiB27dgUh3uVkHiToX79ghheMe3rWz
         he2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764380886; x=1764985686;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gTMvUg1UMZTZ4C3O9OiBQ8cOr6Brx+qDSX2glns7W/k=;
        b=qSziMkubmCYwMOXNzFsM+obWFeL5TcSygVV7zPkrqfwKNuurAAGtpY8nKOuJW/nda5
         exSFg/tz+e3o40nMffOsfJb+/bOBQ0N2hOaJUWI2of4Ek6UPmiDhXJLkONvTi4jXXU81
         fowzQbW997PR3o1+d3+TO0kURaA2DB+xWseYz7/3VPhcE5kJXJDBUoitaxz4BV+BVhL3
         bbr+/leLQ0QjhzCDL4HKu94mv8ZMww5EESi7/ky5Zl8fGmELfnMRBB+co9+Aw4VY49rd
         D62dbKI4A58CESuU0XrTLo6EHtdzMmgBv+A+i0YUbjQEaZJK/ARNdEVrFW7eNyxosIk+
         HbGw==
X-Forwarded-Encrypted: i=1; AJvYcCVp3WmAeeDFhnx6PNKfA56l69rgHjcXggic2HCHwXNPuS96lHEwXyc6zTyBEO36eMODY7egkoytNmnc@lists.infradead.org
X-Gm-Message-State: AOJu0Ywn92s2C7/qsZteOOTHRGKx+sWVQtLSBjEY7/hsGdPKdnzSWU8+
	SXcbcE+afyLSaREub2cqJNeacDwqB9HfwDfjfO0d8IC4V7aQN3Jlp+SupmG4o42DEx4pObPJDnY
	mYrHphLfpJoHpYABPn1Of4wNEcZefvEU=
X-Gm-Gg: ASbGnct69Kgl3q50+XxkRxfqJQ+EvZBzbSB7z6bfPCcqAFcU+zoF866eDxxNHAY9Wc0
	gGbg9IbE1XwpuwCsAF/C3HnQiKGwoGbOanfAP6VHDx35cx7RR6J4pSGNrLBJqji+7cbqD9WMXGP
	WGCUm8dik097q89vfWWfDk+fUNzVpdaUE5LzXrGjEjR1ZAKQd61+IspZmdrS59E2jWA8KmsQ1FW
	Yuoy5vv59M90j/Z2MBcUR50YJmIBR+DbLc1oM9L4lbWuHWD22klCViDU4IMOesQsBANM0IS0Qpb
	rXEB
X-Google-Smtp-Source: AGHT+IF8UylZfxilGeMhsr8XVt5PLAPqSaRXTvsYHaw6wpySxcukJ+AHM3ybyVlNv3V0Obv4Zo5rqIkfGVVhf2kHlvM=
X-Received: by 2002:a05:622a:1489:b0:4ed:afd0:c5ea with SMTP id
 d75a77b69052e-4efbd8f5186mr241469781cf.31.1764380886123; Fri, 28 Nov 2025
 17:48:06 -0800 (PST)
MIME-Version: 1.0
References: <20251128083219.2332407-1-zhangshida@kylinos.cn>
 <20251128083219.2332407-3-zhangshida@kylinos.cn> <CADUfDZqBYdygou9BSgpC+Mg+6+vaE2q-K=i1WJB1+KAeBkS1dg@mail.gmail.com>
In-Reply-To: <CADUfDZqBYdygou9BSgpC+Mg+6+vaE2q-K=i1WJB1+KAeBkS1dg@mail.gmail.com>
From: Stephen Zhang <starzhangzsd@gmail.com>
Date: Sat, 29 Nov 2025 09:47:30 +0800
X-Gm-Features: AWmQ_bnN3cSo6zqXXCSLK6iMVHLbQkMYnCeHd1k_eisM5wRG4bYg-EFq2EOhH5Y
Message-ID: <CANubcdUmUJKeabgagPTWhBd42vzOqx9oxG23FefFJVCcVa_t5A@mail.gmail.com>
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
X-CRM114-CacheID: sfid-20251128_174807_953412_73607E3B 
X-CRM114-Status: GOOD (  21.57  )
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

Caleb Sander Mateos <csander@purestorage.com> =E4=BA=8E2025=E5=B9=B411=E6=
=9C=8829=E6=97=A5=E5=91=A8=E5=85=AD 03:44=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri, Nov 28, 2025 at 12:34=E2=80=AFAM zhangshida <starzhangzsd@gmail.c=
om> wrote:
> >
> > From: Shida Zhang <zhangshida@kylinos.cn>
> >
> > Andreas point out that multiple completions can race setting
> > bi_status.
> >
> > The check (parent->bi_status) and the subsequent write are not an
> > atomic operation. The value of parent->bi_status could have changed
> > between the time you read it for the if check and the time you write
> > to it. So we use cmpxchg to fix the race, as suggested by Christoph.
> >
> > Suggested-by: Andreas Gruenbacher <agruenba@redhat.com>
> > Suggested-by: Christoph Hellwig <hch@infradead.org>
> > Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
> > ---
> >  block/bio.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/block/bio.c b/block/bio.c
> > index 55c2c1a0020..aa43435c15f 100644
> > --- a/block/bio.c
> > +++ b/block/bio.c
> > @@ -313,9 +313,12 @@ EXPORT_SYMBOL(bio_reset);
> >  static struct bio *__bio_chain_endio(struct bio *bio)
> >  {
> >         struct bio *parent =3D bio->bi_private;
> > +       blk_status_t *status =3D &parent->bi_status;
>
> nit: this variable seems unnecessary, just use &parent->bi_status
> directly in the one place it's needed?
>

Thanks, Caleb and Andreas. I will integrate your suggestions to:

      if (!bio->bi_status)
               cmpxchg(&parent->bi_status, 0, bio->bi_status);

Thanks,
Shida

> Best,
> Caleb
>
> > +       blk_status_t new_status =3D bio->bi_status;
> > +
> > +       if (new_status !=3D BLK_STS_OK)
> > +               cmpxchg(status, BLK_STS_OK, new_status);
> >
> > -       if (bio->bi_status && !parent->bi_status)
> > -               parent->bi_status =3D bio->bi_status;
> >         bio_put(bio);
> >         return parent;
> >  }
> > --
> > 2.34.1
> >
> >

