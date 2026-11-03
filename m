Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FB4606A329
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Nov 2026 06:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=CAspxG/n
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=To41khtPHzlXcg/B1bOpe2kkIK49wEwH7nCRB1U9TQU=; b=CAspxG/ngZE/vwq6sSgFVhK9fC
	IM8AMQ0PDMnjOzlXdLwwABWbngYDm4J6zJRDiYKqbPBmYxlLTbRQDhUhMKh8Bcayv9nbepmpBcMhu
	R7oU8en7+hO/MY+QAQobxuavNYPMKCR2j1/BORiPzsmV4jybUfElU3hMnDmKSZa+qUyxgNkDcPe6z
	znDEicib8cIoGj5bVzfiIEl1np04trAm/A0ZnRwg94AOYfchH6Shi5dbBxXApUJycQfZiwbRtTTqi
	prveVUNyEChunyWkTRp0AKJHfP6idVnSIdlGCPq3kD2D31eV0iNxU07KSiqN0r+2HJucQs5vhPUck
	ndaEBhGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xO7bm-00000001B6E-04Y3;
	Tue, 03 Nov 2026 06:02:58 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xO7bh-00000001B5E-1Xhf
	for linux-nvme@lists.infradead.org;
	Tue, 03 Nov 2026 06:02:56 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 148A568AFE; Tue,  3 Nov 2026 07:02:50 +0100 (CET)
Date: Tue, 3 Nov 2026 07:02:49 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, axboe@kernel.dk, hch@lst.de,
	Josef Bacik <josef@toxicpanda.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Hannes Reinecke <hare@kernel.org>, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 07/19] nvmet-tcp: let the accept work come to an end
Message-ID: <20261103060249.GD1862@lst.de>
References: <20261029155252.2332266-1-kbusch@meta.com> <20261029155252.2332266-8-kbusch@meta.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261029155252.2332266-8-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261102_220253_560836_C2635612 
X-CRM114-Status: GOOD (  13.77  )
X-Spam-Score: -1.9 (-)
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
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 29, 2026 at 08:52:40AM -0700, Keith Busch wrote:
> From: Josef Bacik <josef@toxicpanda.com>
> 
> nvmet_tcp_accept_work() loops until there's nothing left to accept, and
> anyone opening and closing connections fast enough keeps it running
> indefinitely, since tearing down a dead connection takes long enough for
> more to arrive. Whoever flushes nvmet_wq waits for it: removing any
> other port of the target does in nvmet_port_release(), and so does
> unloading the rdma and fc modules.
> 
> Accept a bounded number of connections per run and requeue the work. A
> flush doesn't wait for work queued behind it.

The subject is very odd, and should probably use something more like
a shortened version of this sentence.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


