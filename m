Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 308D0C44501
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jul 2026 07:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=q5vcvurC5b5R8k13ofLciTMPwKkuRHFQKBx8BX3sT94=; b=22hMD4cCae/958g41sHbXveJXp
	0gqOqTeArvKukuk0ipIJhHIN6fHEZPXTqtbo/vC/isxNsDACvUZN2+uaItYLGYkFQjOvjBednl1C9
	bKSzulPMe5nvTwHWNpyLwVBgVHD9w+ARlNNLaxwzgOHKKtDuLxbXYoFBUFp+a9ZAmOJFBFAJ9G+yB
	bjR9leUaRX4wf7Ni5I1QWIYGUfIe24l3r0lRotunpH5aATmHiB4ZKL+yE0M/L84Wy+hFbxCUPkOhG
	tSIZn1jS/IGzUDMsQ4vRPezxVbiBML13emeRxhxlRi5iS864jIT4RFQaC7lltjbN8FUCM2jWb2Zmn
	zfVxrrSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjAp9-00000008Lju-04KY;
	Mon, 13 Jul 2026 07:11:31 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjAp5-00000008Lhb-3ACU
	for linux-nvme@lists.infradead.org;
	Mon, 13 Jul 2026 07:11:29 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B52FE77013;
	Mon, 13 Jul 2026 07:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783926685; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q5vcvurC5b5R8k13ofLciTMPwKkuRHFQKBx8BX3sT94=;
	b=vJq6b1+fU4dVWS8R3YyCCU9jzXYqGbXKhdURVcZUQg1/UPpL2v7HjjBxl/wwQw8xlqllNK
	Bi0xh7hBwSYqbCFj+h0eyubiP7VQaiXpucDsCl+V3WXZtOl80q6q3dzqVID4JNVxdeWeU5
	3IslJPuki2pu6bauEc6Zblx9XbQ2nz4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783926685;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q5vcvurC5b5R8k13ofLciTMPwKkuRHFQKBx8BX3sT94=;
	b=11yqjKEOzKwcztO0lq76CDghV6MHHrXEj8oa+wbFxlznQykxaVx2We6aj4X/FzW6z/v/Tj
	2ozmDi+SRny/vCBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=vJq6b1+f;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=11yqjKEO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783926685; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q5vcvurC5b5R8k13ofLciTMPwKkuRHFQKBx8BX3sT94=;
	b=vJq6b1+fU4dVWS8R3YyCCU9jzXYqGbXKhdURVcZUQg1/UPpL2v7HjjBxl/wwQw8xlqllNK
	Bi0xh7hBwSYqbCFj+h0eyubiP7VQaiXpucDsCl+V3WXZtOl80q6q3dzqVID4JNVxdeWeU5
	3IslJPuki2pu6bauEc6Zblx9XbQ2nz4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783926685;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q5vcvurC5b5R8k13ofLciTMPwKkuRHFQKBx8BX3sT94=;
	b=11yqjKEOzKwcztO0lq76CDghV6MHHrXEj8oa+wbFxlznQykxaVx2We6aj4X/FzW6z/v/Tj
	2ozmDi+SRny/vCBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5F308779AE;
	Mon, 13 Jul 2026 07:11:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lHcSFp2PVGruVgAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 13 Jul 2026 07:11:25 +0000
Message-ID: <b14ee42d-95f4-42d9-8b40-58c0f045b414@suse.de>
Date: Mon, 13 Jul 2026 09:11:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/16] nvme: Implement cross-controller reset
 completion
To: Mohamed Khalfella <mkhalfella@purestorage.com>,
 Justin Tee <justin.tee@broadcom.com>,
 Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
 Paul Ely <paul.ely@broadcom.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 James Smart <jsmart833426@gmail.com>, Randy Jennings
 <randyj@purestorage.com>, Dhaval Giani <dgiani@purestorage.com>
Cc: Aaron Dailey <adailey@purestorage.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260712022437.3743117-1-mkhalfella@purestorage.com>
 <20260712022437.3743117-10-mkhalfella@purestorage.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260712022437.3743117-10-mkhalfella@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[purestorage.com,broadcom.com,gmail.com,nvidia.com,lst.de,kernel.dk,kernel.org,grimberg.me];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
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
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[purestorage.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:dkim,suse.de:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: B52FE77013
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260713_001127_948841_8326B222 
X-CRM114-Status: GOOD (  24.99  )
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

On 7/12/26 4:23 AM, Mohamed Khalfella wrote:
> An nvme source controller that issues CCR command expects to receive an
> NVME_AER_NOTICE_CCR_COMPLETED when pending CCR succeeds or fails. Add
> ctrl->ccr_work to read NVME_LOG_CCR logpage and wakeup threads waiting
> on CCR completion.
> 
> Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> ---
>   drivers/nvme/host/core.c | 50 +++++++++++++++++++++++++++++++++++++++-
>   drivers/nvme/host/nvme.h |  1 +
>   2 files changed, 50 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index a1deffc3cc00..18de3805eff8 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1943,7 +1943,8 @@ EXPORT_SYMBOL_GPL(nvme_set_queue_count);
>   
>   #define NVME_AEN_SUPPORTED \
>   	(NVME_AEN_CFG_NS_ATTR | NVME_AEN_CFG_FW_ACT | \
> -	 NVME_AEN_CFG_ANA_CHANGE | NVME_AEN_CFG_DISC_CHANGE)
> +	 NVME_AEN_CFG_ANA_CHANGE | NVME_AEN_CFG_CCR_COMPLETE | \
> +	 NVME_AEN_CFG_DISC_CHANGE)
>   
>   static void nvme_enable_aen(struct nvme_ctrl *ctrl)
>   {
> @@ -4974,6 +4975,48 @@ static void nvme_get_fw_slot_info(struct nvme_ctrl *ctrl)
>   	kfree(log);
>   }
>   
> +static void nvme_ccr_work(struct work_struct *work)
> +{
> +	struct nvme_ctrl *ctrl = container_of(work, struct nvme_ctrl, ccr_work);
> +	struct nvme_ccr_entry *ccr;
> +	struct nvme_ccr_log_entry *entry;
> +	struct nvme_ccr_log *log;
> +	int num_entries, ret, i;
> +	unsigned long flags;
> +
> +	log = kmalloc_obj(*log);
> +	if (!log)
> +		return;
> +
> +	ret = nvme_get_log(ctrl, 0, NVME_LOG_CCR, 0x01,
> +			   0x00, log, sizeof(*log), 0);
> +	if (ret)
> +		goto out;
> +
> +	spin_lock_irqsave(&ctrl->lock, flags);
> +	num_entries = min(le16_to_cpu(log->ne), NVMF_CCR_PER_PAGE);
> +	for (i = 0; i < num_entries; i++) {
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

I _think_ we need a marker here to figure out if the completion was 
already called. Depending on how often the log gets updated it might
be that we're processing two AENs before the other thread in 
nvme_issue_wait_ccr() is able to process the completion and remove the 
element from the list, in which case we're issuing a double completion.

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
> @@ -5050,6 +5093,9 @@ static bool nvme_handle_aen_notice(struct nvme_ctrl *ctrl, u32 result)
>   	case NVME_AER_NOTICE_DISC_CHANGED:
>   		ctrl->aen_result = result;
>   		break;
> +	case NVME_AER_NOTICE_CCR_COMPLETED:
> +		queue_work(nvme_wq, &ctrl->ccr_work);
> +		break;
>   	default:
>   		dev_warn(ctrl->device, "async event result %08x\n", result);
>   	}
> @@ -5238,6 +5284,7 @@ void nvme_stop_ctrl(struct nvme_ctrl *ctrl)
>   	nvme_stop_failfast_work(ctrl);
>   	flush_work(&ctrl->async_event_work);
>   	cancel_work_sync(&ctrl->fw_act_work);
> +	cancel_work_sync(&ctrl->ccr_work);

Might be good to have a WARN_ON(!list_empty(&ctrl->ccr_list)) here.

>   	if (ctrl->ops->stop_ctrl)
>   		ctrl->ops->stop_ctrl(ctrl);
>   }
> @@ -5363,6 +5410,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
>   	ctrl->quirks = quirks;
>   	ctrl->numa_node = NUMA_NO_NODE;
>   	INIT_WORK(&ctrl->scan_work, nvme_scan_work);
> +	INIT_WORK(&ctrl->ccr_work, nvme_ccr_work);
>   	INIT_WORK(&ctrl->async_event_work, nvme_async_event_work);
>   	INIT_WORK(&ctrl->fw_act_work, nvme_fw_act_work);
>   	INIT_WORK(&ctrl->delete_work, nvme_delete_ctrl_work);
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 90b989302e21..578fedda9946 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -422,6 +422,7 @@ struct nvme_ctrl {
>   	struct nvme_effects_log *effects;
>   	struct xarray cels;
>   	struct work_struct scan_work;
> +	struct work_struct ccr_work;
>   	struct work_struct async_event_work;
>   	struct delayed_work ka_work;
>   	struct delayed_work failfast_work;

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

