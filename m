Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5718A606A33F
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Nov 2026 14:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=cCB3wUA3;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eNTPRTKJ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=YkaimypVfCpq6j4BAH6otlWMPVoAgw31YOFb6o2TkCQ=; b=cCB3wUA392kqdzQ2wUGihwwlz2
	bQ8leB13Gf+Hd+Oz6+TfUhkabOWqV3ENVy9BQg/jbFoTztG9fCmNQmE4CdZuZuwI8/3TSyo4cTT5q
	8Y03OVjV9QnXAnaEqktuRfZywNPSl/MD1hROqbUjovp/nhBijxymrOWm0k2xU34XAXL9XQYYJDjSw
	BfG7OcDr9hYFTX7VTzhbqNqbpV0BKLbs3U/JzAP9izLOJ32JCrjwkVQ/rX50u4bCjwhgIasf+1KEV
	cY8JPpRUpRxUg5qhVso4VOR/SeuB4uHwYM/ghbUqDxZxXjK35NdPckCMuuPXsLUZYFh8Bqmvcyptn
	akdrSfvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWaW1-0000000DZEU-0C49;
	Thu, 26 Nov 2026 14:32:01 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWaVy-0000000DZE1-44IB
	for linux-nvme@lists.infradead.org;
	Thu, 26 Nov 2026 14:32:00 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id B6E0A411B1;
	Thu, 26 Nov 2026 14:31:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69BA31F000C4;
	Thu, 26 Nov 2026 14:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795703518;
	bh=YkaimypVfCpq6j4BAH6otlWMPVoAgw31YOFb6o2TkCQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eNTPRTKJzt7Ll30ThpKT+QvZ7wyZ607rXHIOZELw++8EVZJW+PMQkNVEP/PA1dTmO
	 4+3+wGT2HjK1LqQ3FrKWaKAZMBf8v+plPSCrDjv0vviHUeK12biWz+vCEE7XNNzsKt
	 HL5CasXRp7EQ8rvuf4VFB3eY6uDXOk/JDg70J5WrL0B785twQxbb6xUQhr1hk/hnwr
	 TIP2Z5KM0rc9H5+z+MhsTr+hRjvTlvkn2LHhFgiN8shk6rKPnUv7HclgiRbeFJR6R+
	 741wYHQh2CQuYrAHtc714IknNMtWY6oR/RlyJmW1xsXtcqFIa5q0QrmaGW9w4OqTRg
	 vB094xXKsnqEg==
Message-ID: <sashiko-outbox-235711@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 12/14] nvme-fabrics: allow to pass in keyring by name
To: "Hannes Reinecke" <hare@kernel.org>, "Keith Busch" <kbusch@kernel.org>, "Jens
 Axboe" <axboe@kernel.dk>, "Christoph Hellwig" <hch@lst.de>, "Sagi Grimberg" <sagi@grimberg.me>, "Hannes
 Reinecke" <hare@suse.de>, "Chaitanya Kulkarni" <kch@nvidia.com>, "Eric
 Biggers" <ebiggers@kernel.org>, "David Howells" <dhowells@redhat.com>, "Jarkko
 Sakkinen" <jarkko@kernel.org>, "Jonathan Corbet" <corbet@lwn.net>, "Shuah
 Khan" <skhan@linuxfoundation.org>, "Randy Dunlap" <rdunlap@infradead.org>, "Kees
 Cook" <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-nvme@lists.infradead.org, keyrings@vger.kernel.org
In-Reply-To: <20261126-dhchap-keyring-v4-v7-12-ee438ffea527@kernel.org>
References: <20261126-dhchap-keyring-v4-v7-0-ee438ffea527@kernel.org>
 <20261126-dhchap-keyring-v4-v7-12-ee438ffea527@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 14:31:56 +0000
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

Thank you for your contribution! Sashiko AI review found 8 potential
issues to consider:
- [High] nvme-fabrics: NULL dereference and key leak in
  nvmf_parse_options()
- [High] nvme-fabrics: missing keyring link and key leak in
  tls_keyring_store()
- [High] nvme-fabrics: vmlinux link failure when CONFIG_NVME_KEYRING=3Dm
- [High] nvme-keyring: broken header stubs when CONFIG_NVME_KEYRING=3Dn
- [Medium] nvme-fabrics: unstripped newline in tls_keyring_store()
  breaks lookup
- [Medium] nvme-fabrics: missing key type and state checks in keyring ID
  fallback
- [Medium] nvme-fabrics: unsynchronized opts->keyring access in
  tls_keyring_store()
- [Low] nvme-fabrics: unreachable !keyring path in
  nvme_tls_attrs_are_visible()
--

commit cea520ca62b4a11b68d9d8f8ca9eeea627f871dd
Author: Hannes Reinecke <hare@kernel.org>

nvme-fabrics: allow to pass in keyring by name

This commit allows specifying the fabrics keyring option by name in
addition to serial number, enables the keyring option for all fabrics
transports, and makes the tls_keyring sysfs attribute writable.

> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
> index bba6a4848f227..12a30ed16f9ef 100644
> --- a/drivers/nvme/host/fabrics.c
> +++ b/drivers/nvme/host/fabrics.c
> @@ -663,8 +663,8 @@ static struct key *nvmf_parse_key(int key_id)
>  {
>  	struct key *key;
> =20
> -	if (!IS_ENABLED(CONFIG_NVME_TCP_TLS)) {
> -		pr_err("TLS is not supported\n");
> +	if (!IS_ENABLED(CONFIG_NVME_KEYRING)) {
> +		pr_err("nvme keyring is not supported\n");
>  		return ERR_PTR(-EINVAL);
>  	}

[Severity: High]
Can this fail to link vmlinux when CONFIG_NVME_KEYRING=3Dm?

IS_ENABLED(CONFIG_NVME_KEYRING) is true when NVME_KEYRING is a module,
while NVME_FABRICS in drivers/nvme/host/Kconfig only selects NVME_KEYRING
if NVME_TCP_TLS is enabled.  If CONFIG_NVME_FABRICS=3Dy (with
CONFIG_NVME_TCP_TLS=3Dn and CONFIG_NVME_HOST_AUTH=3Dn) and
CONFIG_NVME_KEYRING=3Dm (for example via CONFIG_NVME_TARGET=3Dm), built-in
fabrics.o references nvme_tls_key_lookup() and nvme_keyring_link() in
nvme-keyring.ko.  Similarly, when CONFIG_NVME_CORE=3Dy, CONFIG_NVME_TCP=3Dm,
and CONFIG_NVME_TCP_TLS=3Dy, NVME_FABRICS=3Dm selects CONFIG_NVME_KEYRING=
=3Dm,
so built-in drivers/nvme/host/sysfs.o fails to link against
nvme_keyring_name() and nvme_keyring_unlink().

[ ... ]

> @@ -993,14 +995,24 @@ static int nvmf_parse_options(struct nvmf_ctrl_opti=
ons *opts,
>  			opts->tos =3D token;
>  			break;
>  		case NVMF_OPT_KEYRING:
> -			if (match_int(args, &key_id) || key_id <=3D 0) {
> -				ret =3D -EINVAL;
> +#if IS_ENABLED(CONFIG_NVME_KEYRING)
> +			p =3D match_strdup(args);
> +			if (!p) {
> +				ret =3D -ENOMEM;
>  				goto out;
>  			}
> -			key =3D nvmf_parse_key(key_id);
> +			key =3D request_key(&key_type_keyring, p, NULL);
> +			kfree(p);
>  			if (IS_ERR(key)) {
> -				ret =3D PTR_ERR(key);
> -				goto out;
> +				if (match_int(args, &key_id) || key_id <=3D 0) {
> +					ret =3D -EINVAL;
> +					goto out;
> +				}
> +				key =3D nvmf_parse_key(key_id);
> +				if (IS_ERR(key)) {
> +					ret =3D PTR_ERR(key);
> +					goto out;
> +				}
>  			}
>  			ret =3D nvme_keyring_link(opts->keyring);
>  			if (ret) {
> @@ -1008,6 +1020,7 @@ static int nvmf_parse_options(struct nvmf_ctrl_opti=
ons *opts,
>  				goto out;
>  			}
>  			opts->keyring =3D key;
> +#endif
>  			break;

[Severity: High]
Does nvme_keyring_link(opts->keyring) pass NULL instead of the newly
looked-up key?

On the first keyring=3D option, opts->keyring is NULL, so
nvme_keyring_link(NULL) calls key_link(nvme_keyring, NULL) ->
__key_link_lock(), triggering a NULL pointer dereference on
index_key->type with nvme_keyring->sem held write-locked.  If keyring=3D is
specified more than once in the option string, the previous opts->keyring
is also overwritten without being unlinked or released with key_put().

[Severity: High]
Does guarding this block with #if IS_ENABLED(CONFIG_NVME_KEYRING) expose
broken stubs in include/linux/nvme-keyring.h when CONFIG_NVME_KEYRING=3Dn?

include/linux/nvme-keyring.h {
    ...
static const char *nvme_keyring_name(void)
{
	return NULL;
}
static int nvme_keyring_link(struct key *keyring)
{
	return 0;
}
int nvme_keyring_unlink(struct key *keyring)
{
	return 0;
}
    ...
}

When CONFIG_NVME_KEYRING is disabled, nvme_keyring_unlink() is defined as
a non-static function in the header, causing multiple-definition linker
errors across fabrics.o, sysfs.o, and tcp.o, while the non-inline static
nvme_keyring_link() stub becomes unused in fabrics.c and triggers
-Wunused-function.

> diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
> index 4ebc03a8ddcae..0ffea12fcfb6b 100644
> --- a/drivers/nvme/host/sysfs.c
> +++ b/drivers/nvme/host/sysfs.c
> @@ -1212,7 +1212,38 @@ static ssize_t tls_keyring_show(struct device *dev,
>  		return sysfs_emit(buf, "%s\n", nvme_keyring_name());
>  	return sysfs_emit(buf, "%s\n", keyring->description);
>  }
> -static DEVICE_ATTR_RO(tls_keyring);
> +
> +static ssize_t tls_keyring_store(struct device *dev,
> +		struct device_attribute *attr, const char *buf, size_t count)
> +{
> +	struct nvme_ctrl *ctrl =3D dev_get_drvdata(dev);
> +	struct key *keyring =3D ctrl->opts->keyring;
> +	int ret;
> +
> +	keyring =3D request_key(&key_type_keyring, buf, NULL);

[Severity: Medium]
Does passing buf directly to request_key() without stripping a trailing
newline break keyring lookup by name from sysfs?

Writes such as "echo my_keyring > tls_keyring" pass "my_keyring\n" to
request_key(), which fails with -ENOKEY and falls through to kstrtoul(),
returning -EINVAL.  Other sysfs handlers in this file (such as
dhchap_secret_store()) strip the trailing newline with strcspn(buf, "\n").

> +	if (IS_ERR(keyring)) {
> +		unsigned long keyring_id;
> +
> +		ret =3D kstrtoul(buf, 0, &keyring_id);
> +		if (ret < 0)
> +			return -EINVAL;
> +		keyring =3D key_lookup(keyring_id);
> +		if (IS_ERR(keyring))
> +			return -EINVAL;
> +	}

[Severity: Medium]
Can the serial ID fallback in tls_keyring_store() and nvmf_parse_options()
accept a key that is not a keyring?

Neither key_lookup() here nor nvmf_parse_key() in nvmf_parse_options()
verifies that keyring->type =3D=3D &key_type_keyring.  In addition,
tls_keyring_store() does not check that keyring_id fits in a positive
key_serial_t or call key_validate(keyring) to reject revoked, expired, or
invalidated keys.

> +	if (ctrl->opts->keyring) {
> +		ret =3D nvme_keyring_unlink(ctrl->opts->keyring);
> +		if (ret < 0) {
> +			pr_warn("failed to unlink '%08X' from default keyring\n",
> +				key_serial(ctrl->opts->keyring));
> +			key_put(keyring);
> +			return ret;
> +		}
> +	}
> +	ctrl->opts->keyring =3D keyring;
> +	return count;
> +}
> +static DEVICE_ATTR_ADMIN_RW(tls_keyring);

[Severity: High]
Does tls_keyring_store() leak the old ctrl->opts->keyring reference and
leave the new keyring unlinked from the default .nvme keyring?

After nvme_keyring_unlink(ctrl->opts->keyring) removes the link from
nvme_keyring, key_put(ctrl->opts->keyring) is never called before
ctrl->opts->keyring is overwritten.  The new keyring is also never passed
to nvme_keyring_link(keyring), so keys in it cannot be found through
nvme_keyring, any subsequent write to tls_keyring fails in
nvme_keyring_unlink() with -ENOENT, and controller teardown hits
WARN_ON(ret) in nvmf_free_options().

[Severity: Medium]
What serializes tls_keyring_store() against concurrent calls to
tls_keyring_store(), tls_keyring_show(), or nvme_tcp_start_tls()?

CPU0                              CPU1
tls_keyring_store()               tls_keyring_show()
                                    keyring =3D ctrl->opts->keyring
  nvme_keyring_unlink(
    ctrl->opts->keyring)
  /* once key_put() is added: */
  key_put(ctrl->opts->keyring)
                                    sysfs_emit(...,
                                      keyring->description)
                                      <-- use-after-free

Two concurrent writers can also unlink and replace ctrl->opts->keyring at
the same time, while tls_keyring_show() and nvme_tcp_start_tls() read
ctrl->opts->keyring without holding a lock or taking a key reference.

[Severity: Low]
Is tls_keyring visible in sysfs when a controller is created without an
initial keyring=3D option?

drivers/nvme/host/sysfs.c:nvme_tls_attrs_are_visible() {
    ...
	if (a =3D=3D &dev_attr_tls_keyring.attr &&
	    !ctrl->opts->keyring)
		return 0;
    ...
}

Because nvme_tls_attrs_are_visible() hides tls_keyring whenever
ctrl->opts->keyring is NULL, the !keyring fallback in tls_keyring_show()
cannot be reached and a keyring cannot be configured via
tls_keyring_store() unless one was already passed at connect time.  Also,
making tls_keyring writable and changing it from DEVICE_ATTR_RO (0444) to
DEVICE_ATTR_ADMIN_RW (0600) is not mentioned in the commit message or
Documentation/ABI/stable/sysfs-nvme.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126-dhchap-key=
ring-v4-v7-0-ee438ffea527@kernel.org?part=3D12

