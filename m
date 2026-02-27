Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF7F0FD5307
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Feb 2026 07:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fyUxa9nDlaRndLSANamFyrxOUS552dD8cf4pJRT62ww=; b=rFmTEiEF6HDDT0tTHqpg9u5jeH
	3E0Sf21/8FdDnCM6gxVaaD+J/0qAsptkXglZG0D3iRSRsff5jihLV9r6LdKbijEirjSM/6tVnPW6R
	LcqsCN9zkPMibwBT/5Y9Qs0sElu1SBEU4fnGLK/2lg+ZQQ7Gne9K8DIxy9HJuKoXQTqpx4Ht3elHS
	XwjFP4d3Mw7mZKui5IiYMLSW7CgMx/ftAMnsyxP++M2DjFcsqB9UUwvtb2b6B9k0hQEKpRT4UlAvE
	9Tszxgr++IVkCXLQ8VM4Ln9bQZUF4NKMbhjcqMqVfD/9cX/RSunzd37q4K498QAxPa8ZRsUlxFnan
	/alZZKqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvsiM-00000007vFa-1oMA;
	Fri, 27 Feb 2026 07:56:46 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvsiK-00000007vEy-0WmH
	for linux-nvme@lists.infradead.org;
	Fri, 27 Feb 2026 07:56:45 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D06EE5BD5E;
	Fri, 27 Feb 2026 07:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772178999; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fyUxa9nDlaRndLSANamFyrxOUS552dD8cf4pJRT62ww=;
	b=anIH+pJxbiQXf/Til0aBlKalAOzuhANQ9s0xY+c3wak+rHsCjAX+9D99w/VOAkzSZsCynA
	IOwToNS89d9dypwcavoQIHaw/qLwEBXAxkAKCxCpYLyEwqnUIvXy/tMT1JGoXxMv1w71c2
	UUnt+T6iPdWWGKqkeadcgqQDUnK63Cc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772178999;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fyUxa9nDlaRndLSANamFyrxOUS552dD8cf4pJRT62ww=;
	b=1NUkLgbPiIv0P8LiJxRBN7t26+sTSaex509a+UXSyJrq3LpZHpDyN9zT8dSSyNt944E2jK
	ez2I9pADtEDRQOAg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=SvMVMsaR;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=1F3u3Fp0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772178998; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fyUxa9nDlaRndLSANamFyrxOUS552dD8cf4pJRT62ww=;
	b=SvMVMsaRPCQk4QpTGbtmTiNT+hYfg1ciznrN+ApyngfG2VwPoNirfz0k5JVYwKHuhhn+tP
	3YcBQkZslhQx8LzEtZhpoouhYHriCccs7cDIs2EzSArS54WAh/hBkjk7LssVtf3/phzJoE
	7/oRJ7xI8KMg2++DGw3DqY9zTxMr3QQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772178998;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fyUxa9nDlaRndLSANamFyrxOUS552dD8cf4pJRT62ww=;
	b=1F3u3Fp00PdutustvzT5pEz4cjtvxKaJY3Gkzqodfdb6ry/eGMxS7KWnvv0BKtFKmz7EbN
	IpHfy6ul0PWHcMBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BE7D33EA69;
	Fri, 27 Feb 2026 07:56:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6atDLTZOoWmPOAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Fri, 27 Feb 2026 07:56:38 +0000
Date: Fri, 27 Feb 2026 08:56:38 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, nilay@linux.ibm.com, 
	hare@suse.de, linux-nvme@lists.infradead.org
Subject: Re: [PATCH V3] nvme-tcp: teardown circular lockng fixes
Message-ID: <ec3cdaa2-1f39-4301-a0bb-846243c9d5da@flourine.local>
References: <20260226025658.86496-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226025658.86496-1-kch@nvidia.com>
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: D06EE5BD5E
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260226_235644_336982_DCECC010 
X-CRM114-Status: GOOD (  15.97  )
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

On Wed, Feb 25, 2026 at 06:56:58PM -0800, Chaitanya Kulkarni wrote:
> When a controller reset is triggered via sysfs (by writing to
> /sys/class/nvme/<nvmedev>/reset_controller), the reset work tears down
> and re-establishes all queues. The socket release using fput() defers
> the actual cleanup to task_work delayed_fput workqueue. This deferred
> cleanup can race with the subsequent queue re-allocation during reset,
> potentially leading to use-after-free or resource conflicts.
> 
> Replace fput() with __fput_sync() to ensure synchronous socket release,
> guaranteeing that all socket resources are fully cleaned up before the
> function returns. This prevents races during controller reset where
> new queue setup may begin before the old socket is fully released.
> 
> * Call chain during reset:
>   nvme_reset_ctrl_work()
>     -> nvme_tcp_teardown_ctrl()
>       -> nvme_tcp_teardown_io_queues()
>         -> nvme_tcp_free_io_queues()
>           -> nvme_tcp_free_queue()       <-- fput() -> __fput_sync()
>       -> nvme_tcp_teardown_admin_queue()
>         -> nvme_tcp_free_admin_queue()
>           -> nvme_tcp_free_queue()       <-- fput() -> __fput_sync()
>     -> nvme_tcp_setup_ctrl()             <-- race with deferred fput
> 
> memalloc_noreclaim_save() sets PF_MEMALLOC which is intended for tasks
> performing memory reclaim work that need reserve access. While PF_MEMALLOC
> prevents the task from entering direct reclaim (causing __need_reclaim() to
> return false), it does not strip __GFP_IO from gfp flags. The allocator can
> therefore still trigger writeback I/O when __GFP_IO remains set, which is
> unsafe when the caller holds block layer locks.
> 
> Switch to memalloc_noio_save() which sets PF_MEMALLOC_NOIO. This causes
> current_gfp_context() to strip __GFP_IO|__GFP_FS from every allocation in
> the scope, making it safe to allocate memory while holding elevator_lock and
> set->srcu.

I gave it a test run on my local machine with blktests and it passed.
But then, I was not able to reproduce first either.

Reviewed-by: Daniel Wagner <dwagner@suse.de>

