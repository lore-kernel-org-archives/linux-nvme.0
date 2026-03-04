Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07188EF8FFA
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Mar 2026 15:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GkCO8U87PDd2xBX9rOr4mr02NCqf1DfsiPflHAiOeWk=; b=w6iAqFZV3TCKCe7JUk4ng9k2TS
	5DYuGcPpWByk/QYbtcSNWXQc8vtAYDMGtwoqkUnOFGHVGiT+8YogMLXh420Fzhh516DU8+4q/Xwy5
	sWyEg+oFfQRBZE+sb8Y9aiDKc+pz2c+XTn95jpJkKZK7N4Z/D9OGLDUa9OB68ylPvVnSzQ2A89/wc
	gxS46yNEEGtRCgIY80+3A862PnNV3PNTdIAHlCMRQ0kqr5n0HK02vbggdnyREJjZeSTavOCF15ffP
	XEl4zDZ3vihzoIFy1nlXDG+cG59lUSGSXZRJAusnmpkMGnzBLbffKYBDuXtdRfbPSmEp14fhZCYmU
	8RbkeNOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxoQl-000000000VQ-0nwb;
	Wed, 04 Mar 2026 15:46:35 +0000
Received: from mail-oa1-x2e.google.com ([2001:4860:4864:20::2e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxoQi-000000000Uv-0TES
	for linux-nvme@lists.infradead.org;
	Wed, 04 Mar 2026 15:46:33 +0000
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-4094f2e7e0eso300624fac.3
        for <linux-nvme@lists.infradead.org>; Wed, 04 Mar 2026 07:46:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772639191; cv=none;
        d=google.com; s=arc-20240605;
        b=ZoOdPFSmTDyDSVDrvskHt60A3UeoKr9S/UXk3taSxwp9JLbUNXsg0bnkQlnSIfvVgH
         EMNND5BprG62JYSQBI31P9Sy5lSPkZdQhzMyGWdenAR/oUQnu5GSuMTU94nneg93Lewm
         3ApPQwTGVOHRrtOLqtATi4mTwWqak/OfEnGUZ0qBabSYwcVbnGFhVmT3flwe2FmeWOaT
         AZiP4vvUmMHj0ie6WzV2RJR4r5op42wYlvbTwwhUs6px7N5wkNGEm3fhRzZ86B5YZSk4
         Xv50GRlYCFbvIxgoHYoR3PuAa8B6zfAG2MZkUo4K8dpL88lrQUjtgvPCGGk5PM209VIC
         E0lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GkCO8U87PDd2xBX9rOr4mr02NCqf1DfsiPflHAiOeWk=;
        fh=LQjF2vS+LrI9WEFjxZwfWFP2c6klyKWHsnnunGc51iI=;
        b=FjAQh8wnAqOttYdINQXOjNcQMODteE0W2M7kSy9fcnlgZZzYD6G+H0qt7GfcsKmikO
         E4LMGhhe3ewaHp74rUxLODtwOvVrItfYRaJJi1OPsQO1QkC5f9avYn/x7GzSVJnsIXoI
         vcv3GdPVo51ZGWUeY6OKnAzCX/MfqYGX1mvehWs0uyfJjgDSY8vv1054mVXK69nDWoZh
         aP16wVWxdcX/nrjIK2bTWQ9NIpp7gK1KzIF2McyaQ0zklLZohnF/ej8w1kFBP9bJ3aDf
         q2luqPvjTNexr/IUagL1W/vCdAHz4hqI6NA26F/mIzknfMvOkpLRC5pseN0fdt+d+cEL
         5e+g==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1772639191; x=1773243991; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GkCO8U87PDd2xBX9rOr4mr02NCqf1DfsiPflHAiOeWk=;
        b=OhAH8X9NF/NtdHZcB9dDw76TyX7d9IB1qLx5NHEm6s8HZS7Zlv9Y+Yc3j3ayJ9lTXU
         Cl3u5n2tIYmKi/rfJpD6q4RzFYo8E3RBxdnj2oiEMTwSr0D9MyAH32Gm1cZ27dAGuW2/
         fJkvSl2zTHQkxJNaHqTIa4BOq4c47yPLBHBWTgMDzcSxiMc1pwXjxeBteRCc8Jm8KqLw
         UBGFKO39Hd1DUOOpgfLycB4Zf0iDuoCEIsyigZ0lh8o/HsAxnNkpjCa1a8VtqGobRQJX
         sXYzmDkjY1EW5NcKsE2+BSu0KnOACh10goyyLFkHqncJBp3Jvm1s5Rgzs9bbVlh9Wyle
         u17g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772639191; x=1773243991;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GkCO8U87PDd2xBX9rOr4mr02NCqf1DfsiPflHAiOeWk=;
        b=RyDFMbKAdEARuppWMjVGJcfaSijp5achZJhC52u6Lk1wFe4lmGWCkNYQL20LFSigzW
         17zNd/mMJS52/8IQ3qXxJBQrL0gBG7eRREq319/GkZc+OsKXJmnjPJueKv2P+Wq1z0pa
         BN/pU0G1YMLMMThQ1N/dxHf8+gtblWg8n9MvhaVZa7x61cZvZVBFgqQkIAXNrV4i9VdK
         3BlCYvvDl0Gtat2QRw3ZmI+DG9R/Wbuy7zmfpYwua4eXIl1bi1Xwu7kmv1l5rn4uAziS
         dV9YGNQEsXRFKizJlNDBOaq3pIRTfH7bs6gpNBsbEOXjJLwJFJeCB/wMyPcvdQ8iScj0
         Ud4A==
X-Forwarded-Encrypted: i=1; AJvYcCWEbcWXKQcrFjRgdWNFRJkUVUtTE4uk26mRWfdg6qsZ4wgBVF6CX+ADb/e3IXm2Ce56RLTLlZwG231P@lists.infradead.org
X-Gm-Message-State: AOJu0Yz+VE4rjnK5L1j+b0wQyQ+RF0EvK11mupb+uDkw0pHWwAZyxJgj
	/bQF/6OXOs5hQoIJofin3bDTwwYYtaPzMRzgDh/+mvvfZ9nQu9C5ZnzipB9qoWJp/Qp5cKObZ0Q
	6fTyvO6wRKkBjb54uopsPXNvXUaOeFHmzbJloxdsAcw==
X-Gm-Gg: ATEYQzzytc3jBgaVqvqOkbcJEOxppp0ESNlb9YYuuCJPuqxjUO5RmleLysqn02SoyBb
	ZNHXLAeSD4siJIRuutJpfw1GPCgUlWcCAXwJ19HxE4/bZMGA/jV9BudIUNAz+TFkxi/ULIWaWS/
	r8aNvsotbH3lJjQBEhlg7H3HFuWGxodZp5BJum/j+9mdgmuqRsP3csROSfNpRHp5LTT/0KQr8Bq
	WLhrtIV9mjDN2j4E7PZF87M0wFes9uPDwPFZottgn3prz8R0CeIaXHYnLzrEy+NT4NFYNTUuvmR
	5HXltMyGSUD80+mG0Q==
X-Received: by 2002:a4a:ba01:0:b0:66a:84ca:1fa3 with SMTP id
 006d021491bc7-67b176e5dafmr714951eaf.1.1772639190574; Wed, 04 Mar 2026
 07:46:30 -0800 (PST)
MIME-Version: 1.0
References: <20260302172914.2488599-1-csander@purestorage.com>
 <20260302172914.2488599-4-csander@purestorage.com> <aagKTanM5Az9UDsJ@fedora>
In-Reply-To: <aagKTanM5Az9UDsJ@fedora>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Wed, 4 Mar 2026 07:46:18 -0800
X-Gm-Features: AaiRm50ME6wzDjhP0yhHyM4MRN0Z72HKTGXLDU8_-qryiqs1Sm0543HVZG0MCFU
Message-ID: <CADUfDZozycFBPX0kH=22Gda7njM3xVmL=Cy=zCq6cfXY8JH_dw@mail.gmail.com>
Subject: Re: [PATCH v5 3/5] io_uring: count CQEs in io_iopoll_check()
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, 
	Sagi Grimberg <sagi@grimberg.me>, io-uring@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Anuj Gupta <anuj20.g@samsung.com>, 
	Kanchan Joshi <joshi.k@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260304_074632_301987_6D62CE95 
X-CRM114-Status: GOOD (  29.92  )
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

On Wed, Mar 4, 2026 at 2:33=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrote=
:
>
> On Mon, Mar 02, 2026 at 10:29:12AM -0700, Caleb Sander Mateos wrote:
> > A subsequent commit will allow uring_cmds that don't use iopoll on
> > IORING_SETUP_IOPOLL io_urings. As a result, CQEs can be posted without
> > setting the iopoll_completed flag for a request in iopoll_list or going
> > through task work. For example, a UBLK_U_IO_FETCH_IO_CMDS command could
> > call io_uring_mshot_cmd_post_cqe() to directly post a CQE. The
> > io_iopoll_check() loop currently only counts completions posted in
> > io_do_iopoll() when determining whether the min_events threshold has
> > been met. It also exits early if there are any existing CQEs before
> > polling, or if any CQEs are posted while running task work. CQEs posted
> > via io_uring_mshot_cmd_post_cqe() or other mechanisms won't be counted
> > against min_events.
> >
> > Explicitly check the available CQEs in each io_iopoll_check() loop
> > iteration to account for CQEs posted in any fashion.
> >
> > Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> > ---
> >  io_uring/io_uring.c | 9 ++-------
> >  1 file changed, 2 insertions(+), 7 deletions(-)
> >
> > diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
> > index 46f39831d27c..b4625695bb3a 100644
> > --- a/io_uring/io_uring.c
> > +++ b/io_uring/io_uring.c
> > @@ -1184,11 +1184,10 @@ __cold void io_iopoll_try_reap_events(struct io=
_ring_ctx *ctx)
> >               io_move_task_work_from_local(ctx);
> >  }
> >
> >  static int io_iopoll_check(struct io_ring_ctx *ctx, unsigned int min_e=
vents)
> >  {
> > -     unsigned int nr_events =3D 0;
> >       unsigned long check_cq;
> >
> >       min_events =3D min(min_events, ctx->cq_entries);
> >
> >       lockdep_assert_held(&ctx->uring_lock);
> > @@ -1227,34 +1226,30 @@ static int io_iopoll_check(struct io_ring_ctx *=
ctx, unsigned int min_events)
> >                * the poll to the issued list. Otherwise we can spin her=
e
> >                * forever, while the workqueue is stuck trying to acquir=
e the
> >                * very same mutex.
> >                */
> >               if (list_empty(&ctx->iopoll_list) || io_task_work_pending=
(ctx)) {
> > -                     u32 tail =3D ctx->cached_cq_tail;
> > -
> >                       (void) io_run_local_work_locked(ctx, min_events);
> >
> >                       if (task_work_pending(current) || list_empty(&ctx=
->iopoll_list)) {
> >                               mutex_unlock(&ctx->uring_lock);
> >                               io_run_task_work();
> >                               mutex_lock(&ctx->uring_lock);
> >                       }
> >                       /* some requests don't go through iopoll_list */
> > -                     if (tail !=3D ctx->cached_cq_tail || list_empty(&=
ctx->iopoll_list))
> > +                     if (list_empty(&ctx->iopoll_list))
> >                               break;
> >               }
> >               ret =3D io_do_iopoll(ctx, !min_events);
> >               if (unlikely(ret < 0))
> >                       return ret;
> >
> >               if (task_sigpending(current))
> >                       return -EINTR;
> >               if (need_resched())
> >                       break;
> > -
> > -             nr_events +=3D ret;
> > -     } while (nr_events < min_events);
> > +     } while (io_cqring_events(ctx) < min_events);
>
> Before entering the loop, if io_cqring_events() finds any queued CQE,
> io_iopoll_check() returns immediately without polling.
>
> If the queued CQE is originated from non-iopoll uring_cmd, iopoll request
> will not be polled, may this be one issue?

I also noticed that logic and thought it seemed odd. I would think
we'd always want to wait for min_events CQEs (and iopoll once even if
min_events is 0). Looks like Jens added the early return in commit
a3a0e43fd770 ("io_uring: don't enter poll loop if we have CQEs
pending"), perhaps he can shed some light on it?

Thanks,
Caleb

