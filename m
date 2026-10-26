Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEAC5606A335
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Oct 2026 15:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=44FaonGO;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RfGdENv1
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=vDe8CRpYtfnlmiKQSVOlxcNlMy5T26XfLimRRniHF+0=; b=44FaonGOxJZ8aC7AjetPaBaphG
	ogDlIvjTq8tKadQa1GpZ/NH8OG4p9UzekAz9JG5Mx96/axYxeysmqMhjU4xytNgur5hWiqpQiBihL
	baqAtP3yOD2jd+dRdDhCqtXJXWih1PvwSsy8dobWr5ULo+/7CaFONujWNTq5ZKSbeCs8h8DMAwdcY
	5JhDER8ZCDULhIwZwffES6uzkiMuhDq/MudwB0hjVH1PuyZNmyzvwUK/sNYM1pskMrMmtEB3avmU3
	S7fy8cPEPleD4ZRjqwK5qRYXfxDUtDdBJXEEHkacPSFLBMfdrvWvFUndc81ZMLUVado95e93plMmK
	rnE11fYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLN5L-00000002noB-0idg;
	Mon, 26 Oct 2026 15:58:07 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLN5J-00000002nni-3YGK
	for linux-nvme@lists.infradead.org;
	Mon, 26 Oct 2026 15:58:05 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 63F11600CB;
	Mon, 26 Oct 2026 15:58:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA1081F01825;
	Mon, 26 Oct 2026 15:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793030284;
	bh=vDe8CRpYtfnlmiKQSVOlxcNlMy5T26XfLimRRniHF+0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RfGdENv1KO6WGultc5JBQI30mnFo6lIKcY9IMNm242LLG++yypD0knxji/25b8PHA
	 KWUyeaY+4qcol3KBKeNo/GMw23xHfVVKzB402sfacJYzvNeFe0vZy2sQNkMTR4sBTA
	 aS24MMu0Ia1VzOQuVdZFCc+ZaXidM1CweyLxsyn4wzGVxu8YYpmOW2gjBQ9Z6qCaSb
	 N5LRLymxHHOcSDK0YF1Oa37aZCvH6asL4lEb88PKQ34ncvLwNfAQNWCB9f2nPYsiyM
	 cX9YDggdR5JCxlrTsVUznB2IBeWahvXy3OARhdTDh0GYMww/mQKO50oK7pU4vvBbOz
	 mWdsfHDrHsgeQ==
Date: Mon, 26 Oct 2026 09:58:02 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christian Aurich Zanettini Martins <christian.aurichzm@gmail.com>
Cc: linux-nvme@lists.infradead.org, axboe@kernel.dk, hch@lst.de,
	sagi@grimberg.me, sgogte@purestorage.com, mgurtovoy@nvidia.com,
	israelr@nvidia.com, wagi@kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] nvme-rdma: fix NULL metadata_sgl dereference with T10-PI
Message-ID: <at94ipr6nhBIMBK2@kbusch-mbp>
References: <20261024213737.506824-1-christian.aurichzm@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261024213737.506824-1-christian.aurichzm@gmail.com>
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

On Sat, Oct 24, 2026 at 06:37:37PM -0300, Christian Aurich Zanettini Martins wrote:
> Since commit 2a8513091d2f ("nvme-rdma: parallelize I/O queue allocation
> and startup") the I/O tag set is allocated before the I/O queues.
> nvme_rdma_init_request() only sets req->metadata_sgl if
> queue->pi_support is set, but pi_support is only set later by
> nvme_rdma_alloc_queue(), so every I/O request is left with a NULL
> metadata_sgl.
> 
> With an RDMA device that supports integrity and a namespace formatted
> with protection information, nvme_rdma_dma_map_req() then dereferences
> the NULL pointer on the first integrity I/O, already during the
> namespace scan when there is more than one I/O queue.
> 
> Queues that a later reconnect adds for the first time have the same
> problem.
> 
> Check queue_idx and the controller's max_integrity_segments instead,
> which is what nvme_rdma_alloc_queue() derives pi_support from.

Thanks, applied to nvme-7.4.

