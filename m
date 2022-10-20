Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE5CFC43219
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Oct 2022 13:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jJM/GBakjBfyCraEn+8twaTB9LWBeqaj9yYL5h/spdY=; b=Y7K2syS1yc5e+59YsrmKUPslP+
	6W+TKBQhvPEnzyleBsA86s6ow2L28p4IhArCjZRdSDKkpwSUc4d5xd4s3MwArnHJvNUUUQZXrw5Py
	4VS4uhPGsZJpRshestYVpNGUPh3o8fCFnRo47H0OtQ9i0wZ9ae1buL9aGIZtb+azYDFIbUyC1YHQt
	1xJoO9c8sH4AQDuA06jMkJQq0vd8zeSMWMOUl0KTU3wDvprjboBy252yGb4KDPhIwqQGDDKQwQ7ur
	tfnvNI0FKFAu9MvWfTD3L5DKzvWYewEStJU384ndn6J6n3j8uKrQ0s7u2cuFTILLAVlQym0avMgIT
	LrP1EwiQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olVro-00Fgq2-7g; Thu, 20 Oct 2022 13:45:48 +0000
Received: from mail-wr1-f47.google.com ([209.85.221.47])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olVhu-00FX9H-CG
	for linux-nvme@lists.infradead.org; Thu, 20 Oct 2022 13:35:36 +0000
Received: by mail-wr1-f47.google.com with SMTP id v1so5221505wrt.11
        for <linux-nvme@lists.infradead.org>; Thu, 20 Oct 2022 06:35:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jJM/GBakjBfyCraEn+8twaTB9LWBeqaj9yYL5h/spdY=;
        b=BjB2QxmxoIyBM596ZJ62gqTO4QJF46Ejsg0BsxgLYbxsQD1aKQdPiFclDUS4TgF4x+
         0VbcWGF38TLHzBur5qfPxPuo3JXn/N8WHxleSr3PcC2hscykCfSP6n/R4NQlq6ik4lyE
         eQbcBsg3Xb6WMlwic5hCjvMmxiAyod8xhTCyvBULO8W2GJ501m3mL2hWmYxgoQDmXFvM
         zSz3bUS04cBpAUUTnDQxTUF0hNkgP5GpwUPvjLwEpLvmYazc2lGJGkzMrtFrhKETtqwI
         Bhs/94bWaAmm18EKTln0ZU5xW5Rhs8iYatFI3civhnZfFav0X7jAwBA010U6n6NiY0wJ
         72Sg==
X-Gm-Message-State: ACrzQf2cILPYcGzPZv2U6+we21tWApNSpxAw2wf2V6MQGdiMMqgjudPJ
	GfRkfb2HHe2DbRv5qq94yWE=
X-Google-Smtp-Source: AMsMyM4qEcE7d8hVAOj1E6q5daxd0AaWGyc2Lt7wVQo03b0BJRrNli12Yp7Tz8grPoHRL+7JoYDYmg==
X-Received: by 2002:a5d:5a96:0:b0:232:2e1:48f7 with SMTP id bp22-20020a5d5a96000000b0023202e148f7mr8961586wrb.694.1666272933007;
        Thu, 20 Oct 2022 06:35:33 -0700 (PDT)
Received: from [192.168.64.53] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id o13-20020adfe80d000000b0023580e7a2c4sm2174878wrm.86.2022.10.20.06.35.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Oct 2022 06:35:32 -0700 (PDT)
Message-ID: <609615c0-225e-9607-e8cd-2f1a356211c0@grimberg.me>
Date: Thu, 20 Oct 2022 16:35:30 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 8/8] nvme: use blk_mq_[un]quiesce_tagset
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>, Chao Leng <lengchao@huawei.com>
Cc: Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org
References: <20221020105608.1581940-1-hch@lst.de>
 <20221020105608.1581940-9-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221020105608.1581940-9-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221020_063534_469513_1ECDCF45 
X-CRM114-Status: GOOD (  24.78  )
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



On 10/20/22 13:56, Christoph Hellwig wrote:
> From: Chao Leng <lengchao@huawei.com>
> 
> All controller namespaces share the same tagset, so we can use this
> interface which does the optimal operation for parallel quiesce based on
> the tagset type(e.g. blocking tagsets and non-blocking tagsets).
> 
> nvme connect_q should not be quiesced when quiesce tagset, so set the
> QUEUE_FLAG_SKIP_TAGSET_QUIESCE to skip it when init connect_q.
> 
> Currently we use NVME_NS_STOPPED to ensure pairing quiescing and
> unquiescing. If use blk_mq_[un]quiesce_tagset, NVME_NS_STOPPED will be
> invalided, so introduce NVME_CTRL_STOPPED to replace NVME_NS_STOPPED.
> In addition, we never really quiesce a single namespace. It is a better
> choice to move the flag from ns to ctrl.
> 
> Signed-off-by: Chao Leng <lengchao@huawei.com>
> [hch: rebased on top of prep patches]
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/nvme/host/core.c | 38 +++++++++-----------------------------
>   drivers/nvme/host/nvme.h |  2 +-
>   2 files changed, 10 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 0ab3a18fd9f85..cc71f1001144f 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -4891,6 +4891,7 @@ int nvme_alloc_io_tag_set(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set,
>   			ret = PTR_ERR(ctrl->connect_q);
>   			goto out_free_tag_set;
>   		}
> +		blk_queue_flag_set(QUEUE_FLAG_SKIP_TAGSET_QUIESCE, ctrl->connect_q);
>   	}
>   
>   	ctrl->tagset = set;
> @@ -5090,20 +5091,6 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
>   }
>   EXPORT_SYMBOL_GPL(nvme_init_ctrl);
>   
> -static void nvme_start_ns_queue(struct nvme_ns *ns)
> -{
> -	if (test_and_clear_bit(NVME_NS_STOPPED, &ns->flags))
> -		blk_mq_unquiesce_queue(ns->queue);
> -}
> -
> -static void nvme_stop_ns_queue(struct nvme_ns *ns)
> -{
> -	if (!test_and_set_bit(NVME_NS_STOPPED, &ns->flags))
> -		blk_mq_quiesce_queue(ns->queue);
> -	else
> -		blk_mq_wait_quiesce_done(ns->queue->tag_set);
> -}
> -
>   /**
>    * nvme_kill_queues(): Ends all namespace queues
>    * @ctrl: the dead controller that needs to end
> @@ -5120,10 +5107,9 @@ void nvme_kill_queues(struct nvme_ctrl *ctrl)
>   	if (ctrl->admin_q && !blk_queue_dying(ctrl->admin_q))
>   		nvme_start_admin_queue(ctrl);
>   	if (!test_and_set_bit(NVME_CTRL_NS_DEAD, &ctrl->flags)) {
> -		list_for_each_entry(ns, &ctrl->namespaces, list) {
> +		list_for_each_entry(ns, &ctrl->namespaces, list)
>   			blk_mark_disk_dead(ns->disk);
> -			nvme_start_ns_queue(ns);
> -		}
> +		nvme_start_queues(ctrl);
>   	}
>   	up_read(&ctrl->namespaces_rwsem);
>   }
> @@ -5179,23 +5165,17 @@ EXPORT_SYMBOL_GPL(nvme_start_freeze);
>   
>   void nvme_stop_queues(struct nvme_ctrl *ctrl)
>   {
> -	struct nvme_ns *ns;
> -
> -	down_read(&ctrl->namespaces_rwsem);
> -	list_for_each_entry(ns, &ctrl->namespaces, list)
> -		nvme_stop_ns_queue(ns);
> -	up_read(&ctrl->namespaces_rwsem);
> +	if (!test_and_set_bit(NVME_CTRL_STOPPED, &ctrl->flags))
> +		blk_mq_quiesce_tagset(ctrl->tagset);
> +	else
> +		blk_mq_wait_quiesce_done(ctrl->tagset);

Isn't blk_mq_quiesce_tagset already waits for the (s)rcu
grace? Is this to make a concurrent caller also wait?

I wish we would sort out all the concurrency issues in
the driver(s) instead of making core functions reentrant safe...

