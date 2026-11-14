Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C70606A32D
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Nov 2026 19:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=iXDDMzVk;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Um0sp+1B
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=owkaXQA+1bA6W9xlnCroIoER/eVY8xHYzFtVFS5POF0=; b=iXDDMzVkCjYYRoMyUciVPfFafJ
	WD/vQ8C7D958Vq28U9e0NlGlMA7yh5KRHQN86Bn2kQEoPHcYPY1wjQdEYx/XO5GBEaPI0LgDqVbn8
	BNApJqX8s2E3ZwD8Hth+m7w/56R9P0OUSaXPYsS2g/2zHh3tXw70EE2Ra/RCwN8yUrFcFZnseL9S5
	n3gE35z63rm6eR2B1F5a7aOmQFF3U6hWT/QSOhf88LaSHITNx6283zsQN3zlzhOHi5WxotcJphliY
	ZZspPyk3IK/mCh0xokW0yqXToxVRrk6s/NeLiUjReBbLj1hTIF5n4ZlShpV1eyEUYF+e7tphhwZRE
	zD7dYU+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSJL0-0000000GfPq-21ad;
	Sat, 14 Nov 2026 19:22:58 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSJKz-0000000GfPe-3DSq
	for linux-nvme@lists.infradead.org;
	Sat, 14 Nov 2026 19:22:57 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 83E0C40213
	for <linux-nvme@lists.infradead.org>; Sat, 14 Nov 2026 19:22:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 296EE1F000C4;
	Sat, 14 Nov 2026 19:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794684177;
	bh=owkaXQA+1bA6W9xlnCroIoER/eVY8xHYzFtVFS5POF0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Um0sp+1BUR6Z+f1OKkH11e+pIXhtMm5e//jJJQKke4uSG6eb/hoM2Vx+6KDpiK4qM
	 XG53ekVp3WDFQP1RiL8nGmBxKHl5BsgzZfqkBwZENk66SeuGBx0hI4GSSOh1LBrxqU
	 xmBx3kfzVRm0iABd4qtx/BZ/8HB2b6cfM6umjXtFXG7pCvJ2zY9GReRrPJVAqBGKsx
	 4qOBv2B0LAhfRcZi6adjejPiByMaVcqJnl8qunrHIOlP435UrSzObPNZ5V/5l0HbFE
	 phKJl+FxwAJxZrV62qSPLBfaOGyuizT05JbYJhHcK6OkTGufSE1sQYUyrGvl6GjykE
	 UI/HvE8tuuVOQ==
Message-ID: <sashiko-outbox-214966@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v3 10/10] NFSD: Add allow_tags to the netlink
 export interface
To: "Chuck Lever" <cel@kernel.org>
Cc: linux-nvme@lists.infradead.org, "Jeff Layton" <jlayton@kernel.org>, "Anna
 Schumaker" <anna@kernel.org>
In-Reply-To: <20261113-tls-session-tags-v3-10-91271964cdb0@kernel.org>
References: <20261113-tls-session-tags-v3-0-91271964cdb0@kernel.org>
 <20261113-tls-session-tags-v3-10-91271964cdb0@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 19:22:56 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] nfsd: NLA_STRING policy in fs/nfsd/netlink.c disagrees with
  nfsd.yaml
--

commit 9462d94731ddc9a3ecf082d3129a435c7feed8da
Author: Chuck Lever <cel@kernel.org>

NFSD: Add allow_tags to the netlink export interface

This commit adds the allow-tags attribute to the NFSD svc-export netlink
interface, parses and validates session tags in nfsd_nl_parse_one_export(),
and reports validation errors through the netlink extended ACK.

> diff --git a/Documentation/netlink/specs/nfsd.yaml b/Documentation/netlin=
k/specs/nfsd.yaml
> index 9ae37bf3ea717..e58856b34b020 100644
> --- a/Documentation/netlink/specs/nfsd.yaml
> +++ b/Documentation/netlink/specs/nfsd.yaml

[ ... ]

> @@ -297,6 +301,12 @@ attribute-sets:
>        -
>          name: fsid
>          type: s32
> +      -
> +        name: allow-tags
> +        type: string
> +        checks:
> +          max-len: handshake-session-tag-max-len
> +        multi-attr: true

[ ... ]

> diff --git a/fs/nfsd/netlink.c b/fs/nfsd/netlink.c
> index 88a4a4ffcb7fd..146c655757410 100644
> --- a/fs/nfsd/netlink.c
> +++ b/fs/nfsd/netlink.c

[ ... ]

> @@ -55,6 +56,7 @@ const struct nla_policy nfsd_svc_export_nl_policy[NFSD_=
A_SVC_EXPORT_FSID + 1] =3D
>  	[NFSD_A_SVC_EXPORT_XPRTSEC] =3D NLA_POLICY_MASK(NLA_U32, 0x7),
>  	[NFSD_A_SVC_EXPORT_FLAGS] =3D NLA_POLICY_MASK(NLA_U32, 0x3ffff),
>  	[NFSD_A_SVC_EXPORT_FSID] =3D { .type =3D NLA_S32, },
> +	[NFSD_A_SVC_EXPORT_ALLOW_TAGS] =3D { .type =3D NLA_STRING, .len =3D HAN=
DSHAKE_SESSION_TAG_MAX_LEN, },
>  };

[Severity: Medium]
Should nfsd_svc_export_nl_policy[NFSD_A_SVC_EXPORT_ALLOW_TAGS] match the
NLA_NUL_STRING policy generated from Documentation/netlink/specs/nfsd.yaml?

fs/nfsd/netlink.c is generated by tools/net/ynl/ynl-regen.sh, which emits
NLA_NUL_STRING for string attributes without unterminated-ok:

tools/net/ynl/pyynl/ynl_gen_c.py:TypeString.attr_policy()
    if self.checks.get('unterminated-ok', False):
        policy =3D 'NLA_STRING'
    else:
        policy =3D 'NLA_NUL_STRING'

Because fs/nfsd/netlink.c was edited to use NLA_STRING here, running
ynl-regen.sh will overwrite it with NLA_NUL_STRING and silently change the
kernel uAPI validation policy to reject non-NUL-terminated tag payloads.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-tls-sessio=
n-tags-v3-0-91271964cdb0@kernel.org?part=3D10

