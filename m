Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8118C5DF94
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Aug 2026 13:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=90RObd31g9TBKc/D+6/5VvKpf9+Pc9xOd1tLYtrh6HE=; b=1IR59QvohrJx+CPS3R/1r1+WsJ
	j1wmxPGKydpISHCnELk988EcvMyE26BfVCy6knSNCQPgf+kGH8SF8qTGz0PGnsmCxNeH1zkUQNk7p
	yLQmnUM7O7d1so7ELppcFldLMIhrSwKSNxbu/9VP7ykf6It93K0dA3c2KndWUP/oNXtCn/wX9WbG8
	7yAIx+298aZ1bQ9z8f5mk/+9NvxD0+QzLqyJJqWK3LlDMnS1ww/YBEyWBfVywx5E7oDNWR5GrpMTX
	cUHZnmBLQR3krEHwZtFFDyYbKO7GAlNsYSWJWbAYIEoQpLkkobh/HtIbr+rZ6U9GFs4mjTXf+5/UN
	2+nfbZ7w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wyUzc-0000000Gito-0dLo;
	Mon, 24 Aug 2026 13:45:40 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wyUzY-0000000GitU-3TCa
	for linux-nvme@lists.infradead.org;
	Mon, 24 Aug 2026 13:45:38 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A01F8868A6;
	Mon, 24 Aug 2026 13:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1787579130; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=90RObd31g9TBKc/D+6/5VvKpf9+Pc9xOd1tLYtrh6HE=;
	b=ux3jdo3jqBU3O0iijeWHrcO2VgptYxRn/yynqXrAlKjS5K0RscCWli6D9STkh+1bQKLmmV
	infL0tWQRxziGzDEFK/cWPVoJbadA1rZIsz7KsT96DkvBrS97XELCEMV2NPhKTMpc+S9Zr
	8R2+vpWCKrn7NtmLPvon5Tj3nYH5uhA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1787579130;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=90RObd31g9TBKc/D+6/5VvKpf9+Pc9xOd1tLYtrh6HE=;
	b=jsZnbC/H4M6NSB9yGyJB9/nVmSxTZbfVFXHJ0Wu93IYONT3BH3SJ67/9M3K9dib7FFRrsY
	fBJtFD0LXpdm1ICg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=0ZSFilug;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=iqm26zSw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1787579126; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=90RObd31g9TBKc/D+6/5VvKpf9+Pc9xOd1tLYtrh6HE=;
	b=0ZSFilug+jqGP28X3dZOr7CMsBtaImsXJ5wLBoCaUigMPPP0WtNuvRUoQbHojrgj4nMlHD
	rJ7Yz9RV4i0yIogixEKfkqLL4vmiR/DlX2/iIrs0Avk1g2sEk1K1vwct+1yIbMcDx1T+jB
	HFQBE4ukmRCWw4SrIk0prVO4C8GRwUw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1787579126;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=90RObd31g9TBKc/D+6/5VvKpf9+Pc9xOd1tLYtrh6HE=;
	b=iqm26zSwIZ7IuTpJbvGOGzw3u32EMH5KIho5HFsAc7GmlJNv/tYFsKEU/fgfcFMuas8onW
	MnF61/8xB8iTztDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8C2E913331;
	Mon, 24 Aug 2026 13:45:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HsPOIfZKjGqNawAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 24 Aug 2026 13:45:26 +0000
Message-ID: <c3ca9481-8eaa-496b-bdde-38cd911d8f96@suse.de>
Date: Mon, 24 Aug 2026 15:45:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] nvme-mpath: support controller crd when failing over
 request
To: sagi@grimberg.me, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: Daniel Wagner <dwagner@suse.de>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <20260823084903.193188-1-sagi@grimberg.me>
 <20260823084903.193188-5-sagi@grimberg.me>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260823084903.193188-5-sagi@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.994];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[grimberg.me:email,suse.de:email,suse.de:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: A01F8868A6
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260824_064537_185305_A34EED7C 
X-CRM114-Status: GOOD (  26.56  )
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

On 8/23/26 10:49 AM, Sagi Grimberg wrote:
> When failing over a request (due to a path based status) we should
> repect controller crd returned in the nvme completion as much as
> possible. Hence we want to delay the failover command execution by
> the controller crdt.
> 
> We allocate a new nvme_mpath_failover_timer referencing the request
> stolen bios in a staging list, and when the command retry delay expires,
> and only then the bios are moved to the mpath head requeue list which is
> immediately kicked to re-submit these bios. If we failed to allocate
> a fot, we fallback to the existing behavior.
> 
> Given that we now have a new staging list for mpath devices, we drain
> them when removing the device.
> 
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>   drivers/nvme/host/multipath.c | 96 +++++++++++++++++++++++++++++++++--
>   drivers/nvme/host/nvme.h      |  1 +
>   2 files changed, 93 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index b5501217303c..959dd1e05a2d 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -9,6 +9,13 @@
>   #include <trace/events/block.h>
>   #include "nvme.h"
>   
> +struct nvme_mpath_failover_timer {
> +	struct list_head	entry;
> +	struct nvme_ns_head	*head;
> +	struct bio_list		bios;
> +	struct timer_list	timer;
> +};
> +
>   bool multipath = true;
>   static bool multipath_always_on;
>   
> @@ -144,10 +151,48 @@ void nvme_mpath_start_freeze(struct nvme_subsystem *subsys)
>   			blk_freeze_queue_start(h->disk->queue);
>   }
>   
> +static void nvme_mpath_failover_timer_fn(struct timer_list *t)
> +{
> +	struct nvme_mpath_failover_timer *fot = timer_container_of(fot, t, timer);
> +	struct nvme_ns_head *head = fot->head;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&head->requeue_lock, flags);
> +	if (list_empty(&fot->entry)) {
> +		spin_unlock_irqrestore(&head->requeue_lock, flags);
> +		return;
> +	}
> +
> +	list_del_init(&fot->entry);
> +	if (fot->bios.head)
> +		bio_list_merge(&head->requeue_list, &fot->bios);
> +	spin_unlock_irqrestore(&head->requeue_lock, flags);
> +	kblockd_schedule_work(&head->requeue_work);
> +	kfree(fot);
> +}
> +
> +static struct nvme_mpath_failover_timer *
> +nvme_mpath_alloc_failover_timer(struct nvme_ns_head *head)
> +{
> +	struct nvme_mpath_failover_timer *fot;
> +
> +	fot = kzalloc(sizeof(*fot), GFP_ATOMIC);
> +	if (!fot)
> +		goto out;
> +	fot->head = head;
> +	bio_list_init(&fot->bios);
> +	INIT_LIST_HEAD(&fot->entry);
> +	timer_setup(&fot->timer, nvme_mpath_failover_timer_fn, 0);
> +out:
> +	return fot;
> +}
> +
>   void nvme_failover_req(struct request *req)
>   {
>   	struct nvme_ns *ns = req->q->queuedata;
>   	u16 status = nvme_req(req)->status & NVME_SCT_SC_MASK;
> +	struct nvme_mpath_failover_timer *fot = NULL;
> +	unsigned int delay;
>   	unsigned long flags;
>   	struct bio *bio;
>   
> @@ -167,13 +212,27 @@ void nvme_failover_req(struct request *req)
>   	for (bio = req->bio; bio; bio = bio->bi_next)
>   		bio_set_dev(bio, ns->head->disk->part0);
>   
> -	spin_lock_irqsave(&ns->head->requeue_lock, flags);
> -	blk_steal_bios(&ns->head->requeue_list, req);
> -	spin_unlock_irqrestore(&ns->head->requeue_lock, flags);
> +	delay = nvme_crd_msecs(nvme_req(req));
> +	if (delay) {
> +		fot = nvme_mpath_alloc_failover_timer(ns->head);
> +		if (fot) {
> +			blk_steal_bios(&fot->bios, req);
> +			spin_lock_irqsave(&ns->head->requeue_lock, flags);
> +			list_add_tail(&fot->entry, &ns->head->fots);
> +			spin_unlock_irqrestore(&ns->head->requeue_lock, flags);
> +			mod_timer(&fot->timer, jiffies + msecs_to_jiffies(delay));
> +		}
> +	}
> +	/* no CRD or timer allocation failed, fallback to immediate failover */
> +	if (!fot) {
> +		spin_lock_irqsave(&ns->head->requeue_lock, flags);
> +		blk_steal_bios(&ns->head->requeue_list, req);
> +		spin_unlock_irqrestore(&ns->head->requeue_lock, flags);
> +		kblockd_schedule_work(&ns->head->requeue_work);
> +	}

Yikes. Allocation during failover is not going to make you friends.

And this whole mechanism looks pretty similar what we did over at 
implementing CCR. Can you use the mechanism from there?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

