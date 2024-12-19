Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F06CBE77184
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Dec 2024 15:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7YJfQlySGqkADIe6C2FpqIGeFo+bGA1iN79AkPkxUCM=; b=KxSSKJGg/m9xkSYS+cZ8VBeOVK
	uhF+7KsHGQWixubyu4gNk+VhPwmJH+V3DEV3jEHJe2y+G6qPKfWnpLImMpUCZVB0yUKlG1rOQAWI1
	EJXn6rEmBKWDwX2oP5wAi/8bebGch5Bh9JQxwnrzOhF49nBrmdQ+V7c4oNt8RwhdZaNiBDeC8n/b0
	FweADsI1B+5zRbntWPvKwuBlDIncYDCoy9UGSywQHrHZphbrkTV39L0HQFDIVcGcZRBkR7CXByhlU
	yqc4kN375sa1enrjtshglugJ9IjcHrCD1oS2cEJqHshG7sOO8YF9+6VGMA1i6vnOImQhJB55i5TEt
	ttMk5VPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tOIto-00000002EOS-0hYy;
	Thu, 19 Dec 2024 15:57:16 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tOIbv-00000002Bjx-3kO6
	for linux-nvme@lists.infradead.org;
	Thu, 19 Dec 2024 15:38:49 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2DC081F392;
	Thu, 19 Dec 2024 15:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1734622724; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7YJfQlySGqkADIe6C2FpqIGeFo+bGA1iN79AkPkxUCM=;
	b=lIuIKLZ3tx9Tlasx+4eYis53arw0VaKm3Wb1cWvb25z+Dg8VMTHXyFLY9DQgh1izh5tKcn
	TgFWIX4sl7yYM3i8in2DGUM6Np6WDhTCk7CjE4/KBwwx/G63QhBgvaQWAY0k/qdhoLDev5
	MS3Z43ARDJrKXLuTjCXs6oSlJ8R9DXY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1734622724;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7YJfQlySGqkADIe6C2FpqIGeFo+bGA1iN79AkPkxUCM=;
	b=Awx86fPr/B1eNZPuzu33T8EOyLecp2Vl8kd0f176Ei8UGx0R6SiZf7ATaV3NDN+OTRnuaj
	32KyGSHHHdAli/Dg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=lIuIKLZ3;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Awx86fPr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1734622724; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7YJfQlySGqkADIe6C2FpqIGeFo+bGA1iN79AkPkxUCM=;
	b=lIuIKLZ3tx9Tlasx+4eYis53arw0VaKm3Wb1cWvb25z+Dg8VMTHXyFLY9DQgh1izh5tKcn
	TgFWIX4sl7yYM3i8in2DGUM6Np6WDhTCk7CjE4/KBwwx/G63QhBgvaQWAY0k/qdhoLDev5
	MS3Z43ARDJrKXLuTjCXs6oSlJ8R9DXY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1734622724;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7YJfQlySGqkADIe6C2FpqIGeFo+bGA1iN79AkPkxUCM=;
	b=Awx86fPr/B1eNZPuzu33T8EOyLecp2Vl8kd0f176Ei8UGx0R6SiZf7ATaV3NDN+OTRnuaj
	32KyGSHHHdAli/Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0E99513A77;
	Thu, 19 Dec 2024 15:38:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bzRPAwQ+ZGc2PgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Thu, 19 Dec 2024 15:38:44 +0000
Date: Thu, 19 Dec 2024 16:38:43 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Daniel Wagner <wagi@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Kashyap Desai <kashyap.desai@broadcom.com>, Sumit Saxena <sumit.saxena@broadcom.com>, 
	Shivasharan S <shivasharan.srikanteshwara@broadcom.com>, Chandrakanth patil <chandrakanth.patil@broadcom.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Nilesh Javali <njavali@marvell.com>, 
	GR-QLogic-Storage-Upstream@marvell.com, Don Brace <don.brace@microchip.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Costa Shulyupin <costa.shul@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, 
	Valentin Schneider <vschneid@redhat.com>, Waiman Long <llong@redhat.com>, 
	Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, Frederic Weisbecker <frederic@kernel.org>, 
	Mel Gorman <mgorman@suse.de>, Hannes Reinecke <hare@suse.de>, 
	Sridhar Balaraman <sbalaraman@parallelwireless.com>, "brookxu.cn" <brookxu.cn@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
	megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org, storagedev@microchip.com, 
	virtualization@lists.linux.dev
Subject: Re: [PATCH v4 8/9] blk-mq: use hk cpus only when
 isolcpus=managed_irq is enabled
Message-ID: <cc5e44dd-e1dc-4f24-88d9-ce45a8b0794f@flourine.local>
References: <20241217-isolcpus-io-queues-v4-0-5d355fbb1e14@kernel.org>
 <20241217-isolcpus-io-queues-v4-8-5d355fbb1e14@kernel.org>
 <Z2PlbL0XYTQ_LxTw@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z2PlbL0XYTQ_LxTw@fedora>
X-Rspamd-Queue-Id: 2DC081F392
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[39];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,kernel.dk,lst.de,grimberg.me,broadcom.com,oracle.com,marvell.com,microchip.com,redhat.com,linux.alibaba.com,linux-foundation.org,linutronix.de,suse.com,suse.de,parallelwireless.com,gmail.com,vger.kernel.org,lists.infradead.org,lists.linux.dev];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLy1uc785cwzda5mnrw36e8hj5)];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241219_073848_079827_3215C3D1 
X-CRM114-Status: GOOD (  16.85  )
X-Mailman-Approved-At: Thu, 19 Dec 2024 07:56:32 -0800
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

On Thu, Dec 19, 2024 at 05:20:44PM +0800, Ming Lei wrote:
> > +	cpumask_andnot(isol_mask,
> > +		       cpu_possible_mask,
> > +		       housekeeping_cpumask(HK_TYPE_MANAGED_IRQ));
> > +
> > +	for_each_cpu(cpu, isol_mask) {
> > +		qmap->mq_map[cpu] = qmap->queue_offset + queue;
> > +		queue = (queue + 1) % qmap->nr_queues;
> > +	}
> 
> Looks the IO hang issue in V3 isn't addressed yet, is it?
> 
> https://lore.kernel.org/linux-block/ZrtX4pzqwVUEgIPS@fedora/

I've added an explanation in the cover letter why this is not
addressed. From the cover letter:

I've experimented for a while and all solutions I came up were horrible
hacks (the hotpath needs to be touched) and I don't want to slow down all
other users (which are almost everyone). IMO, it's just not worth trying
to fix this corner case. If the user is using isolcpus and does CPU
hotplug, we can expect that the user can also first offline the isolated
CPUs. I've discussed this topic during ALPSS and the room came to the
same conclusion. Thus I just added a patch which issues a warning that
IOs are likely to hang.

