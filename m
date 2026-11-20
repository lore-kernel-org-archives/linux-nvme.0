Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2DD606A320
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Nov 2026 11:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=yqn9CkSi;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M+8kGMzV
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=UGj3PPD+Z9lpF9gtIZydxwASpggXvv6p6FHEGQ0lH2w=; b=yqn9CkSiG/W9zPgqh8Fq62gOR5
	tiQzXqQ4InSS65bwUYRJFmqaw3hIooQZQ8wZYmuMJf78kpCEnSNkuDG4NaRggcjyf2LXG90o+aJLY
	PzkZ9ChhQh9tfZSBCXWilEkgaKDEsCRScCk8OWXqtVNaTTPp2Ri0JU8jptzbH6sSaiCbfWeksdqbZ
	nyFN73rZ1yyx6jWEx7ZqUJkXlgr56qZi5Bhhm1P0t1/cPWRvy4oHKx8eSIWKIpNRe/W0Q3kha1v42
	iVQV/jVdgXI3HYftSkPBbTppdecf+yOHNTX0WIr4dP4boyCSslbDX2N6zR6NyqpwlaMXY5RZBJ3M6
	bhT8aRPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUMwB-0000000EpEn-2hqW;
	Fri, 20 Nov 2026 11:37:51 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUMwA-0000000EpEc-07HR
	for linux-nvme@lists.infradead.org;
	Fri, 20 Nov 2026 11:37:50 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 76CFA44E09
	for <linux-nvme@lists.infradead.org>; Fri, 20 Nov 2026 11:37:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CE0E1F000CA;
	Fri, 20 Nov 2026 11:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795174669;
	bh=UGj3PPD+Z9lpF9gtIZydxwASpggXvv6p6FHEGQ0lH2w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=M+8kGMzVXtJh32IqrqDKdVXOisauqFtMBsT09EBmt6oC1Va8U0p1lrDhe5LLVerWN
	 xNB5NSXV7q1pQzKwa13WrmA1qD5NstpPUtJgcsgTT/qdiNOe2hMNerWbvU4bA9ECRb
	 JkLyJo41citgST9NtZo+MLN8KRmrjTzgavOSVx0d6a+/dako7ZfAwAX56JcjZ/niDI
	 jv4XQjmZNd7q9Sejuzi15zVaniOYSghjnTL2CKZZrfKgoYaEFtJJcmGtnr4JVFHLtW
	 P9YzV1q3/FDf5TOiB204FFmfcYN8Y6njibNThRUa7brIIZeJqoTdm/nx3Obj+HXmok
	 5U8bd7HB3r/QA==
Message-ID: <sashiko-outbox-225080@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 8/9] nvme-fabrics: allow to pass in keyring by name
To: "Hannes Reinecke" <hare@kernel.org>
Cc: linux-nvme@lists.infradead.org
In-Reply-To: <20261120-dhchap-keyring-v4-v4-8-5f8c7d9926ee@kernel.org>
References: <20261120-dhchap-keyring-v4-v4-0-5f8c7d9926ee@kernel.org>
 <20261120-dhchap-keyring-v4-v4-8-5f8c7d9926ee@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 11:37:48 +0000
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
- [High] nvme-fabrics: opt_tokens keyring=3D%d pattern rejects keyring
  names
- [Medium] nvme-fabrics: build failure in nvmf_parse_options() when
  !CONFIG_KEYS
--

commit 0ba36c8d6abaed9ca222b0bbab73723c1ce8243d
Author: Hannes Reinecke <hare@kernel.org>

nvme-fabrics: allow to pass in keyring by name

This commit updates nvmf_parse_options() so the NVMF_OPT_KEYRING option
falls back to looking up a keyring by description via request_key() when the
argument is not a positive integer serial number.

> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
> index cd728768a68fc..71da67b543aa4 100644
> --- a/drivers/nvme/host/fabrics.c
> +++ b/drivers/nvme/host/fabrics.c

[ ... ]

> @@ -993,13 +994,23 @@ static int nvmf_parse_options(struct nvmf_ctrl_opti=
ons *opts,
>  			break;
>  		case NVMF_OPT_KEYRING:
>  			if (match_int(args, &key_id) || key_id <=3D 0) {
> -				ret =3D -EINVAL;
> -				goto out;
> -			}
> -			key =3D nvmf_parse_key(key_id);
> -			if (IS_ERR(key)) {
> -				ret =3D PTR_ERR(key);
> -				goto out;
> +				p =3D match_strdup(args);

[Severity: High]
Can a keyring name ever reach this branch while opt_tokens still defines
NVMF_OPT_KEYRING as "keyring=3D%d"?

drivers/nvme/host/fabrics.c:opt_tokens {
    ...
	{ NVMF_OPT_KEYRING,		"keyring=3D%d"		},
    ...
}

Because match_token() requires "%d" arguments to be valid integers, any
non-numeric name such as "keyring=3D.nvme" fails to match and makes
nvmf_parse_options() reject the option with -EINVAL in the default switch
case.  In addition, reading /dev/nvme-fabrics still advertises "keyring=3D%=
d"
to userspace, while passing a non-positive integer serial number such as
"keyring=3D0" or "keyring=3D-1" enters this fallback and looks up the numbe=
r as
a keyring description instead of returning -EINVAL.

> +				if (!p) {
> +					ret =3D -ENOMEM;
> +					goto out;
> +				}
> +				key =3D request_key(&key_type_keyring, p, NULL);

[Severity: Medium]
Does this break the build when CONFIG_NVME_FABRICS is enabled and
CONFIG_KEYS is disabled?

CONFIG_NVME_FABRICS only selects CONFIG_NVME_KEYRING (which selects
CONFIG_KEYS) when CONFIG_NVME_TCP_TLS or CONFIG_NVME_HOST_AUTH is enabled.
Both key_type_keyring in include/linux/key-type.h and request_key() in
include/linux/key.h are declared under #ifdef CONFIG_KEYS with no stub for
!CONFIG_KEYS builds.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120-dhchap-key=
ring-v4-v4-0-5f8c7d9926ee@kernel.org?part=3D8

