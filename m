Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332E2606A31C
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Nov 2026 14:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Xfw6dR33;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZroeW6+o
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=P9wshFdtYcyCOkhncepQ/tnlZC/sU0rmaigBNw3t2p4=; b=Xfw6dR332Nou6vaLUT8ehnnNM3
	op0UcRoXohkpFFEXwPR76XIssZ9C9ATdZT4wZwzJC/K5ZL0lRZA6UlBxaJpwvn0ahVkV12uTg4e56
	e4QEJou2DQhpXp3O7c2JiIIfAYDnvbzI1merDW/HhieiUmts1Rb3Fv5FYHgPQYICfHEWLpw4E6xFb
	GU2DK5KtQBjTHLfa5YhtAdLLBGmA2JKmp+J2dYKJ5QBNfrDnsQCOELCXTZz23cdagCL9EIM5gidgA
	62HcixNmw3xDxVDxrsgk84saC4fpvRhbeG2v4bix9XtHJj0vjeleKvicGlDqcQJ+qD8KKqdWRUck2
	769d6wGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWaUw-0000000DYlD-2iYA;
	Thu, 26 Nov 2026 14:30:54 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWaUs-0000000DYk9-2g2f
	for linux-nvme@lists.infradead.org;
	Thu, 26 Nov 2026 14:30:51 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 4034745CEE;
	Thu, 26 Nov 2026 14:30:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5507D1F000ED;
	Thu, 26 Nov 2026 14:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795703450;
	bh=P9wshFdtYcyCOkhncepQ/tnlZC/sU0rmaigBNw3t2p4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZroeW6+onBOTxwaE8tFS29BaIHC9syuHqhwFEHJC6HDxo8VE1QhnClFC3taEToUfp
	 eiuyJCGkrofjBnMkkMMOG6grPSN0VcCE8BH4eY+kZW3Ky9jYAmfHtciPAj205oPBzY
	 i9NPwCrMIbB6ELexL+Pr794OcJZX2xwwzgfoME729HRCGNXwXaJsDmmNq3eIfn0xbJ
	 tQTb1kquek/D9/nUWjiy1vBrV/3f1QdNIh6VDOezwwH/v8+9AP7G3zRUutmdOxMTZv
	 FA3PP4bSOz2SNVaFYIdK4ZrlTMkzeSfd3yw3Zvy970OI3C6wy0NpKtYPGV0nLfELMp
	 8rpYIFGAv3mtg==
Message-ID: <sashiko-outbox-235710@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 13/14] nvme-auth: link pre-provisioned keys into
 .nvme keyring
To: "Hannes Reinecke" <hare@kernel.org>, "Keith Busch" <kbusch@kernel.org>, "Jens
 Axboe" <axboe@kernel.dk>, "Christoph Hellwig" <hch@lst.de>, "Sagi Grimberg" <sagi@grimberg.me>, "Hannes
 Reinecke" <hare@suse.de>, "Chaitanya Kulkarni" <kch@nvidia.com>, "Eric
 Biggers" <ebiggers@kernel.org>, "David Howells" <dhowells@redhat.com>, "Jarkko
 Sakkinen" <jarkko@kernel.org>, "Jonathan Corbet" <corbet@lwn.net>, "Shuah
 Khan" <skhan@linuxfoundation.org>, "Randy Dunlap" <rdunlap@infradead.org>, "Kees
 Cook" <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-nvme@lists.infradead.org, keyrings@vger.kernel.org
In-Reply-To: <20261126-dhchap-keyring-v4-v7-13-ee438ffea527@kernel.org>
References: <20261126-dhchap-keyring-v4-v7-0-ee438ffea527@kernel.org>
 <20261126-dhchap-keyring-v4-v7-13-ee438ffea527@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 14:30:48 +0000
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
- [High] nvme-auth: nvme_keyring_unlink() removes shared or .nvme
  pre-provisioned keys
- [Medium] nvmet-auth: nvmet_auth_update_key() mutates host state before
  linking key
- [Medium] nvmet-auth: nvmet_auth_update_key() sets wrong generated flag
  for ctrl key
- [Low] nvmet-auth: nvmet_auth_update_key() logs new_key serial on
  unlink failure
--

commit 03391c2ce04bdc0cd535d7de4d681251fe291e19
Author: Hannes Reinecke <hare@kernel.org>

nvme-auth: link pre-provisioned keys into .nvme keyring

This commit links pre-provisioned DH-HMAC-CHAP keys into the .nvme keyring
when parsed on the host or set on the target, and unlinks them when the
options or host keys are cleared or replaced.

> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
> index 12a30ed16f9ef..e7f51474ab5e1 100644
> --- a/drivers/nvme/host/fabrics.c
> +++ b/drivers/nvme/host/fabrics.c

[ ... ]

> @@ -1346,23 +1366,27 @@ void nvmf_free_options(struct nvmf_ctrl_options *=
opts)
>  	struct key *key;
> =20
>  	nvmf_host_put(opts->host);
> -	if (opts->dhchap_key &&
> -	    opts->dhchap_key_generated) {
> +	if (opts->dhchap_key) {
>  		key =3D key_lookup(opts->dhchap_key);
>  		if (!IS_ERR(key)) {
> -			pr_debug("revoke dhchap host key %08x\n",
> -				 opts->dhchap_key);
> -			key_revoke(key);
> +			if (opts->dhchap_key_generated) {
> +				pr_debug("revoke dhchap host key %08x\n",
> +					 opts->dhchap_key);
> +				key_revoke(key);
> +			} else
> +				nvme_keyring_unlink(key);
>  			key_put(key);
>  		}
>  	}

[Severity: High]
Does nvme_keyring_unlink() remove a pre-provisioned key that originally
lived in the .nvme keyring or is shared across multiple controllers?

Keyring links are indexed by key type and description rather than
reference-counted, so key_link() replaces an existing link in .nvme in
place and key_unlink() deletes that sole link.  A pre-provisioned key
placed directly in .nvme (as required when looking up keys by description
via nvme_dhchap_psk_lookup()) is removed from .nvme as soon as the first
controller disconnects or fails to connect, and a key from another keyring
that is shared across controllers or target hosts is unlinked from .nvme
while other users still depend on it.

[ ... ]

> diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
> index 54e79c8a7cae6..04a9177ffa1f4 100644
> --- a/drivers/nvme/target/auth.c
> +++ b/drivers/nvme/target/auth.c
> @@ -19,19 +19,20 @@
> =20
>  #include "nvmet.h"
> =20
> -static void nvmet_auth_update_key(struct nvmet_host *host, bool set_ctrl,
> +static int nvmet_auth_update_key(struct nvmet_host *host, bool set_ctrl,
>  				  struct key *new_key, bool new_generated)
>  {
>  	key_serial_t old_key_id =3D 0, new_key_id =3D key_serial(new_key);
>  	struct key *key =3D NULL;
>  	bool generated =3D false;
> +	int ret;
> =20
>  	if (set_ctrl) {
>  		if (host->dhchap_ctrl_key) {
>  			if (host->dhchap_ctrl_key =3D=3D new_key_id) {
>  				if (new_key && new_generated)
>  					key_revoke(new_key);
> -				return;
> +				return 0;
>  			}
>  			old_key_id =3D host->dhchap_ctrl_key;
>  			generated =3D host->dhchap_ctrl_key_generated;
> @@ -44,7 +45,7 @@ static void nvmet_auth_update_key(struct nvmet_host *ho=
st, bool set_ctrl,

[Severity: Medium]
In the set_ctrl branch of nvmet_auth_update_key(), does
"host->dhchap_key_generated =3D new_generated" right after
"host->dhchap_ctrl_key =3D new_key_id" overwrite the host key's flag instead
of host->dhchap_ctrl_key_generated?

That leaves host->dhchap_ctrl_key_generated false so generated controller
keys are unlinked instead of revoked, while clobbering
host->dhchap_key_generated so a pre-provisioned host key can be revoked by
key_revoke() when later replaced or cleared.

>  			if (host->dhchap_key =3D=3D new_key_id) {
>  				if (new_key && new_generated)
>  					key_revoke(new_key);
> -				return;
> +				return 0;
>  			}
>  			old_key_id =3D host->dhchap_key;
>  			generated =3D host->dhchap_key_generated;
> @@ -53,18 +54,37 @@ static void nvmet_auth_update_key(struct nvmet_host *=
host, bool set_ctrl,
>  		host->dhchap_key =3D new_key_id;
>  		host->dhchap_key_generated =3D new_generated;
>  	}
> +	if (new_key && !new_generated) {
> +		ret =3D nvme_keyring_link(new_key);
> +		if (ret < 0) {
> +			pr_warn("%s: failed to link %s key %08x\n",
> +				__func__, set_ctrl ? "ctrl" : "host",
> +				key_serial(new_key));
> +			return ret;
> +		}
> +	}

[Severity: Medium]
If nvme_keyring_link(new_key) fails here, does this early return leave
host->dhchap_key or host->dhchap_ctrl_key updated to new_key_id while
leaking old_key_id?

Because the host fields are overwritten before linking new_key, an error
from nvme_keyring_link() skips revoking or unlinking old_key_id and leaves
the unlinked new_key_id installed on host.

> +
>  	if (!old_key_id)
> -		return;
> +		return 0;
> =20
>  	key =3D key_lookup(old_key_id);
>  	if (IS_ERR(key))
> -		return;
> +		return PTR_ERR(key);
>  	if (generated) {
>  		pr_debug("%s: revoke %s key %08x\n", __func__,
>  			 set_ctrl ? "ctrl" : "host", key_serial(key));
>  		key_revoke(key);
> +		ret =3D 0;
> +	} else {
> +		ret =3D nvme_keyring_unlink(key);
> +		if (ret < 0) {
> +			pr_warn("%s: failed to unlink %s key %08x\n",
> +				__func__, set_ctrl ? "ctrl" : "host",
> +				key_serial(new_key));
> +		}
>  	}

[Severity: Low]
Should this pr_warn() log key_serial(key) instead of key_serial(new_key)
when unlinking the old key fails?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126-dhchap-key=
ring-v4-v7-0-ee438ffea527@kernel.org?part=3D13

