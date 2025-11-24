Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D490CFD350
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Nov 2025 19:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EERH6/JIEEiMf2D5uu/AetAzy7stW1ViASmr0rlnLs0=; b=ON6Rm3hPn7c9KXq3hupOPfYFmw
	OF7VPb9LinVQMXAlaQ4cIqgTe+d7Wu7fB8plIWauBZQiHUa+eiCzDtXVgDkxXg7TftftEwjHUU9mO
	6ZgOKW6n0EZJq84/pdaKudj+aI2Vbi8RBgsnKvtDchvP3JBTuuCU3CZ2/e1ySTBE6xkT+/8LwWmht
	GEouPY+6cRrbx845Du/ogxXUvF6n1duteTB1lU71kelaieK1g0Kvnovgk75VVqeGlPELzrb0poMva
	EtsLKcr01KHe5D/K1w+MLGLFgDJMqW2ETnSHAtpCX9UXUjr/LvxhlPjOmj6JcDKKhd9paHeDMhUBS
	5Fk6ubqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNcLc-0000000CFe5-4Bu8;
	Mon, 24 Nov 2025 19:35:41 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNcLb-0000000CFdt-2Rj5
	for linux-nvme@lists.infradead.org;
	Mon, 24 Nov 2025 19:35:39 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id B1B5D6016B;
	Mon, 24 Nov 2025 19:35:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 102EEC4CEF1;
	Mon, 24 Nov 2025 19:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764012938;
	bh=4gfxfhxsb4p1i0Y/gHmoyYm5wkQ0hQ8R98HFeWnoHJE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=azCyXbGL8dLLL3mDIpqJnOnjuaU8kWLzEPbmHjAKhpCwRFsYYhNU/oOf+KdI0BIvf
	 Hma/XrH4kn6yhlv3DyK3qlYJaKzWkP3Vk8R2gVyskKAY81ZRj4rlnjXY6I+kaJ2HEs
	 jXN/UkDCKT835DOHFh7UjBNEw23ZxRuCkCsDT2iR+IaIYevfrDskvxMV2Meg7KrRIW
	 5u/bTWfJcvx6xpjSGs/7PtmltXTXCb8WAWrsj6ssH8YjL1KhNPE2/iaMPPEi51l41u
	 ElhQFPU7koo6mqZFhYhI9jBFVggoYKuo0jJl75NlIgLeO2/YCOzT/EuLG/xoqa7EYH
	 sONf5RQFMSm4Q==
Date: Mon, 24 Nov 2025 12:35:36 -0700
From: Keith Busch <kbusch@kernel.org>
To: Israel Rukshin <israelr@nvidia.com>
Cc: Linux-nvme <linux-nvme@lists.infradead.org>,
	Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@fb.com>, Nitzan Carmi <nitzanc@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [PATCH 1/2] nvmet-rdma: Use kvcalloc for commands and responses
 arrays
Message-ID: <aSSziMs_1JPxeowN@kbusch-mbp>
References: <1763966961-32140-1-git-send-email-israelr@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1763966961-32140-1-git-send-email-israelr@nvidia.com>
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

On Mon, Nov 24, 2025 at 08:49:20AM +0200, Israel Rukshin wrote:
> Replace kcalloc with kvcalloc for allocation of the commands and
> responses arrays. Each command structure is 272 bytes and each
> response structure is 672 bytes. These arrays typically exceed a
> single page, and grow much larger with high queue depths
> (e.g., commands >2MB, responses >170KB)
> 
> kvcalloc automatically falls back to vmalloc for large or fragmented
> allocations, improving reliability. In our case, this memory is not
> aimed for DMA operations and could be safely allocated by kvcalloc.
> Using virtually contiguous memory helps to avoid allocation failures
> and out-of-memory conditions common with kcalloc on large pools.

Thanks, applied to nvme-6.19.

