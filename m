Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77347C2BD05
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Jun 2024 08:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=juuEuxMZbChHNv99fYDrEi4X39+0Oh2xhBu6++WA8z8=; b=ZMX1wDgpE1kVxr5Y9gqyIK271M
	dYiPP/M6ht3dSuiSNZ3/feBPperxH4k3XmdDlUZYneE8Asl37K1p0i4X7hq9RC4FBR8B6DVl41t1z
	2l90q2irPWyvGxAI53LooR+kQhJqA5CtvfDaPOz88kNUmqIiyojggNlb/kqzG1eEC8wNXujDhpoZ0
	vuBxd/KawuijirZBpFLe9vipdH9V1OK4zxoIveWSzct8ZTaZAHEQp7JrKY6OUAoPbZ0g1CMuzoCjr
	b+SiEXvcxNjC6L8JOjV698WRCHWQRBKadHE4w0ePMwQpxFG/MsuygO2SBACWEIac4X4uxRAK+RIY0
	ohRnLytg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sLfLz-0000000G6lu-493H;
	Mon, 24 Jun 2024 08:47:11 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sLfLw-0000000G6l8-2NR2
	for linux-nvme@lists.infradead.org;
	Mon, 24 Jun 2024 08:47:10 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id DDE1068B05; Mon, 24 Jun 2024 10:47:05 +0200 (CEST)
Date: Mon, 24 Jun 2024 10:47:05 +0200
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <dwagner@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Thomas Gleixner <tglx@linutronix.de>,
	Frederic Weisbecker <fweisbecker@suse.com>,
	Mel Gorman <mgorman@suse.de>, Hannes Reinecke <hare@suse.de>,
	Sridhar Balaraman <sbalaraman@parallelwireless.com>,
	"brookxu.cn" <brookxu.cn@gmail.com>, Ming Lei <ming.lei@redhat.com>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/3] sched/isolation: Add io_queue housekeeping option
Message-ID: <20240624084705.GA20292@lst.de>
References: <20240621-isolcpus-io-queues-v1-0-8b169bf41083@suse.de> <20240621-isolcpus-io-queues-v1-1-8b169bf41083@suse.de> <20240622051156.GA11303@lst.de> <x2mjbnluozxykdtqns47f37ssdkziovkdzchon5zkcadgkuuif@qloym5wjwomm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <x2mjbnluozxykdtqns47f37ssdkziovkdzchon5zkcadgkuuif@qloym5wjwomm>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240624_014708_771544_4AAD6547 
X-CRM114-Status: GOOD (  19.53  )
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

On Mon, Jun 24, 2024 at 09:13:06AM +0200, Daniel Wagner wrote:
> On Sat, Jun 22, 2024 at 07:11:57AM GMT, Christoph Hellwig wrote:
> > > diff --git a/include/linux/sched/isolation.h b/include/linux/sched/isolation.h
> > > index 2b461129d1fa..fe751d704e99 100644
> > > --- a/include/linux/sched/isolation.h
> > > +++ b/include/linux/sched/isolation.h
> > > @@ -16,6 +16,7 @@ enum hk_type {
> > >  	HK_TYPE_WQ,
> > >  	HK_TYPE_MANAGED_IRQ,
> > >  	HK_TYPE_KTHREAD,
> > > +	HK_TYPE_IO_QUEUE,
> > >  	HK_TYPE_MAX
> > >  };
> > 
> > It might be a good time to write comments explaining these types?
> 
> Sure, will do.
> 
> Do you think we should introduce a new type or just use the existing
> managed_irq for this?

No idea really.  What was the reason for adding a new one?  The best
person to comment on this is probably Thomas.

