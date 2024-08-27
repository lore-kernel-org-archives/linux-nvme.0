Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 577D3C52D6F
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Aug 2024 07:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=L9dFbzEYxWKoUcCwJF4J+nGiF1ggPYNOzu9ZtTx5tZM=; b=GY4Rl8ffDyWx3Pid7E2L0pC1WM
	LZwvkP8Y5134tKJV58XcHttr6m8CkGzAnqHFF8CqN7J6oLNvwe4Np1bzuvlnNuYLsfaKuPavkosKt
	I9dQdd+vj8ZdSp/rQ+RsL9Hf0on6kYCmADpbs0Rtc7ghRaFeA3/JwsO00bIxrI6WmDLCYZ/UK2YA0
	kE4ipuS7tH79mn9oETF6NHDux40H+Ek74RcRGjgWgl2Q2E6Vzde9UMItwZecGvSOKCAE34bkbZufF
	WxvHxhSur5gEAsI3Wv2qN0+XEEP1BRkypzg//4KkdTaxKXgXAW5TPWpYFzq14FosvPqMQLmm0TL0U
	WegNtX3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1siqi7-0000000AEE6-3WFw;
	Tue, 27 Aug 2024 07:33:51 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1siqi2-0000000AEBR-242E
	for linux-nvme@lists.infradead.org;
	Tue, 27 Aug 2024 07:33:49 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 412DB21B09;
	Tue, 27 Aug 2024 07:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724744023; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L9dFbzEYxWKoUcCwJF4J+nGiF1ggPYNOzu9ZtTx5tZM=;
	b=F7mWJo8Nk7z1CLn4ne/oDR4ffZbYdq9m0iWqgfC2TccABQfAXhN+lEzhiiHOROAg/5Spht
	l+YNetPxbU/AiBZtl6sa+uRWPQVpOTe81L30xOAP0QKVz17zIOtRMDeRsdYr/YjiGHitUQ
	ABjZieQ4TGwcrdh4Vy+BXGXdMkwHTW0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724744023;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L9dFbzEYxWKoUcCwJF4J+nGiF1ggPYNOzu9ZtTx5tZM=;
	b=XdNFzVSvxhKvvZqW4Q09iwkoHx3t8lQuwisNnE5jMuKhrf2UVRt2ys0kmzHitgDvhTTxXW
	rj3TVwYI5DjlEoDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=F7mWJo8N;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=XdNFzVSv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724744023; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L9dFbzEYxWKoUcCwJF4J+nGiF1ggPYNOzu9ZtTx5tZM=;
	b=F7mWJo8Nk7z1CLn4ne/oDR4ffZbYdq9m0iWqgfC2TccABQfAXhN+lEzhiiHOROAg/5Spht
	l+YNetPxbU/AiBZtl6sa+uRWPQVpOTe81L30xOAP0QKVz17zIOtRMDeRsdYr/YjiGHitUQ
	ABjZieQ4TGwcrdh4Vy+BXGXdMkwHTW0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724744023;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L9dFbzEYxWKoUcCwJF4J+nGiF1ggPYNOzu9ZtTx5tZM=;
	b=XdNFzVSvxhKvvZqW4Q09iwkoHx3t8lQuwisNnE5jMuKhrf2UVRt2ys0kmzHitgDvhTTxXW
	rj3TVwYI5DjlEoDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E320313A44;
	Tue, 27 Aug 2024 07:33:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qHCtNVaBzWaPfAAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 27 Aug 2024 07:33:42 +0000
Message-ID: <b61564f5-2670-43eb-9af2-91f69620c8a0@suse.de>
Date: Tue, 27 Aug 2024 09:33:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nvme: core: shorten duration of multipath namespace
 rescan
Content-Language: en-US
To: Martin Wilck <martin.wilck@suse.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>
Cc: Niklas Cassel <cassel@kernel.org>, Daniel Wagner <dwagner@suse.de>,
 Stuart Hayes <stuart.w.hayes@gmail.com>, linux-nvme@lists.infradead.org,
 Martin Wilck <mwilck@suse.com>
References: <20240826142241.53601-1-mwilck@suse.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240826142241.53601-1-mwilck@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 412DB21B09
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,suse.de,gmail.com,lists.infradead.org,suse.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MID_RHS_MATCH_FROM(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:dkim,suse.de:mid,suse.com:email]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240827_003346_703592_7B2CEADD 
X-CRM114-Status: GOOD (  18.97  )
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

On 8/26/24 16:22, Martin Wilck wrote:
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
> v2: (all changes suggested by Sagi Grimberg)
>   - patch subject changed from "nvme: core: freeze multipath queue early in
>     nvme_update_ns_info()" to "nvme: core: shorten duration of multipath
>     namespace rescan"
>   - inserted comment explaining why blk_freeze_queue_start() is called early
>   - wait for queue to be frozen even if ret != 0
>   - make code structure more obvious vs. freeze_start / freeze_wait / unfreeze
> 
> Hannes and Daniel had already added Reviewed-by: tags to the v1 patch, but
> I didn't add them above, because the patch looks quite different now.
> 
> ---
>   drivers/nvme/host/core.c | 21 ++++++++++++++++-----
>   1 file changed, 16 insertions(+), 5 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


