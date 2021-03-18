Return-Path: <SRS0=ZogQ=IQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10293C433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Mar 2021 05:55:49 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97A0664F0F
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Mar 2021 05:55:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97A0664F0F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=lNOGJ1r9z3526i4ysJQT4NEI7ZOfsH6wozlXGaWmjuQ=; b=Hk/iWA5LzYfsJLCWMthZvyRjZ
	CSpRZINrPLJxkIztqYyAWBa2Xih8ShkBVxVOof6QD/lk5EI896AHGIWM68TSgXAXT62CAFWMrrbSF
	7g7zWWHPskQB6B6URThNlQno5i8LLHn1STdw2BtQor4x3BvPQmRib4fsOJWH8XXBrQw7b2RdQllYG
	R6WIWqGiSi6oliUNmB7Ru4YI2vsy4+8avnuaS8XYU4qUVgc5YwWkppfI8fXiN08rS6WJRADuAyd6d
	td4Xajrlj5wZbKumvyS4ptkVoK+N3qOvZ8xrFCKLYnI4jqz1mEkd3OmOW/LrCAktHDSmbn1ogMw4G
	b5hICh4wQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lMlcj-004ZIu-4P; Thu, 18 Mar 2021 05:55:09 +0000
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lMlcd-004ZI3-Bp
 for linux-nvme@lists.infradead.org; Thu, 18 Mar 2021 05:55:05 +0000
Received: by mail-wr1-x42f.google.com with SMTP id v11so4174850wro.7
 for <linux-nvme@lists.infradead.org>; Wed, 17 Mar 2021 22:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=e6XYWNN/vIflygnMc5hEvr+N00R83qDR2mYo4MniNC8=;
 b=gkqbo2CiuQrZvvW5KR5wLQTKAn/vsKPDhqZjYIkwe2rf56gCXhsuh9HJKyB/stX/rd
 oblOZIBovjfg5g52FNlJ24hR75R2+FQvY5Cyee9dsnk6lvhwS0JrC/2qnipSySfV2Wi+
 yaPLFqVpXjgrWtUVw/qtsmFKbDfQb11bDaAWGDnElmCWJny+DP1wTVJj8jTtifVs82FE
 O3Ii/Sg3IERh+pqCwDhjkZIgNKv+NDtUDCtis2AA/RIAqhizX1blehJYY4PXN05zV8M2
 tYxqClmrFe7SjgjtZ/p55GWIpvRunb3R1GJZVvx+Ny6+Z21K/gPyAIwugoOHCQmLN7W8
 ryBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=e6XYWNN/vIflygnMc5hEvr+N00R83qDR2mYo4MniNC8=;
 b=td2SuKb/n8HA02cV+d9L1dzmDyCxQzQA/wCK52o0uZHUW9AaALeAdO2fWs4y1D/y1X
 dInkQNaKjYGzacobY/X7vWUfKwWUWApaGjvBaRAhM1ajHN6yQcrVLOBA54phxy7ggYow
 vqqGSSp26FIzzxZTMTnhsZ0WSB9Cs9+ARqHS69GbBvT+44ozQ+TcNgMCknYoD8NiIkzU
 mFu4YO95F4wGFjKUukvp+I7WD1wvD+cVgnG6pLQ6tyT4vGIS63278PqKkxqpOz3Er1fd
 qtrZtqaOqjr8VuJsw5vm5iHvTuWteH4R54pQqshWBncv4kH0UmK6hIpL1Ss27X0TefeL
 seUA==
X-Gm-Message-State: AOAM532Vimk5tASJYukvfNiTUKflh9Oc1qPx6dPdX1wmUqFAEJ/7F63W
 XREcaU2g+Fm258eRP7NHPPchu3JRX79HgVZAKQs=
X-Google-Smtp-Source: ABdhPJwAXTDwYV7+sxnSjT+09aPVYfqmr5rmS14GFNtNwcRevMBRfdutxo5z461O6eMvTC4ERbNm1DwCGRBqClyXZiU=
X-Received: by 2002:a5d:5906:: with SMTP id v6mr7867438wrd.137.1616046902176; 
 Wed, 17 Mar 2021 22:55:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210316140126.24900-1-joshi.k@samsung.com>
 <CGME20210316140240epcas5p3e71bfe2afecd728c5af60056f21cc9b7@epcas5p3.samsung.com>
 <20210316140126.24900-4-joshi.k@samsung.com> <20210317085258.GA19580@lst.de>
In-Reply-To: <20210317085258.GA19580@lst.de>
From: Kanchan Joshi <joshiiitr@gmail.com>
Date: Thu, 18 Mar 2021 11:24:34 +0530
Message-ID: <CA+1E3rJ62b8aRBnZzsQAUD2pZVrFAWUwd1jnS_mts=x9=fzt-w@mail.gmail.com>
Subject: Re: [RFC PATCH v3 3/3] nvme: wire up support for async passthrough
To: Christoph Hellwig <hch@lst.de>
Cc: Kanchan Joshi <joshi.k@samsung.com>, Jens Axboe <axboe@kernel.dk>, 
 Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, io-uring@vger.kernel.org, 
 linux-nvme@lists.infradead.org, anuj20.g@samsung.com, 
 Javier Gonzalez <javier.gonz@samsung.com>,
 Nitesh Shetty <nj.shetty@samsung.com>, 
 Selvakumar S <selvakuma.s1@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210318_055503_804849_6334FE5B 
X-CRM114-Status: GOOD (  37.10  )
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

On Wed, Mar 17, 2021 at 2:24 PM Christoph Hellwig <hch@lst.de> wrote:
>
> > +/*
> > + * This is carved within the block_uring_cmd, to avoid dynamic allocation.
> > + * Care should be taken not to grow this beyond what is available.
> > + */
> > +struct uring_cmd_data {
> > +     union {
> > +             struct bio *bio;
> > +             u64 result; /* nvme cmd result */
> > +     };
> > +     void *meta; /* kernel-resident buffer */
> > +     int status; /* nvme cmd status */
> > +};
> > +
> > +inline u64 *ucmd_data_addr(struct io_uring_cmd *ioucmd)
> > +{
> > +     return &(((struct block_uring_cmd *)&ioucmd->pdu)->unused[0]);
> > +}
>
> The whole typing is a mess, but this mostly goes back to the series
> you're basing this on.  Jens, can you send out the series so that
> we can do a proper review?
>
> IMHO struct io_uring_cmd needs to stay private in io-uring.c, and
> the method needs to get the file and the untyped payload in form
> of a void * separately.  and block_uring_cmd should be private to
> the example ioctl, not exposed to drivers implementing their own
> schemes.
>
> > +void ioucmd_task_cb(struct io_uring_cmd *ioucmd)
>
> This should be mark static and have a much more descriptive name
> including a nvme_ prefix.

Yes. Will change.

> > +     /* handle meta update */
> > +     if (ucd->meta) {
> > +             void __user *umeta = nvme_to_user_ptr(ptcmd->metadata);
> > +
> > +             if (!ucd->status)
> > +                     if (copy_to_user(umeta, ucd->meta, ptcmd->metadata_len))
> > +                             ucd->status = -EFAULT;
> > +             kfree(ucd->meta);
> > +     }
> > +     /* handle result update */
> > +     if (put_user(ucd->result, (u32 __user *)&ptcmd->result))
>
> The comments aren't very useful, and the cast here is a warning sign.
> Why do you need it?

Will do away with cast and comments.

> > +             ucd->status = -EFAULT;
> > +     io_uring_cmd_done(ioucmd, ucd->status);
>
> Shouldn't the io-uring core take care of this io_uring_cmd_done
> call?

At some point we (driver) need to tell the io_uring that command is
over, and return the status to it so that uring can update CQE.
This call "io_uring_cmd_done" does just that.

> > +void nvme_end_async_pt(struct request *req, blk_status_t err)
>
> static?

Indeed. Will change.

> > +{
> > +     struct io_uring_cmd *ioucmd;
> > +     struct uring_cmd_data *ucd;
> > +     struct bio *bio;
> > +     int ret;
> > +
> > +     ioucmd = req->end_io_data;
> > +     ucd = (struct uring_cmd_data *) ucmd_data_addr(ioucmd);
> > +     /* extract bio before reusing the same field for status */
> > +     bio = ucd->bio;
> > +
> > +     if (nvme_req(req)->flags & NVME_REQ_CANCELLED)
> > +             ucd->status = -EINTR;
> > +     else
> > +             ucd->status = nvme_req(req)->status;
> > +     ucd->result = le64_to_cpu(nvme_req(req)->result.u64);
> > +
> > +     /* this takes care of setting up task-work */
> > +     ret = uring_cmd_complete_in_task(ioucmd, ioucmd_task_cb);
> > +     if (ret < 0)
> > +             kfree(ucd->meta);
> > +
> > +     /* unmap pages, free bio, nvme command and request */
> > +     blk_rq_unmap_user(bio);
> > +     blk_mq_free_request(req);
>
> How can we free the request here if the data is only copied out in
> a task_work?

Things that we want to use in task_work (command status and result)
are alive in "ucd" (which is carved inside uring_cmd itself, and will
not be reclaimed until we tell io_uring that command is over).
The meta buffer is separate, and it is also alive via ucd->meta. It
will be freed only in task-work.
bio/request/pages cleanup do not have to wait till task-work.

> >  static int nvme_submit_user_cmd(struct request_queue *q,
> >               struct nvme_command *cmd, void __user *ubuffer,
> >               unsigned bufflen, void __user *meta_buffer, unsigned meta_len,
> > -             u32 meta_seed, u64 *result, unsigned timeout)
> > +             u32 meta_seed, u64 *result, unsigned int timeout,
> > +             struct io_uring_cmd *ioucmd)
> >  {
> >       bool write = nvme_is_write(cmd);
> >       struct nvme_ns *ns = q->queuedata;
> > @@ -1179,6 +1278,20 @@ static int nvme_submit_user_cmd(struct request_queue *q,
> >                       req->cmd_flags |= REQ_INTEGRITY;
> >               }
> >       }
> > +     if (ioucmd) { /* async handling */
>
> nvme_submit_user_cmd already is a mess.  Please split this out into
> a separate function.  Maybe the logic to map the user buffers can be
> split into a little shared helper.

Ok. I will look at refactoring the way you mentioned.

> > +int nvme_uring_cmd(struct request_queue *q, struct io_uring_cmd *ioucmd,
> > +             enum io_uring_cmd_flags flags)
>
> Another comment on the original infrastructure:  this really needs to
> be a block_device_operations method taking a struct block_device instead
> of being tied into blk-mq.
>
> > +EXPORT_SYMBOL_GPL(nvme_uring_cmd);
>
> I don't think this shoud be exported.

It is needed to populate the callback in PCI transport. Not right?


Thanks for the detailed review.
-- 
Kanchan

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
