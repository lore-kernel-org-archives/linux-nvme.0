Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76F86C433FE
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Mar 2022 18:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kf7TOgS7D3Yd0UtSvuZyI1f288zh+DR/XNn+gdcU/e0=; b=AaOxVQ6gyUcDcVvNk59Y+2ZbLr
	KzoE/E5tyoJuA46/5QL0wJC+6JGnZORXInZUIuRLi/jqN0OO9gY9JSRBruKdrxCoTremDmIPGewUj
	DoosxU4MnbqAbn4ASFm109TRkFJfrtsA4bZoTkGrbNuWux8Urn+IRm1WB+QOaHdk2N52LISgKNgKg
	qYYHFe2uoClifeAf1kPbfcOWcfhOA6ZlkMfMY6kVqqkZDcC7n/TfECQxCxfiGzy9VONA9SP3CxCo/
	tOq7WOtmi+xH8beW39Xl+gwqrxyIYQ9p8ErGHxK0PKWrZKF8b7xQsAgjO4DimEP9f3gPexO3dUvaX
	mw0rlITQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nSkJ5-0002Xy-M6; Fri, 11 Mar 2022 18:48:07 +0000
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nSkJ2-0002XY-9X
 for linux-nvme@lists.infradead.org; Fri, 11 Mar 2022 18:48:06 +0000
Received: by mail-ej1-x62a.google.com with SMTP id a8so20981214ejc.8
 for <linux-nvme@lists.infradead.org>; Fri, 11 Mar 2022 10:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=kf7TOgS7D3Yd0UtSvuZyI1f288zh+DR/XNn+gdcU/e0=;
 b=XSlS5JP4NOqYU9yEkHISgTvjtxTXflOBHHRlhW6BrF3xKXdrwC1bqvq4RtQkamVzah
 MlGxtryBa0BwRj3i4tFyPsei6FHGOlx78c823zEb/N6JN1I9Xzc6H50lijaG76ou72LA
 0m8P7kS6pXUBMAh7tCfYKA39ubF51TnC2Ytr9UfCys5U6IvuuUv+kIH7txETMjSENATr
 u5AAKXS2mVtA5MnSaN8fwc+YQfNm/wMBjW4HEUr+IIkOCmh9Zcp9OdYNPUO7nF/zRxjA
 RRQ6U+uhqtgdLkDmuZdeV7MhSicc5az09LIRGObm3zTZWulkunqQUbtv/5QGbQ+dU8oM
 8ANg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=kf7TOgS7D3Yd0UtSvuZyI1f288zh+DR/XNn+gdcU/e0=;
 b=SHmVeBdmUCUQH22i172DojqYFV+A2/1hViGGlPw6yzcBMccNh5iFytLExkzIxOYPKE
 PDMpWEOxzWUyoo7Ha+3wQFYqLjYpWmW3KVCM81oDaiGfrjG9HssenEVCSY28Awg4GByj
 97tcAms7FrZpPF9ahGIeBDcsXt1cF7Kte1Kiwjll4bYNMzddlb4oOrTBnE1mYem/w6BX
 fNN9oHQAbOIcnD/Keb3Gv94uMqpSgxc15JthTFig7mMZS++ZyvAxq1a+3m/5ho15bjbw
 VP82qOp66Gj4xbZPOiecsN62WoJbyPNzM6J01MJG+YvK55ezEgOZUgKqutoGxs9eEFlQ
 2DzQ==
X-Gm-Message-State: AOAM532G7HmkUPeRtx4cKMFRYwtPisLUTWYa54pT5gOrhK1f39WddEiz
 0EB2Efqt0ocpWuxYgudJYrq/Y1i2PcVh9ZWA6xbu
X-Google-Smtp-Source: ABdhPJz4r5C9q5aApxVwetcw+DRO04FhjfuFweRhE4YCYNDr38bRHM9Y7Kd06Xnvg+SydBi9uXF6UMJThJnev06sF7k=
X-Received: by 2002:a17:907:3f86:b0:6db:b745:f761 with SMTP id
 hr6-20020a1709073f8600b006dbb745f761mr548786ejc.610.1647024482439; Fri, 11
 Mar 2022 10:48:02 -0800 (PST)
MIME-Version: 1.0
References: <20220308152105.309618-1-joshi.k@samsung.com>
 <CGME20220308152658epcas5p3929bd1fcf75edc505fec71901158d1b5@epcas5p3.samsung.com>
 <20220308152105.309618-4-joshi.k@samsung.com>
 <YiqrE4K5TWeB7aLd@bombadil.infradead.org>
 <e3bfd028-ece7-d969-f47c-1181b17ac919@kernel.dk>
 <YiuC1fhEiRdo5bPd@bombadil.infradead.org>
In-Reply-To: <YiuC1fhEiRdo5bPd@bombadil.infradead.org>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 11 Mar 2022 13:47:51 -0500
Message-ID: <CAHC9VhSNMH8XAKa43kCR8fZj-B1ucCd3R6WXOo3B4z80Bw2Kkw@mail.gmail.com>
Subject: Re: [PATCH 03/17] io_uring: add infra and support for
 IORING_OP_URING_CMD
To: Luis Chamberlain <mcgrof@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 linux-security-module@vger.kernel.org, linux-audit@redhat.com
Cc: Kanchan Joshi <joshi.k@samsung.com>, jmorris@namei.org, serge@hallyn.com, 
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com, 
 songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com, 
 kpsingh@kernel.org, hch@lst.de, kbusch@kernel.org, asml.silence@gmail.com, 
 io-uring@vger.kernel.org, linux-nvme@lists.infradead.org, 
 linux-block@vger.kernel.org, sbates@raithlin.com, logang@deltatee.com, 
 pankydev8@gmail.com, javier@javigon.com, a.manzanares@samsung.com, 
 joshiiitr@gmail.com, anuj20.g@samsung.com, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220311_104804_406462_30476670 
X-CRM114-Status: GOOD (  43.13  )
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

On Fri, Mar 11, 2022 at 12:11 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> On Thu, Mar 10, 2022 at 07:43:04PM -0700, Jens Axboe wrote:
> > On 3/10/22 6:51 PM, Luis Chamberlain wrote:
> > > On Tue, Mar 08, 2022 at 08:50:51PM +0530, Kanchan Joshi wrote:
> > >> From: Jens Axboe <axboe@kernel.dk>
> > >>
> > >> This is a file private kind of request. io_uring doesn't know what's
> > >> in this command type, it's for the file_operations->async_cmd()
> > >> handler to deal with.
> > >>
> > >> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> > >> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
> > >> ---
> > >
> > > <-- snip -->
> > >
> > >> +static int io_uring_cmd(struct io_kiocb *req, unsigned int issue_flags)
> > >> +{
> > >> +  struct file *file = req->file;
> > >> +  int ret;
> > >> +  struct io_uring_cmd *ioucmd = &req->uring_cmd;
> > >> +
> > >> +  ioucmd->flags |= issue_flags;
> > >> +  ret = file->f_op->async_cmd(ioucmd);
> > >
> > > I think we're going to have to add a security_file_async_cmd() check
> > > before this call here. Because otherwise we're enabling to, for
> > > example, bypass security_file_ioctl() for example using the new
> > > iouring-cmd interface.
> > >
> > > Or is this already thought out with the existing security_uring_*() stuff?
> >
> > Unless the request sets .audit_skip, it'll be included already in terms
> > of logging.
>
> Neat.

[NOTE: added the audit and SELinux lists to the To/CC line]

Neat, but I think we will need to augment things to support this new
passthrough mechanism.

The issue is that folks who look at audit logs need to be able to
piece together what happened on the system using just what they have
in the logs themselves.  As things currently stand with this patchset,
the only bit of information they would have to go on would be
"uring_op=<IORING_OP_URING_CMD>" which isn't very informative :)

You'll see a similar issue in the newly proposed LSM hook below, we
need to be able to record information about not only the passthrough
command, e.g. io_uring_cmd::cmd_op, but also the underlying
device/handler so that we can put the passthrough command in the right
context (as far as I can tell io_uring_cmd::cmd_op is specific to the
device).  We might be able to leverage file_operations::owner::name
for this, e.g. "uring_passthru_dev=nvme
uring_passthru_op=<NVME_IOCTL_IO64_CMD>".

> > But I'd prefer not to lodge this in with ioctls, unless
> > we're going to be doing actual ioctls.
>
> Oh sure, I have been an advocate to ensure folks don't conflate async_cmd
> with ioctl. However it *can* enable subsystems to enable ioctl
> passthrough, but each of those subsystems need to vet for this on their
> own terms. I'd hate to see / hear some LSM surprises later.

Same :)  Thanks for bringing this up with us while the patches are
still in-progress/under-review, I think it makes for a much more
pleasant experience for everyone.

> > But definitely something to keep in mind and make sure that we're under
> > the right umbrella in terms of auditing and security.
>
> Paul, how about something like this for starters (and probably should
> be squashed into this series so its not a separate commit) ?
>
> From f3ddbe822374cc1c7002bd795c1ae486d370cbd1 Mon Sep 17 00:00:00 2001
> From: Luis Chamberlain <mcgrof@kernel.org>
> Date: Fri, 11 Mar 2022 08:55:50 -0800
> Subject: [PATCH] lsm,io_uring: add LSM hooks to for the new async_cmd file op
>
> io-uring is extending the struct file_operations to allow a new
> command which each subsystem can use to enable command passthrough.
> Add an LSM specific for the command passthrough which enables LSMs
> to inspect the command details.
>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  fs/io_uring.c                 | 5 +++++
>  include/linux/lsm_hook_defs.h | 1 +
>  include/linux/lsm_hooks.h     | 3 +++
>  include/linux/security.h      | 5 +++++
>  security/security.c           | 4 ++++
>  5 files changed, 18 insertions(+)
>
> diff --git a/fs/io_uring.c b/fs/io_uring.c
> index 3f6eacc98e31..1c4e6b2cb61a 100644
> --- a/fs/io_uring.c
> +++ b/fs/io_uring.c
> @@ -4190,6 +4190,11 @@ static int io_uring_cmd_prep(struct io_kiocb *req,
>         struct io_ring_ctx *ctx = req->ctx;
>         struct io_uring_cmd *ioucmd = &req->uring_cmd;
>         u32 ucmd_flags = READ_ONCE(sqe->uring_cmd_flags);
> +       int ret;
> +
> +       ret = security_uring_async_cmd(ioucmd);
> +       if (ret)
> +               return ret;

As a quick aside, for the LSM/audit folks the lore link for the full
patchset is here:
https://lore.kernel.org/io-uring/CA+1E3rJ17F0Rz5UKUnW-LPkWDfPHXG5aeq-ocgNxHfGrxYtAuw@mail.gmail.com/T/#m605e2fb7caf33e8880683fe6b57ade4093ed0643

Similar to what was discussed above with respect to auditing, I think
we need to do some extra work here to make it easier for a LSM to put
the IO request in the proper context.  We have io_uring_cmd::cmd_op
via the @ioucmd parameter, which is good, but we need to be able to
associate that with a driver to make sense of it.  In the case of
audit we could simply use the module name string, which is probably
ideal as we would want a string anyway, but LSMs will likely want
something more machine friendly.  That isn't to say we couldn't do a
strcmp() on the module name string, but for something that aims to
push performance as much as possible, doing a strcmp() on each
operation seems a little less than optimal ;)

-- 
paul-moore.com

