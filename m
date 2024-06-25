Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 901A1C2BBCA
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Jun 2024 08:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PgrnSv7iTsORqiBqIbgAFanma+OLSb36OJTxyTfWs8A=; b=M0eyYzwohSpuw5ViuYljgRXb6S
	9GdE+V6WnAADUe25/WCe6o2+BSFWKW8xnjv4GSBQiEckUq4itMpZPS+9TUykBCEcyoMs0tGY8ymEX
	IzELfsE6z/FHEFeCCaw/KzCM2hflGw5AmnlQoyNWwto/0FZ62Q8kre7VYMqAcOwtIxPdADTV1e05O
	N6UiOzUUPIneusg2mLmltsShD4jrJPRwOu6bM5ljaxITMVrFK1we3H8ctTEMeiXIJqszYwYGIGNee
	3djTCI6ir3HSUv+5KV3JrBgWIW3E5OI/GsaHycgKs6WIN2SZ8VbY+9v1TS48jIUp0IVFQU6rA7+Y2
	POcc+0tQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sM204-00000002C5A-067S;
	Tue, 25 Jun 2024 08:58:04 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sM1zt-00000002Bxt-3qH4
	for linux-nvme@lists.infradead.org;
	Tue, 25 Jun 2024 08:58:01 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E39CC1F7D3;
	Tue, 25 Jun 2024 08:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719305871; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PgrnSv7iTsORqiBqIbgAFanma+OLSb36OJTxyTfWs8A=;
	b=EvB9fFdkD+Sop+gsGm20VvTbFcL5U04T+3ULHB8KIUL95RbBbEApOMewpM2Xc8Z9zK6HQS
	vnrNa6FUw+e+1ew3LREZZaUJNo7BXVc2GBXiRMNBNfnX7rZfUW0+kdQPjqCDiKAt0R5ZdS
	PbpiaxpmL4dGGMkN4MX/ua2z6xf6md8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719305871;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PgrnSv7iTsORqiBqIbgAFanma+OLSb36OJTxyTfWs8A=;
	b=kJDBYi6xqWkn4x42bKVzxW2FGnKTdDUWAS4g4TG4+5w031jEP7umiactHn/TtywgGUqjXA
	35bOGL24O+zUdaAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719305870; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PgrnSv7iTsORqiBqIbgAFanma+OLSb36OJTxyTfWs8A=;
	b=lLGWY32yF5j0kwO7OBOonfkM6oIZB1LQW2hrc1oBvuf28zUkLAPHj9YfdoETurlqVKx8uB
	hjrntORUK2oSHu9nAE9xPwQ/Pv+72vDSD5oXsAy3KWjw0RCn2KjMzMsJmhEuw8pgMjygek
	mxtxTJq/6kr3+8jTKY4Bv+6/HEs7+/Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719305870;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PgrnSv7iTsORqiBqIbgAFanma+OLSb36OJTxyTfWs8A=;
	b=fCDG/Nxf5Riz7Jnv5fCpd+9O/F2i8/BTJ1xbRptUXcGq6fzEe+L71oCEXFo886mXYMVKJR
	SW7Reb6ZWhSXCaBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D3D391384C;
	Tue, 25 Jun 2024 08:57:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4RoVM46Gema8PQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 25 Jun 2024 08:57:50 +0000
Date: Tue, 25 Jun 2024 10:57:42 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>, 
	Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, 
	Sagi Grimberg <sagi@grimberg.me>, Frederic Weisbecker <fweisbecker@suse.com>, 
	Mel Gorman <mgorman@suse.de>, Sridhar Balaraman <sbalaraman@parallelwireless.com>, 
	"brookxu.cn" <brookxu.cn@gmail.com>, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-nvme@lists.infradead.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 1/3] sched/isolation: Add io_queue housekeeping option
Message-ID: <rk2ywo6y3ppki2gfogter2p2p2b556kmawqsuqrif3xcalsc2m@aosprmhypcav>
References: <20240621-isolcpus-io-queues-v1-0-8b169bf41083@suse.de>
 <20240621-isolcpus-io-queues-v1-1-8b169bf41083@suse.de>
 <20240622051156.GA11303@lst.de>
 <x2mjbnluozxykdtqns47f37ssdkziovkdzchon5zkcadgkuuif@qloym5wjwomm>
 <20240624084705.GA20292@lst.de>
 <sjna556zvxyyj6as5pk6bbgmdwoiybl4gubqnlrxyfdvhbnlma@ewka5cxxowr7>
 <55315fc9-4439-43b0-a4d2-89ab4ea598f0@suse.de>
 <878qyt7b65.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878qyt7b65.ffs@tglx>
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_TWO(0.00)[2];
	TAGGED_RCPT(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FREEMAIL_CC(0.00)[suse.de,lst.de,kernel.dk,kernel.org,grimberg.me,suse.com,parallelwireless.com,gmail.com,vger.kernel.org,lists.infradead.org,linutronix.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240625_015754_169792_1F035FFF 
X-CRM114-Status: GOOD (  29.83  )
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

On Tue, Jun 25, 2024 at 09:07:30AM GMT, Thomas Gleixner wrote:
> On Tue, Jun 25 2024 at 08:37, Hannes Reinecke wrote:
> > On 6/24/24 11:00, Daniel Wagner wrote:
> >> On Mon, Jun 24, 2024 at 10:47:05AM GMT, Christoph Hellwig wrote:
> >>>> Do you think we should introduce a new type or just use the existing
> >>>> managed_irq for this?
> >>>
> >>> No idea really.  What was the reason for adding a new one?
> >> 
> >> I've added the new type so that the current behavior of spreading the
> >> queues over to the isolated CPUs is still possible. I don't know if this
> >> a valid use case or not. I just didn't wanted to kill this feature it
> >> without having discussed it before.
> >> 
> >> But if we agree this doesn't really makes sense with isolcpus, then I
> >> think we should use the managed_irq one as nvme-pci is using the managed
> >> IRQ API.
> >> 
> > I'm in favour in expanding/modifying the managed irq case.
> > For managed irqs the driver will be running on the housekeeping CPUs 
> > only, and has no way of even installing irq handlers for the isolcpus.
> 
> Yes, that's preferred, but please double check with the people who
> introduced that in the first place.

The relevant code was added by Ming:

11ea68f553e2 ("genirq, sched/isolation: Isolate from handling managed
interrupts")

    [...] it can happen that a managed interrupt whose affinity
    mask contains both isolated and housekeeping CPUs is routed to an isolated
    CPU. As a consequence IO submitted on a housekeeping CPU causes interrupts
    on the isolated CPU.

    Add a new sub-parameter 'managed_irq' for 'isolcpus' and the corresponding
    logic in the interrupt affinity selection code.

    The subparameter indicates to the interrupt affinity selection logic that
    it should try to avoid the above scenario.
    [...]

From the commit message I read the original indent is that managed_irq
should avoid speading queues on isolcated CPUs.

Ming, do you agree to use the managed_irq mask to limit the queue
spreading on isolated CPUs? It would make the io_queue option obsolete.

