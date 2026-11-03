Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F70606A33E
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Nov 2026 20:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=eseC4zYt;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gkyrt7V9
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=kOQHm/cSQ8hXHfqjsR3vSGDbjczIWcs+teVv58ONHrc=; b=eseC4zYtmbWcCo6522c5zs2h59
	BnAxeV6mHATlsw2Q98qbzFVxQ2Y7l23SuZzUV5A77cUFZnrIXYif5jtuUcMe+92n2ThaR5bpQu9P9
	6Bx2SWM/zBCxFlAoBsY9kqYiuRD26gMMe6Ur6+bdtQksitnRfq7YL0fpE4KhF9/xe6cb2QqzagSu8
	aB81SOJibv3x4v1BFlEP9JHL6BgtvOXY/9RSPItAq1fVXUkDe3WiS4zBvUFFSkxcecdi4YYViTELO
	l5UABKNPUX6UDsfkToXq4qC5oo3A6OHxjchYNv/5hEWtxBjHZkVZAAZGM3HnPKXNxpzx8Gn6Q1cKB
	D/ftE1Nw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOKm2-00000003bDr-2YMY;
	Tue, 03 Nov 2026 20:06:26 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOKm1-00000003bDi-1665
	for linux-nvme@lists.infradead.org;
	Tue, 03 Nov 2026 20:06:25 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id DBE35440B7;
	Tue,  3 Nov 2026 20:06:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AEAD1F000C1;
	Tue,  3 Nov 2026 20:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793736384;
	bh=kOQHm/cSQ8hXHfqjsR3vSGDbjczIWcs+teVv58ONHrc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Gkyrt7V9aW+Iwcl/019dLW4XX+Vv/dU8MWlEFW7a6AllIp0pGLaEjKJ4AiHcRqwXF
	 sTdLtQ2FAl3gwBgXDhGDXqzhRkWnEauiCPnnkVkGEUcfIiew7fc6C0FtHZL6j1aI9/
	 P2ygI+VknULFBHDuU8dZ20OZWEdC3831X0S2VLRaPpAfWXqM7KAsHJceCmwXyXOeP4
	 C7xVaG07Dv5FAyAgnA5PAsrCZy7cPSwJK5BGwb0GK6q3KOHiSw8hFZukzzJEZypeKJ
	 O37bK6C21C/Hs+57NlCNOsYw7ybFNvWB7nQe5X6aSnuj0Ty75EUJxL8e+EAnW+cxSI
	 adpmeslSSC29Q==
Date: Tue, 3 Nov 2026 13:06:23 -0700
From: Keith Busch <kbusch@kernel.org>
To: Mauricio Faria de Oliveira <mfo@igalia.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, Chao Shi <coshi036@gmail.com>,
	kernel-dev@igalia.com, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: reject completions for requests that are not in
 flight
Message-ID: <auo-v5ZliGbM1Tiz@kbusch-mbp>
References: <20261103-nvme-double-cmpl-uaf-blk-mq-v1-1-b10fea474423@igalia.com>
 <auo5a1kRTSWsAYtF@kbusch-mbp>
 <352cfcec6865cbf636a22442511f16b1@igalia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <352cfcec6865cbf636a22442511f16b1@igalia.com>
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

On Tue, Nov 03, 2026 at 04:54:27PM -0300, Mauricio Faria de Oliveira wrote:
> For the former question, I'd imagine other block drivers might be
> subject to a similar issue, under incorrect completions, and can take a
> look at this later. I'd appreciate feedback on the points above before
> trying to address it generically in the block layer, if at all possible.

Here's my real concern: the proposal is a race. Another CPU can change
the request state to in-flight, and this code will declare it complete
before the hardware even saw it. It's a silent data corruption problem
that we can't fix because it is impossible to tell the difference
between a bogus and a legit completion at that point. This kind of
hardware shouldn't be allowed to exist as it can't be used successfully
when it behaves this way.

