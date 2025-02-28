Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B2C9C19776
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Feb 2025 07:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AMH+Ct4cSLyr91tMN/c0O0+iDa4wkLGmUlBFVGM9kkQ=; b=okWzojf8gr8d9zZSt53WSL0Dyf
	NqfDGTwpyipYI2mS8BqlbLqjfTxzhfbzpT1KrGxGB+RKCCtKaUT/SFFXgW3NuyYwTjOCYSeKvzg1W
	QQwEFtA+/ao0vkVC09ixtuNgsbm5eEep41L9Fmm5PgZXK7KMBsSt16+KMYobVHF4QV9TpRz3+kAGz
	NhVa2gnQn2G5mitMTBzMVq2aPRfz/vvfkJrMQxmt/kafHOcJNH9HnBSkHFp2CJRhT1Sc//BkjnVd6
	M2toXCmyXOI9M9a1kjxHM7VjoOy6mkpqRADCl/nVBS8qUOPABcSQA5/nDCOIGRl8M5oCzIL57MVLL
	vyeM8C8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tnutl-0000000A0vl-00Yh;
	Fri, 28 Feb 2025 07:35:05 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tnuti-0000000A0vE-2XN7
	for linux-nvme@lists.infradead.org;
	Fri, 28 Feb 2025 07:35:03 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B4D512116F;
	Fri, 28 Feb 2025 07:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740728100; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AMH+Ct4cSLyr91tMN/c0O0+iDa4wkLGmUlBFVGM9kkQ=;
	b=BTFEsKs+VT0/B0sYogDR5QVmVYT2ys/bNuymWNjIDqZibBihV1nWnsOMdoCX0N44Y3ixXW
	rLEDRtkhg9LWrN5alZA2u0x2ldRpZXOd6TO1tnLVWELvrHmBcC8ePpZ/IQvrY1IcrjfQnm
	6g1ceYB3HDh61eY3OCrw/4sWdMBT8nQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740728100;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AMH+Ct4cSLyr91tMN/c0O0+iDa4wkLGmUlBFVGM9kkQ=;
	b=JDdx/GggYnLEmJB8UB/UxxE7jDqmhI26BQ24mJV/pzr7lra9mbs7NzF3MMFyuk3PAqGJ/l
	HcUZpD00ZQ3w1iDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740728100; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AMH+Ct4cSLyr91tMN/c0O0+iDa4wkLGmUlBFVGM9kkQ=;
	b=BTFEsKs+VT0/B0sYogDR5QVmVYT2ys/bNuymWNjIDqZibBihV1nWnsOMdoCX0N44Y3ixXW
	rLEDRtkhg9LWrN5alZA2u0x2ldRpZXOd6TO1tnLVWELvrHmBcC8ePpZ/IQvrY1IcrjfQnm
	6g1ceYB3HDh61eY3OCrw/4sWdMBT8nQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740728100;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AMH+Ct4cSLyr91tMN/c0O0+iDa4wkLGmUlBFVGM9kkQ=;
	b=JDdx/GggYnLEmJB8UB/UxxE7jDqmhI26BQ24mJV/pzr7lra9mbs7NzF3MMFyuk3PAqGJ/l
	HcUZpD00ZQ3w1iDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6B848137AC;
	Fri, 28 Feb 2025 07:35:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vVeMGCRnwWd5JwAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 28 Feb 2025 07:35:00 +0000
Message-ID: <f944fdb3-081f-474a-9193-f482fe87f72b@suse.de>
Date: Fri, 28 Feb 2025 08:34:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/11] nvmet-fc: take tgtport reference only once
To: Daniel Wagner <wagi@kernel.org>, James Smart <james.smart@broadcom.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250226-nvmet-fcloop-v1-0-c0bd83d43e6a@kernel.org>
 <20250226-nvmet-fcloop-v1-8-c0bd83d43e6a@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250226-nvmet-fcloop-v1-8-c0bd83d43e6a@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250227_233502_796941_9BBC8E20 
X-CRM114-Status: GOOD (  21.33  )
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

On 2/26/25 19:46, Daniel Wagner wrote:
> The reference counting code can be simplified. Instead taking a tgtport
> refrerence at the beginning of nvmet_fc_alloc_hostport and put it back
> if not a new hostport object is allocated, only take it when a new
> hostport object is allocated.
> 
Can it really?
Main point of this operation is that 'tgtport' isn't going away during 
while we're figuring out whether we need it.

With this patch it means that

> Signed-off-by: Daniel Wagner <wagi@kernel.org>
> ---
>   drivers/nvme/target/fc.c | 18 +++---------------
>   1 file changed, 3 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
> index b807b4c05cac7fe4764df3df76f8fa50f4bab6ba..391917b4ce0115dbc0ad99d1fb363b1af6ee0685 100644
> --- a/drivers/nvme/target/fc.c
> +++ b/drivers/nvme/target/fc.c
> @@ -1046,29 +1046,16 @@ nvmet_fc_alloc_hostport(struct nvmet_fc_tgtport *tgtport, void *hosthandle)
>   	if (!hosthandle)
>   		return NULL;
>   
> -	/*
> -	 * take reference for what will be the newly allocated hostport if
> -	 * we end up using a new allocation
> -	 */
> -	if (!nvmet_fc_tgtport_get(tgtport))
> -		return ERR_PTR(-EINVAL);
> -
 >   	spin_lock_irqsave(&tgtport->lock, flags);>   	match = 
nvmet_fc_match_hostport(tgtport, hosthandle);
>   	spin_unlock_irqrestore(&tgtport->lock, flags);
>   

'tgtport' might be invalid here, causing a crash when taking the lock.

> -	if (match) {
> -		/* no new allocation - release reference */
> -		nvmet_fc_tgtport_put(tgtport);
> +	if (match)
>   		return match;
> -	}
>   
>   	newhost = kzalloc(sizeof(*newhost), GFP_KERNEL);
> -	if (!newhost) {
> -		/* no new allocation - release reference */
> -		nvmet_fc_tgtport_put(tgtport);
> +	if (!newhost)
>   		return ERR_PTR(-ENOMEM);
> -	}
>   
>   	spin_lock_irqsave(&tgtport->lock, flags);
>   	match = nvmet_fc_match_hostport(tgtport, hosthandle);
> @@ -1077,6 +1064,7 @@ nvmet_fc_alloc_hostport(struct nvmet_fc_tgtport *tgtport, void *hosthandle)
>   		kfree(newhost);
>   		newhost = match;
>   	} else {
> +		nvmet_fc_tgtport_get(tgtport);
>   		newhost->tgtport = tgtport;
>   		newhost->hosthandle = hosthandle;
>   		INIT_LIST_HEAD(&newhost->host_list);
> 

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

