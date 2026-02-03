Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7E70E83054
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Feb 2026 05:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DejLwaTkGlL5rspQzW5pEIuKX3w5zGUKbElTQJdV2Sk=; b=CXYbRsO8siCAPaFjjO3MP8NISU
	BsQR1VUNue9CZD1m/WeJIDTfW6PYh6OvFxtB6pM/X0BlXzc7vv365DBqI2sPPTb6Gh7HiL5BP8gO1
	MQkXPyNclJ/cFuWm4p0O5yluRigNcMPtuvibwIzaeeCFsAQX9AZVhlmOJNJc0I5KGRv1VdpKwZiFH
	kT7bs5GikvS5Kiusb+oy5Pe4CiLCu1sFXR0lTAO7JNV45K7pF+jtrpF0D1DhWt497uS4Ey+Fh5tcV
	5ho7zsgySwNfAMhsC1PEpKxi2tifBRBAFk8d0YFQyBZGOpu7u9fFuoPnTQyHqz6QO8CZUJWvtnFZc
	LfsH2G0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vn8pX-000000065Zr-2sev;
	Tue, 03 Feb 2026 05:20:03 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vn8pV-000000065ZC-0wnV
	for linux-nvme@lists.infradead.org;
	Tue, 03 Feb 2026 05:20:02 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 046DA3E6CB;
	Tue,  3 Feb 2026 05:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770095999; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DejLwaTkGlL5rspQzW5pEIuKX3w5zGUKbElTQJdV2Sk=;
	b=EZSH1GqFNwzF+rhwPjQofnirqf/pDIUHxUT5OatRCh+ut6EzWtOmJv4/9H65qz5tt6rF6A
	oZnnrlR1M6uIAHkSh+XCzN+7jyG8ZVgLnrK49P4I9vMQI0ITikVs+0UZBlDLWMLBT3GwFy
	X78+kYB00WmKhYKXrAzOXa7Cs4LZ8MI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770095999;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DejLwaTkGlL5rspQzW5pEIuKX3w5zGUKbElTQJdV2Sk=;
	b=kQf27y3vE3AIDI9RsvvNj6YhB7o5glbRJc9Ug8K2LyLvDh/AdpIInUd9W19OYPYiIs9kVB
	3hlqlfUaGdwQCmBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=EZSH1GqF;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=kQf27y3v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770095999; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DejLwaTkGlL5rspQzW5pEIuKX3w5zGUKbElTQJdV2Sk=;
	b=EZSH1GqFNwzF+rhwPjQofnirqf/pDIUHxUT5OatRCh+ut6EzWtOmJv4/9H65qz5tt6rF6A
	oZnnrlR1M6uIAHkSh+XCzN+7jyG8ZVgLnrK49P4I9vMQI0ITikVs+0UZBlDLWMLBT3GwFy
	X78+kYB00WmKhYKXrAzOXa7Cs4LZ8MI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770095999;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DejLwaTkGlL5rspQzW5pEIuKX3w5zGUKbElTQJdV2Sk=;
	b=kQf27y3vE3AIDI9RsvvNj6YhB7o5glbRJc9Ug8K2LyLvDh/AdpIInUd9W19OYPYiIs9kVB
	3hlqlfUaGdwQCmBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 795ED3EA62;
	Tue,  3 Feb 2026 05:19:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RobvDHqFgWmICAAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 03 Feb 2026 05:19:54 +0000
Message-ID: <528a39a9-f087-461f-9f5b-c4b5821396b6@suse.de>
Date: Tue, 3 Feb 2026 06:19:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/14] nvme: Implement cross-controller reset recovery
To: Mohamed Khalfella <mkhalfella@purestorage.com>,
 Justin Tee <justin.tee@broadcom.com>,
 Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
 Paul Ely <paul.ely@broadcom.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>
Cc: Aaron Dailey <adailey@purestorage.com>,
 Randy Jennings <randyj@purestorage.com>,
 Dhaval Giani <dgiani@purestorage.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260130223531.2478849-1-mkhalfella@purestorage.com>
 <20260130223531.2478849-9-mkhalfella@purestorage.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260130223531.2478849-9-mkhalfella@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	URIBL_BLOCKED(0.00)[suse.de:mid,suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,purestorage.com:email];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[purestorage.com,broadcom.com,gmail.com,nvidia.com,lst.de,kernel.dk,kernel.org,grimberg.me];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,suse.de:email]
X-Rspamd-Queue-Id: 046DA3E6CB
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260202_212001_419367_1E561614 
X-CRM114-Status: GOOD (  35.45  )
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

On 1/30/26 23:34, Mohamed Khalfella wrote:
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
>   drivers/nvme/host/core.c      | 129 ++++++++++++++++++++++++++++++++++
>   drivers/nvme/host/nvme.h      |   9 +++
>   3 files changed, 139 insertions(+)
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
> index 3e1e02822dd4..13e0775d56b4 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -554,6 +554,134 @@ void nvme_cancel_admin_tagset(struct nvme_ctrl *ctrl)
>   }
>   EXPORT_SYMBOL_GPL(nvme_cancel_admin_tagset);
>   
> +static struct nvme_ctrl *nvme_find_ctrl_ccr(struct nvme_ctrl *ictrl,
> +					    u32 min_cntlid)
> +{
> +	struct nvme_subsystem *subsys = ictrl->subsys;
> +	struct nvme_ctrl *sctrl;
> +	unsigned long flags;
> +
> +	mutex_lock(&nvme_subsystems_lock);
> +	list_for_each_entry(sctrl, &subsys->ctrls, subsys_entry) {
> +		if (sctrl->cntlid < min_cntlid)
> +			continue;
> +
> +		if (atomic_dec_if_positive(&sctrl->ccr_limit) < 0)
> +			continue;
> +
> +		spin_lock_irqsave(&sctrl->lock, flags);
> +		if (sctrl->state != NVME_CTRL_LIVE) {
> +			spin_unlock_irqrestore(&sctrl->lock, flags);
> +			atomic_inc(&sctrl->ccr_limit);
> +			continue;
> +		}
> +
> +		/*
> +		 * We got a good candidate source controller that is locked and
> +		 * LIVE. However, no guarantee sctrl will not be deleted after
> +		 * sctrl->lock is released. Get a ref of both sctrl and admin_q
> +		 * so they do not disappear until we are done with them.
> +		 */
> +		WARN_ON_ONCE(!blk_get_queue(sctrl->admin_q));
> +		nvme_get_ctrl(sctrl);
> +		spin_unlock_irqrestore(&sctrl->lock, flags);
> +		goto found;
> +	}
> +	sctrl = NULL;
> +found:

Normally one would be using a temporary loop variable and assign 'sctrl' 
to that one if found. Then you can just call 'break' and drop the 'goto'.

> +	mutex_unlock(&nvme_subsystems_lock);
> +	return sctrl;
> +}
> +
> +static void nvme_put_ctrl_ccr(struct nvme_ctrl *sctrl)
> +{
> +	atomic_inc(&sctrl->ccr_limit);
> +	blk_put_queue(sctrl->admin_q);
> +	nvme_put_ctrl(sctrl);
> +}
> +
> +static int nvme_issue_wait_ccr(struct nvme_ctrl *sctrl, struct nvme_ctrl *ictrl)
> +{
> +	struct nvme_ccr_entry ccr = { };
> +	union nvme_result res = { 0 };
> +	struct nvme_command c = { };
> +	unsigned long flags, tmo;
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
> +	if (ret)
> +		goto out;
> +
> +	result = le32_to_cpu(res.u32);
> +	if (result & 0x01) /* Immediate Reset Successful */
> +		goto out;
> +
> +	tmo = msecs_to_jiffies(max(ictrl->cqt, ictrl->kato * 1000));
> +	if (!wait_for_completion_timeout(&ccr.complete, tmo)) {
> +		ret = -ETIMEDOUT;
> +		goto out;
> +	}
> +
> +	if (ccr.ccrs != NVME_CCR_STATUS_SUCCESS)
> +		ret = -EREMOTEIO;
> +out:
> +	spin_lock_irqsave(&sctrl->lock, flags);
> +	list_del(&ccr.list);
> +	spin_unlock_irqrestore(&sctrl->lock, flags);
> +	return ret;
> +}
> +
> +unsigned long nvme_fence_ctrl(struct nvme_ctrl *ictrl)
> +{
> +	unsigned long deadline, now, timeout;
> +	struct nvme_ctrl *sctrl;
> +	u32 min_cntlid = 0;
> +	int ret;
> +
> +	timeout = nvme_fence_timeout_ms(ictrl);
> +	dev_info(ictrl->device, "attempting CCR, timeout %lums\n", timeout);
> +
> +	now = jiffies;
> +	deadline = now + msecs_to_jiffies(timeout);
> +	while (time_before(now, deadline)) {
> +		sctrl = nvme_find_ctrl_ccr(ictrl, min_cntlid);
> +		if (!sctrl) {
> +			/* CCR failed, switch to time-based recovery */
> +			return deadline - now;
> +		}
> +
> +		ret = nvme_issue_wait_ccr(sctrl, ictrl);
> +		if (!ret) {
> +			dev_info(ictrl->device, "CCR succeeded using %s\n",
> +				 dev_name(sctrl->device));
> +			nvme_put_ctrl_ccr(sctrl);
> +			return 0;
> +		}
> +
> +		/* CCR failed, try another path */
> +		min_cntlid = sctrl->cntlid + 1;
> +		nvme_put_ctrl_ccr(sctrl);
> +		now = jiffies;
> +	}

That will spin until 'deadline' is reached if 'nvme_issue_wait_ccr()' 
returns an error. _And_ if the CCR itself runs into a timeout we would
never have tried another path (which could have succeeded).

I'd rather rework this loop to open-code 'issue_and_wait()' in the loop,
and only switch to the next controller if the submission of CCR failed.
Once that is done we can 'just' wait for completion, as a failure there
will be after KATO timeout anyway and any subsequent CCR would be pointless.

> +
> +	dev_info(ictrl->device, "CCR reached timeout, call it done\n");
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(nvme_fence_ctrl);
> +
>   bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
>   		enum nvme_ctrl_state new_state)
>   {
> @@ -5119,6 +5247,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
>   
>   	mutex_init(&ctrl->scan_lock);
>   	INIT_LIST_HEAD(&ctrl->namespaces);
> +	INIT_LIST_HEAD(&ctrl->ccr_list);
>   	xa_init(&ctrl->cels);
>   	ctrl->dev = dev;
>   	ctrl->ops = ops;
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 00866bbc66f3..fa18f580d76a 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -279,6 +279,13 @@ enum nvme_ctrl_flags {
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
 >   struct nvme_ctrl {>   	bool comp_seen;
>   	bool identified;
> @@ -296,6 +303,7 @@ struct nvme_ctrl {
>   	struct blk_mq_tag_set *tagset;
>   	struct blk_mq_tag_set *admin_tagset;
>   	struct list_head namespaces;
> +	struct list_head ccr_list;
>   	struct mutex namespaces_lock;
>   	struct srcu_struct srcu;
>   	struct device ctrl_device;
> @@ -814,6 +822,7 @@ blk_status_t nvme_host_path_error(struct request *req);
>   bool nvme_cancel_request(struct request *req, void *data);
>   void nvme_cancel_tagset(struct nvme_ctrl *ctrl);
>   void nvme_cancel_admin_tagset(struct nvme_ctrl *ctrl);
> +unsigned long nvme_fence_ctrl(struct nvme_ctrl *ctrl);
>   bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
>   		enum nvme_ctrl_state new_state);
>   int nvme_disable_ctrl(struct nvme_ctrl *ctrl, bool shutdown);

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

