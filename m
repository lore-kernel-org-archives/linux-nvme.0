Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34107606A319
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Oct 2026 22:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ETh7sNZ6;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mzTk+MVd
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TL7mbe/xtrzGTO0Hy7xZjUjaYdh2W2uKzcx2I9ujOoo=; b=ETh7sNZ6cFhLOC8GMND/0bg1lk
	upVXPmD6g5J5LyIABfeleX63qIbjWYgRkFJO629bgiEDZbIpH2g+P+oJqf+N1YXATp/7h7V+5ncW1
	Q5JfpcK0khaah0aiKRUePPegyCQRwzoRxH75UUhqM6RlQWPnxBMs5U4vpWkiqVKhHZfNufNB7ScV2
	uYLyXMOXWE8KT5oBCm8R4IeIjc4FpDmhyKFZ79RxPpjxcxHub3fusT5M8jqDm+GA3FEYQEjrEhkem
	HTXVDO+KqPY5wi7RTT4IV54fv03pCyfUl6uHvn+z7BZ3FLJoaowFDNfSjq5ENJuWB9ri2K/RobqJf
	iKzv6nvg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJesY-0000000Cz7z-14BK;
	Wed, 21 Oct 2026 22:33:50 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJesW-0000000Cz7n-3TtQ
	for linux-nvme@lists.infradead.org;
	Wed, 21 Oct 2026 22:33:48 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id E399160008;
	Wed, 21 Oct 2026 22:33:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EA411F000C1;
	Wed, 21 Oct 2026 22:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792622027;
	bh=TL7mbe/xtrzGTO0Hy7xZjUjaYdh2W2uKzcx2I9ujOoo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mzTk+MVdz2r4GfSPYAI3Vg9+cRuW3fDzsVozID7ZKDuEYZ3deqegkdbc/pAFG1crA
	 29acM8lr0vRXc1pyyqYpqQSd7hQZbIrZFpnlfjrdSJl1jNGR/tgbLVA9y8x7l5DfLE
	 dHvmW+IDQzKpzkHpFlRsN/wzSOeChJvzWXfJ6VC47M8im1ktIIsk1ORMqWfuEoIfrd
	 MQaSv6PJIwIxn3jTlMCLBp1Ukqhj1ley9UAi3PFaPIPsFbMXB1QYXF76Wd1yHnHw7e
	 81960ZtKbA9kEY8cOg2Xia8yrEC6uc00H9hGJIV4R24WMm4fxVfaaDf1Ra5g5xV3VV
	 sD4Z+05e7+wVA==
Date: Wed, 21 Oct 2026 16:33:45 -0600
From: Keith Busch <kbusch@kernel.org>
To: Andrew Stellman <astellman@stellman-greene.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
	Jens Axboe <axboe@kernel.dk>,
	Bryam Vargas <hexlabsecurity@proton.me>, security@kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] nvmet-rdma: fix out-of-bounds write in
 nvmet_rdma_map_sgl_inline()
Message-ID: <atk9yQvt7KN_e4nq@kbusch-mbp>
References: <166ea8e3-189e-4212-a457-e0b6e2e678f4@kernel.dk>
 <20261021050748.32491-1-astellman@stellman-greene.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261021050748.32491-1-astellman@stellman-greene.com>
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
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 21, 2026 at 01:07:48AM -0400, Andrew Stellman wrote:
> nvmet_rdma_map_sgl_inline() bounds the host-supplied in-capsule SGL
> offset with "off + len > inline_data_size", evaluated in 64-bit
> arithmetic. off is taken straight from the host SGL descriptor
> (le64_to_cpu(sgl->addr)) and len is promoted to 64-bit, so the sum
> wraps: an off within len of 2^64 makes it small and the check passes.
> off is then used as page_idx = off / PAGE_SIZE to index the fixed-size
> rsp->cmd->inline_sg[] array (NVMET_RDMA_MAX_INLINE_SGE entries), so a
> crafted offset yields an out-of-bounds scatterlist index that is written
> through in nvmet_rdma_use_inline_sg().
> 
> The mapping runs while handling a received capsule, before the command
> executes, so a remote RDMA peer can reach it (the Connect capsule is a
> write and takes this path on a queue that has no controller yet). The
> host controls only the low bits of the resulting displacement, so the
> expected impact is an out-of-bounds write that faults the target
> (remote denial of service).
> 
> This wrap was reported, with a KASAN reproduction, on linux-nvme in May,
> and the check below was suggested in that thread. The fix that was
> applied, 48c0162f647b, reworked how the offset is mapped but kept the
> original check, and its page index turns a wrapped offset into an
> out-of-bounds index into inline_sg[].
> 
> Reject the offset before it can wrap.
> 
> Found independently by static analysis with AI assistance, not
> reproduced at runtime.
> 
> Fixes: 0d5ee2b2ab4f ("nvmet-rdma: support max(16KB, PAGE_SIZE) inline data")
> Fixes: 48c0162f647b ("nvmet-rdma: handle inline data with a nonzero offset")
> Reported-by: Bryam Vargas <hexlabsecurity@proton.me>
> Closes: https://lore.kernel.org/all/LM21QIR-1-qJb7PViyJKCnGBnUzizeiNJVWQ3wb7ZwGezodjgKg3f-iobqOyequ-sT1jFCKJImfqNO_BKU3KO80xFITnaI5GTV_GxLUNDDc=@proton.me/
> Suggested-by: Keith Busch <kbusch@kernel.org>
> Cc: stable@kernel.org

Should be @vger.kernel.org.

Thanks, applied to nvme-7.4 with the above email fixed.

