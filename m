Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046A5606A320
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Nov 2026 11:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=zwR9gutN;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d9/UXLGm
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=E2X+JIjEsxLWgAENHf3qwklGbxrWM/A3djQPQmx89WI=; b=zwR9gutNRjqI3i6jitwe4MuQ2M
	4mdDN3dIx/xoPbVhzzc3nbsMl2WSkG9iHp64Q8MgyVSS+09AkshMA38vhVlhUdThh0mmJMfXSeYRb
	6T8849618qBtv9H4Jkc3ZdtP/FhiI8d/V/6PVXMJellZSEIaFxEbQXBN9P7zxSGLfdGxrmXDgIp6F
	K3UAY0Z3iliTmaMGYADGzFI1LAPEiXL9FMGZnMX9PuwBMXylhsAM9bwzaW3gSjcod/PD47/q+hjNP
	itgfVbifOLEKHgFrv6vB36GjVNIhweXu5FbBAmWiFPhGplZU0+9kWxOuYEiLps6JH8GVItFIRZDhf
	oTxsJVBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUMmy-0000000EnBe-2rWR;
	Fri, 20 Nov 2026 11:28:20 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUMmw-0000000EnBF-3Sro
	for linux-nvme@lists.infradead.org;
	Fri, 20 Nov 2026 11:28:18 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 1F550605CB
	for <linux-nvme@lists.infradead.org>; Fri, 20 Nov 2026 11:28:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CD9F1F000CA;
	Fri, 20 Nov 2026 11:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795174097;
	bh=E2X+JIjEsxLWgAENHf3qwklGbxrWM/A3djQPQmx89WI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=d9/UXLGmnwJ5v0xVSzPlqygrTIZZrScGNRegV+MS0UptLQ3/P8GU2RmotktpFSBPt
	 jKaPpFWTnFNhychVkytttlORSm8Xw0M72ZZvHLCPV0uKKvicgaXXTvtfg/ohDllfAY
	 IdTTjGFP1blfA/x1V+GbLboSqU/rADsJtNDUfAwOoryfTBroqvGO0shlMt5GeDwK4O
	 cPlPM2/aDhOu6993sq4dlzyYAWN2iGj0Uo6FcRf+IrJV1q9F/TKjgmHzEXCu1+Z9V/
	 eyuYOMw3ZslOjdl1+uJO8GEB8h08u3KqJ4962Sun7B8ckStx7onJfyriBR34oEjo/L
	 j0cl4MKQYkbQg==
Message-ID: <sashiko-outbox-225040@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/9] nvme-keyring: add 'dhchap' key type
To: "Hannes Reinecke" <hare@kernel.org>
Cc: linux-nvme@lists.infradead.org
In-Reply-To: <20261120-dhchap-keyring-v4-v4-2-5f8c7d9926ee@kernel.org>
References: <20261120-dhchap-keyring-v4-v4-0-5f8c7d9926ee@kernel.org>
 <20261120-dhchap-keyring-v4-v4-2-5f8c7d9926ee@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 11:28:16 +0000
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
- [Critical] nvme-keyring: out-of-bounds reads and underflows in
  nvme_dhchap_psk_preparse()
- [High] nvme-keyring: uninitialized keylen used in
  nvme_dhchap_psk_preparse()
- [Medium] nvme-keyring: unsigned error check and size mismatch in
  nvme_dhchap_psk_read()
- [Medium] nvme-keyring: out-of-bounds memcmp() in
  nvme_dhchap_psk_match()
--

commit 329ebc74c917187a04d7c54885592dcb5f74d0dd
Author: Hannes Reinecke <hare@kernel.org>

nvme-keyring: add 'dhchap' key type

This commit adds a 'dhchap' key type to store DH-HMAC-CHAP secret keys with
a user-type compatible payload and a read callback that formats keys in the=
ir
base64-encoded representation.

> diff --git a/drivers/nvme/common/keyring.c b/drivers/nvme/common/keyring.c
> index 87cb51e1f5a7f..96561f2dd81b8 100644
> --- a/drivers/nvme/common/keyring.c
> +++ b/drivers/nvme/common/keyring.c
[ ... ]
> @@ -253,6 +256,212 @@ key_serial_t nvme_tls_psk_default(struct key *keyri=
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
> +	pr_debug("%s: match '%s' '%s' len %zd\n",
> +		 __func__, match_id, key->description, match_len);
> +
> +	return !memcmp(key->description, match_id, match_len);
> +}

[Severity: Medium]
Can memcmp() read past the end of key->description here?  key_alloc()
allocates strlen(key->description) + 1 bytes, so searching with a match_id
longer than key->description reads out of bounds, while a shorter match_id
matches any key whose description shares that prefix.

[ ... ]

> +static int nvme_dhchap_psk_preparse(struct key_preparsed_payload *prep)
> +{
> +	struct user_key_payload *upayload;
> +	size_t datalen =3D prep->datalen, keylen;
> +	int ret;
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
> +	if (sscanf(prep->data, "DHHC-%01hhu:%02hhu:%*s",
> +		   &version, &hmac) !=3D 2) {
> +		pr_debug("%s: invalid key data '%s'\n", __func__,
> +			 (char *)prep->data);
> +		prep->payload.data[0] =3D NULL;
> +		prep->quotalen =3D 0;
> +		return -EINVAL;
> +	}
> +
> +	/* skip header and final ':' character */
> +	datalen -=3D 11;
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
> +	prep->quotalen =3D keylen;

[Severity: High]
Isn't keylen uninitialized when assigned to prep->quotalen?
generic_key_instantiate() passes prep->quotalen to key_payload_reserve(),
corrupting per-user key quota accounting and exposing the lower 16 bits of
the stack value via key->datalen in /proc/keys.

> +	prep->payload.data[0] =3D upayload;
> +	ret =3D base64_decode(prep->data + 10, datalen, upayload->data,
> +			    true, BASE64_STD);
> +	if (ret < 0) {
> +		pr_debug("%s: Failed to decode key %s\n",
> +			 __func__, (char *)prep->data + 10);
> +		return ret;
> +	}
> +	ret -=3D 4;
> +	crc =3D ~crc32(~0, upayload->data, ret);

[Severity: Critical]
Can malformed or short payloads from add_key() trigger out-of-bounds reads
and integer underflows in nvme_dhchap_psk_preparse()?

add_key() copies plen bytes from userspace into prep->data without appending
a NUL terminator, so sscanf() and the pr_debug() %s calls can read past
prep->data + prep->datalen.  Because %*s is assignment-suppressed and
%02hhu matches one or two digits, sscanf() can also return 2 when
prep->datalen < 11 (for example, "DHHC-1:01"), causing datalen -=3D 11 to
underflow and wrap sizeof(*upayload) + datalen in kzalloc().

Even when prep->datalen >=3D 11, if base64_decode() returns 0..3 (such as on
an 11-byte payload "DHHC-1:01::"), ret -=3D 4 becomes negative and wraps to
SIZE_MAX - 3 .. SIZE_MAX when passed as size_t len to crc32().  In addition,
base64_decode() returns -1 on error, which leaks out as -EPERM instead of
-EINVAL, and the decoded key length is never checked against the valid
DH-HMAC-CHAP sizes (32, 48, or 64 bytes).

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
> +	 * CRC length (=3D 4) +
> +	 * ':' (=3D 1)
> +	 */
> +	keylen =3D nvme_dhchap_decoded_key_size(upayload->datalen) + 15;
> +	if (keylen < 0 || !buffer || buflen =3D=3D 0)
> +		return keylen;
> +
> +	if (buflen < keylen)
> +		return -EINVAL;

[Severity: Medium]
Since keylen is an unsigned size_t, is keylen < 0 always false here?
Adding 15 before checking for an error also turns -EINVAL from
nvme_dhchap_decoded_key_size() into -7 (-E2BIG), and double-counts the
4-byte CRC because nvme_dhchap_decoded_key_size() already returns the
encoded length of the key plus CRC (48, 72, or 92 bytes), so the total
formatted length is 4 bytes larger than what nvme_dhchap_psk_read()
actually writes (+ 11).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120-dhchap-key=
ring-v4-v4-0-5f8c7d9926ee@kernel.org?part=3D2

