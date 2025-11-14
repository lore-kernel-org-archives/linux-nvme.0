Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52D34CDE006
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Nov 2025 07:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Y2/AuKA5YiROwkz+HjXumx7ObWtAwP0RFFtkqkdV+ng=; b=J87BEfbJ7xTfBOd3l3eL19gT/b
	ZY6dLz4emXHicReve5BWWe2KuyTTFCP9J7vpfOTUoZRD9HhsA9YuzufAeCnkMx/eaKXDr/6mQTSUM
	5tbfnIEsMhrV2+oWIpKu9xjhmJJr3wHe05EbAflxAa/o6W3EsfV4ZtBHQUWMQ9jnbJFHKVq6bBC/m
	hDqOvpVte525BIIJRxLJWHZ4ofr8Uu3BP9J/Dk3PpphC91MGlDyMYYio21Soib2i8wYyDL1dlQ6m8
	kfD8X3WRZ1OuT5HTGFnbRO1C4FVtUiLm1O7nCLJ2ClVpv/ay96ggROf6hhPGp8uLeyzXUIj4SSJSE
	3UZEOuVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJnnK-0000000BhmT-2OQb;
	Fri, 14 Nov 2025 07:00:30 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJnnH-0000000Bhle-4B7l
	for linux-nvme@lists.infradead.org;
	Fri, 14 Nov 2025 07:00:29 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B01BE211FF;
	Fri, 14 Nov 2025 07:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1763103626; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y2/AuKA5YiROwkz+HjXumx7ObWtAwP0RFFtkqkdV+ng=;
	b=OBOsz4NE0x/4MwZyrRM8b1/nOb1tGt5lxt4IMz9+55ID7FmLY2WJoJbgtC73GBsr8bkxsD
	5eF/SsExOPPnhLJGzmAb4/W+rE57Zg1bi7eGbgwyd8SCCDmHtzMNbAKeFS/n7oimLpF9/o
	FHe7EDq8hnIDUeoVtgQ2Xiq3cZlWe1E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1763103626;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y2/AuKA5YiROwkz+HjXumx7ObWtAwP0RFFtkqkdV+ng=;
	b=wybibO156ySlZ3eavFE/1W7q+S/bSGNjc6qY2vm52xnj9qNUomqqX/+GSfRT/gUYq1vSy0
	aThruS/3bCmJEXBA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=dBXdf29L;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=IymCTVZt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1763103625; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y2/AuKA5YiROwkz+HjXumx7ObWtAwP0RFFtkqkdV+ng=;
	b=dBXdf29LigIdE0PoMQhah2OFsUu41V5ssFCEnHvKbH54tJD36Q2s/eDAyD2IIXXDFKpWqc
	EhCJcE0L0E79ex/+hrBVZQACpiXzwA9HGVUwIS2W5gL2GeSanPRPol5v9F8WB4nBkmKeGe
	5bc0UbzipIuSx4vM1L6eIKiHYGO+iJE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1763103625;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y2/AuKA5YiROwkz+HjXumx7ObWtAwP0RFFtkqkdV+ng=;
	b=IymCTVZtJGJAztfZvA/pi6ckXVy8bRVCF3D/wisXg+kyAuamnqYHY0K802osJvvrLXqy6q
	qrpJNhhtyW1OfuAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 62E413EA61;
	Fri, 14 Nov 2025 07:00:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xoZuFonTFmnxQwAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 14 Nov 2025 07:00:25 +0000
Message-ID: <e94f276d-da71-4159-bd9c-e9165231b122@suse.de>
Date: Fri, 14 Nov 2025 08:00:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] nvme: Expose the tls_configured sysfs for secure
 concat connections
To: alistair23@gmail.com, kbusch@kernel.org, axboe@kernel.dk, hch@lst.de,
 sagi@grimberg.me, kch@nvidia.com, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Alistair Francis <alistair.francis@wdc.com>
References: <20251114045850.1898865-1-alistair.francis@wdc.com>
 <20251114045850.1898865-4-alistair.francis@wdc.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20251114045850.1898865-4-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B01BE211FF
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-5.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,kernel.dk,lst.de,grimberg.me,nvidia.com,lists.infradead.org];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_TRACE(0.00)[suse.de:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:mid,suse.de:dkim]
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251113_230028_189656_EF9446BA 
X-CRM114-Status: GOOD (  14.48  )
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

On 11/14/25 05:58, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
> v3:
>   - No change
> v2:
>   - New patch
> 
>   drivers/nvme/host/sysfs.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
> index 29430949ce2f..6d10e12136d0 100644
> --- a/drivers/nvme/host/sysfs.c
> +++ b/drivers/nvme/host/sysfs.c
> @@ -838,7 +838,7 @@ static umode_t nvme_tls_attrs_are_visible(struct kobject *kobj,
>   	    !ctrl->opts->tls && !ctrl->opts->concat)
>   		return 0;
>   	if (a == &dev_attr_tls_configured_key.attr &&
> -	    (!ctrl->opts->tls_key || ctrl->opts->concat))
> +	    !ctrl->opts->concat)
>   		return 0;
>   	if (a == &dev_attr_tls_keyring.attr &&
>   	    !ctrl->opts->keyring)

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

