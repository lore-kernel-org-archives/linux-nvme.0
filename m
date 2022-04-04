Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53811C433F5
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Apr 2022 15:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Cxv6eRZihM5d2+KA9Gy/o6F4LSNKpnki/Cp9tds22EU=; b=L5GKk2eEFh2oHBX0/FH5pzk6lD
	yFdOeeYaNVrYjaOLHk/DSgYoACvkogHf4s9v1V4sp7vHH1VoQsC+OYZP4cI4FT7kxbdzaVirzlcOH
	ld8Kl7zOnk6ZkPWgrJICH7egsxN66uRtmJBid0sN99iwrAAkW5qyV6ooh1+7vfadYsW3Ko0LJvyf3
	yMy/3TY/3ffvrtw4Wd4qFfNWJxIkmfoCuGWrkfQcV1E9+vqDDKuNbvgeyR8JjHTN+PWt+ngYHxCjO
	NDq5ppV0CpQLXHE50jVdzRArH6f8k/XQIyhVx8MndsL8jJS+0pK/z01qXauv0sfa/S/RUrw0Bhzl/
	pJvM0M7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nbOPs-00FWGM-CZ; Mon, 04 Apr 2022 15:14:52 +0000
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nbOPp-00FWFB-9F
 for linux-nvme@lists.infradead.org; Mon, 04 Apr 2022 15:14:50 +0000
Received: by mail-ot1-x329.google.com with SMTP id
 b17-20020a0568301df100b005ce0456a9efso7420756otj.9
 for <linux-nvme@lists.infradead.org>; Mon, 04 Apr 2022 08:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Cxv6eRZihM5d2+KA9Gy/o6F4LSNKpnki/Cp9tds22EU=;
 b=V5VblXb5znlCxPmvo3sok6C1BjFPwvtWApDnW/3AmtQzRz2Pb+vAQAjZRiMWfpcTUj
 DAjH0h4DRR8oLoVVKMCPLu8tsp6Tw9+tkz9P6saZJuQiGliDmrLL9VVgKxUpBfLHaU8i
 KxZ+OWEDQFWZi9yVegYuB8Z+FcG6R97cyrpySSjM5tVNJATny9acknhhOnP2ulygmY8S
 oHGjW83qHYGlGFp6Sw/qvlOzkCjaF/VITyR35ynSXIqZl6Hd+GFFckOSHFcm+Wneao9t
 ejDeeAIm9mYJy8RLcJNIKcvcQJrETrtU7HE5rBsK75/lDrok8jD3PJEdgwToS9Wqy6iD
 EW6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Cxv6eRZihM5d2+KA9Gy/o6F4LSNKpnki/Cp9tds22EU=;
 b=IikOiTJF1WeB/OtebgKOkOYfzwIjPiFzGg83/3pAGpv5fQQwcu/IBfg0lHwZd1LGUf
 8n6Mo74Abd8Eso029GiONTPzxlWAwEq34+pniPuCUiSYlQvhNTBC4iHLyVmwg/PiEGpW
 4iOo9M6CbiiXx7Uic5Z8bXS81OhwR+aa+JLy7Gwt82RJ6Mb5N1fOcAlaxJhu9NCg7UGS
 KlMp5avVo6c1Qf+wMV/X42H4IHloSxLL9zEdg4wyzE9O3TOL7xExc360hIuwnTSDRD5q
 OIl1ps0AlOoOya84wZ7lHTbcT8ojnI7zq3wwxemr7LwFoZU8zO8HYQcb0HWNe/uk+C5S
 8g9w==
X-Gm-Message-State: AOAM5331FaM0QPfwg6L/q3rfG4RoFglkj8i2toT9GUklplVWchI+D5L0
 vNliwaSAkHmbI9ucpFnoS34un/iPYVTmx6lTDxM=
X-Google-Smtp-Source: ABdhPJyJ8AjKxuFryAua5NpBUOSJbti4efWspiDfTtSRUNZCcdYnfI+uJUnGYQ8d9iPalw+hVsibY3rN7Lc6Tu1Lbvk=
X-Received: by 2002:a9d:eef:0:b0:5d2:8e2f:6729 with SMTP id
 102-20020a9d0eef000000b005d28e2f6729mr241040otj.86.1649085287158; Mon, 04 Apr
 2022 08:14:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220401110310.611869-1-joshi.k@samsung.com>
 <CGME20220401110834epcas5p4d1e5e8d1beb1a6205d670bbcb932bf77@epcas5p4.samsung.com>
 <20220401110310.611869-4-joshi.k@samsung.com> <20220404071656.GC444@lst.de>
In-Reply-To: <20220404071656.GC444@lst.de>
From: Kanchan Joshi <joshiiitr@gmail.com>
Date: Mon, 4 Apr 2022 20:44:20 +0530
Message-ID: <CA+1E3r+nHBace_K1Zt-FrOgGF5d0=TDoNtU65bFuWX8R7p8+DQ@mail.gmail.com>
Subject: Re: [RFC 3/5] io_uring: add infra and support for IORING_OP_URING_CMD
To: Christoph Hellwig <hch@lst.de>
Cc: Kanchan Joshi <joshi.k@samsung.com>, Jens Axboe <axboe@kernel.dk>,
 io-uring@vger.kernel.org, 
 linux-nvme@lists.infradead.org, Pavel Begunkov <asml.silence@gmail.com>, 
 Ming Lei <ming.lei@redhat.com>, Luis Chamberlain <mcgrof@kernel.org>, 
 Pankaj Raghav <pankydev8@gmail.com>,
 =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>, 
 Anuj Gupta <anuj20.g@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220404_081449_367377_7304F538 
X-CRM114-Status: GOOD (  37.97  )
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

On Mon, Apr 4, 2022 at 12:46 PM Christoph Hellwig <hch@lst.de> wrote:
>
> Cann we plese spell out instastructure here?  Or did you mean
> infraread anyway :)

:-) sure, I see the problem with this shorthand now.

> > -enum io_uring_cmd_flags {
> > -     IO_URING_F_COMPLETE_DEFER       =3D 1,
> > -     IO_URING_F_UNLOCKED             =3D 2,
> > -     /* int's last bit, sign checks are usually faster than a bit test=
 */
> > -     IO_URING_F_NONBLOCK             =3D INT_MIN,
> > -};
>
> This doesn't actually get used anywhere outside of io_uring.c, so why
> move it?

This got missed out.
We are going to use it for things like this in nvme (from past series):

+ if (ioucmd && (ioucmd->flags & IO_URING_F_NONBLOCK)) {
+ rq_flags |=3D REQ_NOWAIT;
+ blk_flags |=3D BLK_MQ_REQ_NOWAIT;
+ }
+ req =3D nvme_alloc_request(q, cmd, blk_flags, rq_flags);

Also for polling too. Will fix this up in the next version.

> > +static void io_uring_cmd_work(struct io_kiocb *req, bool *locked)
> > +{
> > +     req->uring_cmd.driver_cb(&req->uring_cmd);
> > +}
> > +
> > +void io_uring_cmd_complete_in_task(struct io_uring_cmd *ioucmd,
> > +                     void (*driver_cb)(struct io_uring_cmd *))
> > +{
> > +     struct io_kiocb *req =3D container_of(ioucmd, struct io_kiocb, ur=
ing_cmd);
> > +
> > +     req->uring_cmd.driver_cb =3D driver_cb;
> > +     req->io_task_work.func =3D io_uring_cmd_work;
> > +     io_req_task_work_add(req, !!(req->ctx->flags & IORING_SETUP_SQPOL=
L));
> > +}
> > +EXPORT_SYMBOL_GPL(io_uring_cmd_complete_in_task);
>
> I'm still not a fund of the double indirect call here.  I don't really
> have a good idea yet, but I plan to look into it.
>
> >  static void io_req_task_queue_fail(struct io_kiocb *req, int ret)
>
> Also it would be great to not add it between io_req_task_queue_fail and
> the callback set by it.

Right. Will change.

> > +void io_uring_cmd_done(struct io_uring_cmd *ioucmd, ssize_t ret)
> > +{
> > +     struct io_kiocb *req =3D container_of(ioucmd, struct io_kiocb, ur=
ing_cmd);
> > +
> > +     if (ret < 0)
> > +             req_set_fail(req);
> > +     io_req_complete(req, ret);
> > +}
> > +EXPORT_SYMBOL_GPL(io_uring_cmd_done);
>
> It seems like all callers of io_req_complete actually call req_set_fail
> on failure.  So maybe it would be nice pre-cleanup to handle the
> req_set_fail call from =C4=A9o_req_complete?

io_tee and io_splice do slightly different handling.
If we take this route, it seems they can use __io_req_complete() instead.

> > +     /* queued async, consumer will call io_uring_cmd_done() when comp=
lete */
> > +     if (ret =3D=3D -EIOCBQUEUED)
> > +             return 0;
> > +     io_uring_cmd_done(ioucmd, ret);
>
> Why not:
>         if (ret !=3D -EIOCBQUEUED)
>                 io_uring_cmd_done(ioucmd, ret);
>         return 0;
>
> That being said I wonder why not just remove the retun value from
> ->async_cmd entirely and just require the implementation to always call
> io_uring_cmd_done?  That removes the confusion on who needs to call it
> entirely, similarly to what we do in the block layer for ->submit_bio.

Right, this seems doable at this point as we do not do any special
handling (in io_uring) on the return code.

> > +struct io_uring_cmd {
> > +     struct file     *file;
> > +     void            *cmd;
> > +     /* for irq-completion - if driver requires doing stuff in task-co=
ntext*/
> > +     void (*driver_cb)(struct io_uring_cmd *cmd);
> > +     u32             flags;
> > +     u32             cmd_op;
> > +     u16             cmd_len;
>
> The cmd_len field does not seem to actually be used anywhere.

Another stuff that got left out from the previous series :-(
Using this field for a bit of sanity checking at the moment. Like this in n=
vme:

+ if (ioucmd->cmd_len !=3D sizeof(struct nvme_passthru_cmd64))
+ return -EINVAL;
+ cptr =3D (struct nvme_passthru_cmd64 *)ioucmd->cmd;

> > +++ b/include/uapi/linux/io_uring.h
> > @@ -22,10 +22,12 @@ struct io_uring_sqe {
> >       union {
> >               __u64   off;    /* offset into file */
> >               __u64   addr2;
> > +             __u32   cmd_op;
> >       };
> >       union {
> >               __u64   addr;   /* pointer to buffer or iovecs */
> >               __u64   splice_off_in;
> > +             __u16   cmd_len;
> >       };
> >       __u32   len;            /* buffer size or number of iovecs */
> >       union {
> > @@ -60,7 +62,10 @@ struct io_uring_sqe {
> >               __s32   splice_fd_in;
> >               __u32   file_index;
> >       };
> > -     __u64   __pad2[2];
> > +     union {
> > +             __u64   __pad2[2];
> > +             __u64   cmd;
> > +     };
>
> Can someone explain these changes to me a little more?

All these three (cmd_op, cmd_len and cmd) are operation specific
fields. user-space supplies these into SQE, io_uring packages those
into "struct io_uring_cmd" and pass that down to the provider for
doing the real processing.

1. cmd_op =3D operation code for async cmd (e.g. passthru ioctl opcode
or whatever else we want to turn async from user-space)
2. cmd_len =3D actual length of async command (e.g. we have max 80 bytes
with big-sqe and for nvme-passthru we use the max, but for some other
usecase one can go with smaller length)
3. cmd =3D this is the starting-offset where async-command is placed (by
user-space) inside the big-sqe. 16 bytes in first-sqe, and next 64
bytes comes from second-sqe.

And if we were doing pointer-based command submission, this "cmd"
would have pointed to user-space command (of whatever length). Just to
put the entire thought-process across; I understand that we are not
taking that route.

