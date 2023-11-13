Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2721AC4332F
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Nov 2023 21:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WmDyh6Tsz2ffYXPAE0H7XJ7QtZHf3QBO4CHQGG9uDIg=; b=0axle8JltJuS8igUf9x2GMIRzE
	J5QcoRR5PpyDFBR3k2qOaCT870tUg7LjF5Vk7FZ6jGV1G4Nhr1dvyVDPANNliG0caq2wLtcaKdCGb
	gzC1Y5julW/vVZYnbMd3hj0y2wUrZf02m/kWLxVi2AZYrR83RZIJDCc8jKR+dh0RSuUhEJK0DiDbr
	L0NoP950u4hhyBMzAog1MIne4xPcWufJ73wdVjau2Wli/4YNyu4yD73KaCp6oeIJm2atI8VqaMJ4H
	2GJ/mWVQfxkeGYQE39PPZ+Z+yhvb/yypzxU3TJ+YsGoM6U8EdE9TG6QzLn28juyNp/eFIqIlVPJmO
	nMgKO06A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r2eIh-00EjVz-09;
	Mon, 13 Nov 2023 21:16:55 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r2eId-00EjUt-28
	for linux-nvme@lists.infradead.org;
	Mon, 13 Nov 2023 21:16:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699910208;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WmDyh6Tsz2ffYXPAE0H7XJ7QtZHf3QBO4CHQGG9uDIg=;
	b=MROLD90F6nKzUZy0vTtw6sOgU1Jn39hZYF/2Xd+xCf8r6CvuZDTYqsCoNDn6WdT3NK6nnD
	IXrQi8cdg8i6wpw1vmkMFFknmrW6CaFJGRaLpouiMQiu+PZGBceDwcDXvhBkHGZn4NI9rr
	WW5U0pdZnm4MpcW0z15okXfE3G9LJIs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-462-_p8-8W6tMxaoJHMTScBSyQ-1; Mon, 13 Nov 2023 16:16:47 -0500
X-MC-Unique: _p8-8W6tMxaoJHMTScBSyQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-32d9cd6eb0bso2342079f8f.0
        for <linux-nvme@lists.infradead.org>; Mon, 13 Nov 2023 13:16:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699910206; x=1700515006;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WmDyh6Tsz2ffYXPAE0H7XJ7QtZHf3QBO4CHQGG9uDIg=;
        b=NMfshk8cvDc0VDFZpT1AzOsozaI2BYh2SDxBlqlLcd1EnzXmiSvteYUrwOmG3qWNr+
         V7vuvLf5j/cOVBjffe2vRCV6In7fcO2L+fQMjd9hVu4dfQDMr1R4K60PrJz1SH65UaCD
         MV8GoysnwcwSrcFVKpAenOPQW7/fPkgq98npIH5kanln4NCoJ+zT7Ibi4YrkCgOxd2h1
         KnIwN23RQuQ7FyrC/Uf8EhESZK8aLf03z8Zbc8ouqnmivoNXp34ZS0oPXRg7qGqIY1RK
         bW5Yq0bqCL5lBroQpizZnTPBWEnIVvTPg62G1lEFURvnyS1JGd6Ux8DIJjgHwBBfi2VQ
         2iLQ==
X-Gm-Message-State: AOJu0YyJ+Dw6GMEx/7T94sICuUscW65Axru0YwB6iqx56P1kF5qVRN0N
	giRuHzsB2hORCcFo9bOZQDSFHvbkHDrEHjY4vRZFbUPRm1nXL0uiutreJwcu7KCFq1TMWvI1T+9
	UkgiL/ucf9bhXJsFFotufEvFicbiutebg8eA7JGNjddU=
X-Received: by 2002:adf:e885:0:b0:32f:acb1:ba9b with SMTP id d5-20020adfe885000000b0032facb1ba9bmr6615045wrm.22.1699910206200;
        Mon, 13 Nov 2023 13:16:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEIetdpbZgIa9pum73pKXcm0A0/d9D1xwWUEEhrEw64iGkRcdljEUI6UsN4WS9CC6v61Gv1w7Y0KVJezNJlpag=
X-Received: by 2002:adf:e885:0:b0:32f:acb1:ba9b with SMTP id
 d5-20020adfe885000000b0032facb1ba9bmr6615032wrm.22.1699910205797; Mon, 13 Nov
 2023 13:16:45 -0800 (PST)
MIME-Version: 1.0
References: <20231107212331.9413-1-emilne@redhat.com> <20231107212331.9413-2-emilne@redhat.com>
 <ZU2E1j4zyUGYw7en@dev-ushankar.dev.purestorage.com>
In-Reply-To: <ZU2E1j4zyUGYw7en@dev-ushankar.dev.purestorage.com>
From: Ewan Milne <emilne@redhat.com>
Date: Mon, 13 Nov 2023 16:16:33 -0500
Message-ID: <CAGtn9rkWpBAa-KCB1TD9hj9fibft1YcYCeq7dYsmR3akQ6DYrw@mail.gmail.com>
Subject: Re: [PATCH 2/3] nvme: multipath: only update ctrl->nr_active when
 using queue-depth iopolicy
To: Uday Shankar <ushankar@purestorage.com>
Cc: linux-nvme@lists.infradead.org, tsong@purestorage.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231113_131651_802980_0376D6D8 
X-CRM114-Status: GOOD (  28.22  )
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

I think quiescing all the queues associated with the nvme_ctrl would
be undesirable
just to handle changing the iopolicy, which only needs to affect I/O
that has not yet
gone through the path selection.  It would be better not to make the
sysfs write have
to wait, as well (although this could be done with a work item, it
seems like overkill).

Probably there is not enough contention for the atomic_dec_if_positive() to=
 loop
but I take your point, I'll look at it.  The equipment I have here is
likely not fast enough
to be sure.

-Ewan



On Thu, Nov 9, 2023 at 8:18=E2=80=AFPM Uday Shankar <ushankar@purestorage.c=
om> wrote:
>
> On Tue, Nov 07, 2023 at 04:23:30PM -0500, Ewan D. Milne wrote:
> > The atomic updates of ctrl->nr_active are unnecessary when using
> > numa or round-robin iopolicy, so avoid that cost on a per-request basis=
.
> > Clear nr_active when changing iopolicy and do not decrement below zero.
> > (This handles changing the iopolicy while requests are in flight.)
>
> Instead of trying to handle a changing iopolicy while requests are in
> flight, can we quiesce I/O when we change the iopolicy? That should let
> us simplify/speed up the logic in the I/O path a bit
> (atomic_dec_if_positive seems to hide a cmpxchg loop on most
> architectures, which can be slower than an atomic_dec).
>
> >
> > Signed-off-by: Ewan D. Milne <emilne@redhat.com>
> > ---
> >  drivers/nvme/host/core.c      |  2 +-
> >  drivers/nvme/host/multipath.c | 21 ++++++++++++++++++---
> >  drivers/nvme/host/nvme.h      |  2 ++
> >  3 files changed, 21 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > index 75a1b58a7a43..9bc19755be77 100644
> > --- a/drivers/nvme/host/core.c
> > +++ b/drivers/nvme/host/core.c
> > @@ -110,7 +110,7 @@ struct workqueue_struct *nvme_delete_wq;
> >  EXPORT_SYMBOL_GPL(nvme_delete_wq);
> >
> >  static LIST_HEAD(nvme_subsystems);
> > -static DEFINE_MUTEX(nvme_subsystems_lock);
> > +DEFINE_MUTEX(nvme_subsystems_lock);
> >
> >  static DEFINE_IDA(nvme_instance_ida);
> >  static dev_t nvme_ctrl_base_chr_devt;
> > diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipat=
h.c
> > index 4c2690cddef3..e184e7c377bc 100644
> > --- a/drivers/nvme/host/multipath.c
> > +++ b/drivers/nvme/host/multipath.c
> > @@ -133,7 +133,8 @@ void nvme_mpath_start_request(struct request *rq)
> >       if (!blk_queue_io_stat(disk->queue) || blk_rq_is_passthrough(rq))
> >               return;
> >
> > -     atomic_inc(&ns->ctrl->nr_active);
> > +     if (READ_ONCE(ns->head->subsys->iopolicy) =3D=3D NVME_IOPOLICY_QD=
)
> > +             atomic_inc(&ns->ctrl->nr_active);
> >       nvme_req(rq)->flags |=3D NVME_MPATH_IO_STATS;
> >       nvme_req(rq)->start_time =3D bdev_start_io_acct(disk->part0, req_=
op(rq),
> >                                                     jiffies);
> > @@ -147,7 +148,8 @@ void nvme_mpath_end_request(struct request *rq)
> >       if (!(nvme_req(rq)->flags & NVME_MPATH_IO_STATS))
> >               return;
> >
> > -     atomic_dec(&ns->ctrl->nr_active);
> > +     if (READ_ONCE(ns->head->subsys->iopolicy) =3D=3D NVME_IOPOLICY_QD=
)
> > +             atomic_dec_if_positive(&ns->ctrl->nr_active);
> >       bdev_end_io_acct(ns->head->disk->part0, req_op(rq),
> >                        blk_rq_bytes(rq) >> SECTOR_SHIFT,
> >                        nvme_req(rq)->start_time);
> > @@ -848,6 +850,19 @@ static ssize_t nvme_subsys_iopolicy_show(struct de=
vice *dev,
> >                         nvme_iopolicy_names[READ_ONCE(subsys->iopolicy)=
]);
> >  }
> >
> > +void nvme_subsys_iopolicy_update(struct nvme_subsystem *subsys, int io=
policy)
> > +{
> > +     struct nvme_ctrl *ctrl;
> > +
> > +     WRITE_ONCE(subsys->iopolicy, iopolicy);
> > +
> > +     mutex_lock(&nvme_subsystems_lock);
> > +     list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
> > +             atomic_set(&ctrl->nr_active, 0);
> > +     }
> > +     mutex_unlock(&nvme_subsystems_lock);
> > +}
> > +
> >  static ssize_t nvme_subsys_iopolicy_store(struct device *dev,
> >               struct device_attribute *attr, const char *buf, size_t co=
unt)
> >  {
> > @@ -857,7 +872,7 @@ static ssize_t nvme_subsys_iopolicy_store(struct de=
vice *dev,
> >
> >       for (i =3D 0; i < ARRAY_SIZE(nvme_iopolicy_names); i++) {
> >               if (sysfs_streq(buf, nvme_iopolicy_names[i])) {
> > -                     WRITE_ONCE(subsys->iopolicy, i);
> > +                     nvme_subsys_iopolicy_update(subsys, i);
> >                       return count;
> >               }
> >       }
> > diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> > index f0f3fd8b4197..c4469bc38d89 100644
> > --- a/drivers/nvme/host/nvme.h
> > +++ b/drivers/nvme/host/nvme.h
> > @@ -49,6 +49,8 @@ extern struct workqueue_struct *nvme_wq;
> >  extern struct workqueue_struct *nvme_reset_wq;
> >  extern struct workqueue_struct *nvme_delete_wq;
> >
> > +extern struct mutex nvme_subsystems_lock;
> > +
> >  /*
> >   * List of workarounds for devices that required behavior not specifie=
d in
> >   * the standard.
> > --
> > 2.20.1
> >
> >
>


