Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83DF4C4345F
	for <linux-nvme@archiver.kernel.org>; Mon,  6 May 2024 05:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JM0BYCVtz2dby6hutGZvn144Ba9N41z3Ju+4SKU67Hk=; b=FHI+ZPeWm4evFCvzKbHGiTAdAA
	8dK9Y/NFc5tM8boGJrdRKRl/jKVkzby6MEz5rmUk2+zTR/X62UsO/BEmiA1NZ4sP6XdTi2Db8Bgag
	PHVirZnMWMsqznxKZEhpxPjPf1I5f2Kl6tazdUfxjQsq4sJzrvWVwQsBtG1zkj46rbbq+yYHnAX5d
	bfFKWPPLvvKunzBHaH0Xz8ey2ALXqJo0a3t2szoaGzPH9NIw3nrady543fWiZr1yivuo9Nni2KVDm
	sy61UidIdqOUrx9mhlp0XcIkCWjINxAgGqb/xhVgL4UN4twH5VO1jlkaz1Got7eaJGSCXqQ6snhja
	UQt9tDSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s3rF5-00000006DjW-1nSt;
	Mon, 06 May 2024 05:50:27 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s3rF2-00000006Dif-3AO9
	for linux-nvme@lists.infradead.org;
	Mon, 06 May 2024 05:50:26 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id F214768AFE; Mon,  6 May 2024 07:50:20 +0200 (CEST)
Date: Mon, 6 May 2024 07:50:20 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH] nvmet-rdma: Avoid o(n^2) loop in delete_ctrl
Message-ID: <20240506055020.GA5059@lst.de>
References: <20240505103944.52275-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240505103944.52275-1-sagi@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240505_225024_958079_AD8B076F 
X-CRM114-Status: GOOD (  16.61  )
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

On Sun, May 05, 2024 at 01:39:44PM +0300, Sagi Grimberg wrote:
> From: Sagi Grimberg <sagi.grimberg@vastdata.com>
> 
> When deleting a nvmet-rdma ctrl, we essentially loop over all
> queues that belong to the controller and schedule a removal of
> each. Instead of restarting the loop every time a queue is found,
> do a simple safe list traversal.
> 
> This addresses an unneeded time spent scheduling queue removal in
> cases there a lot of queues.

I think the original reason for this was to avoid lock order dependencies
and/or deadlocks, I wish I would have documented that better.  Looking at
the current version __nvmet_rdma_queue_disconnect I can't find any
obvious problem, but rdma_disconnect is a bit of a block box from
the driver POV.  Did you test this extensively with lockdep enabled?

> +	list_for_each_entry_safe(queue, tmp, &nvmet_rdma_queue_list, queue_list) {

Nit: overly long line here.  Maybe just rename tmp to n?


