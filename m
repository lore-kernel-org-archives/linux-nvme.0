Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4009E81BD1
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Feb 2026 14:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qWP2nHAeJacHVb6O6tSQOPKCO2pLR8lSvZnkYgFv/eU=; b=SfKFrWCkT+rpTtSmsA2/paeXmR
	JjnSXtrk9RuhFkvMWnwTu/dd3cYkiB+oRZ3b2k8FGndJOgAuD62yIxfP8EYmDQ+WvFUrPb+B30ZpL
	0m1wluc9f3ONxl8/fHTfevAYaGxbOt9yV4DGCdrxZZkBVswTFFsIfqljbpuAxWp4/YQG83pC0TAwD
	5pUQsefapTHdi3k/2aju8FDPeqxlu/Nv2N4tURpoPSHJyLi+pkZBh3MYAU/g1SIZ9xFSoXhsngcgt
	JU0M1VOnLmWBLk0mbeqmd7uky0//di/Qbgte2S1XKIDJNLcedWVUeyE6EX65uL+zIn9lUcMhpgMvV
	HTSQd6Hg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vpShl-0000000FYAN-4Ag2;
	Mon, 09 Feb 2026 14:57:37 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vpShi-0000000FY7r-1bNR;
	Mon, 09 Feb 2026 14:57:36 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 498C368CFE; Mon,  9 Feb 2026 15:57:22 +0100 (CET)
Date: Mon, 9 Feb 2026 15:57:21 +0100
From: Christoph Hellwig <hch@lst.de>
To: Yu Kuai <yukuai@fnnas.com>
Cc: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
	sven@kernel.org, j@jannau.net, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, tj@kernel.org, nilay@linux.ibm.com,
	ming.lei@redhat.com, neal@gompa.dev, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/4] nvme-rdma: move blk_mq_update_nr_hw_queues after
 nvme_unfreeze
Message-ID: <20260209145721.GA18315@lst.de>
References: <20260209082953.3053721-1-yukuai@fnnas.com> <20260209082953.3053721-2-yukuai@fnnas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260209082953.3053721-2-yukuai@fnnas.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260209_065734_639110_B01DC436 
X-CRM114-Status: GOOD (  14.11  )
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

On Mon, Feb 09, 2026 at 04:29:50PM +0800, Yu Kuai wrote:
> blk_mq_update_nr_hw_queues() freezes and unfreezes queues internally.
> When the queue is already frozen before this call, the freeze depth
> becomes 2. The internal unfreeze only decrements it to 1, leaving the
> queue still frozen when debugfs_create_files() is called.
> 
> This triggers WARN_ON_ONCE(q->mq_freeze_depth != 0) in
> debugfs_create_files() and risks deadlock.
> 
> Fix this by moving nvme_unfreeze() before blk_mq_update_nr_hw_queues()
> so the queue is unfrozen before the call, allowing the internal
> freeze/unfreeze to work correctly.

After this nothing is really protected by the frozen queue except
for unquiescing the I/O queues.  So we can probably eventually
drop it, but it might make sense to avoid that for now.

Reviewed-by: Christoph Hellwig <hch@lst.de>


