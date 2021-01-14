Return-Path: <SRS0=kiw1=GR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 386CBC433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 02:48:34 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D493B235FF
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 02:48:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D493B235FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=liMU/0pd+YOwpI0o0WtqLwvC10nVAefZcNDemkcsJMI=; b=WRe9aOmk0yvWj/wZubt9AsIN6
	n5ruHkLeGfzww5n2zakpmOdZCiOq6/vKIPOa+yVswXNCFer4t66RCb9rgJCZzCACNvCQlI+aaVibQ
	cayoC5frig2BKbmcafLu+XUyrM+FZbhVSp+nf3lCRS/QT3lT+7p/1i7i53IAjWjBwIbhl6BM4D3u+
	rTL3egAb0yjc129v+p7+enZgahxeNBbE6Y7/ucDaL4rWJ38XfJi0d9Uz2pv9JeBH+rTL+f4ykHj2O
	nrlZAkcC3bV6YcSw0hKtz2UGMSSGuGAHE+YSBAdeBHE0kJB1/BjjeKuS8d66ZAbnI8mHuDXm4BIhZ
	oYUPtlIbw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kzsgG-0000Kv-OV; Thu, 14 Jan 2021 02:48:12 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kzsgC-0000KQ-IH
 for linux-nvme@lists.infradead.org; Thu, 14 Jan 2021 02:48:10 +0000
Received: from DGGEMM406-HUB.china.huawei.com (unknown [172.30.72.55])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4DGTHB1r20zQwqV;
 Thu, 14 Jan 2021 10:47:02 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 DGGEMM406-HUB.china.huawei.com (10.3.20.214) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Thu, 14 Jan 2021 10:47:57 +0800
Received: from [10.169.42.93] (10.169.42.93) by dggema772-chm.china.huawei.com
 (10.1.198.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1913.5; Thu, 14
 Jan 2021 10:47:57 +0800
Subject: Re: [PATCH V2 2/2] nvme: retry commands based on ACRE result
To: Minwoo Im <minwoo.im.dev@gmail.com>, <linux-nvme@lists.infradead.org>
References: <20210113143538.554-1-minwoo.im.dev@gmail.com>
 <20210113143538.554-3-minwoo.im.dev@gmail.com>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <b122f482-cb73-67ff-1a30-053c1e8c9c18@huawei.com>
Date: Thu, 14 Jan 2021 10:47:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20210113143538.554-3-minwoo.im.dev@gmail.com>
Content-Language: en-US
X-Originating-IP: [10.169.42.93]
X-ClientProxiedBy: dggeme719-chm.china.huawei.com (10.1.199.115) To
 dggema772-chm.china.huawei.com (10.1.198.214)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210113_214810_173224_36FD3E85 
X-CRM114-Status: GOOD (  23.49  )
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
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>, Christoph
 Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 2021/1/13 22:35, Minwoo Im wrote:
> Introduce acre flag for Advanced Command Retry Enable to controller
> instance to decide whether to retry or not in error cases.  This flag is
> set if Set Features for Host Behavior Support with ACRE bit set is
> successfully done during reset_work.
> 
> This patch also fixes nvme_decide_disposition() because all the nvme
> requests are initialized with REQ_FAILFAST_DRIVER to req->cmd_flags so
> that blk_noretry_request(req) is always true.  Check ctrl->acre first
> and if it's not host path error, then it will be retried.
> 
> Cc: Chao Leng <lengchao@huawei.com>
> Signed-off-by: Minwoo Im <minwoo.im.dev@gmail.com>
> ---
>   drivers/nvme/host/core.c | 16 ++++++++++++++--
>   drivers/nvme/host/nvme.h |  1 +
>   2 files changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index a8cee380b3c0..391bb2d08d0f 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -303,8 +303,7 @@ static inline enum nvme_disposition nvme_decide_disposition(struct request *req)
>   	if (likely(nvme_req(req)->status == 0))
>   		return COMPLETE;
>   
> -	if (blk_noretry_request(req) ||
> -	    (nvme_req(req)->status & NVME_SC_DNR) ||
> +	if ((nvme_req(req)->status & NVME_SC_DNR) ||
>   	    nvme_req(req)->retries >= nvme_max_retries)
>   		return COMPLETE;
>   
> @@ -317,6 +316,13 @@ static inline enum nvme_disposition nvme_decide_disposition(struct request *req)
>   			return COMPLETE;
>   	}
>   
> +	if (nvme_req(req)->ctrl->acre) {
> +		if (!nvme_is_path_error(nvme_req(req)->status) &&
> +				!blk_queue_dying(req->q))
> +			return RETRY;
> +	} else if (blk_noretry_request(req))
> +		return COMPLETE;
If acre is true and nvme_req(req)->status is nvme path error and
blk_noretry_request(req) is true, we need return complete for REQ_FAILFAST_XX.
Otherwise, connection process may takes long time in abnormal scenarios.
We can do like this:

+    if (nvme_req(req)->ctrl->acre &&
+        !nvme_is_path_error(nvme_req(req)->status) &&
+        !blk_queue_dying(req->q))
+        return RETRY;
+
+    if (blk_noretry_request(req))
+        return COMPLETE;
> +
>   	return RETRY;
>   }
>   
> @@ -2498,6 +2504,8 @@ static int nvme_configure_acre(struct nvme_ctrl *ctrl)
>   	struct nvme_feat_host_behavior *host;
>   	int ret;
>   
> +	ctrl->acre = false;
> +
>   	/* Don't bother enabling the feature if retry delay is not reported */
>   	if (!ctrl->crdt[0] && !ctrl->crdt[1] && !ctrl->crdt[2])
>   		return 0;
> @@ -2509,6 +2517,10 @@ static int nvme_configure_acre(struct nvme_ctrl *ctrl)
>   	host->acre = NVME_ENABLE_ACRE;
>   	ret = nvme_set_features(ctrl, NVME_FEAT_HOST_BEHAVIOR, 0,
>   				host, sizeof(*host), NULL);
> +
> +	if (!ret)
> +		ctrl->acre = true;
> +
>   	kfree(host);
>   	return ret;
>   }
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 88a6b97247f5..db8b45e8ffde 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -270,6 +270,7 @@ struct nvme_ctrl {
>   #ifdef CONFIG_BLK_DEV_ZONED
>   	u32 max_zone_append;
>   #endif
> +	bool acre;
>   	u16 crdt[3];
>   	u16 oncs;
>   	u16 oacs;
> 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
