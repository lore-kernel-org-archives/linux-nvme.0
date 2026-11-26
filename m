Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49231606A31C
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Nov 2026 14:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=eSeCju5z;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h8aeXAjz
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=w2FnkjsorPqnWEbAhKKiOQtC7SO28lR3c0NUHkdn6z0=; b=eSeCju5zcFr+XgJQtpqyxvOfOF
	kUTnvEGsXLVWoXyPm4Sx65c/4cz8wcCfpQH/JptrE2QZdKr45QxJpKxH6XTGsMztBWnDqrw6G/936
	U8mLmnw/rNboxCsYqA6kmS68AHndD9IeILSn9WCpWvfvMaRA2QKQnVHrY4OZ/CUbr0DrYFAseN2f1
	wrBHp+30C4uXG4rwv7IjVrdyopU4R5sQrdg56mTYCLWYpQ6gkphXk2R29grRZly3bzMDrCHENi+nJ
	5PYAUr+aOFdH30HC/YRxq9j+qE4VOywBzHYb1RwlWkq5gpJFNzEguwG8sBF3UqR3/pXg5lJo5dJ9W
	M5ZD9XpQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWaQJ-0000000DXpi-49I7;
	Thu, 26 Nov 2026 14:26:07 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWaQI-0000000DXpK-0zDL
	for linux-nvme@lists.infradead.org;
	Thu, 26 Nov 2026 14:26:06 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 4B280621E2;
	Thu, 26 Nov 2026 14:26:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4684F1F000C0;
	Thu, 26 Nov 2026 14:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795703165;
	bh=w2FnkjsorPqnWEbAhKKiOQtC7SO28lR3c0NUHkdn6z0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=h8aeXAjzFqE4ciymvXEicFjQdJV6tw6b7dPLGGF+BoyhToZUubqjuBqoQMBeSPcXs
	 xqOAytULhFRcZ5cOrqkXf8EBIlGUTh2G6BghNfXBPaXtqcofVGhgvJn8jByuBunwmS
	 f5Y7MPf0oc3jL6sXJp2vPwe4IZ1+L1S0G7lW1O6APMnV5rlIxVj0t3MYrlltVliPcI
	 Atql9HovTqhYlw6vujJXZnlhHLML1hIgrsNGJiNupX+l+mQgeSlYrlTnJOtuTfVCAm
	 iVSRywqGGTQHSh6Exjk+eBwXHa9WBl+GS2IiQYl2WLa59fUTjHqS4bEC+RIKgXhZMs
	 Xd49GoQH9opdA==
Message-ID: <sashiko-outbox-235696@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 10/14] nvme-auth: allow to specify the key by key
 serial
To: "Hannes Reinecke" <hare@kernel.org>, "Keith Busch" <kbusch@kernel.org>, "Jens
 Axboe" <axboe@kernel.dk>, "Christoph Hellwig" <hch@lst.de>, "Sagi Grimberg" <sagi@grimberg.me>, "Hannes
 Reinecke" <hare@suse.de>, "Chaitanya Kulkarni" <kch@nvidia.com>, "Eric
 Biggers" <ebiggers@kernel.org>, "David Howells" <dhowells@redhat.com>, "Jarkko
 Sakkinen" <jarkko@kernel.org>, "Jonathan Corbet" <corbet@lwn.net>, "Shuah
 Khan" <skhan@linuxfoundation.org>, "Randy Dunlap" <rdunlap@infradead.org>, "Kees
 Cook" <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-nvme@lists.infradead.org, keyrings@vger.kernel.org
In-Reply-To: <20261126-dhchap-keyring-v4-v7-10-ee438ffea527@kernel.org>
References: <20261126-dhchap-keyring-v4-v7-0-ee438ffea527@kernel.org>
 <20261126-dhchap-keyring-v4-v7-10-ee438ffea527@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 14:26:03 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] nvme-auth: missing key type validation in
  nvme_auth_extract_key()
- [Low] nvme-auth: key_serial truncation to key_serial_t in
  nvme_auth_extract_key()
--

commit 7d31006b6164c1d407e94a069e4daf6dec180cf1
Author: Hannes Reinecke <hare@kernel.org>

nvme-auth: allow to specify the key by key serial

This commit updates nvme_auth_extract_key() to parse a numeric key serial
and look up the key via key_lookup() before falling back to key description
lookup or key generation.

> diff --git a/drivers/nvme/common/auth.c b/drivers/nvme/common/auth.c
> index 15e72fe8868af..e336c698437dc 100644
> --- a/drivers/nvme/common/auth.c
> +++ b/drivers/nvme/common/auth.c
> @@ -148,7 +148,7 @@ EXPORT_SYMBOL_GPL(nvme_auth_hmac_hash_len);
>   * @generated: indicate whether a key has been generated
>   *
>   * Extracts or generates a key from @input.
> - * @input can either be a key description or raw key data; in
> + * @input can be a key serial, a key description or raw key data; in
>   * the latter case a key is generated from @input and
>   * @generated is set to 'true'.
>   *
> @@ -158,7 +158,18 @@ struct key *nvme_auth_extract_key(const char *input,=
 size_t input_len,
>  				  bool *generated)
>  {
>  	struct key *key;
> -
> +	unsigned long key_serial;
> +	int err;
> +
> +	/* Check if @input is a key serial */
> +	err =3D kstrtoul(input, 0, &key_serial);
> +	if (!err) {
> +		key =3D key_lookup(key_serial);

[Severity: Low]
Can kstrtoul() silently truncate 64-bit values when key_serial is passed to
key_lookup()?  key_serial_t is int32_t and valid serials are positive, so a
numeric string larger than INT_MAX on 64-bit platforms is narrowed to its
lower 32 bits instead of being rejected.  Parsing with kstrtos32() and
checking key_serial > 0 would avoid this.

> +		if (!IS_ERR(key)) {
> +			*generated =3D false;
> +			return key;
> +		}
> +	}

[Severity: High]
Can key_lookup() return a key that is not a positively instantiated
nvme_dhchap_psk_key_type key?

Unlike nvme_dhchap_psk_lookup(), key_lookup() searches the global serial
tree without checking key->type or instantiation state.  When
nvme_auth_transform_key() later runs, it unconditionally calls user_read()
and nvme_dhchap_psk_hash(), which read key->payload.rcu_data0 as a struct
user_key_payload and access 6 bytes past upayload->datalen:

drivers/nvme/common/keyring.c:nvme_dhchap_psk_hash() {
	...
	upayload =3D user_key_payload_locked(key);
	hmac =3D upayload->data[upayload->datalen + 5];
	return hmac;
}

Passing the serial of an uninstantiated key, a keyring, or another key type
(such as user, logon, or NVMe TLS PSK, where user_preparse() only allocates
upayload->datalen bytes) causes a NULL pointer dereference, type confusion,
or a 6-byte slab out-of-bounds read.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126-dhchap-key=
ring-v4-v7-0-ee438ffea527@kernel.org?part=3D10

