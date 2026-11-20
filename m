Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8B3606A320
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Nov 2026 11:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=HXZUMvhi;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=keal7Uji
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=dRJsrbWFy8lZ+q0A86lw3VYSJkXTRRykHrpJRl5Bp+g=; b=HXZUMvhiAofBtrWMvWaRpi0Lhn
	E1VWzb6I0zb3foxlxoRaq35lZdQBPmBH9uk66bwjgLAUsGVZD1BsZZbpVnpI03sjGFMxFl+o4qOXF
	CqYlR5mlkIcEM5TeTfR0uTrYR7PgO8UWHBv00w6mf5fjpWjNeOfHe2sQsB+074aSja+awF8AVV4PJ
	WmSVh797goE8vxDNUIjv+B1Gm0w/4a7yS6/0lRebpdZBxEjVOPmFfDbvjOUOyqySQLa7s78Ai7+H+
	alGbRQQ0+iRAhDcefYTAO5bbfY12jCElgF/eNyTkFb+NrqRzfwiXSXlk9gRYJjjSuJxKRioFJtznE
	inKxvlHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUMnZ-0000000EnIj-49vL;
	Fri, 20 Nov 2026 11:28:57 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUMnX-0000000EnII-4AxI
	for linux-nvme@lists.infradead.org;
	Fri, 20 Nov 2026 11:28:56 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 74837605CB
	for <linux-nvme@lists.infradead.org>; Fri, 20 Nov 2026 11:28:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBD031F000C4;
	Fri, 20 Nov 2026 11:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795174135;
	bh=dRJsrbWFy8lZ+q0A86lw3VYSJkXTRRykHrpJRl5Bp+g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=keal7UjiNrxraxFhA0lCCqeWyB0Pt2Qjavy/38AvEBjPtBsI7vNE3BzVRuUqJ+go+
	 6Pynu/DBLtkePmIVp0qmwkMz3B631/zzZF2+r8eoLE3krwf462SeRTUDBlFmqKqlg7
	 qrNi5UXTuvtQdmkTd8NLc4tyBcyUnanaudVh2mY0aiWfZVOK155MNzqbaYGZUYI3H/
	 7CeC+Iy6ZCoOqwTlF0XaTX2J73pe3Pq9zgAZhKWI2lqA/RyOat1dyuY7Hv+wbQ5pSW
	 MOu0qHZjBI6k68ysQsPU7e81qqdSvIkdD4UZxk499mO3I0NUH1EA+Ko4kqsQlsyc5x
	 BCItXZI53oPnA==
Message-ID: <sashiko-outbox-225043@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 5/9] nvmet-auth: parse dhchap key from configfs
 attribute
To: "Hannes Reinecke" <hare@kernel.org>
Cc: linux-nvme@lists.infradead.org
In-Reply-To: <20261120-dhchap-keyring-v4-v4-5-5f8c7d9926ee@kernel.org>
References: <20261120-dhchap-keyring-v4-v4-0-5f8c7d9926ee@kernel.org>
 <20261120-dhchap-keyring-v4-v4-5-5f8c7d9926ee@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 11:28:54 +0000
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
- [High] nvmet-auth: missing error abort and invalid status in
  nvmet_setup_auth()
- [High] nvmet-auth: missing initialization of ctrl->shash_id in
  nvmet_setup_auth()
- [High] nvmet-auth: missing length checks in nvme_dhchap_psk_preparse()
- [Medium] nvmet-auth: memory leak of keydata in
  nvmet_host_dhchap_ctrl_key_store()
- [Medium] nvmet-auth: empty writes rejected in configfs key store
  callbacks
--

commit 4bc851b3a915dfe8fe3d7c3db8fe8c3fa58c01ca
Author: Hannes Reinecke <hare@kernel.org>

nvmet-auth: parse dhchap key from configfs attribute

This commit converts the nvmet configfs DH-HMAC-CHAP key handling to store
host and controller keys as struct key pointers rather than raw secret
strings.

> diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
> index 26457ce4acc2a..33b45b4b202d4 100644
> --- a/drivers/nvme/target/auth.c
> +++ b/drivers/nvme/target/auth.c
> @@ -19,52 +19,63 @@

[ ... ]

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

[Severity: High]
Can passing unvalidated configfs strings into nvme_auth_extract_key()
underflow datalen and ret in nvme_dhchap_psk_preparse()?

nvme_auth_extract_key() calls nvme_dhchap_psk_create() -> key_create() ->
nvme_dhchap_psk_preparse():

drivers/nvme/common/keyring.c:nvme_dhchap_psk_preparse() {
	...
	if (sscanf(prep->data, "DHHC-%01hhu:%02hhu:%*s",
		   &version, &hmac) !=3D 2) {
		...
		return -EINVAL;
	}

	/* skip header and final ':' character */
	datalen -=3D 11;
	...
	ret =3D base64_decode(prep->data + 10, datalen, upayload->data,
			    true, BASE64_STD);
	if (ret < 0) {
		...
		return ret;
	}
	ret -=3D 4;
	crc =3D ~crc32(~0, upayload->data, ret);
	...
}

Because %02hhu matches 1 or 2 digits and %*s is not counted in sscanf()'s
return value, a short string such as "DHHC-1:1:" (9 bytes) returns 2 with
datalen < 11, so datalen -=3D 11 underflows size_t datalen and passes a huge
length to base64_decode().  Similarly, a short payload that decodes to 0..3
bytes (such as "DHHC-1:01:AA=3D=3D:") makes ret -=3D 4 negative, which is t=
hen
converted to size_t in crc32() and reads past upayload->data.

[ ... ]

> @@ -186,44 +195,74 @@ u8 nvmet_setup_auth(struct nvmet_ctrl *ctrl, struct=
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
> +	}
> +	key_id =3D key_serial(key);
> +	up_read(&key->sem);
> +	if (ret) {
> +		pr_warn("host key %08x invalidated\n", key_id);
> +		key_put(key);
> +		key =3D ERR_PTR(-EKEYREVOKED);
>  	}

[Severity: High]
When key_validate(key) fails on host->dhchap_key, doesn't execution fall
through instead of setting ret =3D NVME_AUTH_DHCHAP_FAILURE_NOT_USABLE and
jumping to out_unlock?

If host->dhchap_ctrl_key is present and valid, the second key_validate()
overwrites ret with 0, so nvmet_setup_auth() returns 0 while leaving
ctrl->host_key NULL on initial connect, bypassing authentication because
nvmet_has_auth() and nvmet_check_auth_status() treat a NULL ctrl->host_key
as no authentication required.  If host->dhchap_ctrl_key is absent or also
invalid, nvmet_setup_auth() returns the negative errno from key_validate()
truncated to u8 instead of NVME_AUTH_DHCHAP_FAILURE_NOT_USABLE, and if
key_get() returns NULL it jumps to out_unlock with ret =3D=3D 0.

> -	key_put(ctrl->host_key);
> -	ctrl->host_key =3D host_key;
> -	key_put(ctrl->ctrl_key);
> -	ctrl->ctrl_key =3D ctrl_key;
> -	ctrl->shash_id =3D host->dhchap_hash_id;
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

[Severity: High]
Does dropping ctrl->shash_id =3D host->dhchap_hash_id leave ctrl->shash_id =
at
0?

nvmet_auth_negotiate() matches the host's proposed HMAC IDs against
ctrl->shash_id, so leaving it at 0 ignores the host's configured dhchap_hash
attribute and always falls back to fallback_hash_id (and passes 0 to
nvme_auth_hmac_name() in the debug prints here).

> diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configf=
s.c
> index 27c50fa533e70..880cf5151588a 100644
> --- a/drivers/nvme/target/configfs.c
> +++ b/drivers/nvme/target/configfs.c

[ ... ]

> @@ -2251,9 +2266,19 @@ static ssize_t nvmet_host_dhchap_key_store(struct =
config_item *item,
>  		const char *page, size_t count)
>  {
>  	struct nvmet_host *host =3D to_host(item);
> +	u8 *keydata;
> +	size_t len;
>  	int ret;
> =20
> -	ret =3D nvmet_auth_set_key(host, page, false);
> +	len =3D strcspn(page, "\n");
> +	if (!len)
> +		return -EINVAL;
> +	keydata =3D kstrndup(page, len, GFP_KERNEL);
> +	if (!keydata)
> +		return -ENOMEM;
> +
> +	ret =3D nvmet_auth_set_key(host, keydata, false);
> +	kfree_sensitive(keydata);

[Severity: Medium]
Does returning -EINVAL when !len in nvmet_host_dhchap_key_store() and
nvmet_host_dhchap_ctrl_key_store() prevent clearing a configured key via
configfs?  An empty or newline-only write is rejected before reaching the
!strlen(secret) revocation branch in nvmet_auth_set_key().

[ ... ]

> @@ -2284,9 +2323,18 @@ static ssize_t nvmet_host_dhchap_ctrl_key_store(st=
ruct config_item *item,
>  		const char *page, size_t count)
>  {
>  	struct nvmet_host *host =3D to_host(item);
> +	u8 *keydata;
> +	size_t len;
>  	int ret;
> =20
> -	ret =3D nvmet_auth_set_key(host, page, true);
> +	len =3D strcspn(page, "\n");
> +	if (!len)
> +		return -EINVAL;
> +	keydata =3D kstrndup(page, len, GFP_KERNEL);
> +	if (!keydata)
> +		return -ENOMEM;
> +
> +	ret =3D nvmet_auth_set_key(host, keydata, true);
>  	/*
>  	 * Re-authentication is a soft state, so keep the
>  	 * current authentication valid until the host

[Severity: Medium]
Does nvmet_host_dhchap_ctrl_key_store() leak keydata?  Unlike
nvmet_host_dhchap_key_store(), it does not call kfree_sensitive(keydata)
after nvmet_auth_set_key().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120-dhchap-key=
ring-v4-v4-0-5f8c7d9926ee@kernel.org?part=3D5

