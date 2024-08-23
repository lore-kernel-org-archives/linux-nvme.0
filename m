Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21FE4C52D7C
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Aug 2024 06:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2EmLDIMd6Utauv9WBWnrM3YXCn86rvd0/CgbzeqV61s=; b=y9gPZz34RM164RLzOcmhniTDvH
	tXPkQ4Qw6SWYA9GTte7KJRqCxysfMPFvswNE0lO7uzHklgeNIjlf88qypm+JJ7osMS3GJk0mDSaiU
	3sDAkRmGg+taDL70rmau0qnT/4HPOHTLIOyMZlbSXpE3+kBFtB5nL07hkZu/Lyg1xeCWW38KJ+dJy
	dU+PI3VMihJ5ZKL/iekwU77FPVlN94FId7x6eWgxaGs7EsK6X2iLkVRb++E59EXUmbjoWMwiM1gVu
	BunDoc4u7jk5/j9mJxEfgyJIxZYMMDac0DZ+6EZL1bi3sJ7m2J+Hr+vq9JXQrNfCQrfRxF6r27QrV
	PM5JPdNw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shO3W-0000000FVkK-2kQT;
	Fri, 23 Aug 2024 06:45:54 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shO2k-0000000FVT3-0Uyu
	for linux-nvme@lists.infradead.org;
	Fri, 23 Aug 2024 06:45:09 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A9B17202D4;
	Fri, 23 Aug 2024 06:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724395502; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2EmLDIMd6Utauv9WBWnrM3YXCn86rvd0/CgbzeqV61s=;
	b=h3YQN7mFuDMNMiCEfFFcj/yFH8ikFHP5aDrl45bxYY8knxFTsMtoC+xY6O0oW5k4nMTFTP
	E5FJVwk3K3AexdG21AaflUMGFLvCtkAV5WZlMORJXvgSw8lbAtmvHBpNKdWRkpQ63Z/PKP
	l7uQ85HFtsLnTegTUMV51kT6WRGplBQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724395502;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2EmLDIMd6Utauv9WBWnrM3YXCn86rvd0/CgbzeqV61s=;
	b=qpfM+TJlX35F+FXzyinsCO4iolDtNKrj0MNi4vbveLbp9DS63gy8M/y+qRJ+zh7Sxu9UO+
	2OQycBAG/SrRRVDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=h3YQN7mF;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=qpfM+TJl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724395502; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2EmLDIMd6Utauv9WBWnrM3YXCn86rvd0/CgbzeqV61s=;
	b=h3YQN7mFuDMNMiCEfFFcj/yFH8ikFHP5aDrl45bxYY8knxFTsMtoC+xY6O0oW5k4nMTFTP
	E5FJVwk3K3AexdG21AaflUMGFLvCtkAV5WZlMORJXvgSw8lbAtmvHBpNKdWRkpQ63Z/PKP
	l7uQ85HFtsLnTegTUMV51kT6WRGplBQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724395502;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2EmLDIMd6Utauv9WBWnrM3YXCn86rvd0/CgbzeqV61s=;
	b=qpfM+TJlX35F+FXzyinsCO4iolDtNKrj0MNi4vbveLbp9DS63gy8M/y+qRJ+zh7Sxu9UO+
	2OQycBAG/SrRRVDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 57B291333E;
	Fri, 23 Aug 2024 06:45:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lW5cE+4vyGYlawAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 23 Aug 2024 06:45:02 +0000
Message-ID: <9de89e5a-04fc-4684-8514-b86884643a5d@suse.de>
Date: Fri, 23 Aug 2024 08:45:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: core: freeze multipath queue early in
 nvme_update_ns_info()
Content-Language: en-US
To: Martin Wilck <martin.wilck@suse.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>
Cc: Daniel Wagner <dwagner@suse.de>, Stuart Hayes <stuart.w.hayes@gmail.com>,
 linux-nvme@lists.infradead.org
References: <20240822201413.112268-1-mwilck@suse.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240822201413.112268-1-mwilck@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A9B17202D4
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
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.de,gmail.com,lists.infradead.org];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240822_234506_342667_7D0BD948 
X-CRM114-Status: GOOD (  14.63  )
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

On 8/22/24 22:14, Martin Wilck wrote:
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
>   drivers/nvme/host/core.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


