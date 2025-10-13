Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9973BCCD185
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Oct 2025 05:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XsH83EwB9fikMqFYJpo48022+QYpXTjVy7OSkiD2HSo=; b=xY3kHfItRMC6/eORgV1/TadNsI
	wCEW6jMeGsGw7vfUs0uk82yz769ej86u80u7O8KXRld94vqGvILMmYNlNJ9Iid3Iwwlt06eDoLoIk
	s/23GqAXOzx3sSYjFfregSVfe34UCu5wVmaK4rEUByPhE4br5vwB8JR46hMdfdO/2KZEk+kwQCyLF
	Sh8JNL2doKvQg4bxwK4XoJlxbBiWOpVvOd9svCPq3hYDS6OjkbHNHrqI9W1aHvf5s4YC6CKaO6CJk
	NnDLK9EL1qioPMmWbT4kZ5pAWVo9vwBEqn8ygiKKxiGFDj8r06X1sB3eJ4ID9Z1Ypb9vleTJttLj1
	n/RtqYbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8BVl-0000000CJM2-07M9;
	Mon, 13 Oct 2025 05:54:21 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8BVe-0000000CJL5-3gap
	for linux-nvme@lists.infradead.org;
	Mon, 13 Oct 2025 05:54:16 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 38611212AE;
	Mon, 13 Oct 2025 05:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1760334851; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XsH83EwB9fikMqFYJpo48022+QYpXTjVy7OSkiD2HSo=;
	b=urcE8ZPg+qu6cm+43dd0QwpRLASFT99ub9oC6nwUKmMn8T1rROOT4MI/0GlOETNr8gmL5R
	3kDoYgvJoiQOetVf/rxkn86c3pGVc+5PTnH7a6Rlrf5s7YKQrJb2VE6Q50zUDxzjjcevQg
	58v6rmPieHYXBZ/bGySHIGwJvzF3qG0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1760334851;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XsH83EwB9fikMqFYJpo48022+QYpXTjVy7OSkiD2HSo=;
	b=wzzLZ2FYp9jX03hGxDai6ypiorhK3m+wCKM18yXwBh4dhdBA3aVmglhjrDOokPZRTIkD/z
	VS5EbVYIKFCJ5xDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=urcE8ZPg;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=wzzLZ2FY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1760334851; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XsH83EwB9fikMqFYJpo48022+QYpXTjVy7OSkiD2HSo=;
	b=urcE8ZPg+qu6cm+43dd0QwpRLASFT99ub9oC6nwUKmMn8T1rROOT4MI/0GlOETNr8gmL5R
	3kDoYgvJoiQOetVf/rxkn86c3pGVc+5PTnH7a6Rlrf5s7YKQrJb2VE6Q50zUDxzjjcevQg
	58v6rmPieHYXBZ/bGySHIGwJvzF3qG0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1760334851;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XsH83EwB9fikMqFYJpo48022+QYpXTjVy7OSkiD2HSo=;
	b=wzzLZ2FYp9jX03hGxDai6ypiorhK3m+wCKM18yXwBh4dhdBA3aVmglhjrDOokPZRTIkD/z
	VS5EbVYIKFCJ5xDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EC5F01377F;
	Mon, 13 Oct 2025 05:54:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id baz8NwKU7GgaEwAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 13 Oct 2025 05:54:10 +0000
Message-ID: <3fb79f55-212f-4825-9d21-f48298af5742@suse.de>
Date: Mon, 13 Oct 2025 07:54:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCHv2 1/4] block: expose
 blk_stat_{enable,disable}_accounting() to drivers
To: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de, axboe@kernel.dk, dwagner@suse.de,
 gjoyce@ibm.com
References: <20251009100608.1699550-1-nilay@linux.ibm.com>
 <20251009100608.1699550-2-nilay@linux.ibm.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20251009100608.1699550-2-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 38611212AE
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251012_225415_069123_1E771FFD 
X-CRM114-Status: GOOD (  13.47  )
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

On 10/9/25 12:05, Nilay Shroff wrote:
> The functions blk_stat_enable_accounting() and
> blk_stat_disable_accounting() are currently exported, but their
> prototypes are only defined in a private header. Move these prototypes
> into a common header so that block drivers can directly use these APIs.
> 
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
>   block/blk-stat.h       | 4 ----
>   include/linux/blk-mq.h | 4 ++++
>   2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/block/blk-stat.h b/block/blk-stat.h
> index 9e05bf18d1be..f5d95dd8c0e9 100644
> --- a/block/blk-stat.h
> +++ b/block/blk-stat.h
> @@ -67,10 +67,6 @@ void blk_free_queue_stats(struct blk_queue_stats *);
>   
>   void blk_stat_add(struct request *rq, u64 now);
>   
> -/* record time/size info in request but not add a callback */
> -void blk_stat_enable_accounting(struct request_queue *q);
> -void blk_stat_disable_accounting(struct request_queue *q);
> -
>   /**
>    * blk_stat_alloc_callback() - Allocate a block statistics callback.
>    * @timer_fn: Timer callback function.
> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> index b25d12545f46..f647444643b8 100644
> --- a/include/linux/blk-mq.h
> +++ b/include/linux/blk-mq.h
> @@ -735,6 +735,10 @@ int blk_rq_poll(struct request *rq, struct io_comp_batch *iob,
>   
>   bool blk_mq_queue_inflight(struct request_queue *q);
>   
> +/* record time/size info in request but not add a callback */
> +void blk_stat_enable_accounting(struct request_queue *q);
> +void blk_stat_disable_accounting(struct request_queue *q);
> +
>   enum {
>   	/* return when out of requests */
>   	BLK_MQ_REQ_NOWAIT	= (__force blk_mq_req_flags_t)(1 << 0),

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

