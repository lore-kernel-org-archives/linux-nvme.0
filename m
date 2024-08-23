Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DCA8C52D7C
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Aug 2024 07:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pltypmgxPB2K5uBUdCjzbe3Q+mvmyhYKZQoUXbW2Qqk=; b=LgG1ZFYSImJn8Z6rZk4y2baeih
	ay/8AKb0bdL+KAtwKOUYBqXJlqCW2q2guhhT9NfzBlpICJFEpqdS4TBgOjmvvGRNu1oXEnh57I2lb
	2q5rrn8FEPqJ73FaeXWLuCi+EpRjS/ahaUEtt7Sf3VH3UN9CRmR9FEzofvvG1ZooiMaoOHRYnNMFB
	SL+IJCe/vbAebA3uMthq9VTTS1CMHEvUFkIjzxr/W4ymyxvOPaUKpLaipgWMREKkW9aR9vQ8Yrtac
	Z2uqDQhsY0k0wUCws++RNG2Gw2G/JdbsG5Z3Vg8YOrlxeI3FKqfO4LX0SDzQtk7bHwUEP0vTq7F4Z
	rmaP7oug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shOHn-0000000FYEm-2Uf1;
	Fri, 23 Aug 2024 07:00:39 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shOHi-0000000FYDo-0Hif
	for linux-nvme@lists.infradead.org;
	Fri, 23 Aug 2024 07:00:37 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 562EB22616;
	Fri, 23 Aug 2024 07:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724396432; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pltypmgxPB2K5uBUdCjzbe3Q+mvmyhYKZQoUXbW2Qqk=;
	b=O7xVqEs/G6KIkPg4eBhOXciNig4n6zg42W2njez97wCO+3gnQBKL2NHDkKoawdaB9yNe5S
	/FOdorrI5evrk4mWSdQUROEPuzeCiLJfPTxDfP9ysiv2Jh8ZyctK3rMnj1/VtnvKbloaUG
	Mb8mOyMls0TIr1giQrqzn3zUfwtY/Hw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724396432;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pltypmgxPB2K5uBUdCjzbe3Q+mvmyhYKZQoUXbW2Qqk=;
	b=8M/omMq1sxf4vGlOHNB/d21K52gZ31d/LlKOk/6EYTUdM4qd5LBMJIz3k6fit03gy66sMH
	4+EUg1VL+lWYCQCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="O7xVqEs/";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="8M/omMq1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724396432; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pltypmgxPB2K5uBUdCjzbe3Q+mvmyhYKZQoUXbW2Qqk=;
	b=O7xVqEs/G6KIkPg4eBhOXciNig4n6zg42W2njez97wCO+3gnQBKL2NHDkKoawdaB9yNe5S
	/FOdorrI5evrk4mWSdQUROEPuzeCiLJfPTxDfP9ysiv2Jh8ZyctK3rMnj1/VtnvKbloaUG
	Mb8mOyMls0TIr1giQrqzn3zUfwtY/Hw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724396432;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pltypmgxPB2K5uBUdCjzbe3Q+mvmyhYKZQoUXbW2Qqk=;
	b=8M/omMq1sxf4vGlOHNB/d21K52gZ31d/LlKOk/6EYTUdM4qd5LBMJIz3k6fit03gy66sMH
	4+EUg1VL+lWYCQCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3B5631333E;
	Fri, 23 Aug 2024 07:00:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZGgRDJAzyGbKbwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Fri, 23 Aug 2024 07:00:32 +0000
Date: Fri, 23 Aug 2024 09:00:31 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Martin Wilck <martin.wilck@suse.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>, 
	Stuart Hayes <stuart.w.hayes@gmail.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: core: freeze multipath queue early in
 nvme_update_ns_info()
Message-ID: <a92fa364-5d61-4680-b0fe-3381b8978aa6@flourine.local>
References: <20240822201413.112268-1-mwilck@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822201413.112268-1-mwilck@suse.com>
X-Rspamd-Queue-Id: 562EB22616
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[8];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,kernel.dk,lst.de,grimberg.me,suse.de,gmail.com,lists.infradead.org];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:email]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240823_000034_287463_A5F2B2E0 
X-CRM114-Status: GOOD (  13.21  )
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

On Thu, Aug 22, 2024 at 10:14:13PM GMT, Martin Wilck wrote:
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

Reviewed-by: Daniel Wagner <dwagner@suse.de>

