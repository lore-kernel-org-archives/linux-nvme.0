Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FEA606A31A
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Nov 2026 17:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=UHibapEm;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HT5Lfx9f
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=viczR+ECZn4ml27Q5qrdEk+oMwYKBqYz6CVa4yr3QGo=; b=UHibapEmgijCDpzcF80MpnF0Aj
	riQ2WpFboTIOdsLf72AUWbgjtTfs81rsqTJVGO9Bk0u4xg+cCC82rOLOEHhBLe6FqoU4G8+rPY8Fz
	svnuJ5g5VdB+gCaWCJQ8ACJBPBrKqcUEfmUvmdKksYaxmE3VX/Huv3iuzMEBod478DtNRoKkKHyI7
	GvdACbwaotWkaoS9lgwdNwqSPkR96NxvQdh5O5adZUf1o5JqHp2QK4c63S0FQQlIVxYHWCoqIGSwE
	bIjQx93/Iqz7ZvbwT6SZlrr3+6VJigArK6R+vatAuSfXwQLGFV5PHjcWpL008ENr4BPVViN8NKZRe
	mWV796jw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVXu7-00000004NA1-1EHb;
	Mon, 23 Nov 2026 17:32:35 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVXu5-00000004N9N-3yzn
	for linux-nvme@lists.infradead.org;
	Mon, 23 Nov 2026 17:32:34 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 66D6D611E0
	for <linux-nvme@lists.infradead.org>; Mon, 23 Nov 2026 17:32:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E95601F000D2;
	Mon, 23 Nov 2026 17:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795455153;
	bh=viczR+ECZn4ml27Q5qrdEk+oMwYKBqYz6CVa4yr3QGo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HT5Lfx9fwwAbck5CAyBgBpq7PqGeaDpv0lSezqGeX9676w7mXKeo3NbneBWoN5HFV
	 N7X/DvWMhKZByhBLf+111R6z3VTF5YSNo008YnVzJ/pgBOl8m23cBzdFjCMaJLfZAw
	 qInBmmz3pNd2xtiwZuNUfA06sAKFbZbKCxCUz5r5OuTNiMlYco8J/CE5aZiHvp2m9D
	 lApz7hRf+kmIf3yr3bJUr552nqlaDhe2JOB8oDLssngeS0zwfMr/DpuVP2z3luRbVg
	 yOmBQNaot/XtuFZiG+Ad3WStsX96EfXLVhq0hF3xv5uWdkzeFw0xt0/GKF9Undeq3e
	 aCpc4qH+o3S7w==
Message-ID: <sashiko-outbox-229755@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 6/9] nvme: allow to pass in key description as dhchap
 secret
To: "Hannes Reinecke" <hare@kernel.org>
Cc: linux-nvme@lists.infradead.org
In-Reply-To: <20261123-dhchap-keyring-v4-v6-6-5082a49715ab@kernel.org>
References: <20261123-dhchap-keyring-v4-v6-0-5082a49715ab@kernel.org>
 <20261123-dhchap-keyring-v4-v6-6-5082a49715ab@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 17:32:32 +0000
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

Thank you for your contribution! Sashiko AI review found 6 potential
issues to consider:
- [Medium] nvmet-auth: self-revocation of active generated key in
  nvmet_auth_set_key()
- [Medium] nvmet-auth: host_key reference leak on ctrl_key error in
  nvmet_setup_auth()
- [Medium] nvme-auth: dhchap_secret_store() returns -EBUSY instead of
  re-authenticating
- [Low] nvme-auth: key_serial(ctrl->host_key) logged before assignment
  in nvme_auth_init_ctrl()
- [Low] nvme: wrong device pointer ctrl->dev used for logging in sysfs
  store helpers
- [Low] nvme-auth: mismatched key serial comments in
  nvme_auth_extract_key()
--

commit bea90f054bc2ef7a55e7fb9326ffa4aa13dd0817
Author: Hannes Reinecke <hare@kernel.org>

nvme: allow to pass in key description as dhchap secret

This commit updates nvme_auth_extract_key() to look up a pre-populated key
in the keyring before falling back to generating a new key from raw secret
data, and tracks whether the key was auto-generated so only generated keys
are revoked on cleanup.

> diff --git a/drivers/nvme/common/auth.c b/drivers/nvme/common/auth.c
> index 158c9cb886c15..8c84595018258 100644
> --- a/drivers/nvme/common/auth.c
> +++ b/drivers/nvme/common/auth.c
> @@ -144,20 +144,32 @@ EXPORT_SYMBOL_GPL(nvme_auth_hmac_hash_len);
>   * nvme_auth_extract_key - extract the DH-HMAC-CHAP key
>   *
>   * @keyring: keyring to be used for the resulting key
> - * @secret: key data
> - * @secret_len: length of @secret
> + * @input: key serial or key data
> + * @input_len: length of @input
> + * @generated: indicate whether a key has been generated
>   *
> - * Extracts a dhchap key from @secret.
> + * Extracts or generates a key from @input.
> + * @input can either be a key serial or raw key data; in
> + * the latter case a key is generated from @input and
> + * @generated is set to 'true'.
>   *
>   * Returns the dhchap key or an error pointer on failure.
>   */
> -struct key *nvme_auth_extract_key(struct key *keyring, const char *secre=
t,
> -				  size_t secret_len)
> +struct key *nvme_auth_extract_key(struct key *keyring, const char *input,
> +				  size_t input_len, bool *generated)
>  {
>  	struct key *key;
> =20
> -	key =3D nvme_dhchap_psk_create(keyring, secret, secret_len);
> +	/* Check if @input is a key serial number */
> +	key =3D nvme_dhchap_psk_lookup(keyring, input);

[Severity: Low]
This isn't a bug, but the comments here and the commit message body say
that @input can be a key serial number, whereas nvme_dhchap_psk_lookup()
searches the keyring by key description (matching the commit subject and
the sysfs/configfs show callbacks).

[ ... ]

> diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
> index 26e8f321650e7..2c73da4cd3c61 100644
> --- a/drivers/nvme/host/auth.c
> +++ b/drivers/nvme/host/auth.c

[ ... ]

> @@ -1104,6 +1117,7 @@ int nvme_auth_init_ctrl(struct nvme_ctrl *ctrl)
>  	if (ctrl->host_key)
>  		nvme_auth_clear_host_key(ctrl);
>  	ctrl->host_key =3D host_key;
> +	ctrl->host_key_generated =3D host_key_generated;

[Severity: Low]
Just above this hunk, pr_debug() logs key_serial(ctrl->host_key) before
ctrl->host_key is assigned host_key:

drivers/nvme/host/auth.c:nvme_auth_init_ctrl() {
    ...
	pr_debug("%s: using dhchap host key %08x\n",
	       __func__, key_serial(ctrl->host_key));
	if (ctrl->host_key)
		nvme_auth_clear_host_key(ctrl);
	ctrl->host_key =3D host_key;
    ...
}

Should that log key_serial(host_key) instead, like the ctrl_key message a
few lines below?  Otherwise it logs 00000000 on initial controller setup
and the old key serial on re-initialization.

[ ... ]

> diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
> index 6fab0d217e749..c94abb901a73c 100644
> --- a/drivers/nvme/host/sysfs.c
> +++ b/drivers/nvme/host/sysfs.c

[ ... ]

> @@ -874,22 +877,34 @@ static ssize_t dhchap_secret_store(struct device *d=
ev,
>  	ret =3D key_validate(key);
>  	up_read(&key->sem);
>  	if (ret) {
> -		dev_warn(ctrl->device, "key %08x invalidated\n",
> +		dev_warn(ctrl->dev, "key %08x invalidated\n",
>  			 key_serial(key));
> -		dev_dbg(ctrl->device, "revoke host key %08x\n",
> -			key_serial(key));
> -		key_revoke(key);
> +		if (generated) {
> +			dev_dbg(ctrl->dev, "revoke host key %08x\n",
> +				key_serial(key));
> +			key_revoke(key);
> +		}
>  		key_put(key);
>  		kfree_sensitive(dhchap_secret);
>  		return ret;
>  	}
>  	mutex_lock(&ctrl->dhchap_auth_mutex);
>  	old_key =3D ctrl->host_key;
> -	dev_dbg(ctrl->device, "revoke host key %08x\n",
> -		key_serial(old_key));
> -	key_revoke(old_key);
> -
> +	if (old_key && key_serial(old_key) =3D=3D key_serial(key)) {
> +		dev_warn(ctrl->device, "key %08x already present\n",
> +			 key_serial(key));
> +		mutex_unlock(&ctrl->dhchap_auth_mutex);
> +		key_put(key);
> +		kfree_sensitive(dhchap_secret);
> +		return -EBUSY;
> +	}
> +	if (ctrl->host_key_generated) {
> +		dev_dbg(ctrl->dev, "revoke host key %08x\n",
> +			key_serial(old_key));
> +		key_revoke(old_key);
> +	}

[Severity: Low]
Should these dev_warn() and dev_dbg() calls (and the one in
dhchap_ctrl_secret_store() below) keep using ctrl->device instead of
ctrl->dev?  ctrl->device is the nvmeX controller class device, whereas
ctrl->dev is the parent device (such as the shared /dev/nvme-fabrics misc
device), so switching to ctrl->dev loses the controller name in the logs.

>  	ctrl->host_key =3D key;
> +	ctrl->host_key_generated =3D generated;
>  	mutex_unlock(&ctrl->dhchap_auth_mutex);
>  	key_put(old_key);
>  	kfree_sensitive(dhchap_secret);

[ ... ]

> @@ -960,20 +979,32 @@ static ssize_t dhchap_ctrl_secret_store(struct devi=
ce *dev,
>  	if (ret) {
>  		dev_warn(ctrl->device, "key %08x invalidated\n",
>  			 key_serial(key));
> -		dev_dbg(ctrl->device, "revoke ctrl key %08x\n",
> -			key_serial(key));
> -		key_revoke(key);
> +		if (generated) {
> +			dev_dbg(ctrl->device, "revoke ctrl key %08x\n",
> +				key_serial(key));
> +			key_revoke(key);
> +		}
>  		key_put(key);
>  		kfree_sensitive(dhchap_secret);
>  		return ret;
>  	}
>  	mutex_lock(&ctrl->dhchap_auth_mutex);
>  	old_key =3D ctrl->ctrl_key;
> -	dev_dbg(ctrl->device, "revoke ctrl key %08x\n",
> -		key_serial(old_key));
> -	key_revoke(old_key);
> -
> +	if (old_key && key_serial(old_key) =3D=3D key_serial(key)) {
> +		dev_warn(ctrl->device, "ctrl key %08x already present\n",
> +			 key_serial(key));
> +		mutex_unlock(&ctrl->dhchap_auth_mutex);
> +		key_put(key);
> +		kfree_sensitive(dhchap_secret);
> +		return -EBUSY;
> +	}
> +	if (ctrl->ctrl_key_generated) {
> +		dev_dbg(ctrl->dev, "revoke ctrl key %08x\n",
> +			key_serial(old_key));
> +		key_revoke(old_key);
> +	}
>  	ctrl->ctrl_key =3D key;
> +	ctrl->ctrl_key_generated =3D generated;
>  	mutex_unlock(&ctrl->dhchap_auth_mutex);
>  	key_put(old_key);
>  	kfree_sensitive(dhchap_secret);

[Severity: Medium]
Does returning -EBUSY when key_serial(old_key) =3D=3D key_serial(key) in
dhchap_secret_store() and dhchap_ctrl_secret_store() break triggering
re-authentication via sysfs when using pre-populated keys?

Writing the currently active secret to dhchap_secret or dhchap_ctrl_secret
is the documented interface for triggering controller re-authentication.
When a raw secret is written, nvme_dhchap_psk_create() allocates a new key
with a new serial number and queues ctrl->dhchap_auth_work, but when the
active pre-populated key description is written, nvme_dhchap_psk_lookup()
returns the existing key, so these functions stop any pending auth work
via nvme_auth_stop(ctrl) and fail with -EBUSY instead of queueing
ctrl->dhchap_auth_work.

[ ... ]

> diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
> index 6348c810bd168..c3fa4ab78fb94 100644
> --- a/drivers/nvme/target/auth.c
> +++ b/drivers/nvme/target/auth.c

[ ... ]

> @@ -56,7 +67,7 @@ int nvmet_auth_set_key(struct nvmet_host *host, const c=
har *secret,
>  		return 0;
>  	}
>  	len =3D strcspn(secret, "\n");
> -	key =3D nvme_auth_extract_key(NULL, secret, len);
> +	key =3D nvme_auth_extract_key(NULL, secret, len, &generated);
>  	if (IS_ERR(key)) {
>  		pr_debug("%s: invalid key specification\n", __func__);
>  		return PTR_ERR(key);
> @@ -72,10 +83,13 @@ int nvmet_auth_set_key(struct nvmet_host *host, const=
 char *secret,
>  	up_read(&key->sem);
>  	down_write(&nvmet_config_sem);
>  	nvmet_auth_revoke_key(host, set_ctrl);
> -	if (set_ctrl)
> +	if (set_ctrl) {
>  		host->dhchap_ctrl_key =3D key;
> -	else
> +		host->dhchap_ctrl_key_generated =3D generated;
> +	} else {
>  		host->dhchap_key =3D key;
> +		host->dhchap_key_generated =3D generated;
> +	}
>  	up_write(&nvmet_config_sem);
>  	return 0;
>  }

[Severity: Medium]
Can nvmet_auth_set_key() revoke the newly looked-up key in place if the
host currently has an auto-generated key and its description (UUID) is
written back to configfs?

nvme_auth_extract_key() finds the active key in the keyring via
nvme_dhchap_psk_lookup() and returns it with generated =3D false, and then
nvmet_auth_revoke_key() sees the old generated flag set and calls
key_revoke() on that same struct key before it is reinstalled on host,
leaving the host with a permanently revoked key that fails all subsequent
authentications.  Also, if key_validate(key) fails when generated is true,
nvmet_auth_set_key() calls key_put(key) without key_revoke(key), leaving
the generated key linked in the keyring.

[Severity: Medium]
Later in drivers/nvme/target/auth.c, does nvmet_setup_auth() leak the
host_key reference when acquiring or validating ctrl_key fails?

drivers/nvme/target/auth.c:nvmet_setup_auth() {
    ...
	host_key =3D key_get(host->dhchap_key);
    ...
	if (host->dhchap_ctrl_key) {
		ctrl_key =3D key_get(host->dhchap_ctrl_key);
		if (!ctrl_key) {
			pr_warn("%s: ctrl key %08x not found\n",
				__func__, key_serial(host->dhchap_ctrl_key));
			ret =3D NVME_AUTH_DHCHAP_FAILURE_NOT_USABLE;
			goto out_unlock;
		}
		down_read(&ctrl_key->sem);
		ret =3D key_validate(ctrl_key);
		key_id =3D key_serial(ctrl_key);
		up_read(&ctrl_key->sem);
		if (ret) {
			pr_warn("ctrl key %08x invalidated\n", key_id);
			key_put(ctrl_key);
			ret =3D NVME_AUTH_DHCHAP_FAILURE_NOT_USABLE;
			goto out_unlock;
		}
	}
    ...
out_unlock:
	up_read(&nvmet_config_sem);

	return ret;
}

When a pre-populated ctrl_key in the keyring is revoked or expired,
key_validate(ctrl_key) fails and jumps to out_unlock without calling
key_put(host_key), leaking a reference on host_key on every authentication
attempt.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123-dhchap-key=
ring-v4-v6-0-5082a49715ab@kernel.org?part=3D6

