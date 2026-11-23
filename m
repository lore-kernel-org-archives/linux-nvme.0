Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155EB606A31F
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Nov 2026 17:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=2wZno/Qr;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ip3GEWHC
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=MBTG8aTG4NZsomoN2tTnNE+OH3jvG/0srwcN5yAElaQ=; b=2wZno/QrfQuQf0scCbci/r7m9Q
	4vd1tAXURc6a3XgxdjaZ/zjJbhgK6RCE69ddBxa3Atfr+WXF5bzE+rksKBrIfn/9vA6GJ3MAAMr/S
	ZG+g6HNc+UKLRcfMMIzF3u9VTRrnDQLIlOP24Xe2YdAY7AaBau9rqMAum6jFXZ6+PO/0A5Khr1hik
	z4zJ28DXismu+KJu4UnTTIZIo2FpmUqJdif4v2AMIy28QX8zjaEkhWfna8edRvszgsUM7/uRJ8XNl
	0fwfBSHqcFgbb8Y4QeI+8jgW8uWdLrbT30rcZRl50kIBVIZfKyGP6jnqGpWO4kQr+fOD9fr0UN7m1
	cBJkqaWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVXt0-00000004Mpp-3Hst;
	Mon, 23 Nov 2026 17:31:26 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVXsz-00000004MpX-44OU
	for linux-nvme@lists.infradead.org;
	Mon, 23 Nov 2026 17:31:26 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 586FE61EBC
	for <linux-nvme@lists.infradead.org>; Mon, 23 Nov 2026 17:31:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE7E61F000D0;
	Mon, 23 Nov 2026 17:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795455084;
	bh=MBTG8aTG4NZsomoN2tTnNE+OH3jvG/0srwcN5yAElaQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ip3GEWHCu0zSzGi+Ji0KS1Dpk5tTCtjX6nnBUn/cCjiWlRbC0VAqkWQNpzzWyFDye
	 yrUg8ULZDtT70eTdCNamlAmiWauU6bEcNz42F92rft//B+oUnHNP4fzpgZVPNgSPl6
	 ugwkcj1EbWmhOjJWzoAsuRFpxqWStc2OJv1nZSuDmX6Um1FOY5LoIh8UsN3K7s+/Nq
	 chRcTEBgUfkuHsieoH61xpgkhytQm8Fvs3RTGMtVaVkXwyiHI2Pwl6453yPpv4ZMeC
	 gpXKDd/qAen/AMP9l2Rhg+tmJBNV3JoI+h7eCOwoG43yDZGa4s8a0/ozySAe+vIo6i
	 sptcBtTYBzpmQ==
Message-ID: <sashiko-outbox-229754@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/9] nvme-keyring: add 'dhchap' key type
To: "Hannes Reinecke" <hare@kernel.org>
Cc: linux-nvme@lists.infradead.org
In-Reply-To: <20261123-dhchap-keyring-v4-v6-2-5082a49715ab@kernel.org>
References: <20261123-dhchap-keyring-v4-v6-0-5082a49715ab@kernel.org>
 <20261123-dhchap-keyring-v4-v6-2-5082a49715ab@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 17:31:24 +0000
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
- [Critical] nvme-keyring: out-of-bounds read on prep->data in
  nvme_dhchap_psk_preparse()
- [Medium] nvme-keyring: broken colon handling in
  nvme_dhchap_psk_preparse()
- [Medium] nvme-keyring: broken buffer length check in
  nvme_dhchap_psk_read()
- [Low] nvme-keyring: use kfree_sensitive() on error in
  nvme_dhchap_psk_preparse()
- [Low] nvme-keyring: inverted name and comment for
  nvme_dhchap_decoded_key_size()
--

commit 821eb4c808c34e952c59ff2fa90f5898d0eb2667
Author: Hannes Reinecke <hare@kernel.org>

nvme-keyring: add 'dhchap' key type

This commit adds a 'dhchap' key type to the NVMe keyring to store and read
DH-HMAC-CHAP secret keys in a user-key compatible payload.

> diff --git a/drivers/nvme/common/keyring.c b/drivers/nvme/common/keyring.c
> index 87cb51e1f5a7f..fc7f833a7c6b6 100644
> --- a/drivers/nvme/common/keyring.c
> +++ b/drivers/nvme/common/keyring.c
> @@ -253,6 +256,213 @@ key_serial_t nvme_tls_psk_default(struct key *keyri=
ng,

[ ... ]

> +static int nvme_dhchap_psk_preparse(struct key_preparsed_payload *prep)
> +{
> +	struct user_key_payload *upayload;
> +	size_t datalen =3D prep->datalen;
> +	int ret, offset =3D 0;
> +	char *p;
> +	u32 crc;
> +	u8 version, hmac;
> +
> +	if (!prep->data) {
> +		pr_debug("%s: Empty data", __func__);
> +		prep->payload.data[0] =3D NULL;
> +		prep->quotalen =3D 0;
> +		return -EINVAL;
> +	}
> +	if (sscanf(prep->data, "DHHC-%01hhu:%02hhu:%n",
> +		   &version, &hmac, &offset) !=3D 2 || offset !=3D 10) {
> +		pr_debug("%s: invalid key header\n", __func__);
> +		prep->payload.data[0] =3D NULL;
> +		prep->quotalen =3D 0;
> +		return -EINVAL;
> +	}
> +
> +	if (version !=3D 1 || hmac > 3) {
> +		pr_debug("%s: invalid key version\n", __func__);
> +		prep->payload.data[0] =3D NULL;
> +		prep->quotalen =3D 0;
> +		return -EINVAL;
> +	}
> +
> +	/* skip header and final ':' character */
> +	if (offset > prep->datalen) {
> +		pr_debug("%s: invalid key data\n", __func__);
> +		prep->payload.data[0] =3D NULL;
> +		prep->quotalen =3D 0;
> +		return -EINVAL;
> +	}

[Severity: Critical]
As reported by Martin Belanger on v5 [1], can sscanf() and the pr_debug()
below read past the end of prep->data?

add_key() allocates a buffer of size plen (prep->datalen) and copies the raw
userspace payload without appending a NUL terminator:

security/keys/keyctl.c:SYSCALL_DEFINE5(add_key)() {
    ...
	if (_payload) {
		payload =3D kvmalloc(plen, GFP_KERNEL);
		if (!payload)
			goto error2;

		ret =3D -EFAULT;
		if (copy_from_user(payload, _payload, plen) !=3D 0)
			goto error3;
	}
    ...
}

When userspace passes a non-NUL-terminated payload (for example, fewer than
10 bytes, or "DHHC-" followed by whitespace), sscanf() scans past
prep->data + prep->datalen into adjacent kernel memory before the
offset > prep->datalen check runs.  Similarly, when base64_decode() fails
below, pr_debug("%s: Failed to decode key %s\n", ...) formats
(char *)prep->data + offset with %s without bounding it by datalen.

> +	datalen =3D prep->datalen - offset;
> +	p =3D memchr(prep->data + offset, ':', datalen);
> +	if (p)
> +		datalen--;
> +
> +	/*
> +	 * payload is < key | version | hmac >
> +	 * base64 decode will always return less data
> +	 * than the encoded data, so allocating the size
> +	 * of the encoded data will be large enough.
> +	 */
> +	upayload =3D kzalloc(sizeof(*upayload) + datalen, GFP_KERNEL);
> +	if (!upayload) {
> +		prep->payload.data[0] =3D NULL;
> +		prep->quotalen =3D 0;
> +		return -ENOMEM;
> +	}

[Severity: Medium]
Does decrementing datalen by 1 leave the trailing ':' in the base64 input
whenever the payload ends with a NUL byte or newline?

If userspace passes a NUL-terminated or newline-terminated key string, ':'
is not the final byte of prep->data, so datalen-- only strips the trailing
NUL or newline and leaves ':' inside the slice passed to base64_decode(),
which then fails with -EINVAL.  Truncating at p (datalen =3D p - (char *)
(prep->data + offset)) and validating that datalen is a supported encoded
key size before calling kzalloc() would also avoid allocating an arbitrary
buffer up to 1 MB prior to length validation.

> +
> +	/* decode the data */
> +	prep->payload.data[0] =3D upayload;
> +	ret =3D base64_decode(prep->data + offset, datalen, upayload->data,
> +			    true, BASE64_STD);
> +	if (ret < 0) {
> +		pr_debug("%s: Failed to decode key %s\n",
> +			 __func__, (char *)prep->data + offset);
> +		prep->payload.data[0] =3D NULL;
> +		prep->quotalen =3D 0;
> +		kfree(upayload);
> +		return -EINVAL;
> +	}
> +	if (ret !=3D 36 && ret !=3D 52 && ret !=3D 68) {
> +		pr_debug("%s: invalid decoded key size '%d'\n",
> +			 __func__, ret);
> +		prep->payload.data[0] =3D NULL;
> +		prep->quotalen =3D 0;
> +		kfree(upayload);
> +		return -EINVAL;
> +	}
> +	ret -=3D 4;
> +	crc =3D ~crc32(~0, upayload->data, ret);
> +	if (get_unaligned_le32(upayload->data + ret) !=3D crc) {
> +		pr_debug("%s: CRC mismatch for key\n", __func__);
> +		/* CRC mismatch */
> +		prep->payload.data[0] =3D NULL;
> +		prep->quotalen =3D 0;
> +		kfree(upayload);
> +		return -EKEYREJECTED;
> +	}

[Severity: Low]
Should these three error paths use kfree_sensitive(upayload) instead of
kfree(upayload)?  base64_decode() has already written decoded secret key
bytes into upayload->data, and clearing prep->payload.data[0] prevents
user_free_preparse() from zeroizing the buffer.

[ ... ]

> +/**
> + * nvme_dhchap_decoded_key_size - Size of the base64-decoded key
> + * @size: size of the encoded key
> + *
> + * Returns the expected size of the key after base64 decoding
> + * include 4 bytes of CRC.
> + */
> +static inline int nvme_dhchap_decoded_key_size(int size)
> +{
> +	int keylen =3D -EINVAL;
> +
> +	switch (size) {
> +	case 32:
> +		keylen =3D 48;
> +		break;
> +	case 48:
> +		keylen =3D 72;
> +		break;
> +	case 64:
> +		keylen =3D 92;
> +		break;
> +	default:
> +		break;
> +	}
> +	return keylen;
> +}

[Severity: Low]
This isn't a bug, but the function name and kernel-doc comment are inverted:
this helper takes the decoded key size (32, 48, or 64) and returns the
base64-encoded size including the 4-byte CRC (48, 72, or 92).

> +
> +/**
> + * nvme_dhchap_psk_read - read callback for dhchap key types
> + * @key: key to read from
> + * @buffer: buffer for the key contents
> + * @buflen: length of @buffer
> + *
> + * Formats the DH-HMAC-CHAP key in base64-encoded form as
> + * defined in the NVM Express TCP Transport Specification Rev 1.1,
> + * Section 3.6.1.5 'PSK Interchange Format'. The payload of @key
> + * is assumed to be of 'struct user_key_payload', with the data
> + * consisting of the key data of length 'upayload->datalen', followed
> + * by four bytes of CRC, one byte version, and one byte hmac fields.
> + */
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
> +	ret =3D nvme_dhchap_decoded_key_size(upayload->datalen);
> +	if (ret < 0)
> +		return ret;
> +	keylen =3D ret + 11;
> +	if (!buffer && !buflen)
> +		return keylen;
> +	else if (buflen < keylen)
> +		return -EINVAL;
> +
> +	memset(buffer, 0, buflen);

[Severity: Medium]
Does this buffer check violate the key_type->read() contract and allow a
NULL pointer dereference in memset()?

Per include/linux/key-type.h and keyctl_read_key(), ->read() should return
 the required buffer size whenever buffer is NULL or buflen is too small
(if (!buffer || buflen < keylen) return keylen;).  As written, calling
keyctl(KEYCTL_READ) with a non-NULL buffer and 0 < buflen < keylen fails
with -EINVAL instead of returning keylen, and a call with buffer =3D=3D NUL=
L and
buflen >=3D keylen falls through to memset(NULL, 0, buflen).

[1] https://lore.kernel.org/r/463a55e8-c2ef-4d83-94ff-7599c7d931e6@gmail.com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123-dhchap-key=
ring-v4-v6-0-5082a49715ab@kernel.org?part=3D2

