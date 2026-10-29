Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8716B60A2614
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Oct 2026 13:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=3yKDBjIp;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dfrZQk6d
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=XFsZIEmLfdIOUyk8ouxDamnlLiLiQgneVvzb4N5qWoI=; b=3yKDBjIp8z3ZzFxFN8LGmIkyy/
	4YdU9pGnM8kO1tDhhyidlQyeAQIVOALSHnpmgO7WRlPFJIq01D5SGTdzQiYYjoBJ3fvBKyvNUBnU9
	LBteGZqoEptPsfP4ZLejCRzGAnRmOLpjZx0ZRSJiMkBPYMc9r/qrdzxw9ykih3MUIao6E5HvFZyNn
	JWRbYd4okp7K++dD3QwUwxsZPI8br+taYDN8/TTVzoLqe05kxA2Ix7g/qJq5sHs3F/4rmeH+YkJpp
	YoTA+TpSllHjKKyaYcBrCFuzDG/cdr+69EHKA73Q+Ue8aaBW0z8xjEwrj75Tp/FKcx+glzvrKQsDh
	18nDpmzA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMQZ8-00000009Rsx-1pTt;
	Thu, 29 Oct 2026 13:53:14 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMQZ4-00000009RpQ-36qx
	for linux-nvme@lists.infradead.org;
	Thu, 29 Oct 2026 13:53:10 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 6C07460207;
	Thu, 29 Oct 2026 13:53:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 072EA1F01282;
	Thu, 29 Oct 2026 13:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793281989;
	bh=XFsZIEmLfdIOUyk8ouxDamnlLiLiQgneVvzb4N5qWoI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dfrZQk6dYPEKBET2yASB5ZPcstwrHjXiVt2Ql0+5oRZ6VuQPU98pSfgldn6dwdQhi
	 w4sitk70t2vBv3qXtkqs3amVkCw5pqtzKx1RJq0t1A/vItWHduifK6AJJUr3+EsfIo
	 zbbW9kOUvIjyJDfqAkMbTM+YFnCJWcrI0Up4+obwYOGn6G8OmzV4SXXxba6zEkSPDp
	 QbHFzfS5L1h6F6mhJWf8gp+IzA74MMH5JT62ALeG9BBom16AoIzK/ySS7DQX78oAfL
	 aTfCDSmy/jv8B2W+1rQk1+wMfjHrNelh+d1kX8mFY2kqcVirzIeLARlm9jcmgBBeYR
	 OPyzThZEhR9vg==
Message-ID: <sashiko-outbox-189436@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC net-next v2 4/5] tls: send a KeyUpdate at the record
 limit and on request
To: "Martin Belanger" <martin.nvme.dev@gmail.com>
Cc: linux-nvme@lists.infradead.org
In-Reply-To: <20261028-keyupdate-rfc-v2-4-eb5143b4c487@gmail.com>
References: <20261028-keyupdate-rfc-v2-0-eb5143b4c487@gmail.com>
 <20261028-keyupdate-rfc-v2-4-eb5143b4c487@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 13:53:08 +0000
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] tls: race on KeyUpdate state when tls_tx_key_update() drops socket=
 lock
- [High] tls: missing per-record key update check in tls_sw_sendmsg_locked()
- [Medium] tls: unaligned cmsghdr stack buffer in tls_tx_key_update()
- [Medium] tls: tls_tx_key_update() ignores send errors and clears sk_err w=
hen copied > 0
--

commit 02941403f2fa4fc7dc9df07d972533cd8d92b8ff
Author: Martin Belanger <martin.belanger@dell.com>

tls: send a KeyUpdate at the record limit and on request

This patch implements automatic TLS 1.3 TX KeyUpdate transmission before
reaching the 2^24 record limit for AES-GCM or when requested by the peer.
It also adds the TLS_TX_KEY_UPDATE socket option to allow user space to
trigger a KeyUpdate immediately and optionally request one from the peer.

> diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
> index cc0177320e7e6..4fe78624859d7 100644
> --- a/net/tls/tls_sw.c
> +++ b/net/tls/tls_sw.c

[ ... ]

> @@ -1005,6 +1006,151 @@ static int tls_sw_sendmsg_locked(struct sock *sk,=
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
> +	msg.msg_flags =3D flags & (MSG_DONTWAIT | MSG_NOSIGNAL);
> +
> +	cmsg =3D CMSG_FIRSTHDR(&msg);
> +	cmsg->cmsg_level =3D SOL_TLS;
> +	cmsg->cmsg_type =3D TLS_SET_RECORD_TYPE;
> +	cmsg->cmsg_len =3D CMSG_LEN(sizeof(record_type));
> +	memcpy(CMSG_DATA(cmsg), &record_type, sizeof(record_type));

[Severity: Medium]
Could accessing cmsg here and in tls_process_cmsg() trigger an unaligned
memory access?

In tls_tx_key_update(), buf is declared as a u8 array on the stack with
1-byte alignment, and CMSG_FIRSTHDR(&msg) casts msg.msg_control to struct
cmsghdr *, which requires alignment of __kernel_size_t (8 bytes on 64-bit
architectures, 4 bytes on 32-bit architectures).

Dereferencing cmsg->cmsg_level, cmsg->cmsg_type, and cmsg->cmsg_len through
that pointer in tls_tx_key_update() and tls_sw_sendmsg_locked() ->
tls_process_cmsg() can fault on strict-alignment architectures or trigger
UBSAN alignment warnings.

Should buf be aligned to __alignof__(struct cmsghdr)?

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
What happens if transmitting the KeyUpdate record fails inside
tls_sw_sendmsg_locked() after the 5-byte payload has already been copied?

In tls_sw_sendmsg_locked(), copied is incremented by 5 before
bpf_exec_tx_verdict() -> tls_push_record() -> tls_tx_records() calls
tcp_sendmsg_locked():

net/tls/tls_sw.c:bpf_exec_tx_verdict() {
	err =3D tls_push_record(sk, flags, record_type);
	if (err && err !=3D -EINPROGRESS && sk->sk_err =3D=3D EBADMSG) {
		*copied -=3D sk_msg_free(sk, msg);
		tls_free_open_rec(sk);
		err =3D -sk->sk_err;
	}
	return err;
}

net/tls/tls_sw.c:tls_sw_sendmsg_locked() {
end:
	ret =3D sk_stream_error(sk, msg->msg_flags, ret);
	return copied > 0 ? copied : ret;
}

When tcp_sendmsg_locked() fails (for example with -EPIPE after
shutdown(fd, SHUT_WR) or -ECONNRESET), bpf_exec_tx_verdict() does not roll
back copied. At the end of tls_sw_sendmsg_locked(), sk_stream_error() calls
sock_error(sk) on -EPIPE (clearing sk->sk_err to 0), and
tls_sw_sendmsg_locked() discards ret and returns 5 because copied > 0.

As a result, tls_tx_key_update() sees ret =3D=3D 5, waits for async encrypt=
ion,
rotates the TX key via tls_keyupdate_rekey(sk, 1), increments
tls_ctx->tx_key_updates and LINUX_MIB_TLSTXREKEYOK, and returns 0 even
though the KeyUpdate was not sent and sk->sk_err was consumed.

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
> +static int tls_tx_key_update_if_due(struct sock *sk, int flags)
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
Can KeyUpdate state become inconsistent if tls_tx_key_update() sleeps and
drops the socket lock?

When the socket send buffer is full and MSG_DONTWAIT is not set (which is
always true for tls_sw_key_update() since it passes MSG_NOSIGNAL, as well as
for blocking tls_sw_sendmsg()), tls_tx_key_update() ->
tls_sw_sendmsg_locked() can block in sk_stream_wait_memory(), temporarily
releasing lock_sock(sk) while keeping ctx->tx_lock held.

Because do_tls_setsockopt_conf() (for TLS_TX and TLS_RX) and the RX path in
tls_keyupdate_rx() only acquire lock_sock(sk) and not ctx->tx_lock, they can
interleave while tls_tx_key_update() is sleeping:

1. A concurrent setsockopt(SOL_TLS, TLS_TX, ...) in do_tls_setsockopt_conf()
installs a new TX key and zeroes ctx->tx_secret:

net/tls/tls_main.c:do_tls_setsockopt_conf() {
		if (tx) {
			memzero_explicit(&ctx->tx_secret,
					 sizeof(ctx->tx_secret));
			ctx->tx_key_update_reply =3D false;
		}
		memzero_explicit(&ctx->rx_secret, sizeof(ctx->rx_secret));
		/* the answer now goes to user space */
		ctx->tx_key_update_asked =3D false;
}

When tls_tx_key_update() wakes up, it encrypts the KeyUpdate record with the
newly installed key and then calls tls_keyupdate_rekey(sk, 1), which sees
ctx->tx_secret.len =3D=3D 0, returns -EINVAL, and triggers
tls_err_abort(sk, -EINVAL), aborting the connection.

2. A concurrent setsockopt(SOL_TLS, TLS_RX, ...) during
tls_sw_key_update(sk, 1) zeroes ctx->rx_secret and resets
ctx->tx_key_update_asked =3D false. When tls_sw_key_update(sk, 1) wakes up,=
 it
sends KeyUpdate(update_requested) and sets ctx->tx_key_update_asked =3D true
even though ctx->rx_secret was cleared, leaving tx_key_update_asked
permanently stuck at -EBUSY because user space rather than the kernel will
consume the peer's reply.

3. A concurrent recvmsg() running tls_keyupdate_rx() while
tls_sw_key_update(sk, 1) is sleeping in sk_stream_wait_memory() can set
ctx->tx_key_update_reply =3D true after tls_sw_key_update(sk, 1) has already
passed the if (request && ctx->tx_key_update_reply) check, causing it to
send KeyUpdate(update_requested) without first sending the required
KeyUpdate(update_not_requested) reply.

> +
>  int tls_sw_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
>  {
>  	struct tls_context *tls_ctx =3D tls_get_ctx(sk);
> @@ -1019,7 +1165,9 @@ int tls_sw_sendmsg(struct sock *sk, struct msghdr *=
msg, size_t size)
>  	if (ret)
>  		return ret;
>  	lock_sock(sk);
> -	ret =3D tls_sw_sendmsg_locked(sk, msg, size);
> +	ret =3D tls_tx_key_update_if_due(sk, msg->msg_flags);
> +	if (!ret)
> +		ret =3D tls_sw_sendmsg_locked(sk, msg, size);
>  	release_sock(sk);
>  	mutex_unlock(&tls_ctx->tx_lock);
>  	return ret;

[Severity: High]
Should tls_tx_key_update_if_due() be checked before each record inside
tls_sw_sendmsg_locked() rather than only once at the start of
tls_sw_sendmsg()?

Inside tls_sw_sendmsg_locked(), the while (msg_data_left(msg)) loop segments
the message into records of up to tls_ctx->tx_max_payload_len bytes and
encrypts each record via bpf_exec_tx_verdict() -> tls_push_record() ->
tls_do_encryption(), advancing tls_ctx->tx.rec_seq on every record:

net/tls/tls_sw.c:tls_sw_sendmsg_locked() {
	while (msg_data_left(msg)) {
		if (sk->sk_err) {
			ret =3D -sk->sk_err;
			goto send_end;
		}
		...
}

Because tls_tx_key_update_if_due() is only called before entering
tls_sw_sendmsg_locked():

1. Any multi-record sendmsg(), write(), sendfile(), or splice() call that
starts with rec_seq < TLS_KEYUPDATE_TX_RECORDS (2^24) will continue
encrypting all remaining records in that call under the old key after
rec_seq crosses 2^24 (including when ctx->tx_key_updates =3D=3D
TLS_KEYUPDATE_MAX, bypassing the -EKEYEXPIRED check at the record limit).
In particular, if TLS_TX_MAX_PAYLOAD_LEN is set to a small value (down to
63 bytes for TLS 1.3), a single large write or sendfile call of MAX_RW_COUNT
(~2 GiB) can encrypt over 3.4 * 10^7 (> 2^25) records in one
tls_sw_sendmsg_locked() invocation without any KeyUpdate.

2. If tls_sw_sendmsg_locked() blocks in sk_stream_wait_memory() and drops
lock_sock(sk) mid-loop, a concurrent recvmsg() can process a peer
KeyUpdate(update_requested) in tls_keyupdate_rx() and set
ctx->tx_key_update_reply =3D true, but tls_sw_sendmsg_locked() will continue
encrypting and sending all remaining Application Data records in msg before
replying with a KeyUpdate.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028-keyupdate-=
rfc-v2-0-eb5143b4c487@gmail.com?part=3D4

