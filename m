Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 284E8E9A03B
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Feb 2026 02:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NMHnTis2eTOTDVEZP9kQAwtC5xzV3oGmf4nIPo5Fpn8=; b=JrfjQQTNYnRDxBHqoTxUaBoAZK
	jsI2zzpzXbSX85WCxF/4wjtxEfIItKYZXw3j3e96etnyQX25jeuzWGhHA3C72+ujPzUwj4rS2Z6Ye
	PLXhggJY/n/aujZQkV0JQmSXi/m49fBkdeIYSXOsPGCp8aX3+TP2ZEUAzpwnntPH3ndU3e/eUhuHA
	hlB/X7RP/eMmPy5etKUG4iDB5x2kcJbR9BBtTkx+LO12oVQHjyDYXalNM5bLXw+XPAthbz3Z0U6xG
	C7XZe7OQyuo+yuDoBsArCGCMtY2B5PFEM+YqoqU1efhxGx6aFEBZyOXl79F9HWaBIr2UCYuxsMH3F
	H77Irp3g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vsX9h-00000009BJB-20eb;
	Wed, 18 Feb 2026 02:19:09 +0000
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vsX9e-00000009BIm-0WWq
	for linux-nvme@lists.infradead.org;
	Wed, 18 Feb 2026 02:19:07 +0000
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-b8fc023934dso41351166b.3
        for <linux-nvme@lists.infradead.org>; Tue, 17 Feb 2026 18:19:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771381143; cv=none;
        d=google.com; s=arc-20240605;
        b=c3sfdCfbUwcdlKjCIf+nVmzIAysS4s0JFj++7GCFww6hz8mCrf34clsOW3f4dpf6n6
         UQDjRIUy7amB82A0YP/jtXWnK0VMXVntj43MVLAJ6tRpHfAXy06M2QWfVFPq4lmLXLmH
         e0AmL2TumVZyVmA9YO8Yya5f2YiMKzo5ucw5qngnhj1+7nVSJTL3RpbfZbT/oP4PV4xR
         6inRfqduD4UIv615DTHnP+ysXNZMarNTkTmVxVvxogveudHvblGW9aWx0HfCYMHKoazO
         WlCkdMYmQ2ISl5CxFC6TQVeIVdam5cVxusK/vSpNaTI/X5CgyMyzwTtXyQgJUNUKInJd
         N6zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NMHnTis2eTOTDVEZP9kQAwtC5xzV3oGmf4nIPo5Fpn8=;
        fh=dXQ5JF4q+mvyadvsiWgZOMBLxrzI2iGEgVKbRXWexDc=;
        b=Fwyu1aykMhT/oxAMzuOaQ0FNMPvzwh74GU8TcPYpE/8KuT8mTQ4NuHa2GKGhv2C705
         RvTaSAligKF1EOiBImBj57kC9cK2gbmUFM7WlAPcFvtyNRLjWhvX2LuvPQWZ/Xzlu2lf
         Xr6g7uH0mvZKkXcigaIzfkH/VwLlOqabzs6fv15D/qIMN7/MWpxBAm5vOrPqZEkDFCZq
         6e11FJdzsrRJMNbKySLQfrklBdA485RMXsFtJh8m2Id423IOVFjmDXD4mY59e124pl3y
         kXY4h3HToKrTHO40Gt3B7oXTlASkkkHZbDVd/txnIghFLCtUGr9P8s4NVzVUKhaEdv2N
         4/ig==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1771381143; x=1771985943; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NMHnTis2eTOTDVEZP9kQAwtC5xzV3oGmf4nIPo5Fpn8=;
        b=OfPsgc1yYyhW38mxCtAssrs7GaZY0+HbRrxBb9Ys9GnRVP6fGpdCZiIw5mtpzSzbjE
         M57aYze1TgwZId4bGU1al9IECCbpHOr30GwwqwevUhKm2iX934Yz5MdrP3rO/GnCn6as
         RykParYsABNkKRXAlmq7PkQGhX/yWyLE21Yos+U2gKr41au2Q2gi9Z/8fsSx+qm5zNig
         xDqe0eH836d97cZSwLRp8eCqJXqkcBMAOjqnm5Oh8Ihga4hlXKyCCPMHS3tuga6yyWYm
         JzrX/f3mtJ3JWTBFUnsTUoFjdecyuQuU7f3YUEJkWttkT1qWM8ne6rRZOvwf62hH+Xo+
         Rk0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771381143; x=1771985943;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NMHnTis2eTOTDVEZP9kQAwtC5xzV3oGmf4nIPo5Fpn8=;
        b=TbcsBqtB3dlyLoqzF9i2ezXXchXs7gvwcrbKkuMejs8C9wH63IT6ORYNsbEASumwBi
         fHnwRC1x9JjiY65DIbF9Ca7yPBJb5nI5h3ybDsmIvXDPjslaaWGQJczhRO2nnyxERk4E
         w5DJAfCC8s1/AVruylW9ocLOXAsPP7F0+SLPKasqpClnBvbZj65RYbEJxPEv1HYyJkPS
         KIAEswyTdkkZmUz21QQe1qBpEXnPbOuEfkDHWFE1mMbt97A7BJdmCzhDm9Z1tv0nsCaF
         0hwPzYDmCGfFFS1O5JopxZg621A8KsOKYdZMovjd1NgJgnkiOABotGjreCECNa1ItP+2
         Qq0Q==
X-Forwarded-Encrypted: i=1; AJvYcCU9kA6Sp5KWUpLDHYS7zJmUUgpge4ocDaN0kcawCW9mEiPAjbOOK+k9kJoq311bIy+ogsSByNagxOFQ@lists.infradead.org
X-Gm-Message-State: AOJu0YxlhW03aZxSZSONLet7r1fp2xqhAebHYq06HiRctoVojMbIP9Qu
	pwS2tMmEp4beXwx2opIEytbJKdIM3Tj95mCoXVCZEVEZBbuzvoTo6bNfJI7IOgMCqKLjKefACUU
	nimyfUUT7cVwB1z6iAvFQHqoSIiouwo1iiG9ixAZ8sg==
X-Gm-Gg: AZuq6aLhWOxDsdi9TzWabPXyttMGxbfgBbcbNNEFOQWIWvMkTwF2SVapdXZ0YbfKkIm
	QDhObB9xZVUqZqHe60F/hSWHZMRSWSYrVHygNWK1MSNMMjMbS7jSsVICxEkvLqslNYeXUIl4Uu8
	4dJEwVcVtA9Xb3PhIOB5uS27EzP9L6VAbLESyJeUbi9vodlg+bBaxqBKsF2fr1ky8YX0fD888+D
	EqnSPxul0CYqiMWcRmK1J8suZKpElpYBen/c5aOvpYX42YEFFtBVNmqwStQr5+1N/C/nGxb86Ly
	XnrjTiAK
X-Received: by 2002:a17:907:9719:b0:b88:4ff8:12fb with SMTP id
 a640c23a62f3a-b8fac870c29mr507705366b.0.1771381143250; Tue, 17 Feb 2026
 18:19:03 -0800 (PST)
MIME-Version: 1.0
References: <20260213032119.1125331-1-csander@purestorage.com> <20260213032119.1125331-3-csander@purestorage.com>
In-Reply-To: <20260213032119.1125331-3-csander@purestorage.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Tue, 17 Feb 2026 18:18:52 -0800
X-Gm-Features: AaiRm50dI3slBlu4uqxlVzOL72r3ApJKaSReOmdwRugNnG7zjKFlefXtw1cmx0U
Message-ID: <CADUfDZr+4hv-vm8my7kbKQG-2zoomG5a1y5Yt9fzxqbvSyPrSw@mail.gmail.com>
Subject: Re: [PATCH 2/3] io_uring/uring_cmd: allow non-iopoll cmds with IORING_SETUP_IOPOLL
To: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, 
	Sagi Grimberg <sagi@grimberg.me>
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260217_181906_286211_584A655B 
X-CRM114-Status: GOOD (  30.78  )
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

On Thu, Feb 12, 2026 at 7:21=E2=80=AFPM Caleb Sander Mateos
<csander@purestorage.com> wrote:
>
> Currently, creating an io_uring with IORING_SETUP_IOPOLL requires all
> requests issued to it to support iopoll. This prevents, for example,
> using ublk zero-copy together with IORING_SETUP_IOPOLL, as ublk
> zero-copy buffer registrations are performed using a uring_cmd. There's
> no technical reason why these non-iopoll uring_cmds can't be supported.
> They will either complete synchronously or via an external mechanism
> that calls io_uring_cmd_done(), so they don't need to be polled.
>
> Allow uring_cmd requests to be issued to IORING_SETUP_IOPOLL io_urings
> even if their files don't implement ->uring_cmd_iopoll(). For these
> uring_cmd requests, skip initializing struct io_kiocb's iopoll fields,
> don't insert the request into iopoll_list, and take the
> io_req_complete_defer() or io_req_task_work_add() path in
> __io_uring_cmd_done() instead of setting the iopoll_completed flag. Also
> allow io_uring_cmd_mark_cancelable() to be called on these uring_cmds.
> Assert that io_uring_cmd_mark_cancelable() is only called on
> non-IORING_SETUP_IOPOLL io_urings or uring_cmds to files that don't
> implement ->uring_cmd_iopoll().
>
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> ---
>  io_uring/io_uring.c  |  4 +++-
>  io_uring/uring_cmd.c | 11 +++++------
>  2 files changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
> index c45af82dda3d..4e68a5168894 100644
> --- a/io_uring/io_uring.c
> +++ b/io_uring/io_uring.c
> @@ -1417,11 +1417,13 @@ static int io_issue_sqe(struct io_kiocb *req, uns=
igned int issue_flags)
>
>         if (ret =3D=3D IOU_ISSUE_SKIP_COMPLETE) {
>                 ret =3D 0;
>
>                 /* If the op doesn't have a file, we're not polling for i=
t */
> -               if ((req->ctx->flags & IORING_SETUP_IOPOLL) && def->iopol=
l_queue)
> +               if ((req->ctx->flags & IORING_SETUP_IOPOLL) &&
> +                   def->iopoll_queue && (!io_is_uring_cmd(req) ||
> +                                         req->file->f_op->uring_cmd_iopo=
ll))
>                         io_iopoll_req_issued(req, issue_flags);
>         }
>         return ret;
>  }
>
> diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
> index ee7b49f47cb5..8df52e8f1c1b 100644
> --- a/io_uring/uring_cmd.c
> +++ b/io_uring/uring_cmd.c
> @@ -108,12 +108,12 @@ void io_uring_cmd_mark_cancelable(struct io_uring_c=
md *cmd,
>          * Doing cancelations on IOPOLL requests are not supported. Both
>          * because they can't get canceled in the block stack, but also
>          * because iopoll completion data overlaps with the hash_node use=
d
>          * for tracking.
>          */
> -       if (ctx->flags & IORING_SETUP_IOPOLL)
> -               return;
> +       WARN_ON_ONCE(ctx->flags & IORING_SETUP_IOPOLL &&
> +                    req->file->f_op->uring_cmd_iopoll);
>
>         if (!(cmd->flags & IORING_URING_CMD_CANCELABLE)) {
>                 cmd->flags |=3D IORING_URING_CMD_CANCELABLE;
>                 io_ring_submit_lock(ctx, issue_flags);
>                 hlist_add_head(&req->hash_node, &ctx->cancelable_uring_cm=
d);
> @@ -165,11 +165,12 @@ void __io_uring_cmd_done(struct io_uring_cmd *ioucm=
d, s32 ret, u64 res2,
>                 if (req->ctx->flags & IORING_SETUP_CQE_MIXED)
>                         req->cqe.flags |=3D IORING_CQE_F_32;
>                 io_req_set_cqe32_extra(req, res2, 0);
>         }
>         io_req_uring_cleanup(req, issue_flags);
> -       if (req->ctx->flags & IORING_SETUP_IOPOLL) {
> +       if (req->ctx->flags & IORING_SETUP_IOPOLL &&
> +           req->file->f_op->uring_cmd_iopoll) {

I do worry that the pointer chasing here may be expensive, ->file and
->f_op could both be uncached. Would it make sense to add a flag to
req->flags to indicate whether a request should actually be IOPOLLed?

Thanks,
Caleb

>                 /* order with io_iopoll_req_issued() checking ->iopoll_co=
mplete */
>                 smp_store_release(&req->iopoll_completed, 1);
>         } else if (issue_flags & IO_URING_F_COMPLETE_DEFER) {
>                 if (WARN_ON_ONCE(issue_flags & IO_URING_F_UNLOCKED))
>                         return;
> @@ -255,13 +256,11 @@ int io_uring_cmd(struct io_kiocb *req, unsigned int=
 issue_flags)
>                 issue_flags |=3D IO_URING_F_SQE128;
>         if (ctx->flags & (IORING_SETUP_CQE32 | IORING_SETUP_CQE_MIXED))
>                 issue_flags |=3D IO_URING_F_CQE32;
>         if (io_is_compat(ctx))
>                 issue_flags |=3D IO_URING_F_COMPAT;
> -       if (ctx->flags & IORING_SETUP_IOPOLL) {
> -               if (!file->f_op->uring_cmd_iopoll)
> -                       return -EOPNOTSUPP;
> +       if (ctx->flags & IORING_SETUP_IOPOLL && file->f_op->uring_cmd_iop=
oll) {
>                 issue_flags |=3D IO_URING_F_IOPOLL;
>                 req->iopoll_completed =3D 0;
>                 if (ctx->flags & IORING_SETUP_HYBRID_IOPOLL) {
>                         /* make sure every req only blocks once */
>                         req->flags &=3D ~REQ_F_IOPOLL_STATE;
> --
> 2.45.2
>

