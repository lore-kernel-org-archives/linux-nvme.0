Received: from smtp.lore.kernel.org (ip-10-30-226-214.us-west-2.compute.internal [10.30.226.214])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A03606A322
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Oct 2026 14:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=rRg1cMfm;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jt3manw0
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C695FCCF2E6
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Oct 2026 14:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oUauQvHS3NTWyt9vjGJPWt7FZhoq+fPqFt/ovAb7PII=; b=rRg1cMfmfxPn01/aHIfidadjk+
	UaDG7sbAi89uT6nnvwkCIZO2nBXQMGZmLHRCQQxbcnZO9LR4qKTKP/JPb6kCvCYYwt8M97q9q0cCF
	AXUgOtFRdUCGpZMKUeas4btDMG4aUqtGedsnM3dGF8HDHe7frLd0BwqTXT/E6NpR6uHVb+zP6NfEm
	66pmPGx5NI1WP4r4jyi5wcuPLPAPLlRs2PivqxLaeaXuqzUjuN6lbrxJBEJR92fn6W8dw8/lEARno
	swIocGzu+jjqQ2D6WGPnDcTQMq5tPsiVXGLE6Yy7UkF5I9pOvpWPE8DN+FGTLnJtYRD+fOf+1IMaQ
	/OB6f68A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIohF-00000007mU5-2uPK;
	Mon, 19 Oct 2026 14:50:41 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIohE-00000007mTw-3B1h
	for linux-nvme@lists.infradead.org;
	Mon, 19 Oct 2026 14:50:40 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id E70CE60210
	for <linux-nvme@lists.infradead.org>; Mon, 19 Oct 2026 14:50:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C2CD1F000C4;
	Mon, 19 Oct 2026 14:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792421439;
	bh=oUauQvHS3NTWyt9vjGJPWt7FZhoq+fPqFt/ovAb7PII=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jt3manw0+0PNVgyKezATASKo0q+s096Fyart3hWQsdFW3n24K2Os6xGoYRcLpcU3q
	 Q/4FgTuyW4bVa4NTRtL/QE+T9P7UgbzH3tszG7ZFyGjU+1RpvQ3319p5VtBKdUXE7E
	 SqKrRFpz3UQG+ZGLh3eCVsq+FIitwq2t7JyEHS8+MYQ9l8XeoprWHCPcn6GXjTvZCe
	 Df72CbttBt7GnstsH1vH8nZhKwFZgqZIp9oEY2+lOQE2U1ex/JJHtCRucuRKwMDMS2
	 oRVn9hzbk/vnUMTcK2cqQzWlx5Q2KMGQVIc5hpJng2vCqxi2oUh7RgoNQCG1I+uCk8
	 zfejpFT+a4WTQ==
Message-ID: <sashiko-outbox-177519@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 6.18] nvme-tcp: delay
 nvme_tcp_reclassify_socket()
To: "Sasha Levin" <sashal@kernel.org>
Cc: linux-nvme@lists.infradead.org
In-Reply-To: <20261019135441.1420968-249-sashal@kernel.org>
References: <20261019135441.1420968-1-sashal@kernel.org>
 <20261019135441.1420968-249-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 14:50:39 +0000
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
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_ZEN_BLOCKED_OPENDNS,SPF_HELO_NONE
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] nvme-tcp: unsafe live lock reinit in nvme_tcp_reclassify_socket()
--

commit 168d45f90ed1a7b47f62fbd5085e5e0bbb05d5a8
Author: Eric Dumazet <edumazet@google.com>

nvme-tcp: delay nvme_tcp_reclassify_socket()

This commit delays nvme_tcp_reclassify_socket() in nvme_tcp_alloc_queue()
until after kernel_connect() and the optional nvme_tcp_start_tls() handshake
complete, in order to avoid pulling tlshd lock dependencies into the
nvme-tcp socket lockdep class.

Link: https://lore.kernel.org/lkml/CANn89i+wnTLC=3D=3DUnXCpjsS4YxvEfhe5oK0N=
7fttbqr1zKyqdug@mail.gmail.com/

> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index beef2b576102a..da148092677fe 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -1859,7 +1859,6 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *n=
ctrl, int qid,
>  	}
> =20
>  	sk_net_refcnt_upgrade(queue->sock->sk);
> -	nvme_tcp_reclassify_socket(queue->sock);
> =20
>  	/* Single syn retry */
>  	tcp_sock_set_syncnt(queue->sock->sk, 1);
> @@ -1948,6 +1947,8 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *n=
ctrl, int qid,
>  			goto err_init_connect;
>  	}
> =20
> +	nvme_tcp_reclassify_socket(queue->sock);
> +

[Severity: High]
Is it safe to call nvme_tcp_reclassify_socket() here after kernel_connect()
and nvme_tcp_start_tls() have already run?

When CONFIG_DEBUG_LOCK_ALLOC is enabled, nvme_tcp_reclassify_socket() checks
sock_allow_reclassification() and calls sock_lock_init_class_and_name() in
process context with bottom halves enabled and no lock held:

drivers/nvme/host/tcp.c:nvme_tcp_reclassify_socket() {
	struct sock *sk =3D sock->sk;

	if (WARN_ON_ONCE(!sock_allow_reclassification(sk)))
		return;

	switch (sk->sk_family) {
	case AF_INET:
		sock_lock_init_class_and_name(sk, "slock-AF_INET-NVME",
					      &nvme_tcp_slock_key[0],
					      "sk_lock-AF_INET-NVME",
					      &nvme_tcp_sk_key[0]);
		break;
    ...
}

And sock_lock_init_class_and_name() reinitializes sk->sk_lock in-place:

include/net/sock.h:sock_lock_init_class_and_name()
	sk_owner_set(sk, THIS_MODULE);
	sk->sk_lock.owned =3D 0;
	init_waitqueue_head(&sk->sk_lock.wq);
	spin_lock_init(&(sk)->sk_lock.slock);
	debug_check_no_locks_freed((void *)&(sk)->sk_lock,
				   sizeof((sk)->sk_lock));
	lockdep_set_class_and_name(&(sk)->sk_lock.slock,
				   (skey), (sname));
	lockdep_init_map(&(sk)->sk_lock.dep_map, (name), (key), 0);

At this point in nvme_tcp_alloc_queue() (reached from
nvme_tcp_alloc_admin_queue() or __nvme_tcp_alloc_io_queues()),
kernel_connect() has already transitioned queue->sock->sk to TCP_ESTABLISHE=
D,
hashed it into inet_ehash, and armed TCP timers. In addition, when TLS is
used, handshake_nl_done_doit() -> handshake_complete() ->
nvme_tcp_tls_done() completes queue->tls_complete before userspace tlshd
closes its open file descriptor to queue->sock->file.

If incoming peer packets (such as TCP ACKs, window updates, TLS 1.3
post-handshake NewSessionTicket messages, or FIN/RST) trigger softirq TCP RX
(tcp_v4_rcv() / tcp_v6_rcv()), or if TCP timers (tcp_write_timer() /
tcp_delack_timer()) or tlshd activity coincide with
nvme_tcp_reclassify_socket():

1. Can softirq or tlshd acquire sk->sk_lock.slock or sk->sk_lock right after
   sock_allow_reclassification(sk) succeeds, racing with spin_lock_init(),
   init_waitqueue_head(), sk->sk_lock.owned =3D 0,
   debug_check_no_locks_freed(), lockdep_set_class_and_name(), and
   lockdep_init_map() to corrupt the spinlock, waitqueue, and lockdep state?

2. If softirq or tlshd already holds sk->sk_lock.slock or sk->sk_lock.owned
   when sock_allow_reclassification(sk) is checked, won't this trigger
   WARN_ON_ONCE(!sock_allow_reclassification(sk)) and abort reclassificatio=
n,
   leaving the socket in the default lockdep class?

>  	ret =3D nvme_tcp_init_connection(queue);
>  	if (ret)
>  		goto err_init_connect;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019135441.1420=
968-249-sashal@kernel.org?part=3D1

