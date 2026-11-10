Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF1D60A263B
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Nov 2026 12:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=0LQn7hms;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=OY3wGhqG;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=QcnOGgcp;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=OY3wGhqG;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=QcnOGgcp
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=G2tDSge8kYrin1SA/inaPmpvgHGz/bSIb4IKARoBuOE=; b=0LQn7hmsLaBO3k
	ui1hs4RSE/OvGx09q5euD9is5DBcoiSbczvuuJs1vsLd68mylL5W7isXyiURw7XDJ149fdDWlFFXl
	wf+mot/jiIXZvB6zMSpamWvV+8SpxwSmvzrSOHl8wbyj6PKpcgScuMUAHKsJb4xUSZ5hsvcX1K+Cr
	QbUqbx9CVRl9AWRRkb6Mbqz9KG3qQGYP95WRPSkxFJIIiFTcJXkDl8xDruMZQQhoxTI3f6jnFQ32m
	ZsN5O5OoXfIqwEK3H261hPo/0bKm1+d7WUm5WGFAKphmLIgLEEHjqMwKacvjsdtrxE7N1mbC4AO/U
	HK9iveGHwqWXIJWaIWlw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQlOA-00000003vmk-0ngd;
	Tue, 10 Nov 2026 12:55:50 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQlO6-00000003vm7-2Iut
	for linux-nvme@lists.infradead.org;
	Tue, 10 Nov 2026 12:55:49 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C357E21EFD;
	Tue, 10 Nov 2026 12:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794315344; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G2tDSge8kYrin1SA/inaPmpvgHGz/bSIb4IKARoBuOE=;
	b=OY3wGhqGrse184pX0UQm8P9Ms8iy/lBZy8po6SkbH6GR4VV17znkmv3yGahOOApwGDMjrz
	3VC4XdUmZNcTMLlW8/h/KIYRUDUGIBpjxy3pvYKtiYHXmVPEKmLSy518yNpZmcw/Jt39kW
	qmuqAYVErNVei+gsUlC6ExhX4J2qyr8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794315344;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G2tDSge8kYrin1SA/inaPmpvgHGz/bSIb4IKARoBuOE=;
	b=QcnOGgcpdzBHWTeU4669kegBu8MRVFJX1eUxh4iVvOGbfNjszoU1xZzhdn37tg4VbTHvDi
	tm0taBttNrmHcCAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794315344; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G2tDSge8kYrin1SA/inaPmpvgHGz/bSIb4IKARoBuOE=;
	b=OY3wGhqGrse184pX0UQm8P9Ms8iy/lBZy8po6SkbH6GR4VV17znkmv3yGahOOApwGDMjrz
	3VC4XdUmZNcTMLlW8/h/KIYRUDUGIBpjxy3pvYKtiYHXmVPEKmLSy518yNpZmcw/Jt39kW
	qmuqAYVErNVei+gsUlC6ExhX4J2qyr8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794315344;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G2tDSge8kYrin1SA/inaPmpvgHGz/bSIb4IKARoBuOE=;
	b=QcnOGgcpdzBHWTeU4669kegBu8MRVFJX1eUxh4iVvOGbfNjszoU1xZzhdn37tg4VbTHvDi
	tm0taBttNrmHcCAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 89C5F1339F;
	Tue, 10 Nov 2026 12:55:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RG1yFVAU82puQwAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 10 Nov 2026 12:55:44 +0000
Message-ID: <508595ec-0540-4534-afd4-44ef8ee01da6@suse.de>
Date: Tue, 10 Nov 2026 13:55:43 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: stop asynchronous event work before ANA teardown
To: Yaohan Li <shunsheng1218@gmail.com>, kbusch@kernel.org, axboe@kernel.dk,
 hch@lst.de, sagi@grimberg.me
Cc: jthumshirn@suse.de, mkp@kernel.org, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <179378587000.73780.18152328009023418065@gmail.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <179378587000.73780.18152328009023418065@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-13.29 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,kernel.dk,lst.de,grimberg.me];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]
X-Spam-Score: -13.29
X-Spam-Level: 
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261110_045548_014736_858D55DC 
X-CRM114-Status: GOOD (  20.43  )
X-Spam-Score: -2.1 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/4/26 10:51 AM, Yaohan Li wrote:
> nvme_mpath_stop() cancels ana_work, but the asynchronous event worker
> can enqueue ANA processing again while controller teardown is in
> progress. An ANA work item can therefore survive the final
> controller release and access freed memory.
> 
> Cancel async_event_work during controller uninitialization, after the
> controller has stopped accepting new events, and cancel ana_work
> again before releasing its ANA resources. Draining only ana_work is
> not sufficient while the event worker can requeue it.
> 
> The race was reproduced with the in-tree NVMe loop target and
> scheduling injection. Cancelling ANA work alone left reports; draining
> the event source and the ANA work together removed the reported
> use-after-free under the same test conditions.
> 
> Fixes: 0d0b660f214dc ("nvme: add ANA support")
> Assisted-by: ZCode:GLM-4
> Signed-off-by: Yaohan Li <shunsheng1218@gmail.com>
> ---
>   drivers/nvme/host/core.c      | 9 +++++++++
>   drivers/nvme/host/multipath.c | 7 +++++++
>   2 files changed, 16 insertions(+)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index a7a4d09644c13..017aae1189de1 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -5182,6 +5182,15 @@ EXPORT_SYMBOL_GPL(nvme_start_ctrl);
>   void nvme_uninit_ctrl(struct nvme_ctrl *ctrl)
>   {
>   	nvme_stop_keep_alive(ctrl);
> +
> +	/*
> +	 * Stop the async event worker before the final put: it processes
> +	 * ANA change events by re-queueing ctrl->ana_work, which is
> +	 * embedded in ctrl and cancelled in nvme_free_ctrl(); a worker
> +	 * running past that point would re-queue it onto freed memory.
> +	 */
> +	cancel_work_sync(&ctrl->async_event_work);
> +
>   	nvme_hwmon_exit(ctrl);
>   	nvme_fault_inject_fini(&ctrl->fault_inject);
>   	dev_pm_qos_hide_latency_tolerance(ctrl->device);
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index 9e0a0fd77c56e..44bd1a1ad5940 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -1610,6 +1610,13 @@ int nvme_mpath_init_identify(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
>   
>   void nvme_mpath_uninit(struct nvme_ctrl *ctrl)
>   {
> +	/*
> +	 * nvme_mpath_stop() already cancelled ana_work, but an ANA async
> +	 * event completing after nvme_stop_ctrl() can have re-queued it.
> +	 * It is embedded in ctrl, which is freed after uninit.
> +	 */
> +	cancel_work_sync(&ctrl->ana_work);
> +
>   	kvfree(ctrl->ana_log_buf);
>   	ctrl->ana_log_buf = NULL;
>   	ctrl->ana_log_size = 0;

Why can we schedule AENs when a controller teardown is active?
Shouldn't we rather disallow that instead of fixing the fallout?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

