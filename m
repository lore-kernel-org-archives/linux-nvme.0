Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 797FCCCD1A7
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Oct 2025 16:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kvA6xK5Xtq8RBkflh8c9xO3TOx82mNJ2rxZnSqjp06g=; b=fL28V4Hyj2v0/vIMv2fAuy3zT7
	bo0C/6V+dJ2r52L+FSF+9tePXC38Yis9Vpn+WUBnlEiIZIZk9MUYad0RD6h4E0FYFFd27kG9MRRoT
	nh2yTBJxthRsHHs+92BWwQgJgeKfOWK3o9Fj2AEnDBitTkL0YN7wkoLjmeaVtKHYI1L0/q75RJtek
	McaqlHgUiCFLweYdDRtwU+SzQniAQWw0FFhVS1R764hRBTGhOn/eDb2vdF6d4grMz0Z101Xm6QboP
	k0ppijY7wP8S3Wj9WDEZZ1kZu+KDUMpRbC3iyKzx+iOt8/rm9fx33xlWMUNmhiZ3aztZL78mdU9e0
	GUfHvw2g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBFPX-000000008WZ-1dly;
	Tue, 21 Oct 2025 16:40:35 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBFPU-000000008Tv-2pmO
	for linux-nvme@lists.infradead.org;
	Tue, 21 Oct 2025 16:40:34 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6E3C2227A88; Mon, 20 Oct 2025 14:30:28 +0200 (CEST)
Date: Mon, 20 Oct 2025 14:30:27 +0200
From: Christoph Hellwig <hch@lst.de>
To: Leon Romanovsky <leon@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 3/3] block-dma: properly take MMIO path
Message-ID: <20251020123027.GA19560@lst.de>
References: <20251017-block-with-mmio-v1-0-3f486904db5e@nvidia.com> <20251017-block-with-mmio-v1-3-3f486904db5e@nvidia.com> <20251017062519.GC402@lst.de> <20251020085231.GM6199@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020085231.GM6199@unreal>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251021_094032_850791_AE8B564C 
X-CRM114-Status: GOOD (  10.62  )
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

On Mon, Oct 20, 2025 at 11:52:31AM +0300, Leon Romanovsky wrote:
> What about this commit message?

Much bettwer.  Btw, what is the plan for getting rid of the
"automatic" p2p handling, which would be the logical conflusion from
this?


