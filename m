Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9028F606A325
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Nov 2026 11:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=fbJDWq5m;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GAn6dcht
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=P4p7+dT3o2H+gIQ6QbsyjQ17mHeKcLqHzY5Tmfoma+U=; b=fbJDWq5mrMzfStVrlUiOnfQph/
	L1ueUzyJm6rhkK49Q7ZOMcMeOYv6m/9EnJ5o4rFm+uVjHKD2/hFvOIeDBnIy/JsCFSda3thBV0W2S
	iBR1jxmgvjNKFLs+6rI0XNuqG3OYWwNP/YalDlHBmDuKTP/v8GdCVC1Jg7eXcvNhjRV4l1uWUy9Xt
	44ujArMk99cX+s4A6bKxfIlfppNBIkidzDKmoU5VpBXrn4j7LNEath55blI5WUXRHhQ8G4LiqDtOA
	LbAdPHBU4+EQRfX3AJpgm9K6gCa45RtqOaftVFcWRF5nNQBwa1gCsF9S849j+4Mbjdz+a2Gwaf7Pd
	Q2kP6YnQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUMxZ-0000000EpTB-4Bpz;
	Fri, 20 Nov 2026 11:39:18 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUMxY-0000000EpT4-2Qi0
	for linux-nvme@lists.infradead.org;
	Fri, 20 Nov 2026 11:39:16 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 5604043079
	for <linux-nvme@lists.infradead.org>; Fri, 20 Nov 2026 11:39:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84B5D1F000C4;
	Fri, 20 Nov 2026 11:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795174755;
	bh=P4p7+dT3o2H+gIQ6QbsyjQ17mHeKcLqHzY5Tmfoma+U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GAn6dchtdcnqY253SB9g0zBiVOHAfXCpQOxLkK3QwhBXqPT8qmni9SU6CTc/WtKVP
	 dX+TezFOyma/1rhRMgF252B6bwBeWdQ+X6FqSaGZiiHm1/Ig2zGzki95iUBcP0BkA+
	 +TKI47mponOV42Ep93sSd4s4fb5ohjuErlnMufYakSvDkpraJ09wpgWGmsfq+hfYUB
	 Tcypb9HaE7xgO6LiHjUEtILYhW8k5vIjMZucui1Kal8pilMnSskop4c7xwLSPuR3F+
	 V0/lm2SQRUjeUPz6TcmoehtGe91g+iaRWNJ1vs6esga97ysFa5BhQBhKRwzMyRaATN
	 8fL2COCag99zA==
Message-ID: <sashiko-outbox-225082@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 9/9] nvmet: add configfs attribute 'dhchap_keyring'
To: "Hannes Reinecke" <hare@kernel.org>
Cc: linux-nvme@lists.infradead.org
In-Reply-To: <20261120-dhchap-keyring-v4-v4-9-5f8c7d9926ee@kernel.org>
References: <20261120-dhchap-keyring-v4-v4-0-5f8c7d9926ee@kernel.org>
 <20261120-dhchap-keyring-v4-v4-9-5f8c7d9926ee@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 11:39:15 +0000
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
- [High] nvmet: keyring reference leak in nvmet_host_release()
- [Medium] nvmet: inverted error return sign in
  nvmet_host_dhchap_keyring_store()
- [Medium] nvmet: unlocked host->dhchap_keyring access in
  nvmet_auth_set_key()
- [Medium] nvmet: 1-byte OOB write in nvmet_host_dhchap_keyring_show()
  via sprintf()
--

commit 7f1bb5c7e432b0938e23615bf24751f61d823e03
Author: Hannes Reinecke <hare@kernel.org>

nvmet: add configfs attribute 'dhchap_keyring'

This commit adds a dhchap_keyring configfs attribute to the nvmet host
directory so userspace can specify the keyring used for DH-HMAC-CHAP key
lookups.

> diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
> index 4f2489c5d894b..d583813ef4f27 100644
> --- a/drivers/nvme/target/auth.c
> +++ b/drivers/nvme/target/auth.c
> @@ -68,7 +68,7 @@ int nvmet_auth_set_key(struct nvmet_host *host, const c=
har *secret,
>  		return 0;
>  	}
>  	len =3D strcspn(secret, "\n");
> -	key =3D nvme_auth_extract_key(NULL, secret, len, &generated);
> +	key =3D nvme_auth_extract_key(host->dhchap_keyring, secret, len, &gener=
ated);
>  	if (IS_ERR(key)) {
>  		pr_debug("%s: invalid key specification\n", __func__);
>  		return PTR_ERR(key);

[Severity: Medium]
Can a concurrent write to dhchap_keyring free host->dhchap_keyring while
nvmet_auth_set_key() is using it?

CPU0                                    CPU1
nvmet_host_dhchap_key_store()
  nvmet_auth_set_key()
    keyring =3D host->dhchap_keyring
                                        nvmet_host_dhchap_keyring_store()
                                          down_write(&nvmet_config_sem)
                                          key_put(host->dhchap_keyring)
                                          host->dhchap_keyring =3D new_ring
                                          up_write(&nvmet_config_sem)
    nvme_auth_extract_key(keyring, ...)
      ...                               <-- use-after-free

nvmet_host_dhchap_keyring_store() replaces host->dhchap_keyring and drops
the old reference under nvmet_config_sem, whereas nvmet_auth_set_key()
reads and uses host->dhchap_keyring without holding nvmet_config_sem or
pinning it with key_get().

> diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configf=
s.c
> index 319947aa0a40f..ffe0f852e59d9 100644
> --- a/drivers/nvme/target/configfs.c
> +++ b/drivers/nvme/target/configfs.c
> @@ -2347,6 +2347,62 @@ static ssize_t nvmet_host_dhchap_ctrl_key_store(st=
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
Can sprintf() write one byte past the end of page here?

add_key() accepts descriptions up to 4095 bytes (KEY_MAX_DESC_SIZE - 1),
and configfs fill_write_buffer() accepts a 4095-byte write without a
trailing newline.  Formatting a 4095-byte keyring->description with "%s\n"
writes 4097 bytes (including the NUL terminator) into the 4096-byte
PAGE_SIZE configfs read buffer.  Using sysfs_emit() or snprintf(page,
PAGE_SIZE, ...) would avoid the overflow.

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
> +	return ret ? -ret : count;
> +}

[Severity: Medium]
Does negating ret return a positive value when request_key() fails?
PTR_ERR(keyring) is already negative, so returning -ret causes
configfs_write_iter() to treat the positive errno as a successful write
byte count and silently ignore the failure.

[ ... ]

> @@ -2445,6 +2502,11 @@ static struct config_group *nvmet_hosts_make_group=
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
> =20
>  	config_group_init_type_name(&host->group, name, &nvmet_host_type);

[Severity: High]
Does removing a host group leak host->dhchap_keyring?

Both key_lookup() here and request_key() in
nvmet_host_dhchap_keyring_store() acquire a reference on
host->dhchap_keyring, but nvmet_host_release() never calls
key_put(host->dhchap_keyring):

drivers/nvme/target/configfs.c:nvmet_host_release() {
	struct nvmet_host *host =3D to_host(item);

#ifdef CONFIG_NVME_TARGET_AUTH
	nvmet_auth_revoke_key(host, false);
	nvmet_auth_revoke_key(host, true);
#endif
	kfree(host);
}

Every removed host configfs directory leaks a reference on its configured
keyring.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120-dhchap-key=
ring-v4-v4-0-5f8c7d9926ee@kernel.org?part=3D9

