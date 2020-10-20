Return-Path: <SRS0=uU0g=D3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE2A6C433E7
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Oct 2020 08:15:09 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BA912225F
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Oct 2020 08:15:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gasrE+bo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BA912225F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=DgHaAizNnls8ecMKnoPi0zQSMZjwK88t0M6IAKjGvVI=; b=gasrE+boUtU5+jUeSTnGcTLzt
	VlUHBG/VCWXdcWLJxoXz2WlrlARBWDspImmJaD+pmvqFHkcmu5fIYTiIEnkS1bNGjg2DZuGYdPCoy
	Kjc+zdzbaTt3zPBFtHiSTIveBA5PEq58/wjiwTg7OEfOPEik/N89hNBnTxO46NX1pOIsT4qSgir5O
	1Oxu1c+uDAdvlB/rCWQpS7yfgsRLxZXoK2G/RzL6MAVRWoUrWPP4i4LGkWXTkesZ1rqqG9hdXBb7+
	mNTLqjVbUm3b5WxnGqBMfYvPtXihE87N1vItZMiwoV7saTwFuYGmg2xrpXpb5LSm87FeyBKCP16Jd
	mRF9Q4Olw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kUmnS-0006cO-Vl; Tue, 20 Oct 2020 08:15:07 +0000
Received: from mail-wr1-f68.google.com ([209.85.221.68])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kUmnQ-0006bm-BQ
 for linux-nvme@lists.infradead.org; Tue, 20 Oct 2020 08:15:05 +0000
Received: by mail-wr1-f68.google.com with SMTP id y12so983805wrp.6
 for <linux-nvme@lists.infradead.org>; Tue, 20 Oct 2020 01:15:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=JICnmpgJqEyWxnJUxHlU/3GJOgOwF6R6VyauLHmmydI=;
 b=nmRAglWUxjFrWSBgiMFhsIzppmAUj4fCbB2WPY3mtPRaiMx5XvyXQa9KNlSXLFlgLv
 z6FFZNxmNgI29YFxrcTiswGbhTloxvNocrswo1PVW0Y6/HzaZOJ0SIq8KXcaPphUNKnc
 /1rYNMkSAJE5DlRCYb7362rOS71Cd1ckAkUwlN52DsBd17Vey98cK1x+vMKQWyWOtF3Q
 Ce5DYXm2hiEDvi/76oR3WMAQJV4c0JpVAxAI+CHWzR4fkQJQpkOzEqd7llso8k8S5//4
 o25VlVRTiMiZ4W1vMZR97/pdB/DkSa27vmEzSXkwrSIrDBR6u+47W86hpZrg845Drf2H
 8qNg==
X-Gm-Message-State: AOAM5319ggjhKbd1QZYnVyng0u0eC/iGTYNK7M9VcGMdovDFegu0ui58
 gdrf0+PgsJYV3MkMHymDP8U=
X-Google-Smtp-Source: ABdhPJyy0gjEXQHtBQIRwv+UBiM50spMkkmt05u1TTdrEwJ573UPitbqj/kIxQgGeVSAwhrCJDTLhg==
X-Received: by 2002:adf:ef02:: with SMTP id e2mr1938653wro.381.1603181703320; 
 Tue, 20 Oct 2020 01:15:03 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:104e:47d9:f0fe:a697?
 ([2601:647:4802:9070:104e:47d9:f0fe:a697])
 by smtp.gmail.com with ESMTPSA id m14sm1735292wro.43.2020.10.20.01.14.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2020 01:15:02 -0700 (PDT)
Subject: Re: [PATCH 4/4] nvme: tcp: complete non-IO requests atomically
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
References: <20201016142811.1262214-1-ming.lei@redhat.com>
 <20201016142811.1262214-5-ming.lei@redhat.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <7a63d842-a1d3-6452-9961-f22c212bf545@grimberg.me>
Date: Tue, 20 Oct 2020 01:14:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201016142811.1262214-5-ming.lei@redhat.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201020_041504_410808_F1286C31 
X-CRM114-Status: GOOD (  27.40  )
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
Cc: Yi Zhang <yi.zhang@redhat.com>, Chao Leng <lengchao@huawei.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> During controller's CONNECTING state, admin/fabric/connect requests
> are submitted for recovery, and we allow to abort this request directly
> in time out handler for not blocking the setup step.
> 
> So timout vs. normal completion race may be triggered on these requests.
> 
> Add atomic completion for requests from connect/fabric/admin queue for
> avoiding the race.

I don't understand why this is needed... I don't understand the race,
and I don't understand why fencing the queue with nvme_tcp_stop_queue
and serialization against the teardown flow is not sufficient.

> 
> CC: Chao Leng <lengchao@huawei.com>
> Cc: Sagi Grimberg <sagi@grimberg.me>
> Reported-by: Yi Zhang <yi.zhang@redhat.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   drivers/nvme/host/tcp.c | 40 +++++++++++++++++++++++++++++++++++++---
>   1 file changed, 37 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 56ac61a90c1b..654061abdc5a 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -30,6 +30,8 @@ static int so_priority;
>   module_param(so_priority, int, 0644);
>   MODULE_PARM_DESC(so_priority, "nvme tcp socket optimize priority");
>   
> +#define REQ_STATE_COMPLETE     0
> +
>   enum nvme_tcp_send_state {
>   	NVME_TCP_SEND_CMD_PDU = 0,
>   	NVME_TCP_SEND_H2C_PDU,
> @@ -56,6 +58,8 @@ struct nvme_tcp_request {
>   	size_t			offset;
>   	size_t			data_sent;
>   	enum nvme_tcp_send_state state;
> +
> +	unsigned long		comp_state;
>   };
>   
>   enum nvme_tcp_queue_flags {
> @@ -469,6 +473,33 @@ static void nvme_tcp_error_recovery(struct nvme_ctrl *ctrl)
>   	queue_work(nvme_reset_wq, &to_tcp_ctrl(ctrl)->err_work);
>   }
>   
> +/*
> + * requests originated from admin, fabrics and connect_q have to be
> + * completed atomically because we don't cover the race between timeout
> + * and normal completion for these queues.
> + */
> +static inline bool nvme_tcp_need_atomic_complete(struct request *rq)
> +{
> +	return !rq->rq_disk;
> +}
> +
> +static inline void nvme_tcp_clear_rq_complete(struct request *rq)
> +{
> +	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
> +
> +	if (unlikely(nvme_tcp_need_atomic_complete(rq)))
> +		clear_bit(REQ_STATE_COMPLETE, &req->comp_state);
> +}
> +
> +static inline bool nvme_tcp_mark_rq_complete(struct request *rq)
> +{
> +	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
> +
> +	if (unlikely(nvme_tcp_need_atomic_complete(rq)))
> +		return !test_and_set_bit(REQ_STATE_COMPLETE, &req->comp_state);
> +	return true;
> +}
> +
>   static int nvme_tcp_process_nvme_cqe(struct nvme_tcp_queue *queue,
>   		struct nvme_completion *cqe)
>   {
> @@ -483,7 +514,8 @@ static int nvme_tcp_process_nvme_cqe(struct nvme_tcp_queue *queue,
>   		return -EINVAL;
>   	}
>   
> -	if (!nvme_try_complete_req(rq, cqe->status, cqe->result))
> +	if (nvme_tcp_mark_rq_complete(rq) &&
> +			!nvme_try_complete_req(rq, cqe->status, cqe->result))
>   		nvme_complete_rq(rq);
>   	queue->nr_cqe++;
>   
> @@ -674,7 +706,8 @@ static inline void nvme_tcp_end_request(struct request *rq, u16 status)
>   {
>   	union nvme_result res = {};
>   
> -	if (!nvme_try_complete_req(rq, cpu_to_le16(status << 1), res))
> +	if (nvme_tcp_mark_rq_complete(rq) &&
> +			!nvme_try_complete_req(rq, cpu_to_le16(status << 1), res))
>   		nvme_complete_rq(rq);
>   }
>   
> @@ -2173,7 +2206,7 @@ static void nvme_tcp_complete_timed_out(struct request *rq)
>   	/* fence other contexts that may complete the command */
>   	mutex_lock(&to_tcp_ctrl(ctrl)->teardown_lock);
>   	nvme_tcp_stop_queue(ctrl, nvme_tcp_queue_id(req->queue));
> -	if (!blk_mq_request_completed(rq)) {
> +	if (nvme_tcp_mark_rq_complete(rq) && !blk_mq_request_completed(rq)) {
>   		nvme_req(rq)->status = NVME_SC_HOST_ABORTED_CMD;
>   		blk_mq_complete_request(rq);
>   	}
> @@ -2315,6 +2348,7 @@ static blk_status_t nvme_tcp_queue_rq(struct blk_mq_hw_ctx *hctx,
>   	if (unlikely(ret))
>   		return ret;
>   
> +	nvme_tcp_clear_rq_complete(rq);
>   	blk_mq_start_request(rq);
>   
>   	nvme_tcp_queue_request(req, true, bd->last);
> 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
