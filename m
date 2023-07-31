Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D785AC001E0
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Jul 2023 14:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CucA2Wh76Zo5CjKaoAQcU4GqOR0hNfj5aFjYH3T+MIw=; b=ncif21Kpr/iGbz4kHRAPUNsV+9
	yijiUUTAQgobrWiDSdrkk3hwtcFsOMHrmZUcstCu/pc5ykp8HUR0PY5qiJGI3ffyyZ5D0ZykNyDwW
	QcEpvHNzsjmSXJdy07A85vx8yBfMjS8bUkMhaxSpBSXt6FLyKqUzxsUUwtsZLfesLCCzOkN74PS5n
	RQWrMUIPokNKupEHDs7vBmcj95hPgWAJ0CNtyirDqYCfTZ7tjbk9guRpqIMq1h5CxFgPHBwfbVqLr
	VgkQGjJXRNSKsyxohpsg0b0JGVeI2hZ4lTbC7IeGIr7lsfu2DMNjDBPz7CIKiZnjRa2frEm6X2bVA
	X6fAoplg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qQTZQ-00G4lg-06;
	Mon, 31 Jul 2023 14:08:24 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qQTZO-00G4lO-1W;
	Mon, 31 Jul 2023 14:08:22 +0000
Date: Mon, 31 Jul 2023 07:08:22 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH] nvme: zns: limit max_zone_append by max_segments
Message-ID: <ZMfAVkHn2Gm6NRS9@infradead.org>
References: <20230731114632.1429799-1-shinichiro.kawasaki@wdc.com>
 <ZMe7Gck9MSo8Fn+a@infradead.org>
 <2dea2a1c-b127-4661-c232-4dcf0b249878@kernel.org>
 <ZMe/tFLYy8xR9EWs@infradead.org>
 <67078894-69d6-f89f-00c2-55e4556edf38@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67078894-69d6-f89f-00c2-55e4556edf38@kernel.org>
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

On Mon, Jul 31, 2023 at 11:07:30PM +0900, Damien Le Moal wrote:
> On 7/31/23 23:05, Christoph Hellwig wrote:
> > On Mon, Jul 31, 2023 at 11:02:35PM +0900, Damien Le Moal wrote:
> >>>
> >>> 	blk_queue_max_zone_append_sectors(q,
> >>> 		queue_max_sectors(q), ns->ctrl->max_zone_append);
> >>
> >> blk_queue_max_zone_append_sectors() already does cap max zone append to
> >> max_hw_sectors.
> > 
> > Then we should not need this..
> 
> The cap is not the soft limit. It is the large hw limit, which I think is mdts
> as well for zns.

Well, there shouldn't be a strict need to limit to the soft limit.
Although limiting WRITE and not ZONE_APPEND fields a bit weird.

