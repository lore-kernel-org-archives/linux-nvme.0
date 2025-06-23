Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B0BFC7EE32
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Jun 2025 19:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7GlrCIhwKAEHppYQF+AyTd4Lqnr2ETw8o2DAc651MNI=; b=MaW1NVFL0twy1JpLc9B0yWU3x3
	3btNitTMtZo9Kyn0rrpZ4EdK2FSbGWhRXBg7WZNJLh0OTLQHHUgsjIXf/DQs8kPYk5pEhn8WNttNL
	uG9sI2jSAG7fyHARlv6qSgfjjQtrGCiF3jzhIMDZTyFJXwR7AeQDcZqXZPAmYGxWgZrcCt54eEwQN
	DZwGOP+4QjKchlJqri8y46QY9vOU3ItMrn3aL8bUBO6lHu6XXUJchdfySr8A0x8KxcyS+h0L3dHJs
	X9iI3laE15CLMsvbga8WmIcp8rA33IvWT5522xHGuULPY0UPkXdJyS05CP6bN/dixrPdeXXTDGJeb
	AL3XID8Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTn3S-00000003pF2-3Dma;
	Mon, 23 Jun 2025 19:42:10 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTjLJ-00000003HpD-1MQ1
	for linux-nvme@lists.infradead.org;
	Mon, 23 Jun 2025 15:44:21 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id BD8DC6112C;
	Mon, 23 Jun 2025 15:44:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6729C4CEEA;
	Mon, 23 Jun 2025 15:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750693460;
	bh=9BQ1ioDiMBHUQu+2sHzZIu1nET0FBJI3rflpGZEATno=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MDxvg3jDPtEphFw4T6z/BN7F+rE3LR5IecdJODREv8obGTCh6KkPExbRzgdnDjkGS
	 Glxr8XV0cFaXTSaPtQbZ5yezGR/t5J3kBBZW95Pddm97TiFLWSEM3Uif/07xAChLws
	 M9q8v4o9J+1BOb29H55jYMYUYHMEvXnFL21I6FWOpsZRzPI0GH3q396trfzt78JBo9
	 oMSIoSoEBkGdzqnA8WjNzZE/PbKLR2/P0QzQQ444QjI2ZWsEWjrRqwUApo9WR77Swt
	 gw4Vvr/AOChadx8fxdyYbP7MrBdyx8zKlQJj6l0DyWljmaIGSGNRN9Bq3HaAhgELEN
	 aFSgw1+06Zysg==
Date: Mon, 23 Jun 2025 09:44:18 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Leon Romanovsky <leon@kernel.org>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Logan Gunthorpe <logang@deltatee.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, Daniel Gomez <da.gomez@samsung.com>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [PATCH 7/8] nvme-pci: replace NVME_MAX_KB_SZ with NVME_MAX_BYTE
Message-ID: <aFl2Uvlskbt7iXiZ@kbusch-mbp>
References: <20250623141259.76767-1-hch@lst.de>
 <20250623141259.76767-8-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250623141259.76767-8-hch@lst.de>
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

On Mon, Jun 23, 2025 at 04:12:29PM +0200, Christoph Hellwig wrote:
> Having a define in kiB units is a bit weird.  Also update the
> comment now that there is not scatterlist limit.

Looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>

