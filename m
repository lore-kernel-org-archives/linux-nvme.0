Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705C7606A32A
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Nov 2026 17:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=QZAQyDbE;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RsyAsk64
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=/ZRgBoCF3g9qp3iAc6NqnvnrdN1Y49kMWzX0i/UIulc=; b=QZAQyDbE9zxMpz4Wfp/3GENJTO
	JtLYmi6F2VSYaVVYAQYuuSEM0zKHlHZ/xO7wfspT0vy+B+R+BEtYEtWDDGkghLY2+cfK7XAHg7Ate
	ESFg4iG3KF4CawSt6nohzbGz4uGSgq7LEYzmoLyDcoVZQHwEbX2IVFfs0EVa/p6n52f0PrfNxdiYS
	k5VULcxi2djc29DNcKP4n162e+BZ9CK70UAnx7hoGWvxf/3eV/bcvgzcTE6AdLQN0Cncghn4Egt7p
	JuYV1aa/NjVKK4EVoH77szeL8n9AyouGJCLm0osMRn9DAXFooJMlFuhPua6TZvSJsgmT5AaEt7zDv
	8YFhIWFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVXsM-00000004MhG-0T7t;
	Mon, 23 Nov 2026 17:30:46 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVXsK-00000004MhA-2d4z
	for linux-nvme@lists.infradead.org;
	Mon, 23 Nov 2026 17:30:44 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 644EB44134
	for <linux-nvme@lists.infradead.org>; Mon, 23 Nov 2026 17:30:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A8761F000C0;
	Mon, 23 Nov 2026 17:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795455044;
	bh=/ZRgBoCF3g9qp3iAc6NqnvnrdN1Y49kMWzX0i/UIulc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RsyAsk64TsZ+Xcjq5PtkdoukIl7fgMiRL71mW6Z+UKh8m+gG2AUGdXKF0J+JEK3ib
	 6XvcRaYhatQ++AgBuGbsF32hVsU5u0qQwEbILr17ZD8da8mZ9jyIZVdRb+YTo+e3Pa
	 bB/nwQyJvU13IBFQRtXZ2GVONXYzvfE7OBUZeuQ+ZnEh5gsocJH3RfaahWnRnBhEv4
	 UWs1mXsOAJsimeQ2jNGRrtA7z/QsWFtS9fAJzRCtqgfVshEchBQouIWwmz/R0AV7Qx
	 4iUK8BzMUcQOJpuQOOJ66YUF+CqwcHzFiu/sxbWU/gJG3qMSEEbB+KMIc5N7P9etFe
	 b8d9PlTYM1pAA==
Message-ID: <sashiko-outbox-229752@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 8/9] nvme-fabrics: allow to pass in keyring by name
To: "Hannes Reinecke" <hare@kernel.org>
Cc: linux-nvme@lists.infradead.org
In-Reply-To: <20261123-dhchap-keyring-v4-v6-8-5082a49715ab@kernel.org>
References: <20261123-dhchap-keyring-v4-v6-0-5082a49715ab@kernel.org>
 <20261123-dhchap-keyring-v4-v6-8-5082a49715ab@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 17:30:43 +0000
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
- [Medium] nvme-fabrics: keyring=3D<id> fails in nvmf_parse_key() when TLS
  is disabled
- [Medium] nvme-fabrics: match_int() in nvmf_parse_options() misparses
  keyring names
--

commit 1438f3b90feece0503d30638e100925a9591818f
Author: Hannes Reinecke <hare@kernel.org>

nvme-fabrics: allow to pass in keyring by name

This commit updates the fabrics keyring=3D option to accept keyring names v=
ia
request_key() in addition to numeric key serial IDs, and guards the option
with CONFIG_NVME_KEYRING instead of CONFIG_NVME_TCP_TLS.

> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
> index 2937e5dc9ecd2..aae094bbbf0dd 100644
> --- a/drivers/nvme/host/fabrics.c
> +++ b/drivers/nvme/host/fabrics.c
> @@ -14,6 +14,7 @@
>  #include "fabrics.h"
>  #include <linux/nvme-auth.h>
>  #include <linux/nvme-keyring.h>
> +#include <linux/key-type.h>
> =20
>  static DECLARE_RWSEM(nvmf_transports_rwsem);
>  static LIST_HEAD_GUARDED(nvmf_transports, nvmf_transports_rwsem);
> @@ -696,8 +697,10 @@ static const match_table_t opt_tokens =3D {
>  	{ NVMF_OPT_NR_WRITE_QUEUES,	"nr_write_queues=3D%d"	},
>  	{ NVMF_OPT_NR_POLL_QUEUES,	"nr_poll_queues=3D%d"	},
>  	{ NVMF_OPT_TOS,			"tos=3D%d"		},
> +#if IS_ENABLED(CONFIG_NVME_KEYRING)
> +	{ NVMF_OPT_KEYRING,		"keyring=3D%s"		},
> +#endif
>  #ifdef CONFIG_NVME_TCP_TLS
> -	{ NVMF_OPT_KEYRING,		"keyring=3D%d"		},
>  	{ NVMF_OPT_TLS_KEY,		"tls_key=3D%d"		},
>  #endif
>  	{ NVMF_OPT_FAIL_FAST_TMO,	"fast_io_fail_tmo=3D%d"	},
> @@ -992,17 +995,29 @@ static int nvmf_parse_options(struct nvmf_ctrl_opti=
ons *opts,
>  			opts->tos =3D token;
>  			break;
>  		case NVMF_OPT_KEYRING:
> +#if IS_ENABLED(CONFIG_NVME_KEYRING)
>  			if (match_int(args, &key_id) || key_id <=3D 0) {

[Severity: Medium]
Can match_int() misparse a keyring name that starts with digits as a
numeric serial ID?

Because opt_tokens now matches keyring=3D%s, args[0] holds the full string.
match_int() calls match_number(), which uses simple_strtol() and only
checks endp =3D=3D buf without verifying that the entire string was consume=
d:

lib/parser.c:match_number() {
    ...
	val =3D simple_strtol(buf, &endp, base);
	if (endp =3D=3D buf)
		ret =3D -EINVAL;
    ...
}

Any keyring name shorter than 24 bytes beginning with a positive integer
prefix (such as "1nvme") returns 0 from match_int() with key_id > 0,
routing the truncated prefix to nvmf_parse_key() instead of looking up the
keyring by name with request_key().

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

[Severity: Medium]
Does passing a keyring by serial number fail when CONFIG_NVME_HOST_AUTH is
enabled but CONFIG_NVME_TCP_TLS is disabled?

NVMF_OPT_KEYRING is now guarded by CONFIG_NVME_KEYRING (which is also
selected by CONFIG_NVME_AUTH), and keyring=3D<name> succeeds via
request_key().  However, the numeric path calls nvmf_parse_key(), which
still requires CONFIG_NVME_TCP_TLS:

drivers/nvme/host/fabrics.c:nvmf_parse_key() {
	struct key *key;

	if (!IS_ENABLED(CONFIG_NVME_TCP_TLS)) {
		pr_err("TLS is not supported\n");
		return ERR_PTR(-EINVAL);
	}
    ...
}

In addition, NVMF_ALLOWED_OPTS includes NVMF_OPT_DHCHAP_SECRET and
NVMF_OPT_DHCHAP_CTRL_SECRET for all transports, which use opts->keyring in
nvmf_parse_options(), but NVMF_OPT_KEYRING is still only set in
nvme_tcp_transport.allowed_opts and omitted from NVMF_ALLOWED_OPTS.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123-dhchap-key=
ring-v4-v6-0-5082a49715ab@kernel.org?part=3D8

