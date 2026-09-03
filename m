Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE4B4C61DD3
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Sep 2026 17:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7ewABu/OdmOVe+HOqk4r9aZ2OhRinVo0iIDSSoR7VOc=; b=01Yp2/hOTPSgk9RNTmLkXRVaz4
	7I0VZDvITSK5tdw4FojG+4P6mWGi7IqoPkw5EVMSwL78qbemdkzs1B+9bGH9tQh7tPkz3aTiW+r4e
	Lq8YGo6UIcR7MCcvlpd/Js/0H7DQyz6B5O4HCUFWaPD3bIrHSNJO5iOCjzCpO7RiGvsjf3UeYR8Ty
	pVK3UnDIAMMVljOc1gdrVCCPS+9BQiNU8bFrQe3dis7HsTxu5KHWtFEoNC81aMYTR+swwr8cZV8PT
	FYHEuj+JNzIAGtj/trglGaA4mqtC7sYUJdvMStZyCZz74tVp6pb5HlMWss7EVVW6Wu3xW8HxGEzqZ
	uAKQM3Hg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x2BL2-00000000HwN-10vK;
	Thu, 03 Sep 2026 17:35:00 +0000
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x2BKz-00000000Hvh-0z2u
	for linux-nvme@lists.infradead.org;
	Thu, 03 Sep 2026 17:34:59 +0000
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-4ab3c6f7f44so11944b6e.3
        for <linux-nvme@lists.infradead.org>; Thu, 03 Sep 2026 10:34:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788456896; cv=none;
        d=google.com; s=arc-20260327;
        b=kXNYwzpM7hYZzAlv9lS5psw47tDycaNZM6iRS9HIPqPTUyGhJ5ayP44NV6Tv+lirj0
         xx/Etpy2tqU2b4DDgSJT24g7WWR6m4V3jzF0DvR6+O9A2E0w92q/fGYAfYEs8vz5g+cv
         KZEHyMq0MLtc5ty14t36VjVIM6/QQ2UvZvRdq8dU4y7Dk1BfDJRlATnHwMNEgTtoTRMW
         As86wv62BPWE/aAKYHykXCsLzMabS4fFuKPM9Arrl6hjDJ8Mk8uPhvJH3hbv9HD7fcPN
         GISNIWArglsYg2hbM4C6fOvp8sy7d3rwmJKIYFJ9wcOxKMdpAx35HSKXwVQAlZFOxsVn
         YI7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7ewABu/OdmOVe+HOqk4r9aZ2OhRinVo0iIDSSoR7VOc=;
        fh=rr7gSjHc5fCJ3hZRWQKMWCdbeMce9/tp74f2bZj+ntc=;
        b=aHevdSf9CZNokYr6rBDE7YO41xqYoWsFf30tzEDuwnXtBjSUaIqTWIeI5dQ7hACG6Q
         4ScOFQ81FW3iiDXp6p0QBezGsjw983FG7p17ZZBMD0qTxT5E+ysHM6udHjApLBD/mU2I
         n2lzzuXAspnoPCDXfXU/i80q3bePER3S5fGQBDAlEYRgaxtTZivclNuH/I/FGRKeIWTL
         WUpUdDUEVkzp0nFpq4DsogmStqZ6Tmzl2Mc66RSTAAdTOkBh0zwU+w2hwVhboOTiu417
         w2ohTsObOEQZyabA2i0k5GhSVt6kqp7KZktplOSiHCqp/952m2aHBqk/lwn5aC1KcJkP
         vp3g==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1788456896; x=1789061696; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7ewABu/OdmOVe+HOqk4r9aZ2OhRinVo0iIDSSoR7VOc=;
        b=Fibn2d2MCF+9IkvtxHJjZY1MwDM7asT4uOh5pgOccDAtT8/bmL0l1v+kq4JhlqLzwv
         Tle6M+a0gMTDQZ1cbqVc8HNSqd7ASGjXo7ArwDxPyDe7ai9h0z3xz44kFJCK9BgBYY/L
         v8idGWzbD4QuQ8Eei6tUR9/oZ6HQH98tyjK25XNxRQR7w0sDmSa0MbRAzu0b1NQjSW8Q
         tRhyjq+sqLUmtFYwApKvxmhRXipCzYIZ7Sxsx5J4U/Ib0XNXWLer6mCJ2H4Q21PrpZGR
         EgYUmlJHuclBpGs/6IWBKtN5bSEGhZMPwbE3yKnSETxydp+MS/tLnB6WagTr4vg6/R8h
         B9Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788456896; x=1789061696;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7ewABu/OdmOVe+HOqk4r9aZ2OhRinVo0iIDSSoR7VOc=;
        b=a3ncp/LEH3mVEeGDJKATRnCBnMHZXcmHMgHXHRfj6iFINArsVizKdcuoJ6VXkGl07+
         BRL/sfi4jtSPwXFHw2nYQnObpPYTQlKWf0l/2HObzkxi4C1iZoRjOAI/0uHxfqODiO97
         FqhhiigwHFB5032HyC0qF4JZAYMlXgyFHBjIw+oa7T59l4JrhOTTyim1xsMhNwTukCYa
         z7XZppzyRXX2jjDlGk2xf6oaCKcxhsScBMY+ASsGyINf+NxhqBCxwvK4s2WxmQIFL2gR
         JXSjJHRwDeafQIrBVuNpk6hgtfD1ACm6agpcihzWIEUZM6JyVzAYG/+pBN2DfAbVIM9o
         SVrw==
X-Forwarded-Encrypted: i=1; AKwUvBwNKak6Q+56ji70k1FBy7SzLptKOSvxo9SiD069MAantHR3u3JdGcLQ0uMLnOvpMTRXUVwcT1CUKcFd@lists.infradead.org
X-Gm-Message-State: AFuF++n+9qAsijf7xVCVufFhJtYoluJVufkhNyRGj0ar4G1g+su0Cecn
	0PGmsZk6M+h6E1CzmtTkvt3kiXgKXLIRKhxb/TOmItji4qAinqQW2BZj0U1/gDizdKb+3Pmoias
	OEAo2e0oMNStKeHV9f5YXmMra5GtojGOPsB5OS0s/pg==
X-Gm-Gg: AYBFou0J7MhIxCVwUmeu9fg7NTsWE0XhG9Oae3uwMtJGZLnBo8TiXTV+HxEwKceO7NM
	WJ4+BgJwuDG1quy9T7AeSXT3G/shdckEPNDYhrMumcOo9MifuIg/HOee0wenq8tZ1j2g7qXFNmd
	5nQfqtRGvBcuk4xqNnpBkiHhar4iqf0+0mgguPfqtHrcigG7TpXVNGHWAObmSZDkYmiz/vlLWcT
	r4LnR54Xm9wTnlI6OkwnTcbKyFgs7h7rGl0k349e/Yjc4u191mzM4OJJz7KkTFEX0FTDdpFBh0a
	+yDhFG3pAp0wVu6DJ++5c6twKxKssvdo/maf6D7nVup1
X-Received: by 2002:a05:6808:30a6:b0:4b5:8402:958d with SMTP id
 5614622812f47-4b6bfbcfc9amr6567061b6e.5.1788456895883; Thu, 03 Sep 2026
 10:34:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260902225708.2379840-1-csander@purestorage.com>
 <20260902225708.2379840-2-csander@purestorage.com> <CACVXFVOKGOEmefHmZpsBX-7uxGjzbaJiueYMvka8TDjccOuFjg@mail.gmail.com>
In-Reply-To: <CACVXFVOKGOEmefHmZpsBX-7uxGjzbaJiueYMvka8TDjccOuFjg@mail.gmail.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Thu, 3 Sep 2026 10:34:43 -0700
X-Gm-Features: AcwNN1W9WnICv9pGfNodLq9yLwaSICnIyXjRpvwIb40wmKIKgI6KwpbmnVrMA7k
Message-ID: <CADUfDZqFLMS08wq0bJWQwKpJL5k9ty1bruVFQFcV6juFVB-9AQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] io_uring/cmd: split io_uring_cmd_set_res() from io_uring_cmd_done()
To: Ming Lei <tom.leiming@gmail.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, Joanne Koong <joannelkoong@gmail.com>, 
	linux-nvme@lists.infradead.org, io-uring@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260903_103457_473581_4F52B45E 
X-CRM114-Status: GOOD (  27.30  )
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

On Wed, Sep 2, 2026 at 6:02=E2=80=AFPM Ming Lei <tom.leiming@gmail.com> wro=
te:
>
> On Wed, Sep 2, 2026 at 6:05=E2=80=AFPM Caleb Sander Mateos
> <csander@purestorage.com> wrote:
> >
> > In preparation for setting the io_uring NVMe passthru CQE results from
> > the blk-mq request completion rather than the task work callback, split
> > out functions io_uring_cmd_set_res{,32}() from __io_uring_cmd_done().
> > io_uring_cmd_done{,32}() now call io_uring_cmd_set_res{,32}() and then
> > __io_uring_cmd_done(). This allows __io_uring_cmd_done() to be made
> > CQE-size-agnostic, with 3 fewer arguments.
> >
> > Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> > ---
> >  include/linux/io_uring/cmd.h | 23 +++++++++++++++++------
> >  io_uring/uring_cmd.c         | 33 ++++++++++++++++++---------------
> >  2 files changed, 35 insertions(+), 21 deletions(-)
> >
> > diff --git a/include/linux/io_uring/cmd.h b/include/linux/io_uring/cmd.=
h
> > index 331dcbefe72f..67f2ef700c43 100644
> > --- a/include/linux/io_uring/cmd.h
> > +++ b/include/linux/io_uring/cmd.h
> > @@ -50,19 +50,21 @@ int io_uring_cmd_import_fixed_vec(struct io_uring_c=
md *ioucmd,
> >                                   const struct iovec __user *uvec,
> >                                   size_t uvec_segs,
> >                                   int ddir, struct iov_iter *iter,
> >                                   unsigned issue_flags);
> >
> > +void io_uring_cmd_set_res(struct io_uring_cmd *, s32 ret);
> > +void io_uring_cmd_set_res32(struct io_uring_cmd *, s32 ret, u64 res2);
> > +
> >  /*
> >   * Completes the request, i.e. posts an io_uring CQE and deallocates @=
ioucmd
> >   * and the corresponding io_uring request.
> >   *
> >   * Note: the caller should never hard code @issue_flags and is only al=
lowed
> >   * to pass the mask provided by the core io_uring code.
> >   */
> > -void __io_uring_cmd_done(struct io_uring_cmd *cmd, s32 ret, u64 res2,
> > -                        unsigned issue_flags, bool is_cqe32);
> > +void __io_uring_cmd_done(struct io_uring_cmd *, unsigned issue_flags);
> >
> >  void __io_uring_cmd_do_in_task(struct io_uring_cmd *ioucmd,
> >                             io_req_tw_func_t task_work_cb,
> >                             unsigned flags);
> >
> > @@ -105,12 +107,19 @@ static inline int io_uring_cmd_import_fixed_vec(s=
truct io_uring_cmd *ioucmd,
> >                                                 int ddir, struct iov_it=
er *iter,
> >                                                 unsigned issue_flags)
> >  {
> >         return -EOPNOTSUPP;
> >  }
> > -static inline void __io_uring_cmd_done(struct io_uring_cmd *cmd, s32 r=
et,
> > -               u64 ret2, unsigned issue_flags, bool is_cqe32)
> > +static inline void io_uring_cmd_set_res(struct io_uring_cmd *cmd, s32 =
ret)
> > +{
> > +}
> > +static inline void io_uring_cmd_set_res32(struct io_uring_cmd *cmd, s3=
2 ret,
> > +                                         u64 res2)
> > +{
> > +}
> > +static inline void __io_uring_cmd_done(struct io_uring_cmd *cmd,
> > +                                      unsigned issue_flags)
> >  {
> >  }
> >  static inline void __io_uring_cmd_do_in_task(struct io_uring_cmd *iouc=
md,
> >                             io_req_tw_func_t task_work_cb, unsigned fla=
gs)
> >  {
> > @@ -171,17 +180,19 @@ static inline void *io_uring_cmd_ctx_handle(struc=
t io_uring_cmd *cmd)
> >  }
> >
> >  static inline void io_uring_cmd_done(struct io_uring_cmd *ioucmd, s32 =
ret,
> >                                      unsigned issue_flags)
> >  {
> > -       return __io_uring_cmd_done(ioucmd, ret, 0, issue_flags, false);
> > +       io_uring_cmd_set_res(ioucmd, ret);
> > +       __io_uring_cmd_done(ioucmd, issue_flags);
> >  }
> >
> >  static inline void io_uring_cmd_done32(struct io_uring_cmd *ioucmd, s3=
2 ret,
> >                                        u64 res2, unsigned issue_flags)
> >  {
> > -       return __io_uring_cmd_done(ioucmd, ret, res2, issue_flags, true=
);
> > +       io_uring_cmd_set_res32(ioucmd, ret, res2);
> > +       __io_uring_cmd_done(ioucmd, issue_flags);
> >  }
> >
> >  int io_buffer_register_bvec(struct io_uring_cmd *cmd, struct request *=
rq,
> >                             void (*release)(void *), unsigned int index=
,
> >                             unsigned int issue_flags);
> > diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
> > index 726a659f38c3..917b32a921e6 100644
> > --- a/io_uring/uring_cmd.c
> > +++ b/io_uring/uring_cmd.c
> > @@ -136,40 +136,43 @@ void __io_uring_cmd_do_in_task(struct io_uring_cm=
d *ioucmd,
> >         req->io_task_work.func =3D task_work_cb;
> >         __io_req_task_work_add(req, flags);
> >  }
> >  EXPORT_SYMBOL_GPL(__io_uring_cmd_do_in_task);
> >
> > -static inline void io_req_set_cqe32_extra(struct io_kiocb *req,
> > -                                         u64 extra1, u64 extra2)
> > +void io_uring_cmd_set_res(struct io_uring_cmd *cmd, s32 ret)
> >  {
> > -       req->big_cqe.extra1 =3D extra1;
> > -       req->big_cqe.extra2 =3D extra2;
> > +       struct io_kiocb *req =3D cmd_to_io_kiocb(cmd);
> > +
> > +       if (ret < 0)
> > +               req_set_fail(req);
> > +       io_req_set_res(req, ret, 0);
> >  }
> > +EXPORT_SYMBOL_GPL(io_uring_cmd_set_res);
> > +
> > +void io_uring_cmd_set_res32(struct io_uring_cmd *cmd, s32 ret, u64 res=
2)
> > +{
> > +       struct io_kiocb *req =3D cmd_to_io_kiocb(cmd);
> > +
> > +       if (ret < 0)
> > +               req_set_fail(req);
> > +       io_req_set_res32(req, ret, 0, res2, 0);
> > +}
> > +EXPORT_SYMBOL_GPL(io_uring_cmd_set_res32);
>
> Both the two helpers can be inline, can't they?

I also wanted to do that, but req_set_*() are defined in
io_uring/io_uring.h, an io_uring-private header, whereas
include/linux/io_uring/cmd.h is a public header. Perhaps the inline
functions could be moved to include/linux/io_uring_types.h or
include/linux/io_uring.h. If not, I think we'll have to rely on LTO to
inline these calls. I'd be curious to hear Jens's thoughts.

Best,
Caleb

