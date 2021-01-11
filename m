Return-Path: <SRS0=B93q=GO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 220E2C433DB
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Jan 2021 03:48:35 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC14B221ED
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Jan 2021 03:48:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC14B221ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=XEaBnfdgKrj9SQkvtePWdD0yJL907R6V6mT7V56sWAc=; b=S3OVTA2rqay/vzTLZ5Qj+wCIb
	DzR+yWNIR5F6ZgvyHMKRYuhOd1jJHekNlXh2mZvwkAFI8S9IA7Z4q4+UrvauldoXOSAavh/ivJHbT
	fTJ50iSiasxz+lbIlHngVTEkr/ZlwcQ+xJpfhyplhGzqH4fCXL3ghqqAeFv121udmDyDHMjnF8qy7
	jfoYb18u7yFGoAyTq2HEduPfIIikL0mhmYhiL0b9LVSzvwuvibKC3vXZArj/KWKN+FC3ZAUiqlrBB
	gFiuLD5KZ5xlxyb8v6Gv4LSRsMAWy40+fJiMCcJmp+yu5KKwF9apZDMaEeK+/nxrQuWLf2aY/aSpP
	d8zYSukyA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kyoBn-0006vV-Te; Mon, 11 Jan 2021 03:48:19 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kyoBe-0006rS-V7
 for linux-nvme@lists.infradead.org; Mon, 11 Jan 2021 03:48:12 +0000
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.53])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4DDfll18C8z5G97;
 Mon, 11 Jan 2021 11:46:59 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 DGGEMM403-HUB.china.huawei.com (10.3.20.211) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Mon, 11 Jan 2021 11:47:58 +0800
Received: from [10.169.42.93] (10.169.42.93) by dggema772-chm.china.huawei.com
 (10.1.198.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1913.5; Mon, 11
 Jan 2021 11:47:57 +0800
Subject: Re: [PATCH 3/3] nvme: add parameter command_retry to enable retry
To: Minwoo Im <minwoo.im.dev@gmail.com>, <linux-nvme@lists.infradead.org>
References: <20210108144659.7126-1-minwoo.im.dev@gmail.com>
 <20210108144659.7126-4-minwoo.im.dev@gmail.com>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <dfe59030-3eab-a178-7264-792f76dffe4c@huawei.com>
Date: Mon, 11 Jan 2021 11:47:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20210108144659.7126-4-minwoo.im.dev@gmail.com>
Content-Language: en-US
X-Originating-IP: [10.169.42.93]
X-ClientProxiedBy: dggeme712-chm.china.huawei.com (10.1.199.108) To
 dggema772-chm.china.huawei.com (10.1.198.214)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210110_224811_288846_1728128E 
X-CRM114-Status: GOOD (  21.84  )
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



On 2021/1/8 22:46, Minwoo Im wrote:
> nvme_init_request() has set REQ_FAILFAST_DRIVER to make requests
> non-retryable.  This command flag value is checked in
> nvme_decide_disposition() to decide whether to RETRY or other
> operations.  In that point, blk_noretry_request() macro will be used to
> check if command flags have one of REQ_FAILFAST_*.  If so, it just
> decides to complete the request without retrying.
> 
> This patch added a module parameter named command_retry to turn on the
> command retry feature in this driver.  If turning it on,
> REQ3_FAILFAST_DRIVER will not be set to requests so that retry can be
> reached out to nvme_retry_req() based on the module parameter.
> 
> Signed-off-by: Minwoo Im <minwoo.im.dev@gmail.com>
> ---
>   drivers/nvme/host/core.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 6e428fdc25a8..e1836ca9956f 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -44,6 +44,10 @@ static unsigned char shutdown_timeout = 5;
>   module_param(shutdown_timeout, byte, 0644);
>   MODULE_PARM_DESC(shutdown_timeout, "timeout in seconds for controller shutdown");
>   
> +static bool command_retry;
> +module_param(command_retry, bool, 0644);
> +MODULE_PARM_DESC(command_retry, "retry commands up to nvme_max_retries");
> +
>   static u8 nvme_max_retries = 5;
>   module_param_named(max_retries, nvme_max_retries, byte, 0644);
>   MODULE_PARM_DESC(max_retries, "max number of retries a command may have");
> @@ -560,7 +564,8 @@ static inline void nvme_init_request(struct request *req,
>   	else /* no queuedata implies admin queue */
>   		req->timeout = NVME_ADMIN_TIMEOUT;
>   
> -	req->cmd_flags |= REQ_FAILFAST_DRIVER;
> +	if (!command_retry)
> +		req->cmd_flags |= REQ_FAILFAST_DRIVER;
In abnormal scenarios, such as request time out, connection process may takes long time or the admin command waits for long time.
Retry only for non-host errors may be a better choice. Maybe we can make some optimizations in nvme_decide_disposition.
>   	nvme_clear_nvme_request(req);
>   	nvme_req(req)->cmd = cmd;
>   }
> 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
