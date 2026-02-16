Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8047BE7BDB4
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Feb 2026 12:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZB39Mlc0V5qDSGXGlLY4Z3UfPU7EtOfF4yAZPJUceKM=; b=hww6ybsx1CuEyu5JUS86M3Igts
	pKUUbg1qVHSrTBlxQIwACUPvpCTUR9iszhQMKKRrbX1JJ2+RHjJt6DeptmRdvzLpVU83AtytVc7bl
	jk+XgmYLO5a6D7H1ZXMD/lcDb6Cj9LB5VUEgonkTmo0voD69H24hJcPDRKobmkdJWtxr3mCeFChHh
	UWNF/BKwg8DBVp5LP9B5Nb4pa7FmVz4n+hg6sqm9pYx9EKpofKKuhfJy52pwYe48OicieKY/7CzeP
	R4c4mzOf9RW6ST41Ga6uTGjRIEbl9n39wmRp2hO82c1ZXum+gce2aXzpDlMqcx7hh8HdypC1h9RVT
	GzgILjnA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vrxvC-00000006XPk-2Oio;
	Mon, 16 Feb 2026 12:41:50 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vrxv6-00000006XOI-2ZHG
	for linux-nvme@lists.infradead.org;
	Mon, 16 Feb 2026 12:41:49 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7A7705BD7B;
	Mon, 16 Feb 2026 12:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771245702; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZB39Mlc0V5qDSGXGlLY4Z3UfPU7EtOfF4yAZPJUceKM=;
	b=fIRPLt5Xcv8nTUxY9xpjrfLMhj9mtVK9gvjeJN5bGDjO25ppyDZPw2ql/6e4mKS0nYCNPE
	0VG/lkCsWqBBqBnfhsA5jpBNSxjeaS5j8UJ8tHIiSTvI+iM0G3k13f+3LZjoM7hriUADmg
	m8sapp1H7oLM1vFUnRVcdbw7sN0Imds=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771245702;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZB39Mlc0V5qDSGXGlLY4Z3UfPU7EtOfF4yAZPJUceKM=;
	b=0rApMlPrmq4OLIrFxCsIKAH4oMI8sZJk/6kxgvS1o0jpmXNurk46EuSWbnAHC2jmYP1MTn
	djAU7kaSe5OqhJCw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=fIRPLt5X;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=0rApMlPr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771245702; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZB39Mlc0V5qDSGXGlLY4Z3UfPU7EtOfF4yAZPJUceKM=;
	b=fIRPLt5Xcv8nTUxY9xpjrfLMhj9mtVK9gvjeJN5bGDjO25ppyDZPw2ql/6e4mKS0nYCNPE
	0VG/lkCsWqBBqBnfhsA5jpBNSxjeaS5j8UJ8tHIiSTvI+iM0G3k13f+3LZjoM7hriUADmg
	m8sapp1H7oLM1vFUnRVcdbw7sN0Imds=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771245702;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZB39Mlc0V5qDSGXGlLY4Z3UfPU7EtOfF4yAZPJUceKM=;
	b=0rApMlPrmq4OLIrFxCsIKAH4oMI8sZJk/6kxgvS1o0jpmXNurk46EuSWbnAHC2jmYP1MTn
	djAU7kaSe5OqhJCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EB5263EA62;
	Mon, 16 Feb 2026 12:41:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8J4cK4UQk2m2PAAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 16 Feb 2026 12:41:41 +0000
Message-ID: <c5ee3fd5-2bbe-44e0-ae1b-ed77d7d87029@suse.de>
Date: Mon, 16 Feb 2026 13:41:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/21] nvme: Implement cross-controller reset recovery
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
 <20260214042753.4073668-9-mkhalfella@purestorage.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260214042753.4073668-9-mkhalfella@purestorage.com>
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
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Queue-Id: 7A7705BD7B
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260216_044144_946130_46409C28 
X-CRM114-Status: GOOD (  29.29  )
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
>   drivers/nvme/host/core.c      | 141 ++++++++++++++++++++++++++++++++++
>   drivers/nvme/host/nvme.h      |   9 +++
>   3 files changed, 151 insertions(+)
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
> index 231d402e9bfb..765b1524b3ed 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -554,6 +554,146 @@ void nvme_cancel_admin_tagset(struct nvme_ctrl *ctrl)
>   }
>   EXPORT_SYMBOL_GPL(nvme_cancel_admin_tagset);
>   
> +static struct nvme_ctrl *nvme_find_ctrl_ccr(struct nvme_ctrl *ictrl,
> +					    u32 min_cntlid)
> +{
> +	struct nvme_subsystem *subsys = ictrl->subsys;
> +	struct nvme_ctrl *ctrl, *sctrl = NULL;
> +	unsigned long flags;
> +
> +	mutex_lock(&nvme_subsystems_lock);
> +	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
> +		if (ctrl->cntlid < min_cntlid)
> +			continue;
> +
> +		if (atomic_dec_if_positive(&ctrl->ccr_limit) < 0)
> +			continue;
> +
> +		spin_lock_irqsave(&ctrl->lock, flags);
> +		if (ctrl->state != NVME_CTRL_LIVE) {
> +			spin_unlock_irqrestore(&ctrl->lock, flags);
> +			atomic_inc(&ctrl->ccr_limit);
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
> +	tmo = secs_to_jiffies(ictrl->kato);
> +	if (!wait_for_completion_timeout(&ccr.complete, tmo)) {
> +		ret = -ETIMEDOUT;
> +		goto out;
> +	}
> +
That will be tricky. The 'ccr' comand will be sent with the default
command queue timeout which is decoupled from KATO.
So you really should set the command timeout for the 'ccr' command
to ctrl->kato to ensure it'll be terminated correctly.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

