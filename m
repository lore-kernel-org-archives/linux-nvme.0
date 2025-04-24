Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5D4BC369AB
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Apr 2025 11:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oXu0xToKAPO25fLhe2rMHBfxuHS/THmrVmv/bkCC9KY=; b=jAVbC0uO8COdFSKMggSQFgSlFI
	wODlyh9Y2JWdrcNgfKC86wu7RV6GYklt9LIlsqLqniXflQeH34S7dWE8VZdeA7fMgkkWzK2E43U+c
	7uuvlrJCpvBSAyHmj9XDRNgzBP7aj1wtme7DZ2+faSEGYfHo8hGdfUWmG92trPjYCY7X8O3sK2BA9
	JTN2cKRHb3rXJmEXw4k8sg7sp1dBK1K1tZQ6az9MbUKaUwjcnroQUqgs8FJRI5hDKFPWr120GMGZL
	FpHBLT0mxVdYzwULBosqCXeVD0bRuWj32pI8fTCfPmwEE2ptAxe97GUdkm9GAPfq4et45aid4gJ3x
	ddLPEysA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7uff-0000000DqEB-06qJ;
	Thu, 24 Apr 2025 11:23:11 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7teB-0000000De5d-092W
	for linux-nvme@lists.infradead.org;
	Thu, 24 Apr 2025 10:17:36 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1F4AF1F399;
	Thu, 24 Apr 2025 10:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745489853; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oXu0xToKAPO25fLhe2rMHBfxuHS/THmrVmv/bkCC9KY=;
	b=s4nSWQtCo6+QGjsRUDwCGwwpQ/fpa53Eh8lU/LstcikM8KFwYcQ9AMWJhaHh1+jE9GdA4d
	5ZPOIiDJ2/kFlniRZy1sIHrLG1+Oxj2FA78Pn2mFfcTNaYapxssjre7rKMTIQxHzuhkPab
	WoZUgcnLztL1IfQaRel/8N9IlHU3nOI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745489853;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oXu0xToKAPO25fLhe2rMHBfxuHS/THmrVmv/bkCC9KY=;
	b=uBmBj3A6z5PZfg79qv/WL/gZE5Q/6V6mRY5TBcET26WLX+N/oeOMFdfjxMaGtJ7zamJy8w
	mdqIV88re7KEV6DQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=s4nSWQtC;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=uBmBj3A6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745489853; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oXu0xToKAPO25fLhe2rMHBfxuHS/THmrVmv/bkCC9KY=;
	b=s4nSWQtCo6+QGjsRUDwCGwwpQ/fpa53Eh8lU/LstcikM8KFwYcQ9AMWJhaHh1+jE9GdA4d
	5ZPOIiDJ2/kFlniRZy1sIHrLG1+Oxj2FA78Pn2mFfcTNaYapxssjre7rKMTIQxHzuhkPab
	WoZUgcnLztL1IfQaRel/8N9IlHU3nOI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745489853;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oXu0xToKAPO25fLhe2rMHBfxuHS/THmrVmv/bkCC9KY=;
	b=uBmBj3A6z5PZfg79qv/WL/gZE5Q/6V6mRY5TBcET26WLX+N/oeOMFdfjxMaGtJ7zamJy8w
	mdqIV88re7KEV6DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DA92A139D0;
	Thu, 24 Apr 2025 10:17:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rFqzMrwPCmjTJwAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 24 Apr 2025 10:17:32 +0000
Message-ID: <10fec246-82a6-40bf-a522-ea3de7fa0624@suse.de>
Date: Thu, 24 Apr 2025 12:17:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 08/14] nvmet-fcloop: prevent double port deletion
To: Daniel Wagner <wagi@kernel.org>, James Smart <james.smart@broadcom.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250423-nvmet-fcloop-v5-0-3d7f968728a5@kernel.org>
 <20250423-nvmet-fcloop-v5-8-3d7f968728a5@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250423-nvmet-fcloop-v5-8-3d7f968728a5@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1F4AF1F399
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_TLS_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid,suse.de:email];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250424_031735_221747_49AD6DFC 
X-CRM114-Status: GOOD (  18.47  )
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

On 4/23/25 15:21, Daniel Wagner wrote:
> The delete callback can be called either via the unregister function or
> from the transport directly. Thus it is necessary ensure resources are
> not freed multiple times.
> 
> Signed-off-by: Daniel Wagner <wagi@kernel.org>
> ---
>   drivers/nvme/target/fcloop.c | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
> index 9adaee3c7129f7e270842c5d09f78de2e108479a..014cc66f92cb1db0a81a79d2109eae3fff5fd38a 100644
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
> @@ -1067,14 +1072,20 @@ static void
>   fcloop_remoteport_delete(struct nvme_fc_remote_port *remoteport)
>   {
>   	struct fcloop_rport *rport = remoteport->private;
> +	bool delete_port = true;
>   	unsigned long flags;
>   
>   	flush_work(&rport->ls_work);
>   
>   	spin_lock_irqsave(&fcloop_lock, flags);
> +	if (test_and_set_bit(PORT_DELETED, &rport->flags))
> +		delete_port = false;
>   	rport->nport->rport = NULL;
>   	spin_unlock_irqrestore(&fcloop_lock, flags);
>   
> +	if (!delete_port)
> +		return;
> +

The double negation is hard to follow. Can't you
rename it to 'put_port' or somesuch and invert the logic?

>   	fcloop_nport_put(rport->nport);
>   }
>   
> @@ -1082,14 +1093,20 @@ static void
>   fcloop_targetport_delete(struct nvmet_fc_target_port *targetport)
>   {
>   	struct fcloop_tport *tport = targetport->private;
> +	bool delete_port = true;
>   	unsigned long flags;
>   
>   	flush_work(&tport->ls_work);
>   
>   	spin_lock_irqsave(&fcloop_lock, flags);
> +	if (test_and_set_bit(PORT_DELETED, &tport->flags))
> +		delete_port = false;
>   	tport->nport->tport = NULL;
>   	spin_unlock_irqrestore(&fcloop_lock, flags);
>   
> +	if (!delete_port)
> +		return;
> +
Same here.

>   	fcloop_nport_put(tport->nport);
>   }
>   
> @@ -1433,6 +1450,7 @@ fcloop_create_remote_port(struct device *dev, struct device_attribute *attr,
>   	rport->nport = nport;
>   	rport->lport = nport->lport;
>   	nport->rport = rport;
> +	rport->flags = 0;
>   	spin_lock_init(&rport->lock);
>   	INIT_WORK(&rport->ls_work, fcloop_rport_lsrqst_work);
>   	INIT_LIST_HEAD(&rport->ls_list);
> @@ -1530,6 +1548,7 @@ fcloop_create_target_port(struct device *dev, struct device_attribute *attr,
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

