Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271D8606A320
	for <linux-nvme@archiver.kernel.org>; Sun, 22 Nov 2026 01:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=iVgXf/ed;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=onrTfMQ+
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=2RXhtdX03YYhTyECJCW0C5gFw3Lx+7BYSRSxnYn+5NA=; b=iVgXf/ed8oyDnXWQkmT1O6kZRb
	rTl2T3VeeeEVw+2G7/6xrSEXWWz4pAH55s4vXbdt18PjySADi9yJCVmYs/JALoaN3lyUFY05jjKsx
	7OPJt8s/IQQukEKIw7K4iX86HVnPcnXH8KZtgbzYbCDinMGBlTNKdAAqANRREvq7vURr8dK+CJGlF
	y4ZFfD4Rsi8m46ayZu8JRoJIlh2LHhbjkHkA9mhBSO/2GAyQUmyMA1MF9edPbFOoN6FGO7r3YIg02
	eWwK3XMf6Yu5Z97DFgBvWNQBoQ3aRrd1dE8FavO9ScIhCgO8tUTfHNcx0Q74R00yN0vbn/G4LMzrG
	Ov4610cw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUwbT-00000000fPM-3Dni;
	Sun, 22 Nov 2026 01:42:51 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUwbS-00000000fPG-1iVT
	for linux-nvme@lists.infradead.org;
	Sun, 22 Nov 2026 01:42:50 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id B77C342BA8;
	Sun, 22 Nov 2026 01:42:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85E491F000C0;
	Sun, 22 Nov 2026 01:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795311769;
	bh=2RXhtdX03YYhTyECJCW0C5gFw3Lx+7BYSRSxnYn+5NA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=onrTfMQ+7/Fg61+18wNmv4wtT0RrIc4cCZRAzJT316VeqMo/Nwd1jrnvwl1V9SgKb
	 mIhtV3xxnIT9gIhIJYPZFCLJ4XfWQyJbBqK5r+mpSxXocPh28Zlc6bObAV3yoybSPf
	 re27vJIYLpbjr+b3OsnDFhIL5CugCLMjERhvb0CQGvT01VtPMaFIeF9Xx1nwMhmLIq
	 /SUXtC2CrAJ/CcTkDVJz9Ti/4wffA8L+gAYyoMXZUf5hXAmCyh2G2W0KEYaler8GCY
	 DlkJk6DQKqYMC1HIx+RB0WP47hfv+/WznqSUbE94JSNqP9KQ/zrshXCej5WcYK7T8r
	 8GdZGZVjU9ukA==
Message-ID: <sashiko-outbox-227628@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 1/2] nvme-tcp: remove the direct send path
To: "Seiji Nishikawa" <snishika@redhat.com>
Cc: linux-nvme@lists.infradead.org
In-Reply-To: <20261122011826.1959697-2-snishika@redhat.com>
References: <20261122011826.1959697-1-snishika@redhat.com>
 <20261122011826.1959697-2-snishika@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 22 Nov 2026 01:42:49 +0000
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] nvme-tcp: poll queue starvation and latency regression in
  nvme_tcp_queue_request()
--

commit 7f6babf6da3e0f7ca956d6a355e996efe6f74e66
Author: Seiji Nishikawa <snishika@redhat.com>

nvme-tcp: remove the direct send path

This commit removes the inline direct send path in nvme_tcp_queue_request()
and nvme_tcp_send_all(), deferring all request transmissions to
queue->io_work on nvme_tcp_wq.

> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 62a594b8ab9bf..2b832ac3068a9 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
[ ... ]
> @@ -446,28 +435,10 @@ static inline void nvme_tcp_queue_request(struct nv=
me_tcp_request *req,
>  		bool last)
>  {
>  	struct nvme_tcp_queue *queue =3D req->queue;
> -	bool empty;
> =20
> -	empty =3D llist_add(&req->lentry, &queue->req_list) &&
> -		list_empty(&queue->send_list) && !queue->request;
> -
> -	/*
> -	 * if we're the first on the send_list and we can try to send
> -	 * directly, otherwise queue io_work. Also, only do that if we
> -	 * are on the same cpu, so we don't introduce contention.
> -	 *
> -	 * TLS kTLS send takes ctx->tx_lock while blk_mq holds set->srcu.
> -	 * lockdep reports circular locking via elevator_lock.  Defer TLS
> -	 * sends to the io workqueue instead of inline from this path.
> -	 */
> -	if (queue->io_cpu =3D=3D raw_smp_processor_id() &&
> -	    !nvme_tcp_queue_tls(queue) &&
> -	    empty && mutex_trylock(&queue->send_mutex)) {
> -		nvme_tcp_send_all(queue);
> -		mutex_unlock(&queue->send_mutex);
> -	}
> +	llist_add(&req->lentry, &queue->req_list);
> =20
> -	if (last && nvme_tcp_queue_has_pending(queue))
> +	if (last)
>  		queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
>  }

[Severity: Medium]
Does removing the inline send from nvme_tcp_queue_request() break polled
I/O on HCTX_TYPE_POLL queues?

nvme_tcp_set_queue_io_cpu() binds queue->io_cpu for a poll queue to a CPU
in set->map[HCTX_TYPE_POLL].mq_map, while nvme_tcp_poll() only polls the
receive side and never drains queue->req_list:

drivers/nvme/host/tcp.c:nvme_tcp_poll() {
    ...
	set_bit(NVME_TCP_Q_POLLING, &queue->flags);
	if (sk_can_busy_loop(sk) && skb_queue_empty_lockless(&sk->sk_receive_queue=
))
		sk_busy_loop(sk, true);
	ret =3D nvme_tcp_try_recv(queue);
	clear_bit(NVME_TCP_Q_POLLING, &queue->flags);
    ...
}

Previously, a task submitting and polling on queue->io_cpu sent the
request inline when the queue was idle and completed it without waking
nvme_tcp_wq.  With all sends deferred to queue->io_work on queue->io_cpu,
a SCHED_FIFO or SCHED_RR task polling via io_uring IORING_SETUP_IOPOLL or
blk_execute_rq() on queue->io_cpu starves the SCHED_NORMAL nvme_tcp_wq
worker on the same CPU and spins in nvme_tcp_poll() waiting for a request
still sitting in queue->req_list until RT throttling or the 30-second
NVMe I/O timeout fires.  For SCHED_NORMAL tasks on queue->io_cpu, waking
the WQ_HIGHPRI worker sets TIF_NEED_RESCHED, causing blk_hctx_poll() and
io_iopoll_check() to abort polling on need_resched() or forcing two
context switches per polled I/O.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261122011826.1959=
697-1-snishika@redhat.com?part=3D1

