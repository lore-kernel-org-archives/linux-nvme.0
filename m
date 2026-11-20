Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20863606A320
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Nov 2026 11:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=KRoS42cB;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TBEssKZp
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=KfujoYpnZjonzngo17A6gfMml3wbndpsk1WnRJ3v9Mg=; b=KRoS42cBUj4fl92b3NrutJnJdk
	R3AkPjz0beLFAlTkU0tJ8Qz2Nxwwnn7FGnUeRLeo+UZRtgUv3TCr4t1mPS3pA6/eLrJ45Wsf00QGQ
	hH7nPlHJQ7aZYSyY5S6giG1/+VpA6/tAaYKG7aJTPDdvCL60YfHfFwfmYSdJMU+su5fgaAwY3Fd3W
	/xFZtlbdlXd4LCd1JamDhxUeueku0cE4HoIT/Hs2WL3ekHvpS3b0hoWiZAwlDn2FE44DMddcj+hEQ
	KyCCCsyIKLoJz7RjEXPF1j0lGVzNnNWdjK3hLbxtBXe/zUN94VzjoyX5r1bWkO91agw20a3+Gbbyz
	uVb8WKzQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUMqs-0000000EoV4-3IeK;
	Fri, 20 Nov 2026 11:32:22 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUMqr-0000000EoUY-1aEv
	for linux-nvme@lists.infradead.org;
	Fri, 20 Nov 2026 11:32:21 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id BFE6160218
	for <linux-nvme@lists.infradead.org>; Fri, 20 Nov 2026 11:32:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C87A1F000D1;
	Fri, 20 Nov 2026 11:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795174340;
	bh=KfujoYpnZjonzngo17A6gfMml3wbndpsk1WnRJ3v9Mg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TBEssKZp6r3SZJ+2dJABEyL0dkpBAiUOdC3E6LoLOBpWWE33haYn6OY+xHqF5nls6
	 y1KUTzfuTkG+K4RaUbdbENwHjfGN9D5XMRsQo55k8P6sfgJQgRo92EF4dYVRmFl7Hp
	 RP35iediJ3CnY2kCKtbPs+6QuMt5u4WXAkTtO8IDjyOx9hOQt+ZVzP4liGgDfIFTA5
	 tPNsdp+T+YBc/8tt+ejnLCeQVDXbnYksVEc8RJBypg5xzUHLm1N58Y0p/oMjisdaC3
	 ivc/3LpHiL9MUTkMQgRBDd89nVma9ScoUlslUTHFkPNVHAlRvHhijvcApkmXpA4XC9
	 Qea+SChjRzeOQ==
Message-ID: <sashiko-outbox-225048@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 4/9] nvme: parse dhchap keys during option parsing
To: "Hannes Reinecke" <hare@kernel.org>
Cc: linux-nvme@lists.infradead.org
In-Reply-To: <20261120-dhchap-keyring-v4-v4-4-5f8c7d9926ee@kernel.org>
References: <20261120-dhchap-keyring-v4-v4-0-5f8c7d9926ee@kernel.org>
 <20261120-dhchap-keyring-v4-v4-4-5f8c7d9926ee@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 11:32:19 +0000
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

Thank you for your contribution! Sashiko AI review found 7 potential
issues to consider:
- [High] nvme-fabrics: wrong key revoked in nvmf_free_options() for
  dhchap_ctrl_key
- [High] nvme: build failure in nvmf_parse_options() and sysfs.c without
  auth/keyring
- [High] nvme: removing secret length checks exposes underflows in key
  preparsing
- [Medium] nvme: out-of-bounds write on read error in
  dhchap_ctrl_secret_show()
- [Medium] nvme-auth: host_key ref leak and inverted check in
  nvme_auth_init_ctrl()
- [Medium] nvme: unlocked host_key and ctrl_key access in dhchap sysfs
  show callbacks
- [Low] nvme: check !ctrl->opts for dhchap_key attrs in
  nvme_dev_attrs_are_visible()
--

commit ddf0d4926edd9ec44ea25839b02c0ba20380f64e
Author: Hannes Reinecke <hare@kernel.org>

nvme: parse dhchap keys during option parsing

This commit parses DH-HMAC-CHAP secrets into struct key pointers during
fabric option parsing instead of storing raw secret strings in
nvmf_ctrl_options, and adds sysfs attributes to expose the host and
controller key serials.

> diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
> index 0ddf3834f4ea2..c189096f825ea 100644
> --- a/drivers/nvme/host/auth.c
> +++ b/drivers/nvme/host/auth.c
[ ... ]
> @@ -1038,31 +1056,68 @@ int nvme_auth_init_ctrl(struct nvme_ctrl *ctrl)
>  	INIT_WORK(&ctrl->dhchap_auth_work, nvme_ctrl_auth_work);
>  	if (!ctrl->opts)
>  		return 0;
> -	ctrl->host_key =3D nvme_auth_extract_key(ctrl->opts->keyring,
> -				ctrl->opts->dhchap_secret,
> -				strlen(ctrl->opts->dhchap_secret));
> -	if (IS_ERR(ctrl->host_key)) {
> -		ret =3D PTR_ERR(ctrl->host_key);
> -		ctrl->host_key =3D NULL;
> -		return ret;
> +	if (!ctrl->opts->dhchap_key) {
> +		nvme_auth_clear_host_key(ctrl);
> +		nvme_auth_clear_ctrl_key(ctrl);
> +		return 0;
>  	}
> +	if (!ctrl->host_key)
> +		nvme_auth_clear_host_key(ctrl);
>
> -	ctrl->ctrl_key =3D nvme_auth_extract_key(ctrl->opts->keyring,
> -				ctrl->opts->dhchap_ctrl_secret,
> -				strlen(ctrl->opts->dhchap_ctrl_secret));
> -	if (IS_ERR(ctrl->ctrl_key)) {
> -		ret =3D PTR_ERR(ctrl->ctrl_key);
> -		ctrl->ctrl_key =3D NULL;
> -		goto err_free_dhchap_secret;
> +	ctrl->host_key =3D key_get(ctrl->opts->dhchap_key);
> +	if (!ctrl->host_key) {
> +		dev_warn(ctrl->device,
> +			 "dhchap host key %08x not present\n",
> +			 key_serial(ctrl->opts->dhchap_key));
> +		return -ENOKEY;
>  	}
> +	down_read(&ctrl->host_key->sem);
> +	ret =3D key_validate(ctrl->host_key);
> +	up_read(&ctrl->host_key->sem);
> +	if (ret) {
> +		dev_warn(ctrl->device,
> +			 "dhchap host key %08x invalidated\n",
> +			 key_serial(ctrl->host_key));
> +		key_put(ctrl->host_key);
> +		ctrl->host_key =3D NULL;
> +		return -ENOKEY;
> +	}
> +	dev_dbg(ctrl->device,
> +		"%s: using dhchap host key %08x\n",
> +		__func__, key_serial(ctrl->host_key));
>
> -	if (!ctrl->opts->dhchap_secret && !ctrl->opts->dhchap_ctrl_secret)
> -		return 0;
> +	if (ctrl->ctrl_key)
> +		nvme_auth_clear_ctrl_key(ctrl);
> +
> +	if (ctrl->opts->dhchap_ctrl_key) {
> +		ctrl->ctrl_key =3D key_get(ctrl->opts->dhchap_ctrl_key);
> +		if (!ctrl->ctrl_key) {
> +			dev_warn(ctrl->device,
> +				 "dhchap ctrl key %08x not present\n",
> +				 key_serial(ctrl->opts->dhchap_ctrl_key));
> +			return -ENOKEY;
> +		}
> +		down_read(&ctrl->ctrl_key->sem);
> +		ret =3D key_validate(ctrl->ctrl_key);
> +		up_read(&ctrl->ctrl_key->sem);
> +		if (ret) {
> +			dev_warn(ctrl->device,
> +				 "dhchap ctrl key %08x invalidated\n",
> +				 key_serial(ctrl->ctrl_key));
> +			key_put(ctrl->ctrl_key);
> +			ctrl->ctrl_key =3D NULL;
> +			return -EKEYREVOKED;
> +		}

[Severity: Medium]
Do the error returns in the ctrl->opts->dhchap_ctrl_key block leak the
ctrl->host_key reference taken earlier in nvme_auth_init_ctrl()?

When nvme_auth_init_ctrl() fails, nvme_init_ctrl() jumps to
out_release_instance before initializing ctrl->ctrl_device, so
nvme_auth_free() is never called on that error path.

Also, the check before nvme_auth_clear_host_key(ctrl) is inverted
(!ctrl->host_key instead of ctrl->host_key), and nvme_init_ctrl() calls
nvme_auth_init_ctrl() before assigning ctrl->device =3D &ctrl->ctrl_device,
so the dev_warn() and dev_dbg() calls here pass a NULL ctrl->device.

> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
> index 5ed91557f0706..7ed8618257ca9 100644
> --- a/drivers/nvme/host/fabrics.c
> +++ b/drivers/nvme/host/fabrics.c
[ ... ]
> @@ -1020,14 +1024,8 @@ static int nvmf_parse_options(struct nvmf_ctrl_opt=
ions *opts,
>  				ret =3D -ENOMEM;
>  				goto out;
>  			}
> -			if (strlen(p) < 11 || strncmp(p, "DHHC-1:", 7)) {
> -				pr_err("Invalid DH-CHAP secret %s\n", p);
> -				kfree_sensitive(p);
> -				ret =3D -EINVAL;
> -				goto out;
> -			}
> -			kfree_sensitive(opts->dhchap_secret);
> -			opts->dhchap_secret =3D p;
> +			kfree_sensitive(host_secret);
> +			host_secret =3D p;
>  			break;
>  		case NVMF_OPT_DHCHAP_CTRL_SECRET:
>  			p =3D match_strdup(args);
> @@ -1035,14 +1033,8 @@ static int nvmf_parse_options(struct nvmf_ctrl_opt=
ions *opts,
>  				ret =3D -ENOMEM;
>  				goto out;
>  			}
> -			if (strlen(p) < 11 || strncmp(p, "DHHC-1:", 7)) {
> -				pr_err("Invalid DH-CHAP secret %s\n", p);
> -				kfree_sensitive(p);
> -				ret =3D -EINVAL;
> -				goto out;
> -			}
> -			kfree_sensitive(opts->dhchap_ctrl_secret);
> -			opts->dhchap_ctrl_secret =3D p;
> +			kfree_sensitive(ctrl_secret);
> +			ctrl_secret =3D p;
>  			break;

[Severity: High]
Does removing the minimum length checks here and in dhchap_secret_store() /
dhchap_ctrl_secret_store() allow short secret strings to underflow datalen
and ret in nvme_dhchap_psk_preparse()?

drivers/nvme/common/keyring.c:nvme_dhchap_psk_preparse() {
    ...
	if (sscanf(prep->data, "DHHC-%01hhu:%02hhu:%*s",
		   &version, &hmac) !=3D 2) {
    ...
	}

	/* skip header and final ':' character */
	datalen -=3D 11;
}

Because %*s is assignment-suppressed and %02hhu matches one or two digits,
sscanf() returns 2 for 8- to 10-byte strings such as "DHHC-1:0:a", causing
unsigned datalen -=3D 11 to wrap around and wrap the kzalloc() size
calculation sizeof(*upayload) + datalen.  For 11- to 15-byte inputs such as
"DHHC-1:00:a" where base64_decode() returns 0..3, ret -=3D 4 in
nvme_dhchap_psk_preparse() becomes negative and is passed as an unsigned
length to crc32(~0, upayload->data, ret), reading out-of-bounds across
kernel memory.

[ ... ]

> @@ -1086,6 +1078,41 @@ static int nvmf_parse_options(struct nvmf_ctrl_opt=
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
> +		pr_debug("lookup host identity '%s'\n", host_secret);
> +		key =3D nvme_auth_extract_key(opts->keyring, host_secret,
> +					    strlen(host_secret));
> +		if (IS_ERR(key)) {
> +			ret =3D PTR_ERR(key);
> +			goto out;
> +		}
> +		pr_debug("using dhchap host key %08x\n", key_serial(key));
> +		opts->dhchap_key =3D key;
> +	}
> +	if (ctrl_secret) {
> +		if (!opts->dhchap_key) {
> +			ret =3D -EINVAL;
> +			goto out;
> +		}
> +		pr_debug("lookup ctrl identity '%s'\n", ctrl_secret);
> +		key =3D nvme_auth_extract_key(opts->keyring, ctrl_secret,
> +					    strlen(ctrl_secret));

[Severity: High]
Does calling nvme_auth_extract_key() unconditionally here break the build
when CONFIG_NVME_FABRICS is enabled without CONFIG_NVME_AUTH (or when
CONFIG_NVME_FABRICS=3Dy and CONFIG_NVME_AUTH=3Dm)?

include/linux/nvme-auth.h declares nvme_auth_extract_key() without a
!CONFIG_NVME_AUTH stub, and match_token() is an external call so the
compiler cannot dead-code-eliminate the host_secret and ctrl_secret
branches when CONFIG_NVME_HOST_AUTH is disabled.

In addition, drivers/nvme/host/sysfs.c now includes <linux/nvme-keyring.h>
unconditionally, which fails to compile when CONFIG_NVME_KEYRING is
disabled due to a stray semicolon and a non-inline function definition in
the fallback block:

include/linux/nvme-keyring.h:
static inline struct key *nvme_dhchap_psk_lookup(struct key *keyring,
		const char *hostnqn, const char *subnqn, u8 hmac);
{
	return ERR_PTR(-EOPNOTSUPP);
}
u8 nvme_dhchap_psk_hash(struct key *key)
{
	return 0;
}

[ ... ]

> @@ -1304,8 +1326,18 @@ void nvmf_free_options(struct nvmf_ctrl_options *o=
pts)
>  	kfree(opts->subsysnqn);
>  	kfree(opts->host_traddr);
>  	kfree(opts->host_iface);
> -	kfree_sensitive(opts->dhchap_secret);
> -	kfree_sensitive(opts->dhchap_ctrl_secret);
> +	if (opts->dhchap_key) {
> +		pr_debug("revoke dhchap host key %08x\n",
> +			 key_serial(opts->dhchap_key));
> +		key_revoke(opts->dhchap_key);
> +		key_put(opts->dhchap_key);
> +	}
> +	if (opts->dhchap_ctrl_key) {
> +		pr_debug("revoke dhchap ctrl key %08x\n",
> +			 key_serial(opts->dhchap_ctrl_key));
> +		key_revoke(opts->dhchap_key);
> +		key_put(opts->dhchap_ctrl_key);
> +	}

[Severity: High]
In the opts->dhchap_ctrl_key block, should key_revoke() be passed
opts->dhchap_ctrl_key instead of opts->dhchap_key?  Passing
opts->dhchap_key dereferences the host key after key_put(opts->dhchap_key)
has already dropped its reference, and leaves opts->dhchap_ctrl_key
unrevoked.

> diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
> index a5c1511e49ac2..1311f5e29b004 100644
> --- a/drivers/nvme/host/sysfs.c
> +++ b/drivers/nvme/host/sysfs.c
[ ... ]
> @@ -818,11 +820,23 @@ static ssize_t dhchap_secret_show(struct device *de=
v,
>  		struct device_attribute *attr, char *buf)
>  {
>  	struct nvme_ctrl *ctrl =3D dev_get_drvdata(dev);
> -	struct nvmf_ctrl_options *opts =3D ctrl->opts;
> +	struct key *key =3D ctrl->host_key;
> +	ssize_t count;
>
> -	if (!opts->dhchap_secret)
> +	if (!key)
>  		return sysfs_emit(buf, "none\n");
> -	return sysfs_emit(buf, "%s\n", opts->dhchap_secret);
> +	down_read(&key->sem);
> +	if (key_validate(key))
> +		count =3D sysfs_emit(buf, "<invalidated>\n");
> +	else {
> +		count =3D key->type->read(key, buf, PAGE_SIZE);
> +		if (count > 0) {
> +			buf[count] =3D '\n';
> +			count++;
> +		}
> +	}
> +	up_read(&key->sem);
> +	return count;
>  }
[ ... ]
> @@ -830,36 +844,47 @@ static ssize_t dhchap_secret_store(struct device *d=
ev,
[ ... ]
> +	mutex_lock(&ctrl->dhchap_auth_mutex);
> +	old_key =3D ctrl->host_key;
> +	dev_dbg(ctrl->dev, "revoke host key %08x\n",
> +		key_serial(old_key));
> +	key_revoke(old_key);
> +
> +	ctrl->host_key =3D key;
> +	mutex_unlock(&ctrl->dhchap_auth_mutex);
> +	key_put(old_key);

[Severity: Medium]
Can a concurrent read of dhchap_secret (or dhchap_ctrl_secret, dhchap_key,
or dhchap_ctrl_key) race with dhchap_secret_store() or
dhchap_ctrl_secret_store() and trigger a use-after-free on the old key?

CPU0                              CPU1
dhchap_secret_show()
  key =3D ctrl->host_key;
                                  dhchap_secret_store()
                                    mutex_lock(&ctrl->dhchap_auth_mutex);
                                    old_key =3D ctrl->host_key;
                                    key_revoke(old_key);
                                    ctrl->host_key =3D key;
                                    mutex_unlock(&ctrl->dhchap_auth_mutex);
                                    key_put(old_key);  <-- frees old_key
  down_read(&key->sem);  <-- use-after-free

None of dhchap_secret_show(), dhchap_ctrl_secret_show(), dhchap_key_show(),
or dhchap_ctrl_key_show() hold ctrl->dhchap_auth_mutex or take a key_get()
reference before dereferencing ctrl->host_key or ctrl->ctrl_key.  Once a
key has been replaced via sysfs store (so opts->dhchap_key no longer holds
a reference), ctrl->host_key holds the only reference, and key_put(old_key)
frees it while a concurrent show callback is using it.

> @@ -873,11 +898,23 @@ static ssize_t dhchap_ctrl_secret_show(struct devic=
e *dev,
>  		struct device_attribute *attr, char *buf)
>  {
>  	struct nvme_ctrl *ctrl =3D dev_get_drvdata(dev);
> -	struct nvmf_ctrl_options *opts =3D ctrl->opts;
> +	struct key *key =3D ctrl->ctrl_key;
> +	size_t count;
>
> -	if (!opts->dhchap_ctrl_secret)
> +	if (!key)
>  		return sysfs_emit(buf, "none\n");
> -	return sysfs_emit(buf, "%s\n", opts->dhchap_ctrl_secret);
> +	down_read(&key->sem);
> +	if (key_validate(key))
> +		count =3D sysfs_emit(buf, "<invalidated>");
> +	else {
> +		count =3D key->type->read(key, buf, PAGE_SIZE);
> +		if (count > 0) {
> +			buf[count] =3D '\n';
> +			count++;
> +		}
> +	}
> +	up_read(&key->sem);
> +	return count;
>  }

[Severity: Medium]
Can a negative error return from key->type->read() cause an out-of-bounds
write before buf in dhchap_ctrl_secret_show() and dhchap_key_show()?

Unlike dhchap_secret_show(), which declares ssize_t count, both
dhchap_ctrl_secret_show() and dhchap_key_show() declare count as unsigned
size_t.  If key->type->read() returns a negative error code (such as
-EINVAL), count wraps to a large positive value, passes count > 0, and
writes '\n' to buf[count] out-of-bounds.  Commit "nvme: allow to pass in
key description as dhchap secret" later in this series replaces
key->type->read() in dhchap_key_show(), but dhchap_ctrl_secret_show()
retains the unsigned size_t count and also omits the trailing newline on
"<invalidated>".

[ ... ]

> @@ -925,6 +970,41 @@ static ssize_t dhchap_ctrl_secret_store(struct devic=
e *dev,
>  }
>
>  static DEVICE_ATTR_ADMIN_RW(dhchap_ctrl_secret);
> +
> +static ssize_t dhchap_key_show(struct device *dev,
> +		struct device_attribute *attr, char *buf)
> +{
> +	struct nvme_ctrl *ctrl =3D dev_get_drvdata(dev);
> +	struct key *key =3D ctrl->host_key;
> +	size_t count;
> +
> +	if (!key)
> +		return 0;
> +	down_read(&key->sem);
> +	if (key_validate(key))
> +		count =3D sysfs_emit(buf, "<invalidated>\n");
> +	else {
> +		count =3D key->type->read(key, buf, PAGE_SIZE);
> +		if (count > 0) {
> +			buf[count] =3D '\n';
> +			count++;
> +		}
> +	}
> +	up_read(&key->sem);
> +	return count;
> +}
> +static DEVICE_ATTR_ADMIN_RO(dhchap_key);
> +
> +static ssize_t dhchap_ctrl_key_show(struct device *dev,
> +		struct device_attribute *attr, char *buf)
> +{
> +	struct nvme_ctrl *ctrl =3D dev_get_drvdata(dev);
> +
> +	if (!ctrl->ctrl_key)
> +		return 0;
> +	return sysfs_emit(buf, "%08x\n", key_serial(ctrl->ctrl_key));
> +}
> +static DEVICE_ATTR_ADMIN_RO(dhchap_ctrl_key);
>  #endif
>
>  static struct attribute *nvme_dev_attrs[] =3D {
> @@ -956,6 +1036,8 @@ static struct attribute *nvme_dev_attrs[] =3D {
>  #ifdef CONFIG_NVME_HOST_AUTH
>  	&dev_attr_dhchap_secret.attr,
>  	&dev_attr_dhchap_ctrl_secret.attr,
> +	&dev_attr_dhchap_key.attr,
> +	&dev_attr_dhchap_ctrl_key.attr,
>  #endif

[Severity: Low]
Should nvme_dev_attrs_are_visible() hide dev_attr_dhchap_key.attr and
dev_attr_dhchap_ctrl_key.attr when !ctrl->opts, the same way it hides
dev_attr_dhchap_secret.attr and dev_attr_dhchap_ctrl_secret.attr?  Without
that check, both attributes appear on non-Fabrics controllers (such as PCIe
controllers) when CONFIG_NVME_HOST_AUTH is enabled.

Also, in this patch dhchap_key_show() outputs the key payload via
key->type->read() instead of key_serial(key) as dhchap_ctrl_key_show() does
(though commit "nvme: allow to pass in key description as dhchap secret"
later in the series updates dhchap_key_show() to emit key_serial()).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120-dhchap-key=
ring-v4-v4-0-5f8c7d9926ee@kernel.org?part=3D4

