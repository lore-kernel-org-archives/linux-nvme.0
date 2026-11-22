Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F5F606A331
	for <linux-nvme@archiver.kernel.org>; Sun, 22 Nov 2026 00:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=DtNd/6hP;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X3nYg85n
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=Wme/Jw65vekSkLxpWIsP9GgAmvy1/VZB1ZbshkHKAZw=; b=DtNd/6hPArcTmc
	xaareeSggdJV5GQUq2PTqIDoRwVaHEgwWs7E7DXvxAqws27tKhU7Yri56nHXaNiDnWiXX9IWJ2mSP
	+em5K9l+PSoVukrHfHXvmCR4KyPRWbq1XsVAaARvEXCyKC6ElJ2RBgdPAwkeLeDgmbeVg4+IYVimN
	chSJi0rnrEJsLErDqiF8aLrWbMMDecdmiiGF3sWBtvW1uxhGkNKDc8erXDR47rREFZX+vzRbjvzel
	41LswjwSgKVKZm6wwt9lSN8GSxMfdX+UZmsvBeFY+DCt09VoMflDOE9XwZT/psmxCaPmBfW5bWw3Y
	PyX0CDPiJhlv7wG/xPIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUvCc-00000000ZC9-2Hm3;
	Sun, 22 Nov 2026 00:13:06 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUvCb-00000000ZBz-25YW
	for linux-nvme@lists.infradead.org;
	Sun, 22 Nov 2026 00:13:05 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id ABB8B60D64;
	Sun, 22 Nov 2026 00:13:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF7C71F000C0;
	Sun, 22 Nov 2026 00:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795306384;
	bh=Wme/Jw65vekSkLxpWIsP9GgAmvy1/VZB1ZbshkHKAZw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=X3nYg85nYhldkdDOD6+IzCzfE+ghiyyrey1IreSL8rUp6l2H08RQeBZGRKYeo9qst
	 Ny3CaPnleLhvnutoO5GS6D+KPDlYLp/1M2Bbz0beGB1rdV+/yNFjtoA/JXlxKfVe9I
	 XEG356y+Ut88rKRHvt5Ff7c3qAClO7cQrW0b8Kcr1Nlao9oD+sN5A2M7u4HVLPY2ed
	 oHilj/rEtoc1tTuPLPjqP/6HU+nTZ7BkqmKFuakpR5FfBPS3l1wMFLwU8pSQvw1qVQ
	 BmHok3z4HQNQDMuygC7xfEIMMYsTs5WiekDFnKTjKTLhzASQOCqGW2va0jGvgIscRo
	 7flK77N6TyExw==
Date: Sat, 21 Nov 2026 16:13:02 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Chuck Lever <cel@kernel.org>
Cc: Donald Hunter <donald.hunter@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Sabrina
 Dubroca <sd@queasysnail.net>, Keith Busch <kbusch@kernel.org>, Jens Axboe
 <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg
 <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, Jeff Layton
 <jlayton@kernel.org>, NeilBrown <neil@brown.name>, Olga Kornievskaia
 <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey
 <tom@talpey.com>, Eric Dumazet <edumazet@kernel.org>,
 kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org, Hannes Reinecke
 <hare@kernel.org>
Subject: Re: [PATCH net-next v3 00/10] Deliver TLS session tags to
 upper-layer consumers (NFSD)
Message-ID: <20261121161302.69f202c8@kernel.org>
In-Reply-To: <20261113-tls-session-tags-v3-0-91271964cdb0@kernel.org>
References: <20261113-tls-session-tags-v3-0-91271964cdb0@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Fri, 13 Nov 2026 14:21:58 -0500 Chuck Lever wrote:
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

I submitted this for AI review now, I think due to the problem
Simon flagged CI didn't just gobble it up automatically.
The AI review will not be emailed to the list automatically but
hopefully it will be ready here by the time you read this:
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261113-tls-session-tags-v3-3-91271964cdb0@kernel.org

The patches look reasonable to me, overall. At a high level tho - 
I don't have any familiarity with "tag" based policies.
Are you confident it's flexible and convenient enough to survive
as uAPI?

Naively I'd think it creates unnecessarily wide API on both ends
(handshake and server). My knee jerk design would be to populate
the full policy in the server, and only carry some "policy ID"
thru the handshake. Number of policy IDs would equal to the number
of tag combinations (which result in different behavior).

Any examples of APIs like the one you're adding working well?
Anyone willing to review this series, please??

