Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23593E810D9
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Sep 2023 13:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BVpbgUeHi/mHXfQ/dMUC8ZtJs1BZv76r9JDeQErJDHY=; b=gd1CaoSUrYwFksBJGhhtn8RFvO
	qwLnp40gaFl4N6MoAqIZyFrHeITKM7b+X2QC1ogJyq0p9FBi+tph45UfjnKDggV7SC3/O6I8r3WWH
	oh8v/JOIqdgPV4nFjO4oUnn8IqnnOIFfMMt4bkDOrL83RpVmlWAcJHG9fGa4qVL8vf2BVhIKV09a9
	Aa8gxKa6AriQ+xqTd02vrqNfDRjp22/7O2+TLKSZNwU1/gbs7y6aCwTRwLRw3XNqLQnv7n7DfKKHD
	ZQsqqNML9mvIsS9Q/2lwqjZauNzpPImWXCe7kddGNGbE+qvAqfa6Do1UnWLNvgDAkeqZpOleTbg6j
	zeT9iCsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qlUwL-0013FL-0L;
	Wed, 27 Sep 2023 13:50:57 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qlUwH-0013Er-3B
	for linux-nvme@lists.infradead.org;
	Wed, 27 Sep 2023 13:50:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695822653;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BVpbgUeHi/mHXfQ/dMUC8ZtJs1BZv76r9JDeQErJDHY=;
	b=UD6JhFa6eNRyqUABHqQZkp0IXGhLJ+6xS2W8ovPYIzAQwzRJ44Bi2jlIjJ0o+80hcWfHW4
	2WXlQSUYVnxFBUxk5GvmYnXz/nHn1DK0aO6qMjXcboY15Ub4mggCTVpcJyT83W0Fv5ZKjN
	56/d1Sm/Ugvy2xliVbtGGEahLMg0PPE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-379-esd_9CBnMeKtjM2a6TNI2w-1; Wed, 27 Sep 2023 09:50:51 -0400
X-MC-Unique: esd_9CBnMeKtjM2a6TNI2w-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4059475c174so63170315e9.0
        for <linux-nvme@lists.infradead.org>; Wed, 27 Sep 2023 06:50:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695822650; x=1696427450;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BVpbgUeHi/mHXfQ/dMUC8ZtJs1BZv76r9JDeQErJDHY=;
        b=ENqqax1kU6xjefX11UsCy3zWJgErf/Wyu05bZfZORWPgfS3cfh+1yUlztrnY9RQy+6
         qG9iwC+0KiVmvRBgYH9mUN8wQneEKQ8z8l+Ee5zcE2slUB5cmVBRfYzAjAPd4ENw6175
         CnrQWB5OI+5fDNTdnTaNXi7kzEvrTn5QDYYWDRtFL+yMNr/jHnFO7KyH5FaUmQpAH/C4
         EJ/J1R8B5Ut1VRt9vlkjjpFDeunDIRE/CyZQRr/+IGydgmGm1oSAkJCWwZFBPXtndgXV
         3huVWIAsUEoFhH9/fCsVCsAN4yqRTb0ukJC4wF5V7LAY2z9GWwGGEhEheeaeE6p42C69
         8hcA==
X-Gm-Message-State: AOJu0YyS8kiXxmJkqkYmrYcICBZSxuQj91GsPok7fI9klZ2E4S5VohyQ
	xIZNYGbA4PxKxalU2/SlJ0fWd9HvFaQ5+xjanKs1mjztDIHxDZM9sCtB4O92p7dqLnsQOExczUe
	d8bW7OS+EcNJ/zZNCQk9tJUzeHDGO0kcs9EKoqO1B1N8=
X-Received: by 2002:a5d:5957:0:b0:321:634d:d022 with SMTP id e23-20020a5d5957000000b00321634dd022mr1649623wri.28.1695822649824;
        Wed, 27 Sep 2023 06:50:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhHWNNWSKR7FZ3vNuDQPb5rQ/yu0/N0XvZ13aOfjH9IrgJt2VhtNQiDNVpvq3EMpQaQ44EigM46tZm3Hx6Cr8=
X-Received: by 2002:a5d:5957:0:b0:321:634d:d022 with SMTP id
 e23-20020a5d5957000000b00321634dd022mr1649612wri.28.1695822649505; Wed, 27
 Sep 2023 06:50:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230925163123.16042-1-emilne@redhat.com> <20230925163123.16042-2-emilne@redhat.com>
 <e034b1ec-68d7-9ccd-4c3f-2bf3c34d3ade@grimberg.me>
In-Reply-To: <e034b1ec-68d7-9ccd-4c3f-2bf3c34d3ade@grimberg.me>
From: Ewan Milne <emilne@redhat.com>
Date: Wed, 27 Sep 2023 09:50:38 -0400
Message-ID: <CAGtn9rkhAttAi_+E_7G5sqtY8d_oUoV5+Qc+W_J8TYFB-rxfBQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] block: introduce blk_queue_nr_active()
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, tsong@purestorage.com, jmeneghi@redhat.com, 
	mlombard@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230927_065054_096909_81A2EE21 
X-CRM114-Status: GOOD (  24.83  )
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

I think it is unfortunately necessary to compute the sum from all the hctxs
because in the general case there could be threads on other CPUs submitting
I/O through another hctx that might significantly affect the result, but I =
can
do some more tests and see how it looks.

-Ewan

On Wed, Sep 27, 2023 at 6:56=E2=80=AFAM Sagi Grimberg <sagi@grimberg.me> wr=
ote:
>
>
>
> On 9/25/23 19:31, Ewan D. Milne wrote:
> > Returns a count of the total number of active requests
> > in a queue.  For non-shared tags (the usual case) this is
> > the sum of nr_active from all of the hctxs.
> >
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
>
> I think that for the purposes of nvme-mpath you should probably be
> interested in the hctx mapped to the running cpu, and not the
> cumulative active requests.
>
> As for BLK_MQ_F_TAG_HCTX_SHARED, this is dead-code until scsi/null makes
> any use of it... but seems fine in theory.
>


