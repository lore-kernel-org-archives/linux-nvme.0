Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 026F5C5478C
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Feb 2024 06:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DVrXS3meSWSjd1bMnUURR+S00gfRTU0w1XU7uYCcLWc=; b=C09fpvFYOPFJumfIg8tUkzfaNi
	bTXdFd9cRQddu7Q76GDHXlDeqOyZqsRqzTNIThdTh1urnV7+Fbwyw8HQBhMBAU/yZWlmLyITnm95x
	BPLRFnK7S2FGjfMGt2UCs9PSMD2q1QtBOJVbGQeWasG/Awt8dO3it6wbuQSEqSpL8U658t3M2UyRt
	gmizHWxx3sgh+NqcubUIEbmFVJT1f1c883di0wEdhLogDxQg0+uV55GhW8aUxgvtaKoNc2QyCMSgM
	2iVlb0KyrHVsVrI0xypsv267VsITW3rHhn2dQXv7x0ewAgFlqgAiFkxOafVJv5kpbkVzNQnOHtHl9
	SvGXHhLg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1reqbC-00000003wBT-0I0I;
	Tue, 27 Feb 2024 06:05:54 +0000
Received: from out30-99.freemail.mail.aliyun.com ([115.124.30.99])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1reqb8-00000003wAp-1BT4
	for linux-nvme@lists.infradead.org;
	Tue, 27 Feb 2024 06:05:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709013946; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=DVrXS3meSWSjd1bMnUURR+S00gfRTU0w1XU7uYCcLWc=;
	b=kW9uhvgNAuonyMISY5hwiFyG4OzwrfWhXjk/kTVIzaUKmo2IQn6DQYVZVJOKX7pyjAxl/OZjlwARkzI0myWGKEbKTABUtRQLhJE60rwpZHCTek/YDexNfkVC7UktRln56IACQsMYM6/szW4wqkBmrbgR8+Bum5mPHat0S+jjm2o=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0W1LdhBy_1709013942;
Received: from 30.178.84.101(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0W1LdhBy_1709013942)
          by smtp.aliyun-inc.com;
          Tue, 27 Feb 2024 14:05:43 +0800
Message-ID: <c8f19c2c-82fe-4cc3-b408-bf8040222fba@linux.alibaba.com>
Date: Tue, 27 Feb 2024 14:05:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: move nvme_dsm_range size check to
 _nvme_check_size()
Content-Language: en-GB
From: Guixin Liu <kanie@linux.alibaba.com>
To: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org
References: <20240223032947.55086-1-kanie@linux.alibaba.com>
In-Reply-To: <20240223032947.55086-1-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240226_220551_013871_E5967E51 
X-CRM114-Status: GOOD (  11.28  )
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

Hi,

     Gentle ping...

Best Regards,

Guixin Liu

在 2024/2/23 11:29, Guixin Liu 写道:
> Move nvme_dsm_range size check to _nvme_check_size(), and remove
> redundant same check.
>
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
> ---
>   drivers/nvme/host/core.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 5cdd22f591f9..848d4b896fec 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1800,9 +1800,6 @@ static void nvme_config_discard(struct nvme_ctrl *ctrl, struct gendisk *disk,
>   		return;
>   	}
>   
> -	BUILD_BUG_ON(PAGE_SIZE / sizeof(struct nvme_dsm_range) <
> -			NVME_DSM_MAX_RANGES);
> -
>   	/*
>   	 * If discard is already enabled, don't reset queue limits.
>   	 *
> @@ -4602,8 +4599,6 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
>   	ctrl->ka_cmd.common.opcode = nvme_admin_keep_alive;
>   	ctrl->ka_last_check_time = jiffies;
>   
> -	BUILD_BUG_ON(NVME_DSM_MAX_RANGES * sizeof(struct nvme_dsm_range) >
> -			PAGE_SIZE);
>   	ctrl->discard_page = alloc_page(GFP_KERNEL);
>   	if (!ctrl->discard_page) {
>   		ret = -ENOMEM;
> @@ -4823,6 +4818,8 @@ static inline void _nvme_check_size(void)
>   	BUILD_BUG_ON(sizeof(struct nvme_dbbuf) != 64);
>   	BUILD_BUG_ON(sizeof(struct nvme_directive_cmd) != 64);
>   	BUILD_BUG_ON(sizeof(struct nvme_feat_host_behavior) != 512);
> +	BUILD_BUG_ON(NVME_DSM_MAX_RANGES * sizeof(struct nvme_dsm_range) >
> +			PAGE_SIZE);
>   }
>   
>   

