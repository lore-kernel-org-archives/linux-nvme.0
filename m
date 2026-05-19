Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD477CD4F52
	for <linux-nvme@archiver.kernel.org>; Tue, 19 May 2026 08:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lqrCrz0x20lz4C2ENvXjncp9V130MOrha4oKy5/ibCE=; b=AqKRBg1InwFGLQNNqVaRs9Aawb
	MNRr0ueYPg9Z3wsvaWZMAJ9VwKwyjIb2f4XV8J/UHy+mRMmRgnOdEtqufurJbkTGlNkBQZOCeIr+5
	SNlPT+45pB3NSJ5R5v/KOaQ377ihFATgN81fCYv8tJWxnRW0MUpll8xY9NjrK0XX/btfV5ytOgkgh
	+F4NstxoX3E+ViiR6DwyM3sjyWya4kj+STeL/wz5+gtQjFyY7t6iT+q0voE4QW/SPo418/9bd0GFu
	PnD0r+2w6sCOzSI4XEFxwhvNjRPc7pxO0UjUKr5aE2ez9DsdE6vctaT6Xvt4Ut8LxACIIwvXGoQGe
	mVjpUbxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPG7C-00000000jcB-0YA9;
	Tue, 19 May 2026 08:47:50 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPG79-00000000jbE-1sMP
	for linux-nvme@lists.infradead.org;
	Tue, 19 May 2026 08:47:48 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5C3566AFA9;
	Tue, 19 May 2026 08:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779180465; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lqrCrz0x20lz4C2ENvXjncp9V130MOrha4oKy5/ibCE=;
	b=WB+xzc1qCFRi1ANRkiOYeWYVjZwJ5QkGWgumC9Gp7ldI1AHzd+/5UPVoClDPe6aqKjaFua
	h340E1oFQeo8oMrAZ337mhpp0+s0OdCRdtPV+giiY2JwWvAmY0lquqHoGErDslvCUGfwqR
	HqE5Dj5t8KzgDYyx3yNIEVP41NuaB6k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779180465;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lqrCrz0x20lz4C2ENvXjncp9V130MOrha4oKy5/ibCE=;
	b=woEfgWTSVZLU4D1FE3+IUs/gC/Gw4Ehm2BU6l7FxyXicB71jWMfFTUMSG9W62P8BO1mQiF
	rB6GqBO5WgMo9dDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779180465; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lqrCrz0x20lz4C2ENvXjncp9V130MOrha4oKy5/ibCE=;
	b=WB+xzc1qCFRi1ANRkiOYeWYVjZwJ5QkGWgumC9Gp7ldI1AHzd+/5UPVoClDPe6aqKjaFua
	h340E1oFQeo8oMrAZ337mhpp0+s0OdCRdtPV+giiY2JwWvAmY0lquqHoGErDslvCUGfwqR
	HqE5Dj5t8KzgDYyx3yNIEVP41NuaB6k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779180465;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lqrCrz0x20lz4C2ENvXjncp9V130MOrha4oKy5/ibCE=;
	b=woEfgWTSVZLU4D1FE3+IUs/gC/Gw4Ehm2BU6l7FxyXicB71jWMfFTUMSG9W62P8BO1mQiF
	rB6GqBO5WgMo9dDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 26DDF593A8;
	Tue, 19 May 2026 08:47:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Q07qCLEjDGo+IQAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 19 May 2026 08:47:45 +0000
Message-ID: <9bd25f0c-3cf9-4dff-9a3f-730d799d6646@suse.de>
Date: Tue, 19 May 2026 10:47:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 1/7] nvme: Let the blocklayer set timeouts for requests
To: Maurizio Lombardi <mlombard@redhat.com>, kbusch@kernel.org
Cc: mheyne@amazon.de, emilne@redhat.com, jmeneghi@redhat.com,
 linux-nvme@lists.infradead.org, dwagner@suse.de, mlombard@arkamax.eu,
 mkhalfella@purestorage.com, chaitanyak@nvidia.com, hare@kernel.org,
 hch@lst.de
References: <20260514083255.41109-1-mlombard@redhat.com>
 <20260514083255.41109-2-mlombard@redhat.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260514083255.41109-2-mlombard@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	URIBL_BLOCKED(0.00)[purestorage.com:email,lst.de:email,suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[purestorage.com:email,suse.de:email,suse.de:mid,lst.de:email,amazon.de:email,imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260519_014747_640712_15A82970 
X-CRM114-Status: GOOD (  24.60  )
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

On 5/14/26 10:32, Maurizio Lombardi wrote:
> From: Maximilian Heyne <mheyne@amazon.de>
> 
> When initializing an nvme request which is about to be send to the block
> layer, we do not need to initialize its timeout. If it's left
> uninitialized at 0 the block layer will use the request queue's timeout
> in blk_add_timer (via nvme_start_request which is called from
> nvme_*_queue_rq). These timeouts are setup to either NVME_IO_TIMEOUT or
> NVME_ADMIN_TIMEOUT when the request queues were created.
> 
> Because the io_timeout of the IO queues can be modified via sysfs, the
> following situation can occur:
> 
> 1) NVME_IO_TIMEOUT = 30 (default module parameter)
> 2) nvme1n1 is probed. IO queues default timeout is 30 s
> 3) manually change the IO timeout to 90 s
>     echo 90000 > /sys/class/nvme/nvme1/nvme1n1/queue/io_timeout
> 4) Any call of __submit_sync_cmd on nvme1n1 to an IO queue will issue
>     commands with the 30 s timeout instead of the wanted 90 s which might
>     be more suitable for this device.
> 
> Commit 470e900c8036 ("nvme: refactor nvme_alloc_request") silently
> changed the behavior for ioctl's already because it unconditionally
> overrides the request's timeout that was set in nvme_init_request. If it
> was unset by the user of the ioctl if will be overridden with 0 meaning
> the block layer will pick the request queue's IO timeout.
> 
> Following up on that, this patch further improves the consistency of IO
> timeout usage. However, there are still uses of NVME_IO_TIMEOUT which
> could be inconsistent with what is set in the device's request_queue by
> the user.
> 
> Reviewed-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Daniel Wagner <dwagner@suse.de>
> Signed-off-by: Maximilian Heyne <mheyne@amazon.de>
> Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
> ---
>   drivers/nvme/host/core.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index c3032d6ad6b1..6c75253d2866 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -729,10 +729,8 @@ void nvme_init_request(struct request *req, struct nvme_command *cmd)
>   		struct nvme_ns *ns = req->q->disk->private_data;
>   
>   		logging_enabled = ns->head->passthru_err_log_enabled;
> -		req->timeout = NVME_IO_TIMEOUT;
>   	} else { /* no queuedata implies admin queue */
>   		logging_enabled = nr->ctrl->passthru_err_log_enabled;
> -		req->timeout = NVME_ADMIN_TIMEOUT;
>   	}
>   
>   	if (!logging_enabled)

Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

