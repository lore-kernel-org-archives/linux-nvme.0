Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85638606A319
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Oct 2026 07:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=0RvMFrrA;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KbvF1HPz
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:To:Subject:From
	:Message-ID:Cc:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eHUhdpszMSc4IldH/x8u+PfVK7KcnI+Ddg4fkN+VqFY=; b=0RvMFrrAAiobGWQLxSIjsE8lfV
	qyIpJrCbmy66d5NgxnmGGf+w/ygM6c3uFNJ2rbI8WMMvHtDQkwTDLubd4TR9HP3b2tT2DmXKkbpZP
	fVBQZlOvQUp0+1CUPr7cbh/lBwtf8rO+h/ZsTs2Y6uO3YJbSvv+MC1v6taRuowWHtKru7FQXV+pgx
	o/hzC31anuorbSvE3jHzzpl/iRjusHRUUGsgor5Q/aYSJQmn5FuBOhJur2E6pX1DJgPP3MwB+D002
	e6L9ndi8qjqFIPaC7Yvgt39Q2llN9+HlPA27ssJbX58FiyM8vMgl3500Rb7/YHYG2+X8zeabCWuu5
	lvw4sw8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJnKX-0000000DZjf-1Foo;
	Thu, 22 Oct 2026 07:35:17 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJnKW-0000000DZjO-0CNM
	for linux-nvme@lists.infradead.org;
	Thu, 22 Oct 2026 07:35:16 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 7206643BEC;
	Thu, 22 Oct 2026 07:35:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FF7A1F000C1;
	Thu, 22 Oct 2026 07:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792654515;
	bh=eHUhdpszMSc4IldH/x8u+PfVK7KcnI+Ddg4fkN+VqFY=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=KbvF1HPzLDrCeBsTIbEXJomJ0ax9b3v/YTLfz0izIffxC7GjWC7jutOhdire5BjQ8
	 muVL6oBSY+HZQb95vXStLhw7+ZTjRp/PtIh/SWLZtEeR94NOSznUk94ublx9NJWqq3
	 VCFNwQO/x7QCRTu9mLAvviqM4GJvNCzCh0Ml9LwmOCjxhil6TAZQvFN9HEqT6jTX6M
	 lnjNN2cFYhczlXFb1DdhBI+GL7Lox5Y0fNuvpsxInBCN8EGDY0g/mks1P1wjKVJvQe
	 cb2GQqublVEoWlTka/xT+xBS+q9agBg3Y6lpxpSaBTykWMNMdPYpCLttwB8d6TG1fO
	 MJMnpNQbCG7kw==
Message-ID: <sashiko-outbox-181128@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] nvme-tcp: wait for in-flight TLS handshake callback
To: "Avi Weiss" <thnkslprpt@gmail.com>, linux-nvme@lists.infradead.org
In-Reply-To: <20261022071934.3818224-1-thnkslprpt@gmail.com>
References: <20261022071934.3818224-1-thnkslprpt@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 07:35:14 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] nvme-tcp: stale tls_enabled and tls_pskid in nvme_tcp_start_tls()
--

commit d9acb1a02c55a0e337ba9cf1eb5bf3a75d22cb58
Author: Avi Weiss <thnkslprpt@gmail.com>

nvme-tcp: wait for in-flight TLS handshake callback

When nvme_tcp_start_tls() times out or is interrupted and
tls_handshake_cancel() loses the race against handshake completion, this
commit waits for queue->tls_complete before returning the timeout or signal
error so the queue is not freed while nvme_tcp_tls_done() is still running.

> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 7eec983c0eade..26a626abef7b2 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -1816,7 +1816,8 @@ static int nvme_tcp_start_tls(struct nvme_ctrl *nct=
rl,
>  		dev_err(nctrl->device,
>  			"queue %d: TLS handshake failed, error %d\n",
>  			qid, ret);
> -		tls_handshake_cancel(queue->sock->sk);
> +		if (!tls_handshake_cancel(queue->sock->sk))
> +			wait_for_completion(&queue->tls_complete);
>  	} else {
>  		if (queue->tls_err) {
>  			dev_err(nctrl->device,

[Severity: Medium]
What happens to queue->tls_enabled and ctrl->ctrl.tls_pskid if
wait_for_completion_interruptible_timeout() in nvme_tcp_start_tls() returns=
 0
or -ERESTARTSYS concurrently with handshake_complete() invoking
nvme_tcp_tls_done() with status =3D=3D 0?

When tls_handshake_cancel() returns false and nvme_tcp_start_tls() waits for
queue->tls_complete, a successful nvme_tcp_tls_done() callback modifies the
queue and controller state before signaling completion:

drivers/nvme/host/tcp.c:nvme_tcp_tls_done() {
	...
	tls_key =3D nvme_tls_key_lookup(pskid);
	if (IS_ERR(tls_key)) {
		...
	} else {
		queue->tls_enabled =3D true;
		if (qid =3D=3D 0)
			ctrl->ctrl.tls_pskid =3D key_serial(tls_key);
		key_put(tls_key);
		queue->tls_err =3D 0;
	}

out_complete:
	complete(&queue->tls_complete);
}

Because nvme_tcp_start_tls() still returns the negative timeout or signal
error after wait_for_completion(&queue->tls_complete), nvme_tcp_alloc_queue=
()
jumps to err_init_connect before setting NVME_TCP_Q_ALLOCATED on
queue->flags:

drivers/nvme/host/tcp.c:nvme_tcp_alloc_queue() {
	...
	if (nvme_tcp_tls_configured(nctrl) && pskid) {
		ret =3D nvme_tcp_start_tls(nctrl, queue, pskid);
		if (ret)
			goto err_init_connect;
	}
	...
	set_bit(NVME_TCP_Q_ALLOCATED, &queue->flags);
}

Neither err_init_connect nor a subsequent nvme_tcp_alloc_queue() call resets
queue->tls_enabled to false, and nvme_tcp_stop_queue_nowait() returns early
when NVME_TCP_Q_ALLOCATED is not set:

drivers/nvme/host/tcp.c:nvme_tcp_stop_queue_nowait() {
	...
	if (!test_bit(NVME_TCP_Q_ALLOCATED, &queue->flags))
		return;
	...
	/* Stopping the queue will disable TLS */
	queue->tls_enabled =3D false;
}

If that queue is later connected without TLS (for example, qid =3D=3D 0 dur=
ing
the initial unencrypted DH-HMAC-CHAP step of a secure concatenation reset or
reconnect where pskid =3D=3D 0), nvme_tcp_init_connection() will see
nvme_tcp_queue_tls(queue) =3D=3D true on an unencrypted TCP socket, call
tls_get_record_type(), and fail with -ENOTCONN. In addition, when
nvme_tcp_alloc_admin_queue() fails during the initial
nvme_tcp_configure_admin_queue() call in nvme_tcp_setup_ctrl(), both
functions return early without calling nvme_tcp_teardown_admin_queue(),
leaving ctrl->tls_pskid populated on a disconnected controller.

When tls_handshake_cancel() returns false and wait_for_completion() finishe=
s,
should nvme_tcp_start_tls() either clean up queue->tls_enabled and
ctrl->ctrl.tls_pskid before returning the error, or use queue->tls_err if n=
ot
interrupted?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022071934.3818=
224-1-thnkslprpt@gmail.com?part=3D1

