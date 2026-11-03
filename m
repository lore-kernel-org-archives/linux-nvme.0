Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6B0606A324
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Nov 2026 16:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=PNuAiPUt;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OUngCLuR
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=uU8RIntUZy7rC2MU0khuybK2ArhQyP8UUhj3j/r/m+s=; b=PNuAiPUtMpBP2VbE61FuUgIHyv
	I6isnbNe1bj2RbPy1J3lixySTsQwNLWWEfEYjEbjZmX9oR58/XHte5w1LqIzecnw/HgYS65BlJpmX
	F0jypEA/ij3/N4QpJP1zj8DfgRnsC+rnzZNCldyhqzTV12VBZ6pSP7qHAUr8edrJE49fqYd73RAY9
	fExBTmnryyXQS472nejsjFJMr67GJX96flpH/EA4wybZr9ffJJaZw88wuzeK9HjUx65GmBGLzqE2Q
	xqqF39DBHe736sWXXmdRtBcaMAJZZCWFsZqkJmcJWtZyq4ELCa8n3+38lqpZziyt0gWy4xfLtFayw
	Jyp/rCFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOHpz-00000003EvY-26Nq;
	Tue, 03 Nov 2026 16:58:19 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOHpv-00000003Euf-29cz
	for linux-nvme@lists.infradead.org;
	Tue, 03 Nov 2026 16:58:15 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 21A0642E5E;
	Tue,  3 Nov 2026 16:58:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB8E21F00919;
	Tue,  3 Nov 2026 16:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793725095;
	bh=uU8RIntUZy7rC2MU0khuybK2ArhQyP8UUhj3j/r/m+s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OUngCLuRIWw1FRSWIbNQvq3LeGjhDULcm4NkWxxMcZc24rn08JlMBTQUozINZuPH4
	 Jcyu8GygsPRILC6Dp3lW09MgdLZA3x+SeGNjkwP3dFmIcnFxWVmIBJkDGxKckZblTL
	 omAzNUpvLghwKiz5uMzmyG+pWjVSk1Rl73c92l4iMu6jDbyJhUJwqjApDyS8iYZ9Lt
	 vaUwfWHtWA5AFGRWuAFyJjgdhXBWezE0wCUMdgFwO9wmTyUkBEf4A7lHZCJ0VRSs9p
	 nIG6Rq+gg4HHitkS/GPOf+Xn5vCECFMUpS9dS3sdbe8iY9eXYsMsSEevmvmZinbApb
	 m9ryFwoG8+/3A==
Message-ID: <sashiko-outbox-195763@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v4 4/5] tls: send a KeyUpdate at the record
 limit and on request
To: "Martin Belanger" <martin.nvme.dev@gmail.com>
Cc: linux-nvme@lists.infradead.org
In-Reply-To: <20261102-keyupdate-rfc-v4-4-f17419972b9f@gmail.com>
References: <20261102-keyupdate-rfc-v4-0-f17419972b9f@gmail.com>
 <20261102-keyupdate-rfc-v4-4-f17419972b9f@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 16:58:14 +0000
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] tls: KeyUpdate bypassed in tls_sw_sendmsg_locked() after empty ope=
n_rec allocation
- [High] tls: KeyUpdate state races when sk_stream_wait_memory() drops lock=
_sock()
- [Medium] tls: tls_tx_key_update() ignores fatal send errors and loses EPI=
PE
--

commit 60932b2dae024fb3dd906a58ae73a60d9d48188e
Author: Martin Belanger <martin.belanger@dell.com>

tls: send a KeyUpdate at the record limit and on request

This commit sends a TLS 1.3 KeyUpdate before the next Application Data
record when a socket with a registered TX secret reaches 2^24 records or
when the peer requests a KeyUpdate. It also adds the TLS_TX_KEY_UPDATE
socket option to trigger a KeyUpdate immediately and optionally request
one from the peer.

> diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
> index 027c32edaf850..4b2e10000facf 100644
> --- a/net/tls/tls_sw.c
> +++ b/net/tls/tls_sw.c

[ ... ]

> @@ -805,6 +808,16 @@ static int tls_sw_sendmsg_locked(struct sock *sk, st=
ruct msghdr *msg,
>  			goto send_end;
>  		}
> =20
> +		/* Check before each new record: one call can write many
> +		 * records, and a KeyUpdate reply must go before the next
> +		 * one. The KeyUpdate itself is a handshake record.
> +		 */
> +		if (!ctx->open_rec && record_type =3D=3D TLS_RECORD_TYPE_DATA) {
> +			ret =3D tls_tx_maybe_update_key(sk, msg->msg_flags);
> +			if (ret)
> +				goto send_end;
> +		}
> +
>  		if (ctx->open_rec)
>  			rec =3D ctx->open_rec;
>  		else

[Severity: High]
Can a pending KeyUpdate or the record limit check be bypassed here if an
earlier send attempt left an empty ctx->open_rec allocated?

In net/tls/tls_sw.c, tls_sw_sendmsg_locked() checks
tls_tx_maybe_update_key() only when !ctx->open_rec, and then immediately
allocates ctx->open_rec via tls_get_rec(sk) before checking
sk_stream_memory_free(sk) or calling tls_alloc_encrypted_msg():

net/tls/tls_sw.c:tls_sw_sendmsg_locked() {
    ...
		if (ctx->open_rec)
			rec =3D ctx->open_rec;
		else
			rec =3D ctx->open_rec =3D tls_get_rec(sk);
    ...
		if (!sk_stream_memory_free(sk))
			goto wait_for_sndbuf;
    ...
wait_for_sndbuf:
		sk_set_nospace(sk);
wait_for_memory:
		ret =3D sk_stream_wait_memory(sk, &timeo);
		if (ret) {
trim_sgl:
			if (ctx->open_rec)
				tls_trim_both_msgs(sk, orig_size);
			goto send_end;
		}
}

When the socket send buffer is full and sk_stream_wait_memory() returns an
error with orig_size =3D=3D 0 (such as -EAGAIN on a non-blocking socket or
expired SO_SNDTIMEO, or -ERESTARTSYS/-EINTR on a signal),
tls_trim_both_msgs(sk, 0) trims msg_plaintext and msg_encrypted to 0 bytes
but leaves ctx->open_rec non-NULL and empty.

This happens directly when a KeyUpdate is due (either at
TLS_KEYUPDATE_TX_RECORDS or when ctx->tx_key_update_reply is true) and
tls_tx_maybe_update_key() calls tls_tx_key_update() ->
tls_sw_sendmsg_locked() while !sk_stream_memory_free(sk), or when
setsockopt(TLS_TX_KEY_UPDATE) is interrupted by a signal in
sk_stream_wait_memory(), or when a non-blocking sendmsg() returns -EAGAIN
at wait_for_sndbuf before a peer KeyUpdate sets ctx->tx_key_update_reply.

When the caller retries sendmsg() once write space is available,
ctx->open_rec is already non-NULL, so the !ctx->open_rec check is false.
Wouldn't this skip tls_tx_maybe_update_key() (and the -EKEYEXPIRED check at
TLS_KEYUPDATE_MAX) and encrypt the Application Data record under the old
key, as well as cause do_tls_setsockopt_tx_payload_len() to fail with
-EBUSY after an interrupted TLS_TX_KEY_UPDATE?

> @@ -1005,6 +1018,153 @@ static int tls_sw_sendmsg_locked(struct sock *sk,=
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
> +	union {
> +		struct cmsghdr cmsg;
> +		u8 buf[CMSG_SPACE(sizeof(record_type))];
> +	} ctrl =3D {};
> +	struct msghdr msg =3D {};
> +	struct cmsghdr *cmsg;
> +	struct kvec iov;
> +	int ret;
> +
> +	msg.msg_control =3D &ctrl;
> +	msg.msg_controllen =3D sizeof(ctrl);
> +	msg.msg_flags =3D flags & (MSG_DONTWAIT | MSG_NOSIGNAL);
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
As reported by Sashiko on RFC v3 [1], what happens in tls_tx_key_update()
in net/tls/tls_sw.c when transmitting the 5-byte KeyUpdate record fails in
tls_tx_records() with an error such as -EPIPE (after shutdown(SHUT_WR)) or
-ECONNRESET?

In tls_sw_sendmsg_locked(), the 5-byte kvec payload is copied into msg_pl
and copied is incremented to 5 before bpf_exec_tx_verdict() ->
tls_push_record() -> tls_tx_records() -> tls_push_sg() ->
tcp_sendmsg_locked() attempts to transmit the encrypted record:

net/tls/tls_sw.c:bpf_exec_tx_verdict() {
	err =3D tls_push_record(sk, flags, record_type);
	if (err && err !=3D -EINPROGRESS && sk->sk_err =3D=3D EBADMSG) {
		*copied -=3D sk_msg_free(sk, msg);
		tls_free_open_rec(sk);
		err =3D -sk->sk_err;
	}
	return err;
}

Because bpf_exec_tx_verdict() only rolls back *copied when sk->sk_err =3D=3D
EBADMSG, copied remains 5 when tls_tx_records() fails with -EPIPE or
-ECONNRESET. At the end of tls_sw_sendmsg_locked():

net/tls/tls_sw.c:tls_sw_sendmsg_locked() {
    ...
end:
	ret =3D sk_stream_error(sk, msg->msg_flags, ret);
	return copied > 0 ? copied : ret;
}

When ret is -EPIPE, sk_stream_error() calls sock_error(sk), which clears
sk->sk_err back to 0, and tls_sw_sendmsg_locked() then discards ret and
returns copied (5).

Because tls_tx_key_update() only checks ret < 0, doesn't it treat the
failed send as a success, rotate the TX key via tls_keyupdate_rekey(sk, 1),
update tx_key_updates and tx_key_update_reply / tx_key_update_asked, and
return 0 with the unsent KeyUpdate record still sitting on ctx->tx_list and
sk->sk_err cleared to 0?

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
> +
> +	TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSTXREKEYOK);
> +	tls_ctx->tx_key_updates++;
> +	if (request =3D=3D TLS_KEY_UPDATE_NOT_REQUESTED)
> +		tls_ctx->tx_key_update_reply =3D false;
> +
> +	return 0;
> +}
> +
> +/* Send a KeyUpdate if one is due: in reply to the peer's
> + * update_requested (RFC 9846 section 4.7.3), or before the key reaches
> + * its record limit (section 5.5). ChaCha20-Poly1305 has no record limit:
> + * the sequence number would wrap first.
> + */
> +static int tls_tx_maybe_update_key(struct sock *sk, int flags)
> +{
> +	struct tls_context *ctx =3D tls_get_ctx(sk);
> +	bool limit;
> +
> +	if (likely(!ctx->tx_secret.len))
> +		return 0;
> +
> +	limit =3D ctx->prot_info.cipher_type !=3D TLS_CIPHER_CHACHA20_POLY1305 =
&&
> +		get_unaligned_be64(ctx->tx.rec_seq) >=3D TLS_KEYUPDATE_TX_RECORDS;
> +	if (!limit && !ctx->tx_key_update_reply)
> +		return 0;
> +
> +	if (ctx->tx_key_updates >=3D TLS_KEYUPDATE_MAX) {
> +		/* Ignore update_requested. At the record limit the
> +		 * connection must end.
> +		 */
> +		ctx->tx_key_update_reply =3D false;
> +		return limit ? -EKEYEXPIRED : 0;
> +	}
> +
> +	return tls_tx_key_update(sk, TLS_KEY_UPDATE_NOT_REQUESTED, flags);
> +}
> +
> +/**
> + * tls_sw_key_update - send a KeyUpdate now, for TLS_TX_KEY_UPDATE
> + * @sk: socket
> + * @request: non-zero to also ask the peer to update its key
> + *
> + * Called with tx_lock held and the socket locked.
> + *
> + * Return: 0 on success, or a negative errno.
> + */
> +int tls_sw_key_update(struct sock *sk, int request)
> +{
> +	struct tls_context *ctx =3D tls_get_ctx(sk);
> +	int ret;
> +
> +	if (!ctx->tx_secret.len)
> +		return -EINVAL;
> +
> +	if (request) {
> +		/* Only the kernel sees the answer */
> +		if (!ctx->rx_secret.len)
> +			return -EINVAL;
> +		/* Section 4.7.3: wait for the answer to the previous one */
> +		if (ctx->tx_key_update_asked)
> +			return -EBUSY;
> +	}
> +
> +	if (ctx->tx_key_updates >=3D TLS_KEYUPDATE_MAX - 1)
> +		return -EKEYEXPIRED;
> +
> +	/* A reply must carry update_not_requested */
> +	if (request && ctx->tx_key_update_reply) {
> +		ret =3D tls_tx_key_update(sk, TLS_KEY_UPDATE_NOT_REQUESTED,
> +					MSG_NOSIGNAL);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret =3D tls_tx_key_update(sk, request ? TLS_KEY_UPDATE_REQUESTED :
> +				TLS_KEY_UPDATE_NOT_REQUESTED, MSG_NOSIGNAL);
> +	if (!ret && request)
> +		ctx->tx_key_update_asked =3D true;
> +
> +	return ret;
> +}

[Severity: High]
As reported by Sashiko on RFC v3 [2], can the KeyUpdate state in struct
tls_context race when sk_stream_wait_memory() temporarily drops
lock_sock(sk)?

In net/tls/tls_main.c, do_tls_setsockopt_conf() and
do_tls_setsockopt_secret() only acquire lock_sock(sk) without ctx->tx_lock,
and in net/tls/tls_keyupdate.c, tls_keyupdate_rx() updates
ctx->tx_key_update_asked and ctx->tx_key_update_reply under lock_sock(sk).
Meanwhile, when the socket send buffer is full, tls_sw_sendmsg_locked()
(at wait_for_sndbuf / wait_for_memory) and tcp_sendmsg_locked() (via
tls_push_sg()) call sk_stream_wait_memory(), which releases lock_sock(sk)
while sleeping.

Could this lead to several races while a sender holding ctx->tx_lock sleeps
in sk_stream_wait_memory()?

1. In tls_tx_key_update(), if a concurrent setsockopt(SOL_TLS, TLS_TX) runs
do_tls_setsockopt_conf() while tls_sw_sendmsg_locked() is sleeping,
do_tls_setsockopt_conf() installs a new TX key and zeroes ctx->tx_secret.
When tls_tx_key_update() wakes up and finishes sending the KeyUpdate
record, tls_keyupdate_rekey(sk, 1) sees !ctx->tx_secret.len, returns
-EINVAL, and calls tls_err_abort(sk, -EINVAL), aborting the connection.

2. In tls_sw_key_update(sk, 1), if a concurrent setsockopt(SOL_TLS, TLS_RX)
runs do_tls_setsockopt_conf() while tls_tx_key_update() is sleeping,
do_tls_setsockopt_conf() zeroes ctx->rx_secret and clears
ctx->tx_key_update_asked =3D false. When tls_tx_key_update() returns 0,
tls_sw_key_update() unconditionally sets ctx->tx_key_update_asked =3D true
even though rx_secret is no longer registered, leaving tx_key_update_asked
permanently stuck at true.

3. If a concurrent recvmsg() runs tls_keyupdate_rx() while
tls_sw_key_update(sk, 1) is sleeping in sk_stream_wait_memory() before
copying the KeyUpdate message, or while an Application Data sendmsg() is
sleeping at wait_for_sndbuf in tls_sw_sendmsg_locked() after allocating
ctx->open_rec, ctx->tx_key_update_reply is set to true after the caller has
already passed the tx_key_update_reply check. Upon wakeup,
tls_sw_key_update(sk, 1) sends KeyUpdate(update_requested) or
tls_sw_sendmsg_locked() sends Application Data without first sending the
required KeyUpdate(update_not_requested) reply.

[1] https://lore.kernel.org/r/20261030-keyupdate-rfc-v3-4-8e1e32226e51@gmai=
l.com
[2] https://lore.kernel.org/r/20261030-keyupdate-rfc-v3-4-8e1e32226e51@gmai=
l.com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-keyupdate-=
rfc-v4-0-f17419972b9f@gmail.com?part=3D4

