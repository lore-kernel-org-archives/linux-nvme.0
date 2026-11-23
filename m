Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36626606A68B
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Nov 2026 12:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=xFKo3VNZ;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P9N9wf6/
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=ukA5JlJemlbaumtfSq/3DOtQML6qJIIswA49TIqmLok=; b=xFKo3VNZuV/RMwl/49/DCVDp53
	+Ihr78YhPM3IPrQzyP5Je9GUCypI9c5umLoIw8PiFKXG5ZsVaPrUKRQPUkzN4QXRlCcjhSMfzfKxv
	E8Sb9zSOD7GDDcH8AVtGOCDu/evoobfjB/6gViWpeDD0H4UIIUfu1s+7dUIPBG4Re1Kw7FjWjecgR
	HW+59MCUkAoQY/dHTQE1YCwJWlyCPaZnMVczKZt9x6rn/QWka0dfLw0Lgk6SYIesCFtgJlfok8UTz
	SIU346NMUOY1ay/tpkjj48xjP8dbpU5MEMg6YgH7P4KHxCAM81QKRS/+yyOG0eicsTaEFMDJPwGCc
	bWEgp9HA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVTGb-00000003Npn-2CPd;
	Mon, 23 Nov 2026 12:35:30 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVTGZ-00000003Np1-3Q1z
	for linux-nvme@lists.infradead.org;
	Mon, 23 Nov 2026 12:35:27 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 9087E40C41
	for <linux-nvme@lists.infradead.org>; Mon, 23 Nov 2026 12:35:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43B6F1F000D0;
	Mon, 23 Nov 2026 12:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795437327;
	bh=ukA5JlJemlbaumtfSq/3DOtQML6qJIIswA49TIqmLok=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=P9N9wf6/iTLvfF7beOM6zqED5jegUPnVrMJdjRy6orXkI8F4VcILAdmyoF4ebFlBb
	 XyFUjZ05nyrOYqkGfB5Ool5U1D0P6brBFyrGok6JGfgXzgErF6tSGraOKj/vWoV74y
	 dhkam/GC/zW9OOfXxaGBaCndJA7gxU5WM9qwJYC4y8V9/UekgDL8sJQxQC5wHTqRt7
	 5c6JDZCyNZXUkCvrv6wPDhztq304NPd9XHv8QT21kCCavltLI1ok89q7f/UqhGgtnb
	 4shSrUpO7TbsVALqWXcMbqUohiEKbUUxVvuy3uSe79yE8N8NcfPPFZYH+cn9Sierjw
	 RuzAmz+rvHcHQ==
Message-ID: <sashiko-outbox-229228@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 9/9] nvmet: add configfs attribute 'dhchap_keyring'
To: "Hannes Reinecke" <hare@kernel.org>
Cc: linux-nvme@lists.infradead.org
In-Reply-To: <20261123-dhchap-keyring-v4-v5-9-81eefb4c0724@kernel.org>
References: <20261123-dhchap-keyring-v4-v5-0-81eefb4c0724@kernel.org>
 <20261123-dhchap-keyring-v4-v5-9-81eefb4c0724@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 12:35:26 +0000
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
- [High] nvmet: NULL pointer dereference in nvmet_auth_set_key() when
  clearing key
- [Medium] nvmet: cannot write or reset .nvme in
  nvmet_host_dhchap_keyring_store()
- [Medium] nvmet: 1-byte OOB write in nvmet_host_dhchap_keyring_show()
  via sprintf()
--

commit 1e868858e36190db74c6e7c75fe1ba260a535d71
Author: Hannes Reinecke <hare@kernel.org>

nvmet: add configfs attribute 'dhchap_keyring'

This commit adds a dhchap_keyring configfs attribute to the nvmet host
group so userspace can select which keyring is used to look up DH-HMAC-CHAP
keys.

> diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
> index 7204ace149565..84091803af300 100644
> --- a/drivers/nvme/target/auth.c
> +++ b/drivers/nvme/target/auth.c
> @@ -68,7 +68,9 @@ int nvmet_auth_set_key(struct nvmet_host *host, const c=
har *secret,
>  		return 0;
>  	}
>  	len =3D strcspn(secret, "\n");
> -	key =3D nvme_auth_extract_key(NULL, secret, len, &generated);
> +	down_read(&nvmet_config_sem);
> +	key =3D nvme_auth_extract_key(host->dhchap_keyring, secret, len, &gener=
ated);
> +	up_read(&nvmet_config_sem);
>  	if (IS_ERR(key)) {
>  		pr_debug("%s: invalid key specification\n", __func__);
>  		return PTR_ERR(key);

[Severity: High]
Does nvmet_auth_set_key() dereference a NULL secret when clearing a key via
configfs?

Earlier in this series, commit "nvmet-auth: parse dhchap key from configfs
attribute" updated nvmet_host_dhchap_key_store() and
nvmet_host_dhchap_ctrl_key_store() to leave keydata as NULL when an empty
line is written:

drivers/nvme/target/configfs.c:nvmet_host_dhchap_key_store() {
	...
	len =3D strcspn(page, "\n");
	if (len) {
		keydata =3D kstrndup(page, len, GFP_KERNEL);
		if (!keydata)
			return -ENOMEM;
	}

	ret =3D nvmet_auth_set_key(host, keydata, false);
	...
}

nvmet_auth_set_key() then checks if (!strlen(secret)) without testing
!secret first, triggering a NULL pointer dereference whenever an empty
string or newline is written to dhchap_key or dhchap_ctrl_key to revoke a
configured key.

> diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configf=
s.c
> index bc46d760aaa4a..eb20599cf372d 100644
> --- a/drivers/nvme/target/configfs.c
> +++ b/drivers/nvme/target/configfs.c
> @@ -2348,6 +2348,62 @@ static ssize_t nvmet_host_dhchap_ctrl_key_store(st=
ruct config_item *item,
> =20
>  CONFIGFS_ATTR(nvmet_host_, dhchap_ctrl_key);
> =20
> +static ssize_t nvmet_host_dhchap_keyring_show(struct config_item *item,
> +		char *page)
> +{
> +	struct nvmet_host *host =3D to_host(item);
> +	struct key *keyring;
> +	ssize_t ret;
> +
> +	down_read(&nvmet_config_sem);
> +	keyring =3D key_get(host->dhchap_keyring);
> +	if (!keyring) {
> +		page[0] =3D '\0';
> +		ret =3D 0;
> +	} else {
> +		down_read(&keyring->sem);
> +		if (key_validate(keyring))
> +			ret =3D sprintf(page, "<invalidated>\n");
> +		else
> +			ret =3D sprintf(page, "%s\n", keyring->description);
> +		up_read(&keyring->sem);
> +		key_put(keyring);
> +	}
> +	up_read(&nvmet_config_sem);
> +	return ret;
> +}

[Severity: Medium]
Can sprintf(page, "%s\n", keyring->description) write one byte past the end
of the PAGE_SIZE configfs read buffer?

add_key() allows keyring descriptions of up to KEY_MAX_DESC_SIZE - 1 (4095)
bytes, and writing a 4095-byte description without a trailing newline to
dhchap_keyring succeeds in nvmet_host_dhchap_keyring_store().  Reading
dhchap_keyring afterwards writes 4095 description bytes, a newline, and a
NUL terminator at page[4096], overflowing the 4096-byte buffer by one byte.
Using snprintf(page, PAGE_SIZE, ...) avoids the out-of-bounds write.

> +
> +static ssize_t nvmet_host_dhchap_keyring_store(struct config_item *item,
> +		const char *page, size_t count)
> +{
> +	struct nvmet_host *host =3D to_host(item);
> +	struct key *keyring;
> +	char *desc;
> +	size_t len;
> +	int ret =3D 0;
> +
> +	len =3D strcspn(page, "\n");
> +	if (!len)
> +		return -EINVAL;
> +	desc =3D kstrndup(page, len, GFP_KERNEL);
> +	if (!desc)
> +		return -ENOMEM;
> +	keyring =3D request_key(&key_type_keyring, desc, NULL);
> +	if (IS_ERR(keyring)) {
> +		ret =3D PTR_ERR(keyring);
> +	} else {
> +		down_write(&nvmet_config_sem);
> +		key_put(host->dhchap_keyring);
> +		host->dhchap_keyring =3D keyring;
> +		up_write(&nvmet_config_sem);
> +	}
> +	kfree(desc);
> +
> +	return ret < 0 ? ret : count;
> +}

[ ... ]

> @@ -2446,6 +2504,11 @@ static struct config_group *nvmet_hosts_make_group=
(struct config_group *group,
>  #ifdef CONFIG_NVME_TARGET_AUTH
>  	/* Default to SHA256 */
>  	host->dhchap_hash_id =3D NVME_AUTH_HASH_SHA256;
> +	host->dhchap_keyring =3D key_lookup(nvme_keyring_id());
> +	if (IS_ERR(host->dhchap_keyring)) {
> +		kfree(host);
> +		return ERR_PTR(-ENOKEY);
> +	}
>  #endif

[Severity: Medium]
Can userspace restore or reset dhchap_keyring back to the default .nvme
keyring through nvmet_host_dhchap_keyring_store()?

nvmet_hosts_make_group() initializes host->dhchap_keyring to the .nvme
keyring via key_lookup(nvme_keyring_id()), so reading dhchap_keyring shows
".nvme" (and the !keyring branch in nvmet_host_dhchap_keyring_show() is
unreachable).  However, nvme_keyring_init() allocates .nvme without linking
it into any process keyring, while nvmet_host_dhchap_keyring_store() looks
up desc via request_key(&key_type_keyring, desc, NULL), which only searches
the calling process's keyrings and rejects empty writes with -EINVAL.

As a result, tools such as nvmetcli that save and restore configfs
attributes fail with -ENOKEY when writing ".nvme" back unless .nvme was
manually linked into the caller's session keyring, and writing an empty
value to reset dhchap_keyring to the default fails with -EINVAL.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123-dhchap-key=
ring-v4-v5-0-81eefb4c0724@kernel.org?part=3D9

