Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E66606A31A
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Nov 2026 12:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Nk1pKIRc;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oh3SRF+H
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=o9nJpGJTVrZkqpDCRVjS0+EGHvX1bTNHN+SgtWbOksE=; b=Nk1pKIRcibDyQCnK06otBRt32f
	JqyuyqnOE2lMjKVDUJZBdTfK16VBPAW42TlTLKh0nujDK9Y2NHz776RZGSTBG4j8MvbyPOakXjUx9
	VvfZ3wSNhvhbabpPyMYwjUZZYGhVuDOvgw0hEP95HWKgfc0kdH9adjU2EzQ2IcwpBaJXSXJuPHDWl
	oCAyrfr85mDGtMRDBRwALyltVg/h4ls6YgJFrHqASv7TcedrCBmVkLd+knIYsGTFH8t6f3frOSHwH
	V46VWHfMor970Uz/+JtgMD1tnYIYNrqSNM7l60LFOPwZDJdWOJxyhW8l5z+PQUNfYQhRPvTIl7j6W
	sHy+CsJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVTI0-00000003OTN-2w51;
	Mon, 23 Nov 2026 12:36:56 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVTHv-00000003OQe-1RzN
	for linux-nvme@lists.infradead.org;
	Mon, 23 Nov 2026 12:36:52 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 1D516458F7
	for <linux-nvme@lists.infradead.org>; Mon, 23 Nov 2026 12:36:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD86E1F01564;
	Mon, 23 Nov 2026 12:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795437410;
	bh=o9nJpGJTVrZkqpDCRVjS0+EGHvX1bTNHN+SgtWbOksE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oh3SRF+H5SUUPjsEzNlHtDZrNl7p3tiQ/kzOFhI9O81QY5VsG/xPFqnd+kGmJCgfE
	 WnxPZfMggz4LVa1G3Iww+Xn1K0SyAZpVWUMMyWl/Wl9TpevGabh/8zmKLkOHTrf82V
	 gGlfXVjQR4Hvla+WQSRUANAWcM2KzuDms8k46gdGQdnM5a/bQLc8k3oTo5Wcsa2qOu
	 Ag1XZ6he2jAulQlrwGTNoBe8rgr7JqcuiGJFKpvhU71h5TJeFVX5NwBiajR+3/465d
	 c8gye4SVLkvGbnWiQeEF/8yx1eTp4n+abflZbD/TxQaBU4qB6z9gnhX2qTzg03iIE+
	 rfaE4tjU0jzLw==
Message-ID: <sashiko-outbox-229232@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/9] nvme-keyring: add 'dhchap' key type
To: "Hannes Reinecke" <hare@kernel.org>
Cc: linux-nvme@lists.infradead.org
In-Reply-To: <20261123-dhchap-keyring-v4-v5-2-81eefb4c0724@kernel.org>
References: <20261123-dhchap-keyring-v4-v5-0-81eefb4c0724@kernel.org>
 <20261123-dhchap-keyring-v4-v5-2-81eefb4c0724@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 12:36:50 +0000
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

Thank you for your contribution! Sashiko AI review found 8 potential
issues to consider:
- [Critical] nvme-keyring: out-of-bounds read on prep->data in
  nvme_dhchap_psk_preparse()
- [High] nvme-keyring: uninitialized offset used in
  nvme_dhchap_psk_preparse()
- [High] nvme-keyring: header offset mismatch in
  nvme_dhchap_psk_preparse()
- [High] nvme-keyring: memory leak of upayload on error in
  nvme_dhchap_psk_preparse()
- [Medium] nvme-keyring: broken key length queries in
  nvme_dhchap_psk_read()
- [Low] nvme-keyring: inverted naming and comment for
  nvme_dhchap_decoded_key_size()
- [Low] nvme-keyring: missing select CRC32 in Kconfig for
  nvme_dhchap_psk_preparse()
- [Low] nvme-keyring: redundant nvme_dhchap_psk_match_preparse() forces
  linear scan
--

commit d9b56f363bf407639fb6f4f459820389f42a36f1
Author: Hannes Reinecke <hare@kernel.org>

nvme-keyring: add 'dhchap' key type

This commit registers a 'dhchap' key type in the NVMe keyring module to
parse, store, and read back base64-encoded DH-HMAC-CHAP secret keys.

> diff --git a/drivers/nvme/common/keyring.c b/drivers/nvme/common/keyring.c
> index 87cb51e1f5a7f..d0c36d153afdb 100644
> --- a/drivers/nvme/common/keyring.c
> +++ b/drivers/nvme/common/keyring.c
> @@ -4,6 +4,9 @@
>   */
> =20
>  #include <linux/module.h>
> +#include <linux/crc32.h>
> +#include <linux/base64.h>
> +#include <linux/unaligned.h>
>  #include <linux/seq_file.h>
>  #include <linux/key-type.h>
>  #include <keys/user-type.h>

[Severity: Low]
nvme_dhchap_psk_preparse() calls crc32(), which expands to crc32_le(), but
config NVME_KEYRING in drivers/nvme/common/Kconfig only selects KEYS and do=
es
not select CRC32.  Should NVME_KEYRING select CRC32 so builds without
CONFIG_CRC32 enabled by another option do not fail at link time?

> @@ -253,6 +256,231 @@ key_serial_t nvme_tls_psk_default(struct key *keyri=
ng,

[ ... ]

> +static bool nvme_dhchap_psk_match(const struct key *key,
> +				  const struct key_match_data *match_data)
> +{
> +	const char *match_id;
> +	size_t match_len;
> +
> +	if (!key->description) {
> +		pr_debug("%s: no key description\n", __func__);
> +		return false;
> +	}
> +	if (!match_data->raw_data) {
> +		pr_debug("%s: no match data\n", __func__);
> +		return false;
> +	}
> +	match_id =3D match_data->raw_data;
> +	match_len =3D strlen(match_id);
> +	if (match_len !=3D strlen(key->description)) {
> +		pr_debug("%s: match '%s' '%s' different size\n",
> +			 __func__, match_id, key->description);
> +		return false;
> +	}
> +	pr_debug("%s: match '%s' '%s' len %zd\n",
> +		 __func__, match_id, key->description, match_len);
> +
> +	return !memcmp(key->description, match_id, match_len);
> +}
> +
> +static int nvme_dhchap_psk_match_preparse(struct key_match_data *match_d=
ata)
> +{
> +	match_data->lookup_type =3D KEYRING_SEARCH_LOOKUP_ITERATE;
> +	match_data->cmp =3D nvme_dhchap_psk_match;
> +	return 0;
> +}

[Severity: Low]
Is nvme_dhchap_psk_match_preparse() needed here?  nvme_dhchap_psk_match()
checks for an exact description match identical to key_default_cmp(), so
overriding lookup_type to KEYRING_SEARCH_LOOKUP_ITERATE forces every dhchap
key lookup to do a linear scan of the keyring instead of a direct associati=
ve
array lookup.

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
> +	int ret, offset;
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
> +
> +	if (sscanf(prep->data, "DHHC-%01hhu:%02hhu:%n",
> +		   &version, &hmac, &offset) !=3D 2 || !offset) {
> +		pr_debug("%s: invalid key data '%s'\n", __func__,
> +			 (char *)prep->data);
> +		prep->payload.data[0] =3D NULL;
> +		prep->quotalen =3D 0;
> +		return -EINVAL;
> +	}

[Severity: High]
Can offset be used uninitialized when the second ':' in the header is
missing?

In vsscanf(), %n does not increment the conversion count.  An input such as
"DHHC-1:00" converts version and hmac, fails to match the trailing ':', and
returns 2 before reaching %n.  Because offset is not initialized to 0,
!offset reads whatever value is on the stack and later passes
prep->data + offset to strlen() and strrchr().

> +
> +	/* skip header and final ':' character */
> +	datalen =3D strlen(prep->data + offset);
> +	p =3D strrchr(prep->data + offset, ':');
> +	if (p)
> +		datalen--;

[Severity: Critical]
Can sscanf(), strlen(), strrchr(), and pr_debug() read past the end of
prep->data?

add_key() and keyctl_update_key() allocate an exact plen-byte buffer with
kvmalloc() and copy the user payload without adding a NUL terminator:

security/keys/keyctl.c:SYSCALL_DEFINE5(add_key) {
    ...
	if (plen) {
		ret =3D -ENOMEM;
		payload =3D kvmalloc(plen, GFP_KERNEL);
		if (!payload)
			goto error2;

		ret =3D -EFAULT;
		if (copy_from_user(payload, _payload, plen) !=3D 0)
			goto error3;
	}
    ...
}

nvme_dhchap_psk_preparse() never bounds prep->data by prep->datalen before
treating it as a NUL-terminated string, so a non-NUL-terminated payload from
userspace causes out-of-bounds kernel memory reads.

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
> +
> +	/* decode the data */
> +	prep->payload.data[0] =3D upayload;
> +	ret =3D base64_decode(prep->data + 10, datalen, upayload->data,
> +			    true, BASE64_STD);
> +	if (ret < 0) {
> +		pr_debug("%s: Failed to decode key %s\n",
> +			 __func__, (char *)prep->data + 10);
> +		prep->payload.data[0] =3D NULL;
> +		return ret;
> +	}

[Severity: High]
Can base64_decode() read 1 byte past the key buffer and decode the wrong
slice when offset is not 10?

Because 2 in %02hhu is a maximum field width, a header with a single-digit
HMAC such as "DHHC-1:1:<base64>" sets offset to 9.  datalen is computed from
prep->data + offset, but base64_decode() starts at prep->data + 10, skipping
the first base64 character and reading 1 byte past the end of the string.

Also, if a trailing ':' is followed by any other character (such as a
newline), decrementing datalen by 1 instead of using p - (prep->data + offs=
et)
leaves trailing characters in datalen.  And when base64_decode() fails it
returns -1, so returning ret directly returns -EPERM to userspace instead of
-EINVAL.

> +	if (ret !=3D 36 && ret !=3D 52 && ret !=3D 68) {
> +		pr_debug("%s: invalid decoded key size '%d'\n",
> +			 __func__, ret);
> +		prep->payload.data[0] =3D NULL;
> +		return -EINVAL;
> +	}
> +	ret -=3D 4;
> +	crc =3D ~crc32(~0, upayload->data, ret);
> +	if (get_unaligned_le32(upayload->data + ret) !=3D crc) {
> +		pr_debug("%s: CRC mismatch for key\n", __func__);
> +		/* CRC mismatch */
> +		prep->payload.data[0] =3D NULL;
> +		return -EKEYREJECTED;
> +	}

[Severity: High]
Does clearing prep->payload.data[0] =3D NULL on the error paths above leak
upayload?

When ->preparse() returns an error, the keyring core calls ->free_preparse(=
),
which is user_free_preparse() and frees prep->payload.data[0] via
kfree_sensitive().  Setting prep->payload.data[0] =3D NULL on base64_decode=
(),
key size, and CRC failures without freeing upayload causes
user_free_preparse() to see NULL and leak the allocation.

[ ... ]

> +/**
> + * nvme_dhchap_decoded_key_size - Size of the base64-decoded key
> + * @size: size of the encoded key
> + *
> + * Returns the expected size of the key after base64 decoding.
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
this helper takes the decoded binary key size (32, 48, or 64) and returns t=
he
base64-encoded size including the 4-byte CRC (48, 72, or 92).

> +
> +/**
> + * nvme_dhchap_psk_read - read callback for dhchap key types
> + * @key: key to read from
> + * @buffer: buffer for the key contents
> + * @buflen: length of @buffer
> + *
> + * Formets the DH-HMAC-CHAP key in base64-encoded form as
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
> +	if (!buffer || buflen =3D=3D 0)
> +		return -EINVAL;
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
> +	if (buflen < keylen)
> +		return -EINVAL;

[Severity: Medium]
Should nvme_dhchap_psk_read() return keylen instead of -EINVAL when buffer =
is
NULL, buflen is 0, or buflen < keylen?

key_type->read() is required to return the needed buffer size even when no
buffer or a too-small buffer is provided.  keyctl_read_key() calls
__keyctl_read_key(key, NULL, 0) both when userspace probes the key length
(such as keyctl read or keyctl print) and on the first pass whenever buflen=
 >
PAGE_SIZE, so returning -EINVAL breaks those reads.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123-dhchap-key=
ring-v4-v5-0-81eefb4c0724@kernel.org?part=3D2

