Return-Path: <SRS0=mLmp=GQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65EFEC433DB
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Jan 2021 22:20:54 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20A4723136
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Jan 2021 22:20:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20A4723136
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=hGauCGdTyYkVuQELngf5Of2rbshgt6xDcBoSamNXtro=; b=ocDaCZI1R/iLeN2Gufe9Ux+8C
	VsnsFfnLeuXsRwtx4sAx4W9Z24q1zGX/FNoXGuScKzrDbdKD7HCRIyhAxdhNn0u0Lr0Zs1aEIWPZa
	kHHm/r1B7jk7TpjQSsQX1YI5tqeZf7+kfrou1Vv/DsnOjCssv7H0K9bWNevmI5ckXyZYWocIPzeJ8
	syM4USUOJ5wL5uXCscBeR+vccSPHA1fecrNppyuRlpH87mD/+G7c1gZ9xyEzGajwxfBJCCIF4iH2o
	YYoLdp1g+iu7B1rElVKydfaCedXzOpI/bqz1UJdueFVqz8uBq7IH+Yv7Y+wmXRx/szK2IvgR7uGtE
	bU50SR9Cg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kzoVP-00013a-B0; Wed, 13 Jan 2021 22:20:43 +0000
Received: from mail-wr1-f50.google.com ([209.85.221.50])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kzoVL-000138-V1
 for linux-nvme@lists.infradead.org; Wed, 13 Jan 2021 22:20:41 +0000
Received: by mail-wr1-f50.google.com with SMTP id 91so3767376wrj.7
 for <linux-nvme@lists.infradead.org>; Wed, 13 Jan 2021 14:20:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ri+AqEXkQP+S7pNDCYmrIrrxht13Q8Bh0c/YMJ7WI0c=;
 b=HgFC4wIWpqD63QQVnx9Czsu014/i6llvQOTgp18h2vnqrBQxTDbn0YLgDC87QWoarB
 h2K4CkPhuQAK3AellUCY8AckzO3mGBeRRDmrHkQJe9bg+dFCCpYppEKNVQYjtbi5piJc
 PelfgK4BB8aOQEXufBJCMCwvUJA8gpjgLqX8RxpfkldMGZ/tu7uiHEY/gfISkeCIaZj1
 +yeBtX3kCMCXhuWZCHWkawabcE/32accx5fnNbdcxdeNcNt0sB4srzD0+ekqwYD157z0
 xU5ctjUfO6XH9o2MrMFPJwecFbdTMNWfliunO6MWi0d3w5+TTWfaWhrqqJhcl/4GZDaZ
 0tVA==
X-Gm-Message-State: AOAM530m8GSBinMBI3B3Kr8t2HUymbdj85RSyhdSx07jdOoIXgdiYZVc
 7TqvQjq6i5lFWQ7EuiiNFXY=
X-Google-Smtp-Source: ABdhPJzUaXIDg3ojVcKdjD5BRI2WiIGS7BSBRSIEq6Sp7qHiZGeN9Us7OSnCRpbnjfFIzMk6w9/Sow==
X-Received: by 2002:adf:f7d2:: with SMTP id a18mr4601701wrq.47.1610576438584; 
 Wed, 13 Jan 2021 14:20:38 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:e70c:620a:4d8a:b988?
 ([2601:647:4802:9070:e70c:620a:4d8a:b988])
 by smtp.gmail.com with ESMTPSA id h83sm5183983wmf.9.2021.01.13.14.20.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Jan 2021 14:20:38 -0800 (PST)
Subject: Re: [PATCH V2 2/2] nvme: retry commands based on ACRE result
To: Minwoo Im <minwoo.im.dev@gmail.com>, linux-nvme@lists.infradead.org
References: <20210113143538.554-1-minwoo.im.dev@gmail.com>
 <20210113143538.554-3-minwoo.im.dev@gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <3bd35739-c309-b04a-fbd7-90daee5aeae7@grimberg.me>
Date: Wed, 13 Jan 2021 14:20:34 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210113143538.554-3-minwoo.im.dev@gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210113_172040_317859_01B10D66 
X-CRM114-Status: GOOD (  26.12  )
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
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Chao Leng <lengchao@huawei.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

> Introduce acre flag for Advanced Command Retry Enable to controller
> instance to decide whether to retry or not in error cases.  This flag is
> set if Set Features for Host Behavior Support with ACRE bit set is
> successfully done during reset_work.
> 
> This patch also fixes nvme_decide_disposition() because all the nvme
> requests are initialized with REQ_FAILFAST_DRIVER to req->cmd_flags

You mean for passthru commands, nvme doesn't control this for other
commands.

> so
> that blk_noretry_request(req) is always true.  Check ctrl->acre first
> and if it's not host path error, then it will be retried.

I suggest to split out this part to its own patch.

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
