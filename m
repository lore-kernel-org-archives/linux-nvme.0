Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17FF606A6AC
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Nov 2026 12:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=2uQRDWQ5;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nouw4Fjy
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=2A9R6q0uPN262b37a+QcoEy5Z/bD/HTojx3xGQdZc3g=; b=2uQRDWQ5wcCpat4bwGb9PdrVI0
	rQ3c5ALAxPR5gWP4j08fzBrcBksAqLNQATPxLcL9qMKWb8TzhxypvNguRVyUezXgoLNDOg2K3roch
	Wzf/WkGQavxpkRjOA7mBpyVZ6xGRybewdEqjNtvzl6Ktrp5MrweKA+kpMWIpvwui+6ygTKFAwSsDC
	J9t5aDhLJgcw8DHuo4RzjWiYWIQVtXsTtYsJTaQwa4MwpKMEOxYievcpYuWoujCVfTBYrN4f8mb4Y
	53kPfJ66d9Eb0J3ymMetbTZME3SBcL6bH2jULo4KQZk0EJgvpoBDTMV8FxnZESL5vO9B98frIaHIE
	WA2NAgTA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVTHf-00000003OIy-196x;
	Mon, 23 Nov 2026 12:36:35 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVTHb-00000003OGp-0hMV
	for linux-nvme@lists.infradead.org;
	Mon, 23 Nov 2026 12:36:33 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 8E94562100
	for <linux-nvme@lists.infradead.org>; Mon, 23 Nov 2026 12:36:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2F301F000ED;
	Mon, 23 Nov 2026 12:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795437389;
	bh=2A9R6q0uPN262b37a+QcoEy5Z/bD/HTojx3xGQdZc3g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nouw4FjyHnN2Z6fS40yP4YtQklcdB92pLPqVMptZCxMUCRKmxdUz+ZWU7zER6PEwp
	 JIPN50uXxO6oBSDElsS+b/jCE+8YbZQwGxHSm50rF8H+q3R7RnBh/oHNXM44UweJSN
	 5j9p/XovM3IXSC1FQ8EULtN4d1ysnNqMmeGlvuakemUKswZ9o0YitKCCkDJgS1PoBg
	 9n7vmJk1H3cIIqQJnhYkX+6NWNjD2F2Xi/+xIWHpWPYZz7sHPcO+Olm3nBcECOxz0D
	 B2xtXoyz1TZUBFLTxN2ku+0oipBrkQO5VqLaE+pNERbXBb5PuglvINqODrBzxChRLh
	 /lTlKixcXr20A==
Message-ID: <sashiko-outbox-229231@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 6/9] nvme: allow to pass in key description as dhchap
 secret
To: "Hannes Reinecke" <hare@kernel.org>
Cc: linux-nvme@lists.infradead.org
In-Reply-To: <20261123-dhchap-keyring-v4-v5-6-81eefb4c0724@kernel.org>
References: <20261123-dhchap-keyring-v4-v5-0-81eefb4c0724@kernel.org>
 <20261123-dhchap-keyring-v4-v5-6-81eefb4c0724@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 12:36:29 +0000
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

Thank you for your contribution! Sashiko AI review found 10 potential
issues to consider:
- [High] nvmet-auth: NULL pointer dereference in nvmet_auth_set_key()
  when clearing key
- [High] nvme-keyring: broken !CONFIG_NVME_KEYRING stubs in
  include/linux/nvme-keyring.h
- [Medium] nvme: broken key visibility check in
  nvme_dev_attrs_are_visible()
- [Medium] nvme-auth: self-revocation when updating key with active key
  description
- [Medium] nvmet: off-by-one PAGE_SIZE overflow via sprintf() in dhchap
  key configfs show
- [Medium] nvme-auth: unnecessary synchronize_rcu() stalls after
  key_revoke() under locks
- [Low] nvme-auth: mismatched key serial docs and prototype in
  nvme_auth_extract_key()
- [Low] nvme-auth: key_serial() logged before key assignment in
  nvme_auth_init_ctrl()
- [Low] nvme-sysfs: missing trailing newline on invalidated in
  dhchap_ctrl_secret_show()
- [Low] nvme-auth: nvme_auth_init_ctrl() logs key_serial() before
  assigning ctrl keys
--

commit 4ce0c96fc574d457ee6098926055522bf6b8f799
Author: Hannes Reinecke <hare@kernel.org>

nvme: allow to pass in key description as dhchap secret

This commit updates nvme_auth_extract_key() to look up a pre-populated
DH-HMAC-CHAP key in the keyring before falling back to generating a key
from raw secret data, and tracks whether the key was auto-generated so
only generated keys are revoked on teardown.

> diff --git a/drivers/nvme/common/auth.c b/drivers/nvme/common/auth.c
> index ee26fb416ee62..abdad41daa8fb 100644
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
This isn't a bug, but the commit message body, kernel-doc and inline
comment refer to @input as a key serial number, whereas
nvme_dhchap_psk_lookup() searches the keyring by key description
(key->description).

> diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
> index 535cc433dd35d..98913eaeb6d68 100644
> --- a/drivers/nvme/host/auth.c
> +++ b/drivers/nvme/host/auth.c
[ ... ]
> @@ -1109,6 +1122,7 @@ int nvme_auth_init_ctrl(struct nvme_ctrl *ctrl)
>  	if (ctrl->host_key)
>  		nvme_auth_clear_host_key(ctrl);
>  	ctrl->host_key =3D host_key;
> +	ctrl->host_key_generated =3D host_key_generated;

[Severity: Low]
Just above this in nvme_auth_init_ctrl(), dev_dbg() logs
key_serial(ctrl->host_key) before ctrl->host_key =3D host_key is assigned:

drivers/nvme/host/auth.c:nvme_auth_init_ctrl() {
	...
	dev_dbg(ctrl->device,
		"%s: using dhchap host key %08x\n",
		__func__, key_serial(ctrl->host_key));
	if (ctrl->host_key)
		nvme_auth_clear_host_key(ctrl);
	ctrl->host_key =3D host_key;
	...
}

Should that log key_serial(host_key) instead so it does not print 00000000
(or the previous key's serial on reset)?

>  	if (ctrl->ctrl_key)
>  		nvme_auth_clear_ctrl_key(ctrl);
> @@ -1117,6 +1131,7 @@ int nvme_auth_init_ctrl(struct nvme_ctrl *ctrl)
>  			"%s: using dhchap ctrl key %08x\n",
>  			__func__, key_serial(ctrl->ctrl_key));
>  		ctrl->ctrl_key =3D ctrl_key;
> +		ctrl->ctrl_key_generated =3D ctrl_key_generated;
>  	}

[Severity: Low]
Similarly, nvme_auth_clear_ctrl_key(ctrl) clears ctrl->ctrl_key to NULL
right before dev_dbg() logs key_serial(ctrl->ctrl_key), so this always
prints 00000000 instead of key_serial(ctrl_key).

> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
> index 0c09888be31f7..1277749c6e2e3 100644
> --- a/drivers/nvme/host/fabrics.c
> +++ b/drivers/nvme/host/fabrics.c
[ ... ]
> @@ -1339,15 +1343,25 @@ void nvmf_free_options(struct nvmf_ctrl_options *=
opts)
>  	kfree(opts->host_traddr);
>  	kfree(opts->host_iface);
>  	if (opts->dhchap_key) {
> -		pr_debug("revoke dhchap host key %08x\n",
> +		if (opts->dhchap_key_generated) {
> +			pr_debug("revoke dhchap host key %08x\n",
> +				 key_serial(opts->dhchap_key));
> +			key_revoke(opts->dhchap_key);
> +			synchronize_rcu();
> +		}
> +		pr_debug("drop dhchap host key %08x\n",
>  			 key_serial(opts->dhchap_key));
> -		key_revoke(opts->dhchap_key);
>  		key_put(opts->dhchap_key);
>  	}
>  	if (opts->dhchap_ctrl_key) {
> -		pr_debug("revoke dhchap ctrl key %08x\n",
> +		if (opts->dhchap_ctrl_key_generated) {
> +			pr_debug("revoke dhchap ctrl key %08x\n",
> +				 key_serial(opts->dhchap_ctrl_key));
> +			key_revoke(opts->dhchap_ctrl_key);
> +			synchronize_rcu();
> +		}
> +		pr_debug("drop dhchap ctrl key %08x\n",
>  			 key_serial(opts->dhchap_ctrl_key));
> -		key_revoke(opts->dhchap_ctrl_key);
>  		key_put(opts->dhchap_ctrl_key);
>  	}
>  	kfree(opts);

[Severity: Medium]
Why call synchronize_rcu() after key_revoke() here, in
dhchap_secret_store(), dhchap_ctrl_secret_store() and
nvmet_auth_revoke_key()?

key_revoke() sets KEY_FLAG_REVOKED under key->sem and schedules payload
destruction via call_rcu(), while all DH-HMAC-CHAP key readers serialize
on key->sem and key_validate().  Waiting synchronously for an RCU grace
period stalls callers unnecessarily, including while holding
ctrl->dhchap_auth_mutex in dhchap_[ctrl_]secret_store() and while holding
down_write(&nvmet_config_sem) in nvmet_auth_set_key(), which blocks all
concurrent target connections and configfs operations.

> diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
> index e73c3ad89adc0..e6d42da84e168 100644
> --- a/drivers/nvme/host/sysfs.c
> +++ b/drivers/nvme/host/sysfs.c
[ ... ]
> @@ -875,19 +878,25 @@ static ssize_t dhchap_secret_store(struct device *d=
ev,
>  	up_read(&key->sem);
>  	if (ret) {
>  		dev_warn(ctrl->dev, "key %08x invalidated\n", key_serial(key));
> -		dev_dbg(ctrl->dev, "revoke host key %08x\n", key_serial(key));
> -		key_revoke(key);
> +		if (generated) {
> +			dev_dbg(ctrl->dev, "revoke host key %08x\n", key_serial(key));
> +			key_revoke(key);
> +			synchronize_rcu();
> +		}
>  		key_put(key);
>  		kfree_sensitive(dhchap_secret);
>  		return ret;
>  	}
>  	mutex_lock(&ctrl->dhchap_auth_mutex);
>  	old_key =3D ctrl->host_key;
> -	dev_dbg(ctrl->dev, "revoke host key %08x\n",
> -		key_serial(old_key));
> -	key_revoke(old_key);
> -
> +	if (ctrl->host_key_generated) {
> +		dev_dbg(ctrl->dev, "revoke host key %08x\n",
> +			key_serial(old_key));
> +		key_revoke(old_key);
> +		synchronize_rcu();
> +	}
>  	ctrl->host_key =3D key;
> +	ctrl->host_key_generated =3D generated;
>  	mutex_unlock(&ctrl->dhchap_auth_mutex);

[Severity: Medium]
Can this revoke the newly selected key when the active key was
auto-generated?

An auto-generated key is linked into the keyring with a UUID description.
If a user writes that active key's description to dhchap_secret_store()
(or dhchap_ctrl_secret_store(), or nvmet_auth_set_key() on the target),
nvme_auth_extract_key() finds it in the keyring before the old key is
revoked and returns key =3D=3D old_key with generated =3D false.  Because
ctrl->host_key_generated is still true, key_revoke(old_key) then revokes
key itself, causing subsequent authentication to fail with -EKEYREVOKED.
Should these paths check old_key !=3D key before revoking old_key?

> @@ -913,16 +922,18 @@ static ssize_t dhchap_ctrl_secret_show(struct devic=
e *dev,
>  		mutex_unlock(&ctrl->dhchap_auth_mutex);
>  		return sysfs_emit(buf, "none\n");
>  	}
> +
>  	down_read(&key->sem);
>  	if (key_validate(key))
>  		count =3D sysfs_emit(buf, "<invalidated>");

[Severity: Low]
Should "<invalidated>" have a trailing newline here to match
dhchap_secret_show() and the other branches of dhchap_ctrl_secret_show()?

[ ... ]

> @@ -1090,9 +1110,11 @@ static umode_t nvme_dev_attrs_are_visible(struct k=
object *kobj,
>  		return 0;
>  	if (a =3D=3D &dev_attr_dhchap_ctrl_secret.attr && !ctrl->opts)
>  		return 0;
> -	if (a =3D=3D &dev_attr_dhchap_key.attr && !ctrl->opts)
> +	if (a =3D=3D &dev_attr_dhchap_key.attr && !ctrl->opts &&
> +	    !ctrl->host_key_generated)
>  		return 0;
> -	if (a =3D=3D &dev_attr_dhchap_ctrl_key.attr && !ctrl->opts)
> +	if (a =3D=3D &dev_attr_dhchap_ctrl_key.attr && !ctrl->opts &&
> +	    !ctrl->ctrl_key_generated)
>  		return 0;
>  #endif

[Severity: Medium]
Should the visibility conditions for dev_attr_dhchap_key.attr and
dev_attr_dhchap_ctrl_key.attr use || instead of &&?

On Fabrics controllers ctrl->opts is non-NULL, so !ctrl->opts is false and
the !ctrl->host_key_generated / !ctrl->ctrl_key_generated checks are never
reached.  In addition, because sysfs group visibility is only evaluated at
device creation unless sysfs_update_group() is called, changing
ctrl->host_key_generated or ctrl->ctrl_key_generated later in
dhchap_secret_store() or dhchap_ctrl_secret_store() will not update the
visibility of these attributes.

> diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
> index 8b77164512c9c..7204ace149565 100644
> --- a/drivers/nvme/target/auth.c
> +++ b/drivers/nvme/target/auth.c
[ ... ]
> @@ -46,6 +57,7 @@ void nvmet_auth_revoke_key(struct nvmet_host *host, boo=
l set_ctrl)
>  int nvmet_auth_set_key(struct nvmet_host *host, const char *secret,
>  		       bool set_ctrl)
>  {
> +	bool generated =3D false;
>  	struct key *key;
>  	size_t len;
> =20
> @@ -56,7 +68,7 @@ int nvmet_auth_set_key(struct nvmet_host *host, const c=
har *secret,
>  		return 0;
>  	}
>  	len =3D strcspn(secret, "\n");
> -	key =3D nvme_auth_extract_key(NULL, secret, len);
> +	key =3D nvme_auth_extract_key(NULL, secret, len, &generated);

[Severity: High]
Does clearing a host or controller key via configfs trigger a NULL pointer
dereference in nvmet_auth_set_key()?

In nvmet_host_dhchap_key_store() and nvmet_host_dhchap_ctrl_key_store(),
writing an empty string or newline leaves keydata as NULL:

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

nvmet_auth_set_key() then calls strlen(secret) at the start of the
function without checking if (!secret), dereferencing NULL.

> diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configf=
s.c
> index 12c093f4c8363..bc46d760aaa4a 100644
> --- a/drivers/nvme/target/configfs.c
> +++ b/drivers/nvme/target/configfs.c
> @@ -2248,13 +2248,14 @@ static ssize_t nvmet_host_dhchap_key_show(struct =
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
> +			ret =3D sprintf(page, "%s\n", key->description);
>  		up_read(&key->sem);
>  		key_put(key);
>  	}
> @@ -2305,13 +2306,14 @@ static ssize_t nvmet_host_dhchap_ctrl_key_show(st=
ruct config_item *item,
>  		down_read(&key->sem);
>  		if (key_validate(key))
>  			ret =3D sprintf(page, "<invalidated>\n");
> -		else {
> +		else if (host->dhchap_ctrl_key_generated) {
>  			ret =3D key->type->read(key, page, PAGE_SIZE);
>  			if (ret > 0) {
>  				page[ret] =3D '\n';
>  				ret++;
>  			}
> -		}
> +		} else
> +			ret =3D sprintf(page, "%s\n", key->description);
>  		up_read(&key->sem);
>  		key_put(key);
>  	}

[Severity: Medium]
Can sprintf(page, "%s\n", key->description) in nvmet_host_dhchap_key_show()
and nvmet_host_dhchap_ctrl_key_show() overflow the PAGE_SIZE configfs
buffer by 1 byte?

add_key() permits key->description up to 4095 characters (KEY_MAX_DESC_SIZE
is 4096 including the NUL terminator), so appending "\n" and the
terminating NUL writes 4097 bytes into the 4096-byte page buffer.  Using
scnprintf(page, PAGE_SIZE, "%s\n", key->description) would avoid writing
past the end of page.

> diff --git a/include/linux/nvme-auth.h b/include/linux/nvme-auth.h
> index 75e1e75e298e1..d5fbae8fc510b 100644
> --- a/include/linux/nvme-auth.h
> +++ b/include/linux/nvme-auth.h
> @@ -32,7 +32,7 @@ void nvme_auth_hmac_update(struct nvme_auth_hmac_ctx *h=
mac, const u8 *data,
>  void nvme_auth_hmac_final(struct nvme_auth_hmac_ctx *hmac, u8 *out);
> =20
>  struct key *nvme_auth_extract_key(struct key *keyring, const char *secre=
t,
> -				  size_t secret_len);
> +				  size_t secret_len, bool *generated);

[Severity: Low]
The commit message notes that the secret parameter of
nvme_auth_extract_key() was renamed to input, but this declaration in
include/linux/nvme-auth.h still uses secret and secret_len.

[Severity: High]
Also in the keyring headers included by drivers/nvme/host/sysfs.c,
drivers/nvme/host/fabrics.c and drivers/nvme/target/configfs.c, do the
!CONFIG_NVME_KEYRING stubs in include/linux/nvme-keyring.h break the build
when CONFIG_NVME_KEYRING is disabled?

include/linux/nvme-keyring.h {
	...
static inline struct key *nvme_tls_psk_refresh(struct key *keyring,
		const char *hostnqn, const char *subnqn, *data, u8 hmac_id,
		u8 *data, size_t data_len, const char *digest)
{
	return ERR_PTR(-ENOTSUPP);
}
	...
u8 nvme_dhchap_psk_hash(struct key *key)
{
	return 0;
}
}

nvme_tls_psk_refresh() has a stray untyped *data parameter before
u8 hmac_id, and nvme_dhchap_psk_hash() is missing static inline, causing
compile and multiple-definition link errors whenever CONFIG_NVME_KEYRING=3D=
n.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123-dhchap-key=
ring-v4-v5-0-81eefb4c0724@kernel.org?part=3D6

