Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09C17FB3D00
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Mar 2026 10:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=urSal8qoThhTsrBhS3BhhSs0CexUrhkjGM+o3UavJVo=; b=wIOvT+VbxuT2n9F4b72FC23zvR
	Y7MWphukZwRBmjOugj6ja75jlF0VEWjLoz6uTdoNlLSowbtQGwPX6YKPsg/WBYCRDQX9pZdQqyrZx
	6YCIQTqZh5E70c7CSA4sNJuxXJi9LdARn1yPgQjk+LbzssAnFR2yebaQkMA8wPysRcpDcPQFRGIbN
	qPmSumb/RXFphDFxN3HIXdZigRsW5YNSBwLSQKY7GOb8ZNPnljqQ3Kx+qe4h1x7LCYaF0Vlj44V6k
	CwZnuEg4+ZTeWG0mKIBG8bGfLrTwPtAJND18Ia7qkQloItNbaFOTjXBOS2LPjcF/nhVZbCdm7/uN8
	4/rvNNgg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7AF7-0000000B6fL-21DN;
	Mon, 30 Mar 2026 10:53:13 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7AF6-0000000B6el-16f9
	for linux-nvme@bombadil.infradead.org;
	Mon, 30 Mar 2026 10:53:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=urSal8qoThhTsrBhS3BhhSs0CexUrhkjGM+o3UavJVo=; b=D4cZADpnnnYiFnXTHVQtzADsX7
	Hnh9i6fey1ftWB7eR+XI428CPnNd4pBhHY/YRsafPxwwLxu5cAl+AuxeszzHx1bX0wJsqpSUytto4
	amNYqCdVLIBbOpBqhGItmNTOV/0ohg68Xtk9UkQmVuchfcuHPXS83qbrv33EjSU9SHlenFw+arNyT
	WBgWDUc5L4sq+dPoEUaarhRze1jew1NmNor0V6fKiUEtt8+iCsuHb4lOZJe1LZAbJMhuO0N2QL/SI
	+1DNMNxlmrnPlfMmE1T4iErM3ULOmWQNH5tTUX+dd0DJ16ojwFXNBKynm4Syl0l3hQ4oSNhaGHX/N
	Yun7EY9w==;
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7AF3-0000000DdXr-20n7
	for linux-nvme@lists.infradead.org;
	Mon, 30 Mar 2026 10:53:11 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4C5CB4D1F1;
	Mon, 30 Mar 2026 10:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774867988; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=urSal8qoThhTsrBhS3BhhSs0CexUrhkjGM+o3UavJVo=;
	b=d5Gre52m3bjEFP2mS1CV2pqHwxUL8jeL1dIvyx/ZFNFcN5Ep3BatRi/Yv5CVltgtwvmLo4
	uMozEvIWCG8ZuVl/Ta4ViCw7lHUqjKrBc/NFristU0HMcLzWFACLeR5jRJqPxvrt8hs7e/
	1mf09TGbjvBvgAir8899QOtXZOPZmI4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774867988;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=urSal8qoThhTsrBhS3BhhSs0CexUrhkjGM+o3UavJVo=;
	b=JQZhghPnNuGp0Nfc7/EE4gyjWODYsq2Oe7/WQ9qUkcY3vs8V5uRu+Vn9GOzF/+Q0x9G0ii
	fMK1AK0ewimTpxDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=d5Gre52m;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=JQZhghPn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774867988; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=urSal8qoThhTsrBhS3BhhSs0CexUrhkjGM+o3UavJVo=;
	b=d5Gre52m3bjEFP2mS1CV2pqHwxUL8jeL1dIvyx/ZFNFcN5Ep3BatRi/Yv5CVltgtwvmLo4
	uMozEvIWCG8ZuVl/Ta4ViCw7lHUqjKrBc/NFristU0HMcLzWFACLeR5jRJqPxvrt8hs7e/
	1mf09TGbjvBvgAir8899QOtXZOPZmI4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774867988;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=urSal8qoThhTsrBhS3BhhSs0CexUrhkjGM+o3UavJVo=;
	b=JQZhghPnNuGp0Nfc7/EE4gyjWODYsq2Oe7/WQ9qUkcY3vs8V5uRu+Vn9GOzF/+Q0x9G0ii
	fMK1AK0ewimTpxDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 03F6C4A0A2;
	Mon, 30 Mar 2026 10:53:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3GxbOxNWymlveQAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 30 Mar 2026 10:53:07 +0000
Message-ID: <73a9c0e2-ecd0-4170-8723-259529617ec0@suse.de>
Date: Mon, 30 Mar 2026 12:53:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/15] nvme: Implement cross-controller reset
 completion
To: Mohamed Khalfella <mkhalfella@purestorage.com>,
 Justin Tee <justin.tee@broadcom.com>,
 Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
 Paul Ely <paul.ely@broadcom.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, James Smart <jsmart833426@gmail.com>
Cc: Aaron Dailey <adailey@purestorage.com>,
 Randy Jennings <randyj@purestorage.com>,
 Dhaval Giani <dgiani@purestorage.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260328004518.1729186-1-mkhalfella@purestorage.com>
 <20260328004518.1729186-10-mkhalfella@purestorage.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260328004518.1729186-10-mkhalfella@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[purestorage.com,broadcom.com,gmail.com,nvidia.com,kernel.dk,kernel.org,grimberg.me];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:mid,suse.de:email,purestorage.com:email]
X-Rspamd-Queue-Id: 4C5CB4D1F1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260330_115309_659139_A2A20314 
X-CRM114-Status: GOOD (  25.62  )
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

On 3/28/26 01:43, Mohamed Khalfella wrote:
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
> index 5603ae36444f..793f203bfc38 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1920,7 +1920,8 @@ EXPORT_SYMBOL_GPL(nvme_set_queue_count);
>   
>   #define NVME_AEN_SUPPORTED \
>   	(NVME_AEN_CFG_NS_ATTR | NVME_AEN_CFG_FW_ACT | \
> -	 NVME_AEN_CFG_ANA_CHANGE | NVME_AEN_CFG_DISC_CHANGE)
> +	 NVME_AEN_CFG_ANA_CHANGE | NVME_AEN_CFG_CCR_COMPLETE | \
> +	 NVME_AEN_CFG_DISC_CHANGE)
>   
>   static void nvme_enable_aen(struct nvme_ctrl *ctrl)
>   {
> @@ -4873,6 +4874,47 @@ static void nvme_get_fw_slot_info(struct nvme_ctrl *ctrl)
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
> @@ -4949,6 +4991,9 @@ static bool nvme_handle_aen_notice(struct nvme_ctrl *ctrl, u32 result)
>   	case NVME_AER_NOTICE_DISC_CHANGED:
>   		ctrl->aen_result = result;
>   		break;
> +	case NVME_AER_NOTICE_CCR_COMPLETED:
> +		queue_work(nvme_wq, &ctrl->ccr_work);
> +		break;
>   	default:
>   		dev_warn(ctrl->device, "async event result %08x\n", result);
>   	}
> @@ -5144,6 +5189,7 @@ void nvme_stop_ctrl(struct nvme_ctrl *ctrl)
>   	nvme_stop_failfast_work(ctrl);
>   	flush_work(&ctrl->async_event_work);
>   	cancel_work_sync(&ctrl->fw_act_work);
> +	cancel_work_sync(&ctrl->ccr_work);
>   	if (ctrl->ops->stop_ctrl)
>   		ctrl->ops->stop_ctrl(ctrl);
>   }
> @@ -5267,6 +5313,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
>   	ctrl->quirks = quirks;
>   	ctrl->numa_node = NUMA_NO_NODE;
>   	INIT_WORK(&ctrl->scan_work, nvme_scan_work);
> +	INIT_WORK(&ctrl->ccr_work, nvme_ccr_work);
>   	INIT_WORK(&ctrl->async_event_work, nvme_async_event_work);
>   	INIT_WORK(&ctrl->fw_act_work, nvme_fw_act_work);
>   	INIT_WORK(&ctrl->delete_work, nvme_delete_ctrl_work);
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index f2bcff9ccd25..776ee8aa5a93 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -419,6 +419,7 @@ struct nvme_ctrl {
>   	struct nvme_effects_log *effects;
>   	struct xarray cels;
>   	struct work_struct scan_work;
> +	struct work_struct ccr_work;
>   	struct work_struct async_event_work;
>   	struct delayed_work ka_work;
>   	struct delayed_work failfast_work;

Hmm. The 'nvme_fence_ctrl' operation introduced in the previous patch
is synchronous, yet in this patch we're looking a a log page to figure
out if the cross-controller reset is complete.
Which is slightly irritating.
Wouldn't it be better to make the 'nvme_fence_ctrl' operation 
asynchronous, and then have a separate function to wait for the fence
operation to complete (which then could look at log pages etc)?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

