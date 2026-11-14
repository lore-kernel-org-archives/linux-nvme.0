Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C32A606A329
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Nov 2026 19:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=WE7reDMC;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pj58enBs
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=ylY9hzcMk9grM+GGR7t3hX9m0bUP7CU8ra59CyFa8bY=; b=WE7reDMCPTg9k3H1fpH84Q5lTC
	etuUy2hBem5aLzBzCDBoWT5L9+o5SG9Pq91UPSwE/VF529BzdaSoUWiXKd2L4kX40glgoNg8RH/LQ
	N3U0DOWVjHf1VHZkV4dt8Gn4KvRftwUaYejyi4IEXGBIdF7t99z6gzcLqi/WiFxEW2mBUjfKC2xcj
	RFbZuL73UquOyYVfFqcZipvQyqviQWUZOJ38v6BcCDKjELzsEeM1x56TGsufjbAUb8SB2soswwIFA
	xd7rLfchRe9bw9MDsvbl+7UihykutdGoP64yAnECYGuBXiDL0PnoRmjcaNOp3wZW16r5o4OuuWWGP
	moM7T8gw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSJL0-0000000GfPk-1cmv;
	Sat, 14 Nov 2026 19:22:58 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSJKz-0000000GfPY-1WOM
	for linux-nvme@lists.infradead.org;
	Sat, 14 Nov 2026 19:22:57 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id C085740213
	for <linux-nvme@lists.infradead.org>; Sat, 14 Nov 2026 19:22:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39ADC1F000C4;
	Sat, 14 Nov 2026 19:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794684176;
	bh=ylY9hzcMk9grM+GGR7t3hX9m0bUP7CU8ra59CyFa8bY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Pj58enBsIlNNkiW2KE1TrUumegP311PHm3Z00rQJPEzrYD+fQggI8Hw5bW7BT39PJ
	 f5BsTGyMrCL/AOLI8OfYrke8JDg+1klLXsebAP0859KaOF5DEF2sTqH6bx++Sj0f2Q
	 qF/9yLdQP5WDOBVqgslPVPBas6Gb7Eut/Ap1b84SPOjDNUjLwJeWMUFRiUCYVh4+Zk
	 0lVJCWfxrIzCJzOPitQLtazi3VqSokyprjixGAmu7QrV8Kc1+PVsvNaYH8HCIWCom1
	 tfhANqsVEVLArjnh0lWsUZBjgDPsUguhzzaIagROqIDVTvw+MUaxFac7oJOZTeqXyA
	 rlfFTrXez+jHA==
Message-ID: <sashiko-outbox-214957@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v3 01/10] handshake: Add tags to "done"
 downcall
To: "Chuck Lever" <cel@kernel.org>
Cc: linux-nvme@lists.infradead.org, "Jeff Layton" <jlayton@kernel.org>, "Anna
 Schumaker" <anna@kernel.org>
In-Reply-To: <20261113-tls-session-tags-v3-1-91271964cdb0@kernel.org>
References: <20261113-tls-session-tags-v3-0-91271964cdb0@kernel.org>
 <20261113-tls-session-tags-v3-1-91271964cdb0@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 19:22:48 +0000
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
- [Medium] handshake: HANDSHAKE_A_DONE_TAG uses NLA_STRING instead of
  NLA_NUL_STRING
--

commit 686d8603f3072dc2bd0a821dcea3a0351fd8b262
Author: Chuck Lever <cel@kernel.org>

handshake: Add tags to "done" downcall

This commit adds the HANDSHAKE_A_DONE_TAG netlink attribute to the
handshake "done" downcall so userspace agents can return session tags to
the kernel.

> diff --git a/Documentation/netlink/specs/handshake.yaml b/Documentation/n=
etlink/specs/handshake.yaml
> index 0498ada2dd97a..17521b159e893 100644
> --- a/Documentation/netlink/specs/handshake.yaml
> +++ b/Documentation/netlink/specs/handshake.yaml
[ ... ]
> @@ -96,6 +100,16 @@ attribute-sets:
>          name: remote-auth
>          type: s32
>          multi-attr: true
> +      -
> +        name: tag
> +        type: string
> +        doc: >-
> +          A tag the handshake agent assigns to this handshake. The
> +          payload may omit the trailing NUL. An embedded NUL is
> +          rejected.
> +        checks:
> +          max-len: session-tag-max-len
> +        multi-attr: true
[ ... ]
> diff --git a/net/handshake/genl.c b/net/handshake/genl.c
> index 26e3efec64ca7..7150b32a54c45 100644
> --- a/net/handshake/genl.c
> +++ b/net/handshake/genl.c
> @@ -18,10 +18,11 @@ static const struct nla_policy handshake_accept_nl_po=
licy[HANDSHAKE_A_ACCEPT_HAN
>  };
> =20
>  /* HANDSHAKE_CMD_DONE - do */
> -static const struct nla_policy handshake_done_nl_policy[HANDSHAKE_A_DONE=
_REMOTE_AUTH + 1] =3D {
> +static const struct nla_policy handshake_done_nl_policy[HANDSHAKE_A_DONE=
_TAG + 1] =3D {
>  	[HANDSHAKE_A_DONE_STATUS] =3D NLA_POLICY_MAX(NLA_U32, MAX_ERRNO),
>  	[HANDSHAKE_A_DONE_SOCKFD] =3D { .type =3D NLA_S32, },
>  	[HANDSHAKE_A_DONE_REMOTE_AUTH] =3D { .type =3D NLA_S32, },
> +	[HANDSHAKE_A_DONE_TAG] =3D { .type =3D NLA_STRING, .len =3D HANDSHAKE_S=
ESSION_TAG_MAX_LEN, },
>  };

[Severity: Medium]
Should HANDSHAKE_A_DONE_TAG require NUL termination with NLA_NUL_STRING
instead of NLA_STRING?

In non-legacy genetlink specifications, string attributes are required to
be NUL-terminated.  Here, tools/net/ynl/pyynl/ynl_gen_c.py emitted
NLA_STRING only because TypeMultiAttr inherits Type.attr_policy() and
delegates _attr_policy() instead of attr_policy(), bypassing
TypeString.attr_policy():

tools/net/ynl/pyynl/ynl_gen_c.py:TypeMultiAttr._attr_policy() {
    def _attr_policy(self, policy):
        return self.base_type._attr_policy(policy)
}

Documenting in handshake.yaml that the payload may omit the trailing NUL
bakes this generator quirk into the uAPI: if TypeMultiAttr is later fixed
to emit NLA_NUL_STRING for multi-attr strings, regenerating the policy
with tools/net/ynl/ynl-regen.sh will break userspace agents that omit the
trailing NUL.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-tls-sessio=
n-tags-v3-0-91271964cdb0@kernel.org?part=3D1

