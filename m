Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10BE6C531D0
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Jul 2026 08:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9qq5fXeZ+9J7HvjHKAqEIreLCL3+ZVp2s+W9q95D6kU=; b=v90Dy1eTsXOtukTl4LkyUh3EjS
	LEBTDXuDpV6HX75IEzmqFN9AwJ1NZjiPAbn/ZVsiS7zJN1/KT7/AflZ5aIpLOnXOofqfgL8yDvRLn
	cr+4fsIAyqLQGPs/auBO0kPc/b8qk3PMEy2NJRVtfsTRlL10mgwJAbSwgtf0V4gA3U7T7cqWBPUvx
	5wbhWUSm/1Zq+yhC9cK20HzqZpbboQ8nv1RilX7AyEFAREgWGWYYu4B60qpozYb5KwtCckTO/Yxvx
	g4R6W5xw5VmNOvm4QXPLvPS1E/CrCyEaRjiqcfFK8on9wcd7znDArQfF60XF/jSOBgpyNQpvaE+sp
	bhDSsf6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpM4V-00000009qxP-3EWy;
	Thu, 30 Jul 2026 08:24:55 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpM4T-00000009qwY-0AU1
	for linux-nvme@lists.infradead.org;
	Thu, 30 Jul 2026 08:24:54 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 08B3D3ED7;
	Thu, 30 Jul 2026 08:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1785399887; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9qq5fXeZ+9J7HvjHKAqEIreLCL3+ZVp2s+W9q95D6kU=;
	b=V3w75G7SEc0SaW3NvKGw+cvtGA7ntIVsU1ou6OyJtAXirDKeAwYVKb71P3oIyzgX8hOMxH
	iKuidEgiTuMmnqhZzdJ9HAlW8UlfrOCyUC1y3xCxsUluXLtrzBAYn3VIQCwrP6ThnYgXFq
	3SOjZdnR8F8xbL5U1DTOMOGO74N4orA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785399887;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9qq5fXeZ+9J7HvjHKAqEIreLCL3+ZVp2s+W9q95D6kU=;
	b=J6JmBgZGZyj7a3xNnqK2mrREpstkRZCgaZsOGAvmPidw2Y5puocP4QeWST3yggKnQq/6fq
	DvyCv8vHu74z1OBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=nDKmPYHx;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=8vlL5lwv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1785399883; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9qq5fXeZ+9J7HvjHKAqEIreLCL3+ZVp2s+W9q95D6kU=;
	b=nDKmPYHxie2YlM0o3LDMNPXEJzFAe6KGA/1mX4wFLV//c02ZL3V7Yi8oGFclUh1y38kqlR
	U/I5pCFONK8EUW0xsOsk7R4O8eMQSinG//aEjQahHEvMUO0Oudnbht8mAN2o9mOKm7DI8D
	ux3PHuPyOTsEHuqwJ5fQOPiXg4LLXVA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785399883;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9qq5fXeZ+9J7HvjHKAqEIreLCL3+ZVp2s+W9q95D6kU=;
	b=8vlL5lwvDxWdIHefkHm6rHYrAvbmh7SSIA5LLJMKNi/cTIHGL9seiyQfgN8J+2wuP6O2p2
	+9YfOI28oESg5UAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E6749779CD;
	Thu, 30 Jul 2026 08:24:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bLuvN0oKa2oHNgAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 30 Jul 2026 08:24:42 +0000
Message-ID: <d3e9364e-b4af-4fb0-94bc-a8339e9de146@suse.de>
Date: Thu, 30 Jul 2026 10:24:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] nvme: clamp FDP placement handle count to the buffer
 size
To: Guixin Liu <kanie@linux.alibaba.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Nilay Shroff <nilay@linux.ibm.com>,
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org
References: <20260730043105.3071328-1-kanie@linux.alibaba.com>
 <20260730043105.3071328-5-kanie@linux.alibaba.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260730043105.3071328-5-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 08B3D3ED7
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,alibaba.com:email];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260730_012453_235801_C80C31D2 
X-CRM114-Status: GOOD (  17.57  )
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

On 7/30/26 6:31 AM, Guixin Liu wrote:
> nvme_query_fdp_info() allocates the RUH status buffer for at most
> S8_MAX - 1 descriptors and caps the io-mgmt-receive transfer to that
> size. head->nr_plids, however, is taken verbatim from the device-supplied
> nruhsd field, which can be up to 65535. If a non-conformant or malicious
> device reports more descriptors than the buffer holds, the copy loop
> reads past the end of the ruhs buffer (heap out-of-bounds read).
> 
> Clamp nr_plids to the number of descriptors the buffer can actually hold.
> 
> Fixes: 30b5f20bb2dd ("nvme: register fdp parameters with the block layer")
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
> ---
>   drivers/nvme/host/core.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 453c1f0b2dd0..b1f444cd3daf 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2358,6 +2358,7 @@ static int nvme_query_fdp_info(struct nvme_ns *ns, struct nvme_ns_info *info)
>   	}
>   
>   	head->nr_plids = le16_to_cpu(ruhs->nruhsd);
> +	head->nr_plids = min_t(u16, head->nr_plids, S8_MAX - 1);
>   	if (!head->nr_plids)
>   		goto free;
>   

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

