Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44CD7606A321
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Nov 2026 12:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ZgXUmU3Y;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B/Z+YQF4
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=vJU0sEF+Sf67UUUq40QTrQSCmA2w1D+e29uVMjMQoaw=; b=ZgXUmU3YPqUVdlNVl+Rd1x6dxJ
	s2ZfWitx4hcp7G6TleVNl4TMsY5bHbTeDnIsng5QjrWdgYinYRE8Cl+J0NKF2abZYPOrbiLJbtg8U
	tCdo3GYqkDJ5wK2c3OtEii3ii5uypSkkFJvWi8k6DCa06FLIVdmdUnB9e7W2vj91Z+GXYPgK1WBtS
	BqW/MBWvZR2UaCyvZw65iMQG0AemWnXt10glfrdtKUMr1EQeLkOENxhpoZ5mBdSFcKNkZQHH/WYxT
	KXknZIsOMBguVFgxMIfQwAFXlmwdQdOwqLbE9FnR7QaUztuXbc5U+65ElyuAzT8M3N6H6dTM3OZVb
	qMqsSpvg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVTGd-00000003Nr9-40oJ;
	Mon, 23 Nov 2026 12:35:31 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVTGa-00000003NpG-3NS7
	for linux-nvme@lists.infradead.org;
	Mon, 23 Nov 2026 12:35:28 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 8FF1C40C41
	for <linux-nvme@lists.infradead.org>; Mon, 23 Nov 2026 12:35:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DE891F000C0;
	Mon, 23 Nov 2026 12:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795437328;
	bh=vJU0sEF+Sf67UUUq40QTrQSCmA2w1D+e29uVMjMQoaw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=B/Z+YQF4kb4pKE6TyC+Jc1XsDvCKAjxI7pTxA+H12FK16ezwmNQLecil9ZYdkw40S
	 ulrXjBXAhMOnIeqmu/rHDytSdeZDzdCilnd4CIJDGr4nk6IA7u78TUyFjKNVlLbwZ7
	 uP3gWXk9Zcyld1kclqlkMNnMLfyQJOT5jbchG0p1tTtblwIcf4RGao7waSVpuYZzkm
	 6Y3uj/WkhxQMckCJOuAT31i9Y31KU0prMSv/bmwBdJScaB5fHQDVdycCPqdScMmGlD
	 lb10GjelzlmczUxOqLpluopC5/JmIojOW7GI20EW2hg1rzGQiKhexmnChYsHYl9MVu
	 616MdV3zEqnOw==
Message-ID: <sashiko-outbox-229229@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/9] nvme-auth: switch to use 'struct key'
To: "Hannes Reinecke" <hare@kernel.org>
Cc: linux-nvme@lists.infradead.org
In-Reply-To: <20261123-dhchap-keyring-v4-v5-3-81eefb4c0724@kernel.org>
References: <20261123-dhchap-keyring-v4-v5-0-81eefb4c0724@kernel.org>
 <20261123-dhchap-keyring-v4-v5-3-81eefb4c0724@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 12:35:28 +0000
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

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [High] nvme-keyring: build failure in !CONFIG_NVME_KEYRING header
  stubs
- [High] nvme-auth: broken offset, payload leak, and -ENOKEY in key
  extraction
- [Low] nvme-auth: missing memzero_explicit() on error in
  nvme_auth_transform_key()
--

commit 784e3a15ff15feda9e4de8c374a9d16d4c147b86
Author: Hannes Reinecke <hare@kernel.org>

nvme-auth: switch to use 'struct key'

This commit switches NVMe in-band authentication to store DH-HMAC-CHAP keys
in struct key using the dhchap key type and removes struct nvme_dhchap_key.

> diff --git a/drivers/nvme/common/auth.c b/drivers/nvme/common/auth.c
> index 308af3d7c7383..ee26fb416ee62 100644
> --- a/drivers/nvme/common/auth.c
> +++ b/drivers/nvme/common/auth.c
[ ... ]
> @@ -317,11 +261,13 @@ static int nvme_auth_hash(u8 hmac_id, const u8 *dat=
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
> -	u8 *key_data;
> +	long key_len =3D 0;
> +	u8 *transformed_data;
> +	u8 *key_data, key_hash;
>  	size_t transformed_len;
>  	int ret;
> =20
> @@ -329,28 +275,64 @@ int nvme_auth_transform_key(const struct nvme_dhcha=
p_key *key, const char *nqn,
>  		pr_warn("No key specified\n");
>  		return -ENOKEY;
>  	}
> -	if (key->hash =3D=3D 0) {
> -		key_data =3D kzalloc(key->len, GFP_KERNEL);
> -		if (!key_data)
> -			return -ENOMEM;
> -		memcpy(key_data, key->key, key->len);
> -		*transformed_secret =3D key_data;
> -		return key->len;
> -	}
> -	ret =3D nvme_auth_hmac_init(&hmac, key->hash, key->key, key->len);
> -	if (ret)
> +	down_read(&key->sem);
> +	ret =3D key_validate(key);
> +	if (ret) {
> +		pr_warn("%s: key %08x invalidated\n",
> +			__func__, key_serial(key));
> +		up_read(&key->sem);
>  		return ret;
> -	transformed_len =3D nvme_auth_hmac_hash_len(key->hash);
> -	key_data =3D kzalloc(transformed_len, GFP_KERNEL);
> +	}
> +	key_len =3D user_read(key, NULL, 0);
> +	if (key_len <=3D 0) {
> +		pr_warn("failed to get length from key %08x: error %ld\n",
> +			key_serial(key), key_len);
> +		up_read(&key->sem);
> +		return key_len < 0 ? key_len : -ENOKEY;
> +	}
> +
> +	key_data =3D kzalloc(key_len, GFP_KERNEL);
>  	if (!key_data) {
> -		memzero_explicit(&hmac, sizeof(hmac));
> +		up_read(&key->sem);
>  		return -ENOMEM;
>  	}
> +	ret =3D user_read(key, (char *)key_data, key_len);
> +	key_hash =3D nvme_dhchap_psk_hash(key);
> +	up_read(&key->sem);
> +	if (ret !=3D key_len) {
> +		if (ret < 0) {
> +			pr_warn("failed to read from key %08x: error %d\n",
> +				key_serial(key), ret);
> +		} else {
> +			pr_warn("only read %d of %ld bytes from key %08x\n",
> +				ret, key_len, key_serial(key));
> +			ret =3D -ENOKEY;
> +		}
> +		goto out_free_data;
> +	}
> +	if (key_hash =3D=3D 0) {
> +		*transformed_secret =3D key_data;
> +		return key_len;
> +	}
> +
> +	ret =3D nvme_auth_hmac_init(&hmac, key_hash, key_data, key_len);
> +	if (ret)
> +		goto out_free_data;
> +	transformed_len =3D nvme_auth_hmac_hash_len(key_hash);
> +	transformed_data =3D kzalloc(transformed_len, GFP_KERNEL);
> +	if (!transformed_data) {
> +		ret =3D -ENOMEM;
> +		goto out_free_data;
> +	}

[Severity: Low]
Does the !transformed_data error path leave key-derived state in hmac on
the stack?  Before this patch, failing to allocate the output buffer after
nvme_auth_hmac_init() called memzero_explicit(&hmac, sizeof(hmac)) because
nvme_auth_hmac_final() is not reached to zeroize the context.

> diff --git a/drivers/nvme/common/keyring.c b/drivers/nvme/common/keyring.c
> index d0c36d153afdb..08e2a8e39faac 100644
> --- a/drivers/nvme/common/keyring.c
> +++ b/drivers/nvme/common/keyring.c
> @@ -481,6 +481,104 @@ static struct key_type nvme_dhchap_psk_key_type =3D=
 {
>  	.read           =3D nvme_dhchap_psk_read,
>  };
> =20
> +/**
> + * nvme_dhchap_psk_create - Create DH-HMAC-CHAP key
> + * @keyring: keyring for the new key or NULL for the default keyring
> + * @data: Key data
> + * @data_len: Length of @data
> + *
> + * Creates a new DH-HMAC-CHAP key with a random UUID as the key identity.
> + * Returns the new key or an error pointer on failure.
> + */
> +struct key *nvme_dhchap_psk_create(struct key *keyring,
> +		const char *data, size_t data_len)
> +{
> +	key_perm_t keyperm =3D
> +		KEY_POS_SEARCH | KEY_POS_VIEW | KEY_POS_READ |
> +		KEY_POS_WRITE | KEY_POS_LINK | KEY_POS_SETATTR |
> +		KEY_USR_SEARCH | KEY_USR_VIEW | KEY_USR_READ;
> +	char *identity;
> +	key_ref_t keyref;
> +	key_serial_t keyring_id;
> +	struct key *key;
> +	uuid_t key_uuid;
> +
> +	if (data =3D=3D NULL || !data_len)
> +		return ERR_PTR(-EINVAL);
> +
> +	generate_random_uuid(key_uuid.b);
> +	identity =3D kasprintf(GFP_KERNEL, "%pU", &key_uuid);
> +	if (!identity)
> +		return ERR_PTR(-ENOMEM);
> +	if (!keyring)
> +		keyring =3D nvme_keyring;
> +	keyring_id =3D key_serial(keyring);
> +
> +	pr_debug("keyring %x generate dhchap psk '%s'\n",
> +		 keyring_id, identity);
> +	keyref =3D key_create(make_key_ref(keyring, true),
> +			    "dhchap", identity, data, data_len,
> +			    keyperm, KEY_ALLOC_NOT_IN_QUOTA |
> +			    KEY_ALLOC_BUILT_IN |
> +			    KEY_ALLOC_BYPASS_RESTRICTION);
> +	if (IS_ERR(keyref)) {
> +		pr_warn("refresh dhchap psk '%s' failed, error %ld\n",
> +			identity, PTR_ERR(keyref));
> +		kfree(identity);
> +		return ERR_PTR(-ENOKEY);
> +	}

[Severity: High]
Routing nvme_auth_extract_key() through nvme_dhchap_psk_create() and
nvme_dhchap_psk_preparse() introduces several regressions when parsing or
rejecting DH-HMAC-CHAP secrets:

drivers/nvme/common/keyring.c:nvme_dhchap_psk_preparse() {
	...
	if (sscanf(prep->data, "DHHC-%01hhu:%02hhu:%n",
		   &version, &hmac, &offset) !=3D 2 || !offset) {
	...
	/* skip header and final ':' character */
	datalen =3D strlen(prep->data + offset);
	p =3D strrchr(prep->data + offset, ':');
	if (p)
		datalen--;
	...
	prep->payload.data[0] =3D upayload;
	ret =3D base64_decode(prep->data + 10, datalen, upayload->data,
			    true, BASE64_STD);
	if (ret < 0) {
		pr_debug("%s: Failed to decode key %s\n",
			 __func__, (char *)prep->data + 10);
		prep->payload.data[0] =3D NULL;
		return ret;
	}
	if (ret !=3D 36 && ret !=3D 52 && ret !=3D 68) {
		pr_debug("%s: invalid decoded key size '%d'\n",
			 __func__, ret);
		prep->payload.data[0] =3D NULL;
		return -EINVAL;
	}
	ret -=3D 4;
	crc =3D ~crc32(~0, upayload->data, ret);
	if (get_unaligned_le32(upayload->data + ret) !=3D crc) {
		pr_debug("%s: CRC mismatch for key\n", __func__);
		/* CRC mismatch */
		prep->payload.data[0] =3D NULL;
		return -EKEYREJECTED;
	}
	...
}

Does base64_decode() fail on secrets with a single-digit hash ID (such as
"DHHC-1:0:...") and leak upayload on error?

With a 1-digit hash ID, offset is 9, so hardcoding prep->data + 10 skips
the first base64 character and reads one byte past the end of the payload.
When base64_decode(), the decoded length check, or the CRC check fails,
setting prep->payload.data[0] =3D NULL before returning prevents
user_free_preparse() from freeing upayload, leaking it on every rejected
key.

In addition, prep->data is passed to sscanf(), strlen(), and strrchr()
without bounding to prep->datalen (and with offset uninitialized if the
colon after the hash ID is omitted), "if (p) datalen--" only subtracts 1
instead of truncating at p when a trailing newline follows ':', and
nvme_dhchap_psk_create() overwrites the error from key_create() with
-ENOKEY.

> diff --git a/include/linux/nvme-keyring.h b/include/linux/nvme-keyring.h
> index ab8971afa9734..a2ba7588e2d73 100644
> --- a/include/linux/nvme-keyring.h
> +++ b/include/linux/nvme-keyring.h
> @@ -18,12 +18,18 @@ key_serial_t nvme_tls_psk_default(struct key *keyring,
> =20
>  key_serial_t nvme_keyring_id(void);
>  struct key *nvme_tls_key_lookup(key_serial_t key_id);
> +
> +struct key *nvme_dhchap_psk_create(struct key *keyring,
> +		const char *data, size_t data_len);
> +struct key *nvme_dhchap_psk_lookup(struct key *keyring, const char *iden=
tity);
> +u8 nvme_dhchap_psk_hash(struct key *key);
> +
>  #else
>  static inline struct key *nvme_tls_psk_refresh(struct key *keyring,
> -		const char *hostnqn, char *subnqn, u8 hmac_id,
> +		const char *hostnqn, const char *subnqn, *data, u8 hmac_id,
>  		u8 *data, size_t data_len, const char *digest)
>  {
> -	return ERR_PTR(-ENOTSUPP);
> +	return ERR_PTR(-EOPNOTSUPP);
>  }
>  static inline key_serial_t nvme_tls_psk_default(struct key *keyring,
>  		const char *hostnqn, const char *subnqn)
> @@ -36,7 +42,21 @@ static inline key_serial_t nvme_keyring_id(void)
>  }
>  static inline struct key *nvme_tls_key_lookup(key_serial_t key_id)
>  {
> -	return ERR_PTR(-ENOTSUPP);
> +	return ERR_PTR(-EOPNOTSUPP);
> +}
> +static inline struct key *nvme_dhchap_psk_create(struct key *keyring,
> +		const char *data, size_t data_len)
> +{
> +	return ERR_PTR(-EOPNOTSUPP);
> +}
> +static inline struct key *nvme_dhchap_psk_lookup(struct key *keyring,
> +		const char *identity)
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
As reported by kernel test robot on v4 [1], does this break the build when
CONFIG_NVME_KEYRING is disabled?  The !CONFIG_NVME_KEYRING stub for
nvme_tls_psk_refresh() has a stray untyped *data parameter before hmac_id,
and nvme_dhchap_psk_hash() is defined in the header without static inline,
causing multiple-definition linker errors across translation units that
include linux/nvme-keyring.h.

[1] https://lore.kernel.org/r/202611210318.EedT1DJk-lkp@intel.com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123-dhchap-key=
ring-v4-v5-0-81eefb4c0724@kernel.org?part=3D3

