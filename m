Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B030DC54FB3
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Jun 2025 06:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4KgE2toiAqeTAABqExcxdRGCOjRR5I9cGqQ0lta2DRw=; b=SHxqP8TFn1xvLiBlVF1dsXQuYu
	IkInyjUx5LgpEmpSH/2jT28aDx9UVhrWx44veoIiWxU4n2CTlUJAJ8hceL3J98B0aoKqg0KPsx+EL
	NFPk1A+fiNggfP9XPza+zgXnNj0gX6IGO/6E+gJBceY5m76X9t5KUvKaRWYe6ePdfZkZFuxG1N/jc
	A+V7cQ2rlXCxJ5AZ3va8pRrAv5mgjCQZMIfP/8pFRfLd7++gHzu7tTK1TM+Ma8Me9/Ir7dDG3WIYr
	23iFEPkumGbKcnG3f3UetNWEoP5Ni6pFijaDxf/I7S3FQg6Hg7TnpOS16S5mpYSSvaqOzvVZRHUkj
	iNnREMPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uLyqo-00000006qyD-3nfz;
	Mon, 02 Jun 2025 06:40:50 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uLypN-00000006qqv-18VQ
	for linux-nvme@lists.infradead.org;
	Mon, 02 Jun 2025 06:39:23 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 998E721185;
	Mon,  2 Jun 2025 06:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1748846359; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4KgE2toiAqeTAABqExcxdRGCOjRR5I9cGqQ0lta2DRw=;
	b=ZMqMHE1VV2AQ7hxYSk+8ioCFw58vleZEhasTgoutpSFrzWNajwxwuCx5SCYNSwFrH4keOH
	FidK14zxoZmMEeZtuAgpWbmlrSmmU3S+muM43/7KMAyxjeg4hDztJ+LwjZSdz/y+8n8wlr
	5/xvfwQdS2gkkr1TNDgkU4m7iKjqCSA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1748846359;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4KgE2toiAqeTAABqExcxdRGCOjRR5I9cGqQ0lta2DRw=;
	b=YV8VtNEDuYjtNRhF1ac/ukw9WBmrH+7KiojAA6LU1dCRqMGx2E5V6s54AZWnrd1XRFtoA5
	gPH8zTK6StqQUFDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=YPCKHgBm;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=a71sJ29G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1748846358; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4KgE2toiAqeTAABqExcxdRGCOjRR5I9cGqQ0lta2DRw=;
	b=YPCKHgBmPUdAo83EjaArzGX3xYWqqiqKMzO18Xdj9dBFPEGsty78waIB+4E/NDsmrHV9My
	ok2Fdj7VJ312imWii67uBEIF7mPdQqMODbPZDWVgmfd9az0AcFq8XO5rFpVC3qgdWiqXfE
	Qx1E6piSzTeQeLoL0SFc+TigGESnbD4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1748846358;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4KgE2toiAqeTAABqExcxdRGCOjRR5I9cGqQ0lta2DRw=;
	b=a71sJ29GVj2Jq5RPbvKxh2zO12TVXuxFP8QC4C4tAJXg0jxMGhrOdh3BD7geuC08ewDbhw
	cPMv2P5tVJm/bUBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 53CEC136C7;
	Mon,  2 Jun 2025 06:39:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id D1jAEhZHPWjdSgAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 02 Jun 2025 06:39:18 +0000
Message-ID: <1f448bbb-dab2-45b0-b82c-f8d0ef81173e@suse.de>
Date: Mon, 2 Jun 2025 08:39:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] nvme-tcp: avoid race between nvme scan and reset
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-nvme@lists.infradead.org
Cc: Hannes Reinecke <hare@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@infradead.org>
References: <20250602043522.55787-1-shinichiro.kawasaki@wdc.com>
 <20250602043522.55787-2-shinichiro.kawasaki@wdc.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250602043522.55787-2-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:9498, ipnet:::/1, country:IN];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 998E721185
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250601_233921_456180_11A6A382 
X-CRM114-Status: GOOD (  19.27  )
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

On 6/2/25 06:35, Shin'ichiro Kawasaki wrote:
> When the nvme scan work and the nvme controller reset work race, the
> WARN below happens:
> 
>    WARNING: CPU: 1 PID: 69 at block/blk-mq.c:330 blk_mq_unquiesce_queue+0x8f/0xb0
> 
> The WARN can be recreated by repeating the blktests test case nvme/063 a
> few times [1]. Its cause is the new queue allocation for the tag set
> by the scan work between blk_mq_quiesce_tagset() and
> blk_mq_unquiesce_tagset() calls by the reset work.
> 
> Reset work                     Scan work
> ------------------------------------------------------------------------
> nvme_reset_ctrl_work()
>   nvme_tcp_teardown_ctrl()
>    nvme_tcp_teardown_io_queues()
>     nvme_quiesce_io_queues()
>      blk_mq_quiesce_tagset()
>       list_for_each_entry()                                 .. N queues
>        blk_mq_quiesce_queue()
>                                 nvme_scan_work()
>                                  nvme_scan_ns_*()
>                                   nvme_scan_ns()
>                                    nvme_alloc_ns()
>                                     blk_mq_alloc_disk()
>                                      __blk_mq_alloc_disk()
>                                       blk_mq_alloc_queue()
>                                        blk_mq_init_allocate_queue()
>                                         blk_mq_add_queue_tag_set()
>                                          list_add_tail()    .. N+1 queues
>   nvme_tcp_setup_ctrl()
>    nvme_start_ctrl()
>     nvme_unquiesce_io_queues()
>      blk_mq_unquiesce_tagset()
>       list_for_each_entry()                                 .. N+1 queues
>        blk_mq_unquiesce_queue()
>         WARN_ON_ONCE(q->quiesce_depth <= 0)
> 
> blk_mq_quiesce_queue() is not called for the new queue added by the scan
> work, while blk_mq_unquiesce_queue() is called for it. Hence the WARN.
> 
> To suppress the WARN, avoid the race between the reset work and the scan
> work by flushing the scan work at the beginning of the reset work.
> 
> Link: https://lore.kernel.org/linux-nvme/6mhxskdlbo6fk6hotsffvwriauurqky33dfb3s44mqtr5dsxmf@gywwmnyh3twm/ [1]
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> ---
>   drivers/nvme/host/tcp.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index f6379aa33d77..14b9d67329b3 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -2491,6 +2491,9 @@ static void nvme_reset_ctrl_work(struct work_struct *work)
>   		container_of(work, struct nvme_ctrl, reset_work);
>   	int ret;
>   
> +	/* prevent racing with ns scanning */
> +	flush_work(&ctrl->scan_work);
> +
>   	if (nvme_tcp_key_revoke_needed(ctrl))
>   		nvme_auth_revoke_tls_key(ctrl);
>   	nvme_stop_ctrl(ctrl);

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

