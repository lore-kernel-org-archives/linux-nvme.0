Return-Path: <SRS0=kiw1=GR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B167EC433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 01:11:27 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1325F23435
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 01:11:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1325F23435
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=4MMisumePJ39DdAPk9XKf1eWklXWJc6Jx8s71wy/lWA=; b=K/i/wpvHqHA1RtP4tIRSuma5f
	nKXrr8NSfKS56ydXmTt2loxAUl4F6jkw4z9g+QVHRYS+Uxl87jq2chXCteXhiGmlWru9RrbVeHOq4
	l5MLRjWLpyz8bvwb1zcuh0s+aWfgDk98IFtaPl956X/IpgVVfNmh0bPL8lgcRxmYDtCNZIX1sf4C/
	pZQ8o9DV6+xPS61Ej2PlIkp8F4BoHLphJNlIhlCKsEd7naSCbTWL0KhJtebKhyunXj61J+MRpHs3F
	AeS+upqWDSfGoYNRJRabJ4yG6SIKMRNue2nnv3CI/wHHC9uKR+7quE+0iBaV1D/S0qpgEBEP6h+mE
	A9MduSljg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kzrAT-00055O-Ac; Thu, 14 Jan 2021 01:11:17 +0000
Received: from mail-wr1-f50.google.com ([209.85.221.50])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kzrAQ-00054x-Fn
 for linux-nvme@lists.infradead.org; Thu, 14 Jan 2021 01:11:15 +0000
Received: by mail-wr1-f50.google.com with SMTP id t30so4088402wrb.0
 for <linux-nvme@lists.infradead.org>; Wed, 13 Jan 2021 17:11:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=OQp03nloi2yTDHHvvrT0JOpvhMT0tEuY/rJbaCztNFg=;
 b=L/nPFuN4Kb2EFICriGiiTG5b8RETqhZs1TT57QAau7DKew/allK4ePjOhZegrA0JO5
 VAxzMnfUdR3ljoqxrshLq8YbMYbvVfB4Fy/Uw0Mo1UT6227F5NAs7tm1m1FlICwUSRpk
 2CpQYfo1ff8k873de5HmJk6SVH5RinYWjpb6dOwJxdqoYsmZOthEm6qqVIYk6q3Vri/I
 BY2qTz8mlCI/zl2GRdiEpAEa1//8u9szQJT5NDrMQhNHMLDon3x7claBgTi0ZaLRpB1J
 1eUvhtygF6n1omeKveEcLo2ZtJVwOH0CNKFuvRg3+BaZj5TdstWzyhAIQ25k0kfxKTbh
 XlOg==
X-Gm-Message-State: AOAM533ep4C2HYwZQiFYs92ackajk2cA7RICk+Ik+6amZVR3YNMitGMA
 S56wwK5bGeXtPmkTvvz/7jI=
X-Google-Smtp-Source: ABdhPJyQJEv2bCZCJ94oJFBQ0n7/9HZt8DadRyePecDuwIP1smCTh9Vfd9YwiL9UX9MXoXUi+xzFyA==
X-Received: by 2002:adf:eb87:: with SMTP id t7mr5091370wrn.316.1610586673479; 
 Wed, 13 Jan 2021 17:11:13 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:e70c:620a:4d8a:b988?
 ([2601:647:4802:9070:e70c:620a:4d8a:b988])
 by smtp.gmail.com with ESMTPSA id w4sm5251394wmc.13.2021.01.13.17.11.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Jan 2021 17:11:13 -0800 (PST)
Subject: Re: [PATCH] nvme-rdma: avoid repeated request completion for
 concurrent nvme_rdma_timeout
To: Chao Leng <lengchao@huawei.com>, linux-nvme@lists.infradead.org
References: <20210106063635.7452-1-lengchao@huawei.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <002e7d37-433c-f8fa-f460-bfb2447d6bc0@grimberg.me>
Date: Wed, 13 Jan 2021 17:11:10 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210106063635.7452-1-lengchao@huawei.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210113_201114_568275_8C600137 
X-CRM114-Status: GOOD (  24.23  )
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
Cc: kbusch@kernel.org, axboe@fb.com, hch@lst.de
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


On 1/5/21 10:36 PM, Chao Leng wrote:
> A crash happens when inject completing request long time(nearly 30s).
> Each name space has a request queue, when inject completing request long
> time, multi request queues may has time out requests at the same time,
> nvme_rdma_timeout will execute concurrently. Multi requests in different
> request queues may be queued in the same rdma queue, multi
> nvme_rdma_timeout may call nvme_rdma_stop_queue at the same time.
> The first nvme_rdma_timeout will clear NVME_RDMA_Q_LIVE and continue
> stopping the rdma queue(drain qp), but the others check NVME_RDMA_Q_LIVE
> is already cleared, and then directly complete the requests, but the
> rdma queue may be not stopped and the request may be already completed
> in qp and wait treated, the request will be repeated completed.
> Add a multex lock to serialize nvme_rdma_stop_queue.

This looks reasonable to me,

Mind sending one for nvme-tcp as well?

> 
> Signed-off-by: Chao Leng <lengchao@huawei.com>
> ---
>   drivers/nvme/host/rdma.c | 15 +++++++++++----
>   1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index df9f6f4549f1..d5c66e3eeb4a 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -97,6 +97,7 @@ struct nvme_rdma_queue {
>   	struct completion	cm_done;
>   	bool			pi_support;
>   	int			cq_size;
> +	struct mutex		queue_lock;
>   };
>   
>   struct nvme_rdma_ctrl {
> @@ -579,6 +580,7 @@ static int nvme_rdma_alloc_queue(struct nvme_rdma_ctrl *ctrl,
>   	int ret;
>   
>   	queue = &ctrl->queues[idx];
> +	mutex_init(&queue->queue_lock);
>   	queue->ctrl = ctrl;
>   	if (idx && ctrl->ctrl.max_integrity_segments)
>   		queue->pi_support = true;
> @@ -598,7 +600,8 @@ static int nvme_rdma_alloc_queue(struct nvme_rdma_ctrl *ctrl,
>   	if (IS_ERR(queue->cm_id)) {
>   		dev_info(ctrl->ctrl.device,
>   			"failed to create CM ID: %ld\n", PTR_ERR(queue->cm_id));
> -		return PTR_ERR(queue->cm_id);
> +		ret = PTR_ERR(queue->cm_id);
> +		goto out_destroy_mutex;
>   	}
>   
>   	if (ctrl->ctrl.opts->mask & NVMF_OPT_HOST_TRADDR)
> @@ -628,6 +631,8 @@ static int nvme_rdma_alloc_queue(struct nvme_rdma_ctrl *ctrl,
>   out_destroy_cm_id:
>   	rdma_destroy_id(queue->cm_id);
>   	nvme_rdma_destroy_queue_ib(queue);
> +out_destroy_mutex:
> +	mutex_destroy(&queue->queue_lock);
>   	return ret;
>   }
>   
> @@ -639,9 +644,10 @@ static void __nvme_rdma_stop_queue(struct nvme_rdma_queue *queue)
>   
>   static void nvme_rdma_stop_queue(struct nvme_rdma_queue *queue)
>   {
> -	if (!test_and_clear_bit(NVME_RDMA_Q_LIVE, &queue->flags))
> -		return;
> -	__nvme_rdma_stop_queue(queue);
> +	mutex_lock(&queue->queue_lock);
> +	if (test_and_clear_bit(NVME_RDMA_Q_LIVE, &queue->flags))
> +		__nvme_rdma_stop_queue(queue);
> +	mutex_unlock(&queue->queue_lock);
>   }
>   
>   static void nvme_rdma_free_queue(struct nvme_rdma_queue *queue)
> @@ -649,6 +655,7 @@ static void nvme_rdma_free_queue(struct nvme_rdma_queue *queue)
>   	if (!test_and_clear_bit(NVME_RDMA_Q_ALLOCATED, &queue->flags))
>   		return;
>   
> +	mutex_destroy(&queue->queue_lock);
>   	nvme_rdma_destroy_queue_ib(queue);
>   	rdma_destroy_id(queue->cm_id);
>   }
> 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
