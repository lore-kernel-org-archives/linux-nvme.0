Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C8E0C2BD05
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Jun 2024 09:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=w3M+xqiHVsLRWv+q0oA21UzkBuskfOH8bxd3bGy+CgE=; b=yFfxHqEATLOVor2rHHUPghOVHm
	o7/tlnhR4ZsOPmZ+w3/oJ+Jt+WgOtbQIga8EAVx6GZvtsGoQwXkr3ndJ3kHfduisE4jMaIReoBq3N
	aZ5VjK++AmYL2hYaIRJyJSY3Cv4KRvjtqtkNrShcT+LQQm00aKAIiqS4cWOekf6kWazRRascwBm/7
	9dmlWKbaFwX2ZjsAgjD/RrMyt26r0EANA8hVWNJ86TkZe0Dcu+m2OFLIGDeRjABRJVMuQwuqZJ9/r
	ufyFHgMcLgTZfRaFpzqNR12q4bx+i67IGqbK0Y6S2FkZPqErVQSXdPV12uutkaxAqg4whEvxNWOjl
	gGpQIHMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sLfZ9-0000000GARO-1fCt;
	Mon, 24 Jun 2024 09:00:47 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sLfZ3-0000000GAPz-3reL
	for linux-nvme@lists.infradead.org;
	Mon, 24 Jun 2024 09:00:45 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A44831F7C8;
	Mon, 24 Jun 2024 09:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719219639; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w3M+xqiHVsLRWv+q0oA21UzkBuskfOH8bxd3bGy+CgE=;
	b=k7Qk/8ShYPG+fcdLhpx3bcl8CQQhf00EixuPOB4iv6OCCnCQd7gcp++92E4Z9qVIPwG+ja
	z0P7ShT02tylVOT6os6EQhB5d9nw1VkTw1lCJnOyeyOEsrenofo3Y9L4HAnHYoD04koRpz
	dmSmU0F4NGBQW1P5s98Vuuv0U0qAuUU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719219639;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w3M+xqiHVsLRWv+q0oA21UzkBuskfOH8bxd3bGy+CgE=;
	b=jjiAQZrzj0zI0Jpk+uolyyMZU6YW6Z+l/YEn+heltlaX2PV0pJQ4wy7ZN5aKypV9OcQ9SH
	ZdsWCOwsyzA6NzBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="k7Qk/8Sh";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=jjiAQZrz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719219639; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w3M+xqiHVsLRWv+q0oA21UzkBuskfOH8bxd3bGy+CgE=;
	b=k7Qk/8ShYPG+fcdLhpx3bcl8CQQhf00EixuPOB4iv6OCCnCQd7gcp++92E4Z9qVIPwG+ja
	z0P7ShT02tylVOT6os6EQhB5d9nw1VkTw1lCJnOyeyOEsrenofo3Y9L4HAnHYoD04koRpz
	dmSmU0F4NGBQW1P5s98Vuuv0U0qAuUU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719219639;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w3M+xqiHVsLRWv+q0oA21UzkBuskfOH8bxd3bGy+CgE=;
	b=jjiAQZrzj0zI0Jpk+uolyyMZU6YW6Z+l/YEn+heltlaX2PV0pJQ4wy7ZN5aKypV9OcQ9SH
	ZdsWCOwsyzA6NzBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 983F313ACD;
	Mon, 24 Jun 2024 09:00:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5mUnJbc1eWY7HAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 24 Jun 2024 09:00:39 +0000
Date: Mon, 24 Jun 2024 11:00:39 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, 
	Sagi Grimberg <sagi@grimberg.me>, Thomas Gleixner <tglx@linutronix.de>, 
	Frederic Weisbecker <fweisbecker@suse.com>, Mel Gorman <mgorman@suse.de>, Hannes Reinecke <hare@suse.de>, 
	Sridhar Balaraman <sbalaraman@parallelwireless.com>, "brookxu.cn" <brookxu.cn@gmail.com>, 
	Ming Lei <ming.lei@redhat.com>, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/3] sched/isolation: Add io_queue housekeeping option
Message-ID: <sjna556zvxyyj6as5pk6bbgmdwoiybl4gubqnlrxyfdvhbnlma@ewka5cxxowr7>
References: <20240621-isolcpus-io-queues-v1-0-8b169bf41083@suse.de>
 <20240621-isolcpus-io-queues-v1-1-8b169bf41083@suse.de>
 <20240622051156.GA11303@lst.de>
 <x2mjbnluozxykdtqns47f37ssdkziovkdzchon5zkcadgkuuif@qloym5wjwomm>
 <20240624084705.GA20292@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240624084705.GA20292@lst.de>
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.dk,kernel.org,grimberg.me,linutronix.de,suse.com,suse.de,parallelwireless.com,gmail.com,redhat.com,vger.kernel.org,lists.infradead.org];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: A44831F7C8
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240624_020042_243424_7D861D59 
X-CRM114-Status: GOOD (  17.43  )
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

On Mon, Jun 24, 2024 at 10:47:05AM GMT, Christoph Hellwig wrote:
> > Do you think we should introduce a new type or just use the existing
> > managed_irq for this?
> 
> No idea really.  What was the reason for adding a new one?

I've added the new type so that the current behavior of spreading the
queues over to the isolated CPUs is still possible. I don't know if this
a valid use case or not. I just didn't wanted to kill this feature it
without having discussed it before.

But if we agree this doesn't really makes sense with isolcpus, then I
think we should use the managed_irq one as nvme-pci is using the managed
IRQ API.

