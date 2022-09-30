Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49602C4332F
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Sep 2022 14:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gIimetwHznaZAvAfIsX13X27CMEyzU9Pww8hIggO0fw=; b=xJCF34nWGzEfDBxr3UB8vmxuQM
	ZG7Ur2+RPrkK5dTMilZETIdvBY6z0BiWWSi+t9kmpM4ssiZuJNfBLhBWwnpATjkJCOrSDjCr4vbUi
	Ve7XsWq3kc4TgEh3tXz+3wS5UuNOuEUxuZ2OABPrNnSolHKVDa538o9dD6SN7lihtsBwkHfRRatP8
	WXPtJIMibmDcZrsxvUtb6gBe8tu3XBjcrBh0Jt+RnWGukKvC8d4dfUgI4KnS8cJGZZ5AVhBC3IR71
	igPtO5nwxkwxuCDBfBPulkO88Ri2ta7BEAVGH/QhF4gvJSLGQUvpjB7lStEus4PP7gMuR/2/B56oV
	4bvVV1uQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oeGxy-009kQh-7K; Fri, 30 Sep 2022 14:26:14 +0000
Received: from mail-ua1-x931.google.com ([2607:f8b0:4864:20::931])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oeGdb-009YJE-0K
	for linux-nvme@lists.infradead.org; Fri, 30 Sep 2022 14:05:12 +0000
Received: by mail-ua1-x931.google.com with SMTP id a14so1739670uat.13
        for <linux-nvme@lists.infradead.org>; Fri, 30 Sep 2022 07:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=gIimetwHznaZAvAfIsX13X27CMEyzU9Pww8hIggO0fw=;
        b=cnW1BdIwQxXFqQdIGdQKkJQdMdHlrKFHz1p4DhziNtTs0tO+tJ9Lx0H7U2/5rqoCei
         kk77fR3R4/LKx7IXh8tJMuljKjNchkGeNslTpaetLqrO/jmGRHySVscKwyt5W8W0H0Nw
         3Z6JJ31hsijU0lnXF0jz2TCTRxpt1aBEu5KedM50mNY7biix0dLKjOvd5HttVj+vXILa
         rjTnTgsrQgBGipEnQz6+zfsUH9JS0qqUyO9nV5yrwJB/0vWoDjgwzQL0zn2EUjQx3LEG
         bM+suOgoWvq/QlXHRqddlEtzJ57p+nHhC5P/DH4RSLKyHZ8zRL6Spaboiwp9JTaeKWwO
         teaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=gIimetwHznaZAvAfIsX13X27CMEyzU9Pww8hIggO0fw=;
        b=iTZHP1hXWHeurUMcsPnnPQVllDWYhiNWq/gmjMs7DUFhHVnLzcVQn3YE41e4QmHuBx
         PzzSDm5+eu/ZuKd1jIycx38RQSS6FGzZTXKYYaraXTfH2MIxEnYUvbEUrzPqBFwv8Itl
         NMHIlwDOP0tWHtWdFygKzEf3Lzgh438Cq/nk3k7l7wvKhvHJuBo3Inji36KOnKbuhGiL
         rXrmqAqYOmHPwqFzatqr/c8HV3qDsIxl2MdC5NXuvW8FGgg3wOZjo4m+S3cLqRGhxyMC
         VNGHeH9oFT0+ibGUHSU91nhTcKoPrY4m6QXAb//Jm5u39jqfVT1v9CL7YEoWjHphuzH4
         c5XQ==
X-Gm-Message-State: ACrzQf3KMdoCE+KTmISuHe84EYFvNj0hypWAeL9u/MF8jS+Id8tF91ki
	I8bH+RITSXKOkj7p+B7U3tyYWzjZS+TY/SYU+g==
X-Google-Smtp-Source: AMsMyM7nKCE11zyNdHQZhsFQnKND0g9ACmhxTByy15NScbKCJquyPwcdiRsiKjb6uEP6Kf3aSxAStueT5FM5lY0t4aM=
X-Received: by 2002:a9f:2c46:0:b0:39e:fdd4:d272 with SMTP id
 s6-20020a9f2c46000000b0039efdd4d272mr5040761uaj.64.1664546706776; Fri, 30 Sep
 2022 07:05:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220930062749.152261-1-anuj20.g@samsung.com> <CGME20220930063809epcas5p328b9e14ead49e9612b905e6f5b6682f7@epcas5p3.samsung.com>
 <20220930062749.152261-3-anuj20.g@samsung.com> <a08df763-b84f-0360-f1bf-4dd1da3a97bc@kernel.dk>
In-Reply-To: <a08df763-b84f-0360-f1bf-4dd1da3a97bc@kernel.dk>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Fri, 30 Sep 2022 19:34:30 +0530
Message-ID: <CACzX3At9PmwEV03E0PqjS1H1yz07tco-7GyLCKw_mOqFDHVq6g@mail.gmail.com>
Subject: Re: [PATCH for-next v12 02/12] io_uring: introduce fixed buffer
 support for io_uring_cmd
To: Jens Axboe <axboe@kernel.dk>
Cc: Anuj Gupta <anuj20.g@samsung.com>, hch@lst.de, kbusch@kernel.org, 
	io-uring@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-block@vger.kernel.org, gost.dev@samsung.com, linux-scsi@vger.kernel.org, 
	Kanchan Joshi <joshi.k@samsung.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220930_070511_102474_9D71CF22 
X-CRM114-Status: GOOD (  28.73  )
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

On Fri, Sep 30, 2022 at 7:28 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 9/30/22 12:27 AM, Anuj Gupta wrote:
> > Add IORING_URING_CMD_FIXED flag that is to be used for sending io_uring
> > command with previously registered buffers. User-space passes the buffer
> > index in sqe->buf_index, same as done in read/write variants that uses
> > fixed buffers.
> >
> > Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
> > Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
> > ---
> >  include/linux/io_uring.h      |  2 +-
> >  include/uapi/linux/io_uring.h |  9 +++++++++
> >  io_uring/uring_cmd.c          | 18 +++++++++++++++++-
> >  3 files changed, 27 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/linux/io_uring.h b/include/linux/io_uring.h
> > index 1dbf51115c30..e10c5cc81082 100644
> > --- a/include/linux/io_uring.h
> > +++ b/include/linux/io_uring.h
> > @@ -28,7 +28,7 @@ struct io_uring_cmd {
> >               void *cookie;
> >       };
> >       u32             cmd_op;
> > -     u32             pad;
> > +     u32             flags;
> >       u8              pdu[32]; /* available inline for free use */
> >  };
> >
> > diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
> > index 92f29d9505a6..ab7458033ee3 100644
> > --- a/include/uapi/linux/io_uring.h
> > +++ b/include/uapi/linux/io_uring.h
> > @@ -56,6 +56,7 @@ struct io_uring_sqe {
> >               __u32           hardlink_flags;
> >               __u32           xattr_flags;
> >               __u32           msg_ring_flags;
> > +             __u32           uring_cmd_flags;
> >       };
> >       __u64   user_data;      /* data to be passed back at completion time */
> >       /* pack this to avoid bogus arm OABI complaints */
> > @@ -219,6 +220,14 @@ enum io_uring_op {
> >       IORING_OP_LAST,
> >  };
> >
> > +/*
> > + * sqe->uring_cmd_flags
> > + * IORING_URING_CMD_FIXED    use registered buffer; pass thig flag
> > + *                           along with setting sqe->buf_index.
> > + */
> > +#define IORING_URING_CMD_FIXED       (1U << 0)
> > +
> > +
> >  /*
> >   * sqe->fsync_flags
> >   */
> > diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
> > index 6a6d69523d75..05e8ad8cef87 100644
> > --- a/io_uring/uring_cmd.c
> > +++ b/io_uring/uring_cmd.c
> > @@ -4,6 +4,7 @@
> >  #include <linux/file.h>
> >  #include <linux/io_uring.h>
> >  #include <linux/security.h>
> > +#include <linux/nospec.h>
> >
> >  #include <uapi/linux/io_uring.h>
> >
> > @@ -77,7 +78,22 @@ int io_uring_cmd_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
> >  {
> >       struct io_uring_cmd *ioucmd = io_kiocb_to_cmd(req, struct io_uring_cmd);
> >
> > -     if (sqe->rw_flags || sqe->__pad1)
> > +     if (sqe->__pad1)
> > +             return -EINVAL;
> > +
> > +     ioucmd->flags = READ_ONCE(sqe->uring_cmd_flags);
> > +     if (ioucmd->flags & IORING_URING_CMD_FIXED) {
> > +             struct io_ring_ctx *ctx = req->ctx;
> > +             u16 index;
> > +
> > +             req->buf_index = READ_ONCE(sqe->buf_index);
> > +             if (unlikely(req->buf_index >= ctx->nr_user_bufs))
> > +                     return -EFAULT;
> > +             index = array_index_nospec(req->buf_index, ctx->nr_user_bufs);
> > +             req->imu = ctx->user_bufs[index];
> > +             io_req_set_rsrc_node(req, ctx, 0);
> > +     }
> > +     if (ioucmd->flags & ~IORING_URING_CMD_FIXED)
> >               return -EINVAL;
>
> Not that it _really_ matters, but why isn't this check the first thing
> that is done after reading the flags? No need to respin, I can just move
> it myself.
>
Right, checking this condition should have been the first thing to do after
reading the flags. Thanks for taking care of it.

> --
> Jens Axboe

--
Anuj Gupta

