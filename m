Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A64EBC3ABBF
	for <linux-nvme@archiver.kernel.org>; Wed,  7 May 2025 14:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iylIsey/wrS34OzNZBCpedL0/sIHTHzI2WXhm+EitlM=; b=Adg5NlzdQ1sha2cgDtO+YVdrRC
	eoJT/gzaMvNObxyLjQpMigeZZc8R9kh+VuvUgBpG+HHNtU12Wb9aZhvjH5IlWV5N0CVrkocPwe44b
	gSjsKsMT+rce42auC9wdYXmqHVrQfT4wo4RYhXOD6GcWplcxfy/dw4XhoOSTYbaeC5G+8qmuyVkem
	hBAdttRHhgXNGWSbUwqwaN5DuauDy37CWJGf82dD5cNqSmiqVEDXWHnPwTDrJZIQy7bvVGlgg2daJ
	ZCl+hq42jz6Z8Q11TaCmvaCMWNpwOydi7X4tPca0m6Q+xa/38f64wVTHGRP7f2hfHXY/hRjC0g8lF
	0SPFC83Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCftW-0000000FoGT-3HA0;
	Wed, 07 May 2025 14:37:10 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCfId-0000000Fft1-4Bnp
	for linux-nvme@lists.infradead.org;
	Wed, 07 May 2025 13:59:06 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 874BB1F395;
	Wed,  7 May 2025 13:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1746626342; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iylIsey/wrS34OzNZBCpedL0/sIHTHzI2WXhm+EitlM=;
	b=ygD8eAEMNhxUaIiWYzK8r1bjFqrM0y8aIc1+ogNsD3uetbtadahkvh8Y/rl9vS+IUzYk44
	Atva7EDgpvcZdhyLA8K2YNrF+z2mCE6PiGaoHB1tH7F7Gupigrnm7PTe5M3wYDcjbMKHb2
	uhfXc6tU8O8vFwTGdGaYvsJWlIVg560=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1746626342;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iylIsey/wrS34OzNZBCpedL0/sIHTHzI2WXhm+EitlM=;
	b=FtGY9P24Gs1Ipdi4VI55FCR0aHVbND+Tx3qAIXp/Guypji5ErkLTYrNl1TzMc0aV2CRlHH
	QHIixhxx5WQxucAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1746626342; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iylIsey/wrS34OzNZBCpedL0/sIHTHzI2WXhm+EitlM=;
	b=ygD8eAEMNhxUaIiWYzK8r1bjFqrM0y8aIc1+ogNsD3uetbtadahkvh8Y/rl9vS+IUzYk44
	Atva7EDgpvcZdhyLA8K2YNrF+z2mCE6PiGaoHB1tH7F7Gupigrnm7PTe5M3wYDcjbMKHb2
	uhfXc6tU8O8vFwTGdGaYvsJWlIVg560=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1746626342;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iylIsey/wrS34OzNZBCpedL0/sIHTHzI2WXhm+EitlM=;
	b=FtGY9P24Gs1Ipdi4VI55FCR0aHVbND+Tx3qAIXp/Guypji5ErkLTYrNl1TzMc0aV2CRlHH
	QHIixhxx5WQxucAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4B467139D9;
	Wed,  7 May 2025 13:59:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id o/T1ESZnG2hUTgAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 07 May 2025 13:59:02 +0000
Message-ID: <8ce7f125-66b3-4c8c-8c99-77d129adb1a8@suse.de>
Date: Wed, 7 May 2025 15:59:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 08/14] nvmet-fcloop: prevent double port deletion
To: Daniel Wagner <wagi@kernel.org>, James Smart <james.smart@broadcom.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250507-nvmet-fcloop-v6-0-ca02e16fb018@kernel.org>
 <20250507-nvmet-fcloop-v6-8-ca02e16fb018@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250507-nvmet-fcloop-v6-8-ca02e16fb018@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_SHORT(-0.20)[-0.994];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250507_065904_336899_DDB3A0C6 
X-CRM114-Status: GOOD (  20.11  )
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

On 5/7/25 14:23, Daniel Wagner wrote:
> The delete callback can be called either via the unregister function or
> from the transport directly. Thus it is necessary ensure resources are
> not freed multiple times.
> 
> Signed-off-by: Daniel Wagner <wagi@kernel.org>
> ---
>   drivers/nvme/target/fcloop.c | 19 +++++++++++++++++--
>   1 file changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
> index 9adaee3c7129f7e270842c5d09f78de2e108479a..c74baa7f6e43c8bddd9e6948f806f27b032b1d4d 100644
> --- a/drivers/nvme/target/fcloop.c
> +++ b/drivers/nvme/target/fcloop.c
> @@ -215,6 +215,9 @@ struct fcloop_lport_priv {
>   	struct fcloop_lport *lport;
>   };
>   
> +/* The port is already being removed, avoid double free */
> +#define PORT_DELETED	0
> +
>   struct fcloop_rport {
>   	struct nvme_fc_remote_port	*remoteport;
>   	struct nvmet_fc_target_port	*targetport;
> @@ -223,6 +226,7 @@ struct fcloop_rport {
>   	spinlock_t			lock;
>   	struct list_head		ls_list;
>   	struct work_struct		ls_work;
> +	unsigned long			flags;
>   };
>   
>   struct fcloop_tport {
> @@ -233,6 +237,7 @@ struct fcloop_tport {
>   	spinlock_t			lock;
>   	struct list_head		ls_list;
>   	struct work_struct		ls_work;
> +	unsigned long			flags;
>   };
>   
>   struct fcloop_nport {
> @@ -1067,30 +1072,38 @@ static void
>   fcloop_remoteport_delete(struct nvme_fc_remote_port *remoteport)
>   {
>   	struct fcloop_rport *rport = remoteport->private;
> +	bool put_port = false;
>   	unsigned long flags;
>   
>   	flush_work(&rport->ls_work);
>   
>   	spin_lock_irqsave(&fcloop_lock, flags);
> +	if (!test_and_set_bit(PORT_DELETED, &rport->flags))
> +		put_port = true;
>   	rport->nport->rport = NULL;

Can't we set '->nport' to NULL here (and save it in a temporary
variable)?
Then it's quite obvious if we need to call nport_put(),
and we would do away with the 'flags' field ...

>   	spin_unlock_irqrestore(&fcloop_lock, flags);
>   
> -	fcloop_nport_put(rport->nport);
> +	if (put_port)
> +		fcloop_nport_put(rport->nport);
>   }
>   
>   static void
>   fcloop_targetport_delete(struct nvmet_fc_target_port *targetport)
>   {
>   	struct fcloop_tport *tport = targetport->private;
> +	bool put_port = false;
>   	unsigned long flags;
>   
>   	flush_work(&tport->ls_work);
>   
>   	spin_lock_irqsave(&fcloop_lock, flags);
> +	if (!test_and_set_bit(PORT_DELETED, &tport->flags))
> +		put_port = true;
>   	tport->nport->tport = NULL;

Similar here.

>   	spin_unlock_irqrestore(&fcloop_lock, flags);
>   
> -	fcloop_nport_put(tport->nport);
> +	if (put_port)
> +		fcloop_nport_put(tport->nport);
>   }
>   
>   #define	FCLOOP_HW_QUEUES		4
> @@ -1433,6 +1446,7 @@ fcloop_create_remote_port(struct device *dev, struct device_attribute *attr,
>   	rport->nport = nport;
>   	rport->lport = nport->lport;
>   	nport->rport = rport;
> +	rport->flags = 0;
>   	spin_lock_init(&rport->lock);
>   	INIT_WORK(&rport->ls_work, fcloop_rport_lsrqst_work);
>   	INIT_LIST_HEAD(&rport->ls_list);
> @@ -1530,6 +1544,7 @@ fcloop_create_target_port(struct device *dev, struct device_attribute *attr,
>   	tport->nport = nport;
>   	tport->lport = nport->lport;
>   	nport->tport = tport;
> +	tport->flags = 0;
>   	spin_lock_init(&tport->lock);
>   	INIT_WORK(&tport->ls_work, fcloop_tport_lsrqst_work);
>   	INIT_LIST_HEAD(&tport->ls_list);
> 

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

