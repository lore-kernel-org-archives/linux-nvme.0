Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99F51FC9EC4
	for <linux-nvme@archiver.kernel.org>; Sat,  7 Mar 2026 01:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XVr4Mu9HxXeAvAZT+n+MNzB0B1nXnQUrPhRWUN3nixs=; b=p6a+pthkNyocf/g2fPCJZWVzS9
	uKInfF2PuEtydBPP8P0lvGemOKN6+rVAG2OtgkL5j9Yr4EyNm8uCkzBw+Pd2Ct823c/De9las9MR3
	VPILy7YXBx+v6V6Sr1N4AuyEwJTJyHv71zxdUt/x0Ad+lHRQKYcn8niQSI3GrMCZQkDt4NCJnet8o
	jH/UHi3cKKE9cvFeX+1yNHwa90UehDyKzGc7JLZZ+hhrPvIkq2vPgE64nhog7LjLTGNjGmma9mwTW
	K73qyYTwCTgGnmcvbvvUTrc7cLHJR11oqPOhxw/YXf5IurWw+xMQqEZhcSX4U5CH5o3mkd2WqfitP
	sej7CKPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vygcg-00000004mfx-3xcy;
	Sat, 07 Mar 2026 01:38:30 +0000
Received: from mail-oo1-xc30.google.com ([2607:f8b0:4864:20::c30])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vygcd-00000004mfZ-3wPe
	for linux-nvme@lists.infradead.org;
	Sat, 07 Mar 2026 01:38:29 +0000
Received: by mail-oo1-xc30.google.com with SMTP id 006d021491bc7-679f7029fc4so508572eaf.2
        for <linux-nvme@lists.infradead.org>; Fri, 06 Mar 2026 17:38:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772847506; cv=none;
        d=google.com; s=arc-20240605;
        b=dYg6N2r55A2b/Mb64PQ5/rm3nhjyYwydO3RZz1P3Lj5tOkXK36cACm3sEKsZfqy5mj
         QMSiG61ExDaHxJaKE+4Tix4QuREO1K8wQTYmTaysL2ybU7N6SN88EcHWobnUShJ/vCj7
         9N5r0C75xdJTJwDWLhbezhjfV2MU26u1w9wlICx4sk4Uf6myiMVHbPQOSwEJX/mVqGX7
         zTedJK6+TR0ZQwhDtT/RuM4Q+CENukbfXUzod7sOGsDjBbTVrDh12bbF3X8YEtiR5xZB
         +k3XcMiEN9UgCjMRxAjXxSE5pDVu2Y2nr2IAY7g1iYktZ4WCn9v6sVurTPKGaNYp5acx
         M76w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XVr4Mu9HxXeAvAZT+n+MNzB0B1nXnQUrPhRWUN3nixs=;
        fh=0/DhXWSShdNXF+h3eCTBNYlM7Iwxc+DSa62wC+fWbak=;
        b=ATS38pBfsWFSycJEzyz1qgsZ5XsYPCW1TizCPQHCAKR8J/HkFMj0mmg6Hq8zI5v5sX
         1urlwmiFPL/nvQ+TNC7GivCEBdR8VN++8LZob6B3zh8mECVZpadUSMc+jgXMRFqEYvzZ
         h4op58wqj7Zc5XD6hZfnJkCNo7W9LcByrXzoQatIT7FWl9pXWPzErzsPHVCDjLul7AaY
         +BK8IPAiUvjJfzOUmYRIii5U2Ey2atn+ZIWtB/fxrrNj8I81pnnzxSoINohlaUQqyVac
         71syK1j8UoJA1dWlP6XoUqwFRmZUfCOek42o3KyGF7Xb9pNypfte/oX3W/hFBgFvbKMC
         6LXw==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1772847506; x=1773452306; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XVr4Mu9HxXeAvAZT+n+MNzB0B1nXnQUrPhRWUN3nixs=;
        b=LkWYJyHUXxuZ5wVbexs1B8aLqcwrJoIKNgT8XGjdrvY829UGQiUrFFoLVnzm8fwigy
         pFfn7y2D1s6eQ3D7iR2uoYNvmD6a/GDYxCxRTyqZRmiq0KxQtAoGYHhfezT5Llx9haME
         q0bXSv8M1RCW9OzQNXdzbLPAzPUWHeMi4ojJK2FwMiiXQchNQHBoyLSQFilon6KOVNjZ
         kfVZ3HhoJKY3yx5jH04jRaYs+ydFoqUiKEgUrfePVPGdkJCWKsfL6iedD+vf1/bCE7cj
         trq9gmg4oQUHTkB949ZI1GdhjYiUNNDVTDhNPqQnMrQxMDYXbTu2ABtriQmytH0TSJvX
         LnqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772847506; x=1773452306;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XVr4Mu9HxXeAvAZT+n+MNzB0B1nXnQUrPhRWUN3nixs=;
        b=NNl89vh0BlIlfYvsc3x0rbSe84Sd/pUc7Z6RxbT88Z2UxMjf04NVHKaJiaMvyfB4l/
         OtuY8bfbm96Dp4/uEbNwgVmufZWrcYafJOfCPeDbDUE9WZ7jDz561nSZnvb9XBRDGheO
         VJUQOcH8gPD9sueM6JuzQgOYMTGkSXNeIt61kVz4K3un4Ce+tCeA8JQoP63lZgxNe8q/
         bksDGpIIK/Y8C9YLvoLND/KmG8yA6Qe4xRiwBzMvPUNgH/26MHlh7565SKQ+KEDSB9Ss
         z7jQCuxfCbJfacP0Fcq1cJgmq4xWO55mEvIrYv5pQXRmxCfiiWBd5fy6DXCfFnN2MrEs
         NDjg==
X-Forwarded-Encrypted: i=1; AJvYcCXK8Ke8hdvUUC5fzSkwRtYeqS1VXk/w1bRgKhvho9BwB1+gIGnnRrudkFbFM7CtqkkllR40VNgZ5fr5@lists.infradead.org
X-Gm-Message-State: AOJu0YzmYe+VattEUIPXyapovEpNV4HrjvAzFCzL7ttNV3ZtPR6BMrmp
	ACfxaXoaUUdIqYqnu0B6IkAjO106dheOKtpjG2gG+inQGcpLGXnLgEYWCtGJe2akDiWNSbrYZeP
	CtXEmNYQczmWOufb/Jj+l20mbLV+BEnxUymXHeSkfRg==
X-Gm-Gg: ATEYQzwL/B4km9AvQ0pook/QAXtoKqCh5nYlm6gvuTy+MslwLmf1dDmLHerkY8k0nL1
	J5VgRoSZRIdH2fUIYdMCwBx5o0C0qvBn9DahJDH3t1ScCrO4zT1xju/Rx6dV+Rgv/foMtguv4l1
	m0+YCBMT6yH2CDrd3cj5fthkCsQSgnTfBiZ2gYVmdnCYEnMKDcW02lJ3vcf8e/S+i89VF4GvsK4
	Wq089oYbSA06xBsOfgsoqNZJYcnub/MY4/3isOe5jwZgI2Ip7ZgZU5cjA/GW1X7dVxpQr0D6Oci
	lsoeuXSj
X-Received: by 2002:a05:6820:3302:b0:67a:1cf1:a413 with SMTP id
 006d021491bc7-67b9bb6e5d1mr1266737eaf.0.1772847506363; Fri, 06 Mar 2026
 17:38:26 -0800 (PST)
MIME-Version: 1.0
References: <20260302172914.2488599-1-csander@purestorage.com>
 <20260302172914.2488599-4-csander@purestorage.com> <aagKTanM5Az9UDsJ@fedora>
 <CADUfDZozycFBPX0kH=22Gda7njM3xVmL=Cy=zCq6cfXY8JH_dw@mail.gmail.com> <a6591d03-3707-4f1c-b1fa-49f010f98d53@kernel.dk>
In-Reply-To: <a6591d03-3707-4f1c-b1fa-49f010f98d53@kernel.dk>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Fri, 6 Mar 2026 17:38:15 -0800
X-Gm-Features: AaiRm53Xogk7L6yD1Xoposf2XIZMV_wPnho43LlH5PzUQLffjxfNhTFbldlbwNA
Message-ID: <CADUfDZp0shyZ5FqfEcwbi0tHXOFqwqZKRvwQW=heR-yvaOaw0Q@mail.gmail.com>
Subject: Re: [PATCH v5 3/5] io_uring: count CQEs in io_iopoll_check()
To: Jens Axboe <axboe@kernel.dk>
Cc: Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, 
	Sagi Grimberg <sagi@grimberg.me>, io-uring@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Anuj Gupta <anuj20.g@samsung.com>, 
	Kanchan Joshi <joshi.k@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260306_173828_019921_D35FFBF0 
X-CRM114-Status: GOOD (  31.62  )
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

On Wed, Mar 4, 2026 at 8:29=E2=80=AFAM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 3/4/26 8:46 AM, Caleb Sander Mateos wrote:
> > On Wed, Mar 4, 2026 at 2:33?AM Ming Lei <ming.lei@redhat.com> wrote:
> >>
> >> On Mon, Mar 02, 2026 at 10:29:12AM -0700, Caleb Sander Mateos wrote:
> >>> A subsequent commit will allow uring_cmds that don't use iopoll on
> >>> IORING_SETUP_IOPOLL io_urings. As a result, CQEs can be posted withou=
t
> >>> setting the iopoll_completed flag for a request in iopoll_list or goi=
ng
> >>> through task work. For example, a UBLK_U_IO_FETCH_IO_CMDS command cou=
ld
> >>> call io_uring_mshot_cmd_post_cqe() to directly post a CQE. The
> >>> io_iopoll_check() loop currently only counts completions posted in
> >>> io_do_iopoll() when determining whether the min_events threshold has
> >>> been met. It also exits early if there are any existing CQEs before
> >>> polling, or if any CQEs are posted while running task work. CQEs post=
ed
> >>> via io_uring_mshot_cmd_post_cqe() or other mechanisms won't be counte=
d
> >>> against min_events.
> >>>
> >>> Explicitly check the available CQEs in each io_iopoll_check() loop
> >>> iteration to account for CQEs posted in any fashion.
> >>>
> >>> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> >>> ---
> >>>  io_uring/io_uring.c | 9 ++-------
> >>>  1 file changed, 2 insertions(+), 7 deletions(-)
> >>>
> >>> diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
> >>> index 46f39831d27c..b4625695bb3a 100644
> >>> --- a/io_uring/io_uring.c
> >>> +++ b/io_uring/io_uring.c
> >>> @@ -1184,11 +1184,10 @@ __cold void io_iopoll_try_reap_events(struct =
io_ring_ctx *ctx)
> >>>               io_move_task_work_from_local(ctx);
> >>>  }
> >>>
> >>>  static int io_iopoll_check(struct io_ring_ctx *ctx, unsigned int min=
_events)
> >>>  {
> >>> -     unsigned int nr_events =3D 0;
> >>>       unsigned long check_cq;
> >>>
> >>>       min_events =3D min(min_events, ctx->cq_entries);
> >>>
> >>>       lockdep_assert_held(&ctx->uring_lock);
> >>> @@ -1227,34 +1226,30 @@ static int io_iopoll_check(struct io_ring_ctx=
 *ctx, unsigned int min_events)
> >>>                * the poll to the issued list. Otherwise we can spin h=
ere
> >>>                * forever, while the workqueue is stuck trying to acqu=
ire the
> >>>                * very same mutex.
> >>>                */
> >>>               if (list_empty(&ctx->iopoll_list) || io_task_work_pendi=
ng(ctx)) {
> >>> -                     u32 tail =3D ctx->cached_cq_tail;
> >>> -
> >>>                       (void) io_run_local_work_locked(ctx, min_events=
);
> >>>
> >>>                       if (task_work_pending(current) || list_empty(&c=
tx->iopoll_list)) {
> >>>                               mutex_unlock(&ctx->uring_lock);
> >>>                               io_run_task_work();
> >>>                               mutex_lock(&ctx->uring_lock);
> >>>                       }
> >>>                       /* some requests don't go through iopoll_list *=
/
> >>> -                     if (tail !=3D ctx->cached_cq_tail || list_empty=
(&ctx->iopoll_list))
> >>> +                     if (list_empty(&ctx->iopoll_list))
> >>>                               break;
> >>>               }
> >>>               ret =3D io_do_iopoll(ctx, !min_events);
> >>>               if (unlikely(ret < 0))
> >>>                       return ret;
> >>>
> >>>               if (task_sigpending(current))
> >>>                       return -EINTR;
> >>>               if (need_resched())
> >>>                       break;
> >>> -
> >>> -             nr_events +=3D ret;
> >>> -     } while (nr_events < min_events);
> >>> +     } while (io_cqring_events(ctx) < min_events);
> >>
> >> Before entering the loop, if io_cqring_events() finds any queued CQE,
> >> io_iopoll_check() returns immediately without polling.
> >>
> >> If the queued CQE is originated from non-iopoll uring_cmd, iopoll requ=
est
> >> will not be polled, may this be one issue?
> >
> > I also noticed that logic and thought it seemed odd. I would think
> > we'd always want to wait for min_events CQEs (and iopoll once even if
> > min_events is 0). Looks like Jens added the early return in commit
> > a3a0e43fd770 ("io_uring: don't enter poll loop if we have CQEs
> > pending"), perhaps he can shed some light on it?
>
> I don't  recall the bug in question, it's been a while... But it always
> makes sense to return events that are ready, and skip polling. It should
> only be done if there are no ready events to reap.

Ming, are you okay with preserving that behavior in this patch then? I
guess there's a potential fairness concern where REQ_F_IOPOLL requests
may not be polled for some time if non-REQ_F_IOPOLL requests continue
to frequently post CQEs.

Jens, any thoughts on this series? Is it ready to merge?

Thanks,
Caleb

