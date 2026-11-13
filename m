Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6931A606A881
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Nov 2026 14:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=49lhTIDn;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SaEjO6CJ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=ZokK4mq9IPdBFujfmzvMd5Wl2MuH4RtfCC3ycLKUFd4=; b=49lhTIDn1PpBL4KhgvdBSQY8WZ
	oxDS4KccnMvUD95ouDHwN+mrlapkynrasrRm80Ku+Qdf9Ka+OoMPNKDbJT3mckYWPIiAmpXiU9rw7
	TjPhR1D6vC3xnXHwOYqhD+On3fAnmeTSxlDwSQnVJMfWezG4hMytni2ka/Q4YN4VG0ACacuB1/YEI
	YJ0oRdnflkm3QWEGkRPBdG2iH8IrPSs/5HHadaU0muQapBdlsVHEsmCFDdGY/72jsIDV+n3Z3OLmR
	Qouy61WLYxPMXR9mxKC98haS356XvQ3MG0FInMip93DWqhAsf/Qjls5gWgRp1G3UvOfMTEW1WM6UM
	tDJDToyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRse2-0000000DFMJ-3Eyd;
	Fri, 13 Nov 2026 14:52:50 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRsdy-0000000DFIc-0CUn
	for linux-nvme@lists.infradead.org;
	Fri, 13 Nov 2026 14:52:46 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 69F0B62776
	for <linux-nvme@lists.infradead.org>; Fri, 13 Nov 2026 14:52:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA24B1F000C4;
	Fri, 13 Nov 2026 14:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794581565;
	bh=ZokK4mq9IPdBFujfmzvMd5Wl2MuH4RtfCC3ycLKUFd4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SaEjO6CJhbw+CDD/RHpfhU0faF2OVP8jXH0OFqoq5KXTVgRU2BETDf5aXAY3F/6Ng
	 5Miw3totlxPTEOjTe9cWgTXOlkAG9exdj2wfk9ZZ0ohpmRMIPNiHg1JP/rBXiP+Kno
	 6zk/4NERAO/S3JOix8BnyQAUzJqLnPw+ulKKOXM4xIgDBUKgCy1svLStzqktgWz3EO
	 E++FlOzPJLgQRWeu/MrTypeY8adVS48ZMxYpQ+JcRJ0VmMvL06HRHJStEdnxEiacGV
	 A4q7qIw5oVlQFDZaLf91/jMim27YDOCzne39+MRxYQVWQiZDVNsKgWUdhv4xvg1lnQ
	 3Zcd2aGJAJkgQ==
Message-ID: <sashiko-outbox-213027@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v2 10/10] NFSD: Add allow_tags to the netlink
 export interface
To: "Chuck Lever" <cel@kernel.org>
Cc: linux-nvme@lists.infradead.org, "Jeff Layton" <jlayton@kernel.org>, "Anna
 Schumaker" <anna@kernel.org>
In-Reply-To: <20261112-tls-session-tags-v2-10-a587a50de7fc@kernel.org>
References: <20261112-tls-session-tags-v2-0-a587a50de7fc@kernel.org>
 <20261112-tls-session-tags-v2-10-a587a50de7fc@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 14:52:44 +0000
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

commit 1059c4281c80865b99ac7732d9133036256073b9
Author: Chuck Lever <cel@kernel.org>

NFSD: Add allow_tags to the netlink export interface

This commit adds the allow-tags attribute to the NFSD netlink svc-export
attribute set and parses it in nfsd_nl_parse_one_export() to enforce mTLS
session tag policies.

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
>    -
>      name: svc-export-reqs
>      attributes:

[ ... ]

> diff --git a/fs/nfsd/netlink.c b/fs/nfsd/netlink.c
> index 88a4a4ffcb7fd..146c655757410 100644
> --- a/fs/nfsd/netlink.c
> +++ b/fs/nfsd/netlink.c

[ ... ]

> @@ -41,7 +42,7 @@ const struct nla_policy nfsd_sock_nl_policy[NFSD_A_SOCK=
_TRANSPORT_NAME + 1] =3D {
>  	[NFSD_A_SOCK_TRANSPORT_NAME] =3D { .type =3D NLA_NUL_STRING, },
>  };
> =20
> -const struct nla_policy nfsd_svc_export_nl_policy[NFSD_A_SVC_EXPORT_FSID=
 + 1] =3D {
> +const struct nla_policy nfsd_svc_export_nl_policy[NFSD_A_SVC_EXPORT_ALLO=
W_TAGS + 1] =3D {
>  	[NFSD_A_SVC_EXPORT_SEQNO] =3D { .type =3D NLA_U64, },
>  	[NFSD_A_SVC_EXPORT_CLIENT] =3D { .type =3D NLA_NUL_STRING, },
>  	[NFSD_A_SVC_EXPORT_PATH] =3D { .type =3D NLA_NUL_STRING, },
> @@ -55,6 +56,7 @@ const struct nla_policy nfsd_svc_export_nl_policy[NFSD_=
A_SVC_EXPORT_FSID + 1] =3D
>  	[NFSD_A_SVC_EXPORT_XPRTSEC] =3D NLA_POLICY_MASK(NLA_U32, 0x7),
>  	[NFSD_A_SVC_EXPORT_FLAGS] =3D NLA_POLICY_MASK(NLA_U32, 0x3ffff),
>  	[NFSD_A_SVC_EXPORT_FSID] =3D { .type =3D NLA_S32, },
> +	[NFSD_A_SVC_EXPORT_ALLOW_TAGS] =3D { .type =3D NLA_STRING, .len =3D HAN=
DSHAKE_SESSION_TAG_MAX_LEN, },
>  };

[Severity: Medium]
Was fs/nfsd/netlink.c edited by hand to use NLA_STRING for
NFSD_A_SVC_EXPORT_ALLOW_TAGS?

fs/nfsd/netlink.c is generated from Documentation/netlink/specs/nfsd.yaml,
where allow-tags is a genetlink string attribute without unterminated-ok.
Running tools/net/ynl/ynl-regen.sh will overwrite this entry with
.type =3D NLA_NUL_STRING, changing the kernel attribute validation policy on
the next regeneration.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112-tls-sessio=
n-tags-v2-0-a587a50de7fc@kernel.org?part=3D10

