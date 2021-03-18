Return-Path: <SRS0=ZogQ=IQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B94ADC433DB
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Mar 2021 05:26:53 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3852861580
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Mar 2021 05:26:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3852861580
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=5RsZXA+2q7MAC2dckUXGu+OwINzolTpDiLgXs1SUzyw=; b=hwAF43AgXqPmUYM4+41EUDuKW
	u6NBHwWfcoT65kf7OnMDueTzYMLj+lw6R7ErlLOHun9e6+jTylW3vc93+DkSFtb42fXZxXQzN1xZn
	/jcFOqwu59yb2kqguSI6eo59u7WE/jEiHRDmvxNeg28Ce2Acd2bS3JEL3R3lNS5kpcHMfn5fgVID2
	yX13aEjvzFabeYAHlToPT6kwbQOmbvw0XUfOu0PAX7I84ef2TiJHZceJxNFbs/vHAhFS+nUe1k3qU
	C1vNn7EYUGNFUU1+fK6+btQLO1Iq6bkMg4rZBNnPI3Slm6HgWlJukQ0jbL9vwHFGmnHrPk+32sWYG
	Gk7jfYZLg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lMlB1-004WR1-Eo; Thu, 18 Mar 2021 05:26:31 +0000
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lMlAt-004WQO-Dx
 for linux-nvme@lists.infradead.org; Thu, 18 Mar 2021 05:26:26 +0000
Received: by mail-wm1-x329.google.com with SMTP id
 b2-20020a7bc2420000b029010be1081172so2575555wmj.1
 for <linux-nvme@lists.infradead.org>; Wed, 17 Mar 2021 22:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=oNLbqwtqC3zQTJ/OunvctMSzZaiWtNoR0TFwEeoJSpo=;
 b=oa9tShNI5vZqssznIckIOzQaPQgzUGStIWx4OShHbI6IBoZWRk6GZXcqztfIhprHPI
 S5INjlDDp95w3XgfMVmeGaxw+B33+Wp3C8WeDRKP7hiJ/9zrnOz6WrqaHZkILC6mtOxF
 ZbON5EAcVbXJVqtfWdUqOl0624Mf4T4VjduIBP9u59fJ6RFfyatsp5xreItpkmoE6kvL
 JS/stEz4rv4h1g8FcwrkPl2rDIpbrie7qORukBGfB29kuCVXqcx+Mv+Ggq4SIB4a3HXG
 MaP4ylkS/IRwmSqpECyScW9mBfEbdzl6frU9p2bZ/kjDO/yo+eOcs80zVnz1Pt8SdyBf
 AQVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=oNLbqwtqC3zQTJ/OunvctMSzZaiWtNoR0TFwEeoJSpo=;
 b=NoBM9Tp2JZLjcennALdPfJ+Gg8gt1OTmwklie3oTdSwvbaKHw2Y3iAc3RiCcVAP34/
 DcAa8TL7N9hpN70MSPNjdyqpGtK34vEphEcAr3HMNEDfOW95WEbmJ7lu4NNWCV6mIA6u
 pQxX1HS81OMd3jbMXmMpj4US1BWGMYdyoyFdCd+ItRhTgSwbKdgzCRdEGjYSJlH2p15O
 kti4pexU5naVLwST+Amtj7kaqZJLTjv3o6sD8jm7KCYIh6m4pt0U/mt/TviiBT70dSFX
 0CUJydL9mmjrOKljJqBQE1QXpFzwu+sLJN70j7lfFUYDFNmt/mV9w9+acytwL9ZN+kBK
 x91A==
X-Gm-Message-State: AOAM532uI6YfQiDfq1wUBCkuywe9v6To+qYrM7SvEEJOElzgqbTLu5jZ
 IoybY7Mw7fiXbqz+TVUczKyNjJ1PigVNQyz4uvQ48k2fMDK6RQ==
X-Google-Smtp-Source: ABdhPJxV1V4bXjN4izL69vXbsFRYLHmYRPSUsIuA1v676FfcQY4GFpi/hyQIRFZY3MCrzAdaDtDsCR0Zyu8sNsmejVA=
X-Received: by 2002:a05:600c:1913:: with SMTP id
 j19mr1772482wmq.155.1616045182634; 
 Wed, 17 Mar 2021 22:26:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210316140126.24900-1-joshi.k@samsung.com>
 <CGME20210316140233epcas5p372405e7cb302c61dba5e1094fa796513@epcas5p3.samsung.com>
 <20210316140126.24900-2-joshi.k@samsung.com>
 <05a91368-1ba8-8583-d2ab-8db70b92df76@kernel.dk>
In-Reply-To: <05a91368-1ba8-8583-d2ab-8db70b92df76@kernel.dk>
From: Kanchan Joshi <joshiiitr@gmail.com>
Date: Thu, 18 Mar 2021 10:55:55 +0530
Message-ID: <CA+1E3r+Mt7KKeFeYf7WY3CoKwnkXT-jE2EgJSTE6zaAfJX0dzQ@mail.gmail.com>
Subject: Re: [RFC PATCH v3 1/3] io_uring: add helper for uring_cmd completion
 in submitter-task
To: Jens Axboe <axboe@kernel.dk>
Cc: Kanchan Joshi <joshi.k@samsung.com>, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, 
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, io-uring@vger.kernel.org, 
 linux-nvme@lists.infradead.org, anuj20.g@samsung.com, 
 Javier Gonzalez <javier.gonz@samsung.com>,
 Nitesh Shetty <nj.shetty@samsung.com>, 
 Selvakumar S <selvakuma.s1@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210318_052623_664937_5F627F28 
X-CRM114-Status: GOOD (  37.14  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Mar 18, 2021 at 7:31 AM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 3/16/21 8:01 AM, Kanchan Joshi wrote:
> > Completion of a uring_cmd ioctl may involve referencing certain
> > ioctl-specific fields, requiring original subitter context.
> > Introduce 'uring_cmd_complete_in_task' that driver can use for this
> > purpose. The API facilitates task-work infra, while driver gets to
> > implement cmd-specific handling in a callback.
> >
> > Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
> > ---
> >  fs/io_uring.c            | 36 ++++++++++++++++++++++++++++++++----
> >  include/linux/io_uring.h |  8 ++++++++
> >  2 files changed, 40 insertions(+), 4 deletions(-)
> >
> > diff --git a/fs/io_uring.c b/fs/io_uring.c
> > index 583f8fd735d8..ca459ea9cb83 100644
> > --- a/fs/io_uring.c
> > +++ b/fs/io_uring.c
> > @@ -772,9 +772,12 @@ struct io_kiocb {
> >               /* use only after cleaning per-op data, see io_clean_op() */
> >               struct io_completion    compl;
> >       };
> > -
> > -     /* opcode allocated if it needs to store data for async defer */
> > -     void                            *async_data;
> > +     union {
> > +             /* opcode allocated if it needs to store data for async defer */
> > +             void                            *async_data;
> > +             /* used for uring-cmd, when driver needs to update in task */
> > +             void (*driver_cb)(struct io_uring_cmd *cmd);
> > +     };
>
> I don't like this at all, it's very possible that we'd need async
> data for passthrough commands as well in certain cases. And what it
> gets to that point, we'll have no other recourse than to un-unionize
> this and pay the cost. It also means we end up with:
>
> > @@ -1716,7 +1719,7 @@ static void io_dismantle_req(struct io_kiocb *req)
> >  {
> >       io_clean_op(req);
> >
> > -     if (req->async_data)
> > +     if (io_op_defs[req->opcode].async_size && req->async_data)
> >               kfree(req->async_data);
> >       if (req->file)
> >               io_put_file(req, req->file, (req->flags & REQ_F_FIXED_FILE));
>
> which are also very fragile.

I did not want to have it this way....but faced troubles with the more
natural way of doing this. Please see below.

> We already have the task work, just have the driver init and/or call a
> helper to get it run from task context with the callback it desires?
>
> If you look at this:
>
> > @@ -2032,6 +2035,31 @@ static void io_req_task_submit(struct callback_head *cb)
> >       __io_req_task_submit(req);
> >  }
> >
> > +static void uring_cmd_work(struct callback_head *cb)
> > +{
> > +     struct io_kiocb *req = container_of(cb, struct io_kiocb, task_work);
> > +     struct io_uring_cmd *cmd = &req->uring_cmd;
> > +
> > +     req->driver_cb(cmd);
> > +}
> > +int uring_cmd_complete_in_task(struct io_uring_cmd *ioucmd,
> > +                     void (*driver_cb)(struct io_uring_cmd *))
> > +{
> > +     int ret;
> > +     struct io_kiocb *req = container_of(ioucmd, struct io_kiocb, uring_cmd);
> > +
> > +     req->driver_cb = driver_cb;
> > +     req->task_work.func = uring_cmd_work;
> > +     ret = io_req_task_work_add(req);
> > +     if (unlikely(ret)) {
> > +             req->result = -ECANCELED;
> > +             percpu_ref_get(&req->ctx->refs);
> > +             io_req_task_work_add_fallback(req, io_req_task_cancel);
> > +     }
> > +     return ret;
> > +}
> > +EXPORT_SYMBOL(uring_cmd_complete_in_task);
>
> Then you're basically jumping through hoops to get that callback.
> Why don't you just have:
>
> io_uring_schedule_task(struct io_uring_cmd *cmd, task_work_func_t cb)
> {
>         struct io_kiocb *req = container_of(cmd, struct io_kiocb, uring_cmd);
>         int ret;
>
>         req->task_work.func = cb;
>         ret = io_req_task_work_add(req);
>         if (unlikely(ret)) {
>                 req->result = -ECANCELED;
>                 io_req_task_work_add_fallback(req, io_req_task_cancel);
>         }
>         return ret;
> }
>
> ?
I started with that, but the problem was implementing the driver callback .
The callbacks receive only one argument which is "struct callback_head
*", and the driver needs to extract "io_uring_cmd *" out of it.
This part -
+static void uring_cmd_work(struct callback_head *cb)
+{
+     struct io_kiocb *req = container_of(cb, struct io_kiocb, task_work);
+     struct io_uring_cmd *cmd = &req->uring_cmd;

If the callback has to move to the driver (nvme), the driver needs
visibility to "struct io_kiocb" which is uring-local.
Do you see a better way to handle this?
I also thought about keeping the driver_cb inside the unused part of
uring_cmd (instead of union with req->async_data), but it had two
problems - 1. uring needs to peek inside driver-part of uring_cmd to
invoke this callback
2. losing precious space  (I am using that space to avoid per-command
dynamic-allocation in driver)

> Also, please export any symbol with _GPL. I don't want non-GPL drivers
> using this infrastructure.

Got it.


-- 
Kanchan

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
