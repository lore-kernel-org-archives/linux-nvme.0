Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF2E8C25B75
	for <linux-nvme@archiver.kernel.org>; Thu, 23 May 2024 15:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=c8tCGD+B/90fiwr0wHpk4PrsZCbhBjOEiTIub+soBMc=; b=iHMlHJo7G2ivZrbJEc5oXwN0cv
	SjpGPV44fOZP34A8QxFtnDZ707OWZZhDEQEIIQpS0l+pTXYFX9CfqxtufeypTGjE9UeZW2a3/SP0z
	V36VlrWSBOOc//QqAfDpM5r524ZUjWbxiELdLIWFrjIHC0ijq/3pUvHmII7356/zGFhMI1svZWd3/
	zuZiaNo4NFMfKDMpzel/v/P0pcJFp5SED0GhTn9YiFd/g31gSpLc1Vntr2GNRBiAhUoNr2LA5tPH/
	yOKbmDBQ88t6wPF01APQD5nGvAPgpxetNQNpEovW59s5u/UIamJFAxouHRmytQbDwElEn9kk2Y2TR
	E896xd4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sAAHg-00000006dYs-10TK;
	Thu, 23 May 2024 15:23:12 +0000
Received: from mail-vk1-xa2b.google.com ([2607:f8b0:4864:20::a2b])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sAAHe-00000006dXf-03dN
	for linux-nvme@lists.infradead.org;
	Thu, 23 May 2024 15:23:11 +0000
Received: by mail-vk1-xa2b.google.com with SMTP id 71dfb90a1353d-4df7cb5894fso1908647e0c.1
        for <linux-nvme@lists.infradead.org>; Thu, 23 May 2024 08:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716477786; x=1717082586; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c8tCGD+B/90fiwr0wHpk4PrsZCbhBjOEiTIub+soBMc=;
        b=EhZxe5rkXfunlMCexJrwDmi++xdV4XiPoRlWqPN27a7VP01jSidOgtsNOTq8Gakldw
         BY1YYW7GCvWqI2/LWhSMBLkHP9rswuAi4DfG/jHRbmJHeqWFSS9AHPQkblBuIpVkwTdG
         yfYc/U6fvzr416iM5ssKC4oudoR3hJnNO432T3eWepP5Tq6755CN4Q8JxK+eUwYhq5or
         PcA28PfNI0CaLOr3OumKOWmYEF6JKmIJo78XkKQFfegLsZWgk5ZWIqfnz5o8KZHHoo00
         kjzbb4LwryWxNJj4jaKOAhmt/WFIEm2IYPLwHHbfWwt5sIfZYeyBpL3lYHx9oAO8biD8
         4Yog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716477786; x=1717082586;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c8tCGD+B/90fiwr0wHpk4PrsZCbhBjOEiTIub+soBMc=;
        b=QxEzG+s6MsmAZDBgktc/ePI+FTPUbeLknYBqxE/7cky/PCJLAy0EGv1da61gSNwN0C
         jh/UvsZ0IODuduygIySg0V5wzaljrtkUVBWnLSdbbmwr4fyBEVc2RpOCNuVzHViTSGbw
         MTsYGWlsVGn6Ug0vpdG3mvlds83NfsGpGJvY/kuYAB28KnurIdB9cC2DxUfK05hZ66K0
         /w89fPbwyc/ApbGXnizdhU7K7F/QHbT7oZ8KbTCNgHSuwNv/u5Dmg4EaXIHD+DU3gXkb
         b4cBOP9eVSTAw36YiS2WMB01DBobUzYY1Nb1TQo78zUi7VVHIYbjWrwqqWZZKVPE6Gzl
         0kCg==
X-Forwarded-Encrypted: i=1; AJvYcCV6NMzBwW/S1sIhuAha3c9Llg0/+mC0W5JraBlROuELhCd/tKYwZCDR9pwPfTMRRzjMgFaWcUG7lt6ABLy+09qQZJBv5fpkuMtc6nUnrQ4=
X-Gm-Message-State: AOJu0Ywjmp3wTEwR3w2FGvAdVtzI7dLd4eW+foEPseJCri7UNKrsj/PV
	PoGK4D8xasx9NRicsXBVvJ1NzAS9n6kMEktlbVn44289Q8LO89ajGb4OOwU3yt6pefbvMiVDaVe
	a6FXKl1+5Kq8zony/bxAAbQLLeQ==
X-Google-Smtp-Source: AGHT+IHf+AmqHylb4UCzV6cCGGq50XriQJFqc3S13bgCKMdOxy9ZuTsPeUtcuE77AHyQWp9HPWeABRGMmoFgFZvcQWY=
X-Received: by 2002:a05:6122:208a:b0:4bd:32c9:acb with SMTP id
 71dfb90a1353d-4e218524df6mr5691819e0c.7.1716477786039; Thu, 23 May 2024
 08:23:06 -0700 (PDT)
MIME-Version: 1.0
References: <f85e3824-5545-f541-c96d-4352585288a@redhat.com>
 <c366231-e146-5a2b-1d8a-5936fb2047ca@redhat.com> <8522af2f-fb97-4d0b-9e38-868c572da18a@kernel.dk>
 <7060a917-6537-4334-4961-601a182bca54@redhat.com> <b1ca89ae-1500-4c3c-bd8a-74e081aa8dd3@kernel.dk>
 <798720bc-bc69-1e1c-8436-474e8a9fb0e8@redhat.com>
In-Reply-To: <798720bc-bc69-1e1c-8436-474e8a9fb0e8@redhat.com>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Thu, 23 May 2024 20:52:28 +0530
Message-ID: <CACzX3As928NhtJdNGii16Jeuix3RfzRZbgr4ZSv9p+Pi6FiNvA@mail.gmail.com>
Subject: Re: [PATCH v2] block: change rq_integrity_vec to respect the iterator
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, Mike Snitzer <snitzer@kernel.org>, Milan Broz <gmazyland@gmail.com>, 
	linux-block@vger.kernel.org, dm-devel@lists.linux.dev, 
	linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240523_082310_074524_87B0A919 
X-CRM114-Status: GOOD (  27.13  )
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

On Thu, May 23, 2024 at 8:41=E2=80=AFPM Mikulas Patocka <mpatocka@redhat.co=
m> wrote:
>
>
>
> On Thu, 23 May 2024, Jens Axboe wrote:
>
> > On 5/23/24 8:58 AM, Mikulas Patocka wrote:
>
> > > Here I'm resending the patch with the function rq_integrity_vec remov=
ed if
> > > CONFIG_BLK_DEV_INTEGRITY is not defined.
> >
> > That looks better - but can you please just post a full new series,
> > that's a lot easier to deal with and look at than adding a v2 of one
> > patch in the thread.
>
> OK, I'll post both patches.
>
> > > @@ -853,16 +855,20 @@ static blk_status_t nvme_prep_rq(struct
> > >                     goto out_free_cmd;
> > >     }
> > >
> > > +#ifdef CONFIG_BLK_DEV_INTEGRITY
> > >     if (blk_integrity_rq(req)) {
> > >             ret =3D nvme_map_metadata(dev, req, &iod->cmd);
> > >             if (ret)
> > >                     goto out_unmap_data;
> > >     }
> > > +#endif
> >
> >       if (IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY) && blk_integrity_rq(req)=
) {
> >
> > ?
>
> That wouldn't work, because the calls to rq_integrity_vec need to be
> eliminated by the preprocessor.
>
> Should I change rq_integrity_vec to this? Then, we could get rid of the
> ifdefs and let the optimizer remove all calls to rq_integrity_vec.
> static inline struct bio_vec rq_integrity_vec(struct request *rq)
> {
>         struct bio_vec bv =3D { };
>         return bv;
> }

This can be reduced to
return (struct bio_vec){ };

>
> > > @@ -962,12 +968,14 @@ static __always_inline void nvme_pci_unm
> > >     struct nvme_queue *nvmeq =3D req->mq_hctx->driver_data;
> > >     struct nvme_dev *dev =3D nvmeq->dev;
> > >
> > > +#ifdef CONFIG_BLK_DEV_INTEGRITY
> > >     if (blk_integrity_rq(req)) {
> > >             struct nvme_iod *iod =3D blk_mq_rq_to_pdu(req);
> >
> > Ditto
> >
> > > Index: linux-2.6/include/linux/blk-integrity.h
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > --- linux-2.6.orig/include/linux/blk-integrity.h
> > > +++ linux-2.6/include/linux/blk-integrity.h
> > > @@ -109,11 +109,11 @@ static inline bool blk_integrity_rq(stru
> > >   * Return the first bvec that contains integrity data.  Only drivers=
 that are
> > >   * limited to a single integrity segment should use this helper.
> > >   */
> > > -static inline struct bio_vec *rq_integrity_vec(struct request *rq)
> > > +static inline struct bio_vec rq_integrity_vec(struct request *rq)
> > >  {
> > > -   if (WARN_ON_ONCE(queue_max_integrity_segments(rq->q) > 1))
> > > -           return NULL;
> > > -   return rq->bio->bi_integrity->bip_vec;
> > > +   WARN_ON_ONCE(queue_max_integrity_segments(rq->q) > 1);
> > > +   return mp_bvec_iter_bvec(rq->bio->bi_integrity->bip_vec,
> > > +                            rq->bio->bi_integrity->bip_iter);
> > >  }
> >
> > Not clear why the return on integrity segments > 1 is removed?
>
> Because we can't return NULL. But I can leave it there, print a warning
> and return the first vector.
>
> Mikulas
>
> > --
> > Jens Axboe
> >
>
>

--
Anuj Gupta

