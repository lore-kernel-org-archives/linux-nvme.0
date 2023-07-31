Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61EC2C001DE
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Jul 2023 14:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yNLjcPZp5k3ijELOGWOuJxUFufnFWU0GmdwszUlsEQs=; b=R9yEo3ByEqPk1Krs517gAmxVZl
	lctjurzMoNIHhRaEl6jNa7tkR+YuIxl2SWmoEUtLWdHtJykIWWRwxleW49X1zgWFU2JN2keeCTGz/
	UNJo2TtvzOlDOVFG0TIa75wWXr/oors0L1qwDC/UUjaZGNPsH3hqnPxtDULfoiZvzzzeyGD/1tdSs
	L7rVnOON3L0VoeqmOMZuRCChTDSUjRKj5xmalFbwoHVbROwWb3E1xvckU15SwFH8iADSqNOfiteh5
	DWand3n5IsgoTMZmdAJEFXB1bqtYPfpRTqc7h/ZuNzHfjDWQkTrgno0XTXPo1A6qANTlFugpil1A4
	ekGj26VA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qQTWn-00G4ME-1y;
	Mon, 31 Jul 2023 14:05:41 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qQTWm-00G4Lv-1d;
	Mon, 31 Jul 2023 14:05:40 +0000
Date: Mon, 31 Jul 2023 07:05:40 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH] nvme: zns: limit max_zone_append by max_segments
Message-ID: <ZMe/tFLYy8xR9EWs@infradead.org>
References: <20230731114632.1429799-1-shinichiro.kawasaki@wdc.com>
 <ZMe7Gck9MSo8Fn+a@infradead.org>
 <2dea2a1c-b127-4661-c232-4dcf0b249878@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2dea2a1c-b127-4661-c232-4dcf0b249878@kernel.org>
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

On Mon, Jul 31, 2023 at 11:02:35PM +0900, Damien Le Moal wrote:
> > 
> > 	blk_queue_max_zone_append_sectors(q,
> > 		queue_max_sectors(q), ns->ctrl->max_zone_append);
> 
> blk_queue_max_zone_append_sectors() already does cap max zone append to
> max_hw_sectors.

Then we should not need this..

> We could also add the cap to queue_max_segments(q) <<
> PAGE_SECTORS_SHIFT in that function as well given that all zoned devices should
> have that anyway...

No.  That's a NVMe specific thing.  Most SCSI HBAs don't have this
issue.  NVMe devices supporting SGLs don't really have it either, but
for that we'd need to commit to always using SGLs for non-tiny I/O,
which we should probably be doing.

