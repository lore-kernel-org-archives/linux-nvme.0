Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45972CAC581
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Sep 2025 17:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7vdPGiMJOfHCK+wdnKYTzBA4BaNmWPhjMcBBhnMYhGs=; b=XjZBRRZSKHDNKVwxh/MWLO4y6h
	hfzCR79z3wWC9kAHyAlKh4YB1yctoqCcgCl7HzEaQbePKWKP7r0AWVDJyq2G5m2r4z2daXL3NLsBP
	d6KiOJLVfNHCJdFytMIn709GQPly8w711hmWyN8mf620nUnT4xvNXDF++LEfnnivvGzlxFHfzoaP6
	e6gsnfgzjVeoPmZRwE+ncdKAJJfSfrSjuOi39X1aiQR6kWlGa284i/yg4ZEzdvwsRV8UJRJ89xpG9
	UxC/Zbe1hRFrO9suTvVCksS/16we+40qrHvce7QvaXvmalHMCxuLW7AZsA/ROZ6H7dBwIENV174EF
	wF+MhnCQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uvfMm-000000012RT-3vM9;
	Mon, 08 Sep 2025 17:09:21 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uvbQe-0000000HCcV-1R2F
	for linux-nvme@lists.infradead.org;
	Mon, 08 Sep 2025 12:57:05 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7963A16F50;
	Mon,  8 Sep 2025 12:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757336221; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7vdPGiMJOfHCK+wdnKYTzBA4BaNmWPhjMcBBhnMYhGs=;
	b=fDf8SQv2sIP/e0Mj308/WD1UXkPPuF8mumJ/W1XjvO1iGwAjiNhguXnoUVychBPU/GTcC2
	IN3JSakmXY2KGmb7a9vkfqeD/7Fz6sEjkkh8JDFpvAircCvJXMdAQ1HKJwRo04iINs7o8+
	BfX/i7kMim4OYb6Q8KejJIjGO6gqtvw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757336221;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7vdPGiMJOfHCK+wdnKYTzBA4BaNmWPhjMcBBhnMYhGs=;
	b=lGIXWnNJqzzOXhrhU0fntbrspLYZYcxr3aAGbN7CD0dWppz0oEFTZadR6doGvaOXoVyRqO
	414km+42EBImSsCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=fDf8SQv2;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=lGIXWnNJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757336221; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7vdPGiMJOfHCK+wdnKYTzBA4BaNmWPhjMcBBhnMYhGs=;
	b=fDf8SQv2sIP/e0Mj308/WD1UXkPPuF8mumJ/W1XjvO1iGwAjiNhguXnoUVychBPU/GTcC2
	IN3JSakmXY2KGmb7a9vkfqeD/7Fz6sEjkkh8JDFpvAircCvJXMdAQ1HKJwRo04iINs7o8+
	BfX/i7kMim4OYb6Q8KejJIjGO6gqtvw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757336221;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7vdPGiMJOfHCK+wdnKYTzBA4BaNmWPhjMcBBhnMYhGs=;
	b=lGIXWnNJqzzOXhrhU0fntbrspLYZYcxr3aAGbN7CD0dWppz0oEFTZadR6doGvaOXoVyRqO
	414km+42EBImSsCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4916C13946;
	Mon,  8 Sep 2025 12:57:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id j+NEEZ3SvmhhLQAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 08 Sep 2025 12:57:01 +0000
Message-ID: <1077309c-2e91-4f0d-b8a6-69d3f9d60cac@suse.de>
Date: Mon, 8 Sep 2025 14:57:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] nvme-core: do ioccsz/iorcsz validation only for
 I/O controllers
To: Kamaljit Singh <kamaljit.singh@opensource.wdc.com>, kbusch@kernel.org,
 axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: cassel@kernel.org, dlemoal@kernel.org, kamaljit.singh1@wdc.com
References: <20250905232550.1950307-1-kamaljit.singh@opensource.wdc.com>
 <20250905232550.1950307-3-kamaljit.singh@opensource.wdc.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250905232550.1950307-3-kamaljit.singh@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 7963A16F50
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250908_055704_523383_F326D518 
X-CRM114-Status: GOOD (  10.03  )
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

On 9/6/25 01:25, Kamaljit Singh wrote:
> An administrative controller does not support I/O queues, hence it
> should ignore existing checks for IOCCSZ/IORCSZ. Currently, these checks
> only exclude a discovery controller but need to also exclude an
> administrative controller.
> 
> Signed-off-by: Kamaljit Singh <kamaljit.singh@opensource.wdc.com>
> ---
>   drivers/nvme/host/core.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

