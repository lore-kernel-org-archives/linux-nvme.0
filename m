Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B278A606A32C
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Nov 2026 14:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=vl7SiIc8;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VkOkj3al
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=nde5jzcPFgbGFr4Ku39uM0negQLS7OUJRj8MnAeskMo=; b=vl7SiIc8qa1ACKskk29fiz3E1Q
	9dxFzFFAFQHsyV+sLxQEe/3+rAsqwaZQHnctOpev2EkFkdG+Zs3TE2S3+pljUYiQvL7OVAI83ynfv
	iAtRS6vO3iGLU2cRxfvR/Wc8VrLeh5BcfzXXkqLlEHGagLyGZ3qHg3z5wgmqYqk0OeXzbnC8F8zJC
	lI7aaZBJCvUsfBr0juLvm+upzrppWt7mLOC2P42GDzf9BRSkyvBwG5oXo6QEn1VFaI3pjAwKVch6K
	gmVJ8h7AMDWNm4bryG5uHuYFdd7wKZUM6vlnrh3MAijasEPjy1p324HZ4PvW1ZGKFctyO659va+jr
	7gPaQpyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWaXI-0000000DZmu-1ihy;
	Thu, 26 Nov 2026 14:33:20 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWaXH-0000000DZmi-3tWa
	for linux-nvme@lists.infradead.org;
	Thu, 26 Nov 2026 14:33:19 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 6DE9043C4A;
	Thu, 26 Nov 2026 14:33:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D3F61F000C4;
	Thu, 26 Nov 2026 14:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795703599;
	bh=nde5jzcPFgbGFr4Ku39uM0negQLS7OUJRj8MnAeskMo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VkOkj3al2PB5jc4KWLJzAixxYDd+yXVAA4GYSjfD+CE1UNi5vAM804wiaFbuuJ9ug
	 SAUnWq8Ce2Q9XHgbhYEZYXdvI/VCMpi1wG78S7o/zwrx/c6fCk7+gP3d4EaHcYAIQ7
	 UD9cS17KMX2E4D5z7Rrd/xqRnZRo7BFder+HrGWbTUnZowlxVwRibA6T36BfAJYZf/
	 vWY/6zZBKpYHATn0WdN39bLoXVCei68TloUKnBZ727TBSjy+9Fk3akr0suF8RwK07w
	 dBYF/16YCgKytmBx+Ktz7Wos0Bg/fhfGNN6W7LciXZZDzJhDpsJejxC5ngwzrSY3f9
	 aJ/4G5ItQccUA==
Message-ID: <sashiko-outbox-235725@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 06/14] nvme-auth: switch to use 'struct key'
To: "Hannes Reinecke" <hare@kernel.org>, "Keith Busch" <kbusch@kernel.org>, "Jens
 Axboe" <axboe@kernel.dk>, "Christoph Hellwig" <hch@lst.de>, "Sagi Grimberg" <sagi@grimberg.me>, "Hannes
 Reinecke" <hare@suse.de>, "Chaitanya Kulkarni" <kch@nvidia.com>, "Eric
 Biggers" <ebiggers@kernel.org>, "David Howells" <dhowells@redhat.com>, "Jarkko
 Sakkinen" <jarkko@kernel.org>, "Jonathan Corbet" <corbet@lwn.net>, "Shuah
 Khan" <skhan@linuxfoundation.org>, "Randy Dunlap" <rdunlap@infradead.org>, "Kees
 Cook" <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-nvme@lists.infradead.org, keyrings@vger.kernel.org
In-Reply-To: <20261126-dhchap-keyring-v4-v7-6-ee438ffea527@kernel.org>
References: <20261126-dhchap-keyring-v4-v7-0-ee438ffea527@kernel.org>
 <20261126-dhchap-keyring-v4-v7-6-ee438ffea527@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 14:33:18 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] nvme-keyring: nvme_dhchap_psk_create() overwrites
  key_create() error codes
--

commit d2027ac3b70964c8a70b1644b2224565f8d1e622
Author: Hannes Reinecke <hare@kernel.org>

nvme-auth: switch to use 'struct key'

This commit replaces struct nvme_dhchap_key with the kernel keyring's
struct key using the "dhchap" key type for storing and transforming
DH-HMAC-CHAP keys.

> diff --git a/drivers/nvme/common/keyring.c b/drivers/nvme/common/keyring.c
> index 0fc6b4825c2dd..dc0a4fb9296f1 100644
> --- a/drivers/nvme/common/keyring.c
> +++ b/drivers/nvme/common/keyring.c
> @@ -464,6 +464,91 @@ static struct key_type nvme_dhchap_psk_key_type =3D {
>  	.read           =3D nvme_dhchap_psk_read,
>  };
> =20
> +/**
> + * nvme_dhchap_psk_create - Create DH-HMAC-CHAP key
> + * @data: Key data
> + * @data_len: Length of @data
> + *
> + * Creates a new DH-HMAC-CHAP key with a random UUID as the key identity.
> + * Returns the new key or an error pointer on failure.
> + */
> +struct key *nvme_dhchap_psk_create(const char *data, size_t data_len)
> +{
> +	key_perm_t keyperm =3D
> +		KEY_POS_SEARCH | KEY_POS_VIEW | KEY_POS_READ |
> +		KEY_POS_WRITE | KEY_POS_LINK | KEY_POS_SETATTR |
> +		KEY_USR_SEARCH | KEY_USR_VIEW | KEY_USR_READ;
> +	char *identity;
> +	key_ref_t keyref;
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
> +
> +	pr_debug("generate dhchap psk '%s'\n", identity);
> +	keyref =3D key_create(make_key_ref(nvme_keyring, true),
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

[Severity: Medium]
Should this return ERR_CAST(keyref) instead of ERR_PTR(-ENOKEY)?

When key_create() fails in nvme_dhchap_psk_preparse(), such as returning
-EINVAL for a malformed secret or -EKEYREJECTED for a CRC mismatch,
discarding PTR_ERR(keyref) causes nvme_auth_extract_key() callers like
dhchap_secret_store() to report -ENOKEY to userspace instead of the
underlying error code.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126-dhchap-key=
ring-v4-v7-0-ee438ffea527@kernel.org?part=3D6

