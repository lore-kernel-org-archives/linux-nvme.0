Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 466E0C44514
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Jul 2026 20:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9dfbfqdoXKn10lcawgomrLNnCs1SPKM9oBMb8rYI5ws=; b=4NYSVJHRHtIOAOoSYNYjyB4lq2
	cJcHEiRnH9iu6BkWqlEfuySLYdHKt+k6TzET+6x2c+GYDerPOJsbY+0Of0BzDV/7TqEeLGge2+TQ6
	8gvOdjURu1Ema7FvI4PZ9vOLl7yMcMELPDRTIHkfxq9HhfCM/UO+e55qP0O3n9zavct2RWolFeb8E
	i3tQbFjUKus9L+RnFfjy7r/euxFhoYU5wSFdcnzscNwFW7oy5La5HuJ+1otUE5e3eRQJE6LVzOL1E
	0iJATDpnAwGNDSzyaugFido/c05LAp16dfoCXxPRSbZweVsuJKk/Yj6GZ6QsjBKLl8aA5lrls5AlI
	er+g898Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wkT4Y-00000000XGo-05Xh;
	Thu, 16 Jul 2026 20:52:46 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wkT4W-00000000XGR-0xKV
	for linux-nvme@lists.infradead.org;
	Thu, 16 Jul 2026 20:52:44 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id A96C960A5E;
	Thu, 16 Jul 2026 20:52:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE7931F000E9;
	Thu, 16 Jul 2026 20:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784235163;
	bh=9dfbfqdoXKn10lcawgomrLNnCs1SPKM9oBMb8rYI5ws=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AuSPwI3EW3NNq/PxRwu0HFJKNU7dvSgdRJikh94kb7n5Ivgp7F3JVC7AqpM1nVNIl
	 z/TeOymVafponmg0NujiWjLY/aCzgrBMwcdujOuAjlWODHFplHlty3PLByjTvsDfAS
	 2XofCdyzNuui3SzYUJQRkyVktVqB2TazhDbcTRI24HQqAOX0XKdryNOqp6XD8aELc0
	 PVQrnOuG/GZDSkUy0U/JYBBRb6WKD6HrcmWIgMfHQhl4iY5s9XanKvfJE4L/EwVDs8
	 W0rI08nDkN3906ExAVVAWMMCCQy1wEI2WZClbezHrdWSXjRDjSrmkX7/xVE92QKTp8
	 ZySLVVzChGB/g==
Date: Thu, 16 Jul 2026 14:52:41 -0600
From: Keith Busch <kbusch@kernel.org>
To: Jun Zeng <jun1.zeng@intel.com>
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	andriy.shevchenko@intel.com, gang.cao@intel.com,
	jun.i.jin@intel.com, yong.hu@intel.com,
	Liang Fang <liang.a.fang@intel.com>
Subject: Re: [PATCH v1 1/1] nvme-pci: adaptive interrupt coalescing
Message-ID: <allEmTmXCFosxIOr@kbusch-mbp>
References: <20260715075703.15578-1-jun1.zeng@intel.com>
 <20260715075703.15578-2-jun1.zeng@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260715075703.15578-2-jun1.zeng@intel.com>
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

On Wed, Jul 15, 2026 at 03:57:03PM +0800, Jun Zeng wrote:
> Add adaptive interrupt coalescing to improve IOPS for high-throughput
> workloads. Monitor IO pressure periodically and enable/disable coalescing
> automatically based on IOPS, queue depth, and inflight IO thresholds.
> This feature is enabled by default, can be controlled through debugfs
> variable during runtime.

Can't you do all this from user space? You'd maybe need the blk-mq
debugfs to get access to the individual hctx dispatch numbers, but maybe
that's okay?

The atomic_long_inc where you placed it is especially harmful to polled
queues.

