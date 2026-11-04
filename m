Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B149606E831
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Nov 2026 21:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=pQrW8nCb;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DDwdp8Bm
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=SHVzNJ9VQZQQS4cLpWWqSHWVJbLB+APUZjRTflSqlBg=; b=pQrW8nCbxEMGAsvBA6T6hRlvej
	CybZUZMJuNd5LYEdRTJJ0/v6R5opmD2z2NMFT3K78i6Ifu2pIriV94yB+KCw0az68LrLZ0wsW8+Jt
	b1DuZNWH7iL4qz6CQqI91wMjXL2+CJSciSLPdxFzKmW+r+D4CAgtCnyYizlt6UJxbvwSY/9qHinA5
	tXU2R29jQ2X+1HtdmcfWsnTleG3f3VWD8z3a/TdHIEzqdCGgy1lUFvYXMmpJYmSdQU6bC30lWCFUn
	/xqSxNU0Mn+eRqBeu0WdeUmUPFql4JMagRaZ3wBqVyMgTRXzFEFt0+VICIP1d6rGFOFx6dZpavoDx
	N4zwVFuw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOill-0000000750v-3mAM;
	Wed, 04 Nov 2026 21:43:45 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOilk-0000000750c-1qXY
	for linux-nvme@lists.infradead.org;
	Wed, 04 Nov 2026 21:43:44 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id D24C160F2C;
	Wed,  4 Nov 2026 21:43:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D5841F000C1;
	Wed,  4 Nov 2026 21:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793828623;
	bh=SHVzNJ9VQZQQS4cLpWWqSHWVJbLB+APUZjRTflSqlBg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DDwdp8Bmhoq08fg7gvn1yqBPBqevzr2l3VRvTJA9HeMcQkXhFUMwQpQSmzBqYQRK5
	 b7MP3MggyAMjCJ18iWM9UDSz/8sKXqgS1x5lildzDyIS62j2XJ7qtJ8pIk30CTl9Lu
	 XNPrPx0wzuhnbSr8whSAIhdPP0JVhLEyAinTexEN/0vhXU7z0wsfUzNmxYHVzA22cM
	 HEvyKegphzcbfPRSBL8COJzOFG6LhDGW2kZQQ4uif4KS9vlcbuAIPcZ9a44ZxBCKMt
	 +UCXFH0OpR95/s9NiYTNkTgSfBBzEP3eqbep4F58diInCt245QZ/dyhJNQ0Y46T9EH
	 uJdMPmmJOqmCQ==
Message-ID: <sashiko-outbox-198141@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v5 5/6] tls: send a KeyUpdate at the record
 limit and on request
To: "Martin Belanger" <martin.nvme.dev@gmail.com>
Cc: linux-nvme@lists.infradead.org
In-Reply-To: <20261103-keyupdate-rfc-v5-5-de1ab90a88d5@gmail.com>
References: <20261103-keyupdate-rfc-v5-0-de1ab90a88d5@gmail.com>
 <20261103-keyupdate-rfc-v5-5-de1ab90a88d5@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 21:43:43 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] tls: KeyUpdate state races when sk_stream_wait_memory() drops lock=
_sock()
- [Medium] tls: tls_tx_key_update() ignores fatal send errors and loses EPI=
PE
--

commit 389b16f77ade9ff55b3149bc7e91f1df21b17162
Author: Martin Belanger <martin.belanger@dell.com>

tls: send a KeyUpdate at the record limit and on request

This commit adds automatic TLS 1.3 TX KeyUpdate transmission when a cipher
reaches its record limit or when replying to a peer's update_requested, and
introduces the TLS_TX_KEY_UPDATE socket option to trigger an immediate TX
KeyUpdate from user space.

> diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
> index 027c32edaf850..433a43d13a872 100644
> --- a/net/tls/tls_sw.c
> +++ b/net/tls/tls_sw.c

[ ... ]

> @@ -805,6 +808,19 @@ static int tls_sw_sendmsg_locked(struct sock *sk, st=
ruct msghdr *msg,
>  			goto send_end;
>  		}
> =20
> +		/* Check before each new record: one call can write many
> +		 * records, and a KeyUpdate reply must go before the next
> +		 * one. A send that failed before it copied any data leaves
> +		 * an empty open record. The KeyUpdate itself is a handshake
> +		 * record.
> +		 */
> +		if ((!ctx->open_rec || !ctx->open_rec->msg_plaintext.sg.size) &&
> +		    record_type =3D=3D TLS_RECORD_TYPE_DATA) {
> +			ret =3D tls_tx_maybe_update_key(sk, msg->msg_flags);
> +			if (ret)
> +				goto send_end;
> +		}
> +
>  		if (ctx->open_rec)
>  			rec =3D ctx->open_rec;
>  		else
> @@ -1005,6 +1021,153 @@ static int tls_sw_sendmsg_locked(struct sock *sk,=
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
> +
> +	/* Nothing may be encrypted with the next key before the KeyUpdate
> +	 * is encrypted with the current one.
> +	 */
> +	ret =3D tls_encrypt_async_wait(ctx);
> +	if (!ret)
> +		ret =3D tls_keyupdate_rekey(sk, 1);

[Severity: Medium]
As reported by Sashiko on v4 [1], can tls_tx_key_update() ignore fatal
transmission errors and rotate the TX key anyway when tls_tx_records() fails
with -EPIPE or -ECONNRESET?

Inside tls_sw_sendmsg_locked(), when sk->sk_err is initially 0 (for example
after shutdown(fd, SHUT_WR), which sets SEND_SHUTDOWN without setting
sk->sk_err), the 5-byte KeyUpdate payload is copied into msg_pl and copied =
is
set to 5 before bpf_exec_tx_verdict() -> tls_push_record() ->
tls_tx_records() -> tls_push_sg() -> tcp_sendmsg_locked() attempts to
transmit the encrypted record.

When tcp_sendmsg_locked() fails with -EPIPE or -ECONNRESET, tls_tx_records()
calls tls_err_abort(sk, rc) and returns the negative errno, but
bpf_exec_tx_verdict() only rolls back *copied when sk->sk_err =3D=3D EBADMS=
G:

net/tls/tls_sw.c:bpf_exec_tx_verdict() {
	err =3D tls_push_record(sk, flags, record_type);
	if (err && err !=3D -EINPROGRESS && sk->sk_err =3D=3D EBADMSG) {
		*copied -=3D sk_msg_free(sk, msg);
		tls_free_open_rec(sk);
		err =3D -sk->sk_err;
	}
	return err;
}

At the end of tls_sw_sendmsg_locked(), copied is still 5 while ret is -EPIP=
E:

net/tls/tls_sw.c:tls_sw_sendmsg_locked() {
end:
	ret =3D sk_stream_error(sk, msg->msg_flags, ret);
	return copied > 0 ? copied : ret;
}

When ret is -EPIPE, sk_stream_error() calls sock_error(sk), which atomically
clears sk->sk_err back to 0, and tls_sw_sendmsg_locked() then discards ret
and returns copied (5).

Because tls_tx_key_update() only checks ret < 0, it treats the failed send =
as
success, calls tls_keyupdate_rekey(sk, 1), increments LINUX_MIB_TLSTXREKEYOK
and tls_ctx->tx_key_updates, updates tx_key_update_reply or
tx_key_update_asked, and returns 0 while leaving the unsent KeyUpdate record
queued on ctx->tx_list and sk->sk_err cleared to 0.

When called from tls_tx_maybe_update_key() inside tls_sw_sendmsg_locked(),
returning 0 also causes the outer sendmsg loop to continue and encrypt the
caller's Application Data record after the KeyUpdate transmission has alrea=
dy
failed.

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
As reported by Sashiko on v4 [2], how is the KeyUpdate state in struct
tls_context synchronized when sk_stream_wait_memory() drops lock_sock(sk)
during a send or TLS_TX_KEY_UPDATE?

The KeyUpdate fields (tx_secret, rx_secret, tx_key_updates,
tx_key_update_reply, and tx_key_update_asked) are protected by lock_sock(sk=
);
do_tls_setsockopt_conf(), do_tls_setsockopt_secret(), and tls_keyupdate_rx()
all run under lock_sock(sk) without acquiring ctx->tx_lock. However, when t=
he
socket send buffer is full, tls_sw_sendmsg_locked() (at wait_for_sndbuf /
wait_for_memory) and tcp_sendmsg_locked() (via tls_push_sg()) call
sk_stream_wait_memory(), which temporarily releases lock_sock(sk) while
ctx->tx_lock remains held.

Can this cause several races while a sender is sleeping in
sk_stream_wait_memory()?

1. In tls_sw_key_update() and tls_tx_maybe_update_key(), ctx->tx_secret.len
is checked before calling tls_tx_key_update() -> tls_sw_sendmsg_locked(). If
lock_sock(sk) is dropped in sk_stream_wait_memory() and a concurrent
setsockopt(SOL_TLS, TLS_TX) runs do_tls_setsockopt_conf(), it zeroes
ctx->tx_secret. When tls_tx_key_update() wakes up and finishes sending the
KeyUpdate record, tls_keyupdate_rekey(sk, 1) sees !secret->len, returns
-EINVAL, and calls tls_err_abort(sk, -EINVAL), aborting the connection (or =
if
TLS_TX_TRAFFIC_SECRET was also re-registered before wakeup, derives an extra
key update and desynchronizes the TX key schedule).

2. While tls_sw_key_update(sk, 1) is sleeping in sk_stream_wait_memory(), a
concurrent setsockopt(SOL_TLS, TLS_RX) can zero ctx->rx_secret and clear
ctx->tx_key_update_asked =3D false. When tls_sw_key_update(sk, 1) wakes up,=
 it
sends KeyUpdate(TLS_KEY_UPDATE_REQUESTED) without a registered rx_secret and
sets ctx->tx_key_update_asked =3D true, leaving tx_key_update_asked permane=
ntly
wedged because user space rather than the kernel will consume the peer's
reply.

3. While tls_sw_key_update(sk, 1) is sleeping at wait_for_sndbuf before the
KeyUpdate record is encrypted, a concurrent recvmsg() can run
tls_keyupdate_rx() and set ctx->tx_key_update_reply =3D true after
tls_sw_key_update(sk, 1) has already passed the if (request &&
ctx->tx_key_update_reply) check, causing KeyUpdate(TLS_KEY_UPDATE_REQUESTED)
to be sent without first sending the required
KeyUpdate(TLS_KEY_UPDATE_NOT_REQUESTED) reply.

4. In tls_sw_sendmsg_locked(), tls_tx_maybe_update_key() runs at the top of
the loop before ctx->open_rec =3D tls_get_rec(sk) and before
!sk_stream_memory_free(sk) jumps to wait_for_sndbuf:

net/tls/tls_sw.c:tls_sw_sendmsg_locked() {
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

		if (ctx->open_rec && msg_en->sg.size < required_size)
			goto alloc_encrypted;
}

If a blocking Application Data send sleeps in sk_stream_wait_memory() before
copying any plaintext (orig_size =3D=3D 0) and a concurrent reader processe=
s a
peer KeyUpdate(update_requested) via tls_keyupdate_rx() (setting
ctx->tx_key_update_reply =3D true), waking up and taking goto alloc_encrypt=
ed
bypasses tls_tx_maybe_update_key() and sends the Application Data record wi=
th
the old key ahead of the required KeyUpdate reply.

[1] https://lore.kernel.org/r/20261102-keyupdate-rfc-v4-4-f17419972b9f@gmai=
l.com
[2] https://lore.kernel.org/r/20261102-keyupdate-rfc-v4-4-f17419972b9f@gmai=
l.com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-keyupdate-=
rfc-v5-0-de1ab90a88d5@gmail.com?part=3D5

