Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDBE9E7BDB4
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Feb 2026 12:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=su/eNUf9k4VMpABYO53mrDFUBLZV2iut+Ge0IW9bDB0=; b=zRkAjG+i+EoeC5rysTdCGrRTth
	2Y0yU5TlsJCstCYEp/tWvybCZgyUm4frpMVsN1ZcA6Glqq6Owv+iKAQ3jWm78kU521+I2QRVtXh0o
	meh3qeOBUN3oVxoq+/+IPaJTl40+9XhfBB0N6Eiq/1I5ScCMefpBOlh5v3acz4zCEZSaBV06Zy1Wa
	LpDsnWgqv1QS99W1a84WSWJj+nVgTw1biIgW0tx3SvfS3jt3Hdi3OyHh+1tpIvP8jcXcza5vNRTKK
	lZOV3if07nLMRtwef+a2CsAY5ihgwOt02UPtmGK/VmtoyCHvNKb0YEdbKEuDxGf8L3s1PzKb6sG9K
	RkwRy7QQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vrxxG-00000006Xdq-3vii;
	Mon, 16 Feb 2026 12:43:58 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vrxxE-00000006XdG-1Dzs
	for linux-nvme@lists.infradead.org;
	Mon, 16 Feb 2026 12:43:57 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 38C833E87F;
	Mon, 16 Feb 2026 12:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771245834; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=su/eNUf9k4VMpABYO53mrDFUBLZV2iut+Ge0IW9bDB0=;
	b=pbH0IOwVlFqfNwlYAMnngj2i37il2yIk4bm5h0xK0NqXbxuODt5WZER9kytv8O1tLJ+cb2
	MJFldH7BomA4/1WRL+zdL+SPER5KZ4qSnXwrzO/MUcbrL7e0WFrR2hCFHovZeNyj0a2dUp
	GAIpCTcrcX1lIwHON23fEw0v4o8xAko=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771245834;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=su/eNUf9k4VMpABYO53mrDFUBLZV2iut+Ge0IW9bDB0=;
	b=GIDyEL9Fy3h/3AZmifmoz22vDLV5yc6ii1snWc6V4wE0++jjiu2kXz0WFzT8BSemHEwulI
	jj+fAJ4b0Nmmu8Cg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=pbH0IOwV;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=GIDyEL9F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771245834; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=su/eNUf9k4VMpABYO53mrDFUBLZV2iut+Ge0IW9bDB0=;
	b=pbH0IOwVlFqfNwlYAMnngj2i37il2yIk4bm5h0xK0NqXbxuODt5WZER9kytv8O1tLJ+cb2
	MJFldH7BomA4/1WRL+zdL+SPER5KZ4qSnXwrzO/MUcbrL7e0WFrR2hCFHovZeNyj0a2dUp
	GAIpCTcrcX1lIwHON23fEw0v4o8xAko=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771245834;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=su/eNUf9k4VMpABYO53mrDFUBLZV2iut+Ge0IW9bDB0=;
	b=GIDyEL9Fy3h/3AZmifmoz22vDLV5yc6ii1snWc6V4wE0++jjiu2kXz0WFzT8BSemHEwulI
	jj+fAJ4b0Nmmu8Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D9B3E3EA62;
	Mon, 16 Feb 2026 12:43:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0LNoNAkRk2k+PwAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 16 Feb 2026 12:43:53 +0000
Message-ID: <3b21ccbd-7948-436b-8faa-a5541c65946a@suse.de>
Date: Mon, 16 Feb 2026 13:43:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/21] nvme: Implement cross-controller reset
 completion
To: Mohamed Khalfella <mkhalfella@purestorage.com>,
 Justin Tee <justin.tee@broadcom.com>,
 Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
 Paul Ely <paul.ely@broadcom.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 James Smart <jsmart833426@gmail.com>
Cc: Aaron Dailey <adailey@purestorage.com>,
 Randy Jennings <randyj@purestorage.com>,
 Dhaval Giani <dgiani@purestorage.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260214042753.4073668-1-mkhalfella@purestorage.com>
 <20260214042753.4073668-10-mkhalfella@purestorage.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260214042753.4073668-10-mkhalfella@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[purestorage.com,broadcom.com,gmail.com,nvidia.com,lst.de,kernel.dk,kernel.org,grimberg.me];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 38C833E87F
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260216_044356_484763_ECDAE66F 
X-CRM114-Status: GOOD (  24.09  )
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

On 2/14/26 05:25, Mohamed Khalfella wrote:
> An nvme source controller that issues CCR command expects to receive an
> NVME_AER_NOTICE_CCR_COMPLETED when pending CCR succeeds or fails. Add
> sctrl->ccr_work to read NVME_LOG_CCR logpage and wakeup any thread
> waiting on CCR completion.
> 
> Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> ---
>   drivers/nvme/host/core.c | 49 +++++++++++++++++++++++++++++++++++++++-
>   drivers/nvme/host/nvme.h |  1 +
>   2 files changed, 49 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 765b1524b3ed..a9fcde1b411b 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1916,7 +1916,8 @@ EXPORT_SYMBOL_GPL(nvme_set_queue_count);
>   
>   #define NVME_AEN_SUPPORTED \
>   	(NVME_AEN_CFG_NS_ATTR | NVME_AEN_CFG_FW_ACT | \
> -	 NVME_AEN_CFG_ANA_CHANGE | NVME_AEN_CFG_DISC_CHANGE)
> +	 NVME_AEN_CFG_ANA_CHANGE | NVME_AEN_CFG_CCR_COMPLETE | \
> +	 NVME_AEN_CFG_DISC_CHANGE)
>   
>   static void nvme_enable_aen(struct nvme_ctrl *ctrl)
>   {
> @@ -4880,6 +4881,47 @@ static void nvme_get_fw_slot_info(struct nvme_ctrl *ctrl)
>   	kfree(log);
>   }
>   
> +static void nvme_ccr_work(struct work_struct *work)
> +{
> +	struct nvme_ctrl *ctrl = container_of(work, struct nvme_ctrl, ccr_work);
> +	struct nvme_ccr_entry *ccr;
> +	struct nvme_ccr_log_entry *entry;
> +	struct nvme_ccr_log *log;
> +	unsigned long flags;
> +	int ret, i;
> +
> +	log = kmalloc(sizeof(*log), GFP_KERNEL);
> +	if (!log)
> +		return;
> +
> +	ret = nvme_get_log(ctrl, 0, NVME_LOG_CCR, 0x01,
> +			   0x00, log, sizeof(*log), 0);
> +	if (ret)
> +		goto out;
> +
> +	spin_lock_irqsave(&ctrl->lock, flags);
> +	for (i = 0; i < le16_to_cpu(log->ne); i++) {
> +		entry = &log->entries[i];
> +		if (entry->ccrs == NVME_CCR_STATUS_IN_PROGRESS)
> +			continue;
> +
> +		list_for_each_entry(ccr, &ctrl->ccr_list, list) {
> +			struct nvme_ctrl *ictrl = ccr->ictrl;
> +
> +			if (ictrl->cntlid != le16_to_cpu(entry->icid) ||
> +			    ictrl->ciu != entry->ciu)
> +				continue;
> +
> +			/* Complete matching entry */
> +			ccr->ccrs = entry->ccrs;
> +			complete(&ccr->complete);
> +		}
> +	}
> +	spin_unlock_irqrestore(&ctrl->lock, flags);
> +out:
> +	kfree(log);
> +}
> +
>   static void nvme_fw_act_work(struct work_struct *work)
>   {
>   	struct nvme_ctrl *ctrl = container_of(work,
> @@ -4956,6 +4998,9 @@ static bool nvme_handle_aen_notice(struct nvme_ctrl *ctrl, u32 result)
>   	case NVME_AER_NOTICE_DISC_CHANGED:
>   		ctrl->aen_result = result;
>   		break;
> +	case NVME_AER_NOTICE_CCR_COMPLETED:
> +		queue_work(nvme_wq, &ctrl->ccr_work);
> +		break;
>   	default:
>   		dev_warn(ctrl->device, "async event result %08x\n", result);
>   	}
> @@ -5145,6 +5190,7 @@ void nvme_stop_ctrl(struct nvme_ctrl *ctrl)
>   	nvme_stop_failfast_work(ctrl);
>   	flush_work(&ctrl->async_event_work);
>   	cancel_work_sync(&ctrl->fw_act_work);
> +	cancel_work_sync(&ctrl->ccr_work);
>   	if (ctrl->ops->stop_ctrl)
>   		ctrl->ops->stop_ctrl(ctrl);
>   }
> @@ -5268,6 +5314,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
>   	ctrl->quirks = quirks;
>   	ctrl->numa_node = NUMA_NO_NODE;
>   	INIT_WORK(&ctrl->scan_work, nvme_scan_work);
> +	INIT_WORK(&ctrl->ccr_work, nvme_ccr_work);
>   	INIT_WORK(&ctrl->async_event_work, nvme_async_event_work);
>   	INIT_WORK(&ctrl->fw_act_work, nvme_fw_act_work);
>   	INIT_WORK(&ctrl->delete_work, nvme_delete_ctrl_work);
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index f3ab9411cac5..af6a4e83053e 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -365,6 +365,7 @@ struct nvme_ctrl {
>   	struct nvme_effects_log *effects;
>   	struct xarray cels;
>   	struct work_struct scan_work;
> +	struct work_struct ccr_work;
>   	struct work_struct async_event_work;
>   	struct delayed_work ka_work;
>   	struct delayed_work failfast_work;

We really would need some indicator whether 'ccr' is supported at all.
Using the number of available CCR commands would be an option, if though
that would require us to keep two counters (one for the number of
possible outstanding CCRs, and one for the number of actual outstanding
CCRs.).

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

