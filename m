Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E367606A339
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Nov 2026 16:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=SAhz1NwR;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mghHXH79
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:References:In-Reply-To:Message-Id:Cc:To:From:Date:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=Sw0tp8NDejfGg7X2BMLM/bjCiaduIGwJmfTqzVWl61E=; b=SAhz1NwRz6R5x1
	4z7LCWSDIMHI6pwAMtasA2ORKM07qbip1WHFvBFMOiMF3YOoAA+rYLbrlQpSJwuQnNWNbAgjqfzZQ
	haL1WAlq6qgCeXx9MYhWwUNIhnGzsq2Gf3ktxVrTb2JICZivisQ34+bJJGKRJwUuLyRpYH7DWK3Gu
	PJp2nxTipTTn/WJkyZVLaXKpPU5Q9beWPplaE/K3qlIYcXVcF+fCvPRf854TW3ljyftLMdemCTtqM
	zIrqMy2s4jKVA0J8cRIq2JhNvR08bT9AAVvXFvGgiIbsy4KQJiiSYVbpb2M8VzCC9aS129TSs5mlo
	nbkmCnwgo9twKSuEDLYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWyqJ-0000000H5cn-3dUG;
	Fri, 27 Nov 2026 16:30:35 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWyqI-0000000H5cN-2oGt
	for linux-nvme@lists.infradead.org;
	Fri, 27 Nov 2026 16:30:34 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 5C8E7441DD;
	Fri, 27 Nov 2026 16:30:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A016A1F00899;
	Fri, 27 Nov 2026 16:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795797034;
	bh=Sw0tp8NDejfGg7X2BMLM/bjCiaduIGwJmfTqzVWl61E=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=mghHXH79DxJD14zUrWcTaPxXHAVc8vhsm5WZmqMEElaOgUzzkbap0YRw97Fns4Bc/
	 jsST1rGi1TC5p7nXNi1WvFcBcQgcutvExdcd1oL+lHRvReu74td4KlKcSY6RoSE1bL
	 jLpvQJPI4u2lgXvBwQIWHOYSaRs1q4YbP413XzWQ0JLYS/bEXvgzuQBrCL5znBiZgK
	 5Fx7gmQPTUG6chOlqNWEAFpsIQMGXKMmxST20xpwFVXZOIHLOOMYVpl7XUgfl6NLyW
	 lhrBr9HDyHPuyDja+KgUSq3Z5rIldITrqmk2mX0vU8z7ekXcHBDVlCwYHhnLYNiKW0
	 DFJgSHe/13O2Q==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id DA185F40066;
	Fri, 27 Nov 2026 11:30:32 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Fri, 27 Nov 2026 11:30:32 -0500
X-ME-Sender: <xms:KLAJayV9S1YvMsnQ1LGCav8NXCjBj8xgQUO-mq3w96-0FZObKiLfqA>
    <xme:KLAJa5ZaPuDYiDfQab55wJTxi8BRN1iXYAYyIdiCc9L01Dy5AA998zTdaEFbK1aGM
    bHaypsvFlmhba2b6dz1AXOuYFRXDko_Pgoiru_IikrCY_W43uEqz38x>
X-ME-Proxy-Cause: dmFkZTEQYo7d31CaQQDpLnR4G7vJ+9syIEHphpomb/uGssUZqpOqMQ32iGMPTc9KW/2l2Y
    Cq0tkdZOuWVuNsLi7DyAFvPT9nOE9wa3InXGuOuQBGaBQ8uDsWJ7tTmpVb/ZmKRyQLBSVr
    YUZ2EUX+JT5M+a9K2Crbgfu8YTE9Rqdx4gRQmu7T+ns9jBiLlRBY8eowZTFj+vTLal8kS0
    iX0vVv9kwO3P9cmi4quZ4AEwQo+nA//IEG/IJS6RX8Q3S2Bc/rtlwyACYY926bPR3Z4S7y
    okXqDJUQz+3H1cbeuVW0hdyz1wBhhK/DTHxWjT0BhiIqFRD3A4DkztJXW6OCmIeGcl/JJY
    f5Eopi/1cOm/+QXjeqX521u3ULZeRJogvbjX6U7W1ztFEf5AQipL6unWQQ+w8IV7LUxF9v
    1L2Ds8nn5XLfRUfiX+qm0qLICsq+d8JAlE8ZG3h3mEGiHEQDtOaXkhBPhPR/rCU2BK7L+D
    9h1yx8lSkAvWemetZCSRwMrMxz/IAB626OYRvD4V1jzZkp/V2ho9hOQgBdBJYu5hjT8yHe
    Ri5Ix+1RLMdK6oEPgSAkwH1ZXcKjZ9vMB4MQZA3VKTsSdDVQk5H7NLBtCt17ynumjr3xNM
    RaUbsrs2rev95OP9YY6/qG1K0dQ0PozayI0kmEerWOV0iKCShlOVI5T8WAOg
X-ME-Proxy: <xmx:KLAJa5Xt4J0cWCv85OOevdKrAVU9UeRpbR_f7bnnW_4sNhNyTjbsrQ>
    <xmx:KLAJa-f55YsBqF4Vl2sdxI9rxFXC_nxuIgCfTHoNoNYp19_k8P2xHA>
    <xmx:KLAJay8CkTrUINgwQD7M4L5nPVUg4kw0NpV9Nol46zQKFOgJweAJdg>
    <xmx:KLAJa-b3qgnDvJXrzGj17TcNhjdfVMcXCqV4yESED8_z0q0JcJCwgQ>
    <xmx:KLAJayuK1FDjqbq7shMocOFxoI_R41bbZVIy0OoUR-TaL_b-1rAT43bf>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id A4EA1780070; Fri, 27 Nov 2026 11:30:32 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-ThreadId: A8Z6fJDuAPLk
Date: Fri, 27 Nov 2026 11:30:12 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Jakub Kicinski" <kuba@kernel.org>
Cc: "Donald Hunter" <donald.hunter@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, "Paolo Abeni" <pabeni@redhat.com>,
 "Simon Horman" <horms@kernel.org>,
 "John Fastabend" <john.fastabend@gmail.com>,
 "Sabrina Dubroca" <sd@queasysnail.net>, "Keith Busch" <kbusch@kernel.org>,
 "Jens Axboe" <axboe@kernel.dk>, "Christoph Hellwig" <hch@lst.de>,
 "Sagi Grimberg" <sagi@grimberg.me>, "Chaitanya Kulkarni" <kch@nvidia.com>,
 "Jeff Layton" <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, "Eric Dumazet" <edumazet@kernel.org>,
 kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org,
 "Hannes Reinecke" <hare@kernel.org>
Message-Id: <bbac34f0-1f86-46e2-a3f1-248c65a1b9ec@app.fastmail.com>
In-Reply-To: <20261121161302.69f202c8@kernel.org>
References: <20261113-tls-session-tags-v3-0-91271964cdb0@kernel.org>
 <20261121161302.69f202c8@kernel.org>
Subject: Re: [PATCH net-next v3 00/10] Deliver TLS session tags to upper-layer
 consumers (NFSD)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On Sat, Nov 21, 2026, at 7:13 PM, Jakub Kicinski wrote:
> On Fri, 13 Nov 2026 14:21:58 -0500 Chuck Lever wrote:
>> NFSD controls remote access to its exports today by IP address and
>> hostname. Neither of these are cryptographically secure. For
>> instance, a MitM can replace the response to a server's plaintext
>> DNS query. As a result, a malicious NFS client can pretend to be a
>> client whose hostname matches one that has access to exports it
>> would otherwise be denied access to.
>>=20
>> So instead, we want access-control decisions to be based on
>> cryptographically-vetted objects such as TLS peer-certificates.
>> In-kernel x.509 parsing would duplicate work mature userspace
>> libraries already do, so let's make tlshd evaluate peer certificates
>> in user space.
>>=20
>> The certificates are evaluated against admin-defined policy, such
>> as whether the certificate's Issuer matches a particular string.
>> tlshd then marks NFS TLS sessions with those policy matches. Admins
>> also provide a set of policy names on each NFSD export (allow_tags).
>> Computing the intersection with these per-export tags is quick and
>> completely separate from the details of parsing x.509 certificates.
>>=20
>> A yet-to-be-posted patch series introduces tag set support to the
>> exportfs command in nfs-utils. tlshd 1.5.0, current as of this
>> writing, already implements TLS session tagging.

> The patches look reasonable to me, overall. At a high level tho -=20
> I don't have any familiarity with "tag" based policies.
> Are you confident it's flexible and convenient enough to survive
> as uAPI?
>
> Naively I'd think it creates unnecessarily wide API on both ends
> (handshake and server). My knee jerk design would be to populate
> the full policy in the server, and only carry some "policy ID"
> thru the handshake. Number of policy IDs would equal to the number
> of tag combinations (which result in different behavior).
>
> Any examples of APIs like the one you're adding working well?

Here are a few similar mechanisms that are deployed and working.

1. OpenSSH certificate principals. A CA-signed certificate carries
   a set of principal names. AuthorizedPrincipalsFile lists the
   names a target accepts, and access is granted if any principal
   in the certificate matches a line. That is exactly the
   non-empty-intersection rule. AuthorizedPrincipalsCommand
   computes the set in user space, which is the role tlshd plays
   here. The difference is that principals are minted when the
   certificate is issued, not mapped by a local policy at handshake
   time. [3]

2. AWS IAM Roles Anywhere. It maps X.509 Subject/Issuer/SAN fields
   into session principal tags, such as aws:PrincipalTag/x509Subject/OU,
   through a per-profile attribute mapping. Resource and trust policies
   then condition on those tags. It even uses the name "session tags",
   and the certificate-to-tags step is configured separately from the
   resource policy, as in your design. The differences: AWS tags are
   key/value pairs, and the policy language is richer than set
   intersection. [1], [2]

3. Kerberos PAC group SIDs (AD, Samba, SMB). The KDC, a separate
   component, resolves identity into a set of group SIDs carried in
   the ticket. The file server grants access by intersecting that set
   with the resource ACL and never sees how membership was decided.
   Linux credentials already work this way: supplementary groups and
   the AUTH_SYS gid list are a set of IDs in the credential checked
   against the object. The kernel already enforces
   "set in the session =E2=88=A9 set on the resource".

The policy-ID model you mentioned looks a lot like labeled IPsec
(XFRMA_SEC_CTX). The IKE daemon puts a single security context on
the SA, and an LSM enforces it.

The kernel already does only mechanical enforcement (intersection).

Policy IDs make the problem bigger, not smaller, IMHO. One ID per
combination of tags that behaves differently, the combinations grow
combinatorially. Policy IDs also force one compiler that knows both
the certificate rules and every export, which joins together the two
independently managed configs that tags keep apart.

So, we could:

- Rename tags "group memberships" in the cover letter and documentation,
  since that is the term PAC, SSH and AWS deployments use.

- Pin the string format in the uAPI by specifying a character set,
  maximum length and the existing cap, with any other format rejected
  at the DONE downcall. Optionally, reserve a prefix: namespace so other
  upper-layer protocols (NVMe) can't collide with NFS tags.

- Clarify in the series cover letter that the kernel only intersects and
  group/tag policy is handled in user space.


Lastly, I haven't found a perfect fit for security policy reviewers, but
these come close:

  Cc: linux-security-module@vger.kernel.org
  Cc: Paul Moore <paul@paul-moore.com>


--=20
Chuck Lever

[1] IAM Roles Anywhere: certificate attribute mapping (https://docs.aws.=
amazon.com/rolesanywhere/latest/userguide/attribute-mapping.html)
[2] IAM Roles Anywhere: attribute mapping and trust policy
    (https://docs.aws.amazon.com/rolesanywhere/latest/userguide/attribut=
e-mapping-and-trust-policy.html)
[3] openssh-unix-dev: AuthorizedPrincipalsFile (2010) (https://lists.min=
drot.org/pipermail/openssh-unix-dev/2010-October/029012.html)
  - GitLab: AuthorizedPrincipalsCommand (https://docs.gitlab.com/adminis=
tration/operations/ssh_certificates/)

