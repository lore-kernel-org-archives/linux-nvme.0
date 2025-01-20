Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E087C02182
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Jan 2025 13:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VZ0v0cbd64ZPwrdtfH3jB4fEvOB3Hxf44zv6kyBDS38=; b=1VWL1LNYAOCi2/Uz3JjNhNK6y7
	K1eWScj2bXP5hfQDK7Hin+AYs4cOfEM3b0zDsXg6mt7K+uq+8DNj1FKBUvWmj+LZXvaQthSUp1ZbF
	n4gCrboLKJspBOcyT1sFQ897qHYTDfJ6EZyKO7jYUmrZY2zms073t+iL0IyewUNPzUs7T4Jhu4cgc
	p6u0ZCFHAQLdE4975iZQyFH2flTxujQsvgsr5dUhf+l0umoHwGgGerWGN16jFw2l8DpkbYUA7Bitc
	ILkPHJICFrzigIqsRPfyHTrssWd+J3Tr7tiAR9uEct8VXWyBXkxdtxsbLQtXc0sPCPkRPlgdOFDSG
	1QjYQ0Tw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tZsBd-00000005i1w-1HKw;
	Mon, 20 Jan 2025 13:51:29 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tZsBa-00000005i0h-2qYv
	for linux-nvme@lists.infradead.org;
	Mon, 20 Jan 2025 13:51:27 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 213C321188;
	Mon, 20 Jan 2025 13:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1737381085; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VZ0v0cbd64ZPwrdtfH3jB4fEvOB3Hxf44zv6kyBDS38=;
	b=XNmU3sVLs5h7vpQTd99JlcY5B5HFLpXlYF+gZeXfJeISgTrrK3hxWCEHMFgqLmW3BtrQFC
	JNnLPWLbAyyWH9E+6PHFeuX5PR5VSfTA0Rj7TIXB7oyeq1HKu2Zh4WoTZMSTMKkNo6JBYc
	huQZ/gFYSNS5quUR+vYLEnkta2jA7Uw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1737381085;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VZ0v0cbd64ZPwrdtfH3jB4fEvOB3Hxf44zv6kyBDS38=;
	b=S40R48lnPVe48u1diC/by1bfckfCv8tTGuGQGV5RiKucRDg0mXlt7PnMMBKqYr3DGH52Ro
	l+V5wFnHajdkPmBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=XNmU3sVL;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=S40R48ln
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1737381085; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VZ0v0cbd64ZPwrdtfH3jB4fEvOB3Hxf44zv6kyBDS38=;
	b=XNmU3sVLs5h7vpQTd99JlcY5B5HFLpXlYF+gZeXfJeISgTrrK3hxWCEHMFgqLmW3BtrQFC
	JNnLPWLbAyyWH9E+6PHFeuX5PR5VSfTA0Rj7TIXB7oyeq1HKu2Zh4WoTZMSTMKkNo6JBYc
	huQZ/gFYSNS5quUR+vYLEnkta2jA7Uw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1737381085;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VZ0v0cbd64ZPwrdtfH3jB4fEvOB3Hxf44zv6kyBDS38=;
	b=S40R48lnPVe48u1diC/by1bfckfCv8tTGuGQGV5RiKucRDg0mXlt7PnMMBKqYr3DGH52Ro
	l+V5wFnHajdkPmBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 084B41393E;
	Mon, 20 Jan 2025 13:51:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IuGNAd1UjmcPBQAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 20 Jan 2025 13:51:25 +0000
Message-ID: <ace57dd5-76ad-4c8d-9cfb-97ce3105f709@suse.de>
Date: Mon, 20 Jan 2025 14:51:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] nvme-fc: move tagset removal to nvme_fc_delete_ctrl()
To: Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
Cc: Marco Patalano <mpatalan@redhat.com>, Ewan Milne <emilne@redhat.com>,
 James Smart <james.smart@broadcom.com>, Sagi Grimberg <sagi@grimberg.me>
References: <20250113124446.830697-1-ming.lei@redhat.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250113124446.830697-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 213C321188
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250120_055126_862501_C3D101FB 
X-CRM114-Status: GOOD (  23.01  )
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

On 1/13/25 13:44, Ming Lei wrote:
> Now target is removed from nvme_fc_ctrl_free() which is the ctrl->ref
> release handler. And even admin queue is unquiesced there, this way
> is definitely wrong because the ctr->ref is grabbed when submitting
> command.
> 
> And Marco observed that nvme_fc_ctrl_free() can be called from request
> completion code path, and trigger kernel warning since request completes
> from softirq context.
> 
> Fix the issue by moveing target removal into nvme_fc_delete_ctrl(),
> which is also aligned with nvme-tcp and nvme-rdma.
> 
> Cc: Marco Patalano <mpatalan@redhat.com>
> Cc: Ewan Milne <emilne@redhat.com>
> Cc: James Smart <james.smart@broadcom.com>
> Cc: Sagi Grimberg <sagi@grimberg.me>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   drivers/nvme/host/fc.c | 13 +++++++------
>   1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index b81af7919e94..b94b4e50a3df 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -2389,17 +2389,11 @@ nvme_fc_ctrl_free(struct kref *ref)
>   		container_of(ref, struct nvme_fc_ctrl, ref);
>   	unsigned long flags;
>   
> -	if (ctrl->ctrl.tagset)
> -		nvme_remove_io_tag_set(&ctrl->ctrl);
> -
>   	/* remove from rport list */
>   	spin_lock_irqsave(&ctrl->rport->lock, flags);
>   	list_del(&ctrl->ctrl_list);
>   	spin_unlock_irqrestore(&ctrl->rport->lock, flags);
>   
> -	nvme_unquiesce_admin_queue(&ctrl->ctrl);
> -	nvme_remove_admin_tag_set(&ctrl->ctrl);
> -
>   	kfree(ctrl->queues);
>   
>   	put_device(ctrl->dev);
> @@ -3288,6 +3282,13 @@ nvme_fc_delete_ctrl(struct nvme_ctrl *nctrl)
>   
>   	cancel_work_sync(&ctrl->ioerr_work);
>   	cancel_delayed_work_sync(&ctrl->connect_work);
> +
> +	if (ctrl->ctrl.tagset)
> +		nvme_remove_io_tag_set(&ctrl->ctrl);
> +
> +	nvme_unquiesce_admin_queue(&ctrl->ctrl);
> +	nvme_remove_admin_tag_set(&ctrl->ctrl);
> +
>   	/*
>   	 * kill the association on the link side.  this will block
>   	 * waiting for io to terminate

Not sure that'll work. We're waiting for I/Os to complete just after
the line in the last hunk, and I guess the need a tagset to complete
properly.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

