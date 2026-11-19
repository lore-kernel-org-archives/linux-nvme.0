Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398A8606A320
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Nov 2026 16:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=l3XYd1xV;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gQYSVpk8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=vdpT6LJvyJoZU056rFgJK1cgm13iBFK2/AWVWgyfxl0=; b=l3XYd1xVDVbopyF5I5lydQKfKk
	kCWUISpg1fTr+Wm6zaoOL2jvtqPVWjndQaYo3qLdce12PhUdbntmXl7HZ73S9BFa1Vps+bhP6s7mI
	50lvQk24oy5gwbaQo7paXXdHLtUckgdBqqwu4tXPCAp3RrShXA6Dhs/dKGq0R/M6B6M4XAYDe1sXu
	Ov4sSHhyjvheeWb55b5kXd/3yK7kA94oi6kothmZudDRwBXYrMgTzM7xxpKJVMM7zMLWYQ+rR2sAD
	pdvWWveciNOSjUzzt+xzkJBvH2wshKbFRtsqQINqjFFX05iE04NBoWPmdIGHfaECEfV2TmxeYHGgW
	D/EtNoqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xU57B-0000000Cfax-0OKb;
	Thu, 19 Nov 2026 16:36:01 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xU579-0000000CfZP-115I
	for linux-nvme@lists.infradead.org;
	Thu, 19 Nov 2026 16:35:59 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 60B6C6128E;
	Thu, 19 Nov 2026 16:35:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 511101F000C4;
	Thu, 19 Nov 2026 16:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795106158;
	bh=vdpT6LJvyJoZU056rFgJK1cgm13iBFK2/AWVWgyfxl0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gQYSVpk8Ti3Dz/c09ltm5E6cnoyLoK3hTNLppD3CmR67E27lg38E+/NCiyJoo762q
	 1JxZAcpE2jNuyH7arhdRbACTCBIFV5B499W36m5xUxPglxihcgAMnUl6P1qFnWYZ4A
	 ezd6Xu771igMuOdZ5aggHIRRgwgXfRlWMMFAGf478Zt4qaRiCtizOmkjNT/qvfXO4d
	 2MjjshcGxxPN+92CMQDEpdEjqWE48UfVSvxylXsMxjVHk0GG+Z3S8S5vdgqPqRWYZV
	 DCmzsDYax8vY22yr/uMKPF5oDO7+HGcLKgrnNe476l85h2K5RNG1vW5btEEM7rwpZF
	 YE6t540hluycQ==
Date: Thu, 19 Nov 2026 16:35:52 +0000
From: Simon Horman <horms@kernel.org>
To: Chuck Lever <cel@kernel.org>
Cc: Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Eric Dumazet <edumazet@kernel.org>,
	kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org,
	Hannes Reinecke <hare@kernel.org>
Subject: Re: [PATCH net-next v3 00/10] Deliver TLS session tags to
 upper-layer consumers (NFSD)
Message-ID: <20261119163552.GZ860048@horms.kernel.org>
References: <20261113-tls-session-tags-v3-0-91271964cdb0@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261113-tls-session-tags-v3-0-91271964cdb0@kernel.org>
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
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 13, 2026 at 02:21:58PM -0500, Chuck Lever wrote:
> NFSD controls remote access to its exports today by IP address and
> hostname. Neither of these are cryptographically secure. For
> instance, a MitM can replace the response to a server's plaintext
> DNS query. As a result, a malicious NFS client can pretend to be a
> client whose hostname matches one that has access to exports it
> would otherwise be denied access to.
> 
> So instead, we want access-control decisions to be based on
> cryptographically-vetted objects such as TLS peer-certificates.
> In-kernel x.509 parsing would duplicate work mature userspace
> libraries already do, so let's make tlshd evaluate peer certificates
> in user space.
> 
> The certificates are evaluated against admin-defined policy, such
> as whether the certificate's Issuer matches a particular string.
> tlshd then marks NFS TLS sessions with those policy matches. Admins
> also provide a set of policy names on each NFSD export (allow_tags).
> Computing the intersection with these per-export tags is quick and
> completely separate from the details of parsing x.509 certificates.
> 
> A yet-to-be-posted patch series introduces tag set support to the
> exportfs command in nfs-utils. tlshd 1.5.0, current as of this
> writing, already implements TLS session tagging.

Hi Chuck, all,

FYI, while looking over this patchset I noticed that CI flags
shadow len variables in ynl generated C code.

I believe this is a bug in ynl-gen and have posted a patch to try to
address it.

- [PATCH net-next] tools: ynl-gen: avoid shadow local variable declarations
  https://lore.kernel.org/netdev/20261119-ynl-scope-v1-1-d3b0c964d4cb@kernel.org/

...

