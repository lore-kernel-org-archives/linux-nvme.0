Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB22FC52D7C
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Aug 2024 13:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eOyOPvg2k0pZGfSAYtCzkIasI6ZuH0HZANlU989amc4=; b=rjWzT6Lv1ilOpTBumcXI4zM8hx
	GIUCsqLvXJut4wDdR3h4HlYcJaUJAnPGuFQ9QvmPGpO+icj78Re1tRyU9F5MgdouZBJzuj3khKTdJ
	7taG4rnz0fYmSN6umel3fZ9eLPiuTSUdxSCSjNLSsExx9mioPYsJnExyXObjDz9bv98IC2UFZmptK
	+SmWpdKiTc7VRzG24lvjANRLiz0C1bJGgvCfbu1OR89taeh9ARm3z7K67S+EAXyfwtvRIzuMUJ6xx
	6YNIVYqU9BLJag+FxN9Mm7xYpzAxO4Yatkf9weW7HOTljpfv6HBG+Uot+3LGiTy3Gqo+29sDzrE0q
	NTBUcF3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shUVw-0000000GuKy-3AKE;
	Fri, 23 Aug 2024 13:39:40 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shUV8-0000000GuDD-11ys
	for linux-nvme@lists.infradead.org;
	Fri, 23 Aug 2024 13:38:51 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 4F8C9A4010C;
	Fri, 23 Aug 2024 13:38:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F582C4AF0E;
	Fri, 23 Aug 2024 13:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724420328;
	bh=eZRfAPeiSKk9q/LRvS2AwwKZZAstqRcktOfp9+mY5u0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nMqYjgwROMQqO0VnYhCwuxaDXqj/+GYao9n9r+otd9L7aA9Psa64GYRH8nBoRskZY
	 vPKTVtyLtlc/j6we+KdWlCzKHzS4neSHK3aDhc/qc3S/a4d822PbN4NXnoCRQpnNM+
	 KVKkFAt9WgX0WADe2vT75PhUKZygEcYHdjEzLek2GrM4UzTiTlx/0z846t1dtwbmXW
	 9eUOTsbYT+RxaAeoaGhLPiJJF71+FiL1MTy3CyoWjValijzfLXZfJRIxv3U/yTr9Tc
	 ihruESeWC46vXxJdMC5fUSlk4WYRHozeaC10pRx4fMD45Amwq8oP08ZEUdW7tHh/gf
	 AxCUbloXKTfcg==
Date: Fri, 23 Aug 2024 15:38:43 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Martin Wilck <martin.wilck@suse.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>,
	Stuart Hayes <stuart.w.hayes@gmail.com>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: core: freeze multipath queue early in
 nvme_update_ns_info()
Message-ID: <ZsiQ4yCji0PexMQ-@ryzen.lan>
References: <20240822201413.112268-1-mwilck@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822201413.112268-1-mwilck@suse.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240823_063850_392258_6AEB857D 
X-CRM114-Status: GOOD (  21.49  )
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

On Thu, Aug 22, 2024 at 10:14:13PM +0200, Martin Wilck wrote:
> For multipath devices, nvme_update_ns_info() needs to freeze both
> the queue of the path and the queue of the multipath device. For
> both operations, it waits for one RCU grace period to pass, ~25ms
> on my test system. By calling blk_freeze_queue_start() for the
> multipath queue early, we avoid waiting twice; tests using ftrace
> have shown that the second blk_mq_freeze_queue_wait() call finishes
> in just a few microseconds. The path queue is unfrozen before
> calling blk_mq_freeze_queue_wait() on the multipath queue, so that
> possibly outstanding IO in the multipath queue can be flushed.
> 
> I tested this using the "controller rescan under I/O load" test
> I submitted recently [1].
> 
> [1] https://lore.kernel.org/linux-nvme/20240822193814.106111-3-mwilck@suse.com/T/#u
> 
> Signed-off-by: Martin Wilck <mwilck@suse.com>
> ---
>  drivers/nvme/host/core.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 33fa01c599ad..e2454398c660 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2217,6 +2217,9 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_ns_info *info)
>  	bool unsupported = false;
>  	int ret;
>  
> +	if (nvme_ns_head_multipath(ns->head))
> +		blk_freeze_queue_start(ns->head->disk->queue);
> +

From someone reading this code, it looks quite similar to
nvme_mpath_start_freeze().

Perhaps create a new helper, with proper kdoc, and possibly also add kdoc to
nvme_mpath_start_freeze(), so that a user can easily tell (from the kdoc)
when to use which function.


Kind regards,
Niklas

