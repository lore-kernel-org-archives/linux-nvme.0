Return-Path: <SRS0=b72z=GS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00AC4C433DB
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Jan 2021 02:17:27 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8436C23AAA
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Jan 2021 02:17:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8436C23AAA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=7Gj/7OoKQDTY1YHVZUyPI6K9BuH0MlT5nDQpwvNyIE4=; b=fWPu8hUH+IvCWjKxqt9PF1VSa
	l+4xVwB8esme0m2by/+7ZEKu2DcdVah3N/VBl2Xdh70l5op8iaTUgYfVgTh3hQeXEu3wyS1IKhjAo
	RtwVsvdblwKISmI6YXOBqtWpAjHPxbXIWyZe+1Fp/LXziKRb2fVcL7zvIHBqPVWe0z5siW/Xd5MJD
	jjKiS+11dfStuGGqT0N6qydMEBVF+0b8Zdnj1OSjRzc/ipPTLB1RAh3DmWXDGHKrbY1caFup7ks43
	zlVfMFXc6hfkH+OBy4n0irFto2J6L5YNPPnDfNJsByMVwMb1a7ZWGHhFduqF/U8GVfGLqPNiz6s3H
	PL95nbZ7A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l0Efq-0007X9-82; Fri, 15 Jan 2021 02:17:14 +0000
Received: from szxga03-in.huawei.com ([45.249.212.189])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l0Efm-0007WE-Ah
 for linux-nvme@lists.infradead.org; Fri, 15 Jan 2021 02:17:11 +0000
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.53])
 by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4DH4Xb027zz5G5H;
 Fri, 15 Jan 2021 10:15:43 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 DGGEMM404-HUB.china.huawei.com (10.3.20.212) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Fri, 15 Jan 2021 10:17:01 +0800
Received: from [10.169.42.93] (10.169.42.93) by dggema772-chm.china.huawei.com
 (10.1.198.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1913.5; Fri, 15
 Jan 2021 10:17:01 +0800
Subject: Re: [PATCH V3 3/3] nvme: retry commands based on ACRE flag
To: Minwoo Im <minwoo.im.dev@gmail.com>, <linux-nvme@lists.infradead.org>
References: <20210114133110.20779-1-minwoo.im.dev@gmail.com>
 <20210114133110.20779-4-minwoo.im.dev@gmail.com>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <6b01201e-fee7-db30-247e-444881f4cbed@huawei.com>
Date: Fri, 15 Jan 2021 10:17:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20210114133110.20779-4-minwoo.im.dev@gmail.com>
Content-Language: en-US
X-Originating-IP: [10.169.42.93]
X-ClientProxiedBy: dggeme710-chm.china.huawei.com (10.1.199.106) To
 dggema772-chm.china.huawei.com (10.1.198.214)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210114_211710_650913_BA0BEC74 
X-CRM114-Status: GOOD (  17.64  )
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

Reviewed-by: Chao Leng <lengchao@huawei.com>

On 2021/1/14 21:31, Minwoo Im wrote:
> Allow nvme_decide_disposition() to retry commands with error by checking
> Advanced Command Retry Enable (ACRE) flag of controller first than
> REQ_FAILFAST_* cmd_flags.  But, we just can't allow all command failures
> to be retried due to reasons like connecting may take too long due to
> the retries.  This patch only allows non-host path error commands to be
> retried.
> 
> Cc: Chao Leng <lengchao@huawei.com>
> Cc: Sagi Grimberg <sagi@grimberg.me>
> Cc: Keith Busch <kbusch@kernel.org>
> Signed-off-by: Minwoo Im <minwoo.im.dev@gmail.com>
> ---
>   drivers/nvme/host/core.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index a286e3422c61..e4f7c49c2f39 100644
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
> +	if (nvme_req(req)->ctrl->acre &&
> +	    !nvme_is_path_error(nvme_req(req)->status) &&
> +	    !blk_queue_dying(req->q))
> +		return RETRY;
> +	else if (blk_noretry_request(req))
> +		return COMPLETE;
> +
>   	return RETRY;
>   }
>   
> 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
