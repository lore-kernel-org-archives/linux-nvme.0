Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C421606A326
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2026 16:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=VFSUDbO5;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZcBhJskl
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=BeeLPHgQbkHNpANsluu8Xje9C+jzbckI5lot/eMoPlo=; b=VFSUDbO5n8lHdQIx6LelB/JbCY
	GTDFjdOIvilcG2bVCAGSUM241/JF5mTQ4+qZdXQphnSbSYGLfBcxN1IS6C1zajOPWIzuxFHCpqVsn
	8elos1OINx19Ood+xncr5LcXqTDx8EhHhfQ2F4L/Y7n228WtG0oXxcAktt7bX6ELWoRscRChrW06Q
	xk3yya38ZfM8OTmgSwdtIbEowWlQ19i27Ac3PyhCEWk0RgOj9mnc+NUSSQ0I1d2UR+bCCKMSH6XWX
	jDWCnhEENMZfx0DkXPEaosTDWJT3JFibrCouBaJTFytfXSOZkYsySLKp8w22o4VS+QGsLqclHwOOC
	hUk89ZCA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPMq5-0000000D3eT-3DSv;
	Fri, 06 Nov 2026 16:30:53 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPMq4-0000000D3dn-2bZR
	for linux-nvme@lists.infradead.org;
	Fri, 06 Nov 2026 16:30:52 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 132DA43BD6;
	Fri,  6 Nov 2026 16:30:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB2091F0089F;
	Fri,  6 Nov 2026 16:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793982652;
	bh=BeeLPHgQbkHNpANsluu8Xje9C+jzbckI5lot/eMoPlo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZcBhJsklOOrJaJsxn98m6hUs+aoJMfyJjpqf3sHaQ5E4mAsIEIUEeOVoDzxnsknOn
	 h94KPyio91kAdG8CVwEiRzEn9H2UumBhuvpsEkb7IdJwvSfyxzRMh8iwQ+3px9yj5D
	 NHbO9KJT94OkNCk+vhH1MS9SuybiFZ7ZF/fhxN+str1TDgRSTmeIPNI2j802Hntavw
	 iwkEJA/jL/FqNsBKXDJu4AzjSZsj2YNFT0yGwboh1NLA0RXAsZmjlcxVtNK1sbDLaa
	 ThVBgCbYgGj7bz/bC7xqL9zEkZ+i8CL+jp6QcKvzzE3fBlSVLyl5kAlmXVsexqM9Ae
	 RfzYq7RAOQJTg==
Message-ID: <sashiko-outbox-201821@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v6 5/6] tls: send a KeyUpdate at the record
 limit and on request
To: "Martin Belanger" <martin.nvme.dev@gmail.com>
Cc: linux-nvme@lists.infradead.org
In-Reply-To: <20261105-keyupdate-rfc-v6-5-99b695f9eb4f@gmail.com>
References: <20261105-keyupdate-rfc-v6-0-99b695f9eb4f@gmail.com>
 <20261105-keyupdate-rfc-v6-5-99b695f9eb4f@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 16:30:51 +0000
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
- [Medium] tls: tls_tx_key_update() ignores fatal send errors and loses
  EPIPE
--

commit cc9936b6fa0f39f256d5df2f7358e9099a857211
Author: Martin Belanger <martin.belanger@dell.com>

tls: send a KeyUpdate at the record limit and on request

This commit sends a TLS 1.3 KeyUpdate handshake record automatically when a
socket with a registered TX secret reaches 2^24 records or when replying to=
 a
peer's update_requested flag. It also adds the TLS_TX_KEY_UPDATE socket opt=
ion
to allow applications to trigger a KeyUpdate on demand.

> diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
> index 027c32edaf850..433a43d13a872 100644
> --- a/net/tls/tls_sw.c
> +++ b/net/tls/tls_sw.c

[ ... ]

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

[ ... ]

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
As reported by Sashiko on v5 [1], what happens if transmitting the KeyUpdate
record in tls_sw_sendmsg_locked() fails with a fatal TCP error such as -EPI=
PE
(for example on a write-shutdown socket) or -ECONNRESET?

Inside tls_sw_sendmsg_locked(), the 5-byte KeyUpdate body is copied into
msg_pl and copied is incremented to 5 before pushing the record:

  tls_sw_sendmsg_locked()
    sk_msg_memcopy_from_iter()
    copied +=3D try_to_copy;
    bpf_exec_tx_verdict()
      tls_push_record()
        tls_tx_records()
          tls_push_sg()
            tcp_sendmsg_locked() -> returns -EPIPE or -ECONNRESET
          tls_err_abort(sk, rc) -> sets sk->sk_err

In bpf_exec_tx_verdict(), *copied is only rolled back when sk->sk_err is
EBADMSG:

	err =3D tls_push_record(sk, flags, record_type);
	if (err && err !=3D -EINPROGRESS && sk->sk_err =3D=3D EBADMSG) {
		*copied -=3D sk_msg_free(sk, msg);
		tls_free_open_rec(sk);
		err =3D -sk->sk_err;
	}
	return err;

Then at the end of tls_sw_sendmsg_locked(), sk_stream_error() is called
before returning:

end:
	ret =3D sk_stream_error(sk, msg->msg_flags, ret);
	return copied > 0 ? copied : ret;

When ret is -EPIPE, sk_stream_error() calls sock_error(sk), which clears
sk->sk_err back to 0, and tls_sw_sendmsg_locked() then discards ret because
copied > 0 and returns 5.

Because tls_tx_key_update() only checks for ret < 0, won't it treat the fai=
led
transmission as a success, rotate the TX key via tls_keyupdate_rekey(sk, 1),
increment LINUX_MIB_TLSTXREKEYOK and tls_ctx->tx_key_updates, and return 0
while the unsent KeyUpdate record remains queued on ctx->tx_list (and with
sk->sk_err cleared to 0 in the -EPIPE case)?

[1] https://lore.kernel.org/r/sashiko-outbox-198141@kernel.org

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-keyupdate-=
rfc-v6-0-99b695f9eb4f@gmail.com?part=3D5

