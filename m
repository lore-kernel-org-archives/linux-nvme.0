Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837A1606A32E
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Oct 2026 18:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ylIWqJL2;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gqtbtrZ2
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=sAOjpV7dj6etFg7djpRsLmi89agtJWhB40CYXgZzZ18=; b=ylIWqJL2FvhxG4kHNY8RrP5VUu
	8nYXwRx+ItmfAxoovewYW6P8fmVNiW1goQQqugBFkJNo8mKm2C3TvAnlJfjEInVw97KvbQVaYLTTV
	x43FwTFPIc4DHBjQ02+wojvbzrgRuGXc8ztKQuwoJJwcn+vyQeJDMAiRBktCY6U8UUci5bojCDHtO
	EtT3ks9DZLu4FCuDKwOgGbXfVYx4EXBV0X/c9WRNQwivYAF5gZjZnND69LGK7oVYQ2OoI6qOGKgdt
	ppw4n7MJL0TKfI2S77Lo3UQBd9bhLEV8M1+p8zCx7o47P+QMhrU1UTpJhlySp8aDADTaxKqLVIwcF
	04AHTueQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLPRr-000000034UQ-2PDf;
	Mon, 26 Oct 2026 18:29:31 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLPRq-000000034Ss-1Gzj
	for linux-nvme@lists.infradead.org;
	Mon, 26 Oct 2026 18:29:30 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 6B4C960A96;
	Mon, 26 Oct 2026 18:29:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 054891F031E0;
	Mon, 26 Oct 2026 18:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793039369;
	bh=sAOjpV7dj6etFg7djpRsLmi89agtJWhB40CYXgZzZ18=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gqtbtrZ2Io15K0a7cAThDrPqOCcAI5zfih3XrCOH/vTnykofkIDR4ibnkto4jYdXw
	 vyS+epbqWi8C0l2HjBLnRuvyb1fRQcbZDXIbH688Llwk7ttVzxnI4rIzABtMFQG2vw
	 h5WF1F7yxgbCINcXPCyc7DZaL4mu7eJJZAj2ajqEidzbzvFn+Q3EPIvDhMntvLYILB
	 +zFxydGXcjI4ZuFGyJw4fx72Fj1CZcPeL0xY2vxxjzjItAjWOIXdSh/byQ6xCAwnG2
	 BLicQojz5WBwRYRe05mBGS4BoLuwr6eeeNAJIQHR0341iZOQtP3T2TwXueAkAVJyCZ
	 kdjwbVmIKwIOw==
Message-ID: <sashiko-outbox-185619@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] nvme-tcp: start error recovery when read_sock fails
To: "Martin Belanger" <martin.nvme.dev@gmail.com>
Cc: linux-nvme@lists.infradead.org
In-Reply-To: <20261026-nvme-tcp-ctrlrec-fixes-v1-1-ebf6ff7eff34@gmail.com>
References: <20261026-nvme-tcp-ctrlrec-fixes-v1-0-ebf6ff7eff34@gmail.com>
 <20261026-nvme-tcp-ctrlrec-fixes-v1-1-ebf6ff7eff34@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 18:29:28 +0000
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
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] nvme-tcp: race on queue->rd_enabled after release_sock() in nvme=
_tcp_try_recv()
--

commit 3915b73f53c8a994bf45e1efec593bc2bb4f9f8b
Author: Martin Belanger <martin.belanger@dell.com>

nvme-tcp: start error recovery when read_sock fails

This commit updates nvme_tcp_try_recv() to log an error, disable the queue,
and trigger controller error recovery when sock->ops->read_sock() returns a
negative error code other than -EAGAIN and queue->rd_enabled is still set.

> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 7190eb10c2481..a03476f0f69d5 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -1431,7 +1431,21 @@ static int nvme_tcp_try_recv(struct nvme_tcp_queue=
 *queue)
>  	queue->nr_cqe =3D 0;
>  	consumed =3D sock->ops->read_sock(sk, &rd_desc, nvme_tcp_recv_skb);
>  	release_sock(sk);
> -	return consumed =3D=3D -EAGAIN ? 0 : consumed;
> +	if (consumed =3D=3D -EAGAIN)
> +		return 0;
> +
> +	/* nvme_tcp_recv_skb() does both of these itself, so a queue that is
> +	 * still enabled failed inside read_sock() instead
> +	 */
> +	if (unlikely(consumed < 0 && queue->rd_enabled)) {
> +		dev_err(queue->ctrl->ctrl.device,
> +			"queue %d: receive failed: %d\n",
> +			nvme_tcp_queue_id(queue), consumed);
> +		queue->rd_enabled =3D false;
> +		nvme_tcp_error_recovery(&queue->ctrl->ctrl);
> +	}

[Severity: Medium]
Should the check and clearing of queue->rd_enabled happen before calling
release_sock(sk) in drivers/nvme/host/tcp.c:nvme_tcp_try_recv()?

In nvme_tcp_recv_skb(), queue->rd_enabled is checked, cleared, and followed
by nvme_tcp_error_recovery() while lock_sock(sk) is held:

drivers/nvme/host/tcp.c:nvme_tcp_recv_skb() {
	if (unlikely(!queue->rd_enabled))
		return -EFAULT;
...
		if (result) {
			dev_err(queue->ctrl->ctrl.device,
				"receive failed:  %d\n", result);
			queue->rd_enabled =3D false;
			nvme_tcp_error_recovery(&queue->ctrl->ctrl);
			return result;
		}
}

When sock->ops->read_sock() fails directly without hitting the error path in
nvme_tcp_recv_skb() (for example, tls_sw_read_sock() returning -EINVAL on a
non-data TLS record, -EBADMSG, -EKEYEXPIRED, -ENOMEM, or sock_error()),
calling release_sock(sk) first drains sk->sk_backlog via __release_sock(sk)
while queue->rd_enabled is still true.

Any TCP segments that arrived in softirq while the socket was owned will
trigger sk->sk_data_ready:

release_sock()
  -> __release_sock()
    -> nvme_tcp_data_ready()

drivers/nvme/host/tcp.c:nvme_tcp_data_ready() {
	read_lock_bh(&sk->sk_callback_lock);
	queue =3D sk->sk_user_data;
	if (likely(queue && queue->rd_enabled) &&
	    !test_bit(NVME_TCP_Q_POLLING, &queue->flags))
		queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
	read_unlock_bh(&sk->sk_callback_lock);
}

Because queue->rd_enabled has not been cleared yet during release_sock(sk)
and the subsequent dev_err() call, nvme_tcp_data_ready() sees
queue->rd_enabled as true and re-queues queue->io_work on the failed queue.

In addition, nvme_tcp_try_recv() can be called concurrently from
nvme_tcp_poll() and nvme_tcp_io_work(), relying on lock_sock(sk) for
serialization:

drivers/nvme/host/tcp.c:nvme_tcp_poll() {
	set_bit(NVME_TCP_Q_POLLING, &queue->flags);
	if (sk_can_busy_loop(sk) && skb_queue_empty_lockless(&sk->sk_receive_queue=
))
		sk_busy_loop(sk, true);
	ret =3D nvme_tcp_try_recv(queue);
	clear_bit(NVME_TCP_Q_POLLING, &queue->flags);
}

Could releasing lock_sock(sk) before checking and clearing queue->rd_enabled
allow a concurrent nvme_tcp_try_recv() caller to acquire lock_sock(sk) while
queue->rd_enabled is still true, either logging duplicate errors or entering
nvme_tcp_recv_skb() after a transient read_sock() error?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026-nvme-tcp-c=
trlrec-fixes-v1-0-ebf6ff7eff34@gmail.com?part=3D1

