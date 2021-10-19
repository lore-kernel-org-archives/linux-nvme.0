Return-Path: <SRS0=W3/M=PH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 385FFC433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Oct 2021 13:34:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D372460F25
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Oct 2021 13:34:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D372460F25
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Gpd+P/89KOJ+9FLRyzFPRHNwL0V2xnyrGwXnZQq+qJc=; b=yFgu5jvfdt/SNs6EbTFVOtmPoB
	Oeh6UlXbnjNX9AfmDkjMQhVtd6xrb9+OFWdm7dv38Bj19QalcRn6c7oIGNjIw9Scv7kIhKZ2P5brf
	oupe4oXTEN6h23rMIbFo3F/uGWL4XSQMlu3GEAl87p+7cmR7rcNg1T6G2olKxfdm3qJjFAh6N/ZRH
	7TKSG+Tcoh6/oCnbTgu9IHVaSAmXu31NP4wLaAT0WNKwp8KnsvdzS+gGRtwldnnjiwPtPMa5NxvFq
	0Vf+6gnOwGInbMFOJ269TZRErf9M17dmvy7VqD9KtUQPw49dGg0DqeG2hYZYjcom2whdjw3NKgcMH
	e12fbPzg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mcpGN-001R7p-Ae; Tue, 19 Oct 2021 13:34:43 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mcpGJ-001R7E-Ks
 for linux-nvme@lists.infradead.org; Tue, 19 Oct 2021 13:34:41 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4CD791FD2D;
 Tue, 19 Oct 2021 13:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1634650478; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Gpd+P/89KOJ+9FLRyzFPRHNwL0V2xnyrGwXnZQq+qJc=;
 b=PfvfNEZc3YthxkH/Oo0Q4n5DK1tyuDRT25TbY6n1ln2CrGbUyGE00snlZbC6zON5qSyHL4
 VCvTIEf4dJQO/Om3NN8en6s/sTPKe0LgfaoWZvegqW3yhTQvVdh6N/Aggzj1P0A+J0PFeS
 acyCaAFXSXpT4fLdqVBJY99nSmsYy78=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1634650478;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Gpd+P/89KOJ+9FLRyzFPRHNwL0V2xnyrGwXnZQq+qJc=;
 b=eO9SWlgBmYeEJR+qZBS0eg2GPnBX4ubdhcIMZOlZuEABJ8QcAazn0h4lqLjkdF3zrZ6uAA
 4KAW1KFIr3xCdaDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2903313E28;
 Tue, 19 Oct 2021 13:34:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id W0VWCW7JbmH/NAAAMHmgww
 (envelope-from <hare@suse.de>); Tue, 19 Oct 2021 13:34:38 +0000
Subject: Re: [PATCH 5/7] nvme/nvme-fabrics: introduce nvmf_error_recovery_work
 API
To: Max Gurtovoy <mgurtovoy@nvidia.com>, linux-nvme@lists.infradead.org,
 hch@lst.de, kbusch@kernel.org, sagi@grimberg.me
Cc: chaitanyak@nvidia.com, israelr@nvidia.com, oren@nvidia.com,
 jsmart2021@gmail.com
References: <20211018134020.33838-1-mgurtovoy@nvidia.com>
 <20211018134020.33838-6-mgurtovoy@nvidia.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <eeb357d6-5431-0fed-8f83-d61b2ac0a35f@suse.de>
Date: Tue, 19 Oct 2021 15:34:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20211018134020.33838-6-mgurtovoy@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211019_063439_857268_423F581B 
X-CRM114-Status: GOOD (  22.97  )
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

On 10/18/21 3:40 PM, Max Gurtovoy wrote:
> Error recovery work is duplicated in RDMA and TCP transports. Move this
> logic to common code. For that, introduce 2 new ctrl ops to teardown IO
> and admin queue.
> 
> Also update the RDMA/TCP transport drivers to use this API and remove
> the duplicated code.
> 
> Reviewed-by: Israel Rukshin <israelr@nvidia.com>
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> ---
>   drivers/nvme/host/fabrics.c | 23 +++++++++++++++
>   drivers/nvme/host/fabrics.h |  1 +
>   drivers/nvme/host/nvme.h    |  4 +++
>   drivers/nvme/host/rdma.c    | 56 ++++++++++++++++---------------------
>   drivers/nvme/host/tcp.c     | 56 +++++++++++++++----------------------
>   5 files changed, 75 insertions(+), 65 deletions(-)
> 
> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
> index 2edd086fa922..544195369c97 100644
> --- a/drivers/nvme/host/fabrics.c
> +++ b/drivers/nvme/host/fabrics.c
> @@ -493,6 +493,29 @@ void nvmf_reconnect_or_remove(struct nvme_ctrl *ctrl)
>   }
>   EXPORT_SYMBOL_GPL(nvmf_reconnect_or_remove);
>   
> +void nvmf_error_recovery_work(struct work_struct *work)
> +{
> +	struct nvme_ctrl *ctrl = container_of(work,
> +				struct nvme_ctrl, err_work);
> +
> +	nvme_stop_keep_alive(ctrl);
> +	ctrl->ops->teardown_ctrl_io_queues(ctrl);
> +	/* unquiesce to fail fast pending requests */
> +	nvme_start_queues(ctrl);
> +	ctrl->ops->teardown_ctrl_admin_queue(ctrl);
> +	blk_mq_unquiesce_queue(ctrl->admin_q);
> +
> +	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_CONNECTING)) {
> +		/* state change failure is ok if we started ctrl delete */
> +		WARN_ON_ONCE(ctrl->state != NVME_CTRL_DELETING &&
> +			     ctrl->state != NVME_CTRL_DELETING_NOIO);
> +		return;
> +	}
> +
> +	nvmf_reconnect_or_remove(ctrl);
> +}
> +EXPORT_SYMBOL_GPL(nvmf_error_recovery_work);
> +
>   void nvmf_error_recovery(struct nvme_ctrl *ctrl)
>   {
>   	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
> diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
> index 3d8ec7133fc8..8655eff74ed0 100644
> --- a/drivers/nvme/host/fabrics.h
> +++ b/drivers/nvme/host/fabrics.h
> @@ -190,6 +190,7 @@ int nvmf_get_address(struct nvme_ctrl *ctrl, char *buf, int size);
>   bool nvmf_should_reconnect(struct nvme_ctrl *ctrl);
>   void nvmf_reconnect_or_remove(struct nvme_ctrl *ctrl);
>   void nvmf_error_recovery(struct nvme_ctrl *ctrl);
> +void nvmf_error_recovery_work(struct work_struct *work);
>   bool nvmf_ip_options_match(struct nvme_ctrl *ctrl,
>   		struct nvmf_ctrl_options *opts);
>   
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index f9e1ce93d61d..1573edf6e97f 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -493,6 +493,10 @@ struct nvme_ctrl_ops {
>   	void (*submit_async_event)(struct nvme_ctrl *ctrl);
>   	void (*delete_ctrl)(struct nvme_ctrl *ctrl);
>   	int (*get_address)(struct nvme_ctrl *ctrl, char *buf, int size);
> +
> +	/* Fabrics only */
> +	void (*teardown_ctrl_io_queues)(struct nvme_ctrl *ctrl);
> +	void (*teardown_ctrl_admin_queue)(struct nvme_ctrl *ctrl);
>   };
>   
>   /*

As noted by Sagi, this abstraction really is awkward.
Why not have

void (*teardown_ctrl_queues)(struct nvme_ctrl *ctrl, int qid);

and let the callback figure out whether it's for the admin queue
(ie qid == 8) or the normal I/O queue?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer

