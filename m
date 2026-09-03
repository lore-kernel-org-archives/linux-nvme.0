Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BECBCC61DD6
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Sep 2026 01:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=v3T+l4YHBD5H35beFOk9ofILa5eFdJ/R8b9xIj6tzhc=; b=VWbmDEGqaj5LWIAjPblNTTKW+N
	cNNZ5CJ0K263vM5lgg46yjqxS66yfRPheMK8Fg516HG2oTzjq/QvVk48IAySlOtVuf3vj729o6VZn
	g7qJPc81TDi8+qS5DKU7Q55Rc1Lixb2+4YKopKaKjoNOgf851pDqqot1Ytge1zITPeW33EDWJB6xo
	uVoCj4xFBsZGwypk0WhX9sioZ+M4ZF6rQgSBPmNP7gkDWM5U7d88DAn86x1EgrEyRNK9IB34C6nkz
	vraNbynlO9FmBGKGi175r+XQp/S7EZxZ9NeTFQixE7PNyHLs2hf9hWnOQabUzmpu6OJEWD8luhcSs
	eLlXgLMw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1vqJ-0000000G8qW-3EY7;
	Thu, 03 Sep 2026 01:02:15 +0000
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1vqH-0000000G8po-1WW3
	for linux-nvme@lists.infradead.org;
	Thu, 03 Sep 2026 01:02:14 +0000
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-497e6956acfso492964b6e.1
        for <linux-nvme@lists.infradead.org>; Wed, 02 Sep 2026 18:02:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788397332; cv=none;
        d=google.com; s=arc-20260327;
        b=G1xqTsSVQEloX7CodYVv5UGktsY6YSa7YyHxiMsnY2ig77t6lYNa3Jz0eWyAdW5q7A
         6QVYudVSXQA1TqTSzSS7LcG3pcm7Eg9oyWJi5oHFnbnv3i1Bm4zmJsN33dNHdHiZd1fe
         Pngmw1qFpldPsFl8ZII8PJl5dYLNDTR3jUCpJP64/mLDYuogNJ4hkUHuEqHFiwxVPScx
         w5bxUrv98TzEtkPWR2hFqZUTlGDAw8PofoWQTq6yGSVMgZ0jPMJ5mOwJxDaArBbd7b8E
         ic8IO3xK5sHChDXqcbMRQwiYlSgy3KHDLe3Aatyiq1pWBVGWIV8XtRQtjnM0a0Xg8NXv
         NO9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=v3T+l4YHBD5H35beFOk9ofILa5eFdJ/R8b9xIj6tzhc=;
        fh=MkcoDXzsuyEpR0LDyqX5KkpFiW4sEP3M2cGhXjdq7Eg=;
        b=Muez1jEhjl4DmFzPp9Ify0FKrwf59HnbdYvrIEOKFAB4oy8WDN9XDheuu7eDuI90jz
         r7iuWnpUUbbY4veYJFaR1SXfaIA7vAqNZ9pjo5ewMUJz/tqDZXZ2tc9UfrjcwbKkL68r
         4pf501dCI5RUuXcPmGlsqWLkDCLEGz0H8HeE2GdeBR5hkgQOWATWESb/JvxuvIsUVYbO
         8flNwz0G9E9HJ0qW0JYsoDcJjEvty/yvJ70X08RtjwAnJDB4xQgecHFnZBE6x2WlEL4A
         /STQQYdH298vxFH3QTEaCZQ5GvqMxnQ5Re8tsolyhAhGEfENuLIdryrZ4gNuE/TIopKl
         +sfg==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788397332; x=1789002132; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=v3T+l4YHBD5H35beFOk9ofILa5eFdJ/R8b9xIj6tzhc=;
        b=YySuc6oW/6gRnI4xZ+IGm+WJyIOh0O0IXSdjWvJu9LKlylITuNWpYZrpAlx6I5pOMb
         AUgUG2Npzul4z7x7sHRDzGS3nKAfon7bq8wJdoQ50Qomc992XfIaCsdOMozRz/G1bAAo
         iYNc8/VQ3pUyIpFkiOZ8nrgiBGg+woHZ7ATJLUrBDfeZK/fvUNK1nNS0Ya0+UEaaYM09
         7AjFqHUpzx9QJQOixW0yy/ObNMSOUKpXiqRhrc0kijWioo3X+KwzEFov3j5lpMXyQWLa
         ViackDdbqIjHEbd/IaJFnco+NTYk0J1uGbDwR8Zl5sDYiQ2MZ4aAL/ELi6cI7Ed6+KdC
         nd9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788397332; x=1789002132;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v3T+l4YHBD5H35beFOk9ofILa5eFdJ/R8b9xIj6tzhc=;
        b=kSMFbuKxlDZXZwVQhlGbXQbqRww8vtg0SLZb4T3D566zaiuHk8ntt7RLa3TFs1IMR/
         1BkPXH7eVhEioq7ITjzB5CCSAyIZ1yn13OIyd8AxU5nonzlW6sdEwnevkiACigTawLYq
         ibUOCxiAUIVc70t7d/XFLSkQd1yTeqfOx2NZPFQn02mxi9bjCdB7tizDXNZ5O3ABany0
         OgRFa9pRAje5/hPGAMyj0J0WPE14dvt2iY7YC1oGxukH+w5V+pnK+LVDrK/aaAWk+9eM
         Fr0cMRht7NqFf8ybSTR7wFuk3XnmoZF0eSinZN7MQMXfwgmJJuq5rUNnKO9UJwYhzd+6
         Nxeg==
X-Forwarded-Encrypted: i=1; AKwUvBzVZ+nex+kUN8AxueQtkN0C41TBtIM63ZofnS9lzQA5KWiVRx9V0mZ29M75/kLXrPeIjjDSmIENdpbw@lists.infradead.org
X-Gm-Message-State: AFuF++m+0TKgXuUELLLWRovE64g9cwVrwkrBuIiUnt30/TBEfagOxSVw
	5cNEhTb2uC7oICvertq2Iv5A4f8w6sbBd0nyI0BbnXK2atsi26Y5IvqgU6Qlf0XGp/FkRGPZMkR
	mMWENGEThSVYYdWFEr0oOMyGn9jWdecc=
X-Gm-Gg: AYBFou27jkpFvlzPxfWytEuEkSfQE+gWWrMRo39ZwHmH0Xr7+YoVI0RjMheBpQBo3JC
	z2Jz3aS5fjE/RrsanQoNAewavTvZ3Gh7cen08/R/91ebb1C4bTvdENd48R9AWQJJqlrtgUvM/f8
	sk4ldwLq7swhUeXSyzPVNANIci0v1eZM1GqDfknMy4M+37YoptV80nSPq1RvLmu6LNalg/8yS0B
	+dRT5sogyuwfy23E3OoDImAELXaZTxQD3qyCjrcvU2479xxJQT3TOJqqiGR2noF4YGDCgzrmOAP
	QsXTR/JwAXX2V/EBflki4ifc1MGlnIXMDJFy2nn84SHXZrv5tMkCSpbh3RKX30ECpa7XP4v7pNt
	bOsgFY7XoZ4e3VopAdeDkfgHugq61KwJxAFAFTb/rujVU
X-Received: by 2002:a05:6808:d4f:b0:4b2:6691:b019 with SMTP id
 5614622812f47-4b7db1bb378mr2124405b6e.3.1788397331712; Wed, 02 Sep 2026
 18:02:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260902225708.2379840-1-csander@purestorage.com> <20260902225708.2379840-2-csander@purestorage.com>
In-Reply-To: <20260902225708.2379840-2-csander@purestorage.com>
From: Ming Lei <tom.leiming@gmail.com>
Date: Wed, 2 Sep 2026 20:02:00 -0500
X-Gm-Features: AcwNN1XykAeHlzgy4hM5DgNnLtYyOjWT7Rx-kVQ9tsCtGV9ZFST9dEGoIbiXETQ
Message-ID: <CACVXFVOKGOEmefHmZpsBX-7uxGjzbaJiueYMvka8TDjccOuFjg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] io_uring/cmd: split io_uring_cmd_set_res() from io_uring_cmd_done()
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, Joanne Koong <joannelkoong@gmail.com>, 
	linux-nvme@lists.infradead.org, io-uring@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260902_180213_416218_6D315DF9 
X-CRM114-Status: GOOD (  23.54  )
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

On Wed, Sep 2, 2026 at 6:05=E2=80=AFPM Caleb Sander Mateos
<csander@purestorage.com> wrote:
>
> In preparation for setting the io_uring NVMe passthru CQE results from
> the blk-mq request completion rather than the task work callback, split
> out functions io_uring_cmd_set_res{,32}() from __io_uring_cmd_done().
> io_uring_cmd_done{,32}() now call io_uring_cmd_set_res{,32}() and then
> __io_uring_cmd_done(). This allows __io_uring_cmd_done() to be made
> CQE-size-agnostic, with 3 fewer arguments.
>
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> ---
>  include/linux/io_uring/cmd.h | 23 +++++++++++++++++------
>  io_uring/uring_cmd.c         | 33 ++++++++++++++++++---------------
>  2 files changed, 35 insertions(+), 21 deletions(-)
>
> diff --git a/include/linux/io_uring/cmd.h b/include/linux/io_uring/cmd.h
> index 331dcbefe72f..67f2ef700c43 100644
> --- a/include/linux/io_uring/cmd.h
> +++ b/include/linux/io_uring/cmd.h
> @@ -50,19 +50,21 @@ int io_uring_cmd_import_fixed_vec(struct io_uring_cmd=
 *ioucmd,
>                                   const struct iovec __user *uvec,
>                                   size_t uvec_segs,
>                                   int ddir, struct iov_iter *iter,
>                                   unsigned issue_flags);
>
> +void io_uring_cmd_set_res(struct io_uring_cmd *, s32 ret);
> +void io_uring_cmd_set_res32(struct io_uring_cmd *, s32 ret, u64 res2);
> +
>  /*
>   * Completes the request, i.e. posts an io_uring CQE and deallocates @io=
ucmd
>   * and the corresponding io_uring request.
>   *
>   * Note: the caller should never hard code @issue_flags and is only allo=
wed
>   * to pass the mask provided by the core io_uring code.
>   */
> -void __io_uring_cmd_done(struct io_uring_cmd *cmd, s32 ret, u64 res2,
> -                        unsigned issue_flags, bool is_cqe32);
> +void __io_uring_cmd_done(struct io_uring_cmd *, unsigned issue_flags);
>
>  void __io_uring_cmd_do_in_task(struct io_uring_cmd *ioucmd,
>                             io_req_tw_func_t task_work_cb,
>                             unsigned flags);
>
> @@ -105,12 +107,19 @@ static inline int io_uring_cmd_import_fixed_vec(str=
uct io_uring_cmd *ioucmd,
>                                                 int ddir, struct iov_iter=
 *iter,
>                                                 unsigned issue_flags)
>  {
>         return -EOPNOTSUPP;
>  }
> -static inline void __io_uring_cmd_done(struct io_uring_cmd *cmd, s32 ret=
,
> -               u64 ret2, unsigned issue_flags, bool is_cqe32)
> +static inline void io_uring_cmd_set_res(struct io_uring_cmd *cmd, s32 re=
t)
> +{
> +}
> +static inline void io_uring_cmd_set_res32(struct io_uring_cmd *cmd, s32 =
ret,
> +                                         u64 res2)
> +{
> +}
> +static inline void __io_uring_cmd_done(struct io_uring_cmd *cmd,
> +                                      unsigned issue_flags)
>  {
>  }
>  static inline void __io_uring_cmd_do_in_task(struct io_uring_cmd *ioucmd=
,
>                             io_req_tw_func_t task_work_cb, unsigned flags=
)
>  {
> @@ -171,17 +180,19 @@ static inline void *io_uring_cmd_ctx_handle(struct =
io_uring_cmd *cmd)
>  }
>
>  static inline void io_uring_cmd_done(struct io_uring_cmd *ioucmd, s32 re=
t,
>                                      unsigned issue_flags)
>  {
> -       return __io_uring_cmd_done(ioucmd, ret, 0, issue_flags, false);
> +       io_uring_cmd_set_res(ioucmd, ret);
> +       __io_uring_cmd_done(ioucmd, issue_flags);
>  }
>
>  static inline void io_uring_cmd_done32(struct io_uring_cmd *ioucmd, s32 =
ret,
>                                        u64 res2, unsigned issue_flags)
>  {
> -       return __io_uring_cmd_done(ioucmd, ret, res2, issue_flags, true);
> +       io_uring_cmd_set_res32(ioucmd, ret, res2);
> +       __io_uring_cmd_done(ioucmd, issue_flags);
>  }
>
>  int io_buffer_register_bvec(struct io_uring_cmd *cmd, struct request *rq=
,
>                             void (*release)(void *), unsigned int index,
>                             unsigned int issue_flags);
> diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
> index 726a659f38c3..917b32a921e6 100644
> --- a/io_uring/uring_cmd.c
> +++ b/io_uring/uring_cmd.c
> @@ -136,40 +136,43 @@ void __io_uring_cmd_do_in_task(struct io_uring_cmd =
*ioucmd,
>         req->io_task_work.func =3D task_work_cb;
>         __io_req_task_work_add(req, flags);
>  }
>  EXPORT_SYMBOL_GPL(__io_uring_cmd_do_in_task);
>
> -static inline void io_req_set_cqe32_extra(struct io_kiocb *req,
> -                                         u64 extra1, u64 extra2)
> +void io_uring_cmd_set_res(struct io_uring_cmd *cmd, s32 ret)
>  {
> -       req->big_cqe.extra1 =3D extra1;
> -       req->big_cqe.extra2 =3D extra2;
> +       struct io_kiocb *req =3D cmd_to_io_kiocb(cmd);
> +
> +       if (ret < 0)
> +               req_set_fail(req);
> +       io_req_set_res(req, ret, 0);
>  }
> +EXPORT_SYMBOL_GPL(io_uring_cmd_set_res);
> +
> +void io_uring_cmd_set_res32(struct io_uring_cmd *cmd, s32 ret, u64 res2)
> +{
> +       struct io_kiocb *req =3D cmd_to_io_kiocb(cmd);
> +
> +       if (ret < 0)
> +               req_set_fail(req);
> +       io_req_set_res32(req, ret, 0, res2, 0);
> +}
> +EXPORT_SYMBOL_GPL(io_uring_cmd_set_res32);

Both the two helpers can be inline, can't they?

Thanks,

