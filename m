Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7250BC021B8
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Feb 2025 19:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GubPH38OvefOl81ph8p4RyZFgCl0IiL9FXqZATefMdU=; b=fBH3cCz82RUjs1tKXxRD8L/H+M
	EtPq0GiPS4NVHBu6YIxWilfE1pgKcYHmP2py+oahufEkD5n1LAbMoPQPV26btqprCtdkk9NfafYJ1
	01FDUU5/VGZ2PniQgNV7+jhyVDnE+8ZGJPs0nChQgpRFsC068OYLzfX3bWXb6DYMBflyHcCTXLRxT
	XB9OhmZ7RSkIVVFaXtZzB+wG3EDozLGm2a2Ax+y3qVerPgT1hlmjPz0pYFP9Xwct1O0a6t5My71Dz
	2DfXQTtfWVG0LdqTv/gTBrQTXUh4oFPj09RTNo1WozFZ8noRJOw9isx5vqg97b6YK3MEG9dmAPqY/
	1fBtpMZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tnMoR-000000056Yg-2FxL;
	Wed, 26 Feb 2025 19:11:19 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tnMeq-000000054vB-43j7
	for linux-nvme@lists.infradead.org;
	Wed, 26 Feb 2025 19:01:26 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 9CC8D5C74B9;
	Wed, 26 Feb 2025 19:00:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 149CBC4CED6;
	Wed, 26 Feb 2025 19:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740596484;
	bh=0kkdoALIuJtnRdD0VGeHoioZvW3xnSmuK14UCzdeujg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g1uQITdAC3+186R9zg4n44vlpe0ZX1mbUXmAmkF7gr5p27fYfea3OCEUGCUeUq+/O
	 KjHYPLCl3Cs6j/u7sH2EXOumRPnV66/AzHeFXPiAO3+5lyzYpffXO69DJDj74axP08
	 7DsgTK7qYwjuj7CWgE+a+A/nByfw6bsehANca4B/SYQKuhZy3srZCGc4BZIFCVtw2D
	 PR9UDYqBFhhlEXS/K6ugUtjmcjy3FymqkDmp1vDk2TlO6PHuO1gFHb3L/E+a3rxzhl
	 953nujLSrrCmgAKFK4r0u6yTJTj+S9hZZj812RsB4db8XpjNzJrDBqlgch5fuMhVmI
	 29xYZlixnVl+Q==
Date: Wed, 26 Feb 2025 19:01:22 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvmet-tcp: switch to using the crc32c library
Message-ID: <20250226190122.GA3949421@google.com>
References: <20250226062841.60688-1-ebiggers@kernel.org>
 <03dad20d-1293-47d1-a55d-8430fcefc0bb@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03dad20d-1293-47d1-a55d-8430fcefc0bb@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250226_110125_047688_B7A0ED98 
X-CRM114-Status: GOOD (  12.11  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Feb 26, 2025 at 10:37:55AM +0100, Hannes Reinecke wrote:
> ... and it also eliminates a sporadic crash which we've seen
> where 'snd_hash' wasn't initialized when sending PDUs.
> Thanks for doing this!

I'm not sure how that could have happened, since the ahash was allocated when
'if (queue->hdr_digest || queue->data_digest)' which seemed to match the
conditions for when it was used.  But yeah, it's certainly nice to not have the
pointless allocation to worry about.

> (Note to self: check the nvme-tls code for crc32c usage ...)

I have patches for nvme-tls almost ready too.  Just been taking my time since
I've been updating all other users of "crc32" and "crc32c" in the kernel too.
And I need to decide what to do about skb_copy_and_hash_datagram_iter().

- Eric

