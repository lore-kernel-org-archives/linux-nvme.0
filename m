Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 090B4CC6B15
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Oct 2026 14:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZRZYZOB9FEwIzXDvuVciZI9sqe7j6gZwgAGNjQ2MD3k=; b=Kz24uPKWgsL7494dZqTtm2AHyX
	9CsBhgkUqySfijyf5VNjxFmmxb+8WK9WyJTR7odlj/7Rh+7E8axQqh4LUW011AghXuu93gKS78HDd
	ll9B5APfQ+AP8sahQo15aW96ciqTVvJw5xSZv9BBNTVErS5tUk/KwBD/Prdj12wArbYuHhZyh6atx
	Vk4AJ7iqwiMPypwPuRE9PwLN+4rSCtmTe/8ui18ch8256naAkZYq7jFVfvWmBEgiTlAkYx/8AP/YR
	hrx8J/nM77fQ0SvqY3/LCEdR7HHU4Cigi4xuMxGoD5nAS9AgPyujHFiowKFEY45SOXVf++8Z1AGgf
	HigoichA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGdS4-0000000D5Iz-2nO4;
	Tue, 13 Oct 2026 14:26:00 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGdS2-0000000D5IZ-2XBh
	for linux-nvme@lists.infradead.org;
	Tue, 13 Oct 2026 14:25:59 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5D200227A8E; Tue, 13 Oct 2026 16:25:55 +0200 (CEST)
Date: Tue, 13 Oct 2026 16:25:54 +0200
From: Christoph Hellwig <hch@lst.de>
To: Andrea Parri <parri.andrea@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Damien Le Moal <dlemoal@kernel.org>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/5] nvmet: zns: don't leak stale memory in zone
 management receive
Message-ID: <20261013142554.GC14759@lst.de>
References: <20261012141239.156408-1-parri.andrea@gmail.com> <20261012141239.156408-3-parri.andrea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012141239.156408-3-parri.andrea@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261013_072558_810947_A8A4D397 
X-CRM114-Status: GOOD (  10.73  )
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

On Mon, Oct 12, 2026 at 04:12:29PM +0200, Andrea Parri wrote:
> Tested over the loop, tcp, rdma and fc transports with a zoned
> null_blk namespace: before this patch, zone reports carried stale bytes
> and a data length larger than NUMD was accepted; with it, reports are
> fully initialized and such a length fails with Data SGL Length Invalid.

Can you wire up the reproduce in blktests?

The change itself looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


