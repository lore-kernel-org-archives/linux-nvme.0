Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C6B3C7EE23
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Jun 2023 05:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RTeMpP6cNCb+PPKZCzluPVvWb8XHXpFmgPFJHAuRjc8=; b=OZoRZgXmgY5mFpDNA5JZQ9jon5
	SkENvgrwOa2PogL2CWgA/V9F4I2so9533NCu3BjxVnTcndkg4eUnbxvXWiHU/2XnK82lg8E9/GYw7
	g9dTzW5V4PKir4ydvXqo+rwJvPNVaq8GjHPA+06sRuFZOdQ9rzPuk1rxw7QYzbAhys/QzKLxLVLRi
	y5ieBAvOQ30LgYOLrsPpSZFKY2/yiYW7dylXRdhwINe7j33x32MEw2q2pKn9xv+vXOSObw/FMz6zX
	5TikIaUT8juE7Vao3JlV84fc6mlMJ2yNq+nhJFyMYjsjwZrH5wMgBOFgFJSnz4XvbPsh7KLS+Kf/w
	ycEzV8rQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q6lIC-004Mc3-0R;
	Wed, 07 Jun 2023 05:01:08 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q6lI6-004MZf-2s
	for linux-nvme@lists.infradead.org;
	Wed, 07 Jun 2023 05:01:06 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7F85768AA6; Wed,  7 Jun 2023 07:00:59 +0200 (CEST)
Date: Wed, 7 Jun 2023 07:00:59 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
	Amit.Engel@Dell.com, kbusch@kernel.org
Subject: Re: [PATCH] nvme: print disposition on err req completion
Message-ID: <20230607050059.GA19879@lst.de>
References: <20230605064933.46933-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230605064933.46933-1-kch@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230606_220105_034105_C5A746B3 
X-CRM114-Status: GOOD (  13.87  )
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

On Sun, Jun 04, 2023 at 11:49:33PM -0700, Chaitanya Kulkarni wrote:
> Currently we don't print disposition in the request completion path
> in nvme_complete_rq() tracepoint, so when request fails it is not
> straight forward to understand the diposition making it hard to debug
> the problems in the field.
> 
> Update nvme_complete_rq() tracepoint to print the disposition when
> request fails, since disposition value will always be 0 when request
> status = 0.

Hmm, not sure this is the right way to approach it.  I'd rather
redo how the trace points work by having a class and the ondividual
tracepoints in nvme_end_req/nvme_retry_req/nvme_failover_req.


