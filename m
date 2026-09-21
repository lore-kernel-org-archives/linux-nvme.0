Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A1CAC982E1
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Sep 2026 08:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dnlR76jhIgMBfFFSz0TPxpps120E4s2EWia/QNjr+II=; b=qpBDK9nBgAaXKggx0C4Kkueekv
	ww/vqulh171PebFn9YBPfU6YLbNRiE7vs5ksiUpxdqF+/zt7sowh40GYIA73i82cNwNgd/LtOilwW
	d7qBeu1dk93wTLc+lvgaB+3wiu0KKhiwsz8ug9l+xFepn2TJ5t202GWXoT9ar7pLaRA4EOzZMdUDI
	k/0aXRZJOwbT4t4o4gc+QDDiPbi0cNw+NykWUd8qv1C/qSg4JRAeCAn+EhgY7ts6WYHV57X1+kYKs
	pBN5vbqQ93DRuzCNrfD7kLsU1CqUaniG0yijvquv50jG978JX/cDNKCG26r/Rrx5386SuQLQq7yZ6
	Qx0cubXg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8Z3c-00000001Iph-305C;
	Mon, 21 Sep 2026 08:07:24 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8Z3a-00000001Ip7-0ECQ
	for linux-nvme@lists.infradead.org;
	Mon, 21 Sep 2026 08:07:23 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D49531F7CD;
	Mon, 21 Sep 2026 08:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789978036; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dnlR76jhIgMBfFFSz0TPxpps120E4s2EWia/QNjr+II=;
	b=hmlqgRzkFXEZkMKpkH4RgUbX4wexdVeC6wLPU74DA8FdGvqDkQqXSOQlA6u29560XzY0M0
	yWiVEdVehFmrojw3hNi88IUJPqhFoUORU7dvVmBwmZ9FqI7BUF+sGjWecJou1Jpdc288C7
	gjD20BxVZ9hAv77WbQjINHxyLo1WKkU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789978036;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dnlR76jhIgMBfFFSz0TPxpps120E4s2EWia/QNjr+II=;
	b=slls9C5wZDuOZEcxaGdfrf4wpEgjt/+6B9YVBFWiUcVxsQAa8yUYDocAicbx/fGWhLEnNV
	rRvoScsryeXTt5BQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789978031; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dnlR76jhIgMBfFFSz0TPxpps120E4s2EWia/QNjr+II=;
	b=XcmBXLFSw806eDP0dslNNjmy2/drKpB/eUEQJ/vKAvcceu+VrgFWjOfCQQEDzK9E4MB5V9
	EAq6xasiO7aGpX4pq7C4Qa510CaqpYW4ELo/V7ftGq/Rwzzqx0aEDIH7JtH6LBC/W7JIy5
	DoCPTt1sh1ChZt5OTmKYT4rrtGFUPqE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789978031;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dnlR76jhIgMBfFFSz0TPxpps120E4s2EWia/QNjr+II=;
	b=y57ifLw6/OkmH5Rme0hh1Zvw2eJJ0bmQrAJklJbV+YLqO0MUpvnDEurijXFVE6UFcopNC6
	ITlVtBeoH3OAJqBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 50DEB1368D;
	Mon, 21 Sep 2026 08:07:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0EMZCq/lsGo/GwAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 21 Sep 2026 08:07:11 +0000
Message-ID: <6a2fddc2-0a32-4dc2-9642-efebe6934633@suse.de>
Date: Mon, 21 Sep 2026 10:07:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/18] nvme-fc: Use CCR to recover controller that hits an
 error
To: Mohamed Khalfella <mkhalfella@purestorage.com>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: Justin Tee <justin.tee@broadcom.com>,
 Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
 Paul Ely <paul.ely@broadcom.com>, Hannes Reinecke <hare@kernel.org>,
 Chaitanya Kulkarni <kch@nvidia.com>, James Smart <jsmart833426@gmail.com>,
 Randy Jennings <randyj@purestorage.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260918181614.3947933-1-mkhalfella@purestorage.com>
 <20260918181614.3947933-15-mkhalfella@purestorage.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260918181614.3947933-15-mkhalfella@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[broadcom.com,gmail.com,kernel.org,nvidia.com,purestorage.com,lists.infradead.org,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260921_010722_248983_5669C55F 
X-CRM114-Status: GOOD (  22.86  )
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

On 9/18/26 8:14 PM, Mohamed Khalfella wrote:
> An alive nvme controller that hits an error now will move to FENCING
> state instead of RESETTING state. ctrl->fencing_work attempts CCR to
> terminate inflight IOs. Regardless of the success or failure of CCR
> operation the controller is transitioned to RESETTING state to continue
> error recovery process.
> 
> Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> ---
>   drivers/nvme/host/fc.c | 42 ++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 42 insertions(+)
> 
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index 5a530aa37641..42671cca439f 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -166,6 +166,7 @@ struct nvme_fc_ctrl {
>   	struct blk_mq_tag_set	admin_tag_set;
>   	struct blk_mq_tag_set	tag_set;
>   
> +	struct work_struct	fencing_work;
>   	struct work_struct	ioerr_work;
>   	struct delayed_work	connect_work;
>   
> @@ -990,6 +991,7 @@ static void nvme_fc_ctrl_put(struct nvme_fc_ctrl *);
>   static int nvme_fc_ctrl_get(struct nvme_fc_ctrl *);
>   
>   static void nvme_fc_error_recovery(struct nvme_fc_ctrl *ctrl);
> +static void nvme_fc_delete_association(struct nvme_fc_ctrl *ctrl);
>   
>   static void
>   __nvme_fc_finish_ls_req(struct nvmefc_ls_req_op *lsop)
> @@ -1870,6 +1872,30 @@ __nvme_fc_fcpop_chk_teardowns(struct nvme_fc_ctrl *ctrl,
>   	}
>   }
>   
> +static void nvme_fc_fencing_work(struct work_struct *work)
> +{
> +	struct nvme_fc_ctrl *fc_ctrl =
> +			container_of(work, struct nvme_fc_ctrl, fencing_work);
> +	struct nvme_ctrl *ctrl = &fc_ctrl->ctrl;
> +	unsigned long rem;
> +
> +	/*
> +	 * Tear the association down now so the LLDD can finish unregistering
> +	 * the remoteport/localport while the fencing this controller.
> +	 */
> +	nvme_stop_keep_alive(ctrl);
> +	cancel_work_sync(&ctrl->async_event_work);
> +	nvme_fc_delete_association(fc_ctrl);
> +
> +	rem = nvme_fence_ctrl(ctrl);
> +	if (rem)
> +		dev_info(ctrl->device, "CCR failed, starting error recovery\n");
> +
> +	nvme_change_ctrl_state(ctrl, NVME_CTRL_FENCED);
> +	if (nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
> +		queue_work(nvme_reset_wq, &fc_ctrl->ioerr_work);
> +}
> +
>   static void
>   nvme_fc_ctrl_ioerr_work(struct work_struct *work)
>   {
> @@ -1950,6 +1976,14 @@ nvme_fc_start_ioerr_recovery(struct nvme_fc_ctrl *ctrl, char *errmsg)
>   		return;
>   	}
>   
> +	if (nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_FENCING)) {
> +		dev_warn(ctrl->ctrl.device,
> +			 "NVME-FC{%d}: starting controller fencing %s\n",
> +			 ctrl->cnum, errmsg);
> +		queue_work(nvme_wq, &ctrl->fencing_work);
> +		return;
> +	}
> +
>   	if (nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_RESETTING)) {
>   		dev_warn(ctrl->ctrl.device, "NVME-FC{%d}: starting error recovery %s\n",
>   			 ctrl->cnum, errmsg);
> @@ -2463,6 +2497,12 @@ nvme_fc_ctrl_get(struct nvme_fc_ctrl *ctrl)
>   	return kref_get_unless_zero(&ctrl->ref);
>   }
>   
> +static void
> +nvme_fc_stop_ctrl(struct nvme_ctrl *nctrl)
> +{
> +	flush_work(&to_fc_ctrl(nctrl)->fencing_work);
> +}
> +
>   /*
>    * All accesses from nvme core layer done - can now free the
>    * controller. Called after last nvme_put_ctrl() call
> @@ -3428,6 +3468,7 @@ static const struct nvme_ctrl_ops nvme_fc_ctrl_ops = {
>   	.submit_async_event	= nvme_fc_submit_async_event,
>   	.delete_ctrl		= nvme_fc_delete_ctrl,
>   	.get_address		= nvmf_get_address,
> +	.stop_ctrl		= nvme_fc_stop_ctrl,
>   	.get_virt_boundary	= nvmf_get_virt_boundary,
>   };
>   
> @@ -3547,6 +3588,7 @@ nvme_fc_alloc_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
>   
>   	INIT_WORK(&ctrl->ctrl.reset_work, nvme_fc_reset_ctrl_work);
>   	INIT_DELAYED_WORK(&ctrl->connect_work, nvme_fc_connect_ctrl_work);
> +	INIT_WORK(&ctrl->fencing_work, nvme_fc_fencing_work);
>   	INIT_WORK(&ctrl->ioerr_work, nvme_fc_ctrl_ioerr_work);
>   	spin_lock_init(&ctrl->lock);
>   

I would merge it with the previous patch as both are required to get FC
error handling working properly.
Otherwise:

Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

