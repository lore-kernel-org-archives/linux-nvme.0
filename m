Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D68FFC9EC3
	for <linux-nvme@archiver.kernel.org>; Sat,  7 Mar 2026 02:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:References:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rqxlIwfDGS1E+lmb9grWkDLKbEw2kPFez03sw9KGHo4=; b=KldTRbVIThD99pMCWh7XZR0wML
	9xZAFZGOU5fHALnXAIzTEs+QHkC+B9+pVi4x/RuUpBCd2VHmtHyqzaciMuE/dCymi8wc6JmprxX39
	tLN2NkdGqnbuRgM/Y4ZBDkOvkmzcGiDH5OG0lhtCNLdWs8ltDa0ZynVQrdXjBjgJl7jicqbVFRWsu
	seZ+2VwrN8gCzhAqojMDJeLBZOex/uPTuly12FgvMYCGn++liKcJnYNZBFT09cx9aJL1R1RBLM7u9
	q5lBGqO98Vlzjm9DuWIaKJ6y8a2QEfz1nu3sVX0aVJVtatTqG0+7Xl10ly27LrzDj1vm6L6s+gDWM
	9kaXYO/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vyhWG-00000004oit-0fsW;
	Sat, 07 Mar 2026 02:35:56 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vyhWA-00000004ohx-1awl
	for linux-nvme@lists.infradead.org;
	Sat, 07 Mar 2026 02:35:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772850946;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rqxlIwfDGS1E+lmb9grWkDLKbEw2kPFez03sw9KGHo4=;
	b=PFdE6pONjqoB3NCG2bWeInKUM/Fh6H1YaR5zmGISedZRJiXCISoh9ePZN2qz2qIvpnKpnC
	YFF9R6AhxVw8ySKuPdfhZnfcBt5ZbwduKthmNDfEcG8zgaS1udmgFDvoo/0fbGYWgzso9D
	PmLJf2dXonddmDZY1oOY3bBTdDTEWPE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-510-m3m9-pxIM1CwYtLu4knl2w-1; Fri,
 06 Mar 2026 21:35:42 -0500
X-MC-Unique: m3m9-pxIM1CwYtLu4knl2w-1
X-Mimecast-MFC-AGG-ID: m3m9-pxIM1CwYtLu4knl2w_1772850940
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9515819560B5;
	Sat,  7 Mar 2026 02:35:39 +0000 (UTC)
Received: from fedora (unknown [10.72.116.24])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C555E1955D71;
	Sat,  7 Mar 2026 02:35:32 +0000 (UTC)
Date: Sat, 7 Mar 2026 10:35:27 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, Anuj Gupta <anuj20.g@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [PATCH v5 3/5] io_uring: count CQEs in io_iopoll_check()
Message-ID: <aauO72ocnZRhJkiA@fedora>
References: <20260302172914.2488599-1-csander@purestorage.com>
 <20260302172914.2488599-4-csander@purestorage.com>
 <aagKTanM5Az9UDsJ@fedora>
 <CADUfDZozycFBPX0kH=22Gda7njM3xVmL=Cy=zCq6cfXY8JH_dw@mail.gmail.com>
 <a6591d03-3707-4f1c-b1fa-49f010f98d53@kernel.dk>
 <CADUfDZp0shyZ5FqfEcwbi0tHXOFqwqZKRvwQW=heR-yvaOaw0Q@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CADUfDZp0shyZ5FqfEcwbi0tHXOFqwqZKRvwQW=heR-yvaOaw0Q@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: MSZl5qgkJpDRCpEgpDSZ7S-aHmkpiwPM6g4Jmvm119w_1772850940
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260306_183550_856672_B1283EE1 
X-CRM114-Status: GOOD (  38.97  )
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

On Fri, Mar 06, 2026 at 05:38:15PM -0800, Caleb Sander Mateos wrote:
> On Wed, Mar 4, 2026 at 8:29 AM Jens Axboe <axboe@kernel.dk> wrote:
> >
> > On 3/4/26 8:46 AM, Caleb Sander Mateos wrote:
> > > On Wed, Mar 4, 2026 at 2:33?AM Ming Lei <ming.lei@redhat.com> wrote:
> > >>
> > >> On Mon, Mar 02, 2026 at 10:29:12AM -0700, Caleb Sander Mateos wrote:
> > >>> A subsequent commit will allow uring_cmds that don't use iopoll on
> > >>> IORING_SETUP_IOPOLL io_urings. As a result, CQEs can be posted without
> > >>> setting the iopoll_completed flag for a request in iopoll_list or going
> > >>> through task work. For example, a UBLK_U_IO_FETCH_IO_CMDS command could
> > >>> call io_uring_mshot_cmd_post_cqe() to directly post a CQE. The
> > >>> io_iopoll_check() loop currently only counts completions posted in
> > >>> io_do_iopoll() when determining whether the min_events threshold has
> > >>> been met. It also exits early if there are any existing CQEs before
> > >>> polling, or if any CQEs are posted while running task work. CQEs posted
> > >>> via io_uring_mshot_cmd_post_cqe() or other mechanisms won't be counted
> > >>> against min_events.
> > >>>
> > >>> Explicitly check the available CQEs in each io_iopoll_check() loop
> > >>> iteration to account for CQEs posted in any fashion.
> > >>>
> > >>> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> > >>> ---
> > >>>  io_uring/io_uring.c | 9 ++-------
> > >>>  1 file changed, 2 insertions(+), 7 deletions(-)
> > >>>
> > >>> diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
> > >>> index 46f39831d27c..b4625695bb3a 100644
> > >>> --- a/io_uring/io_uring.c
> > >>> +++ b/io_uring/io_uring.c
> > >>> @@ -1184,11 +1184,10 @@ __cold void io_iopoll_try_reap_events(struct io_ring_ctx *ctx)
> > >>>               io_move_task_work_from_local(ctx);
> > >>>  }
> > >>>
> > >>>  static int io_iopoll_check(struct io_ring_ctx *ctx, unsigned int min_events)
> > >>>  {
> > >>> -     unsigned int nr_events = 0;
> > >>>       unsigned long check_cq;
> > >>>
> > >>>       min_events = min(min_events, ctx->cq_entries);
> > >>>
> > >>>       lockdep_assert_held(&ctx->uring_lock);
> > >>> @@ -1227,34 +1226,30 @@ static int io_iopoll_check(struct io_ring_ctx *ctx, unsigned int min_events)
> > >>>                * the poll to the issued list. Otherwise we can spin here
> > >>>                * forever, while the workqueue is stuck trying to acquire the
> > >>>                * very same mutex.
> > >>>                */
> > >>>               if (list_empty(&ctx->iopoll_list) || io_task_work_pending(ctx)) {
> > >>> -                     u32 tail = ctx->cached_cq_tail;
> > >>> -
> > >>>                       (void) io_run_local_work_locked(ctx, min_events);
> > >>>
> > >>>                       if (task_work_pending(current) || list_empty(&ctx->iopoll_list)) {
> > >>>                               mutex_unlock(&ctx->uring_lock);
> > >>>                               io_run_task_work();
> > >>>                               mutex_lock(&ctx->uring_lock);
> > >>>                       }
> > >>>                       /* some requests don't go through iopoll_list */
> > >>> -                     if (tail != ctx->cached_cq_tail || list_empty(&ctx->iopoll_list))
> > >>> +                     if (list_empty(&ctx->iopoll_list))
> > >>>                               break;
> > >>>               }
> > >>>               ret = io_do_iopoll(ctx, !min_events);
> > >>>               if (unlikely(ret < 0))
> > >>>                       return ret;
> > >>>
> > >>>               if (task_sigpending(current))
> > >>>                       return -EINTR;
> > >>>               if (need_resched())
> > >>>                       break;
> > >>> -
> > >>> -             nr_events += ret;
> > >>> -     } while (nr_events < min_events);
> > >>> +     } while (io_cqring_events(ctx) < min_events);
> > >>
> > >> Before entering the loop, if io_cqring_events() finds any queued CQE,
> > >> io_iopoll_check() returns immediately without polling.
> > >>
> > >> If the queued CQE is originated from non-iopoll uring_cmd, iopoll request
> > >> will not be polled, may this be one issue?
> > >
> > > I also noticed that logic and thought it seemed odd. I would think
> > > we'd always want to wait for min_events CQEs (and iopoll once even if
> > > min_events is 0). Looks like Jens added the early return in commit
> > > a3a0e43fd770 ("io_uring: don't enter poll loop if we have CQEs
> > > pending"), perhaps he can shed some light on it?
> >
> > I don't  recall the bug in question, it's been a while... But it always
> > makes sense to return events that are ready, and skip polling. It should
> > only be done if there are no ready events to reap.
> 
> Ming, are you okay with preserving that behavior in this patch then? I
> guess there's a potential fairness concern where REQ_F_IOPOLL requests
> may not be polled for some time if non-REQ_F_IOPOLL requests continue
> to frequently post CQEs.

IMO, the fairness may not a big deal given userspace should keep polling
if the iopoll IO isn't done.

But forget to mention, if non-iopoll CQE is posted and ->cq_flush becomes
true, io_submit_flush_completions() may not get chance to run in case of
the early return. 

Maybe something like below is needed:

@@ -1556,8 +1556,10 @@ static int io_iopoll_check(struct io_ring_ctx *ctx, unsigned int min_events)
         * If we do, we can potentially be spinning for commands that
         * already triggered a CQE (eg in error).
         */
-       if (io_cqring_events(ctx))
+       if (io_cqring_events(ctx)) {
+               io_submit_flush_completions(ctx);
                return 0;
+       }



Thanks,
Ming


