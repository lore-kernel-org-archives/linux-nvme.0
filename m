Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56CE2E83054
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Feb 2026 05:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ktXlnAlSwVL0GX/HAL05RFRoWVr+PCEyt2BldkLUFX8=; b=uXaQevK6MWohToA+7GA+NgO8cD
	7vU+lRUf2HkqtomXARBXEwCPHlEDqyDYZBziXXBcV0J1XSIWOAro35YUE7mI7WhFDIKMxWxktZYvC
	mWdGOF+xzpe8b9bvW0CKEkHMwExv+P+z47E4dgfam9psoFKxFlsgdVaPNsmOnKWYskK8Gw4FXY0nt
	kFfNeq70B++9O/enANcNTxBuzuthvUXwU7VGjUsIjDO4Bct1ELcJkWqZSP4CPKtyGONbxOGqrPXMD
	H4pGgpo3Nm27vTlHmEKc79K8/XYGbNQPNvCx5NOmUkkVhBoX9cnTaIF/4UynTZsesx/JI6aPWN5B/
	YQPzy2eQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vn9CQ-000000067z3-1OA2;
	Tue, 03 Feb 2026 05:43:42 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vn9CN-000000067yc-3mo5
	for linux-nvme@lists.infradead.org;
	Tue, 03 Feb 2026 05:43:41 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 101FC5BCC6;
	Tue,  3 Feb 2026 05:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770097418; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ktXlnAlSwVL0GX/HAL05RFRoWVr+PCEyt2BldkLUFX8=;
	b=f0qQmUMz3Yqtzx7edT67sOC1CcT8Zc3n/0XN0mVAjE+S7rqXEu5VmzVFyU1cjmmuGpic3i
	vEPindgX1PPiANRbARXQa483o9EZddjF6nzXkZy1YdntRWycj8/ThafjFjNWHOlfwNjEP9
	kSHAek257vMEiX1lKhIdHg9P8UyOjzY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770097418;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ktXlnAlSwVL0GX/HAL05RFRoWVr+PCEyt2BldkLUFX8=;
	b=wb2EYh7Nt6leT6ZbRpftsizyMeS8R/dzHVq6SOpUivvnoe0Z9URpdfIoibhyNL5Mlwp9tC
	tUv3RX2tPFadjACg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770097418; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ktXlnAlSwVL0GX/HAL05RFRoWVr+PCEyt2BldkLUFX8=;
	b=f0qQmUMz3Yqtzx7edT67sOC1CcT8Zc3n/0XN0mVAjE+S7rqXEu5VmzVFyU1cjmmuGpic3i
	vEPindgX1PPiANRbARXQa483o9EZddjF6nzXkZy1YdntRWycj8/ThafjFjNWHOlfwNjEP9
	kSHAek257vMEiX1lKhIdHg9P8UyOjzY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770097418;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ktXlnAlSwVL0GX/HAL05RFRoWVr+PCEyt2BldkLUFX8=;
	b=wb2EYh7Nt6leT6ZbRpftsizyMeS8R/dzHVq6SOpUivvnoe0Z9URpdfIoibhyNL5Mlwp9tC
	tUv3RX2tPFadjACg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 560AE3EA62;
	Tue,  3 Feb 2026 05:43:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id s0qDOASLgWkUBgAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 03 Feb 2026 05:43:32 +0000
Message-ID: <c1cd6ce4-c06c-4504-8319-250e01350fec@suse.de>
Date: Tue, 3 Feb 2026 06:43:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/14] nvme-fc: Use CCR to recover controller that hits
 an error
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
 <20260130223531.2478849-14-mkhalfella@purestorage.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260130223531.2478849-14-mkhalfella@purestorage.com>
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
	FREEMAIL_TO(0.00)[purestorage.com,broadcom.com,gmail.com,nvidia.com,lst.de,kernel.dk,kernel.org,grimberg.me];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[purestorage.com:email,imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260202_214340_099335_9E13B410 
X-CRM114-Status: GOOD (  22.85  )
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
> An alive nvme controller that hits an error now will move to FENCING
> state instead of RESETTING state. ctrl->fencing_work attempts CCR to
> terminate inflight IOs. If CCR succeeds, switch to FENCED -> RESETTING
> and continue error recovery as usual. If CCR fails, the behavior depends
> on whether the subsystem supports CQT or not. If CQT is not supported
> then reset the controller immediately as if CCR succeeded in order to
> maintain the current behavior. If CQT is supported switch to time-based
> recovery. Schedule ctrl->fenced_work resets the controller when time
> based recovery finishes.
> 
> Either ctrl->err_work or ctrl->reset_work can run after a controller is
> fenced. Flush fencing work when either work run.
> 
> Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> ---
>   drivers/nvme/host/fc.c | 60 ++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 60 insertions(+)
> 
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index f8f6071b78ed..3a01aeb39081 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -166,6 +166,8 @@ struct nvme_fc_ctrl {
>   	struct blk_mq_tag_set	admin_tag_set;
>   	struct blk_mq_tag_set	tag_set;
>   
> +	struct work_struct	fencing_work;
> +	struct delayed_work	fenced_work;
>   	struct work_struct	ioerr_work;
>   	struct delayed_work	connect_work;
>   
> @@ -1866,12 +1868,59 @@ __nvme_fc_fcpop_chk_teardowns(struct nvme_fc_ctrl *ctrl,
>   	}
>   }
>   
> +static void nvme_fc_fenced_work(struct work_struct *work)
> +{
> +	struct nvme_fc_ctrl *fc_ctrl = container_of(to_delayed_work(work),
> +			struct nvme_fc_ctrl, fenced_work);
> +	struct nvme_ctrl *ctrl = &fc_ctrl->ctrl;
> +
> +	nvme_change_ctrl_state(ctrl, NVME_CTRL_FENCED);
> +	if (nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
> +		queue_work(nvme_reset_wq, &fc_ctrl->ioerr_work);
> +}
> +
> +static void nvme_fc_fencing_work(struct work_struct *work)
> +{
> +	struct nvme_fc_ctrl *fc_ctrl =
> +			container_of(work, struct nvme_fc_ctrl, fencing_work);
> +	struct nvme_ctrl *ctrl = &fc_ctrl->ctrl;
> +	unsigned long rem;
> +
> +	rem = nvme_fence_ctrl(ctrl);
> +	if (!rem)
> +		goto done;
> +
> +	if (!ctrl->cqt) {
> +		dev_info(ctrl->device,
> +			 "CCR failed, CQT not supported, skip time-based recovery\n");
> +		goto done;
> +	}
> +
> +	dev_info(ctrl->device,
> +		 "CCR failed, switch to time-based recovery, timeout = %ums\n",
> +		 jiffies_to_msecs(rem));
> +	queue_delayed_work(nvme_wq, &fc_ctrl->fenced_work, rem);
> +	return;
> +

Same comments re fenced workqueue apply here.

> +done:
> +	nvme_change_ctrl_state(ctrl, NVME_CTRL_FENCED);
> +	if (nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
> +		queue_work(nvme_reset_wq, &fc_ctrl->ioerr_work);
> +}
> +
> +static void nvme_fc_flush_fencing_work(struct nvme_fc_ctrl *ctrl)
> +{
> +	flush_work(&ctrl->fencing_work);
> +	flush_delayed_work(&ctrl->fenced_work);
> +}
> +
>   static void
>   nvme_fc_ctrl_ioerr_work(struct work_struct *work)
>   {
>   	struct nvme_fc_ctrl *ctrl =
>   			container_of(work, struct nvme_fc_ctrl, ioerr_work);
>   
> +	nvme_fc_flush_fencing_work(ctrl);
>   	nvme_fc_error_recovery(ctrl);
>   }
>   
> @@ -1896,6 +1945,14 @@ EXPORT_SYMBOL_GPL(nvme_fc_io_getuuid);
>   static void nvme_fc_start_ioerr_recovery(struct nvme_fc_ctrl *ctrl,
>   					 char *errmsg)
>   {
> +	if (nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_FENCING)) {
> +		dev_warn(ctrl->ctrl.device,
> +			 "NVME-FC{%d}: starting controller fencing %s\n",
> +			 ctrl->cnum, errmsg);
> +		queue_work(nvme_wq, &ctrl->fencing_work);
> +		return;
> +	}
> +
>   	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_RESETTING))
>   		return;
>   
> @@ -3297,6 +3354,7 @@ nvme_fc_reset_ctrl_work(struct work_struct *work)
>   	struct nvme_fc_ctrl *ctrl =
>   		container_of(work, struct nvme_fc_ctrl, ctrl.reset_work);
>   
> +	nvme_fc_flush_fencing_work(ctrl);
>   	nvme_stop_ctrl(&ctrl->ctrl);
>   
>   	/* will block will waiting for io to terminate */
> @@ -3471,6 +3529,8 @@ nvme_fc_alloc_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
>   
>   	INIT_WORK(&ctrl->ctrl.reset_work, nvme_fc_reset_ctrl_work);
>   	INIT_DELAYED_WORK(&ctrl->connect_work, nvme_fc_connect_ctrl_work);
> +	INIT_DELAYED_WORK(&ctrl->fenced_work, nvme_fc_fenced_work);
> +	INIT_WORK(&ctrl->fencing_work, nvme_fc_fencing_work);
>   	INIT_WORK(&ctrl->ioerr_work, nvme_fc_ctrl_ioerr_work);
>   	spin_lock_init(&ctrl->lock);
>   

And, of course, the same comments about sending CCR in response to a
KATO timeout and not a command timeout apply.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

