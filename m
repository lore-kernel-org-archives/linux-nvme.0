Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 238F1C83F03
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Jul 2025 10:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5woB+8MxyV3T68ceBaY+75z4ul70wqMhMKbKCDmKZjU=; b=pDi/NPwLso1z6f5S7rimTm/aMG
	t+RvN7EHWNOLAohyr4t5AG1raYPSWHhfvayPnB5SoV/mbuBD597EaESnhjqN0zNWr+oHKXGa+Ti4X
	mSfNlRP0cMpDJ6ROjWFc2ndf9TH04DA58Y/11YAuxWfxVWUXl6ijoC2c0Hx8iUBdWy4J9i08LqmCI
	UVe9QcEro7VUjM8vpe76R2TgOZ6TmCoeWxowinjB2i1DEGGUEZ29htSyOR8Q856OdsZ0RaNrxaib5
	mx9Ox9Nzai9c49euN61EB5aop5hpbtNp3nRV1ynIXw4bOb6E3JfcCfzC/dZFRLGSg9xfbvH4krdNv
	QaeteX4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXduP-0000000E6se-1DNk;
	Fri, 04 Jul 2025 10:44:45 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXccH-0000000DuxR-0Z9X
	for linux-nvme@lists.infradead.org;
	Fri, 04 Jul 2025 09:21:58 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BCE311F38A;
	Fri,  4 Jul 2025 09:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1751620915; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5woB+8MxyV3T68ceBaY+75z4ul70wqMhMKbKCDmKZjU=;
	b=EmN0pxRpVaMhBUAUzucq+7X8P5sBGednjqHNm/DekL6I4UTrQUWZqrXtT+YRZBIE9Patk3
	97gTEQQGn9T0Nt+aFuQi1ufCDZtdg0r7YwNLTmGdEZ71zzdSJ5yxG4brG5wCizsg6KrdwG
	+hOjEgp4+xVFcHEczQMddymwrvWFlbU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1751620915;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5woB+8MxyV3T68ceBaY+75z4ul70wqMhMKbKCDmKZjU=;
	b=n2F5+5fcHOhQjLZpkaEFHKb4ePyf0CSogZTYDmloS5tzHhbF+ezlzohMClPPfi+TpHwAHq
	2clJgihwaiTFD7BA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=R+MyKEol;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=7j4T0NGp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1751620914; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5woB+8MxyV3T68ceBaY+75z4ul70wqMhMKbKCDmKZjU=;
	b=R+MyKEolL2LbDXKCXiZ9deuHSz+B1/cUbwJSF54ooogriCF0jUt4L2fiVpNQAwJJSi5Pne
	3DA7yJ1VPgfqpJzyY4nceHitGg7mJ+Yz617XJTxDSqTPMhbxeLc7WdPIzLjt6+dDwRILZ5
	qstDfAAzHm/7vhb5vfuOHmAUGsMVaNw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1751620914;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5woB+8MxyV3T68ceBaY+75z4ul70wqMhMKbKCDmKZjU=;
	b=7j4T0NGp7d7ugWNlrR0LYzq/FmEk3EP0/J6G+zNKlNcRDyyBajNb484cY4vyWkysycIygm
	WZAyCIvA0IAqtwBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9471F13757;
	Fri,  4 Jul 2025 09:21:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ooQ9JDKdZ2gbJAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Fri, 04 Jul 2025 09:21:54 +0000
Date: Fri, 4 Jul 2025 11:21:49 +0200
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
Subject: Re: [PATCH v7 08/10] blk-mq: use hk cpus only when isolcpus=io_queue
 is enabled
Message-ID: <e2e62f99-164d-4e80-be1e-9affa724efd0@flourine.local>
References: <20250702-isolcpus-io-queues-v7-0-557aa7eacce4@kernel.org>
 <20250702-isolcpus-io-queues-v7-8-557aa7eacce4@kernel.org>
 <9025c412-9b6f-4714-a880-e8e6084e1b4c@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9025c412-9b6f-4714-a880-e8e6084e1b4c@suse.de>
X-Rspamd-Queue-Id: BCE311F38A
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	TO_DN_SOME(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RL71uuc3g3e76oxfn4mu5aogan)];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,flourine.local:mid];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250704_022157_325972_C4852520 
X-CRM114-Status: GOOD (  30.83  )
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

On Thu, Jul 03, 2025 at 08:58:02AM +0200, Hannes Reinecke wrote:
> > +	for (queue = 0; queue < qmap->nr_queues; queue++) {
> > +		unsigned int idx = (qmap->queue_offset + queue) % nr_masks;
> > +
> > +		for_each_cpu(cpu, &hk_masks[idx]) {
> > +			qmap->mq_map[cpu] = idx;
> > +
> > +			if (cpu_online(cpu))
> > +				cpumask_set_cpu(qmap->mq_map[cpu], active_hctx);
> 
> Why cpu_online? Up until this point it really didn't matter if the affinity
> mask was set to 'online' or 'possible' cpus, but here you
> require CPUs to be online...

This part here tracks if the a hardware context has at least one
housekeeping CPU online. It is possible to provide configuration where
we end up with hardware context which have offline housekeeping CPUs and
online isolcpus. active_hctx tracks which of the hardware contexts is
usable which is used in the next step...

> > +		}
> > +	}
> > +
> > +	/* Map isolcpus to hardware context */
> > +	queue = cpumask_first(active_hctx);
> > +	for_each_cpu_andnot(cpu, cpu_possible_mask, mask) {
> > +		qmap->mq_map[cpu] = (qmap->queue_offset + queue) % nr_masks;
> > +		queue = cpumask_next_wrap(queue, active_hctx);
> > +	}
> 
> Really? Doesn't this map _all_ cpus, and not just the isolcpus?

for_each_cpu iterates over is all CPUs which are not houskeeping CPUs
(mask is the housekeeping mask), thus these are all isol CPU. Note the
'andnot' part.

The cpumask_first/cpumask_next_wrap returns only hardware context which
have at least one housekeeping CPU which is online. Yes, it possible to
make this a bit smarter, so that we keep the grouping of the offline
CPUs intact, though I am not sure if it is worth to add complexity for a
corner case at least not yet.

> > +fallback:
> > +	/*
> > +	 * Map all CPUs to the first hctx to ensure at least one online
> > +	 * housekeeping CPU is serving it.
> > +	 */
> > +	for_each_possible_cpu(cpu)
> > +		qmap->mq_map[cpu] = 0;
> 
> I think you need to map all hctx, no?

The block layer is filtering out hctx which have no CPU assigned to it
when selecting a queue. This is really a failsafe mode, it just makes
sure the system boots.

> > +	/* Map housekeeping CPUs to a hctx */
> > +	for (queue = 0; queue < qmap->nr_queues; queue++) {
> > +		for_each_cpu(cpu, dev->bus->irq_get_affinity(dev, offset + queue)) {
> > +			qmap->mq_map[cpu] = qmap->queue_offset + queue;
> > +
> > +			cpumask_set_cpu(cpu, mask);
> > +			if (cpu_online(cpu))
> > +				cpumask_set_cpu(qmap->mq_map[cpu], active_hctx);
> 
> Now that is really curious. You pick up the interrupt affinity from the
> 'bus', which, I assume, is the PCI bus. And this would imply that the
> bus can (or already is) programmed for this interrupt affinity.

Yes, this is the case. irq_create_affinity_masks which use
group_cpu_evenly/group_mask_cpu_evenly for the number of requested IRQs.
The number of IRQs can be higher than the number of requested queues
here. It's necessary to use the affinity mask created by
irq_create_affinity_mask as input.

> Which would imply that this is a usable interrupt affinity from the
> hardware perspective, irrespective on whether the cpu is online or
> not. So why the check to cpu_online()? Can't we simply take the existing affinity
> and rely on the hardware to do the right thing?

Again, this is tracking if a htcx has online housekeeping CPU.

