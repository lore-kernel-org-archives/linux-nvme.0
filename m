Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E61606A31A
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Nov 2026 12:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=d7cCfgrF;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fuYAXwGG
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=CoYSYbO27LI3WdpYaAvI6TfdamxmjHmK2U/1Kq06Aww=; b=d7cCfgrFi4MojBITvIwfD3G5LP
	muXPAj5muPzuF4tCaeo5w/Q0XRHKPp08WIYT5I8FjDXZIGv+jxwlb8hwIboSJMIb/5CajhWYrBucF
	zgPtztYmc0iI7zT1reiFRF94MsMqG0r0WeKOvG6fD6swj96hmB1LcljVzzsDYZ/mK+xtuarqzBSgW
	tqsWbVL1r4fVoZW22FevLxv2akXZtauzSM9i348AojAAEGjIfaRqZl83vRU12Ou0t0A1yiZxsd+wk
	bp4py+D6Bg2CmGGMwIMZwRsQTCKg3LCFv7NjWXe5f0uLoeX3hD/5i5HLSHtxhOjIOK1c7UlEPQVvP
	BBpP+YXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVTAz-00000003MWW-2sVH;
	Mon, 23 Nov 2026 12:29:41 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVTAu-00000003MVw-2upC
	for linux-nvme@lists.infradead.org;
	Mon, 23 Nov 2026 12:29:40 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 4472A41882
	for <linux-nvme@lists.infradead.org>; Mon, 23 Nov 2026 12:29:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B899D1F000C0;
	Mon, 23 Nov 2026 12:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795436975;
	bh=CoYSYbO27LI3WdpYaAvI6TfdamxmjHmK2U/1Kq06Aww=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fuYAXwGG77L90zui9IZFeAKygVOX4P4DFEf+5ZXiC6sR++kEPtty+ZGyqIuez1E7u
	 eoTvOzRvvus0EILA8nt/sbNBgkG4FsXaNo3GiDObPgxjuRl2foL3CDC0wJSAxGHcsh
	 G2VqX4EjwT9xEsVeGAusc5/fFkpaon6EN9247Vu1GzOEukQDyr9vBhBzHylTClLwhU
	 zCe0hSmdh7q9F96VXezAhJmeTknBr2UJM3urGRX2952I0TeMiR+kzBkULidLDkRhrW
	 zHzE+kDYC9cmfGlFGPHiCOGohClUn2BEeJywz6E8qrsOh26BNTj3owagEwzKXpafPn
	 uUJ8/UgpsGgsQ==
Message-ID: <sashiko-outbox-229220@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 8/9] nvme-fabrics: allow to pass in keyring by name
To: "Hannes Reinecke" <hare@kernel.org>
Cc: linux-nvme@lists.infradead.org
In-Reply-To: <20261123-dhchap-keyring-v4-v5-8-81eefb4c0724@kernel.org>
References: <20261123-dhchap-keyring-v4-v5-0-81eefb4c0724@kernel.org>
 <20261123-dhchap-keyring-v4-v5-8-81eefb4c0724@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 12:29:35 +0000
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
- [High] nvme-fabrics: keyring=3D fails in nvmf_parse_options() for
  CONFIG_NVME_KEYRING=3Dm
- [Medium] nvme-fabrics: match_int() in nvmf_parse_options() misparses
  keyring names
--

commit 357df670b0cbbd8ea5cc07d96b4413e6b84ca631
Author: Hannes Reinecke <hare@kernel.org>

nvme-fabrics: allow to pass in keyring by name

This commit updates the NVMe-oF option parser to accept a keyring name
in addition to a numeric key serial ID for the keyring=3D option.

> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
> index 1277749c6e2e3..5dc1e1d5fb462 100644
> --- a/drivers/nvme/host/fabrics.c
> +++ b/drivers/nvme/host/fabrics.c

[ ... ]

> @@ -697,7 +698,7 @@ static const match_table_t opt_tokens =3D {
>  	{ NVMF_OPT_NR_POLL_QUEUES,	"nr_poll_queues=3D%d"	},
>  	{ NVMF_OPT_TOS,			"tos=3D%d"		},
>  #ifdef CONFIG_NVME_TCP_TLS
> -	{ NVMF_OPT_KEYRING,		"keyring=3D%d"		},
> +	{ NVMF_OPT_KEYRING,		"keyring=3D%s"		},
>  	{ NVMF_OPT_TLS_KEY,		"tls_key=3D%d"		},
>  #endif
>  	{ NVMF_OPT_FAIL_FAST_TMO,	"fast_io_fail_tmo=3D%d"	},
> @@ -992,17 +993,33 @@ static int nvmf_parse_options(struct nvmf_ctrl_opti=
ons *opts,
>  			opts->tos =3D token;
>  			break;
>  		case NVMF_OPT_KEYRING:
> +#ifdef CONFIG_NVME_KEYRING
>  			if (match_int(args, &key_id) || key_id <=3D 0) {

[Severity: Medium]
Can match_int() misparse a keyring name that starts with a positive
number (such as "1nvme") as a numeric key serial ID?

Because opt_tokens now matches keyring=3D%s instead of %d, args[0] spans
the entire string without requiring all characters to be digits.
match_int() -> match_number() calls simple_strtol(buf, &endp, 0) and
only checks endp =3D=3D buf, ignoring trailing non-numeric characters on
strings under 24 bytes.  A keyring name with a leading positive integer
will therefore take the else branch and pass that prefix to
nvmf_parse_key(key_id) instead of looking up the keyring by name via
request_key().

> -				ret =3D -EINVAL;
> -				goto out;
> -			}
> -			key =3D nvmf_parse_key(key_id);
> -			if (IS_ERR(key)) {
> -				ret =3D PTR_ERR(key);
> -				goto out;
> +				p =3D match_strdup(args);
> +				if (!p) {
> +					ret =3D -ENOMEM;
> +					goto out;
> +				}
> +				key =3D request_key(&key_type_keyring, p, NULL);
> +				kfree(p);
> +				if (IS_ERR(key)) {
> +					ret =3D PTR_ERR(key);
> +					goto out;
> +				}
> +			} else {
> +				key =3D nvmf_parse_key(key_id);
> +				if (IS_ERR(key)) {
> +					ret =3D PTR_ERR(key);
> +					goto out;
> +				}
>  			}
>  			key_put(opts->keyring);
>  			opts->keyring =3D key;
> +#else
> +			pr_warn("nvme keyring is disabled\n");
> +			ret =3D -EINVAL;
> +			goto out;
> +#endif

[Severity: High]
Does #ifdef CONFIG_NVME_KEYRING reject all keyring=3D options with
-EINVAL when CONFIG_NVME_KEYRING=3Dm?

NVME_KEYRING is a tristate Kconfig symbol, so modular builds define
CONFIG_NVME_KEYRING_MODULE rather than CONFIG_NVME_KEYRING, causing
nvmf_parse_options() to compile the #else branch and fail controller
creation.  Should this use #if IS_ENABLED(CONFIG_NVME_KEYRING) (like
include/linux/nvme-keyring.h)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123-dhchap-key=
ring-v4-v5-0-81eefb4c0724@kernel.org?part=3D8

