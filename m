Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB7A606A68B
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Nov 2026 14:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=r+CU2pez;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D7bR497l
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=hbJvix+pEN3wYWsB9mjyNccyf1Am2M7XJBMuN4g3MLU=; b=r+CU2pezGa5KzzuSDtZXCNNG7n
	on3AiT3n0Tls3R5yWHrPrRM4fnSXDnz0aWMNjmnoEDOnZpUIRqK4Lxac8uQ0eB7Jc1OMiskyNYnHk
	u1gEyVvAGMfPbVzo1XFr63I5fGMsmc4ZiCdwrBUJep4dI7cmsb5EQhzYCiBiy/sCC9JBrBTkxSMv+
	eohRv7kRCnKUy3KHVJHwToULogWVmbVJfYm5s7/OotxAawcerSr2pb+08yNlOu9r/j5eI3lmCJyG3
	Qmrph7FBZxqYzvOp6Lp4pNMas4QvViH5m1+Rw2oOgUI6h7EIIxQLh+X4gzIzlahpsrIu0tpft1C5p
	eMqD0cCg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWaW1-0000000DZEt-0jq6;
	Thu, 26 Nov 2026 14:32:01 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWaW0-0000000DZE4-19Ik
	for linux-nvme@lists.infradead.org;
	Thu, 26 Nov 2026 14:32:00 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 0C73D4162F;
	Thu, 26 Nov 2026 14:32:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C6AB1F000C4;
	Thu, 26 Nov 2026 14:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795703519;
	bh=hbJvix+pEN3wYWsB9mjyNccyf1Am2M7XJBMuN4g3MLU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=D7bR497lt3X8xX/rFM9SpfPdHXGSYoDqdD0l5iZHsn0Aoq8CrSoQCIhbzlCN3pHx+
	 zOGPH17zRC4bdR10+Q1kMnWsPAEgmWMn8kAzolqYMJUaIBw3bl/XxQdEs3NeOUAuDK
	 pa0stz7Ih5SrTgFsvSmVL9L4SMwFI1m2SUWEWV7xd9T7FwGvNSH4DaZqIXuepY8vT3
	 K576v9lsDER40muwjsJC6/9Q/+HOeNAveVIJo3i3Dw/98Bkldspk83/6k4CsEw6A96
	 SYnCEaHssTdMdzuryqbwPwFQ6GFk0tG4OyA7o+MA43tBLhQD+punHM5MToEtDEQBlB
	 5B+EInT8UjPJA==
Message-ID: <sashiko-outbox-235712@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 14/14] nvme-auth: allow to update pre-provisioned
 keys
To: "Hannes Reinecke" <hare@kernel.org>, "Keith Busch" <kbusch@kernel.org>, "Jens
 Axboe" <axboe@kernel.dk>, "Christoph Hellwig" <hch@lst.de>, "Sagi Grimberg" <sagi@grimberg.me>, "Hannes
 Reinecke" <hare@suse.de>, "Chaitanya Kulkarni" <kch@nvidia.com>, "Eric
 Biggers" <ebiggers@kernel.org>, "David Howells" <dhowells@redhat.com>, "Jarkko
 Sakkinen" <jarkko@kernel.org>, "Jonathan Corbet" <corbet@lwn.net>, "Shuah
 Khan" <skhan@linuxfoundation.org>, "Randy Dunlap" <rdunlap@infradead.org>, "Kees
 Cook" <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-nvme@lists.infradead.org, keyrings@vger.kernel.org, "Martin
 Belanger" <martin.nvme.dev@gmail.com>
In-Reply-To: <20261126-dhchap-keyring-v4-v7-14-ee438ffea527@kernel.org>
References: <20261126-dhchap-keyring-v4-v7-0-ee438ffea527@kernel.org>
 <20261126-dhchap-keyring-v4-v7-14-ee438ffea527@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 14:31:58 +0000
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
- [High] nvme-auth: uninitialized old_key dereference in
  dhchap_*_secret_store()
- [High] nvme-keyring: .update callback added to psk instead of dhchap
  key_type
- [Medium] nvme-auth: wrong pre-populated key check in
  dhchap_*_secret_store()
--

commit 3ccb1f2ff3d815bafe5e4d68e5e266a56f5a6f51
Author: Hannes Reinecke <hare@kernel.org>

nvme-auth: allow to update pre-provisioned keys

This commit attempts to support rotating pre-provisioned DH-HMAC-CHAP keys
via keyctl update by adding a key_type .update callback and disallowing
sysfs key replacements for pre-populated controller keys.

> diff --git a/drivers/nvme/common/keyring.c b/drivers/nvme/common/keyring.c
> index bee64c592752a..ffabd37cd090d 100644
> --- a/drivers/nvme/common/keyring.c
> +++ b/drivers/nvme/common/keyring.c
> @@ -100,6 +100,7 @@ static struct key_type nvme_tls_psk_key_type =3D {
>  	.free_preparse  =3D user_free_preparse,
>  	.match_preparse =3D nvme_tls_psk_match_preparse,
>  	.instantiate    =3D generic_key_instantiate,
> +	.update         =3D user_update,
>  	.revoke         =3D user_revoke,
>  	.destroy        =3D user_destroy,
>  	.describe       =3D nvme_tls_psk_describe,

[Severity: High]
Was .update added to nvme_tls_psk_key_type instead of
nvme_dhchap_psk_key_type?  Because nvme_dhchap_psk_key_type still has no
.update callback, calling keyctl update on a dhchap key fails with
-EOPNOTSUPP.

> diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
> index 0ffea12fcfb6b..0eb68b3973a1e 100644
> --- a/drivers/nvme/host/sysfs.c
> +++ b/drivers/nvme/host/sysfs.c
> @@ -887,9 +887,17 @@ static ssize_t dhchap_secret_store(struct device *de=
v,
>  		kfree_sensitive(dhchap_secret);
>  		return ret;
>  	}
> +	if (!generated &&
> +	    key_serial(old_key) !=3D key_serial(key)) {

[Severity: Medium]
Should this check !ctrl->host_key_generated under ctrl->dhchap_auth_mutex
instead of !generated (and similarly !ctrl->ctrl_key_generated in
dhchap_ctrl_secret_store())?

nvme_auth_extract_key() sets generated based on whether the newly written
sysfs input is a raw DHHC-1 secret or an existing key lookup, not whether
the controller's current key was pre-populated.  Writing a raw DHHC-1
secret sets generated =3D true, bypassing this check and overwriting a
pre-populated ctrl->host_key with a newly generated key, while writing a
pre-populated key identifier to a controller that currently uses a
generated key is rejected with -EPERM.

> +		dev_warn(ctrl->device, "cannot change pre-populated key %08x\n",
> +			 key_serial(old_key));
> +		key_put(key);
> +		kfree_sensitive(dhchap_secret);
> +		return -EPERM;
> +	}
>  	mutex_lock(&ctrl->dhchap_auth_mutex);
>  	old_key =3D ctrl->host_key;

[Severity: High]
Does key_serial(old_key) dereference an uninitialized old_key pointer in
both dhchap_secret_store() and dhchap_ctrl_secret_store()?

old_key is declared on the stack without an initializer and is only
assigned from ctrl->host_key (or ctrl->ctrl_key) after acquiring
ctrl->dhchap_auth_mutex below.  When writing a pre-populated key to sysfs
(generated =3D=3D false), key_serial(old_key) reads old_key->serial from the
uninitialized pointer, or returns 0 when CONFIG_INIT_STACK_ALL_ZERO=3Dy and
causes every re-authentication write to fail with -EPERM.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126-dhchap-key=
ring-v4-v7-0-ee438ffea527@kernel.org?part=3D14

