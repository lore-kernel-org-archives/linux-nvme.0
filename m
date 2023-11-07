Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F78AC4332F
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Nov 2023 22:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LaZlbShSY1zD/N20Q7tGXbNP7iFQR1OF0OXnpQuGlRQ=; b=PUELc813mFjzEhti3VkLgbqF77
	rjGICfsQmihnbbKg9PMlyB+f90jdDNivIBeruHdHZK2jU4LDtEd2/aSnQz/UH49BCBey3nZzT1xWR
	BhqRQlyXaBvTHJqyxKgLxPqedr62FXvGtEWmiL+yFxsq8v2UQPrvJ4bpNCsOJBUdix4DNOkWfICjq
	JOEFCLpnaz03KBuA5UuAivotlV8nmZbaHVYxUbHIbpXRb3tWMTg6taGKjxWawK+XE4zu4tLJkHDOP
	MSBqCaFLT6p/jG1jb+whk3TMCfLpNZ6NSTk+MeGjU1H4cbd4ziXinPfIIz3hxdjVsQ73zRf9+x8oQ
	Rxl79kgQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r0UAk-002Vpk-1X;
	Tue, 07 Nov 2023 22:03:46 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r0UAh-002VpK-21
	for linux-nvme@lists.infradead.org;
	Tue, 07 Nov 2023 22:03:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699394622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LaZlbShSY1zD/N20Q7tGXbNP7iFQR1OF0OXnpQuGlRQ=;
	b=ff/rJ1MOKr326U7uvoMXNsRR6/z/j5jcTKou4uFGKn6exOTfzxWuuBJ9JdGPQre2e5Lst5
	PVAqXgOcNVojnjsXatVpdBKdxIOpLXKp3tFfdOJjejg7R/zgwR5pa87UWnD4+JvwM1wVLS
	18uPBXS3eFpXWPjlRm1d4xDqYpARN2E=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-318-PdMTajS3OS-e8PSpqTtE3A-1; Tue, 07 Nov 2023 17:03:41 -0500
X-MC-Unique: PdMTajS3OS-e8PSpqTtE3A-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-32da7983d20so89987f8f.1
        for <linux-nvme@lists.infradead.org>; Tue, 07 Nov 2023 14:03:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699394619; x=1699999419;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LaZlbShSY1zD/N20Q7tGXbNP7iFQR1OF0OXnpQuGlRQ=;
        b=xNKgpwz0IxjfiE3zFocpPBgwkJIX5Dlcibvx0MJZbCJsuSY+2czZ1aCUbotpHFtWtZ
         6SjF90k/Idwcjl4/LrouyONimYqis/mwbQBz89sSTMTAeRZiier0T03Fht7GQqm0E0cn
         gIsZePA/+954mSrFCgXCV0CniSNXdV6f6FVodM+uDdug7uiJTBmZ6jiQWy8aR2DyqG34
         MUbah5ixZWjDwqpeo6oKdpSaFpB8XF2yKi0cZ9CX9QyGUkq2hAlOPM0n0Jbv7do6et+w
         nFi4N+EID4dre4/wdrTALRshKgCQDW3k7n8ZuX1voHV8zraPmVPbmWVyHlkdZpfJ2jMn
         rLIg==
X-Gm-Message-State: AOJu0YzFY7XDtozNn2oJ1kZGa/l0IDns8tx+yIdHL8MVCzEVm/Uz+nCU
	IhcwOTW6xzwDsKOIX3GZjCtnd1syeE9vkZbt2XSVcRCa/OQ3nLPNXTGQKExZaNaynJU1Yj6ceRq
	aklu5E0QWz0cgs58JGO4BcPf3erjwR/I9EpoHaIvbGKQ=
X-Received: by 2002:adf:c6c7:0:b0:32f:8b11:914e with SMTP id c7-20020adfc6c7000000b0032f8b11914emr70931wrh.8.1699394619444;
        Tue, 07 Nov 2023 14:03:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFq/GOSVj59Z6FkNyXP4u09FCiTG+4LyoDrGjMifW0SGbOfmLheV5AMNXv3v8nzPpJxPyNNTcsW9zhWgQ1+DQI=
X-Received: by 2002:adf:c6c7:0:b0:32f:8b11:914e with SMTP id
 c7-20020adfc6c7000000b0032f8b11914emr70920wrh.8.1699394619157; Tue, 07 Nov
 2023 14:03:39 -0800 (PST)
MIME-Version: 1.0
References: <20231107212331.9413-1-emilne@redhat.com> <20231107212331.9413-2-emilne@redhat.com>
 <ZUqx7JoyPG1QxYeY@kbusch-mbp.dhcp.thefacebook.com>
In-Reply-To: <ZUqx7JoyPG1QxYeY@kbusch-mbp.dhcp.thefacebook.com>
From: Ewan Milne <emilne@redhat.com>
Date: Tue, 7 Nov 2023 17:03:28 -0500
Message-ID: <CAGtn9r=JngYhfygCe856qRNF7fgHe_ry1RoD-R2M=uDq=iWrGQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] nvme: multipath: only update ctrl->nr_active when
 using queue-depth iopolicy
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, tsong@purestorage.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231107_140343_735062_D403C1B7 
X-CRM114-Status: GOOD (  20.06  )
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

I did 2/3 as a separate patch because Tomas wrote the first one
and I thought it was a little more clear to have the optimization
separated out, but I can combine them if we like.

-Ewan

On Tue, Nov 7, 2023 at 4:53=E2=80=AFPM Keith Busch <kbusch@kernel.org> wrot=
e:
>
> On Tue, Nov 07, 2023 at 04:23:30PM -0500, Ewan D. Milne wrote:
> > The atomic updates of ctrl->nr_active are unnecessary when using
> > numa or round-robin iopolicy, so avoid that cost on a per-request basis=
.
> > Clear nr_active when changing iopolicy and do not decrement below zero.
> > (This handles changing the iopolicy while requests are in flight.)
>
> Oh, here's restricting it to that policy. Any reason not to fold it in
> the first one?
>
> > -     atomic_inc(&ns->ctrl->nr_active);
> > +     if (READ_ONCE(ns->head->subsys->iopolicy) =3D=3D NVME_IOPOLICY_QD=
)
> > +             atomic_inc(&ns->ctrl->nr_active);
>
> This all looks racy with the ability to change policies in flight. I
> think we need to introduce a new flag and do something like this:
>
>         if (READ_ONCE(ns->head->subsys->iopolicy) =3D=3D NVME_IOPOLICY_QD=
) {
>                 atomic_inc(&ns->ctrl->nr_active);
>                 nvme_req(rq)->flags |=3D NVME_MPATH_COUNT_ACTIVE;
>         }
>
> ...
>
> > @@ -147,7 +148,8 @@ void nvme_mpath_end_request(struct request *rq)
> >       if (!(nvme_req(rq)->flags & NVME_MPATH_IO_STATS))
> >               return;
> >
> > -     atomic_dec(&ns->ctrl->nr_active);
> > +     if (READ_ONCE(ns->head->subsys->iopolicy) =3D=3D NVME_IOPOLICY_QD=
)
> > +             atomic_dec_if_positive(&ns->ctrl->nr_active);
>
> And then the above becomes:
>
>         if (nvme_req(rq)->flags & NVME_MPATH_COUNT_ACTIVE)
>                 atomic_dec_if_positive(&ns->ctrl->nr_active);
>
> ...
>
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
>
> And then you don't need to do the above since atomic_dec's are always
> pairs with atomic_inc's. What do you think?
>


