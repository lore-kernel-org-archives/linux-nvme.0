Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B596C43458
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jul 2026 07:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/cQ4BK5ZYe0L/CHmz0yrZawQPbG37QmN0XG7DdY+klo=; b=hsKeedu5af0ahkURDzT4PBjEnH
	oUtCWsyOkGAUuoX6KgcKF0znU6vDEhUdLXQRQNMWjJPHfU5IOX88fnwgPEQ4XeYnNWiQg7d7pw/Ox
	7X3JvNrLVNh9zia3yb9uTXVWMecdrHJDd9OBcLLzctyz8fY5mYsUDHr2WHH61ajY9+DxZWTpZG+LI
	wFTfJ4sA/Xx1ukpTiCIFRRki2SWI1EqOOjIw/MqEh+0S65dXuFdI0mnvQ7Ri6i3hQwmDAKzbm3sYp
	TKp/QE3aQ8JvxguYdzBb+iB28wMwGAunjhVKQZWcacFSQiXo98BTW69d5XgXBGIi7Bf/7BPINGfNT
	qnqwORPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjAiF-00000008KJW-0A8c;
	Mon, 13 Jul 2026 07:04:23 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjAiC-00000008KIu-18ih
	for linux-nvme@lists.infradead.org;
	Mon, 13 Jul 2026 07:04:21 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B0FBC77412;
	Mon, 13 Jul 2026 07:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783926257; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/cQ4BK5ZYe0L/CHmz0yrZawQPbG37QmN0XG7DdY+klo=;
	b=A9sWu9j6rL8Sw29pLXJ5wuG1mWP/S+nlNsdfrqqR0Mkbv3W5al0xKaLmUEoT9VYVS1TDCj
	+iJpMTLTk8CkiYy1U19B1ZGyp2IUb4ccX/zZvbQQ7v1QIZC+paTPrFfI9MIiwg5Y8bBqLx
	gHTl9ab3sbaLWWqzvouwOxNAsOTVOGY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783926257;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/cQ4BK5ZYe0L/CHmz0yrZawQPbG37QmN0XG7DdY+klo=;
	b=BLNojXO35s3+jzuQtwKHGBm5JsrtGM/SyFbneUTUY3NvM50C5986phnIOy6GhLezZKka5H
	PzompB0qV6+PygBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="HlL/wRSk";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=IzLLRm0P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783926255; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/cQ4BK5ZYe0L/CHmz0yrZawQPbG37QmN0XG7DdY+klo=;
	b=HlL/wRSkKKXtoUuy1xkJIcesurFdT+6y48vwySjp3sfg3l8oZQ4QNYTz5iKNllauIRj5nO
	yrmB6MVbvE98Ukg+9u1BKhpR2kHfQivPvPiive12ocDQ+8a+JRs4ZBEr1l8eOPvhL6qJCK
	q2ynWM51sZ75ACF4b5O3YNRn9K0fOxY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783926255;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/cQ4BK5ZYe0L/CHmz0yrZawQPbG37QmN0XG7DdY+klo=;
	b=IzLLRm0PaSIAFbqyZeKpWq7trzSA8qq0DXBuavx537ZdyhYzF4gZHIIxEED0F7BwVzinPy
	WvVyat7hpHjzvTBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D67CB779AE;
	Mon, 13 Jul 2026 07:04:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iZU2M+6NVGpEUAAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 13 Jul 2026 07:04:14 +0000
Message-ID: <30475d09-bba2-460b-bf05-869f355ef106@suse.de>
Date: Mon, 13 Jul 2026 09:04:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 08/16] nvme: Implement cross-controller reset recovery
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
 <20260712022437.3743117-9-mkhalfella@purestorage.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260712022437.3743117-9-mkhalfella@purestorage.com>
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
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[purestorage.com,broadcom.com,gmail.com,nvidia.com,lst.de,kernel.dk,kernel.org,grimberg.me];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[purestorage.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:dkim,suse.de:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: B0FBC77412
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260713_000420_612321_D4CAB2E9 
X-CRM114-Status: GOOD (  33.45  )
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
> A host that has more than one path connecting to an nvme subsystem
> typically has an nvme controller associated with every path. This is
> mostly applicable to nvmeof. If one path goes down, inflight IOs on that
> path should not be retried immediately on another path because this
> could lead to data corruption as described in TP4129. TP8028 defines
> cross-controller reset mechanism that can be used by host to terminate
> IOs on the failed path using one of the remaining healthy paths. Only
> after IOs are terminated, or long enough time passes as defined by
> TP4129, inflight IOs should be retried on another path. Implement core
> cross-controller reset shared logic to be used by the transports.
> 
> Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> ---
>   drivers/nvme/host/constants.c |   1 +
>   drivers/nvme/host/core.c      | 152 ++++++++++++++++++++++++++++++++++
>   drivers/nvme/host/nvme.h      |  10 +++
>   3 files changed, 163 insertions(+)
> 
> diff --git a/drivers/nvme/host/constants.c b/drivers/nvme/host/constants.c
> index dc90df9e13a2..f679efd5110e 100644
> --- a/drivers/nvme/host/constants.c
> +++ b/drivers/nvme/host/constants.c
> @@ -46,6 +46,7 @@ static const char * const nvme_admin_ops[] = {
>   	[nvme_admin_virtual_mgmt] = "Virtual Management",
>   	[nvme_admin_nvme_mi_send] = "NVMe Send MI",
>   	[nvme_admin_nvme_mi_recv] = "NVMe Receive MI",
> +	[nvme_admin_cross_ctrl_reset] = "Cross Controller Reset",
>   	[nvme_admin_dbbuf] = "Doorbell Buffer Config",
>   	[nvme_admin_format_nvm] = "Format NVM",
>   	[nvme_admin_security_send] = "Security Send",
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 1ef4dc38f755..a1deffc3cc00 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -571,6 +571,157 @@ void nvme_cancel_admin_tagset(struct nvme_ctrl *ctrl)
>   }
>   EXPORT_SYMBOL_GPL(nvme_cancel_admin_tagset);
>   
> +static struct nvme_ctrl *nvme_find_ctrl_ccr(struct nvme_ctrl *ictrl,
> +					    u32 min_cntlid)
> +{
> +	struct nvme_subsystem *subsys = ictrl->subsys;
> +	struct nvme_ctrl *ctrl, *sctrl = NULL;
> +	unsigned long flags;
> +	int ccr_used;
> +
> +	mutex_lock(&nvme_subsystems_lock);
> +	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
> +		if (ctrl->cntlid < min_cntlid)
> +			continue;
> +
> +		spin_lock_irqsave(&ctrl->lock, flags);
> +		if (nvme_ctrl_state(ctrl) != NVME_CTRL_LIVE) {
> +			spin_unlock_irqrestore(&ctrl->lock, flags);
> +			continue;
> +		}
> +
> +		ccr_used = atomic_inc_return(&ctrl->ccr_used);
> +		if (ccr_used > ctrl->ccrl) {
> +			atomic_dec(&ctrl->ccr_used);
> +			spin_unlock_irqrestore(&ctrl->lock, flags);
> +			continue;
> +		}
> +
> +		/*
> +		 * We got a good candidate source controller that is locked and
> +		 * LIVE. However, no guarantee ctrl will not be deleted after
> +		 * ctrl->lock is released. Get a ref of both ctrl and admin_q
> +		 * so they do not disappear until we are done with them.
> +		 */
> +		WARN_ON_ONCE(!blk_get_queue(ctrl->admin_q));
> +		nvme_get_ctrl(ctrl);
> +		spin_unlock_irqrestore(&ctrl->lock, flags);
> +		sctrl = ctrl;
> +		break;
> +	}
> +	mutex_unlock(&nvme_subsystems_lock);
> +	return sctrl;
> +}
> +
> +static void nvme_put_ctrl_ccr(struct nvme_ctrl *sctrl)
> +{
> +	atomic_dec(&sctrl->ccr_used);
> +	blk_put_queue(sctrl->admin_q);
> +	nvme_put_ctrl(sctrl);
> +}
> +
> +static int nvme_issue_wait_ccr(struct nvme_ctrl *sctrl, struct nvme_ctrl *ictrl,
> +			       unsigned long deadline)
> +{
> +	struct nvme_ccr_entry ccr = { };
> +	union nvme_result res = { 0 };
> +	struct nvme_command c = { };
> +	unsigned long flags, now, tmo = 0;
> +	bool completed = false;
> +	int ret = 0;
> +	u32 result;
> +
> +	init_completion(&ccr.complete);
> +	ccr.ictrl = ictrl;
> +
> +	spin_lock_irqsave(&sctrl->lock, flags);
> +	list_add_tail(&ccr.list, &sctrl->ccr_list);
> +	spin_unlock_irqrestore(&sctrl->lock, flags);
> +
> +	c.ccr.opcode = nvme_admin_cross_ctrl_reset;
> +	c.ccr.ciu = ictrl->ciu;
> +	c.ccr.icid = cpu_to_le16(ictrl->cntlid);
> +	c.ccr.cirn = cpu_to_le64(ictrl->cirn);
> +	ret = __nvme_submit_sync_cmd(sctrl->admin_q, &c, &res,
> +				     NULL, 0, NVME_QID_ANY, 0);
> +	if (ret) {
> +		ret = -EIO;
> +		goto out;
> +	}
> +
> +	result = le32_to_cpu(res.u32);
> +	if (result & 0x01) /* Immediate Reset Successful */
> +		goto out;
> +
Do we care about any other values of 'result' ?

> +	now = jiffies;
> +	if (time_before(now, deadline))
> +		tmo = min_t(unsigned long,
> +			    secs_to_jiffies(ictrl->kato), deadline - now);
> +

Ideally we would check the request timeout for the CCR to not
exceed 'deadline'.
But as __nvme_submit_sync_cmd() doesn't allow to specify the timeout
I guess it'll be good enough for now.
(And if all goes to plan the CCR command should've been aborted in that
case anyway).

> +	if (!wait_for_completion_timeout(&ccr.complete, tmo)) {
> +		ret = -ETIMEDOUT;
> +		goto out;
> +	}
> +
> +	completed = true;
> +
> +out:
> +	spin_lock_irqsave(&sctrl->lock, flags);
> +	list_del(&ccr.list);
> +	spin_unlock_irqrestore(&sctrl->lock, flags);
> +	if (completed) {
> +		if (ccr.ccrs == NVME_CCR_STATUS_SUCCESS)
> +			return 0;
> +		return -EREMOTEIO;
> +	}
> +	return ret;
> +}
> +
> +unsigned long nvme_fence_ctrl(struct nvme_ctrl *ictrl)
> +{
> +	unsigned long now, deadline, timeout;
> +	struct nvme_ctrl *sctrl;
> +	u32 min_cntlid = 0;
> +	int ret;
> +
> +	timeout = nvme_fence_timeout_ms(ictrl);
> +	dev_info(ictrl->device, "attempting CCR, timeout %lums\n", timeout);
> +
> +	now = jiffies;
> +	deadline = jiffies + msecs_to_jiffies(timeout);
> +	while (time_before(now, deadline)) {
> +		sctrl = nvme_find_ctrl_ccr(ictrl, min_cntlid);
> +		if (!sctrl) {
> +			dev_dbg(ictrl->device,
> +				"failed to find source controller\n");
> +			return deadline - now;
> +		}
> +
> +		ret = nvme_issue_wait_ccr(sctrl, ictrl, deadline);
> +		if (!ret) {
> +			dev_info(ictrl->device, "CCR succeeded using %s\n",
> +				 dev_name(sctrl->device));
> +			nvme_put_ctrl_ccr(sctrl);
> +			return 0;
> +		}
> +
> +		/*
> +		 * CCR command or CCR operation failed on this path.
> +		 * Try another path as long as we have time.
> +		 */
> +		dev_err(ictrl->device, "CCR failed using %s, ret = %d\n",
> +			dev_name(sctrl->device), ret);
> +		min_cntlid = sctrl->cntlid + 1;
> +		nvme_put_ctrl_ccr(sctrl);
> +		now = jiffies;
> +	}
> +
> +	/* Fencing timed out call it done */
> +	dev_info(ictrl->device, "fencing timeout\n");
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(nvme_fence_ctrl);
> +
>   bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
>   		enum nvme_ctrl_state new_state)
>   {
> @@ -5205,6 +5356,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
>   
>   	mutex_init(&ctrl->scan_lock);
>   	INIT_LIST_HEAD(&ctrl->namespaces);
> +	INIT_LIST_HEAD(&ctrl->ccr_list);
>   	xa_init(&ctrl->cels);
>   	ctrl->dev = dev;
>   	ctrl->ops = ops;
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index e558a19781bd..90b989302e21 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -333,6 +333,13 @@ enum nvme_ctrl_flags {
>   	NVME_CTRL_FROZEN		= 6,
>   };
>   
> +struct nvme_ccr_entry {
> +	struct list_head list;
> +	struct completion complete;
> +	struct nvme_ctrl *ictrl;
> +	u8 ccrs;
> +};
> +
>   struct nvme_ctrl {
>   	bool comp_seen;
>   	bool identified;
> @@ -350,6 +357,7 @@ struct nvme_ctrl {
>   	struct blk_mq_tag_set *tagset;
>   	struct blk_mq_tag_set *admin_tagset;
>   	struct list_head namespaces;
> +	struct list_head ccr_list;
>   	struct mutex namespaces_lock;
>   	struct srcu_struct srcu;
>   	struct device ctrl_device;
> @@ -393,6 +401,7 @@ struct nvme_ctrl {
>   	u16 sqsize;
>   	u32 max_namespaces;
>   	atomic_t abort_limit;
> +	atomic_t ccr_used;
>   	u8 ccrl;
>   	u8 vwc;
>   	u32 vs;
> @@ -887,6 +896,7 @@ blk_status_t nvme_host_path_error(struct request *req);
>   bool nvme_cancel_request(struct request *req, void *data);
>   void nvme_cancel_tagset(struct nvme_ctrl *ctrl);
>   void nvme_cancel_admin_tagset(struct nvme_ctrl *ctrl);
> +unsigned long nvme_fence_ctrl(struct nvme_ctrl *ctrl);
>   bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
>   		enum nvme_ctrl_state new_state);
>   int nvme_disable_ctrl(struct nvme_ctrl *ctrl, bool shutdown);

Otherwise looks good.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

