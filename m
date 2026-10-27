Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1769B606A31A
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Oct 2026 00:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=xralAgVO;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BLuZ3nn0
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=AHTg5LrmTRCidQYtcebNbXZ2VNLqeb9B0Tq+ClWe9dw=; b=xralAgVOQh4Ki/DI1c07gMuV8Z
	aMABmckoqtHMseYXU3Gy/PYPhWCp5jAc9Mev9GIeC7XhiU427yyQojXzmY6rSOWe1hSrm8f2n+eIW
	qb5YNl/Vl674VpAgSVtlAFksm0cakdn92WMFTADxExbX86GGFMpZKK5FDzKRI3MCMLVUdVHGT4aTL
	YIxYxcwHQ+3oFhKRV/6bXdIzSPXnwBD7gwN1rYvmOrYmGSsb/cV7ip9RZugtnOx/nVcwUvPmE4cGq
	ReijiE1HsBmggfqf1Uee14P4iVW5C3nuF8Wq3HD1f8HLzE/VcwZYefaMn4nz3fxaWft8cZQhAIW5P
	IOy/9tvA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLVBe-00000003XZa-0CdH;
	Tue, 27 Oct 2026 00:37:10 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLVBd-00000003XZS-1KFA
	for linux-nvme@lists.infradead.org;
	Tue, 27 Oct 2026 00:37:09 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id BC29B42E6D;
	Tue, 27 Oct 2026 00:37:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 786A41F01825;
	Tue, 27 Oct 2026 00:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793061428;
	bh=AHTg5LrmTRCidQYtcebNbXZ2VNLqeb9B0Tq+ClWe9dw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BLuZ3nn0g/iYJ573uSCW+rRS+mEc52CxpRJ4jbdPcibJ3ZcCWhtp/8qjtTBAKKLq7
	 vIaEuWfRd7VbALKEGJIbLzx4XmnnFsY6KKieBZFMAmqUd9MZzL35vlq/Blcyljax54
	 hHXs5063v+gPJo+Ql7vWptAcXdNGbvxD/SDqThENv7iB8W64smrGFQ3nosl+42JDz+
	 PuJHijIitEy4+o4DDbW5X/eRATVxx5BPLt3L52gOJVso77AsY793lkbPb5w05IP9u/
	 lEA8BqKFQfNuSQSv680GoLam6dtM8lEJU7BZHnwM+zaprzGKIJr90iFSSq1Fsm5tzC
	 psQ64ISuiLVnQ==
Message-ID: <sashiko-outbox-185958@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC net-next 3/5] tls: update the RX key when a
 KeyUpdate is received
To: "Martin Belanger" <martin.nvme.dev@gmail.com>
Cc: linux-nvme@lists.infradead.org
In-Reply-To: <20261025-keyupdate-rfc-v1-3-60b7756eccbd@gmail.com>
References: <20261025-keyupdate-rfc-v1-0-60b7756eccbd@gmail.com>
 <20261025-keyupdate-rfc-v1-3-60b7756eccbd@gmail.com>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] tls: memory leak of decrypted skb when tls_keyupdate_rx() fails
- [Medium] tls: spurious saved_data_ready() call during in-kernel RX rekey
--

commit 52ccace8026bcb8f3e4f14ffabc2a54f8cb3955e
Author: Martin Belanger <martin.belanger@dell.com>

tls: update the RX key when a KeyUpdate is received

This commit updates the kTLS receive path so sockets with a registered RX
traffic secret automatically derive and install the next key upon decrypting
a TLS 1.3 KeyUpdate record. The consumed KeyUpdate record is not passed to
the caller, and invalid or excessive KeyUpdate messages abort the connectio=
n.

> diff --git a/net/tls/tls_keyupdate.c b/net/tls/tls_keyupdate.c
> new file mode 100644
> index 0000000000000..543bf57599c7b
> --- /dev/null
> +++ b/net/tls/tls_keyupdate.c

[ ... ]

> +int tls_keyupdate_rekey(struct sock *sk, int tx)
> +{
> +	struct tls_context *ctx =3D tls_get_ctx(sk);
> +	struct tls_traffic_secret *secret;
> +	const struct tls_cipher_desc *cipher_desc;
> +	u8 iv[TLS_MAX_SALT_SIZE + TLS_MAX_IV_SIZE];
> +	u8 next[TLS_MAX_TRAFFIC_SECRET_SIZE];
> +	union tls_crypto_context tmp =3D {};
> +	struct tls_crypto_info *info =3D &tmp.info;
> +	int rc;
> +
> +	secret =3D tx ? &ctx->tx_secret : &ctx->rx_secret;
> +	cipher_desc =3D get_cipher_desc(ctx->prot_info.cipher_type);
> +	if (!cipher_desc || !secret->len ||
> +	    cipher_desc->salt + cipher_desc->iv > sizeof(iv))
> +		return -EINVAL;
> +
> +	/* version and cipher_type; the rest of tmp stays zero */
> +	*info =3D tx ? ctx->crypto_send.info : ctx->crypto_recv.info;
> +
> +	rc =3D tls_hkdf_expand_label(secret->data, secret->len, "traffic upd",
> +				   next, secret->len);
> +	if (rc)
> +		goto out;
> +
> +	rc =3D tls_hkdf_expand_label(next, secret->len, "key",
> +				   crypto_info_key(info, cipher_desc),
> +				   cipher_desc->key);
> +	if (rc)
> +		goto out;
> +
> +	rc =3D tls_hkdf_expand_label(next, secret->len, "iv", iv,
> +				   cipher_desc->salt + cipher_desc->iv);
> +	if (rc)
> +		goto out;
> +
> +	memcpy(crypto_info_salt(info, cipher_desc), iv, cipher_desc->salt);
> +	memcpy(crypto_info_iv(info, cipher_desc), iv + cipher_desc->salt,
> +	       cipher_desc->iv);
> +
> +	rc =3D tls_set_sw_offload(sk, tx, info);
> +	if (rc)
> +		goto out;

[Severity: Medium]
When tls_keyupdate_rekey() is called on the RX path (tx =3D=3D 0) via:

  tls_rx_one_record()
    -> tls_check_pending_rekey()
      -> tls_keyupdate_rx()
        -> tls_keyupdate_rekey()
          -> tls_set_sw_offload()
            -> tls_finish_key_update()

tls_finish_key_update() unconditionally invokes ctx->saved_data_ready(sk):

  static void tls_finish_key_update(struct sock *sk, struct tls_context *tl=
s_ctx)
  {
          struct tls_sw_context_rx *ctx =3D tls_ctx->priv_ctx_rx;

          WRITE_ONCE(ctx->key_update_pending, false);
          /* wake-up pre-existing poll() */
          ctx->saved_data_ready(sk);
  }

In this in-kernel RX rekey path, ctx->key_update_pending was never set to
true, and tls_rx_rec_done(ctx) has not been called yet by the caller
(tls_sw_recvmsg(), tls_sw_splice_read(), or tls_sw_read_sock()), so
ctx->strp.msg_ready still refers to the unconsumed KeyUpdate record.

Won't calling ctx->saved_data_ready(sk) here cause concurrent pollers runni=
ng
tls_sk_poll() to observe tls_strp_msg_ready(ctx) =3D=3D true and falsely re=
port
EPOLLIN | EPOLLRDNORM when no application data record follows, as well as
schedule spurious receive work in kernel consumers like nvme-tcp and sunrpc
that commit 22f8bf8808dc ("tls: Suppress spurious saved_data_ready on all
receive paths") aimed to avoid?

[ ... ]

> diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
> index 312e51270f293..a314fa638dc36 100644
> --- a/net/tls/tls_sw.c
> +++ b/net/tls/tls_sw.c
> @@ -1551,15 +1551,26 @@ static int tls_check_pending_rekey(struct sock *s=
k, struct tls_context *ctx,
>  	if (hs_type =3D=3D TLS_HANDSHAKE_KEYUPDATE) {
>  		struct tls_sw_context_rx *rx_ctx =3D ctx->priv_ctx_rx;
> =20
> -		WRITE_ONCE(rx_ctx->key_update_pending, true);
>  		TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSRXREKEYRECEIVED);
> +
> +		if (ctx->rx_secret.len) {
> +			err =3D tls_keyupdate_rx(sk, skb);
> +			if (err) {
> +				tls_err_abort(sk, err);
> +				return err;
> +			}
> +			return 1;
> +		}

[Severity: High]
Does this error path leak the decrypted skb (darg->skb)?

In tls_rx_one_record(), tls_decrypt_sw() (or tls_decrypt_device()) has
already allocated a standalone cleartext skb in darg->skb for the
TLS_RECORD_TYPE_HANDSHAKE record before calling tls_check_pending_rekey().

When tls_keyupdate_rx() returns a negative errno (for example, due to a
malformed KeyUpdate message or exceeding TLS_KEYUPDATE_RX_MAX_PER_SEC),
tls_check_pending_rekey() returns that negative error to tls_rx_one_record()
without freeing skb.

All three callers of tls_rx_one_record() only call consume_skb(darg.skb) wh=
en
err >=3D 0, and jump straight to their exit labels when err < 0:

  err =3D tls_rx_one_record(sk, msg, &darg);
  if (err < 0)
          goto recv_end; /* or splice_read_end / read_sock_end */
  if (err > 0) {
          tls_rx_rec_done(ctx);
          consume_skb(darg.skb);
          continue;
  }

Should skb be freed via consume_skb(skb) before returning a negative error
from tls_check_pending_rekey()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261025-keyupdate-=
rfc-v1-0-60b7756eccbd@gmail.com?part=3D3

