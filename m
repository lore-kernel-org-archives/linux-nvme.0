Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BB02CA1013
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Sep 2025 07:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2kt0bkfBCX4wrrdHIj9tRfGJ0nD7CJveLxwSjj2aj/Q=; b=o6EmTfNngnX5y9ovcCqhTVHMZH
	X525NmYqe6GQkt+JdpsO5+Dc7imFP4SsQj9WRdITPrj+jzY9pfCZfFZ6sHdwieo0QBVXWH6yzn48v
	mWAYPy1V7OyIHqCWKSIO+XIcFev2nfW6nHfAScP+j6Ojb4jEegL4Kt0PIny+9XTRz0QOhR6aytzYS
	mVjp4qh1lA34dDnHyYBY/tk2qllru0r3UZyq2VOpLl3fp8gi496HZ4DX3nXZ5G2LCc/be0415KpWc
	vyb4caBV/gayp1oBa67A6kGo/P1jndAW4nLSiC2DCllEBicpBEoTYA2J0iQPi0wWjdR8z9tudNvOZ
	xbNxxVNw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uvWHc-0000000FHgg-1WP7;
	Mon, 08 Sep 2025 07:27:24 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uvWGQ-0000000FH4l-0ncW
	for linux-nvme@lists.infradead.org;
	Mon, 08 Sep 2025 07:26:13 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DABA1266D1;
	Mon,  8 Sep 2025 07:26:05 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C891B13869;
	Mon,  8 Sep 2025 07:26:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MUfxMA2FvmjiQQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 08 Sep 2025 07:26:05 +0000
Date: Mon, 8 Sep 2025 09:26:05 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Daniel Wagner <wagi@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Aaron Tomlin <atomlin@atomlin.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Costa Shulyupin <costa.shul@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, 
	Valentin Schneider <vschneid@redhat.com>, Waiman Long <llong@redhat.com>, Ming Lei <ming.lei@redhat.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Mel Gorman <mgorman@suse.de>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-nvme@lists.infradead.org, megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org, 
	storagedev@microchip.com, virtualization@lists.linux.dev, 
	GR-QLogic-Storage-Upstream@marvell.com
Subject: Re: [PATCH v8 10/12] blk-mq: use hk cpus only when isolcpus=io_queue
 is enabled
Message-ID: <d11a0c60-1b75-49ec-a2f8-7df402c4adf2@flourine.local>
References: <20250905-isolcpus-io-queues-v8-0-885984c5daca@kernel.org>
 <20250905-isolcpus-io-queues-v8-10-885984c5daca@kernel.org>
 <ff66801c-f261-411d-bbbf-b386e013d096@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff66801c-f261-411d-bbbf-b386e013d096@suse.de>
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: DABA1266D1
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250908_002610_384315_6F6CA6C1 
X-CRM114-Status: GOOD (  15.36  )
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

On Mon, Sep 08, 2025 at 08:13:31AM +0200, Hannes Reinecke wrote:
> >   const struct cpumask *blk_mq_online_queue_affinity(void)
> >   {
> > +	if (housekeeping_enabled(HK_TYPE_IO_QUEUE)) {
> > +		cpumask_and(&blk_hk_online_mask, cpu_online_mask,
> > +			    housekeeping_cpumask(HK_TYPE_IO_QUEUE));
> > +		return &blk_hk_online_mask;
> 
> Can you explain the use of 'blk_hk_online_mask'?
> Why is a static variable?

The blk_mq_*_queue_affinity helpers return a const struct cpumask *, the
caller doesn't need to free the return value. Because cpumask_and needs
store its result somewhere, I opted for the global static variable.

> To my untrained eye it's being recalculated every time one calls
> this function. And only the first invocation run on an empty mask,
> all subsequent ones see a populated mask.

The cpu_online_mask might change over time, it's not a static bitmap.
Thus it's necessary to update the blk_hk_online_mask. Doing some sort of
caching is certainly possible. Given that we have plenty of cpumask
logic operation in the cpu_group_evenly code path later, I am not so
sure this really makes a huge difference.

