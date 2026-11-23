Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC802606A335
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Nov 2026 12:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=bYSySnvN;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RrVNT3oy
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=aXhSaYn7FB4FfCk0IAqjmbKNJRF7SKbSWnVKWnjnYeo=; b=bYSySnvNTL6vvq8twYBEh68Ag0
	IRXJD38aDczBqsGfU0xMm5GGvp1yx24QwksZvWLHicGru2V+epMyoRYGprBiIkY00Wk/Pd5h3tF3f
	MOyXSTbuMfvfuhjcM6DjUoB3CWs1FS0BsTHUilbCK68+untMAvpDsNxiL42pqO1+DcUFrVw6wxzZ6
	Us+vVn7zXpo5TP8cMZsdm4uDQvzQkXsHbzB0cj4jpHJWZ7J4nqNREJVCmq4lse0QbXdiqrAQtnssD
	H7BWfM8Zvf4Vmnkqf6Valtts6FKkuyyZsGSbhKjbBgNzLyF4U7avf2rTUqv381w6EEWEDGRKUWOic
	nmNImbMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVTG1-00000003NWs-32me;
	Mon, 23 Nov 2026 12:34:53 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVTFu-00000003NVw-3GDz
	for linux-nvme@lists.infradead.org;
	Mon, 23 Nov 2026 12:34:46 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 52EE341409
	for <linux-nvme@lists.infradead.org>; Mon, 23 Nov 2026 12:34:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93DE71F000EC;
	Mon, 23 Nov 2026 12:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795437285;
	bh=aXhSaYn7FB4FfCk0IAqjmbKNJRF7SKbSWnVKWnjnYeo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RrVNT3oyEGB2Kj6dNEZQqljHpG+IZ6Tgj9vAE5UKvM4uJfwQlZE+TDVpE0X3FeW+1
	 XCPlSJO6hnC1IFFGdhuh3cPlsGp0s3gEpwTTdQXJuLx0JTjUwq6AkyhI3Sjw/9Pmwf
	 6X7s1iDnFDKepsZ8GS5WEUR1pltuHOIvj/B/Tf8GwlZXh+kfVZ/hBoaGjlMF0xwnC1
	 TL4CCWGw0Sm/AsX8bfwgViJJ/H3tC1wAhn9lfqbego98G590q+X6webBKmI+r0nQAf
	 g6GlaVlxQhJTZurj9TCaOJMwAS8Fdjoeof4FcOGRV79VCZIiyul07YgCnG6xhVBcuV
	 qDFTPl6hxLCjg==
Message-ID: <sashiko-outbox-229226@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 4/9] nvme: parse dhchap keys during option parsing
To: "Hannes Reinecke" <hare@kernel.org>
Cc: linux-nvme@lists.infradead.org
In-Reply-To: <20261123-dhchap-keyring-v4-v5-4-81eefb4c0724@kernel.org>
References: <20261123-dhchap-keyring-v4-v5-0-81eefb4c0724@kernel.org>
 <20261123-dhchap-keyring-v4-v5-4-81eefb4c0724@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 12:34:45 +0000
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
- [High] nvme: build failure in sysfs.c when CONFIG_NVME_KEYRING is
  disabled
- [Low] nvme-auth: log of unassigned keys and NULL device in
  nvme_auth_init_ctrl()
- [Low] nvme-fabrics: dead !CONFIG_NVME_HOST_AUTH branches in
  nvmf_parse_options()
- [Low] nvme: missing trailing newline in dhchap_ctrl_secret_show() on
  invalid key
- [Low] nvme: wrong device pointer logged in dhchap_secret_store() and
  ctrl store
- [Low] nvme: undocumented dhchap_key sysfs attrs and inaccurate
  changelog
--

commit 8a46b5c132a1f37ed808c2b1576c3ace8af7cf7f
Author: Hannes Reinecke <hare@kernel.org>

nvme: parse dhchap keys during option parsing

This commit extracts DH-HMAC-CHAP secrets into key objects during fabrics
option parsing and exposes the active keys and their serial numbers via
controller sysfs attributes.

> diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
> index 0ddf3834f4ea2..535cc433dd35d 100644
> --- a/drivers/nvme/host/auth.c
> +++ b/drivers/nvme/host/auth.c
[ ... ]
> @@ -1029,40 +1024,106 @@ static void nvme_ctrl_auth_work(struct work_stru=
ct *work)
[ ... ]
> +	dev_dbg(ctrl->device,
> +		"%s: using dhchap host key %08x\n",
> +		__func__, key_serial(ctrl->host_key));
> +	if (ctrl->host_key)
> +		nvme_auth_clear_host_key(ctrl);
> +	ctrl->host_key =3D host_key;
> +
> +	if (ctrl->ctrl_key)
> +		nvme_auth_clear_ctrl_key(ctrl);
> +	if (ctrl_key) {
> +		dev_dbg(ctrl->device,
> +			"%s: using dhchap ctrl key %08x\n",
> +			__func__, key_serial(ctrl->ctrl_key));
> +		ctrl->ctrl_key =3D ctrl_key;
> +	}

[Severity: Low]
Do these two dev_dbg() calls pass ctrl->host_key and ctrl->ctrl_key to
key_serial() before assigning host_key and ctrl_key, always logging key
serial 00000000?

Also, nvme_init_ctrl() calls nvme_auth_init_ctrl() before setting
ctrl->device =3D &ctrl->ctrl_device, so ctrl->device is NULL for all
dev_warn() and dev_dbg() calls in nvme_auth_init_ctrl().

> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
> index 5ed91557f0706..0c09888be31f7 100644
> --- a/drivers/nvme/host/fabrics.c
> +++ b/drivers/nvme/host/fabrics.c
[ ... ]
> @@ -1086,6 +1078,53 @@ static int nvmf_parse_options(struct nvmf_ctrl_opt=
ions *opts,
>  			pr_warn("failfast tmo (%d) larger than controller loss tmo (%d)\n",
>  				opts->fast_io_fail_tmo, ctrl_loss_tmo);
>  	}
> +
> +	opts->host =3D nvmf_host_add(hostnqn, &hostid);
> +	if (IS_ERR(opts->host)) {
> +		ret =3D PTR_ERR(opts->host);
> +		opts->host =3D NULL;
> +		goto out;
> +	}
> +
> +	if (host_secret) {
> +#ifdef CONFIG_NVME_HOST_AUTH
> +		pr_debug("lookup host identity '%s'\n", host_secret);
> +		key =3D nvme_auth_extract_key(opts->keyring, host_secret,
> +					    strlen(host_secret));
> +		if (IS_ERR(key)) {
> +			ret =3D PTR_ERR(key);
> +			goto out;
> +		}
> +		pr_debug("using dhchap host key %08x\n", key_serial(key));
> +		opts->dhchap_key =3D key;
> +#else
> +		pr_warn("nvme authentication is disabled\n");
> +		ret =3D -EINVAL;
> +		goto out;
> +#endif
> +	}
> +	if (ctrl_secret) {
> +#ifdef CONFIG_NVME_HOST_AUTH
> +		if (!opts->dhchap_key) {
> +			ret =3D -EINVAL;
> +			goto out;
> +		}
> +		pr_debug("lookup ctrl identity '%s'\n", ctrl_secret);
> +		key =3D nvme_auth_extract_key(opts->keyring, ctrl_secret,
> +					    strlen(ctrl_secret));
> +		if (IS_ERR(key)) {
> +			ret =3D PTR_ERR(key);
> +			goto out;
> +		}
> +		pr_debug("using dhchap ctrl key %08x\n", key_serial(key));
> +		opts->dhchap_ctrl_key =3D key;
> +#else
> +		pr_warn("nvme authentication is disabled\n");
> +		ret =3D -EINVAL;
> +		goto out;
> +#endif
> +	}

[Severity: Low]
Can the !CONFIG_NVME_HOST_AUTH branches under if (host_secret) and
if (ctrl_secret) ever be reached?

NVMF_OPT_DHCHAP_SECRET and NVMF_OPT_DHCHAP_CTRL_SECRET in opt_tokens are
guarded by #ifdef CONFIG_NVME_HOST_AUTH, so when CONFIG_NVME_HOST_AUTH is
disabled, match_token() rejects dhchap_secret and dhchap_ctrl_secret as
unknown parameters and jumps to out while host_secret and ctrl_secret are
still NULL.

> diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
> index a5c1511e49ac2..e73c3ad89adc0 100644
> --- a/drivers/nvme/host/sysfs.c
> +++ b/drivers/nvme/host/sysfs.c
> @@ -6,6 +6,8 @@
>   */
> =20
>  #include <linux/nvme-auth.h>
> +#include <linux/nvme-keyring.h>
> +#include <linux/key-type.h>
>  #include <linux/blkdev.h>

[Severity: High]
Does including linux/nvme-keyring.h unconditionally in sysfs.c break the
build when CONFIG_NVME_CORE is enabled and CONFIG_NVME_KEYRING is
disabled?

In the !IS_ENABLED(CONFIG_NVME_KEYRING) block of
include/linux/nvme-keyring.h (updated earlier in commit "nvme-auth: switch
to use 'struct key'"), nvme_tls_psk_refresh() has a malformed parameter
list and nvme_dhchap_psk_hash() is defined without static inline:

include/linux/nvme-keyring.h:
    static inline struct key *nvme_tls_psk_refresh(struct key *keyring,
		const char *hostnqn, const char *subnqn, *data, u8 hmac_id,
		u8 *data, size_t data_len, const char *digest)
    ...
    u8 nvme_dhchap_psk_hash(struct key *key)
    {
	return 0;
    }

Since sysfs.c is built for any CONFIG_NVME_CORE configuration and does not
use any symbols from linux/nvme-keyring.h, compiling with
CONFIG_NVME_KEYRING=3Dn fails with syntax and multiple-definition errors.

> @@ -830,36 +850,47 @@ static ssize_t dhchap_secret_store(struct device *d=
ev,
[ ... ]
> +	down_read(&key->sem);
> +	ret =3D key_validate(key);
> +	up_read(&key->sem);
> +	if (ret) {
> +		dev_warn(ctrl->dev, "key %08x invalidated\n", key_serial(key));
> +		dev_dbg(ctrl->dev, "revoke host key %08x\n", key_serial(key));
> +		key_revoke(key);
> +		key_put(key);
> +		kfree_sensitive(dhchap_secret);
> +		return ret;
> +	}
> +	mutex_lock(&ctrl->dhchap_auth_mutex);
> +	old_key =3D ctrl->host_key;
> +	dev_dbg(ctrl->dev, "revoke host key %08x\n",
> +		key_serial(old_key));
> +	key_revoke(old_key);

[Severity: Low]
Should these dev_warn() and dev_dbg() calls in dhchap_secret_store() and
dhchap_ctrl_secret_store() use ctrl->device instead of ctrl->dev?

ctrl->dev is the parent transport device (such as the shared
/sys/class/nvme-fabrics/ctl device), whereas ctrl->device is the nvmeX
controller device used by the rest of the function.

> @@ -873,11 +904,28 @@ static ssize_t dhchap_ctrl_secret_show(struct devic=
e *dev,
>  		struct device_attribute *attr, char *buf)
>  {
>  	struct nvme_ctrl *ctrl =3D dev_get_drvdata(dev);
> -	struct nvmf_ctrl_options *opts =3D ctrl->opts;
> +	struct key *key;
> +	ssize_t count;
> =20
> -	if (!opts->dhchap_ctrl_secret)
> +	mutex_lock(&ctrl->dhchap_auth_mutex);
> +	key =3D ctrl->ctrl_key;
> +	if (!key) {
> +		mutex_unlock(&ctrl->dhchap_auth_mutex);
>  		return sysfs_emit(buf, "none\n");
> -	return sysfs_emit(buf, "%s\n", opts->dhchap_ctrl_secret);
> +	}
> +	down_read(&key->sem);
> +	if (key_validate(key))
> +		count =3D sysfs_emit(buf, "<invalidated>");

[Severity: Low]
Is a trailing newline missing from "<invalidated>" in
dhchap_ctrl_secret_show()?  dhchap_secret_show(), dhchap_key_show(), and
dhchap_ctrl_key_show() all emit "<invalidated>\n".

[ ... ]

> @@ -925,6 +981,52 @@ static ssize_t dhchap_ctrl_secret_store(struct devic=
e *dev,
>  }
> =20
>  static DEVICE_ATTR_ADMIN_RW(dhchap_ctrl_secret);
> +
> +static ssize_t dhchap_key_show(struct device *dev,
> +		struct device_attribute *attr, char *buf)
> +{
[ ... ]
> +}
> +static DEVICE_ATTR_ADMIN_RO(dhchap_key);
> +
> +static ssize_t dhchap_ctrl_key_show(struct device *dev,
> +		struct device_attribute *attr, char *buf)
> +{
[ ... ]
> +}
> +static DEVICE_ATTR_ADMIN_RO(dhchap_ctrl_key);

[Severity: Low]
This isn't a bug, but the new dhchap_key and dhchap_ctrl_key sysfs
attributes are not mentioned in the commit message or documented in
Documentation/ABI/stable/sysfs-nvme.  Also, the commit message says the
key serial is stored in struct nvmf_ctrl_options, whereas opts stores
struct key pointers (dhchap_key and dhchap_ctrl_key).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123-dhchap-key=
ring-v4-v5-0-81eefb4c0724@kernel.org?part=3D4

