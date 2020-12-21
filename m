Return-Path: <SRS0=EJ6s=FZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B62C433E0
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Dec 2020 14:14:30 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5DF722BEA
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Dec 2020 14:14:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5DF722BEA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=chelsio.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=BVlPAXUISTbSGqzvGanPp7A3uUZ503JgPTTvETJzjhw=; b=UFofnUi3KZtB5USXiB9l/96bM
	e0wQ7SQ9pY0ZSPzwg5mSWoin0TPmNJzQyFds3WlyOA1u1iFh5r48p3jgZBWZ1nIciHD5awF0GY42H
	iGz9wTLAr6XsXj4JpNK8hU+rgvozelmRG/Haf/l9Phd4khBsq/yrE3G2gL7msM6IX6WJ/UIRbOQNY
	YxVtEok/KoVbrLMmZafIUbFbxszn2sAimwmmMw8EMNnB3HQ8ldjhek9XBmbuXV5g/AREJYP2+yln0
	2NJHlsAwSmJ2sePWElr6ke67tkLN9r1zFFx/y/W1Sl49ItdCuw0cD3qQHFMxiNVoZlhrx5/9HlMJi
	ocQEJM6NQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1krLx9-0002gg-FZ; Mon, 21 Dec 2020 14:14:23 +0000
Received: from stargate.chelsio.com ([12.32.117.8])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1krLx6-0002f2-CM
 for linux-nvme@lists.infradead.org; Mon, 21 Dec 2020 14:14:21 +0000
Received: from localhost (mehrangarh.blr.asicdesigners.com [10.193.185.169])
 by stargate.chelsio.com (8.13.8/8.13.8) with ESMTP id 0BLEDDkf015078;
 Mon, 21 Dec 2020 06:13:23 -0800
Date: Mon, 21 Dec 2020 19:43:03 +0530
From: Potnuri Bharat Teja <bharat@chelsio.com>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH] nvme-tcp: Fix possible race of io_work and direct send
Message-ID: <X+Ctbyv8vrkBl59I@chelsio.com>
References: <20201221080339.945164-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201221080339.945164-1-sagi@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201221_091420_596809_E637D090 
X-CRM114-Status: GOOD (  26.83  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Monday, December 12/21/20, 2020 at 13:33:39 +0530, Sagi Grimberg wrote:
> We may send a request (with or without its data) from two
> paths:
> 
> 1. From our I/O context nvme_tcp_io_work which
> is triggered from:
> - queue_rq
> - r2t reception
> - socket data_ready and write_space callbacks
> 
> 2. Directly from queue_rq if the send_list is empty (because
> we want to save the context switch associated with scheduling
> our io_work).
> 
> However, given that now we have the send_mutex, we may run into
> a race condition where none of these contexts will send the pending
> payload to the controller. Both io_work send path and queue_rq send
> path opportunistically attempt to acquire the send_mutex however
> queue_rq only attempts to send a single request, and if io_work
> context fails to acquire the send_mutex it will complete without
> rescheduling itself.
> 
> The race can trigger with the following sequence:
> 1. queue_rq sends request (no incapsule data) and blocks
> 2. RX path receives r2t - prepares data PDU to send, adds h2cdata PDU to the
>    send_list and schedules io_work
> 3. io_work triggers and cannot acquire the send_mutex - because of (1), ends
>    without self rescheduling
> 4. queue_rq completes the send, and completes
> ==> no context will send the h2cdata - timeout.
> 
> Fix this by having queue_rq sending as much as it can from the send_list
> such that if it still has any left, its because the socket buffer is
> full and the socket write_space callback will trigger, thus guaranteeing
> that a context will be scheduled to send the h2cdata PDU.
> 
> Fixes: db5ad6b7f8cd ("nvme-tcp: try to send request in queue_rq context")
> Reported-by: Potnuri Bharat Teja <bharat@chelsio.com>
> Reported-by: Samuel Jones <sjones@kalrayinc.com>
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>

Tested-by: Potnuri Bharat Teja <bharat@chelsio.com>

> ---
>  drivers/nvme/host/tcp.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 1ba659927442..979ee31b8dd1 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -262,6 +262,16 @@ static inline void nvme_tcp_advance_req(struct nvme_tcp_request *req,
>  	}
>  }
>  
> +static inline void nvme_tcp_send_all(struct nvme_tcp_queue *queue)
> +{
> +	int ret;
> +
> +	/* drain the send queue as much as we can... */
> +	do {
> +		ret = nvme_tcp_try_send(queue);
> +	} while (ret > 0);
> +}
> +
>  static inline void nvme_tcp_queue_request(struct nvme_tcp_request *req,
>  		bool sync, bool last)
>  {
> @@ -279,7 +289,7 @@ static inline void nvme_tcp_queue_request(struct nvme_tcp_request *req,
>  	if (queue->io_cpu == smp_processor_id() &&
>  	    sync && empty && mutex_trylock(&queue->send_mutex)) {
>  		queue->more_requests = !last;
> -		nvme_tcp_try_send(queue);
> +		nvme_tcp_send_all(queue);
>  		queue->more_requests = false;
>  		mutex_unlock(&queue->send_mutex);
>  	} else if (last) {
> -- 
> 2.25.1
> 
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
