Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FFD606A337
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Nov 2026 14:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=dKYCYn1v;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iw3kXYoD
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=UreJkIbM0MfAG0/49/W8Hu2Bt/8whRZRXJquVtgT36s=; b=dKYCYn1vbm2tMiAC2mWj+pAVIt
	Yqfpu+5hHtv62+YyIuP78+GiZj5+pVWnyAev2slzmUuRVmoCZlKvfYtydPZ36Wtxq8mCKOa3kTJsM
	csxyhxexityACYHViUiqUQpwPhj/pTO7gUScFzYZmWXrTEMv4V93JpihznP8qC8GNRsbv7FwF5dTf
	hvgDtVXCPMlKb6AaqyPGLl3+n+aIGfK9NVGWoHfA3U8YBlgeEn9ouqRnlRWMP/oRZ3TuagZs8FBJX
	7RJZcS8LPdN6zcfPAhKlvOWP6ZiNu07rvzRc4zzidMNUo8Hz9n+I9VMhkl+YQQ2w6mLvAUvo4KoBy
	4OVyT4eA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWaWY-0000000DZU3-2bxq;
	Thu, 26 Nov 2026 14:32:34 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWaWX-0000000DZTA-0CgO
	for linux-nvme@lists.infradead.org;
	Thu, 26 Nov 2026 14:32:33 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id C8F374388F;
	Thu, 26 Nov 2026 14:32:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0E1F1F00A36;
	Thu, 26 Nov 2026 14:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795703552;
	bh=UreJkIbM0MfAG0/49/W8Hu2Bt/8whRZRXJquVtgT36s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iw3kXYoD4ZgZ5vQxFrxxRewD5yzJ5K2dn0czNGCsMw/OdtfEKtEtnMtSwn8LX/KCc
	 x3upltUeySRXVrkrFKFQX6o9jwA2yR7Vsr8hw8PD1Y0wLjwhdQnXk3e6WLtDHokoQz
	 60uG8j/Zt6fXT1STztSOxN3p9MlRyLPAGfQ2m3ooXoygcubx3nalIpQGECiOv57lGq
	 kjVZMjQIaMxIs7T7B6jMJcep5ZKCHSsx+zU3R01aCSaqFz6yET4xWSQ8+TXbPVTOow
	 vpBvOUebmSUw/8J4pXiPiYtLOeYYcNLTJaVev+/mQIR1nepHmiq5VUJuUcwtHtcjjO
	 9XVzjLs9lJJwQ==
Message-ID: <sashiko-outbox-235714@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 02/14] nvme-keyring: add 'dhchap' key type
To: "Hannes Reinecke" <hare@kernel.org>, "Keith Busch" <kbusch@kernel.org>, "Jens
 Axboe" <axboe@kernel.dk>, "Christoph Hellwig" <hch@lst.de>, "Sagi Grimberg" <sagi@grimberg.me>, "Hannes
 Reinecke" <hare@suse.de>, "Chaitanya Kulkarni" <kch@nvidia.com>, "Eric
 Biggers" <ebiggers@kernel.org>, "David Howells" <dhowells@redhat.com>, "Jarkko
 Sakkinen" <jarkko@kernel.org>, "Jonathan Corbet" <corbet@lwn.net>, "Shuah
 Khan" <skhan@linuxfoundation.org>, "Randy Dunlap" <rdunlap@infradead.org>, "Kees
 Cook" <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-nvme@lists.infradead.org, keyrings@vger.kernel.org
In-Reply-To: <20261126-dhchap-keyring-v4-v7-2-ee438ffea527@kernel.org>
References: <20261126-dhchap-keyring-v4-v7-0-ee438ffea527@kernel.org>
 <20261126-dhchap-keyring-v4-v7-2-ee438ffea527@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 14:32:31 +0000
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

Thank you for your contribution! Sashiko AI review found 5 potential
issues to consider:
- [Critical] nvme-keyring: out-of-bounds read in
  nvme_dhchap_psk_preparse() via sscanf()
- [Medium] nvme-keyring: nvme_dhchap_psk_read() returns -EINVAL when
  buflen < keylen
- [Medium] nvme-keyring: missing .update callback in
  nvme_dhchap_psk_key_type
- [Low] nvme-keyring: inverted kernel-doc for
  nvme_dhchap_encoded_key_size()
- [Low] nvme-keyring: unbounded kzalloc() in nvme_dhchap_psk_preparse()
--

commit 96ec6bac915bae99bd1eb311a1d2b97cd0c724f7
Author: Hannes Reinecke <hare@kernel.org>

nvme-keyring: add 'dhchap' key type

This commit registers a new dhchap key type to store DH-HMAC-CHAP secret
keys with a user-type compatible payload and base64 read formatting.

> diff --git a/drivers/nvme/common/keyring.c b/drivers/nvme/common/keyring.c
> index 87cb51e1f5a7f..de8dab10fa105 100644
> --- a/drivers/nvme/common/keyring.c
> +++ b/drivers/nvme/common/keyring.c
[ ... ]
> @@ -253,6 +256,205 @@ key_serial_t nvme_tls_psk_default(struct key *keyri=
ng,
>  }
>  EXPORT_SYMBOL_GPL(nvme_tls_psk_default);
> =20
> +static void nvme_dhchap_psk_describe(const struct key *key, struct seq_f=
ile *m)
> +{
> +	seq_puts(m, key->description);
> +	seq_printf(m, ": %u", key->datalen);
> +}
> +
> +/**
> + * nvme_dhchap_psk_preparse - prepare DH-HMAC-CHAP key data
> + * @prep: preparsed payload of the key data
> + *
> + * Decode the DH-HMAC-CHAP key data passed in @prep and
> + * store the resulting binary data. The binary data includes
> + * space for the CRC, the version, and the hmac identifier,
> + * but the data length is just the key data without the CRC.
> + * This allows the user to read the key data via the
> + * 'user_read()' function. The additional 'version' ahd 'hmac'
> + * data is used in the ->read() callback to generate the
> + * base64 encoded key.
> + */
> +static int nvme_dhchap_psk_preparse(struct key_preparsed_payload *prep)
> +{
> +	struct user_key_payload *upayload;
> +	size_t datalen =3D prep->datalen;
> +	int ret =3D -EINVAL, offset =3D 0;
> +	char *p;
> +	u32 crc;
> +	u8 version, hmac;
> +
> +	if (!prep->data || prep->datalen < 10) {
> +		pr_debug("%s: Invalid key data", __func__);
> +		goto out_err;
> +	}
> +	if (sscanf(prep->data, "DHHC-%01hhu:%02hhu:%n",
> +		   &version, &hmac, &offset) !=3D 2 || offset !=3D 10) {
> +		pr_debug("%s: invalid key header\n", __func__);
> +		goto out_err;
> +	}

[Severity: Critical]
As reported by Martin Belanger on v5 [1], can sscanf() read past the end
of prep->data?

add_key() copies plen bytes from userspace into prep->data without
appending a NUL terminator:

security/keys/keyctl.c:SYSCALL_DEFINE5(add_key) {
    ...
		payload =3D kvmalloc(plen, GFP_KERNEL);
		if (!payload)
			goto error2;

		ret =3D -EFAULT;
		if (copy_from_user(payload, _payload, plen) !=3D 0)
			goto error3;
    ...
}

Inside vsscanf(), each integer conversion calls skip_spaces() before
parsing digits, which scans until a NUL byte and ignores prep->datalen.
A non-NUL-terminated payload of 10 or more bytes starting with "DHHC-"
or "DHHC-1:" followed by whitespace causes an out-of-bounds kernel memory
read before the offset check runs.

> +
> +	if (version !=3D 1 || hmac > 3) {
> +		pr_debug("%s: invalid key version\n", __func__);
> +		goto out_err;
> +	}
> +
> +	/* skip header and final ':' character */
> +	if (offset > prep->datalen) {
> +		pr_debug("%s: invalid key data\n", __func__);
> +		goto out_err;
> +	}
> +	datalen =3D prep->datalen - offset;
> +	p =3D memchr(prep->data + offset, ':', datalen);
> +	if (p) {
> +		datalen =3D (p - (char *)prep->data);
> +		datalen -=3D offset;
> +	}
> +
> +	/*
> +	 * payload is < key | version | hmac >
> +	 * base64 decode will always return less data
> +	 * than the encoded data, so allocating the size
> +	 * of the encoded data will be large enough.
> +	 */
> +	upayload =3D kzalloc(sizeof(*upayload) + datalen, GFP_KERNEL);
> +	if (!upayload) {
> +		ret =3D -ENOMEM;
> +		goto out_err;
> +	}
> +
> +	/* decode the data */
> +	prep->payload.data[0] =3D upayload;
> +	ret =3D base64_decode(prep->data + offset, datalen, upayload->data,
> +			    true, BASE64_STD);
> +	if (ret < 0) {
> +		pr_debug("%s: Failed to decode key\n", __func__);
> +		ret =3D -EINVAL;
> +		goto out_free;
> +	}
> +	if (ret !=3D 36 && ret !=3D 52 && ret !=3D 68) {

[Severity: Low]
Should datalen be checked against the valid base64-encoded key lengths
(48, 72, or 92 bytes) before calling kzalloc() and base64_decode()?

Because add_key() allows payloads up to almost 1 MiB, an oversized
payload without an early trailing colon triggers a large physically
contiguous GFP_KERNEL allocation and decodes the entire buffer before
being rejected by the decoded length check.

[ ... ]

> +/**
> + * nvme_dhchap_encoded_key_size - Size of the base64-encoded key
> + * @size: size of the encoded key
> + *
> + * Returns the expected size of the key after base64 decoding
> + * include 4 bytes of CRC.
> + */
> +static inline int nvme_dhchap_encoded_key_size(int size)

[Severity: Low]
This isn't a bug, but the kernel-doc for nvme_dhchap_encoded_key_size()
has the input and return value reversed: @size is the raw decoded key
length (32, 48, or 64 bytes, excluding the 4-byte CRC), and the return
value is the base64-encoded length including the 4-byte CRC.  Also,
nvme_dhchap_psk_describe() above is identical to nvme_tls_psk_describe()
in the same file (and to user_describe()).

[ ... ]

> +static long nvme_dhchap_psk_read(const struct key *key,
> +				 char *buffer, size_t buflen)
> +{
> +	const struct user_key_payload *upayload;
> +	size_t datalen, keylen;
> +	u8 version, hmac;
> +	long ret;
> +
> +	upayload =3D user_key_payload_locked(key);
> +	/*
> +	 * Expected output string length:
> +	 * strlen("DHHC-") +
> +	 * version (=3D 1) +
> +	 * ':' (=3D 1) +
> +	 * hmac (=3D 2) +
> +	 * ':' (=3D 1) +
> +	 * encoded base64 key length +
> +	 * ':' (=3D 1)
> +	 */
> +	ret =3D nvme_dhchap_encoded_key_size(upayload->datalen);
> +	if (ret < 0)
> +		return ret;
> +	keylen =3D ret + 11;
> +	if (!buffer || !buflen)
> +		return keylen;
> +	else if (buflen < keylen)
> +		return -EINVAL;

[Severity: Medium]
Should nvme_dhchap_psk_read() return keylen instead of -EINVAL when
buflen < keylen?

The key_type->read() contract and keyctl_read_key() expect ->read() to
return the required size without copying whenever the caller's buffer is
too small, so returning -EINVAL breaks keyctl(KEYCTL_READ) callers that
probe the key size with a small non-NULL buffer.

> +
> +	memset(buffer, 0, buflen);
> +	version =3D upayload->data[upayload->datalen + 4];
> +	hmac =3D upayload->data[upayload->datalen + 5];
> +	ret =3D sprintf(buffer, "DHHC-%01hhu:%02hhu:", version, hmac);
> +	if (ret < 0)
> +		return -ENOKEY;
> +	/* Include the trailing CRC */
> +	datalen =3D upayload->datalen + 4;
> +	ret +=3D base64_encode(upayload->data, datalen, buffer + ret,
> +			     true, BASE64_STD);
> +	buffer[ret] =3D ':';
> +	ret++;
> +	return ret;
> +}
> +
> +static struct key_type nvme_dhchap_psk_key_type =3D {
> +	.name           =3D "dhchap",
> +	.flags          =3D KEY_TYPE_NET_DOMAIN,
> +	.preparse       =3D nvme_dhchap_psk_preparse,
> +	.free_preparse  =3D user_free_preparse,
> +	.instantiate    =3D generic_key_instantiate,
> +	.revoke         =3D user_revoke,
> +	.destroy        =3D user_destroy,
> +	.describe       =3D nvme_dhchap_psk_describe,
> +	.read           =3D nvme_dhchap_psk_read,
> +};

[Severity: Medium]
As reported by Martin Belanger on v6 [2], should nvme_dhchap_psk_key_type
define .update =3D user_update?

Without .update, keyctl(KEYCTL_UPDATE) fails with -EOPNOTSUPP and
add_key() allocates a new key with a different serial number instead of
updating an existing dhchap key in place, breaking key rotation for
controllers referencing a pre-provisioned key by serial number.  The
later commit "nvme-auth: allow to update pre-provisioned keys" in this
series mentions adding .update to the dhchap key type, but adds
.update =3D user_update to nvme_tls_psk_key_type instead.

[1] https://lore.kernel.org/r/463a55e8-c2ef-4d83-94ff-7599c7d931e6@gmail.com
[2] https://lore.kernel.org/r/a71a3d9f-0f19-45f4-bc98-a5663ad537b2@gmail.com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126-dhchap-key=
ring-v4-v7-0-ee438ffea527@kernel.org?part=3D2

