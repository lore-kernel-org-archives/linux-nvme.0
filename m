Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05044FB3D18
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Mar 2026 10:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KhdM3EsAMfeGqH45h+nFhRR8+AmN2jvA0vRdqjfuoD0=; b=pi38en/4uBEsh2VInjufexpROw
	DNGUKP738S75sMPv+qQq5x10+BkHtwqMtp1Qj7ILvGmmE80wsUvWYgZ6vXp2gL/DjUuZa/MZH0ZEj
	HnQ+aUf7+7JKm2oolWCtkcyqIvLbhc5tTBtLu45mS+e6xQvVhh2lZulHjnb5wAkkEtBa22xUDxU+D
	RWNbpzVpgoJMXQz238VKuoLYyHfm2zNotZzxGz0l1DEJHy5GyPsa4E41fR8GSJo/SQz4Fo1SCl7q2
	O34D2fuenGhAp++48LYV8NqlPy/z/kdKFDejDsa7ACFnPJDmrTfVDp1+WRbUVcefzTqAuBInVA3mz
	A9N+9A4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7ACW-0000000B6KH-091r;
	Mon, 30 Mar 2026 10:50:32 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7ACU-0000000B6Jt-2nb4
	for linux-nvme@bombadil.infradead.org;
	Mon, 30 Mar 2026 10:50:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=KhdM3EsAMfeGqH45h+nFhRR8+AmN2jvA0vRdqjfuoD0=; b=RZ8DwgynaSRC3C+qm9Kd7QM/Nf
	cJWcCU4yyrISXxvndVFeWbuv3P6+fpUn/z3X36npt6J+RM0g4Qssr+AqwAaIAWrPVFAFz0GyqFuuo
	3UqNmBcUQEZhcoFefkevv74aY7k6O6evajkUdtbFvStc/RiBICAaNnpBR8AQTt5ikgAGxzSorYM1+
	5/+H0UPKydngTcGrLYG5Djspxy9WxwbSXVNMCOg9ExWclpKclSLdP46+h2MqXbTTdev1sExsqunI4
	QELxGBWnV5fK35ZEsNVM1FzeuV/qPDLOG316UxbHVuEdbIDTnICnLMKKAMZef+na5JWou0Q6mnezb
	vVlEneqA==;
Received: from smtp-out2.suse.de ([195.135.223.131])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7ACR-0000000Dczz-1pgZ
	for linux-nvme@lists.infradead.org;
	Mon, 30 Mar 2026 10:50:29 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 36F535BD2D;
	Mon, 30 Mar 2026 10:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774867825; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KhdM3EsAMfeGqH45h+nFhRR8+AmN2jvA0vRdqjfuoD0=;
	b=ziBoOMva78vX9k9NPNMb3FOsR6zMjkm2zZZN69YR7RV0ge8vXk3YE8ESCJkPW4EX55TtA+
	KisnrDe17Os8C2JrF3tqPD52bbrM51OJlJjaXurfBsoiUNwu1Q96CFrKaRKt3XWpTn5BTD
	d1FZ3lgTPpq1h7bTKhmpZ5TFxGndv08=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774867825;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KhdM3EsAMfeGqH45h+nFhRR8+AmN2jvA0vRdqjfuoD0=;
	b=4KCy6MubJGWf6hkPcZ0/IBDObHsh7D6p7pqZcUZxr+nCWN5dyTK6xtPzHZqejRwwYxVgTe
	0FWxZbr7mFF/VoAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774867825; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KhdM3EsAMfeGqH45h+nFhRR8+AmN2jvA0vRdqjfuoD0=;
	b=ziBoOMva78vX9k9NPNMb3FOsR6zMjkm2zZZN69YR7RV0ge8vXk3YE8ESCJkPW4EX55TtA+
	KisnrDe17Os8C2JrF3tqPD52bbrM51OJlJjaXurfBsoiUNwu1Q96CFrKaRKt3XWpTn5BTD
	d1FZ3lgTPpq1h7bTKhmpZ5TFxGndv08=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774867825;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KhdM3EsAMfeGqH45h+nFhRR8+AmN2jvA0vRdqjfuoD0=;
	b=4KCy6MubJGWf6hkPcZ0/IBDObHsh7D6p7pqZcUZxr+nCWN5dyTK6xtPzHZqejRwwYxVgTe
	0FWxZbr7mFF/VoAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DB6124A0A2;
	Mon, 30 Mar 2026 10:50:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wFnnM3BVymmVdgAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 30 Mar 2026 10:50:24 +0000
Message-ID: <ee086ee1-a48f-41fb-a7fe-afc6b738cf21@suse.de>
Date: Mon, 30 Mar 2026 12:50:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/15] nvme: Implement cross-controller reset recovery
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
 <20260328004518.1729186-9-mkhalfella@purestorage.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260328004518.1729186-9-mkhalfella@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_TO(0.00)[purestorage.com,broadcom.com,gmail.com,nvidia.com,kernel.dk,kernel.org,grimberg.me];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email,purestorage.com:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260330_115027_738703_111678C8 
X-CRM114-Status: GOOD (  29.77  )
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
>   drivers/nvme/host/core.c      | 145 ++++++++++++++++++++++++++++++++++
>   drivers/nvme/host/nvme.h      |   9 +++
>   3 files changed, 155 insertions(+)
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
> index 824a1193bec8..5603ae36444f 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -554,6 +554,150 @@ void nvme_cancel_admin_tagset(struct nvme_ctrl *ctrl)
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
> +	now = jiffies;
> +	if (time_before(now, deadline))
> +		tmo = min_t(unsigned long,
> +			    secs_to_jiffies(ictrl->kato), deadline - now);
> +
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
> +int nvme_fence_ctrl(struct nvme_ctrl *ictrl)
> +{
> +	unsigned long deadline, timeout;
> +	struct nvme_ctrl *sctrl;
> +	u32 min_cntlid = 0;
> +	int ret;
> +
> +	timeout = nvme_fence_timeout_ms(ictrl);
> +	dev_info(ictrl->device, "attempting CCR, timeout %lums\n", timeout);
> +
> +	deadline = jiffies + msecs_to_jiffies(timeout);
> +	while (time_is_after_jiffies(deadline)) {
> +		sctrl = nvme_find_ctrl_ccr(ictrl, min_cntlid);
> +		if (!sctrl) {
> +			dev_dbg(ictrl->device,
> +				"failed to find source controller\n");
> +			return -EIO;
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
> +		min_cntlid = sctrl->cntlid + 1;
> +		nvme_put_ctrl_ccr(sctrl);
> +
> +		if (ret == -EIO) /* CCR command failed */
> +			continue;
> +
> +		/* CCR operation failed or timed out */
> +		return ret;
> +	}
> +
> +	dev_info(ictrl->device, "CCR operation timeout\n");
> +	return -ETIMEDOUT;
> +}

Please restructure the loop.
Having a comment 'CCR operation failed or timed out',
returning a status, and then have a comment
'CCR operation timeout' _after_ the return is confusing.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

