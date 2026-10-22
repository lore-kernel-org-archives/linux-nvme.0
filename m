Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560E6606ACE3
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Oct 2026 15:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=UQ5L2UV9;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wh3bmJfM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=pYWpbYgGwt9N5yTmTwh36JAVgl/KWWKdODyVXc8tpS0=; b=UQ5L2UV9DttPRcO8IX23SLTtem
	8UMWQfuGcE9PapG8kEsuKxEFnJlCq43GKXHIQfgbVJFWZeGw66ye7ZfmnlD6mrubvJPUQQOIZCYnb
	7UvSZhjci/ZICkepkZaVvoBkdvWtFzuXOLq4u0AWqxD5E63N+Hwkvj77Qwb8Qm2t/v2L7lhNZVTGD
	ffFaL+w/3qy/P1rptCZFuOZEYz/vva1A8xq0AkhFq350SsrPIHHOQGl8Sa2lTqj505QN01m4CtVOu
	sqyUPZnhimHR80OySac0l2tmSwU47tvZgiQHBZHMx1ntT+ScyBOCf5rZY3f5RTwR/D/Nc1a+Hvodm
	TdKxMCaw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xJuWd-0000000EOGQ-1l2w;
	Thu, 22 Oct 2026 15:16:15 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xJuWc-0000000EOG7-2W2L
	for linux-nvme@lists.infradead.org;
	Thu, 22 Oct 2026 15:16:14 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 71918601FD;
	Thu, 22 Oct 2026 15:16:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9985F1F01825;
	Thu, 22 Oct 2026 15:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792682172;
	bh=pYWpbYgGwt9N5yTmTwh36JAVgl/KWWKdODyVXc8tpS0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Wh3bmJfMiXRkGh0rDkEgacTHwwriqEh1Zdv59qRbyh1Ip82/jt4NmwocooAAg9yJu
	 ZVG5xGhBitNCxzsa03RdgQnZsIcB4Eeynb8zfy1xjgc+FN8Tya8iYTGz5QDVTxhM52
	 lx0fZB16UdHWN+VXvISnAjA9s9THtncArOOUpHyg7StvB97e74P9oJ/ttUfiUg2nKH
	 tEXfmFwaszcVIGW2VoEuRDHlK8qt3n4grnM/F7eMmqPo7uegt3wynMEPrzGn4mThGj
	 5A8awiVHjRl4LGuG8w6r3fdWTyh7xFs5TRlRxisqOBEqDU+smc5Rav76PYXM7A3ZV3
	 yaff0WjzfStTA==
Date: Thu, 22 Oct 2026 09:16:10 -0600
From: Keith Busch <kbusch@kernel.org>
To: Andrea Parri <parri.andrea@gmail.com>
Cc: Justin Tee <justintee8345@gmail.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	James Smart <jsmart833426@gmail.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?iso-8859-1?Q?Wilczy=B4nski?= <kwilczynski@kernel.org>,
	Niklas Cassel <cassel@kernel.org>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] nvmet: fix read data, status and length checks in
 fc, zns and pci-epf
Message-ID: <atoouj9RiG1Ik5I5@kbusch-mbp>
References: <20261022132934.3592924-1-parri.andrea@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261022132934.3592924-1-parri.andrea@gmail.com>
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

On Thu, Oct 22, 2026 at 03:29:29PM +0200, Andrea Parri wrote:
> A connected host can currently receive stale target memory through two
> nvmet transports, and ZNS answers a Zone Management Receive whose NUMD
> byte count wraps.
> 
> The FC transport sends a read buffer even when the command completes with
> an error.  Some errors occur before the command handler initializes that
> buffer, so the host receives data left in the allocation.
> 
> The PCI endpoint transport allocates each read segment at the length of
> the host's SGL data descriptor and sends every segment in full, even when
> the descriptors describe more than the command transfers.  The excess
> reaches the host uninitialized, on any successful read.
> 
> Patch 1 makes the FC transport send read data only for successful
> commands, matching the TCP and RDMA transports.  Patch 2 rejects NUMD
> values whose byte count wraps the u32 length calculation instead of
> accepting the wrapped request.
> 
> Patch 3 fixes a related PCI endpoint bug that patch 4 depends on.  The
> transport reports every error it detects itself as a successful
> completion, because nvmet_pci_epf_complete_iod() reloads the status from
> a CQE that only the nvmet core fills in, so even a write whose data
> could not be fetched is reported as written.  Patch 4 then makes the
> transport reject SGLs whose data descriptors do not add up to the
> command's data length.
> 
> Patches 1 and 2 were tested on top of nvme-7.4 over the loop, tcp, rdma
> (rdma_rxe) and fc (fcloop) transports, with a zoned null_blk namespace
> for patch 2.  Without them, a failed Identify over fc returns data and a
> wrapping NUMD is accepted; with them, neither occurs on any of the four
> transports.

Looks good to me. Applied to nvme-7.4.

