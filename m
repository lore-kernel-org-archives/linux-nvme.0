Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC76760A3826
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Nov 2026 11:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=lttmPJ6K;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Va6JdU36
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=i0QoffjqAF++hzTjLnkFki50xv+US9viUHj4MIp1xY0=; b=lttmPJ6KWf1koJMxiswolNaa+l
	OdPLOOVhW3XsnBDR+0kAjBRXff+ZjvxXbSLPvmzGvncBnSE90a8mDF9Ql9InKgTwLB59l/1JPZ0iX
	VsFw4CXz0kuPvTgYSDWsUaeug11BnxUHwDCvSGx8rBGhao+rrTzAO6ATy87AVbc8m/2tk6cX9PNEK
	9odEQdkNiO4u6s7WaxvgG52nd4kGHtUfLFLneYcSn77IHSv/ZDQQYsR+rWEVnXbv9lIV0KFq+7xF0
	GlE42FdvWlcrhShXcqI8El7cDU7BzOtZsbviTP1TaRiiUAyS5X//4q5IxOY+j0lm0+ImBxIOlBUzL
	sREZchHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUMqB-0000000EoEp-0mFh;
	Fri, 20 Nov 2026 11:31:39 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUMq6-0000000EoEM-0dqN
	for linux-nvme@lists.infradead.org;
	Fri, 20 Nov 2026 11:31:34 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 88E0C628C5
	for <linux-nvme@lists.infradead.org>; Fri, 20 Nov 2026 11:31:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13BB91F000D8;
	Fri, 20 Nov 2026 11:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795174293;
	bh=i0QoffjqAF++hzTjLnkFki50xv+US9viUHj4MIp1xY0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Va6JdU36+mODEMViWADSO7PDWLBAoSoXDnW8zHp8RYcoIwtFNxKPCT1i8HMEOzDkk
	 D0dF0pcImTlzfaqrzBGBlNY3US9WpEoG8P01vuCs99LV91CKkmndSui8r6UOvq0m9s
	 h9qsa5XdclZxTfSxAiI8CvUr0F7NkTLwm+2s1YFbT1SUFVN3bBPvPBBXWPGpuIrNJf
	 AbMD91bem44fBLPJCybXPKzTSkDLug0hw4Pn+pgE+tPr4dNHxHuxo7iszTSoTAYtKh
	 B38Xv/AYqq4qIaGHgAb/sxLFat8EV05jQg52UrBeZYljclKHghfLysVfuBXvU4HDhc
	 /6BIdw1i3VbRQ==
Message-ID: <sashiko-outbox-225045@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/9] nvme-auth: switch to use 'struct key'
To: "Hannes Reinecke" <hare@kernel.org>
Cc: linux-nvme@lists.infradead.org
In-Reply-To: <20261120-dhchap-keyring-v4-v4-3-5f8c7d9926ee@kernel.org>
References: <20261120-dhchap-keyring-v4-v4-0-5f8c7d9926ee@kernel.org>
 <20261120-dhchap-keyring-v4-v4-3-5f8c7d9926ee@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 11:31:32 +0000
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

Thank you for your contribution! Sashiko AI review found 4 potential
issues to consider:
- [High] nvme-keyring: build failure and mismatched stubs when
  !CONFIG_NVME_KEYRING
- [High] nvme-auth: missing key length validation in
  nvme_auth_extract_key()
- [Low] nvme-auth: missing kernel-doc param and leftover struct
  nvme_dhchap_key
- [Low] nvme-auth: pointer signedness mismatches in key extraction and
  reading
--

commit ee0a57ee4ed46fe92599175ec65168d3ebd0acca
Author: Hannes Reinecke <hare@kernel.org>

nvme-auth: switch to use 'struct key'

This commit replaces struct nvme_dhchap_key with struct key using the
dhchap key type across the NVMe common, host, and target authentication
code.

> diff --git a/drivers/nvme/common/auth.c b/drivers/nvme/common/auth.c
> index 569f21ad4fc7e..b7092deed9b06 100644
> --- a/drivers/nvme/common/auth.c
> +++ b/drivers/nvme/common/auth.c
[ ... ]
> -struct nvme_dhchap_key *nvme_auth_extract_key(const char *secret, u8 key=
_hash)
> +/**
> + * nvme_auth_extract_key - extract the DH-HMAC-CHAP key
> + *
> + * @secret: key data
> + * @secret_len: length of @secret
> + *
> + * Extracts a dhchap key from @secret.
> + *
> + * Returns the dhchap key or an error pointer on failure.
> + */
> +struct key *nvme_auth_extract_key(struct key *keyring, const char *secre=
t,
> +				  size_t secret_len)
>  {
> -	struct nvme_dhchap_key *key;
> -	const char *p;
> -	u32 crc;
> -	int ret, key_len;
> -	size_t allocated_len =3D strlen(secret);
> -
> -	/* Secret might be affixed with a ':' */
> -	p =3D strrchr(secret, ':');
> -	if (p)
> -		allocated_len =3D p - secret;
> -	key =3D nvme_auth_alloc_key(allocated_len, 0);
> -	if (!key)
> -		return ERR_PTR(-ENOMEM);
> -
> -	key_len =3D base64_decode(secret, allocated_len, key->key, true, BASE64=
_STD);
> -	if (key_len < 0) {
> -		pr_debug("base64 key decoding error %d\n",
> -			 key_len);
> -		ret =3D key_len;
> -		goto out_free_key;
> -	}
> +	struct key *key;
> =20
> -	if (key_len !=3D 36 && key_len !=3D 52 &&
> -	    key_len !=3D 68) {
> -		pr_err("Invalid key len %d\n", key_len);
> -		ret =3D -EINVAL;
> -		goto out_free_key;
> +	key =3D nvme_dhchap_psk_create(keyring, secret, secret_len);
> +	if (!IS_ERR(key)) {
> +		pr_debug("generated dhchap key %s\n",
> +			 key->description);
>  	}
> -
> -	/* The last four bytes is the CRC in little-endian format */
> -	key_len -=3D 4;
> -	/*
> -	 * The linux implementation doesn't do pre- and post-increments,
> -	 * so we have to do it manually.
> -	 */
> -	crc =3D ~crc32(~0, key->key, key_len);
> -
> -	if (get_unaligned_le32(key->key + key_len) !=3D crc) {
> -		pr_err("key crc mismatch (key %08x, crc %08x)\n",
> -		       get_unaligned_le32(key->key + key_len), crc);
> -		ret =3D -EKEYREJECTED;
> -		goto out_free_key;
> -	}
> -	key->len =3D key_len;
> -	key->hash =3D key_hash;
>  	return key;
> -out_free_key:
> -	nvme_auth_free_key(key);
> -	return ERR_PTR(ret);
>  }
>  EXPORT_SYMBOL_GPL(nvme_auth_extract_key);

[Severity: High]
Does replacing the parser here with nvme_dhchap_psk_create() ->
key_create() -> nvme_dhchap_psk_preparse() drop the decoded key length and
prefix length checks, allowing an out-of-bounds read in crc32()?

drivers/nvme/common/keyring.c:nvme_dhchap_psk_preparse() {
	...
	if (sscanf(prep->data, "DHHC-%01hhu:%02hhu:%*s",
		   &version, &hmac) !=3D 2) {
	...
	}

	/* skip header and final ':' character */
	datalen -=3D 11;
	...
	/* decode the data */
	prep->quotalen =3D keylen;
	prep->payload.data[0] =3D upayload;
	ret =3D base64_decode(prep->data + 10, datalen, upayload->data,
			    true, BASE64_STD);
	if (ret < 0) {
		...
		return ret;
	}
	ret -=3D 4;
	crc =3D ~crc32(~0, upayload->data, ret);
	if (get_unaligned_le32(upayload->data + ret) !=3D crc) {
	...
}

nvme_dhchap_psk_preparse() does not verify that ret is 36, 52, or 68
before subtracting 4, so a secret whose base64 body decodes to 0..3 bytes
(such as "DHHC-1:00:AAAA:") makes ret negative and passes a huge size_t to
crc32(), reading past upayload->data across kernel memory, while other
invalid decoded sizes are accepted.

A 1-digit hash ID also satisfies sscanf(), so a 10-byte secret such as
"DHHC-1:0:a" underflows datalen -=3D 11 to SIZE_MAX (or has its first base64
character skipped by prep->data + 10), and prep->quotalen is assigned from
the uninitialized local variable keylen.  In addition,
nvme_dhchap_psk_create() replaces PTR_ERR(keyref) with ERR_PTR(-ENOKEY) on
key_create() failure instead of propagating -EINVAL, -EKEYREJECTED, or
-ENOMEM.

Finally, dhchap_secret_store() and dhchap_ctrl_secret_store() pass raw
count (including any trailing newline) to nvme_auth_extract_key(), leaving
the trailing ':' in the base64 input; later commits "nvme: parse dhchap
keys during option parsing" and "nvme: allow to pass in key description as
dhchap secret" in the series address the sysfs newline handling, while the
nvme_dhchap_psk_preparse() validation defects and error code clobbering
remain.

[ ... ]

> @@ -317,12 +260,13 @@ static int nvme_auth_hash(u8 hmac_id, const u8 *dat=
a, size_t data_len, u8 *out)
>  	return -EINVAL;
>  }
> =20
> -int nvme_auth_transform_key(const struct nvme_dhchap_key *key, const cha=
r *nqn,
> +int nvme_auth_transform_key(struct key *key, const char *nqn,
>  			    u8 **transformed_secret)
>  {
>  	struct nvme_auth_hmac_ctx hmac;
> +	long key_len =3D 0;
>  	u8 *transformed_data;
> -	u8 *key_data;
> +	u8 *key_data, key_hash;
[ ... ]
> +	key_data =3D kzalloc(key_len, GFP_KERNEL);
> +	if (!key_data) {
> +		up_read(&key->sem);
> +		return -ENOMEM;
> +	}
> +	ret =3D user_read(key, key_data, key_len);

[Severity: Low]
Does passing u8 *key_data to user_read() (which expects char *buffer)
trigger a -Wpointer-sign compiler warning?

Similar pointer-signedness mismatches occur in nvme_auth_extract_key() when
passing const char *secret to const u8 *data of nvme_dhchap_psk_create(),
and in nvmet_setup_auth() when passing u8 * host->dhchap_secret and
host->dhchap_ctrl_secret to strlen() and nvme_auth_extract_key().

> diff --git a/include/linux/nvme-auth.h b/include/linux/nvme-auth.h
> index 1c5ce635b169d..b8ea0945131d1 100644
> --- a/include/linux/nvme-auth.h
> +++ b/include/linux/nvme-auth.h
> @@ -37,13 +37,10 @@ void nvme_auth_hmac_update(struct nvme_auth_hmac_ctx =
*hmac, const u8 *data,
>  			   size_t data_len);
>  void nvme_auth_hmac_final(struct nvme_auth_hmac_ctx *hmac, u8 *out);
> =20
> -u32 nvme_auth_key_struct_size(u32 key_len);
> -struct nvme_dhchap_key *nvme_auth_extract_key(const char *secret, u8 key=
_hash);
> -void nvme_auth_free_key(struct nvme_dhchap_key *key);
> -struct nvme_dhchap_key *nvme_auth_alloc_key(u32 len, u8 hash);
> -int nvme_auth_transform_key(const struct nvme_dhchap_key *key,
> -			    const char *nqn, u8 **transformed_secret);
> -int nvme_auth_parse_key(const char *secret, struct nvme_dhchap_key **ret=
_key);
> +struct key *nvme_auth_extract_key(struct key *keyring, const char *secre=
t,
> +				  size_t secret_len);

[Severity: Low]
The commit message notes that the unused struct nvme_dhchap_key definition
can be dropped, but struct nvme_dhchap_key is still present at the top of
include/linux/nvme-auth.h.  Also, the new kernel-doc comment on
nvme_auth_extract_key() in drivers/nvme/common/auth.c omits @keyring, which
causes a W=3D1 kernel-doc warning.

> diff --git a/include/linux/nvme-keyring.h b/include/linux/nvme-keyring.h
> index ab8971afa9734..9fef4b6add787 100644
> --- a/include/linux/nvme-keyring.h
> +++ b/include/linux/nvme-keyring.h
> @@ -18,12 +18,17 @@ key_serial_t nvme_tls_psk_default(struct key *keyring,
> =20
>  key_serial_t nvme_keyring_id(void);
>  struct key *nvme_tls_key_lookup(key_serial_t key_id);
> +
> +struct key *nvme_dhchap_psk_create(struct key *keyring,
> +		const u8 *data, size_t data_len);
> +struct key *nvme_dhchap_psk_lookup(struct key *keyring, const char *iden=
tity);
> +u8 nvme_dhchap_psk_hash(struct key *key);
> +
>  #else
>  static inline struct key *nvme_tls_psk_refresh(struct key *keyring,
> -		const char *hostnqn, char *subnqn, u8 hmac_id,
>  		u8 *data, size_t data_len, const char *digest)
>  {
> -	return ERR_PTR(-ENOTSUPP);
> +	return ERR_PTR(-EOPNOTSUPP);
>  }
>  static inline key_serial_t nvme_tls_psk_default(struct key *keyring,
>  		const char *hostnqn, const char *subnqn)
> @@ -36,7 +41,22 @@ static inline key_serial_t nvme_keyring_id(void)
>  }
>  static inline struct key *nvme_tls_key_lookup(key_serial_t key_id)
>  {
> -	return ERR_PTR(-ENOTSUPP);
> +	return ERR_PTR(-EOPNOTSUPP);
> +}
> +static inline struct key *nvme_dhchap_psk_refresh(struct key *keyring,
> +		const char *hostnqn, const char *subnqn,
> +		u8 *data, size_t data_len)
> +{
> +	return ERR_PTR(-EOPNOTSUPP);
> +}
> +static inline struct key *nvme_dhchap_psk_lookup(struct key *keyring,
> +		const char *hostnqn, const char *subnqn, u8 hmac);
> +{
> +	return ERR_PTR(-EOPNOTSUPP);
> +}
> +u8 nvme_dhchap_psk_hash(struct key *key)
> +{
> +	return 0;
>  }
>  #endif /* !CONFIG_NVME_KEYRING */
>  #endif /* _NVME_KEYRING_H */

[Severity: High]
Does the !CONFIG_NVME_KEYRING branch fail to build when
include/linux/nvme-keyring.h is included with CONFIG_NVME_KEYRING disabled?

The nvme_dhchap_psk_lookup() stub has a stray semicolon after its parameter
list and takes four arguments instead of matching the two-argument
declaration in the CONFIG_NVME_KEYRING branch.  nvme_dhchap_psk_hash() is
defined in the header without static inline, causing multiple-definition
linker errors across translation units.  This branch also defines
nvme_dhchap_psk_refresh() instead of a stub for nvme_dhchap_psk_create(),
and removes hostnqn, subnqn, and hmac_id from the nvme_tls_psk_refresh()
stub signature.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120-dhchap-key=
ring-v4-v4-0-5f8c7d9926ee@kernel.org?part=3D3

