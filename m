Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7884FEE4E8
	for <linux-nvme@archiver.kernel.org>; Sat, 28 Feb 2026 09:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TKa9ExoJrCcyxe887LgwD6P4LJ/v9g4RnssVwA0or+A=; b=fFLTZb0FNCzpLvSZeStGvnggXE
	lmTEsJKZX2hxpDUyVNhTdAOoHGOcc8wtGHOzqHB5/O/fEN/zOQurV8tPIlWGo/oiTiU3w6FQ/oLuE
	yMqxcuz+LwQwScZYMeEIg4v7s5lQwSaxxIsdEITajyQ1n9z5rVO8P/b/IfTouhAL0y8ZFXzdSziXF
	s5rQx901FrS5vh+opcLCgZ6sTCqVTVV7ArlQxan/QILIp1nsGvErBH8LvMw7ubFXDkzZhqTW6S2hB
	wqyw5sJb7zZ2b/M0wmmky1hwcZCko1wUJbYEgabJNJt0lQZs7zvHebgvMfqBBTJbQqFSyTbJFlRH7
	KR2BfvZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vwGtx-00000009hPP-1UGN;
	Sat, 28 Feb 2026 09:46:21 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vwGtt-00000009hOu-3F6m
	for linux-nvme@lists.infradead.org;
	Sat, 28 Feb 2026 09:46:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772271974;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TKa9ExoJrCcyxe887LgwD6P4LJ/v9g4RnssVwA0or+A=;
	b=Y7yL19iNSUDCtUAs5DGlBYV1IZA2Rjr+AIG+IwuTdf9dgiOoDb+7/tnS37uetJQZCtunGz
	TIZ0TmDSMDou58XbELQ2isqmDoeeGITO7oS+HxOPrdC5ISjUJVDJGfo+Dr40dkOWnpt30o
	YG35MrPi3Beus2VD+xBMAiHjtSLg4OU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-376-Hl12rc4MPT6J_CtYXnIOyQ-1; Sat,
 28 Feb 2026 04:46:10 -0500
X-MC-Unique: Hl12rc4MPT6J_CtYXnIOyQ-1
X-Mimecast-MFC-AGG-ID: Hl12rc4MPT6J_CtYXnIOyQ_1772271969
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0AE861956080;
	Sat, 28 Feb 2026 09:46:08 +0000 (UTC)
Received: from fedora (unknown [10.72.116.144])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 15AE119560B5;
	Sat, 28 Feb 2026 09:46:00 +0000 (UTC)
Date: Sat, 28 Feb 2026 17:45:56 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, Anuj Gupta <anuj20.g@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [PATCH v4 3/5] io_uring: count CQEs in io_iopoll_check()
Message-ID: <aaK5VIfPR9fOil39@fedora>
References: <20260227223504.1162421-1-csander@purestorage.com>
 <20260227223504.1162421-4-csander@purestorage.com>
MIME-Version: 1.0
In-Reply-To: <20260227223504.1162421-4-csander@purestorage.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: kxT1LnXAkOTJJA-yuc8NWkdKGC7-tGQ_Qem2MdosHM0_1772271969
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260228_014617_891726_B08BB42B 
X-CRM114-Status: GOOD (  26.11  )
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

On Fri, Feb 27, 2026 at 03:35:01PM -0700, Caleb Sander Mateos wrote:
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
>  io_uring/io_uring.c | 18 +++---------------
>  1 file changed, 3 insertions(+), 15 deletions(-)
> 
> diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
> index 46f39831d27c..5f694052f501 100644
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
> @@ -1205,19 +1204,12 @@ static int io_iopoll_check(struct io_ring_ctx *ctx, unsigned int min_events)
>  		 * dropped CQE.
>  		 */
>  		if (check_cq & BIT(IO_CHECK_CQ_DROPPED_BIT))
>  			return -EBADR;
>  	}
> -	/*
> -	 * Don't enter poll loop if we already have events pending.
> -	 * If we do, we can potentially be spinning for commands that
> -	 * already triggered a CQE (eg in error).
> -	 */
> -	if (io_cqring_events(ctx))
> -		return 0;
>  
> -	do {
> +	while (io_cqring_events(ctx) < min_events) {

It may not handle zero `min_events` correctly, please see AI review result:

https://netdev-ai.bots.linux.dev/ai-review.html?id=6977b6d6-04e4-4990-a96f-b7580fc5acc4

Thanks,
Ming


