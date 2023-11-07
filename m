Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E0B8C4167D
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Nov 2023 22:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=egv6CSfXRAqvwVAbljj7Cl4RIv2xTtJtsZuAJJbX1Eo=; b=A9+qFFXuFfM3W+J3K+5b5AGeMt
	FU3tFvZFZb4hjjnJdZ6aeKxEYoRnfg4x9sHyliYQaGhrfCaI8y7wJwoJtxHbsS+ieSaFhdI0F26YG
	HD4YdhGe+Ta2ZuAUYOW6qtdZYdzQ/S9H26Ld1Ylgs0QsSA8hsm9ZDG3m3antVIpFsSXdvaBS5dMjd
	cQTy5cXqYpBc95eHVZ/vHC+HYU1LMsddPgt0MWIcoDZXj1LRLRFwNV6Et+rCR3Sr15zaK0zVF4MJS
	UVlcLeP4EfjN++khffxwJK+jMzSJaykscEQASEQbeyLpwIUuQTvLLOsBfzpPKO63aicEz0ZDyooyr
	s3Ji3yWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r0U8i-002VSJ-1s;
	Tue, 07 Nov 2023 22:01:40 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r0U8g-002VRt-17
	for linux-nvme@lists.infradead.org;
	Tue, 07 Nov 2023 22:01:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699394497;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=egv6CSfXRAqvwVAbljj7Cl4RIv2xTtJtsZuAJJbX1Eo=;
	b=PXGU0s8Fp900RiPfuBTpXg7TA3KHkyfDMcBDPYWGcjt4COX/8Ez/x8Sy8MrVyts9Fa0zs0
	SVy9UNRK3C+1TdLXSkT2ngN3laB8uP3vct3qdV7/ITRegecy8rb8ZL7NARnnAzAJxw5WPn
	CN64rAKJsjQiHEVlSz84Tzt6pK5WhQE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-472--fCXtFogMLa7AJzfvvsbNw-1; Tue, 07 Nov 2023 17:01:35 -0500
X-MC-Unique: -fCXtFogMLa7AJzfvvsbNw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4091c9bdb8eso883235e9.1
        for <linux-nvme@lists.infradead.org>; Tue, 07 Nov 2023 14:01:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699394494; x=1699999294;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=egv6CSfXRAqvwVAbljj7Cl4RIv2xTtJtsZuAJJbX1Eo=;
        b=SXY9h8/pEFgVnshq93I+luuHe/pL/z1pK/oZO8Z21aS8RmpoKYqFXMSlHyVgzQc6bM
         GS4KIfWg2/tjA680sEwp/iLY19y2GQlyXQqPQADvUh72+utpFW/xKsjIr2fU9QHOCrpy
         BA/ExxdBBoiix7tgpjKKIPJPpft/0qOqWV4EaAl0aAkEVmP3vDsU/snkqDw9n+tDg4SZ
         Ds91uL15vGGBgIGlpAhIrsXMdUIfDRR2fiXAECjNprj0++QNRutKcuxW5wqAlTwoqmI1
         jsGruo0aCygF77qdeFk4CfJa+gaM5TTlpXIMTvvnCqZClZC5+UmIGUjOJotPnd4ssYYq
         0Crg==
X-Gm-Message-State: AOJu0Yw/WXUeBrI9N40m9jCZxX+McX5duDzUDnuRfg9PG1GGdkrbArLm
	sKL0ZU8GK4w107kfdwq5Y8lB5yC4OQGMrACJEz45yJCHkazeX2xm0Gf1hNe0cm+Ul+khM89rdGt
	U+saGPNUDPDnBCx/GO9ffnZucoOyrjlc7SkMhaLsYltY=
X-Received: by 2002:a05:600c:3104:b0:407:3e94:bcca with SMTP id g4-20020a05600c310400b004073e94bccamr60552wmo.1.1699394494145;
        Tue, 07 Nov 2023 14:01:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFpxm28WwdVMF5/yaDwz3hkcd+4C/MiCxyNKrhJ7O5galDPuDmXjlGXrh00/YU9OEEEUGjAAIU6IKUMUUCQkQ8=
X-Received: by 2002:a05:600c:3104:b0:407:3e94:bcca with SMTP id
 g4-20020a05600c310400b004073e94bccamr60536wmo.1.1699394493822; Tue, 07 Nov
 2023 14:01:33 -0800 (PST)
MIME-Version: 1.0
References: <20231107212331.9413-1-emilne@redhat.com> <ZUqw82QlbgXhDwpr@kbusch-mbp.dhcp.thefacebook.com>
In-Reply-To: <ZUqw82QlbgXhDwpr@kbusch-mbp.dhcp.thefacebook.com>
From: Ewan Milne <emilne@redhat.com>
Date: Tue, 7 Nov 2023 17:01:22 -0500
Message-ID: <CAGtn9rmaF8GEFjnnZuM_k6fPxGDAooQrN-7W8bHay1cXqK5Zxg@mail.gmail.com>
Subject: Re: [PATCH 1/3] nvme: multipath: Implemented new iopolicy "queue-depth"
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, tsong@purestorage.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231107_140138_458476_04E4BEFA 
X-CRM114-Status: GOOD (  16.90  )
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

The patch uses the existing flag NVME_MPATH_IO_STATS in the request
for simplicity to see if an atomic_inc() was performed before doing the _de=
c().
If we really need to keep the count for passthrough requests (maybe we do)
then we would need another flag.

The reason to use the atomic_dec_if_positive() in the 2nd patch and set the
nr_active to zero when changing the iopolicy is so that if e.g. someone cha=
nges
the iopolicy repeatedly while requests are in-flight the counter will
work properly.

(I have a test case and another path to make the nr_active counter
visible in sysfs,
btw, if that would be useful.)

-Ewan

On Tue, Nov 7, 2023 at 4:49=E2=80=AFPM Keith Busch <kbusch@kernel.org> wrot=
e:
>
> On Tue, Nov 07, 2023 at 04:23:29PM -0500, Ewan D. Milne wrote:
> >  void nvme_mpath_default_iopolicy(struct nvme_subsystem *subsys)
> >  {
> > @@ -130,6 +133,7 @@ void nvme_mpath_start_request(struct request *rq)
> >       if (!blk_queue_io_stat(disk->queue) || blk_rq_is_passthrough(rq))
> >               return;
> >
> > +     atomic_inc(&ns->ctrl->nr_active);
>
> Did you intend to skip counting nr_active if disk stats are not enabled,
> or if it's a passthough command?
>
> Also, we should restrict the atomics for other new IO Depth  policy.
>
> >       nvme_req(rq)->flags |=3D NVME_MPATH_IO_STATS;
> >       nvme_req(rq)->start_time =3D bdev_start_io_acct(disk->part0, req_=
op(rq),
> >                                                     jiffies);
> > @@ -142,6 +146,8 @@ void nvme_mpath_end_request(struct request *rq)
> >
> >       if (!(nvme_req(rq)->flags & NVME_MPATH_IO_STATS))
> >               return;
> > +
> > +     atomic_dec(&ns->ctrl->nr_active);
>
> And if disk stats were disabled, this dec isn't paired with an inc.
>


