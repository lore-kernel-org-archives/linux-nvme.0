Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055C8606A31A
	for <linux-nvme@archiver.kernel.org>; Sat, 31 Oct 2026 11:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=jbk33gjA;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DLblGfu0
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=rNSBH7WuCqIrjLyTIye75h3C+ft4buKkKyElAYF7IsI=; b=jbk33gjAXU4CFCqDaBqpQNdBCg
	fgc7xepDjOTTT+PKr5BqggawHEycMehLDNnd4K8Sx1TYl0fM31PPscJK2PRHW/30ksRUPbXdOF9AU
	Sn4uzPnH8qVNU1Q8BfVHjswAVhpk7NG30T1QBLApExRsc7azoyF6OTxYx/D4WjPFGBtSGL+s9nnG/
	6GmxbLZ7wuLBzJmSymfo2BIZxz8gHhyWTKpI0Wy+7K7MsMyRLb3YXq9wQSH6WriZc3WKAq40dlS0J
	7jQdVZTxDE7+JPlzsVU/eUk+Ppq1pZNObrD5afyLrOkfSWaUMYk3mMn0WO0sb7lm8l2k0MINpRwVH
	JEf+cKrg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xN76R-0000000DFlB-1qkT;
	Sat, 31 Oct 2026 11:18:27 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xN76P-0000000DFl4-2iHk
	for linux-nvme@lists.infradead.org;
	Sat, 31 Oct 2026 11:18:25 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id A6DC3600AA;
	Sat, 31 Oct 2026 11:18:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 374371F000C1;
	Sat, 31 Oct 2026 11:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793445504;
	bh=rNSBH7WuCqIrjLyTIye75h3C+ft4buKkKyElAYF7IsI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DLblGfu02pCBPqxE/UAPahY1jNsMlyeQxSjj3VMct++7o6l6/TRiVuW7F5LHS7iGd
	 ZRuOYkgOJAzsCPyWLu+jQYJoWRfopA13EFF/5xBtMpV9DVPAfPbO4atwVu813YE07j
	 sCgKHObmnoAE/tGIqW6yIId0Uk/HoIQsDG8sxz49JwzNHrvrCOuLQcr98C+DkMs0WO
	 vbKR1hyoXknUqSvJaWRUX1oL2HWpkyTfx+vFWZ+U1HekiC4KojgUU6W6twVA0aMeK8
	 +Crv1aXCxDtQA+Cv4Dli92Kom1E9WascMichunT2TiOYZUIkuMLXp7/Kv4koG6R9bk
	 BS1rCgsuEXfVA==
Message-ID: <sashiko-outbox-191917@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC net-next v3 4/5] tls: send a KeyUpdate at the record
 limit and on request
To: "Martin Belanger" <martin.nvme.dev@gmail.com>
Cc: linux-nvme@lists.infradead.org
In-Reply-To: <20261030-keyupdate-rfc-v3-4-8e1e32226e51@gmail.com>
References: <20261030-keyupdate-rfc-v3-0-8e1e32226e51@gmail.com>
 <20261030-keyupdate-rfc-v3-4-8e1e32226e51@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 31 Oct 2026 11:18:23 +0000
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
- [High] tls: KeyUpdate state races when sk_stream_wait_memory() drops lock=
_sock()
- [Medium] tls: premature tls_tx_maybe_update_key() call in tls_sw_sendmsg()
- [Medium] tls: tls_tx_key_update() ignores send errors and clears sk_err w=
hen copied > 0
--

commit 2c49d2f944d8bdc66426d465f54f8eb74134a56b
Author: Martin Belanger <martin.belanger@dell.com>

tls: send a KeyUpdate at the record limit and on request

This commit sends a TLS 1.3 KeyUpdate handshake record and rotates the TX k=
ey
when the key reaches 2^24 records or when replying to a peer KeyUpdate with
update_requested. It also adds the TLS_TX_KEY_UPDATE socket option to allow
applications to trigger a KeyUpdate on demand.

> diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
> index cc0177320e7e6..f46cfbd95a6fc 100644
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
> +
> +	/* Nothing may be encrypted with the next key before the KeyUpdate
> +	 * is encrypted with the current one.
> +	 */
> +	ret =3D tls_encrypt_async_wait(ctx);
> +	if (!ret)
> +		ret =3D tls_keyupdate_rekey(sk, 1);

[Severity: Medium]
As reported by Sashiko on v2 [1], what happens in tls_tx_key_update() when
transmitting the KeyUpdate record fails in tls_tx_records(), for example
with -EPIPE on a write-shutdown socket or -ECONNRESET?

Inside tls_sw_sendmsg_locked(), the 5-byte KeyUpdate body is copied into
msg_pl and copied is incremented to 5 before bpf_exec_tx_verdict() calls
tls_push_record() -> tls_tx_records() -> tls_push_sg() ->
tcp_sendmsg_locked().

When tcp_sendmsg_locked() returns an error such as -EPIPE, tls_tx_records()
calls tls_err_abort(sk, rc) to set sk->sk_err. However, bpf_exec_tx_verdict=
()
only rolls back *copied when sk->sk_err =3D=3D EBADMSG:

net/tls/tls_sw.c:bpf_exec_tx_verdict() {
	err =3D tls_push_record(sk, flags, record_type);
	if (err && err !=3D -EINPROGRESS && sk->sk_err =3D=3D EBADMSG) {
		*copied -=3D sk_msg_free(sk, msg);
		tls_free_open_rec(sk);
		err =3D -sk->sk_err;
	}
	return err;
}

At the end of tls_sw_sendmsg_locked(), sk_stream_error(sk, msg->msg_flags,
ret) calls sock_error(sk) on -EPIPE, which atomically clears sk->sk_err back
to 0, and then tls_sw_sendmsg_locked() discards ret because copied > 0:

net/tls/tls_sw.c:tls_sw_sendmsg_locked() {
end:
	ret =3D sk_stream_error(sk, msg->msg_flags, ret);
	return copied > 0 ? copied : ret;
}

Because tls_sw_sendmsg_locked() returns 5 rather than a negative errno,
wouldn't tls_tx_key_update() treat the failed transmission as a success,
rotate the TX key via tls_keyupdate_rekey(sk, 1), update tx_key_updates and
tx_key_update_reply or tx_key_update_asked, and return 0 with the unsent
KeyUpdate record still sitting on ctx->tx_list and sk->sk_err cleared to 0?

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
As reported by Sashiko on v2 [2], can the KeyUpdate state in struct
tls_context race when tls_sw_sendmsg_locked() drops lock_sock(sk) inside
sk_stream_wait_memory()?

While tls_sw_key_update() and tls_sw_sendmsg() hold both ctx->tx_lock and
lock_sock(sk), do_tls_setsockopt_conf() (in net/tls/tls_main.c) and
tls_keyupdate_rx() (in net/tls/tls_keyupdate.c) only acquire lock_sock(sk).
When the socket send buffer is full, tls_sw_sendmsg_locked() (at
wait_for_sndbuf or wait_for_memory, or via tls_push_sg() ->
tcp_sendmsg_locked()) calls sk_stream_wait_memory(), which releases
lock_sock(sk) while sleeping:

1. In tls_sw_key_update() and tls_tx_maybe_update_key(), ctx->tx_secret.len,
   ctx->rx_secret.len, ctx->tx_key_update_asked, and ctx->tx_key_update_rep=
ly
   are checked before calling tls_tx_key_update() -> tls_sw_sendmsg_locked(=
).
   If sk_stream_wait_memory() drops lock_sock(sk) and a concurrent
   setsockopt(SOL_TLS, TLS_TX) runs do_tls_setsockopt_conf() and zeroes
   ctx->tx_secret, tls_tx_key_update() will wake up, finish sending the
   KeyUpdate record, and call tls_keyupdate_rekey(sk, 1), which fails with
   -EINVAL on !secret->len and aborts the connection via tls_err_abort().

2. Similarly, if a concurrent setsockopt(SOL_TLS, TLS_RX) runs
   do_tls_setsockopt_conf() while tls_sw_key_update(sk, 1) is sleeping in
   sk_stream_wait_memory(), it clears ctx->rx_secret and resets
   ctx->tx_key_update_asked =3D false. When tls_sw_key_update(sk, 1) wakes =
up,
   it sends KeyUpdate(TLS_KEY_UPDATE_REQUESTED) and sets
   ctx->tx_key_update_asked =3D true without a registered rx_secret, leaving
   tx_key_update_asked permanently stuck because user space will consume the
   peer's reply.

3. If tls_keyupdate_rx() processes a peer KeyUpdate with
   TLS_KEY_UPDATE_REQUESTED while lock_sock(sk) is dropped in
   sk_stream_wait_memory(), ctx->tx_key_update_reply becomes true after:
   - tls_sw_key_update(sk, 1) already checked if (request &&
     ctx->tx_key_update_reply), causing it to send
     KeyUpdate(TLS_KEY_UPDATE_REQUESTED) without first sending the required
     KeyUpdate(TLS_KEY_UPDATE_NOT_REQUESTED) reply.
   - tls_sw_sendmsg_locked() already checked if (!ctx->open_rec &&
     record_type =3D=3D TLS_RECORD_TYPE_DATA) and allocated ctx->open_rec =
=3D
     tls_get_rec(sk), so waking up from wait_for_sndbuf jumps to
     alloc_encrypted and sends the Application Data record before the
     KeyUpdate reply.

> =20
>  int tls_sw_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
>  {
>  	struct tls_context *tls_ctx =3D tls_get_ctx(sk);
> @@ -1019,7 +1179,9 @@ int tls_sw_sendmsg(struct sock *sk, struct msghdr *=
msg, size_t size)
>  	if (ret)
>  		return ret;
>  	lock_sock(sk);
> -	ret =3D tls_sw_sendmsg_locked(sk, msg, size);
> +	ret =3D tls_tx_maybe_update_key(sk, msg->msg_flags);
> +	if (!ret)
> +		ret =3D tls_sw_sendmsg_locked(sk, msg, size);

[Severity: Medium]
Should tls_sw_sendmsg() really call tls_tx_maybe_update_key() unconditional=
ly
before tls_sw_sendmsg_locked() validates msg, parses control messages, and
checks msg_data_left(msg)?

Inside tls_sw_sendmsg_locked(), the KeyUpdate check in the loop is guarded =
by
!ctx->open_rec && record_type =3D=3D TLS_RECORD_TYPE_DATA after tls_process=
_cmsg()
has parsed any control message and after msg_data_left(msg) and sk->sk_err
have been checked.

By calling tls_tx_maybe_update_key() at the top of tls_sw_sendmsg() before
entering tls_sw_sendmsg_locked():

1. If the caller is sending a non-Application-Data control record via
   TLS_SET_RECORD_TYPE (such as a TLS Alert record for close_notify),
   tls_tx_maybe_update_key() runs before tls_process_cmsg() sets record_typ=
e,
   sending a KeyUpdate before an Alert record or failing with -EKEYEXPIRED =
at
   TLS_KEYUPDATE_MAX and blocking the Alert from being sent.

2. If the sendmsg() call has size =3D=3D 0, invalid flags (MSG_MORE | MSG_E=
OR),
   or a malformed control message that tls_sw_sendmsg_locked() would reject
   with -EINVAL, tls_tx_maybe_update_key() still flushes any open MSG_MORE
   record, transmits a KeyUpdate on the wire, and rotates the TX key.

3. If sk->sk_err is already set on the socket when tx_key_updates >=3D
   TLS_KEYUPDATE_MAX and the record limit is reached,
   tls_tx_maybe_update_key() returns -EKEYEXPIRED before
   tls_sw_sendmsg_locked() can report -sk->sk_err.

[1] https://lore.kernel.org/r/20261028-keyupdate-rfc-v2-4-eb5143b4c487@gmai=
l.com
[2] https://lore.kernel.org/r/20261028-keyupdate-rfc-v2-4-eb5143b4c487@gmai=
l.com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030-keyupdate-=
rfc-v3-0-8e1e32226e51@gmail.com?part=3D4

