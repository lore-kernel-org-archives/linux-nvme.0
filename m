Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014D6606A331
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Nov 2026 15:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=KpShhEeB;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IWT4N0tu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:References:In-Reply-To:Message-Id:Cc:To:From:Date:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=946ec9uZoayF6niegcR4Rr8CIDVjkdBCZGxp/mlLHkc=; b=KpShhEeBg/yL4d
	uAH8EKyk1rYdx0BZ1XeQ40duFJ2SWUh5hLKFTm4U8oOikZ75ymVzqgC/kwgKtuDZZj2Q933XDh1m8
	3s+iNvnn2LIglsK/S5lLnFPoL5DZwD1zHyO8UmfMV/ODvPnCb5EQGnWQZT0UIj8sFiPTZBLB+9BRg
	FqYtMtgXY4WaKZaLMbvmcM7PMp3VBtGY6z/V/3bAdmxxpHFvTLGsGWX7N6b74Awv/HVC8KxHF1cJz
	96N3IroeM8Qdg6j4xeFODLoaGluZNTDMISdJ/p8vg8Z24g9KYo6oIvlKc9UJYMPOzwiFCSqOdLkRv
	nuJ7SNlhSpsrgBeNuyMw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVsRJ-00000006tTi-45pP;
	Tue, 24 Nov 2026 15:28:13 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVsRE-00000006tTM-2vzJ
	for linux-nvme@lists.infradead.org;
	Tue, 24 Nov 2026 15:28:08 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 1636C410A8;
	Tue, 24 Nov 2026 15:28:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FF1D1F000D3;
	Tue, 24 Nov 2026 15:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795534087;
	bh=946ec9uZoayF6niegcR4Rr8CIDVjkdBCZGxp/mlLHkc=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=IWT4N0tu9LxKsrrXsZ1tSnZeK42PPUoUCk8n/FMTFiAMrIz8MSaY043+096F7X+sb
	 ZaS/qCn4t62wfgaYzRRfsVEo+1bEE9rolLbuZFWKUPp8HAnhsnj8py+Y1bedYP15B7
	 Kw9K3S1ZFq4T7i8r6+ZxGZF3vhI6ekgZsd98xJWGAa09UAE7X+IkWmoV5sd71qHrc8
	 n1I9j1Ti6nPn+gSDKxMbz1y+Orua7nRXtu5VkBxhePCVEiQw2VNavwgVJkDTR3V6+n
	 grnLobhMEde9zaA2o97FMCRID85iTqvRBR1CiWJOja69oOQvlgL4MPqX+WjZ0K8qDs
	 aAfnFHe4ykFrg==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id CEEC9F40066;
	Tue, 24 Nov 2026 10:28:05 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Tue, 24 Nov 2026 10:28:05 -0500
X-ME-Sender: <xms:Ba0Fa1G4Llv2NB1_WVZXdcUQIg2hcdZZdQLFQnKB2u6dyxAcZrBIIg>
    <xme:Ba0Fa1IUuNBUHhtk7GoeugYCHZdMf28B-F4gWoJXbUMFMgp3dq35UCki2kN6aBe3_
    R2VjghtMikYERTOQqWI2KZeMDoS-9-NtvLDgREz6VO6nb4KlB4AAAOf>
X-ME-Proxy-Cause: dmFkZTGFJZDUBuTX/zDjzwu8yflFHzRnhD42ZVk+TPJsCJt4ylKPgTsw1FN45Yj2JOSuFn
    JOP/Qtyx+HMEGRKKCgksavD1tnPkvpPnv7pLbINWjuuQYhTon6UwHHs+ikbtTzbMFBcT+p
    I6Fsnago8uWw03dJkVIxoPYosAhm4Q8mlXMvJT5X8rEntFkEru7HnQqooDS7isvwz90b6K
    aXnVLMDYGRrz6pWAbX1OSmKrZLaAql2KuXF75sGdpbrB8tV21WVFvvwyOl7nDXy+y2sGDo
    8jy39bzJTQB0u5OEAmnKbzZBm6TP8BCtns9GFsFRDvz/u89xNOpm2hX7S9xhKfyKGSK+CA
    +G5YhpO+m6Wj5tsigD6MGL6DIqsCzfWstEnzpw4IXv8242ST43uwBLL9CKaoNdhfqgYUh7
    kZYJ1zFVQmyavcAor5QUxnvInVuqUIshanAeJwiHLf20awXfy9tAVr+4w/8fa1bXanSp1A
    fB4Y9pi1Q371xMRUqAmpzSD8K0Zl9bcddbMZ0IePsmqA6kCZNnFJna2UU2hvzyMJvyIeQD
    Eyj94yuwRczu7VVC4iKH7HBVFl3BAxhyhvHIxNzcVW8sAwjWbe5Sp3NB+nPTd3N5diPfU0
    Nd1w8rci+0zD5r/u/RXGimCCyso8Tp75HYy8EsT8iesWyjeTEBNXzgMLi6Jw
X-ME-Proxy: <xmx:Ba0Fa4EaJ6wHylGugGzwD1JbVAOzrHEXQIPGeVcfTTwGHgR6r6qLSw>
    <xmx:Ba0Fa2Mis713kAt-MdWVW2jzJiujCBl1eWjChiXiOfw2GrYoTrXnMA>
    <xmx:Ba0Fa_ummptp4zGB3W792LrdD1Ir78KIXo-wZzgYolanxN8IVV5FxA>
    <xmx:Ba0Fa8Jq5dge73COF_bJq6T5yHnalSAsW1FBHKcRRM-S6ryyGE108w>
    <xmx:Ba0Fa9cZubrLuTmM1Z4rogUjROmlNZKqr2JZ08TtYXyp5qZddJ4ruFoH>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 8716D780070; Tue, 24 Nov 2026 10:28:05 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-ThreadId: A8Z6fJDuAPLk
Date: Tue, 24 Nov 2026 10:27:45 -0500
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
Message-Id: <fbcfb7b2-4cd9-47c9-9cd9-1186a5b15059@app.fastmail.com>
In-Reply-To: <20261123155242.49d87894@kernel.org>
References: <20261113-tls-session-tags-v3-0-91271964cdb0@kernel.org>
 <20261121161302.69f202c8@kernel.org>
 <7a0695c2-bf7a-4394-8cfe-a92deeba51e3@app.fastmail.com>
 <20261123155242.49d87894@kernel.org>
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


On Mon, Nov 23, 2026, at 7:34 PM, Jakub Kicinski wrote:
> On Sun, 22 Nov 2026 16:27:08 -0800 Chuck Lever wrote:
>> On Sat, Nov 21, 2026, at 4:13 PM, Jakub Kicinski wrote:
>> > Naively I'd think it creates unnecessarily wide API on both ends
>> > (handshake and server). My knee jerk design would be to populate
>> > the full policy in the server, and only carry some "policy ID"
>> > thru the handshake. Number of policy IDs would equal to the number
>> > of tag combinations (which result in different behavior). =20
>>=20
>> How is a tag much different than a policy ID?
>>=20
>> It wouldn=E2=80=99t be impossible to impose another layer here that m=
akes
>> a specific set of tags into a single policy, but I=E2=80=99m not seei=
ng
>> that doing such adds a lot of value.
>
> My thinking was that we have two user space components (TLS handshake
> handler and the storage server stack) which are required to render
> their decision in the language of tags, and upload the result
> to the kernel via independent APIs. The policy ID limits the kernel
> to mechanical enforcement.

That is basically the structure I have planned.

- tlshd parses the x.509 certificate and assigns matching tags to
  TLS sessions

- The exportfs command assigns tags to NFS exports and passes the
  tags to the kernel as part of its usual downcall

- Kernel NFSD grants access to an NFS export only when there is a
  non-empty intersection between the tags on the TLS session and
  the tags on the export being accessed.

This might be more helpful than the scant series cover letter:

  https://github.com/linux-nfs/ktls-utils/blob/main/man/man7/tls-session=
-tags.7

It describes the configuration of tlshd's tagging policies. The man
page actually describes how these things are stored in YAML; to
make it easier for humans, we could build a bespoke editing tool.=20

The exportfs command will get an "allow-tags=3D" option that specifies
the set of tags that are granted access. I have some prototype
patches in a private tree, so nothing publishable here yet.


> The components resolve all decisions in user
> space, and give the kernel full list of policy ID -> allowed resources.

Yes, exactly so.


> Could be purely a subjective preference, I won't insist.

I will do another survey of policy mechanisms, as you suggested, at
least for reviewer reference.


> Tho an ack
> from someone experienced with building kernel (security?) policies
> would be awesome.

Agreed, review welcome. I'm open to suggestion on modifying the Cc:
list.


> BTW someone marked the patches as changes requested, so repost will be
> needed.

Yes, I plan a re-roll to address the sashiko review findings you
referred me to.


--=20
Chuck Lever

