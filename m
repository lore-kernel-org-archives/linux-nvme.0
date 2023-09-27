Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABF07E810DA
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Sep 2023 13:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EKfdt6Kw+N8ntdglWY4a9O5k1msEJgIQve5e7wWpGzw=; b=hbrFuv8cMQ2qsHNj6LqaEjYJq2
	I5cDMkqdCSFPEd2AmpjD8PLRlBldltwtGuqxQggzzVW7d5nEainKBuQHoouPgv+ksOwW3r4FEK7M/
	o9HLtj2JWro/BmQU8s2j+/A2FcAyUrAK5lwDSFjZHK4G9zvONdhiCAY78Wa92QI+mUOF4bTO6udGi
	BF3RpkA9MqRRWPALOg5W2zZo2PW7li7kfZUS5HNrrI9xpS4/0fqhKfza+a31Br34B/dxImOSFdA7R
	T5jZWXnNmNKY7hs3NyitdWBpEY9FmwGuRupWALsyHIfPlmwiSObaAm5O3r+UDYat8f54eDBZ6Z0RG
	yISrl9Lw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qlUgS-0011Gn-0v;
	Wed, 27 Sep 2023 13:34:32 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qlUgP-0011GC-2C
	for linux-nvme@lists.infradead.org;
	Wed, 27 Sep 2023 13:34:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695821667;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EKfdt6Kw+N8ntdglWY4a9O5k1msEJgIQve5e7wWpGzw=;
	b=CaG9NKvTV0OVY+C1U4HFlHj+jDSVYrTh0lieH1v3uBLDAg3fXR0GCG8xue9D1Fenlp6fQp
	gr4zO6BkKj9rcSgTP8UKXmn0vpaHK3ZZqbxruXHXlHkFh8c+jBO8r9SobY5n8xw35Dq8g+
	jC555gEcvmLE05/tcRKPSGpxsWY34R4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-5B7YWRv1Mf2bE6ToMRNxjg-1; Wed, 27 Sep 2023 09:34:26 -0400
X-MC-Unique: 5B7YWRv1Mf2bE6ToMRNxjg-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-30932d15a30so8772325f8f.1
        for <linux-nvme@lists.infradead.org>; Wed, 27 Sep 2023 06:34:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695821665; x=1696426465;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EKfdt6Kw+N8ntdglWY4a9O5k1msEJgIQve5e7wWpGzw=;
        b=gkwNSEVVxCbe9Z8bFGEToBne5GhYgALi7XGrDAiw1wGVLy4dhEMKlb56Zef/x4Y2N8
         T+ng9jyTOAJwNvRpoAi0ijpwLDxq7qU44efauupnX6DwSosRipYXgs1MgJUmv4a9r3AW
         QDVa+mvSEzysfTgemKZ7H+FmF8l4AK7MYuSuXO6r3TwHkxE+eTe4DGPbSEhlaJidm7Nx
         ld+/0FNUUldjpqIQWlOH+uv1TfbERTQw4z6tEpDYXvY/tGp2ZiTRIfdm2OPoUI3pmXbH
         ZMMJQCEe97ab75qDIHyp9PfXdOyqpyvkcu6c7SADtArdvDXLgzAZDGbviDX3KkcX2DEE
         RBQQ==
X-Gm-Message-State: AOJu0YzOzjXKgD98aTRlgg4MqWnHsRTpi3XgYCz4ix7/OOcjEpPno3H2
	RpdhlKbIcuPciAtJ39ucPf6V++ynSqAOBWEmBlXgLYudjEXbJug5S291wmya3d0cWe6KUe0JjAS
	lOgj599XstIyEh/z+O238CqhNtXkXVUjJx/iTHD+bTEY=
X-Received: by 2002:adf:e711:0:b0:320:aea6:abb9 with SMTP id c17-20020adfe711000000b00320aea6abb9mr1749765wrm.6.1695821664927;
        Wed, 27 Sep 2023 06:34:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHD8j7RSFhyWkcEFaNGACWAdS0eMW8raAPkdwSSypd6EmG070yBtOMdsKSUS7ZRyzQA+sd4f0fdjDkQoVKBq2k=
X-Received: by 2002:adf:e711:0:b0:320:aea6:abb9 with SMTP id
 c17-20020adfe711000000b00320aea6abb9mr1749746wrm.6.1695821664571; Wed, 27 Sep
 2023 06:34:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230925163123.16042-1-emilne@redhat.com> <20230925163123.16042-2-emilne@redhat.com>
 <c63ee412-3f34-49c7-b873-16b37683dc90@suse.de>
In-Reply-To: <c63ee412-3f34-49c7-b873-16b37683dc90@suse.de>
From: Ewan Milne <emilne@redhat.com>
Date: Wed, 27 Sep 2023 09:34:13 -0400
Message-ID: <CAGtn9rmi33WNTibBRWWDJV98QzC1-wPVEdYObtVbi6DihmmCYQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] block: introduce blk_queue_nr_active()
To: Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org, tsong@purestorage.com, jmeneghi@redhat.com, 
	mlombard@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230927_063429_806935_F8563A2C 
X-CRM114-Status: GOOD (  25.71  )
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

Maybe I missed something but I only found 2 cases that set
BLK_MQ_F_TAG_HCTX_SHARED.

For NVMe/TCP, at least on the system I used that has 80 cores, there
were only 1 hctxs
but I haven't looked into how many e.g. we have for PCI devices.  FC I
think has a smallish number.

-Ewan

On Wed, Sep 27, 2023 at 3:36=E2=80=AFAM Hannes Reinecke <hare@suse.de> wrot=
e:
>
> On 9/25/23 18:31, Ewan D. Milne wrote:
> > Returns a count of the total number of active requests
> > in a queue.  For non-shared tags (the usual case) this is
> > the sum of nr_active from all of the hctxs.
> >
> Bit of an exaggeration here.
> Shared tags are in use if the hardware supports only a global tag space
> (ie basically all SCSI and FC HBAs).
>
> > Signed-off-by: Ewan D. Milne <emilne@redhat.com>
> > ---
> >   block/blk-mq.h         |  5 -----
> >   include/linux/blk-mq.h | 33 ++++++++++++++++++++++++++-------
> >   2 files changed, 26 insertions(+), 12 deletions(-)
> >
> > diff --git a/block/blk-mq.h b/block/blk-mq.h
> > index 1743857e0b01..fbc65eefa017 100644
> > --- a/block/blk-mq.h
> > +++ b/block/blk-mq.h
> > @@ -214,11 +214,6 @@ static inline bool blk_mq_tag_is_reserved(struct b=
lk_mq_tags *tags,
> >       return tag < tags->nr_reserved_tags;
> >   }
> >
> > -static inline bool blk_mq_is_shared_tags(unsigned int flags)
> > -{
> > -     return flags & BLK_MQ_F_TAG_HCTX_SHARED;
> > -}
> > -
> >   static inline struct blk_mq_tags *blk_mq_tags_from_data(struct blk_mq=
_alloc_data *data)
> >   {
> >       if (data->rq_flags & RQF_SCHED_TAGS)
> > diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> > index 01e8c31db665..c921ae5236ab 100644
> > --- a/include/linux/blk-mq.h
> > +++ b/include/linux/blk-mq.h
> > @@ -716,6 +716,32 @@ int blk_rq_poll(struct request *rq, struct io_comp=
_batch *iob,
> >
> >   bool blk_mq_queue_inflight(struct request_queue *q);
> >
> > +#define queue_for_each_hw_ctx(q, hctx, i)                            \
> > +     xa_for_each(&(q)->hctx_table, (i), (hctx))
> > +
> > +#define hctx_for_each_ctx(hctx, ctx, i)                               =
       \
> > +     for ((i) =3D 0; (i) < (hctx)->nr_ctx &&                          =
 \
> > +          ({ ctx =3D (hctx)->ctxs[(i)]; 1; }); (i)++)
> > +
> > +static inline bool blk_mq_is_shared_tags(unsigned int flags)
> > +{
> > +     return flags & BLK_MQ_F_TAG_HCTX_SHARED;
> > +}
> > +
> > +static inline unsigned int blk_mq_queue_nr_active(struct request_queue=
 *q)
> > +{
> > +     unsigned int nr_active =3D 0;
> > +     struct blk_mq_hw_ctx *hctx;
> > +     unsigned long i;
> > +
> > +     queue_for_each_hw_ctx(q, hctx, i) {
> > +             if (unlikely(blk_mq_is_shared_tags(hctx->flags)))
> > +                     return atomic_read(&q->nr_active_requests_shared_=
tags);
> > +             nr_active +=3D atomic_read(&hctx->nr_active);
> > +     }
> > +     return nr_active;
> > +}
> > +
> >   enum {
> >       /* return when out of requests */
> >       BLK_MQ_REQ_NOWAIT       =3D (__force blk_mq_req_flags_t)(1 << 0),
> > @@ -941,13 +967,6 @@ static inline void *blk_mq_rq_to_pdu(struct reques=
t *rq)
> >       return rq + 1;
> >   }
> >
> > -#define queue_for_each_hw_ctx(q, hctx, i)                            \
> > -     xa_for_each(&(q)->hctx_table, (i), (hctx))
> > -
> > -#define hctx_for_each_ctx(hctx, ctx, i)                               =
       \
> > -     for ((i) =3D 0; (i) < (hctx)->nr_ctx &&                          =
 \
> > -          ({ ctx =3D (hctx)->ctxs[(i)]; 1; }); (i)++)
> > -
> >   static inline void blk_mq_cleanup_rq(struct request *rq)
> >   {
> >       if (rq->q->mq_ops->cleanup_rq)
>
> Well. As discussed, using xarray on 'small' arrays is horrible for
> performance. We really should revert the patch from Ming to
> turn it back into a simple array; that'll make traversing much faster.
>
> Cheers,
>
> Hannes
> --
> Dr. Hannes Reinecke                Kernel Storage Architect
> hare@suse.de                              +49 911 74053 688
> SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg
> HRB 36809 (AG N=C3=BCrnberg), Gesch=C3=A4ftsf=C3=BChrer: Ivo Totev, Andre=
w
> Myers, Andrew McDonald, Martje Boudien Moerman
>


