Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11015606A333
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Nov 2026 17:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=jlYrqasF;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RJDhOIIw
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=MINZ9cxyybLTXhDc3p4zukM7MQc3QBKqAdhTnoECCYo=; b=jlYrqasF0lmIuHKWQJO0+yz6vq
	YmbKf3bkS/Q2eGEarf+0/DoIde7xuGs6OXjaYsIN68aShYhwHkakSPBYhp0LORGqm2Lg8Pvru6w20
	mmUFhy53rCf8FoBcPRvknl74H+JHrU5oCk/TZo4jKBc5zLigd8lqFOWSXcHqkrE/kswimYr2dQu/U
	ULd9uIx+YJstA18jb0IZaJhYKnigIOtbC+JsV+XI2gEa4oFKYRPkYYALXWerD/ivWmtfguxldoLpq
	abgJLUHIY2Wv2hOm07IoQ4YBu0CKcIoPU+ieyaYKpFXFjelaU7qPyuGf0+DdeAo1vhn1uAU31E6w8
	0h/tjm7w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVXur-00000004NNp-2CBS;
	Mon, 23 Nov 2026 17:33:21 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVXuk-00000004NLB-2FB2
	for linux-nvme@lists.infradead.org;
	Mon, 23 Nov 2026 17:33:19 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 4A8D74018E
	for <linux-nvme@lists.infradead.org>; Mon, 23 Nov 2026 17:33:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EA2C1F000CF;
	Mon, 23 Nov 2026 17:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795455193;
	bh=MINZ9cxyybLTXhDc3p4zukM7MQc3QBKqAdhTnoECCYo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RJDhOIIwu+UsZWCEqDoaadzKPNJdUuGZ32ExhSgYDvzXAhvP7DHE7NaC2P0aPzWlC
	 dGsokRCTCvG3vaB6uUOgSZmJ+8D6EQDq3rcPktURobSyWeTvSMpsD2X0Simrio0R4U
	 cNXwGeULLlBLYG4UA3oOJFYfuke1FOr7x0iMqpcf/DulNhF+qbpxy8J8Vam28Bx8g4
	 voxDKidcDRYfavMr9mjHsajgyIIaf+fUb8Yh7xVKHs8WBlrKIUdMPv66kjNSFlOUAY
	 QAe5uqXhQbabOju22b9/XlSMvi9Q/cDPOSfpfAD6QccJMp8AsWDlqyMyDaBwMQr9RM
	 P6xV2N5Tej5yQ==
Message-ID: <sashiko-outbox-229765@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 9/9] nvmet: add configfs attribute 'dhchap_keyring'
To: "Hannes Reinecke" <hare@kernel.org>
Cc: linux-nvme@lists.infradead.org
In-Reply-To: <20261123-dhchap-keyring-v4-v6-9-5082a49715ab@kernel.org>
References: <20261123-dhchap-keyring-v4-v6-0-5082a49715ab@kernel.org>
 <20261123-dhchap-keyring-v4-v6-9-5082a49715ab@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 17:33:13 +0000
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
- [Medium] nvmet: writing .nvme to nvmet_host_dhchap_keyring_store()
  fails with -ENOKEY
--

commit 11d3b355e4b75a4b62f576abb3e457739f6b882d
Author: Hannes Reinecke <hare@kernel.org>

nvmet: add configfs attribute 'dhchap_keyring'

This commit adds a dhchap_keyring configfs attribute to the nvmet host
directory so userspace can configure the keyring used for DH-HMAC-CHAP key
lookups.

> diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configf=
s.c
> index e19af764561ec..179f6bef77372 100644
> --- a/drivers/nvme/target/configfs.c
> +++ b/drivers/nvme/target/configfs.c
> @@ -2350,6 +2350,64 @@ static ssize_t nvmet_host_dhchap_ctrl_key_store(st=
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
> +			ret =3D scnprintf(page, PAGE_SIZE,
> +					"%s\n", keyring->description);
> +		up_read(&keyring->sem);
> +		key_put(keyring);
> +	}
> +	up_read(&nvmet_config_sem);
> +	return ret;
> +}
> +
> +static ssize_t nvmet_host_dhchap_keyring_store(struct config_item *item,
> +		const char *page, size_t count)
> +{
> +	struct nvmet_host *host =3D to_host(item);
> +	struct key *keyring;
> +	char *desc =3D NULL;
> +	size_t len;
> +	int ret =3D 0;
> +
> +	len =3D strcspn(page, "\n");
> +	if (len) {
> +		desc =3D kstrndup(page, len, GFP_KERNEL);
> +		if (!desc)
> +			return -ENOMEM;
> +		keyring =3D request_key(&key_type_keyring, desc, NULL);
> +	} else
> +		keyring =3D key_lookup(nvme_keyring_id());

[Severity: Medium]
Does writing ".nvme" to dhchap_keyring fail with -ENOKEY?

nvmet_hosts_make_group() initializes host->dhchap_keyring via
key_lookup(nvme_keyring_id()), so nvmet_host_dhchap_keyring_show() outputs
".nvme" by default (making the !keyring branch in show unreachable).
However, nvme_keyring_init() allocates the ".nvme" keyring with dest set to
NULL, so it is not linked into the calling task's process keyrings.

When a tool such as nvmetcli saves and restores the configuration by
writing ".nvme" back to dhchap_keyring, len is non-zero and
nvmet_host_dhchap_keyring_store() calls request_key(), which searches only
the process keyrings and fails with -ENOKEY unless ".nvme" was manually
linked into them.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123-dhchap-key=
ring-v4-v6-0-5082a49715ab@kernel.org?part=3D9

