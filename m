Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 174D4C77B7C
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Jul 2025 17:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HTvCLqL9j8xmTe0+dNDhTKo7Nie7XcpAxXhHjPvNsGs=; b=l8V3TTHA5WzJ0DP37VDLm1JHLm
	wrfV6XOwew7qCejQmWtaNNUIDqKGniw8G+KZHTsL9GA7CjDjP849n9a9crB9rwEL392AzIH6NQ9iN
	GOmYYKkrZg2iOTAhJjov/hlzMfnaq0bCzieMuCZyq0MUqu70olpinmUwZK62LReElaiNv48suqYnG
	l2Ga8bkswOnkN/lfHXE/2OKrDxtF9GOthKTDN8dqHs9zCGngHQyPxbYbs2OWHk/2PhDif2QeVhw37
	HP5RnLNdq/nE6d0mCcBN852nRUOh3HPYB2+m9tKHPA1p4Npqnor+lYiZx+hUq2KOlkOIeg3EqHuqD
	Af62rJ4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXNOh-0000000C4wp-2Xmc;
	Thu, 03 Jul 2025 17:06:55 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXKwJ-0000000Bfjh-1ky8
	for linux-nvme@lists.infradead.org;
	Thu, 03 Jul 2025 14:29:28 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 6A8D65C5754;
	Thu,  3 Jul 2025 14:29:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D681C4CEE3;
	Thu,  3 Jul 2025 14:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751552966;
	bh=Wv4Ly+yjA1eTB3WL/QTAtPsGKoiMbeZftZxmfxTOncY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dr8QqkVZ30M5Svn3VRIByKw3xnPUVjD4k/DreYk1fbBropfMV+ue/tVWidivH6KNS
	 SbjEx2ZLMMz8bYYlLkRk/MbPVBVfaOuU2tZVTwDmmshaIrXqqxdKw4Y4c0Nro6iBs+
	 yhtpnK1gAGhu5UVrAbJTlwZF1z6RQvv80NvUevWaQZw6UOC1M+qQir+Rcbfuzq7rTq
	 PlPhcX/HcOCVjyCfmxI2MSaLESxuwgwcZ64XaDzizTtdEFluCCzTj9/MmHHyvggJqA
	 WOp9cxE0gWgybiJR45S7PeBuJVqcZYmonAVbgg+/BtRREILd8nKnwP2iR46vPS5X8Q
	 ajTdOfn/xryMg==
Date: Thu, 3 Jul 2025 08:29:23 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Ben Copeland <ben.copeland@linaro.org>, linux-kernel@vger.kernel.org,
	lkft-triage@lists.linaro.org, regressions@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	Dan Carpenter <dan.carpenter@linaro.org>, axboe@kernel.dk,
	sagi@grimberg.me, iommu@lists.linux.dev,
	Leon Romanovsky <leonro@nvidia.com>
Subject: Re: next-20250627: IOMMU DMA warning during NVMe I/O completion
 after 06cae0e3f61c
Message-ID: <aGaTw7SzermpfiD7@kbusch-mbp>
References: <CAL0q8a6pOBZbWYdwKzC1U-PuH4rgf2miv0jcF=fWVZt_dUZHmw@mail.gmail.com>
 <20250630133343.GA26040@lst.de>
 <aGLyswGYD6Zai_sI@kbusch-mbp>
 <20250701132936.GA18807@lst.de>
 <aGRMilWhgF4z0WOf@kbusch-mbp>
 <20250703093042.GA7387@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250703093042.GA7387@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250703_072927_502504_9D8D3663 
X-CRM114-Status: GOOD (  13.12  )
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

On Thu, Jul 03, 2025 at 11:30:42AM +0200, Christoph Hellwig wrote:
> I think the idea to reconstruct the dma addresses from PRPs should
> be considered a failure by now.  It works fine for SGLs, but for
> PRPs we're better off just stashing them away.  Bob, can you try

s/Bob/Ben

> something like the patch below?  To be fully safe it needs a mempool,
> and it could use some cleanups, but it does pass testing on my setup
> here, so I'd love to see if if fixes your issue.

Thanks for confirming.

While this is starting to look a bit messy, I believe it's still an
overall win: you've cut down the vector walking in the setup path from 3
to 1, which reduces a non-trivial amount of overhead for even moderately
sized IO.

