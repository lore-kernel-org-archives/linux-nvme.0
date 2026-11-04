Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79670606E831
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Nov 2026 21:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=MjxRgceZ;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XbV1rfK4
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=FYzTDgZyD8KYlbYKTcTatY816C0xIeXkcL3yySf9i9E=; b=MjxRgceZmW5HCQLky9TytJJsQO
	ZMdQjWUbs2q53RqEB0HD7N7j/D1qJfjEluvLsvA38KmDaXA5a/+LVMQ2zG80tFczwTTKBXMhSJOEM
	z4wRsBTIxXwCjiSrF0oGgbVHqCu/cC5XAYEYPhtqAwpeIhLszj2UyJCD6Y6hb6lxX8GSo8mAGEIa6
	PW7QSxaRlNVkzemNZJKOTLGin1fjbGwsipYmblMi/4p5X1gN4LdEavXY3y+eCrHCa7KJ7W/OU9FTl
	olN4+EzQW2wMHYqbnQ+kqzNzoxQ1nuHKv3/bVvMU9vAyNIVuJIY2xdBsQgHhLS1DPUaXO+ZsVynmQ
	DaPk22uQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOilk-0000000750m-3LBZ;
	Wed, 04 Nov 2026 21:43:44 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOilk-0000000750b-0Kfh
	for linux-nvme@lists.infradead.org;
	Wed, 04 Nov 2026 21:43:44 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 433B360F19;
	Wed,  4 Nov 2026 21:43:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3D7A1F000C1;
	Wed,  4 Nov 2026 21:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793828623;
	bh=FYzTDgZyD8KYlbYKTcTatY816C0xIeXkcL3yySf9i9E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XbV1rfK4phByVgKqx0pxLBhvw8oJ1NAtmCdC/m0Z3UFZh/Gat/A6BqAK9/Bt2K4Ca
	 pM5XZ9GBOsZgs+1z3MtU+JIKVLaz/KMzXixtzOA/agOIPCh5WJgd7jyO0+wuU3Za5s
	 by/hbfpCpUgGgfinhLMs0+T/nEehD1jw0ga8H3qk7Ig77HIkLeN57A+hamtjow2ehp
	 tB0Ft39xXiG+M/gkGxd2YjQ56fUbJUlZy3kNLtYKAR9x0Rz6Hg6+mB+Y6yJLzygPPy
	 gC7o6IvZ4ERlJfEuzbrGimF7WmchfT15euHQ+IWSQDsKxyd+ahFZGRRs5YdtRe62fM
	 JwtxGvzXc1zNg==
Message-ID: <sashiko-outbox-198140@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v5 4/6] tls: update the RX key when a KeyUpdate
 is received
To: "Martin Belanger" <martin.nvme.dev@gmail.com>
Cc: linux-nvme@lists.infradead.org
In-Reply-To: <20261103-keyupdate-rfc-v5-4-de1ab90a88d5@gmail.com>
References: <20261103-keyupdate-rfc-v5-0-de1ab90a88d5@gmail.com>
 <20261103-keyupdate-rfc-v5-4-de1ab90a88d5@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 21:43:42 +0000
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
- [High] tls: FORTIFY_SOURCE field-spanning write warning in tls_keyupdate_=
rekey()
--

commit 0485598776b0569167bc509b38a622743e5ca7ce
Author: Martin Belanger <martin.belanger@dell.com>

tls: update the RX key when a KeyUpdate is received

This commit updates kTLS to derive and install the next RX key automatically
when a KeyUpdate handshake message is received on a socket with a registered
RX traffic secret. It also validates the KeyUpdate message format and rate
limits incoming KeyUpdate messages to at most 8 per second.

> diff --git a/net/tls/tls_keyupdate.c b/net/tls/tls_keyupdate.c
> new file mode 100644
> index 0000000000000..b9e1ecfc59c47
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
> +	union tls_crypto_context tmp;
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
> +	memset(&tmp, 0, sizeof(tmp));
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

[Severity: High]
Won't these memcpy() calls trigger a CONFIG_FORTIFY_SOURCE field-spanning
write warning when tls_check_pending_rekey() -> tls_keyupdate_rx() ->
tls_keyupdate_rekey() runs on a socket with a registered traffic secret?

In tls_keyupdate_rekey(), info is initialized as &tmp.info, which points to
the 4-byte struct tls_crypto_info subobject inside union tls_crypto_context
tmp.

The inlined helpers crypto_info_salt() and crypto_info_iv() offset from info
past the end of that 4-byte member:

net/tls/tls.h:
static inline char *crypto_info_iv(struct tls_crypto_info *crypto_info,
				   const struct tls_cipher_desc *cipher_desc)
{
	return (char *)crypto_info + cipher_desc->iv_offset;
}

static inline char *crypto_info_salt(struct tls_crypto_info *crypto_info,
				     const struct tls_cipher_desc *cipher_desc)
{
	return (char *)crypto_info + cipher_desc->salt_offset;
}

Because the destination pointer is derived from the union member &tmp.info
rather than the enclosing union tmp, __member_size() evaluates to 0 while
__struct_size() evaluates to the remaining space in tmp, causing fortified
memcpy() to warn on a field-spanning write.

This is the same union subobject bounds issue that commit c43c1c24f3cd ("tl=
s:
avoid field-spanning write when copying crypto info") fixed in
do_tls_setsockopt_conf(). Could the destination offset be computed from &tmp
(or could crypto_info_salt() and crypto_info_iv() take union
tls_crypto_context *) to avoid the FORTIFY_SOURCE warning?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-keyupdate-=
rfc-v5-0-de1ab90a88d5@gmail.com?part=3D4

