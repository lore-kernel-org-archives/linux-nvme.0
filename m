Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D189606A324
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Nov 2026 16:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=kQuAvULl;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WgsHEjfb
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=qgm6LeuF4m8rOtMKJGdYqG/KUksLGOQ3KLQA3/P6Di0=; b=kQuAvULlZFMn06otxLxGdASNdf
	J1uxS0q410K7wCsmkhz26y20Twn4z2YoBpdhtUBcYJHXld8l1qesqIN73T28WZlEe0FdTL9nO1eRy
	3+PHyEKYD34S2dY38MhIW3rWbZ1qCXojdE24iHguYeqePOUgtNOn9WCfEbHhTYuf675nZ7QmEg278
	Mi9ktn2F9w9JZGXhGhlbzLK0LgE1y2Eqc/BAA6n+NQ98SXCneQ1GS7O012c7LPSngyrdH9XJyTZDl
	tCZ2tj4e9tCSZ4rfR//92k7klCfFp/C29LopDivRIsQZCueyMgyhtsEC/9zfpKQvq3E0EMgAt37ef
	1k53l/GQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOHpw-00000003Ev2-27I7;
	Tue, 03 Nov 2026 16:58:16 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOHpv-00000003Eue-1TGe
	for linux-nvme@lists.infradead.org;
	Tue, 03 Nov 2026 16:58:15 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id ADAF2601FF;
	Tue,  3 Nov 2026 16:58:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4995C1F000C1;
	Tue,  3 Nov 2026 16:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793725094;
	bh=qgm6LeuF4m8rOtMKJGdYqG/KUksLGOQ3KLQA3/P6Di0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WgsHEjfbAwbanZSdZtkDC5H7sa53qb8oiiHMU3Z8w11tYGRrNjuRG5hLuj4BfY4EQ
	 bwUxBl09tB3P6UUh+lYdLApmHke9qSjsMIrKcQSTbrYcEbhu5WNIC0uWllN8MMYvnX
	 rb72vXYo1D8tBsbioB6muzIXCuykN5yyPcwtqskPX+40s441T9XNwZUZVPvLIi3rT6
	 +NiqevuUQFbRBNL7uO26nC5z67+Vq9lmgQXpMiioqkf2TtWqEOcPeMMLZeT7jOWh/e
	 NF8GRbmPKjJjgJkC64SRyhnDXmestzZsc7QJtzaTT4JTwKJT+xCfNTeGw/bQmz0m6f
	 laA9qva52Fsag==
Message-ID: <sashiko-outbox-195762@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v4 3/5] tls: update the RX key when a KeyUpdate
 is received
To: "Martin Belanger" <martin.nvme.dev@gmail.com>
Cc: linux-nvme@lists.infradead.org
In-Reply-To: <20261102-keyupdate-rfc-v4-3-f17419972b9f@gmail.com>
References: <20261102-keyupdate-rfc-v4-0-f17419972b9f@gmail.com>
 <20261102-keyupdate-rfc-v4-3-f17419972b9f@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 16:58:13 +0000
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
- [High] tls: uninitialized rec_seq in tls_keyupdate_rekey() union tmp
--

commit 9c6271bd7dbba966cda26fd41765d631c75ecd94
Author: Martin Belanger <martin.belanger@dell.com>

tls: update the RX key when a KeyUpdate is received

This commit updates kTLS RX processing so that when a socket with a
registered RX traffic secret receives a valid KeyUpdate message, the kernel
derives and installs the next RX key and consumes the KeyUpdate record
without passing it to the caller.

> diff --git a/net/tls/tls_keyupdate.c b/net/tls/tls_keyupdate.c
> new file mode 100644
> index 0000000000000..281c7b13eb82b
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

[Severity: High]
Does initializing tmp with {} leave the rec_seq portion of union
tls_crypto_context uninitialized when tls_check_pending_rekey() ->
tls_keyupdate_rx() -> tls_keyupdate_rekey() runs?

In include/net/tls.h, the first member of union tls_crypto_context is the
4-byte struct tls_crypto_info:

include/net/tls.h:
union tls_crypto_context {
	struct tls_crypto_info info;
	union {
		struct tls12_crypto_info_aes_gcm_128 aes_gcm_128;
		struct tls12_crypto_info_aes_gcm_256 aes_gcm_256;
		...
	};
};

On compilers without -fzero-init-padding-bits=3Dall (such as Clang or GCC <
15), initializing a union with {} only zero-initializes its first member (4
bytes) and leaves the remaining 52 bytes of union tail padding uninitialized
(or filled with 0xaa under CONFIG_INIT_STACK_ALL_PATTERN=3Dy).

Since tls_keyupdate_rekey() only writes info, key, salt, and iv into tmp
before calling tls_set_sw_offload(sk, tx, info), won't tls_set_sw_offload()
copy uninitialized or pattern-filled stack bytes from crypto_info_rec_seq()
into cctx->rec_seq and ctx->crypto_recv / ctx->crypto_send, causing
subsequent records to fail AEAD decryption with -EBADMSG and exposing stack
bytes via getsockopt(SOL_TLS, TLS_RX / TLS_TX)?

Should tls_keyupdate_rekey() zero tmp with memset(&tmp, 0, sizeof(tmp))
instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-keyupdate-=
rfc-v4-0-f17419972b9f@gmail.com?part=3D3

