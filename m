Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 062D0C0218D
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Jan 2025 08:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=x0jTQ+AN6FO7s+VouLDU0ZKUKzLoR6NAwJXNSFSWOj4=; b=Vq9Ecz0FaFsTaQFCFFRqtjYYLC
	1PpjzeaAMB6OLj2YA5eKi26gSaR2e5Uo7Z9ZN/YXQYlgup55MXAyJoGEiySsUbPGVGV5sB7E84J8b
	oZc3/lWoAsr2SSvRoxuludm+oGG53I3kFErZE0xTi1vT2gM6qKeM7s889QqcMegfkLYZ/TH8ygygF
	XFGr4LNT6CrTuEbj+vmJUpP1tH/G6TcIFmmYuFIXi9VVqEOSgHt2iKnOqS8Jsiuq8kNpSiKDAQifz
	gTxnf1m8JIfqZkMQsv2NQ0fd/3F5WszkYTQCxQmfGQUGTwjRWuGhZFSh3TCJpyIcQyDrm4gTpGZrO
	gtSHh/FQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tbF4L-0000000EFbu-0kIB;
	Fri, 24 Jan 2025 08:29:37 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tbF4I-0000000EFaT-0wVx
	for linux-nvme@lists.infradead.org;
	Fri, 24 Jan 2025 08:29:35 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BFDED1F38C;
	Fri, 24 Jan 2025 08:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1737707372; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x0jTQ+AN6FO7s+VouLDU0ZKUKzLoR6NAwJXNSFSWOj4=;
	b=fw2iGdnn5Y+igY6aFwFk8BPiOLimyMsyFjUFYX4mOElbMmKJCOkcdbIQ1fxdiZZ0HBAiMw
	GddQk5jc+V58HLF1aMH+ozhxZRF9ME9C6OWFGIXyEOUFYd1WYZknMxF7y5B1mE7iSRC4Jh
	7YRymfw9IUlYat5dohy5C2hZjBsVNno=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1737707372;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x0jTQ+AN6FO7s+VouLDU0ZKUKzLoR6NAwJXNSFSWOj4=;
	b=K2z/jhB/qX8A0htMWOwWZML8CAG36FrN1/OoD/w2L/Z4yboLo97uYUb7N6MYgtUNqPYD7m
	gRnZxlmVf4dK26Aw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=fw2iGdnn;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="K2z/jhB/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1737707372; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x0jTQ+AN6FO7s+VouLDU0ZKUKzLoR6NAwJXNSFSWOj4=;
	b=fw2iGdnn5Y+igY6aFwFk8BPiOLimyMsyFjUFYX4mOElbMmKJCOkcdbIQ1fxdiZZ0HBAiMw
	GddQk5jc+V58HLF1aMH+ozhxZRF9ME9C6OWFGIXyEOUFYd1WYZknMxF7y5B1mE7iSRC4Jh
	7YRymfw9IUlYat5dohy5C2hZjBsVNno=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1737707372;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x0jTQ+AN6FO7s+VouLDU0ZKUKzLoR6NAwJXNSFSWOj4=;
	b=K2z/jhB/qX8A0htMWOwWZML8CAG36FrN1/OoD/w2L/Z4yboLo97uYUb7N6MYgtUNqPYD7m
	gRnZxlmVf4dK26Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8E2F1139CB;
	Fri, 24 Jan 2025 08:29:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Eux2IWxPk2dmcAAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 24 Jan 2025 08:29:32 +0000
Message-ID: <70dcbf7e-d8ef-41b8-8692-3dca2f350cec@suse.de>
Date: Fri, 24 Jan 2025 09:29:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-multipath: fix lockdep warning on shutdown
To: hare@kernel.org, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org
References: <20250124071439.106663-1-hare@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250124071439.106663-1-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BFDED1F38C
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250124_002934_421257_56403740 
X-CRM114-Status: GOOD (  13.52  )
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

On 1/24/25 08:14, hare@kernel.org wrote:
> From: Hannes Reinecke <hare@kernel.org>
> 
> During shutdown of multipath devices lockdep complained about a
> potential circular locking:
> 
> WARNING: possible circular locking dependency detected
> (udev-worker)/2792 is trying to acquire lock:
> ffff8881012a4348 ((wq_completion)kblockd){+.+.}-{0:0}, at: touch_wq_lockdep_map+0
> x26/0x90
> 
> but task is already holding lock:
> ffff88811e4b7cc8 (&disk->open_mutex){+.+.}-{4:4}, at: bdev_release+0x61/0x1a0
> which lock already depends on the new lock.
> 
> the existing dependency chain (in reverse order) is:
> -> #2 (&disk->open_mutex){+.+.}-{4:4}:
>          __mutex_lock+0xa5/0xe00
>         nvme_partition_scan_work+0x31/0x60
>          process_scheduled_works+0x37c/0x6f0
> -> #1 ((work_completion)(&head->partition_scan_work)){+.+.}-{0:0}:
>          process_scheduled_works+0x348/0x6f0
>          worker_thread+0x127/0x2a0
> -> #0 ((wq_completion)kblockd){+.+.}-{0:0}:
>          __lock_acquire+0x11f9/0x1790
>          lock_acquire+0x245/0x2d0
>          touch_wq_lockdep_map+0x3b/0x90
>          __flush_work+0x240/0x4b0
>          nvme_mpath_remove_disk+0x2b/0x50
>          nvme_free_ns_head+0x19/0x90
> 
> So the problem is that nvme_mpath_remove_disk() is called with the
> disk->open_mutex held, hence calling flush_work on partition_scan_work
> (which also will try to lock disk->open_mutex) will deadlock.
> Fix this by checking for NVME_NSHEAD_DISK_LIVE before trying to lock
> disk->open_mutex.
> 
> Fixes: 1f021341eef4 ("nvme-multipath: defer partition scanning")
> 
> Signed-off-by: Hannes Reinecke <hare@kernel.org>
> ---
>   block/blk-ioprio.c                |  6 ++++-
>   drivers/nvme/host/multipath.c     |  2 ++
>   drivers/nvme/target/core.c        | 42 +++++++++++++++----------------
>   drivers/nvme/target/io-cmd-bdev.c |  9 +++++++
>   4 files changed, 37 insertions(+), 22 deletions(-)
> 
Nice analysis, but wrong patch.

Please ignore.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

