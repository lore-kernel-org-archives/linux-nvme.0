Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A4B606A31A
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Oct 2026 00:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=OfjtG/HJ;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oNV8VUI8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=N0c9VI+Am6An5QUNg2kTvDGpOC+sq/cpQo4/HEPMPyw=; b=OfjtG/HJa2cnFytZOKuxDL9L7I
	8mjWfRzXsdgCADPztngK+EwNpT30qeXDdZIOwHIfhi0qmPiFOXHnK5b2bvqOiIbuic/v81AK8pLSH
	rwxznab+xCrRj+fwRKbH2VbTfcqpejEqaw0oXc2acMzzJ3WeqR4AZrFNd3aA4PbA3cVc16YimNq8y
	Vx4MCkag5PUrX1vgvbnDD0muKFdRd/baLIOIvhZGYXmebVx/lxbKdqDobL9Xjt/nbxIPlBonCRvoZ
	6oQ5C2lG94bqt1DETqQn3PdA19V9+m9e1or3l0AY2y3qgjawaryJfAkU19cCM4zq/XKWFA0kPLUFv
	CeTW/3ZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLVBf-00000003XZk-0fW1;
	Tue, 27 Oct 2026 00:37:11 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLVBd-00000003XZX-3U7Y
	for linux-nvme@lists.infradead.org;
	Tue, 27 Oct 2026 00:37:09 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 5665043AB8;
	Tue, 27 Oct 2026 00:37:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EB621F01825;
	Tue, 27 Oct 2026 00:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793061429;
	bh=N0c9VI+Am6An5QUNg2kTvDGpOC+sq/cpQo4/HEPMPyw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oNV8VUI8ZW0TAplXHt6ssr1bSThwui8ARYG08PwIP7Q3AKW+ETbZeB8xVVVsq5upN
	 JxDwh9V+OAYnuMXMgD0va18Ajm9hbpKra3HBoJh+s87vO7gso7pbGrOehHz5PXm/03
	 8/JQhRlBMJbyA+yC+THWnJMZnQCeypwWqSiqcM+idHRTnhxu40cLjCEt6V/Jy++/QP
	 MkIlATUYKm3Z0xA6l4wzArbtuhkKjD3MW3neG8mkyjBYRxQ9R8UloMXMwr60qHT9ay
	 wI2yxmmT4rUbz8iD1oQI/zjEAa/R+LtynP0kh88ujpqZK/XKK8HyZACVDoyqZxwkBE
	 k3xNW/lOaknWQ==
Message-ID: <sashiko-outbox-185959@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC net-next 4/5] tls: send a KeyUpdate at the record
 limit and on request
To: "Martin Belanger" <martin.nvme.dev@gmail.com>
Cc: linux-nvme@lists.infradead.org
In-Reply-To: <20261025-keyupdate-rfc-v1-4-60b7756eccbd@gmail.com>
References: <20261025-keyupdate-rfc-v1-0-60b7756eccbd@gmail.com>
 <20261025-keyupdate-rfc-v1-4-60b7756eccbd@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 00:37:08 +0000
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Medium] tls: missing MSG_NOSIGNAL in tls_tx_key_update() causes unexpect=
ed SIGPIPE
- [Medium] tls: stale KeyUpdate state after manual rekey in do_tls_setsocko=
pt_conf()
- [Medium] tls: swallowed TCP send errors and cleared sk_err in tls_tx_key_=
update()
- [Medium] tls: lock_sock() dropped in tls_tx_key_update() races with setso=
ckopt and rx
--

commit 56c21ecdb1fcce3eea994287aff8609b92227c81
Author: Martin Belanger <martin.belanger@dell.com>

tls: send a KeyUpdate at the record limit and on request

This commit sends a TLS 1.3 KeyUpdate before the next record when the TX key
reaches 2^24 records or when the peer has requested a KeyUpdate. It also ad=
ds
the TLS_TX_KEY_UPDATE socket option to trigger an immediate KeyUpdate and
optionally request one from the peer.

> diff --git a/net/tls/tls_keyupdate.c b/net/tls/tls_keyupdate.c
> index 543bf57599c7b..851d5b54b336d 100644
> --- a/net/tls/tls_keyupdate.c
> +++ b/net/tls/tls_keyupdate.c
> @@ -146,5 +146,10 @@ int tls_keyupdate_rx(struct sock *sk, struct sk_buff=
 *skb)
>  	}
>  	TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSRXREKEYOK);
> =20
> +	/* Any KeyUpdate from the peer answers our update_requested */
> +	ctx->tx_key_update_asked =3D false;
> +	if (msg[4] =3D=3D TLS_KEY_UPDATE_REQUESTED)
> +		ctx->tx_key_update_reply =3D true;
> +
>  	return 0;
>  }

[Severity: Medium]
What happens to ctx->tx_key_update_asked and ctx->tx_key_update_reply if
userspace later performs a manual rekey via setsockopt(TLS_TX) or
setsockopt(TLS_RX)?

In net/tls/tls_main.c, do_tls_setsockopt_conf() clears the registered
secrets when updating an existing key:

	if (update) {
		/* The registered secret no longer matches the key. The RX
		 * secret also needs the TX one, see do_tls_setsockopt_secret().
		 */
		if (tx)
			memzero_explicit(&ctx->tx_secret,
					 sizeof(ctx->tx_secret));
		memzero_explicit(&ctx->rx_secret, sizeof(ctx->rx_secret));
		return 0;
	}

If userspace calls setsockopt(TLS_TX_KEY_UPDATE) with request =3D 1 (setting
ctx->tx_key_update_asked =3D true) and then manually rekeys via TLS_TX or
TLS_RX, ctx->rx_secret is zeroed so the peer's KeyUpdate is handled in
userspace rather than tls_keyupdate_rx(). If userspace subsequently registe=
rs
new traffic secrets, ctx->tx_key_update_asked remains true and future
TLS_TX_KEY_UPDATE requests with value =3D 1 will permanently fail with -EBU=
SY
in tls_sw_key_update(). Similarly, a stale ctx->tx_key_update_reply =3D true
across a manual TX rekey and secret registration would cause the next
tls_sw_sendmsg() to emit an unintended extra KeyUpdate.

Should do_tls_setsockopt_conf() also clear ctx->tx_key_update_asked (and
ctx->tx_key_update_reply when tx is true)?

> diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
> index a314fa638dc36..4acedddfb01e8 100644
> --- a/net/tls/tls_sw.c
> +++ b/net/tls/tls_sw.c

[ ... ]

> @@ -1005,6 +1006,150 @@ static int tls_sw_sendmsg_locked(struct sock *sk,=
 struct msghdr *msg,
>  	return copied > 0 ? copied : ret;
>  }
> =20
> +/* RFC 9846 section 5.5 allows 2^24.5 full-size records per AES-GCM key.
> + * Send the KeyUpdate a little earlier.
> + */
> +#define TLS_KEYUPDATE_TX_RECORDS	BIT_ULL(24)
> +
> +/* Section 4.7.3: the epoch must not exceed 2^48-1. The application
> + * traffic secrets start at epoch 3.
> + */
> +#define TLS_KEYUPDATE_MAX		(BIT_ULL(48) - 4)
> +
> +/* Send a KeyUpdate with the current key, then install the next key.
> + * Called with tx_lock held and the socket locked.
> + */
> +static int tls_tx_key_update(struct sock *sk, u8 request, int flags)
> +{
> +	u8 body[TLS_KEYUPDATE_MSG_SIZE] =3D {
> +		TLS_HANDSHAKE_KEYUPDATE, 0, 0, 1, request
> +	};
> +	struct tls_context *tls_ctx =3D tls_get_ctx(sk);
> +	struct tls_sw_context_tx *ctx =3D tls_sw_ctx_tx(tls_ctx);
> +	u8 record_type =3D TLS_RECORD_TYPE_HANDSHAKE;
> +	u8 buf[CMSG_SPACE(sizeof(record_type))];
> +	struct msghdr msg =3D {};
> +	struct cmsghdr *cmsg;
> +	struct kvec iov;
> +	int ret;
> +
> +	memset(buf, 0, sizeof(buf));
> +	msg.msg_control =3D buf;
> +	msg.msg_controllen =3D sizeof(buf);
> +	msg.msg_flags =3D flags & MSG_DONTWAIT;

[Severity: Medium]
Could masking msg.msg_flags with only MSG_DONTWAIT here cause unexpected
SIGPIPE delivery?

When tls_sw_sendmsg() is called with MSG_NOSIGNAL and a KeyUpdate is due,
tls_tx_key_update_if_due() passes msg->msg_flags into tls_tx_key_update(),
which strips MSG_NOSIGNAL before calling tls_sw_sendmsg_locked(). Likewise,
tls_sw_key_update() called from do_tls_setsockopt_key_update() passes
flags =3D 0.

If the connection has failed with -EPIPE (for example when SEND_SHUTDOWN is
set), tls_sw_sendmsg_locked() passes msg.msg_flags to tcp_sendmsg_locked()
and sk_stream_error():

net/core/stream.c:sk_stream_error() {
	if (err =3D=3D -EPIPE)
		err =3D sock_error(sk) ? : -EPIPE;
	if (err =3D=3D -EPIPE && !(flags & MSG_NOSIGNAL))
		send_sig(SIGPIPE, current, 0);
	return err;
}

This sends SIGPIPE to the calling task during setsockopt(TLS_TX_KEY_UPDATE)
or during a sendmsg() call that explicitly requested MSG_NOSIGNAL. Should
tls_tx_key_update() preserve MSG_NOSIGNAL from flags in the sendmsg() path
and set MSG_NOSIGNAL in the setsockopt() path?

> +
> +	cmsg =3D CMSG_FIRSTHDR(&msg);
> +	cmsg->cmsg_level =3D SOL_TLS;
> +	cmsg->cmsg_type =3D TLS_SET_RECORD_TYPE;
> +	cmsg->cmsg_len =3D CMSG_LEN(sizeof(record_type));
> +	memcpy(CMSG_DATA(cmsg), &record_type, sizeof(record_type));
> +
> +	iov.iov_base =3D body;
> +	iov.iov_len =3D sizeof(body);
> +	iov_iter_kvec(&msg.msg_iter, ITER_SOURCE, &iov, 1, sizeof(body));
> +
> +	/* A control record closes the open record first, so all data
> +	 * written so far goes out with the current key, ahead of the
> +	 * KeyUpdate.
> +	 */
> +	ret =3D tls_sw_sendmsg_locked(sk, &msg, sizeof(body));
> +	if (ret < 0)
> +		return ret;

[Severity: Medium]
Can tls_sw_sendmsg_locked() return sizeof(body) even when transmitting the
KeyUpdate record fails at the TCP layer?

Inside tls_sw_sendmsg_locked(), once the 5-byte KeyUpdate payload is copied
into msg_pl, copied is incremented to 5 before bpf_exec_tx_verdict() ->
tls_push_record() is called. If synchronous encryption in tls_do_encryption=
()
succeeds and moves the record to ctx->tx_list, but tls_tx_records() ->
tls_push_sg() -> tcp_sendmsg_locked() fails (for example with -EPIPE because
SEND_SHUTDOWN is set while sk->sk_err was initially 0), tls_tx_records()
calls tls_err_abort(sk, -EPIPE) and returns -EPIPE.

Because bpf_exec_tx_verdict() only rolls back copied when
sk->sk_err =3D=3D EBADMSG, copied remains 5. At the end of
tls_sw_sendmsg_locked():

end:
	ret =3D sk_stream_error(sk, msg->msg_flags, ret);
	return copied > 0 ? copied : ret;

sk_stream_error() consumes and clears sk->sk_err back to 0 via
sock_error(sk), and tls_sw_sendmsg_locked() returns 5 instead of -EPIPE.
tls_tx_key_update() then sees ret =3D=3D 5, rotates the TX key via
tls_keyupdate_rekey(sk, 1), increments LINUX_MIB_TLSTXREKEYOK and
tx_key_updates, and returns 0 on a broken socket with sk->sk_err cleared.

> +
> +	/* Nothing may be encrypted with the next key before the KeyUpdate
> +	 * is encrypted with the current one.
> +	 */
> +	ret =3D tls_encrypt_async_wait(ctx);
> +	if (!ret)
> +		ret =3D tls_keyupdate_rekey(sk, 1);
> +	if (ret) {
> +		/* The peer expects the next key: the connection is lost */
> +		TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSTXREKEYERROR);
> +		tls_err_abort(sk, ret);
> +		return ret;
> +	}

[Severity: Medium]
Is KeyUpdate state protected if tls_sw_sendmsg_locked() drops the socket lo=
ck
while waiting for send buffer memory?

Both tls_tx_key_update_if_due() and tls_sw_key_update() check
ctx->tx_secret.len, ctx->rx_secret.len, ctx->tx_key_update_asked, and
ctx->tx_key_update_reply under lock_sock(sk) and ctx->tx_lock, then call
tls_tx_key_update(). Inside tls_tx_key_update(), tls_sw_sendmsg_locked() (or
tcp_sendmsg_locked() via tls_tx_records() -> tls_push_sg()) can call
sk_stream_wait_memory() when the send buffer is full, which temporarily dro=
ps
lock_sock(sk) while keeping only ctx->tx_lock held.

However, the setsockopt handlers for TLS_TX / TLS_RX
(do_tls_setsockopt_conf()) and TLS_TX_TRAFFIC_SECRET / TLS_RX_TRAFFIC_SECRET
(do_tls_setsockopt_secret()), as well as the RX path (tls_sw_recvmsg() ->
tls_keyupdate_rx()), only acquire lock_sock(sk) and do not take ctx->tx_loc=
k.
While tls_tx_key_update() is sleeping in sk_stream_wait_memory():

1. A concurrent setsockopt(TLS_TX) in do_tls_setsockopt_conf() can replace
   the TX key and zero ctx->tx_secret and ctx->rx_secret. When
   tls_tx_key_update() wakes up, it finishes sending the KeyUpdate under the
   already-replaced key and then calls tls_keyupdate_rekey(sk, 1), which se=
es
   !ctx->tx_secret.len, returns -EINVAL, and aborts the connection via
   tls_err_abort(sk, -EINVAL).
2. A concurrent setsockopt(TLS_RX) can zero ctx->rx_secret after
   tls_sw_key_update(sk, 1) has already verified ctx->rx_secret.len, leaving
   ctx->tx_key_update_asked =3D true with no registered RX secret to ever c=
lear
   it.
3. A concurrent recvmsg() in tls_keyupdate_rx() can set
   ctx->tx_key_update_reply =3D true while tls_sw_key_update(sk, 1) is slee=
ping
   before sending KeyUpdate(update_requested), so tls_tx_key_update() does
   not clear tx_key_update_reply.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261025-keyupdate-=
rfc-v1-0-60b7756eccbd@gmail.com?part=3D4

