Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 510DAC5472F
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Aug 2024 06:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LMQVxNlXbF712LsWa1qgWFyXCexfrV6PW7q0ZSWmjHs=; b=xiNPWfVIekts4bGhARCiQCr31R
	YZiiUoK1AJ8dUzalFl4pG/beb3cq/1zn5PadBCUeWNsoesQ5lgXDZLWiNUa94Z0Jf2FWn+QsPpexD
	8TWT4647E+cvY9bOQtjVNdObH0aKwEe6JKDMqa5HlxQ1mw9kQbagj0JtH3nOUIGWMFmrk9qdoe0mY
	yJMcNwmdlUZF13zsTCUnzVD5314RUx4S/yBlGxzSwsShmrjQZseCm51U/hEIOAZLxqp6rQSj+6PJi
	CHqw1MeqX1uyJ0KuZmDvKdO5f9/Yv4CDMJc10pCFO7ahqcU517Hr/Dq4SOY/kVRhDYAA+FBqO6Hn8
	b5WttCjw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1siply-0000000A1qs-2TQo;
	Tue, 27 Aug 2024 06:33:46 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1siplv-0000000A1pC-1AbC
	for linux-nvme@lists.infradead.org;
	Tue, 27 Aug 2024 06:33:45 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5EAB2227AB1; Tue, 27 Aug 2024 08:33:32 +0200 (CEST)
Date: Tue, 27 Aug 2024 08:33:32 +0200
From: Christoph Hellwig <hch@lst.de>
To: Martin Wilck <martin.wilck@suse.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Niklas Cassel <cassel@kernel.org>, Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>,
	Stuart Hayes <stuart.w.hayes@gmail.com>,
	linux-nvme@lists.infradead.org, Martin Wilck <mwilck@suse.com>
Subject: Re: [PATCH v3] nvme: core: shorten duration of multipath namespace
 rescan
Message-ID: <20240827063332.GA11773@lst.de>
References: <20240826163951.68078-1-mwilck@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826163951.68078-1-mwilck@suse.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240826_233343_489755_AA1BE113 
X-CRM114-Status: GOOD (  18.07  )
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

> +	/*
> +	 * The controller queue is going to be frozen in
> +	 * nvme_update_ns_info_{generic,block}(). Every freeze implies waiting
> +	 * for an RCU grace period to pass. For multipath devices, we
> +	 * need to freeze the multipath queue, too. Start freezing the
> +	 * multipath queue now, lest we need to wait for two grace periods.
> +	 */
> +	if (nvme_ns_head_multipath(ns->head))
> +		blk_freeze_queue_start(ns->head->disk->queue);

I really don't like how we keep this state around the calls into
the command set specific nvme_update_ns_info_* calls, and how it
feels very open coded.

And while looking at it, I think we might even want the multipath
queue frozen over the actual update as well, as there is no point
in sending the I/O even to other paths while we are updating the
information, as they'll probably fail.

Here is what might make sense:

 1) move the code past the csi switch statement in nvme_update_ns_info
    into a new nvme_update_ns_info_common helper and all that
    from nvme_update_ns_info_block and nvme_update_ns_info_generic.
    Maybe having another helper just for the multipath updates might
    also be worthwhile.
 2) add new nvme_freeze_ns helpers that freeze the ns and nshead
    queues and use those in nvme_update_ns_info_block and
    nvme_update_ns_info_generic over the entire update
 3) update these new helpers to use the trick from this patch to
    only require a single grace period.


