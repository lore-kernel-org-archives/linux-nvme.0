Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F55F607F2A4
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Nov 2026 20:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=qXkeO99q;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N8/DPqg3
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=eISV9PtfxBBjY3xTz6XqgWOFKv6BjWqpUx7HxFmpYr0=; b=qXkeO99qYlla91WVMlDH8i/tm5
	099b3q/F4BP41QunKI3AOizTxhSClVsvbVMaHQK7VSC6m1+Bak/GIRppdLVXgDG2dbF99yart3IPK
	Cn5XxX5bbaDik1WtpSRmgmDCiUAfASRqruj0vJnf/KAL2rIDmJvznooS2I/c0P71w8GUk693NdSRb
	akSXRO+8ScllQGY/tQtD1EUcmGZYCycWrptBnnjx473Wezn6pPA4x/qo9N+9XQa0Fqjfs1nhP3JjP
	NX/je6TAMgn5JGhSk3vtrxr+oWMhhtc2sjCSRv6pgJvvtkQ8iI/auDH7+WV7ipIwRnYiCTJoR2if8
	1le3lVzQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOhKr-00000006rbI-0tSb;
	Wed, 04 Nov 2026 20:11:53 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOhKq-00000006rb7-2SqG
	for linux-nvme@lists.infradead.org;
	Wed, 04 Nov 2026 20:11:52 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id B12CE60F19;
	Wed,  4 Nov 2026 20:11:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ABC91F000C1;
	Wed,  4 Nov 2026 20:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793823111;
	bh=eISV9PtfxBBjY3xTz6XqgWOFKv6BjWqpUx7HxFmpYr0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=N8/DPqg3ix/YMADFCcBDWhNnT8+fVkl8KfuBBm4T0nVtcZJkCV65F48UFxYG8Stcr
	 XkuidTVHPKjojl/gG+OamR25qXdYYjyj82ips58sPm0gxkhxh6qlj670doy4K06y41
	 9Bia+O4xL3pWMZ2pKNkR8PryLY3l/k8S32QJDEMZq6Lc18atLU4GL+i2dn2zICw18W
	 QWhi7fC5H61SaVVz6aotdZO5KPzSEZyZwmWbifKj0QZdy4Ls2RPnMSDusC6i7MU04v
	 wt6eHyPC1qkmFXnvBC0xdFU9cVg1EGRdLKFbAW3b8P5NFhIBSMyvlVpwjpj5OKX5jH
	 gyAdrsewdR/wg==
Date: Wed, 4 Nov 2026 13:11:49 -0700
From: Keith Busch <kbusch@kernel.org>
To: Mauricio Faria de Oliveira <mfo@igalia.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, Chao Shi <coshi036@gmail.com>,
	kernel-dev@igalia.com, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: reject completions for requests that are not in
 flight
Message-ID: <auuRhVO8nZHM-MwY@kbusch-mbp>
References: <20261103-nvme-double-cmpl-uaf-blk-mq-v1-1-b10fea474423@igalia.com>
 <auo5a1kRTSWsAYtF@kbusch-mbp>
 <352cfcec6865cbf636a22442511f16b1@igalia.com>
 <auo-v5ZliGbM1Tiz@kbusch-mbp>
 <65414ea51d23fdbeb5d8b7bb4bd9d535@igalia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65414ea51d23fdbeb5d8b7bb4bd9d535@igalia.com>
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

On Wed, Nov 04, 2026 at 04:46:12PM -0300, Mauricio Faria de Oliveira wrote:
> On 2026-11-03 17:06, Keith Busch wrote:
> > On Tue, Nov 03, 2026 at 04:54:27PM -0300, Mauricio Faria de Oliveira wrote:
> >> For the former question, I'd imagine other block drivers might be
> >> subject to a similar issue, under incorrect completions, and can take a
> >> look at this later. I'd appreciate feedback on the points above before
> >> trying to address it generically in the block layer, if at all possible.
> > 
> > Here's my real concern: the proposal is a race. Another CPU can change
> > the request state to in-flight, and this code will declare it complete
> > before the hardware even saw it. It's a silent data corruption problem
> > that we can't fix because it is impossible to tell the difference
> > between a bogus and a legit completion at that point. This kind of
> > hardware shouldn't be allowed to exist as it can't be used successfully
> > when it behaves this way.
> 
> Could you please clarify? Not that I'm defending the patch; just so I
> understand your point.
> 
> The reason I ask is, IIUIC, if another CPU changes the request state to
> in-flight and wins the race over an incorrect completion that maps to
> that request, the request is declared complete anyway, even without this
> code, no?

Yes, the race I'm mentioning is pre-existing assuming we're dealing with
this kind of protocol breaking hardware. It just can't be fixed on the
kernel side, and the proposal trying to cater to it makes it painfully
obvious. I'd rather crash the kernel than risk passing on corrupted data
as a success.

