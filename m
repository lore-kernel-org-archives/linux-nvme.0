Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA62AC433EF
	for <linux-nvme@archiver.kernel.org>; Sat,  4 Dec 2021 10:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
	Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7xCeDoITMT2MiEuGfcfJOSHioleZsgJAHq0XZJkyrvo=; b=NycpU0LUbovHoSRy9R1AxqQTHu
	Cr7iq3VaBwl5mF3Oo7DACTLWaaA8qd9Z53poxQCMBZfuXBFHoLs9qdzW5kmNHT6fsqJCmvpyKPNLJ
	q2noqfty4LgRXtP5tfgF3pGmLw6UR2PzdBzKROFS7uRgpnnKqzEU8ium7TTNhzSlPdU0620H323PB
	dooBiKSg3JNuU3joTOl8iIMQ5QO6PK6tvfAJEkjO7yYtFCqI2XQcPKQMPTwl3gdOE3GE8PiKCrFYx
	0qfZ84LimIWfNzBIeQmw7S1jqKhht2N6XtqQ4QIfDMLB+A10kWQdCj+BMrq48zeMV7ZMtyk0auG6A
	Ovtdy1LA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mtSWM-000DQx-7S; Sat, 04 Dec 2021 10:43:58 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mtSWI-000DPb-VC
 for linux-nvme@lists.infradead.org; Sat, 04 Dec 2021 10:43:56 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 54AAD1FD33;
 Sat,  4 Dec 2021 10:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1638614631; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7xCeDoITMT2MiEuGfcfJOSHioleZsgJAHq0XZJkyrvo=;
 b=LPj1Ou1VIi8MWxDxhubextTKLBuTPXNqo27Ds4CoGAlDglPyjBfGPnwjQMifyYj3rtai8C
 wc2wM6uVdMETgluyrmMrgUC0VLQp1sBSrGqffeEldoEyVgmg2UFCTOhE7F/451oaUkxbVY
 78PTdaX/tklHjIDVQ3qqi9plybl5YgI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1638614631;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7xCeDoITMT2MiEuGfcfJOSHioleZsgJAHq0XZJkyrvo=;
 b=90i7YebLEpnEEEIM+Sd8DLOSeuxMa50D2mH0EswdTVLlDwwtmeuX6JXqub3ZwHI7jJy5A0
 tmDE3mcIyxvn3jCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 25B1E13BF8;
 Sat,  4 Dec 2021 10:43:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id YBAtCGdGq2HGagAAMHmgww
 (envelope-from <hare@suse.de>); Sat, 04 Dec 2021 10:43:51 +0000
Subject: Re: [PATCH 1/4] block: add mq_ops->queue_rqs hook
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <20211203214544.343460-1-axboe@kernel.dk>
 <20211203214544.343460-2-axboe@kernel.dk>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <2a3fb650-4b6e-9eb1-aa6b-318236717ccf@suse.de>
Date: Sat, 4 Dec 2021 11:43:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20211203214544.343460-2-axboe@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211204_024355_217506_2E531A4E 
X-CRM114-Status: GOOD (  25.51  )
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

On 12/3/21 10:45 PM, Jens Axboe wrote:
> If we have a list of requests in our plug list, send it to the driver in
> one go, if possible. The driver must set mq_ops->queue_rqs() to support
> this, if not the usual one-by-one path is used.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>   block/blk-mq.c         | 24 +++++++++++++++++++++---
>   include/linux/blk-mq.h |  8 ++++++++
>   2 files changed, 29 insertions(+), 3 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 22ec21aa0c22..9ac9174a2ba4 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2513,6 +2513,7 @@ void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
>   {
>   	struct blk_mq_hw_ctx *this_hctx;
>   	struct blk_mq_ctx *this_ctx;
> +	struct request *rq;
>   	unsigned int depth;
>   	LIST_HEAD(list);
>   
> @@ -2521,7 +2522,26 @@ void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
>   	plug->rq_count = 0;
>   
>   	if (!plug->multiple_queues && !plug->has_elevator && !from_schedule) {
> -		blk_mq_run_dispatch_ops(plug->mq_list->q,
> +		struct request_queue *q;
> +
> +		rq = plug->mq_list;
> +		q = rq->q;
> +
> +		/*
> +		 * Peek first request and see if we have a ->queue_rqs() hook.
> +		 * If we do, we can dispatch the whole plug list in one go. We
> +		 * already know at this point that all requests belong to the
> +		 * same queue, caller must ensure that's the case.
> +		 */
> +		if (q->mq_ops->queue_rqs &&
> +		    !(rq->mq_hctx->flags & BLK_MQ_F_TAG_QUEUE_SHARED)) {

What is the dependency on shared tags here?
 From what I've seen it's just about submitting requests; the only 
difference to shared tags is the way the tags are allocated.
Care to explain?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer

