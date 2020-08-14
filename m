Return-Path: <SRS0=5rXh=BY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D670BC433DF
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Aug 2020 18:37:30 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1D1D20774
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Aug 2020 18:37:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BxTqx8zo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1D1D20774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=PnqEwcYQwj0HJfGgiiDY7v0sDCBTJGU/MDuVoDYVhsM=; b=BxTqx8zoBrpmfaNfw3a9WIDZ4
	47NgEM8qiTJKzVvJljs9KOXfT8xHJVM17LxfmdL1rrJPDM0BI3OXQFE1j6h7q1w+Kg7C9YCaEo6x5
	j3Tc9AjgP2Gu0JUks6KZ4MaggjQN86tSq/uXgNobfl5lypuaidJQJqvl+S0ZB7ayvLKV1w11tYyhc
	geGTDij/RVLEILfcqIMIiQlbgzdtztWBphQcNzuEWU3s3IR9e6jtJikpUWaHOymNwpfUl8Eh/45QX
	XanZUpsebY997/o8rvkKI33qGMguIOTILXUUxl5XbGZWqlSEnj3L7xMxSccSnA3pWKqbSD8IwUDDG
	KYazcYqDA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k6eZy-0007CW-4Z; Fri, 14 Aug 2020 18:37:26 +0000
Received: from mail-pg1-f196.google.com ([209.85.215.196])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k6eZv-0007BE-AM
 for linux-nvme@lists.infradead.org; Fri, 14 Aug 2020 18:37:24 +0000
Received: by mail-pg1-f196.google.com with SMTP id h12so4929347pgm.7
 for <linux-nvme@lists.infradead.org>; Fri, 14 Aug 2020 11:37:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=hD6ztZGHhhudLNtJ01Vm4TaWiAWkv6WOVelfTCxmWXs=;
 b=X/3g/XWeEeRkt2ed7SL0K/hxQANKT3rPy/xQ2pPNThQLTyUoJ+D0NOVQDDgB2D9VpB
 ftvIdE2KMrVeGmUoSylFoiO3XdyC/huLe4Wf69x3QOYM3P7FSu+n6P44InuLFcQJ3M8o
 0dpIIaBPam8g50Bu+s0gu6JhBCoAuagL8oKKL3JRAWCGjZj1eRnDU0k7G/IR6nVdRAiH
 /dPkNFAvrQQSKIKrt/JfYTjKPJjwCq5ZTnnU8dwR9FTkfk2XZ5JkOpnd9QFXT4i8X9mn
 AywuWH6hZg0owJNEXS1whhwzbvYNTuskacexT9zK4YF1dpbDvr82P59PT4/7n/vYdtL3
 o+HQ==
X-Gm-Message-State: AOAM530gDw7beyz5EDFOtnBC/iw5MYoGJjPpG5wkO63Zi3+DcahB6+xj
 R72/z0uMN98BnaM+9c2wZKq57GXRXvFmwg==
X-Google-Smtp-Source: ABdhPJxNS+3L2jL3bTawq9ebMoeDJqKu3NBJg7oNYtLs3vEB8Bx4qWyDoF0uyLabc5eOQTe1gNH7ig==
X-Received: by 2002:a62:1a49:: with SMTP id a70mr2804354pfa.297.1597430237625; 
 Fri, 14 Aug 2020 11:37:17 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:51f:3472:bc7:2f4f?
 ([2601:647:4802:9070:51f:3472:bc7:2f4f])
 by smtp.gmail.com with ESMTPSA id q66sm8928725pjq.17.2020.08.14.11.37.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Aug 2020 11:37:16 -0700 (PDT)
Subject: Re: [PATCH 2/3] nvme: refactor command completion
To: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
References: <20200814151528.277465-1-hch@lst.de>
 <20200814151528.277465-3-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <6e751fee-9e89-96c7-8246-c8af3ecfcdad@grimberg.me>
Date: Fri, 14 Aug 2020 11:37:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200814151528.277465-3-hch@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200814_143723_379736_C50ACB8A 
X-CRM114-Status: GOOD (  35.21  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Keith Busch <kbusch@kernel.org>, Chao Leng <lengchao@huawei.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 8/14/20 8:15 AM, Christoph Hellwig wrote:
> Lift all the code to decide the dispostition of a completed command
> from nvme_complete_rq and nvme_failover_req into a new helper, which
> returns an emum of the potential actions.  nvme_complete_rq then
> just switches on those and calls the proper helper for the action.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/nvme/host/core.c      | 76 ++++++++++++++++++++++-------------
>   drivers/nvme/host/multipath.c | 47 ++++++----------------
>   drivers/nvme/host/nvme.h      | 31 ++++++++++++--
>   3 files changed, 90 insertions(+), 64 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 88cff309d8e4f0..8d474adad721fb 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -241,17 +241,6 @@ static blk_status_t nvme_error_status(u16 status)
>   	}
>   }
>   
> -static inline bool nvme_req_needs_retry(struct request *req)
> -{
> -	if (blk_noretry_request(req))
> -		return false;
> -	if (nvme_req(req)->status & NVME_SC_DNR)
> -		return false;
> -	if (nvme_req(req)->retries >= nvme_max_retries)
> -		return false;
> -	return true;
> -}
> -
>   static void nvme_retry_req(struct request *req)
>   {
>   	struct nvme_ns *ns = req->q->queuedata;
> @@ -268,34 +257,67 @@ static void nvme_retry_req(struct request *req)
>   	blk_mq_delay_kick_requeue_list(req->q, delay);
>   }
>   
> -void nvme_complete_rq(struct request *req)
> +enum nvme_disposition {
> +	COMPLETE,
> +	RETRY,
> +	FAILOVER,
> +};
> +
> +static inline enum nvme_disposition nvme_decide_disposition(struct request *req)
>   {
> -	blk_status_t status = nvme_error_status(nvme_req(req)->status);
> +	u16 status = nvme_req(req)->status & 0x7ff;
>   
> -	trace_nvme_complete_rq(req);
> +	if (likely(status == 0))
> +		return COMPLETE;
>   
> -	nvme_cleanup_cmd(req);
> +	if (blk_noretry_request(req) || (status & NVME_SC_DNR) ||
> +	    nvme_req(req)->retries >= nvme_max_retries)
> +		return COMPLETE;
>   
> -	if (nvme_req(req)->ctrl->kas)
> -		nvme_req(req)->ctrl->comp_seen = true;
> +	if (req->cmd_flags & REQ_NVME_MPATH) {
> +		if (nvme_is_path_error(status))
> +			return FAILOVER;
> +	}
>   
> -	if (unlikely(status != BLK_STS_OK && nvme_req_needs_retry(req))) {
> -		if ((req->cmd_flags & REQ_NVME_MPATH) && nvme_failover_req(req))
> -			return;
> +	if (blk_queue_dying(req->q))
> +		return COMPLETE;
>   
> -		if (!blk_queue_dying(req->q)) {
> -			nvme_retry_req(req);
> -			return;
> -		}
> -	} else if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&
> -		   req_op(req) == REQ_OP_ZONE_APPEND) {
> +	return RETRY;
> +}
> +
> +static inline void nvme_end_req(struct request *req)
> +{
> +	blk_status_t status = nvme_error_status(nvme_req(req)->status);
> +
> +	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&
> +	    req_op(req) == REQ_OP_ZONE_APPEND)
>   		req->__sector = nvme_lba_to_sect(req->q->queuedata,
>   			le64_to_cpu(nvme_req(req)->result.u64));
> -	}
>   
>   	nvme_trace_bio_complete(req, status);
>   	blk_mq_end_request(req, status);
>   }
> +
> +void nvme_complete_rq(struct request *req)
> +{
> +	trace_nvme_complete_rq(req);
> +	nvme_cleanup_cmd(req);
> +
> +	if (nvme_req(req)->ctrl->kas)
> +		nvme_req(req)->ctrl->comp_seen = true;
> +
> +	switch (nvme_decide_disposition(req)) {
> +	case COMPLETE:
> +		nvme_end_req(req);
> +		return;
> +	case RETRY:
> +		nvme_retry_req(req);
> +		return;
> +	case FAILOVER:
> +		nvme_failover_req(req);
> +		return;
> +	}
> +}
>   EXPORT_SYMBOL_GPL(nvme_complete_rq);
>   
>   bool nvme_cancel_request(struct request *req, void *data, bool reserved)
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index 3ded54d2c9c6ad..abc5bcf7209506 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -65,51 +65,30 @@ void nvme_set_disk_name(char *disk_name, struct nvme_ns *ns,
>   	}
>   }
>   
> -bool nvme_failover_req(struct request *req)
> +void nvme_failover_req(struct request *req)
>   {
>   	struct nvme_ns *ns = req->q->queuedata;
> -	u16 status = nvme_req(req)->status;
> +	u16 status = nvme_req(req)->status & 0x7ff;
>   	unsigned long flags;
>   
> -	switch (status & 0x7ff) {
> -	case NVME_SC_ANA_TRANSITION:
> -	case NVME_SC_ANA_INACCESSIBLE:
> -	case NVME_SC_ANA_PERSISTENT_LOSS:
> -		/*
> -		 * If we got back an ANA error we know the controller is alive,
> -		 * but not ready to serve this namespaces.  The spec suggests
> -		 * we should update our general state here, but due to the fact
> -		 * that the admin and I/O queues are not serialized that is
> -		 * fundamentally racy.  So instead just clear the current path,
> -		 * mark the the path as pending and kick of a re-read of the ANA
> -		 * log page ASAP.
> -		 */
> -		nvme_mpath_clear_current_path(ns);
> -		if (ns->ctrl->ana_log_buf) {
> -			set_bit(NVME_NS_ANA_PENDING, &ns->flags);
> -			queue_work(nvme_wq, &ns->ctrl->ana_work);
> -		}
> -		break;
> -	case NVME_SC_HOST_PATH_ERROR:
> -	case NVME_SC_HOST_ABORTED_CMD:
> -		/*
> -		 * Temporary transport disruption in talking to the controller.
> -		 * Try to send on a new path.
> -		 */
> -		nvme_mpath_clear_current_path(ns);
> -		break;
> -	default:
> -		/* This was a non-ANA error so follow the normal error path. */
> -		return false;
> +	nvme_mpath_clear_current_path(ns);
> +
> +	/*
> +	 * If we got back an ANA error, we know the controller is alive but not
> +	 * ready to serve this namespace.  Kick of a re-read of the ANA
> +	 * information page, and just try any other available path for now.
> +	 */
> +	if (nvme_is_ana_error(status) && ns->ctrl->ana_log_buf) {
> +		set_bit(NVME_NS_ANA_PENDING, &ns->flags);
> +		queue_work(nvme_wq, &ns->ctrl->ana_work);
>   	}
>   
>   	spin_lock_irqsave(&ns->head->requeue_lock, flags);
>   	blk_steal_bios(&ns->head->requeue_list, req);
>   	spin_unlock_irqrestore(&ns->head->requeue_lock, flags);
> -	blk_mq_end_request(req, 0);
>   
> +	blk_mq_end_request(req, 0);
>   	kblockd_schedule_work(&ns->head->requeue_work);
> -	return true;
>   }
>   
>   void nvme_kick_requeue_lists(struct nvme_ctrl *ctrl)
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 6d69cc7306d034..dfcdeb318f3ab6 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -523,6 +523,32 @@ static inline u32 nvme_bytes_to_numd(size_t len)
>   	return (len >> 2) - 1;
>   }
>   
> +static inline bool nvme_is_ana_error(u16 status)
> +{
> +	switch (status & 0x7ff) {
> +	case NVME_SC_ANA_TRANSITION:
> +	case NVME_SC_ANA_INACCESSIBLE:
> +	case NVME_SC_ANA_PERSISTENT_LOSS:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +static inline bool nvme_is_path_error(u16 status)
> +{
> +	switch (status & 0x7ff) {
> +	case NVME_SC_HOST_PATH_ERROR:
> +	case NVME_SC_HOST_ABORTED_CMD:
> +	case NVME_SC_ANA_TRANSITION:
> +	case NVME_SC_ANA_INACCESSIBLE:
> +	case NVME_SC_ANA_PERSISTENT_LOSS:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}

Would be better to reuse nvme_is_ana_error I think so we
don't need to maintain ana status codes in both places:

static inline bool nvme_is_path_error(u16 status)
{
	if (nvme_is_ana_error(status))
		return true;
	switch (status & 0x7ff) {
	case NVME_SC_HOST_PATH_ERROR:
	case NVME_SC_HOST_ABORTED_CMD:
		return true;
	default:
		return false;
	}
}

Otherwise looks good.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
