Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96642C02181
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Jan 2025 13:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QF1VONKnn8WOI8uNOYuFK4FFaffVTqc2ME1cDMhaWJo=; b=EGubplQPpHGVaGJsojnubwfeMa
	NVSRex+aqTEESuYt+KnZgaWmg2r+B0VwvOXlNo2hKMjGedLSewJrMvyFA3LWAOhuWIVUP4ydDqBHT
	HgWDMQPtcc0JUzTrYxSyGc9mTH7YB0Yf6LqI0QGjFU73Vj14t/dkiuf3bBhFKjNg50mqqp4SChHc7
	J3+skyK9PvxcF/1GH9L1X5wKi6tXvjGvzuVZPztiQjnWpvMkhXGu4GxY741u7ReFBNAQetEHHus9c
	GAEvWQNjHGVF9uXRe3Bymg/cwZi77UzzpET+VrnTkVpp3hZq/VlZN2hvAJ2G5gq6LSQpsx8m7xdFn
	L34G0atQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tZs6F-00000005hFC-2ykF;
	Mon, 20 Jan 2025 13:45:55 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tZs69-00000005hAu-1pI0
	for linux-nvme@lists.infradead.org;
	Mon, 20 Jan 2025 13:45:50 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7002C2117E;
	Mon, 20 Jan 2025 13:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1737380746; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QF1VONKnn8WOI8uNOYuFK4FFaffVTqc2ME1cDMhaWJo=;
	b=Axp/DLS6ufjFiiSl70ONlqqWfFr6hYHP2oliF0dEfM7bgJwmQgcjNkWkF3+3EcGVLero25
	nlhjGycmwhsjfnJNJN3DJrXanMy6iXNLn7s2LjtcRTjxcW5vszLQFZW7TjwjluX/+bXiUy
	iJ4K0mBxGDXubxNp/B+dr3KKWFcqf9A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1737380746;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QF1VONKnn8WOI8uNOYuFK4FFaffVTqc2ME1cDMhaWJo=;
	b=dkutcqHhoK3gP03pc9UC0OG0fo8QTyMYnjYUl+G/A4DAVUoE+OcNdqs2mJozVhk/KMjSXB
	JeqDiFpkXQ5pqqCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1737380746; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QF1VONKnn8WOI8uNOYuFK4FFaffVTqc2ME1cDMhaWJo=;
	b=Axp/DLS6ufjFiiSl70ONlqqWfFr6hYHP2oliF0dEfM7bgJwmQgcjNkWkF3+3EcGVLero25
	nlhjGycmwhsjfnJNJN3DJrXanMy6iXNLn7s2LjtcRTjxcW5vszLQFZW7TjwjluX/+bXiUy
	iJ4K0mBxGDXubxNp/B+dr3KKWFcqf9A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1737380746;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QF1VONKnn8WOI8uNOYuFK4FFaffVTqc2ME1cDMhaWJo=;
	b=dkutcqHhoK3gP03pc9UC0OG0fo8QTyMYnjYUl+G/A4DAVUoE+OcNdqs2mJozVhk/KMjSXB
	JeqDiFpkXQ5pqqCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 587941393E;
	Mon, 20 Jan 2025 13:45:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3YMIFYpTjmeAGgAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 20 Jan 2025 13:45:46 +0000
Message-ID: <cab2575c-037d-4d9d-896c-3bd2c64c9a0b@suse.de>
Date: Mon, 20 Jan 2025 14:45:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] nvme-fc: do not ignore connectivity loss during
 connecting
To: Daniel Wagner <wagi@kernel.org>, James Smart <james.smart@broadcom.com>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Paul Ely <paul.ely@broadcom.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250109-nvme-fc-handle-com-lost-v4-0-fe5cae17b492@kernel.org>
 <20250109-nvme-fc-handle-com-lost-v4-3-fe5cae17b492@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250109-nvme-fc-handle-com-lost-v4-3-fe5cae17b492@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250120_054549_639428_F5590603 
X-CRM114-Status: GOOD (  29.61  )
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

On 1/9/25 14:30, Daniel Wagner wrote:
> When a connectivity loss occurs while nvme_fc_create_assocation is
> being executed, it's possible that the ctrl ends up stuck in the LIVE
> state:
> 
>    1) nvme nvme10: NVME-FC{10}: create association : ...
>    2) nvme nvme10: NVME-FC{10}: controller connectivity lost.
>                    Awaiting Reconnect
>       nvme nvme10: queue_size 128 > ctrl maxcmd 32, reducing to maxcmd
>    3) nvme nvme10: Could not set queue count (880)
>       nvme nvme10: Failed to configure AEN (cfg 900)
>    4) nvme nvme10: NVME-FC{10}: controller connect complete
>    5) nvme nvme10: failed nvme_keep_alive_end_io error=4
> 
> A connection attempt starts 1) and the ctrl is in state CONNECTING.
> Shortly after the LLDD driver detects a connection lost event and calls
> nvme_fc_ctrl_connectivity_loss 2). Because we are still in CONNECTING
> state, this event is ignored.
> 
> nvme_fc_create_association continues to run in parallel and tries to
> communicate with the controller and these commands will fail. Though
> these errors are filtered out, e.g in 3) setting the I/O queues numbers
> fails which leads to an early exit in nvme_fc_create_io_queues. Because
> the number of IO queues is 0 at this point, there is nothing left in
> nvme_fc_create_association which could detected the connection drop.
> Thus the ctrl enters LIVE state 4).
> 
> Eventually the keep alive handler times out 5) but because nothing is
> being done, the ctrl stays in LIVE state.
> 
> There is already the ASSOC_FAILED flag to track connectivity loss event
> but this bit is set too late in the recovery code path. Move this into
> the connectivity loss event handler and synchronize it with the state
> change. This ensures that the ASSOC_FAILED flag is seen by
> nvme_fc_create_io_queues and it does not enter the LIVE state after a
> connectivity loss event. If the connectivity loss event happens after we
> entered the LIVE state the normal error recovery path is executed.
> 
> Signed-off-by: Daniel Wagner <wagi@kernel.org>
> ---
>   drivers/nvme/host/fc.c | 23 ++++++++++++++++++-----
>   1 file changed, 18 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index 7409da42b9ee580cdd6fe78c0f93e78c4ad08675..55884d3df6f291cfddb4742e135b54a72f1cfa05 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -781,11 +781,19 @@ nvme_fc_abort_lsops(struct nvme_fc_rport *rport)
>   static void
>   nvme_fc_ctrl_connectivity_loss(struct nvme_fc_ctrl *ctrl)
>   {
> +	enum nvme_ctrl_state state;
> +	unsigned long flags;
> +
>   	dev_info(ctrl->ctrl.device,
>   		"NVME-FC{%d}: controller connectivity lost. Awaiting "
>   		"Reconnect", ctrl->cnum);
>   
> -	switch (nvme_ctrl_state(&ctrl->ctrl)) {
> +	spin_lock_irqsave(&ctrl->lock, flags);
> +	set_bit(ASSOC_FAILED, &ctrl->flags);
> +	state = nvme_ctrl_state(&ctrl->ctrl);
> +	spin_unlock_irqrestore(&ctrl->lock, flags);
> +
> +	switch (state) {
>   	case NVME_CTRL_NEW:
>   	case NVME_CTRL_LIVE:
>   		/*
> @@ -2542,7 +2550,6 @@ nvme_fc_error_recovery(struct nvme_fc_ctrl *ctrl, char *errmsg)
>   	 */
>   	if (ctrl->ctrl.state == NVME_CTRL_CONNECTING) {
>   		__nvme_fc_abort_outstanding_ios(ctrl, true);
> -		set_bit(ASSOC_FAILED, &ctrl->flags);
>   		dev_warn(ctrl->ctrl.device,
>   			"NVME-FC{%d}: transport error during (re)connect\n",
>   			ctrl->cnum);
> @@ -3167,12 +3174,18 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
>   		else
>   			ret = nvme_fc_recreate_io_queues(ctrl);
>   	}
> -	if (!ret && test_bit(ASSOC_FAILED, &ctrl->flags))
> -		ret = -EIO;
>   	if (ret)
>   		goto out_term_aen_ops;
>   
> -	changed = nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_LIVE);
> +	spin_lock_irqsave(&ctrl->lock, flags);
> +	if (!test_bit(ASSOC_FAILED, &ctrl->flags))
> +		changed = nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_LIVE);
> +	else
> +		ret = -EIO;
> +	spin_unlock_irqrestore(&ctrl->lock, flags);
> +
> +	if (ret)
> +		goto out_term_aen_ops;
>   
>   	ctrl->ctrl.nr_reconnects = 0;
>   
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

