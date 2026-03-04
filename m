Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EB07EB7EBC
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Mar 2026 10:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6c9L5RtHp8CSPnp5zZyBQRyYeXPW3aEtn53qvsfLHHk=; b=fVhaDZuycP2P3MbxTm6Yp5dTaI
	aT0ZvAoXPzTqeWj7jX3whuunjvvJeSSU81KR5Hja9ARyDgkgQOs/TAljWnDFipDoIxtnJMSA7eLRB
	RUO/7gkTo6fNxyC9eLhTYchr7Xo4r+jJ2vxcFqUJs19KiCZOWZSpnmu/sfqqNMe4QAGFehsIv6AJk
	5/KH9rkobXEV89RotobjnweNXk3F9CVMN2SUCQuUDly4dvuP4QFgxI4AFQ3OnyEZAzzAdZok7k91/
	zocMSGKK5fO6MDmKM1cJ/VMtt+8oitmvy+0sSjt0Ix6ke5FfmsGzzRhksm62ERmDMNUgK8XT3qWIU
	uTq2XpMw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxjXT-0000000Gzsy-1ZaY;
	Wed, 04 Mar 2026 10:33:11 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxjXQ-0000000Gzsd-2knb
	for linux-nvme@lists.infradead.org;
	Wed, 04 Mar 2026 10:33:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772620385;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6c9L5RtHp8CSPnp5zZyBQRyYeXPW3aEtn53qvsfLHHk=;
	b=LLZGkCe91QDbe6HUNu0KnWIII5X9Qman7+/1An48LqE0mKWqZQgEbHawrJki5i8+GBWGZV
	RegdNPOpdTdkQAx+bvIzMNCozwAQAzcrQGhXNE/q2laJRndf8gGWNrVPXTh+dK49dUKrSI
	ZvtYFNc2UVbs1FR2GFNvnPN5Ms8f388=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-74-TfJoT7MpPLuVRyYeA_WI_Q-1; Wed,
 04 Mar 2026 05:32:59 -0500
X-MC-Unique: TfJoT7MpPLuVRyYeA_WI_Q-1
X-Mimecast-MFC-AGG-ID: TfJoT7MpPLuVRyYeA_WI_Q_1772620378
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 65F251956096;
	Wed,  4 Mar 2026 10:32:57 +0000 (UTC)
Received: from fedora (unknown [10.72.116.5])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D582E195608E;
	Wed,  4 Mar 2026 10:32:50 +0000 (UTC)
Date: Wed, 4 Mar 2026 18:32:45 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, Anuj Gupta <anuj20.g@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [PATCH v5 3/5] io_uring: count CQEs in io_iopoll_check()
Message-ID: <aagKTanM5Az9UDsJ@fedora>
References: <20260302172914.2488599-1-csander@purestorage.com>
 <20260302172914.2488599-4-csander@purestorage.com>
MIME-Version: 1.0
In-Reply-To: <20260302172914.2488599-4-csander@purestorage.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: KJHQzPabf_f7ouObZ2nbGV-uU_pY3PEnUeQ-YAMkE98_1772620378
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260304_023308_786877_F20944EB 
X-CRM114-Status: GOOD (  26.20  )
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

On Mon, Mar 02, 2026 at 10:29:12AM -0700, Caleb Sander Mateos wrote:
> A subsequent commit will allow uring_cmds that don't use iopoll on
> IORING_SETUP_IOPOLL io_urings. As a result, CQEs can be posted without
> setting the iopoll_completed flag for a request in iopoll_list or going
> through task work. For example, a UBLK_U_IO_FETCH_IO_CMDS command could
> call io_uring_mshot_cmd_post_cqe() to directly post a CQE. The
> io_iopoll_check() loop currently only counts completions posted in
> io_do_iopoll() when determining whether the min_events threshold has
> been met. It also exits early if there are any existing CQEs before
> polling, or if any CQEs are posted while running task work. CQEs posted
> via io_uring_mshot_cmd_post_cqe() or other mechanisms won't be counted
> against min_events.
> 
> Explicitly check the available CQEs in each io_iopoll_check() loop
> iteration to account for CQEs posted in any fashion.
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> ---
>  io_uring/io_uring.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
> index 46f39831d27c..b4625695bb3a 100644
> --- a/io_uring/io_uring.c
> +++ b/io_uring/io_uring.c
> @@ -1184,11 +1184,10 @@ __cold void io_iopoll_try_reap_events(struct io_ring_ctx *ctx)
>  		io_move_task_work_from_local(ctx);
>  }
>  
>  static int io_iopoll_check(struct io_ring_ctx *ctx, unsigned int min_events)
>  {
> -	unsigned int nr_events = 0;
>  	unsigned long check_cq;
>  
>  	min_events = min(min_events, ctx->cq_entries);
>  
>  	lockdep_assert_held(&ctx->uring_lock);
> @@ -1227,34 +1226,30 @@ static int io_iopoll_check(struct io_ring_ctx *ctx, unsigned int min_events)
>  		 * the poll to the issued list. Otherwise we can spin here
>  		 * forever, while the workqueue is stuck trying to acquire the
>  		 * very same mutex.
>  		 */
>  		if (list_empty(&ctx->iopoll_list) || io_task_work_pending(ctx)) {
> -			u32 tail = ctx->cached_cq_tail;
> -
>  			(void) io_run_local_work_locked(ctx, min_events);
>  
>  			if (task_work_pending(current) || list_empty(&ctx->iopoll_list)) {
>  				mutex_unlock(&ctx->uring_lock);
>  				io_run_task_work();
>  				mutex_lock(&ctx->uring_lock);
>  			}
>  			/* some requests don't go through iopoll_list */
> -			if (tail != ctx->cached_cq_tail || list_empty(&ctx->iopoll_list))
> +			if (list_empty(&ctx->iopoll_list))
>  				break;
>  		}
>  		ret = io_do_iopoll(ctx, !min_events);
>  		if (unlikely(ret < 0))
>  			return ret;
>  
>  		if (task_sigpending(current))
>  			return -EINTR;
>  		if (need_resched())
>  			break;
> -
> -		nr_events += ret;
> -	} while (nr_events < min_events);
> +	} while (io_cqring_events(ctx) < min_events);

Before entering the loop, if io_cqring_events() finds any queued CQE,
io_iopoll_check() returns immediately without polling.

If the queued CQE is originated from non-iopoll uring_cmd, iopoll request
will not be polled, may this be one issue?


Thanks,
Ming


