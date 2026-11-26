Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCC3606A31C
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Nov 2026 14:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=YQvRChnn;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fwwjUc+P
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=bzF7X//bLpCBs6cSPuMmVlyG/tp4lZhnQW2bHEAVofk=; b=YQvRChnnITgJx5PmKlmBkz1W00
	Ek6sk3kjorFaBBJh2v5jm1pUMuLeNNPdxX8GpqNUEAOSnN+aD3FRrTpuhEYlAtOCeVrA+eTD8MtZ4
	gtSnhyjWKcAY9us0yGBN9SJNxgjYjw831wgxQIuuZqr/dblvxuwVmGyZ5z8NeMBGah11hyJ3SjuOD
	sZ7gBKYVUq+87Cw3/nw7zqxjtf1vAvOHFFmP7fd6NUKB7uZl7pwXpxA2tU922aaWfKS49dBhyITCm
	RazgX3tHHxqMJ3DyMUB4oZaF79e+TgD3s2fkO61eW9Q6TVM5rMfeR9piCGir8JzGWNdaijtVDOto1
	Vll/6wQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWaRV-0000000DXzd-0jBf;
	Thu, 26 Nov 2026 14:27:21 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWaRT-0000000DXzK-39rO
	for linux-nvme@lists.infradead.org;
	Thu, 26 Nov 2026 14:27:20 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 7FD1543693;
	Thu, 26 Nov 2026 14:27:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1551D1F000C6;
	Thu, 26 Nov 2026 14:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795703238;
	bh=bzF7X//bLpCBs6cSPuMmVlyG/tp4lZhnQW2bHEAVofk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fwwjUc+PVuYr/geKSH0AHq5B9/urxue/BLVB8QkSvGU8Fsr9D+O8r6mqnRQQ/ex8X
	 is8QH3eXo/pUnuW2Cpuzy2ZZOa8Y6YPvFUjsfr1mwJ/MzXAOqJuqXPSe5T1fnx+ALX
	 qFtsZaHWvHzHDebnz++fFZndVJVCl8TdAk0umCDVRub3O2AnkRF9bHdPRXGfrCToIw
	 kcmHAZFYrQurvYw2Jf7KvNpB/J2IAnrvScxZ8rw5Ci8J9ZTMW3CBZWzUJQVyFoqzYW
	 i8cUaBrGqvU3HefLF9Uug0djLsv3jAtk5ESDzMKNaF72wVBOQWdkkKOQ6O5S4Fn76M
	 F4a68JVB4YOFQ==
Message-ID: <sashiko-outbox-235701@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 09/14] nvme: allow to pass in key description as
 dhchap secret
To: "Hannes Reinecke" <hare@kernel.org>, "Keith Busch" <kbusch@kernel.org>, "Jens
 Axboe" <axboe@kernel.dk>, "Christoph Hellwig" <hch@lst.de>, "Sagi Grimberg" <sagi@grimberg.me>, "Hannes
 Reinecke" <hare@suse.de>, "Chaitanya Kulkarni" <kch@nvidia.com>, "Eric
 Biggers" <ebiggers@kernel.org>, "David Howells" <dhowells@redhat.com>, "Jarkko
 Sakkinen" <jarkko@kernel.org>, "Jonathan Corbet" <corbet@lwn.net>, "Shuah
 Khan" <skhan@linuxfoundation.org>, "Randy Dunlap" <rdunlap@infradead.org>, "Kees
 Cook" <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-nvme@lists.infradead.org, keyrings@vger.kernel.org
In-Reply-To: <20261126-dhchap-keyring-v4-v7-9-ee438ffea527@kernel.org>
References: <20261126-dhchap-keyring-v4-v7-0-ee438ffea527@kernel.org>
 <20261126-dhchap-keyring-v4-v7-9-ee438ffea527@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 14:27:17 +0000
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
- [High] nvme-auth: ERR_PTR dereference after key_lookup() in show and
  init helpers
- [Medium] nvmet-auth: wrong generated flag updated in
  nvmet_auth_update_key()
--

commit 23f2a5a7beef9101cd52fed1a3096af44469d991
Author: Hannes Reinecke <hare@kernel.org>

nvme: allow to pass in key description as dhchap secret

This commit updates nvme_auth_extract_key() to look up pre-populated
keys by description in addition to generating keys from raw secret data,
and tracks whether keys were auto-generated so pre-populated keys are
not revoked on teardown.

> diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
> index ff0e8569d7067..54e79c8a7cae6 100644
> --- a/drivers/nvme/target/auth.c
> +++ b/drivers/nvme/target/auth.c
> @@ -20,31 +20,38 @@
>  #include "nvmet.h"
> =20
>  static void nvmet_auth_update_key(struct nvmet_host *host, bool set_ctrl,
> -				  struct key *new_key)
> +				  struct key *new_key, bool new_generated)
>  {
>  	key_serial_t old_key_id =3D 0, new_key_id =3D key_serial(new_key);
>  	struct key *key =3D NULL;
> +	bool generated =3D false;
> =20
>  	if (set_ctrl) {
>  		if (host->dhchap_ctrl_key) {
>  			if (host->dhchap_ctrl_key =3D=3D new_key_id) {
> -				if (new_key)
> +				if (new_key && new_generated)
>  					key_revoke(new_key);
>  				return;
>  			}
>  			old_key_id =3D host->dhchap_ctrl_key;
> +			generated =3D host->dhchap_ctrl_key_generated;
> +			host->dhchap_ctrl_key_generated =3D false;
>  		}
>  		host->dhchap_ctrl_key =3D new_key_id;
> +		host->dhchap_key_generated =3D new_generated;

[Severity: Medium]
Should the set_ctrl branch update host->dhchap_ctrl_key_generated instead
of host->dhchap_key_generated?

As written, host->dhchap_ctrl_key_generated remains false, so
nvmet_host_dhchap_ctrl_key_show() prints the internal UUID description
instead of the secret for auto-generated controller keys and replacing or
clearing the controller key never revokes it.  At the same time, setting
or clearing the controller key overwrites host->dhchap_key_generated,
which can cause a pre-populated host key to be revoked or an
auto-generated host key to be leaked.

[ ... ]

> diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configf=
s.c
> index f6bfda757f076..3defa3f948497 100644
> --- a/drivers/nvme/target/configfs.c
> +++ b/drivers/nvme/target/configfs.c
> @@ -2248,13 +2248,15 @@ static ssize_t nvmet_host_dhchap_key_show(struct =
config_item *item,
>  		down_read(&key->sem);
>  		if (key_validate(key))
>  			ret =3D sprintf(page, "<invalidated>\n");
> -		else {
> +		else if (host->dhchap_key_generated) {
>  			ret =3D key->type->read(key, page, PAGE_SIZE);
>  			if (ret > 0) {
>  				page[ret] =3D '\n';
>  				ret++;
>  			}
> -		}
> +		} else
> +			ret =3D scnprintf(page, PAGE_SIZE,
> +					"%s\n", key->description);
>  		up_read(&key->sem);
>  		key_put(key);
>  	}

[Severity: High]
Can nvmet_host_dhchap_key_show() and nvmet_host_dhchap_ctrl_key_show()
dereference an error pointer when the key is unset or has been unlinked?

drivers/nvme/target/configfs.c:nvmet_host_dhchap_key_show() {
	down_read(&nvmet_config_sem);
	key =3D key_lookup(host->dhchap_key);
	if (!key) {
		page[0] =3D '\0';
		ret =3D 0;
	} else {
		down_read(&key->sem);
...
}

key_lookup() returns ERR_PTR(-ENOKEY) rather than NULL when a key serial
is not found (including when host->dhchap_key is 0), so the !key check
falls through to the else branch and dereferences ERR_PTR(-ENOKEY) in
down_read(&key->sem).  nvme_auth_init_ctrl() and nvmet_setup_auth() also
check !host_key and !ctrl_key instead of IS_ERR() after key_lookup(),
which can similarly oops if a pre-populated key was unlinked after option
or configfs parsing dropped its reference.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126-dhchap-key=
ring-v4-v7-0-ee438ffea527@kernel.org?part=3D9

