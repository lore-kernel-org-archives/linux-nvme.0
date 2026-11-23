Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D4D606A31A
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Nov 2026 12:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=2IJHNCWZ;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JL1yYjIG
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=9UyIz7ST0jZsrSZT6eAlbhm1B64SStVMngxS0pm0MNs=; b=2IJHNCWZj+/TZNfhQXqOo8UokB
	5Lv1eWAveNVlCCSbs0r5apNZ2HB1IFyPoZuHIKQ9hZbkyvjzJB8wpG5qiop73DcaylK7Hf6nMG2yH
	jC4i6PFG41/prb1g0pbSsRrkLJF/TqprFmMhc20GalLq4UidKewGnceRtwTo/220qj3y5HGGQeDjt
	+X3fF5qBJWIt7ZfTLRwMawr8ldXUCpUuR65NkC82WXBUiuyhA9vllh04SVO+ghitf/fZKvUuSEQ6G
	dqSgd7BccQoF5g0J0Co4kL0D6wG5vgRobEYp81qzsuVG63t2X1/WU9qR/FclKHog7lYjqBHABvir2
	Wc0KcPxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVTAj-00000003MTe-1iHO;
	Mon, 23 Nov 2026 12:29:25 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVTAi-00000003MTU-1p6U
	for linux-nvme@lists.infradead.org;
	Mon, 23 Nov 2026 12:29:24 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 981B161F51
	for <linux-nvme@lists.infradead.org>; Mon, 23 Nov 2026 12:29:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EF4A1F000CF;
	Mon, 23 Nov 2026 12:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795436963;
	bh=9UyIz7ST0jZsrSZT6eAlbhm1B64SStVMngxS0pm0MNs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JL1yYjIG1mfXUhEW2E2phlz83sddELfKpCRv+fS0HhL53U6p07/6Jjs10Y5cSrpOj
	 EZWFsLAzli1tjYRjMoYoCDWV8rmfMo8SxVNqvRnUiOYbpf1BCmrzj41PZ5ODrFOG2l
	 pRJxABTiGR21Em5zbhooOd9ILmqRQM7G9L8V1qO98uVqIuyhcLYAMimseg9TwhnqkF
	 ebfcBm691lRlU+ySDHi2lgvoJHCGrWjxBcm40W3l0tqrL/ZCONk3U4r7QYdcWYglII
	 XauZ/nsQpA7jkMH8VFEwoBMeIHncBTQ2v/ElSQ2J4vcVMNEc7n5UakncR+L0KMH39q
	 zULaShYyzEDlg==
Message-ID: <sashiko-outbox-229218@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 5/9] nvmet-auth: parse dhchap key from configfs
 attribute
To: "Hannes Reinecke" <hare@kernel.org>
Cc: linux-nvme@lists.infradead.org
In-Reply-To: <20261123-dhchap-keyring-v4-v5-5-81eefb4c0724@kernel.org>
References: <20261123-dhchap-keyring-v4-v5-0-81eefb4c0724@kernel.org>
 <20261123-dhchap-keyring-v4-v5-5-81eefb4c0724@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 12:29:22 +0000
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

Thank you for your contribution! Sashiko AI review found 5 potential
issues to consider:
- [High] nvmet-auth: NULL pointer dereference in nvmet_auth_set_key()
  when clearing key
- [High] nvmet-auth: invalid DH-CHAP status and partial key update in
  nvmet_setup_auth()
- [High] nvmet-auth: shared key revocation in nvmet_auth_revoke_key()
  breaks active ctrls
- [High] nvmet-auth: uninitialized offset and OOB read in
  nvme_dhchap_psk_preparse()
- [Medium] nvmet-auth: missing DH-CHAP version and hash ID check in
  nvmet_auth_set_key()
--

commit 46da02dd0755f9ec506cfdb7b2885930c4ee4ffd
Author: Hannes Reinecke <hare@kernel.org>

nvmet-auth: parse dhchap key from configfs attribute

This commit converts the nvmet configfs DH-HMAC-CHAP key interface to
store keys as struct key pointers on struct nvmet_host rather than raw
secret strings.

> diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
> index 26457ce4acc2a..8b77164512c9c 100644
> --- a/drivers/nvme/target/auth.c
> +++ b/drivers/nvme/target/auth.c
> @@ -19,52 +19,63 @@
> =20
>  #include "nvmet.h"
> =20
> +void nvmet_auth_revoke_key(struct nvmet_host *host, bool set_ctrl)
> +{
> +	struct key *key =3D NULL;
> +
> +	if (set_ctrl) {
> +		if (host->dhchap_ctrl_key) {
> +			key =3D host->dhchap_ctrl_key;
> +			host->dhchap_ctrl_key =3D NULL;
> +		}
> +	} else {
> +		if (host->dhchap_key) {
> +			key =3D host->dhchap_key;
> +			host->dhchap_key =3D NULL;
> +		}
> +	}
> +	if (key) {
> +		pr_debug("%s: revoke %s key %08x\n",
> +			 __func__, set_ctrl ? "ctrl" : "host",
> +			 key_serial(key));
> +		key_revoke(key);
> +		key_put(key);
> +	}
> +}

[Severity: High]
Does revoking the key here break active controllers that still hold a
reference to it?

nvmet_setup_auth() shares host->dhchap_key and host->dhchap_ctrl_key with
connected controllers via key_get().  When a key is updated or cleared in
configfs, calling key_revoke() here marks that shared key revoked and
clears its payload, even though nvmet_host_dhchap_key_store() notes that
existing authentication must stay valid until the host requests
re-authentication.  Because nvmet_execute_auth_send() only re-runs
nvmet_setup_auth() on the admin queue, in-flight authentication or later
I/O queue authentication on an existing controller continues using
ctrl->host_key and fails in key_validate() with -EKEYREVOKED.

In addition, when host->dhchap_key is cleared to NULL, nvmet_setup_auth()
returns early without dropping ctrl->host_key or ctrl->ctrl_key, leaving
the controller pointing to the revoked key on re-authentication.

> +
>  int nvmet_auth_set_key(struct nvmet_host *host, const char *secret,
>  		       bool set_ctrl)
>  {
> -	unsigned char key_hash;
> -	char *dhchap_secret;
> -	int offset =3D 0;
> +	struct key *key;
> +	size_t len;
> =20
>  	if (!strlen(secret)) {
>  		down_write(&nvmet_config_sem);
> -		if (set_ctrl) {
> -			kfree(host->dhchap_ctrl_secret);
> -			host->dhchap_ctrl_secret =3D NULL;
> -			host->dhchap_ctrl_key_hash =3D 0;
> -			host->dhchap_ctrl_key_offset =3D 0;
> -		} else {
> -			kfree(host->dhchap_secret);
> -			host->dhchap_secret =3D NULL;
> -			host->dhchap_key_hash =3D 0;
> -			host->dhchap_key_offset =3D 0;
> -		}
> +		nvmet_auth_revoke_key(host, set_ctrl);
>  		up_write(&nvmet_config_sem);
>  		return 0;
>  	}
> -	if (sscanf(secret, "DHHC-1:%hhd:%n", &key_hash, &offset) !=3D 1 ||
> -	    !offset)
> -		return -EINVAL;

[Severity: High]
Does removing the offset check here expose an uninitialized read and an
out-of-bounds read in nvme_dhchap_psk_preparse()?

Commit 62dae895f986 ("nvmet-auth: store the DH-CHAP key offset instead of
hardcoding it") initialized offset =3D 0 and used the parsed %n offset.
Delegating parsing to nvme_auth_extract_key() -> nvme_dhchap_psk_preparse()
loses both fixes:

drivers/nvme/common/keyring.c:nvme_dhchap_psk_preparse() {
	int ret, offset;
...
	if (sscanf(prep->data, "DHHC-%01hhu:%02hhu:%n",
		   &version, &hmac, &offset) !=3D 2 || !offset) {
...
	datalen =3D strlen(prep->data + offset);
...
	ret =3D base64_decode(prep->data + 10, datalen, upayload->data,
			    true, BASE64_STD);
}

Because %n is not counted in the sscanf() return value, an input missing
the trailing colon (such as "DHHC-1:1") returns 2 without writing offset,
so strlen(prep->data + offset) uses an uninitialized stack variable.  And
when a single-digit HMAC ID is used (such as "DHHC-1:1:...", where offset
is 9), base64_decode() hardcodes prep->data + 10 with datalen computed
from offset 9, reading one byte past the NUL terminator.

> -	if (key_hash > 3) {
> -		pr_warn("Invalid DH-HMAC-CHAP hash id %d\n",
> -			 key_hash);
> -		return -EINVAL;
> -	}
> -	dhchap_secret =3D kstrdup(secret, GFP_KERNEL);
> -	if (!dhchap_secret)
> -		return -ENOMEM;
> +	len =3D strcspn(secret, "\n");
> +	key =3D nvme_auth_extract_key(NULL, secret, len);
> +	if (IS_ERR(key)) {
> +		pr_debug("%s: invalid key specification\n", __func__);
> +		return PTR_ERR(key);
> +	}

[Severity: Medium]
Does switching to nvme_auth_extract_key() drop the DH-CHAP version and
hash ID validation?

Previously, nvmet_auth_set_key() required the "DHHC-1:" prefix and
rejected key_hash > 3 with -EINVAL.  nvme_dhchap_psk_preparse() parses
"DHHC-%01hhu:%02hhu:%n" into version and hmac without checking that
version =3D=3D 1 or hmac <=3D 3, allowing keys with unsupported versions or
hash IDs to be stored via configfs and deferring failure until
authentication time.

[ ... ]

> @@ -186,44 +195,76 @@ u8 nvmet_setup_auth(struct nvmet_ctrl *ctrl, struct=
 nvmet_sq *sq, bool reset)
>  		goto out_unlock;
>  	}
> =20
> -	if (!host->dhchap_secret) {
> +	if (!host->dhchap_key) {
>  		pr_debug("No authentication provided\n");
>  		goto out_unlock;
>  	}
> =20
> -	host_key =3D nvme_auth_extract_key(NULL, host->dhchap_secret,
> -					 strlen(host->dhchap_secret));
> -	if (IS_ERR(host_key)) {
> -		ret =3D NVME_AUTH_DHCHAP_FAILURE_NOT_USABLE;
> +	key =3D key_get(host->dhchap_key);
> +	if (!key) {
> +		pr_warn("%s: host key %08x not found\n",
> +			__func__, key_serial(host->dhchap_key));
>  		goto out_unlock;
>  	}
> -	if (host->dhchap_ctrl_secret) {
> -		ctrl_key =3D nvme_auth_extract_key(NULL, host->dhchap_ctrl_secret,
> -						 strlen(host->dhchap_ctrl_secret));
> -		if (IS_ERR(ctrl_key)) {
> -			key_put(host_key);
> -			ret =3D NVME_AUTH_DHCHAP_FAILURE_NOT_USABLE;
> -			goto out_unlock;
> +	down_read(&key->sem);
> +	ret =3D key_validate(key);
> +	if (!ret) {
> +		if (ctrl->host_key) {
> +			pr_debug("%s: drop host key %08x\n",
> +				 __func__, key_serial(ctrl->host_key));
> +			key_put(ctrl->host_key);
>  		}
> +		ctrl->host_key =3D key;
>  	}
> -	key_put(ctrl->host_key);
> -	ctrl->host_key =3D host_key;
> -	key_put(ctrl->ctrl_key);
> -	ctrl->ctrl_key =3D ctrl_key;
> +	key_id =3D key_serial(key);
> +	up_read(&key->sem);
> +	if (ret) {
> +		pr_warn("host key %08x invalidated\n", key_id);
> +		key_put(key);
> +		key =3D ERR_PTR(-EKEYREVOKED);
> +		goto out_unlock;
> +	}
>  	ctrl->shash_id =3D host->dhchap_hash_id;
>  #ifdef CONFIG_NVME_TARGET_AUTH_DEBUG
> -	host_hash =3D nvme_dhchap_psk_hash(ctrl->host_key);
> -	pr_debug("%s: using hash %s key %u\n", __func__,
> -		 ctrl_hash > 0 ?
> -		 nvme_auth_hmac_name(ctrl_hash) : "none",
> -		 key_serial(ctrl->host_key));
> -	if (ctrl->ctrl_key) {
> -		ctrl_hash =3D nvme_dhchap_psk_hash(ctrl->ctrl_key);
> -		pr_debug("%s: using ctrl hash %s key %u\n", __func__,
> -			 ctrl_hash > 0 ?
> -			 nvme_auth_hmac_name(ctrl_hash) : "none",
> -			 key_serial(ctrl->ctrl_key));
> +	pr_debug("%s: using dhchap hash %s key %08x\n", __func__,
> +		 nvme_auth_hmac_name(ctrl->shash_id), key_id);
> +#endif
> +	if (!host->dhchap_ctrl_key) {
> +		if (ctrl->ctrl_key) {
> +			pr_debug("%s: drop ctrl key %08x\n",
> +				 __func__, key_serial(ctrl->ctrl_key));
> +			key_put(ctrl->ctrl_key);
> +			ctrl->ctrl_key =3D NULL;
> +		}
> +		goto out_unlock;
>  	}
> +
> +	key =3D key_get(host->dhchap_ctrl_key);
> +	if (!key) {
> +		pr_warn("%s: ctrl key %08x not found\n",
> +			__func__, key_serial(host->dhchap_ctrl_key));
> +		goto out_unlock;
> +	}
> +	down_read(&key->sem);
> +	ret =3D key_validate(key);
> +	if (!ret) {
> +		if (ctrl->ctrl_key) {
> +			pr_debug("%s: drop ctrl key %08x\n",
> +				 __func__, key_serial(ctrl->ctrl_key));
> +			key_put(ctrl->ctrl_key);
> +		}
> +		ctrl->ctrl_key =3D key;
> +	}
> +	key_id =3D key_serial(key);
> +	up_read(&key->sem);
> +	if (ret) {
> +		pr_warn("ctrl key %08x invalidated\n", key_id);
> +		key_put(key);
> +		goto out_unlock;
> +	}

[Severity: High]
Does nvmet_setup_auth() return a negative errno instead of a DH-HMAC-CHAP
status code when key_validate() fails, and overwrite ctrl->host_key before
host->dhchap_ctrl_key is validated?

nvmet_execute_auth_send() stores the u8 return value of nvmet_setup_auth()
directly in req->sq->dhchap_status to send in the DH-HMAC-CHAP_Failure1
message.  When key_validate() fails for either key, ret holds a negative
errno (such as -EKEYREVOKED) instead of NVME_AUTH_DHCHAP_FAILURE_NOT_USABLE,
so (u8)ret is sent on the wire as the failure reason code.  Conversely, if
key_get() returns NULL, ret is still 0 and nvmet_setup_auth() reports
success without installing the key.

Also, ctrl->host_key and ctrl->shash_id are replaced before
host->dhchap_ctrl_key is validated, undoing commit 41ad4af45ac9
("nvmet-auth: keep the old keys if the new ones fail") and leaving the
controller with a mismatched host/controller key pair if controller key
validation fails during re-authentication.

[ ... ]

> diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configf=
s.c
> index ff3a8d74de599..12c093f4c8363 100644
> --- a/drivers/nvme/target/configfs.c
> +++ b/drivers/nvme/target/configfs.c

[ ... ]

> @@ -2251,9 +2266,19 @@ static ssize_t nvmet_host_dhchap_key_store(struct =
config_item *item,
>  		const char *page, size_t count)
>  {
>  	struct nvmet_host *host =3D to_host(item);
> +	u8 *keydata =3D NULL;
> +	size_t len;
>  	int ret;
> =20
> -	ret =3D nvmet_auth_set_key(host, page, false);
> +	len =3D strcspn(page, "\n");
> +	if (len) {
> +		keydata =3D kstrndup(page, len, GFP_KERNEL);
> +		if (!keydata)
> +			return -ENOMEM;
> +	}
> +
> +	ret =3D nvmet_auth_set_key(host, keydata, false);
> +	kfree_sensitive(keydata);

[Severity: High]
Does clearing dhchap_key or dhchap_ctrl_key via configfs trigger a NULL
pointer dereference in nvmet_auth_set_key()?

When an empty string or a newline is written to nvmet_host_dhchap_key_store=
()
or nvmet_host_dhchap_ctrl_key_store() to clear a key, len is 0 and keydata
remains NULL.  nvmet_auth_set_key() then evaluates if (!strlen(secret))
without checking if secret is NULL first.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123-dhchap-key=
ring-v4-v5-0-81eefb4c0724@kernel.org?part=3D5

