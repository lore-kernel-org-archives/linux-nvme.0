Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6C8606A327
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Oct 2026 15:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=shYZQ0RI;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NlgoRxf8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=bGUHLo03oq3Gg6IVQNN1cHzDG9J9sP8CXjYjZOjweHI=; b=shYZQ0RIrPfSOvBRLAA2D5Z4E3
	TeA4Q0INbOxW1m9qWZgS+o2c/PcbneVGVrYWHRc0okQO80mz0+ojqN+3z9w5MpjynEBuQb9yv+BHb
	qkoiJNTP+NFoC+p2ZOHbldxIOeUmsLBYXiW2U7VsaoGL+ERGqnUIhmXl6cIzrkkSJ9VAfk1DsIaHy
	nSL00elprYzVekVr8PC6J5j29B/Yn+9nFuKLlhgf2sxdTUPUuzy3fOCsrjQ/YgHTVNfCzjd5coynQ
	fl8qXSrY/NFD6kA3r6xRmL00vIW6rlaEDD9VXBQBEVg7P4wIquP8ZZgfBuzF12bltJqIN+Vg4ZOWt
	Z9vomO7Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLip2-0000000581W-1UCE;
	Tue, 27 Oct 2026 15:10:44 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLip1-0000000581J-3pPc
	for linux-nvme@lists.infradead.org;
	Tue, 27 Oct 2026 15:10:43 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 5090C4347A;
	Tue, 27 Oct 2026 15:10:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD3C21F01825;
	Tue, 27 Oct 2026 15:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793113843;
	bh=bGUHLo03oq3Gg6IVQNN1cHzDG9J9sP8CXjYjZOjweHI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NlgoRxf87R/lLIP0gRhuPMXw/9sgsDkuP/OhS5aUb/IVv1l/p4i0htoNayF+FaqZR
	 d13p+lhI5IL/I3dQrD/BavcyILToAZuhVSW286rV2gKLuzsnk/8m2LmaDNlFCOyFWv
	 r+oNQ6EXCM4qyame8jUiH0dVfmkI9YL+c4McEBB5d+fcVZxWBFVFaljE1FpCE+1jNC
	 tz+999OOWLUya2pDjd7BDj0vFxrJLNhKcUonAzRppX7k2vxRbmu8DMyKM53zkwWYqO
	 7xMOje5tDI0i6pXnvp2YPaidAb0gi2rWE5PHl9UsIR9i3XwiLyBI5k3LDxykAufg35
	 Xjd0D8JzIarUA==
Date: Tue, 27 Oct 2026 09:10:41 -0600
From: Keith Busch <kbusch@kernel.org>
To: guzebing <guzebing1612@gmail.com>
Cc: axboe@kernel.dk, sagi@grimberg.me, leon@kernel.org,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Guzebing <guzebing@bytedance.com>
Subject: Re: [PATCH] nvme-pci: unmap the full IOVA range on PRP setup failure
Message-ID: <auC-8UVAuj2KDb_S@kbusch-mbp>
References: <20261027115718.2241149-1-guzebing1612@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261027115718.2241149-1-guzebing1612@gmail.com>
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

On Tue, Oct 27, 2026 at 07:57:18PM +0800, guzebing wrote:
> When using IOVA, blk_rq_dma_map_iter_start() maps the entire request
> before PRP construction begins. However, iod->total_len is accumulated
> as PRPs are populated. If a PRP list allocation fails, nvme_unmap_data()
> passes this partial length to blk_rq_dma_unmap(), leaving part of the
> request's DMA mapping intact.
>
> Use dma_iova_size() as the unmap length for IOVA mappings so that
> cleanup covers the full range mapped by blk_rq_dma_map_iter_start(),
> even when PRP construction fails.

I don't think this is right. The dma state's iova size was set when it
was allocated, but there are failure scenarios where we've only linked
part of the request. I think the iod's total_len is just not in sync
with the pinned mappings. We should update the total_len as we iterate
the blk_mq_dma_iter, not when we've assigned a PRP element.

