Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2622C44501
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jul 2026 07:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FipojGrSnFTLYb+vyJDUq2ZGcGefYyNnkJo79VsvVR4=; b=JvEZ0sjirNrwCxTtIFV4rjwRY5
	oODypK4GaZhIjnzT0I1pGqV4VzXwJw57/dZ7Dk124/OQnn2/+8jz15g9eL9HVwwiKkWE1v+u/qA5Y
	0/T1MIZfP1xvtKjqt4zswrUySGm25hKwGccRhMS5a3jr0EeVGyCwiZqTv9AK9VXKKPwKMhbCFgY4/
	Etk9+foHiKq8SsJIymFBN92XV7ugy7OL6p8cixWkE1JsK+ZACU+xpCu+QDc37i3IxyYRJthfh7S3Q
	GpH8bm1MtMjeaP98oaL2sVGeHRLm8BJzn/zRrGil9RwuwQn7diChKiv1NHDbTZCybOHly3N92uUct
	XraEcDSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjAv5-00000008Mfv-19oJ;
	Mon, 13 Jul 2026 07:17:39 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjAv2-00000008Mei-2or9
	for linux-nvme@lists.infradead.org;
	Mon, 13 Jul 2026 07:17:37 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 454097742E;
	Mon, 13 Jul 2026 07:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783927054; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FipojGrSnFTLYb+vyJDUq2ZGcGefYyNnkJo79VsvVR4=;
	b=zMWOBZvtYn+UxT2UZR9VI/5CsRuTxqWMEwm3pIPG/u78S5+H+xYmovrJFsTKBxkIfUueR8
	XJaO0w6wiIFf7iw2+ZdHY6nrbu4gqydW4YPC06X4k6kIozh+UGkHtFpy4njskMTidtXhqU
	QZ6Tp5ijVNguGgN1UUphMcEnRBMtUZ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783927054;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FipojGrSnFTLYb+vyJDUq2ZGcGefYyNnkJo79VsvVR4=;
	b=0zok3/EiyparXu6gYb0o61fV8kTYjgUosEcIr3fnJ42nm0zwL3uUhaqoG8tVUi4byUrKtM
	v8XNO55sOaTQg4CA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783927054; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FipojGrSnFTLYb+vyJDUq2ZGcGefYyNnkJo79VsvVR4=;
	b=zMWOBZvtYn+UxT2UZR9VI/5CsRuTxqWMEwm3pIPG/u78S5+H+xYmovrJFsTKBxkIfUueR8
	XJaO0w6wiIFf7iw2+ZdHY6nrbu4gqydW4YPC06X4k6kIozh+UGkHtFpy4njskMTidtXhqU
	QZ6Tp5ijVNguGgN1UUphMcEnRBMtUZ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783927054;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FipojGrSnFTLYb+vyJDUq2ZGcGefYyNnkJo79VsvVR4=;
	b=0zok3/EiyparXu6gYb0o61fV8kTYjgUosEcIr3fnJ42nm0zwL3uUhaqoG8tVUi4byUrKtM
	v8XNO55sOaTQg4CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D0D82779AE;
	Mon, 13 Jul 2026 07:17:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VGeVMQ2RVGpMXQAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 13 Jul 2026 07:17:33 +0000
Message-ID: <f27fdc8d-9aea-42d1-8f55-04d8355a50c4@suse.de>
Date: Mon, 13 Jul 2026 09:17:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 10/16] nvme-tcp: Use CCR to recover controller that
 hits an error
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
 <20260712022437.3743117-11-mkhalfella@purestorage.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260712022437.3743117-11-mkhalfella@purestorage.com>
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
	RCPT_COUNT_TWELVE(0.00)[15];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo,purestorage.com:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260713_001736_867178_32E30F7F 
X-CRM114-Status: GOOD (  21.65  )
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
> An alive nvme controller that hits an error now will move to FENCING
> state instead of RESETTING state. ctrl->fencing_work attempts CCR to
> terminate inflight IOs. Regardless of the success or failure of CCR
> operation the controller is transitioned to RESETTING state to continue
> error recovery process.
> 
> Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> ---
>   drivers/nvme/host/tcp.c | 30 +++++++++++++++++++++++++++++-
>   1 file changed, 29 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index ba5c7b3e2a7c..a1711dd1d3c2 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -161,6 +161,7 @@ struct nvme_tcp_ctrl {
>   	struct sockaddr_storage src_addr;
>   	struct nvme_ctrl	ctrl;
>   
> +	struct work_struct	fencing_work;
>   	struct work_struct	err_work;
>   	struct delayed_work	connect_work;
>   	struct nvme_tcp_request async_req;
> @@ -605,6 +606,12 @@ static void nvme_tcp_init_recv_ctx(struct nvme_tcp_queue *queue)
>   
>   static void nvme_tcp_error_recovery(struct nvme_ctrl *ctrl)
>   {
> +	if (nvme_change_ctrl_state(ctrl, NVME_CTRL_FENCING)) {
> +		dev_warn(ctrl->device, "starting controller fencing\n");
> +		queue_work(nvme_wq, &to_tcp_ctrl(ctrl)->fencing_work);
> +		return;
> +	}
> +
>   	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
>   		return;
>   
> @@ -2494,12 +2501,29 @@ static void nvme_tcp_reconnect_ctrl_work(struct work_struct *work)
>   	nvme_tcp_reconnect_or_remove(ctrl, ret);
>   }
>   
> +static void nvme_tcp_fencing_work(struct work_struct *work)
> +{
> +	struct nvme_tcp_ctrl *tcp_ctrl = container_of(work,
> +			struct nvme_tcp_ctrl, fencing_work);
> +	struct nvme_ctrl *ctrl = &tcp_ctrl->ctrl;
> +	unsigned long rem;
> +
> +	rem = nvme_fence_ctrl(ctrl);
> +	if (rem)
> +		dev_info(ctrl->device, "CCR failed, starting error recovery\n");
> +
> +	nvme_change_ctrl_state(ctrl, NVME_CTRL_FENCED);

This needs to be before nvme_fence_ctrl(). Otherwise the state is 
meaningless are we're moving to RESETTING directly afterwards.

> +	if (nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
> +		queue_work(nvme_reset_wq, &tcp_ctrl->err_work);
> +}
> +
>   static void nvme_tcp_error_recovery_work(struct work_struct *work)
>   {
>   	struct nvme_tcp_ctrl *tcp_ctrl = container_of(work,
>   				struct nvme_tcp_ctrl, err_work);
>   	struct nvme_ctrl *ctrl = &tcp_ctrl->ctrl;
>   
> +	flush_work(&to_tcp_ctrl(ctrl)->fencing_work);

Not so happy with this one here.
_If_ fencing is still running we really should not be entering here.
And If fencing is not running we won't need to call it.
I'd prefer some sort of WARN_ON() here if fencing is still running.

>   	if (nvme_tcp_key_revoke_needed(ctrl))
>   		nvme_auth_revoke_tls_key(ctrl);
>   	nvme_stop_keep_alive(ctrl);
> @@ -2542,6 +2566,7 @@ static void nvme_reset_ctrl_work(struct work_struct *work)
>   		container_of(work, struct nvme_ctrl, reset_work);
>   	int ret;
>   
> +	flush_work(&to_tcp_ctrl(ctrl)->fencing_work);

Same here.

>   	if (nvme_tcp_key_revoke_needed(ctrl))
>   		nvme_auth_revoke_tls_key(ctrl);
>   	nvme_stop_ctrl(ctrl);
> @@ -2667,13 +2692,15 @@ static enum blk_eh_timer_return nvme_tcp_timeout(struct request *rq)
>   	struct nvme_tcp_cmd_pdu *pdu = nvme_tcp_req_cmd_pdu(req);
>   	struct nvme_command *cmd = &pdu->cmd;
>   	int qid = nvme_tcp_queue_id(req->queue);
> +	enum nvme_ctrl_state state;
>   
>   	dev_warn(ctrl->device,
>   		 "I/O tag %d (%04x) type %d opcode %#x (%s) QID %d timeout\n",
>   		 rq->tag, nvme_cid(rq), pdu->hdr.type, cmd->common.opcode,
>   		 nvme_fabrics_opcode_str(qid, cmd), qid);
>   
> -	if (nvme_ctrl_state(ctrl) != NVME_CTRL_LIVE) {
> +	state = nvme_ctrl_state(ctrl);
> +	if (state != NVME_CTRL_LIVE && state != NVME_CTRL_FENCING) {
>   		/*
>   		 * If we are resetting, connecting or deleting we should
>   		 * complete immediately because we may block controller
> @@ -2928,6 +2955,7 @@ static struct nvme_tcp_ctrl *nvme_tcp_alloc_ctrl(struct device *dev,
>   
>   	INIT_DELAYED_WORK(&ctrl->connect_work,
>   			nvme_tcp_reconnect_ctrl_work);
> +	INIT_WORK(&ctrl->fencing_work, nvme_tcp_fencing_work);
>   	INIT_WORK(&ctrl->err_work, nvme_tcp_error_recovery_work);
>   	INIT_WORK(&ctrl->ctrl.reset_work, nvme_reset_ctrl_work);
>   

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

