Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 841F2C021A8
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Feb 2025 06:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=y2uWHNXa/ZN4FiavCBnjjhELBCEMgM3Nx/YZD0w/SBE=; b=h5zmWoVGksv0+5ySmO9F/N6GEp
	6MA4xLHSuwjFM8rr//dN+gr9mlLp6fBC/5R2qvFk1QaXUaFmKEa1z5YIRZFNhjDAv/ynEV51Jkrav
	TG4b3AMWXR/yeK5of/DenyuZVCFMffEp+jZA20P+uF8h/JiEd+pCil3iwGkGiQXqYrDXRFc+dedGn
	61LaJi+/gHx21wHF9Sq/jX2pLrwIdoBNqoA2DGKAzobhpuEj6L+srepyV2b2nBtkCdHl86A1MeSvT
	C/ieu1gZnnopyevRN5J3ecr4it/7ooYRUJ76tWZ9u9aejrd85HXrlDyZguKszcfw8KxAF3nJZcMR7
	kDWPr4og==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tiSbb-00000009uzo-3LwD;
	Thu, 13 Feb 2025 06:21:47 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tiSa9-00000009ulq-43jb;
	Thu, 13 Feb 2025 06:20:19 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 75A1C67373; Thu, 13 Feb 2025 07:20:13 +0100 (CET)
Date: Thu, 13 Feb 2025 07:20:13 +0100
From: Christoph Hellwig <hch@lst.de>
To: Alyssa Rosenzweig <alyssa@rosenzweig.io>
Cc: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Philipp Zabel <p.zabel@pengutronix.de>, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] apple-nvme: defer cache flushes by a specified
 amount
Message-ID: <20250213062013.GC19608@lst.de>
References: <20250211-nvme-fixes-v1-0-6958b3aa49fe@rosenzweig.io> <20250211-nvme-fixes-v1-3-6958b3aa49fe@rosenzweig.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250211-nvme-fixes-v1-3-6958b3aa49fe@rosenzweig.io>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250212_222018_151204_C0075227 
X-CRM114-Status: GOOD (  16.55  )
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

On Tue, Feb 11, 2025 at 01:25:59PM -0500, Alyssa Rosenzweig wrote:
> From: Jens Axboe <axboe@kernel.dk>
> 
> Cache flushes on the M1 nvme are really slow, taking 17-18 msec to
> complete. This can slow down workloads considerably, pure random writes
> end up being bound by the flush latency and hence run at 55-60 IOPS.
> 
> Add a deferred flush work around to provide better performance, at a
> minimal risk. By default, flushes are delayed at most 1 second, but this
> is configurable.
> 
> With this work-around, a pure random write workload runs at ~12K IOPS
> rather than 56 IOPS.

Just as last time this really is not a driver feature.  Cache flushes
are slow on consumer hardware, it's just apple is worse than usual.
Breaking file system transactional guarantee by ignoring data integrity
command in the driver is a no-go.

If we want to allow an opt-in policy for those whole feel adventurous,
it belongs into the core flush state machine.  Fortunately the patch
author seems qualified to touch that :)



