Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14852C3DA4B
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Jul 2024 22:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xsit9J/lGQzgcJVZgdOzeNmTKfTbZWv5F1tvlczn9DI=; b=NPe8l4dbD17OH2ZFbqwnHEZEY6
	Fng1noti+7zAjZj8oO3RV4si0YIfuyZ+ugQhf/8S1WY17+xwhDCWny5v7m7iZp624iP8V54ubv939
	in0lIuXarx8YAqyi0RR6/TWjODTyp+I8YltZeBMuek+UGIOJaR+W/jYxkvnWx8lNscowy/Un83zYq
	CFE1ZQJBIkTfqNTdLvIsgVKZecxwJeZ5Xhflb1h1MFGuaCtyCT4ZA0Ae0arLmfuU4YFgeNbE5pXmA
	qjjV/QMOb/HS7ynyyeRDa80Jr0vickqXPZEMIBoMX/OMsQnQf2FrvHqr7s8Q/1cmM+5NaBRzcW9It
	bsdY3rhQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sTUBB-00000008aZK-0x1y;
	Mon, 15 Jul 2024 22:28:21 +0000
Received: from mail-lf1-f46.google.com ([209.85.167.46])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sTUB8-00000008aXj-02x2
	for linux-nvme@lists.infradead.org;
	Mon, 15 Jul 2024 22:28:19 +0000
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52ea333534cso626391e87.3
        for <linux-nvme@lists.infradead.org>; Mon, 15 Jul 2024 15:28:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721082493; x=1721687293;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xsit9J/lGQzgcJVZgdOzeNmTKfTbZWv5F1tvlczn9DI=;
        b=bySoL0h1MevVdBpLqTAqRE1xLLdDVJckglZMWA4Q6Mq+tmCCkf78hdZZ1P2BeSrosr
         wl/Ev/06wzIq5VgKRcDjqTl5rghS6CvnTy0MLCR8LhWw5Y6PJlD6LNORbTYiluVvKq0F
         uF0SqLHB1ffhKSnWbRmvYKDOVkXRzUZuvbXQHhSu+zcfWWuNAHHGKwi1uNrs2d1cqlv4
         YeLCI2HpllOX1Oo31VqPw6/obnyAQLndDEXgu1bdVB+GcsXH9zVod3tK8L1Na+Y3zmh/
         0XWuJYZ7yBakAD6DZkxfUbBLBd+sGDJlLzDW7tHE8pJUijvLh1m152UtjtR+nx30UO29
         UlEw==
X-Forwarded-Encrypted: i=1; AJvYcCUPdudD3Xveq4pxQw8QrTcrw9L8zzknhSY7+w5tHi/zz+jA2zQkZq34iWXsiXeCFTmyldigoJLUtr1qUW+fmqvO7XHfuHVvM5rLPK6fYOE=
X-Gm-Message-State: AOJu0YzWsIszcH/VzpuV+NPyKV9kDpXMHys2BLXR0fvYdnmJYQwlH0Od
	DBwEAD4Cr4YI0pIFwkBLfut17Uhv6e/5ajY51rZcRqzKCSWWdt0U
X-Google-Smtp-Source: AGHT+IG2MfKCJtfRqX2mA/PJVIBummHIZz/L2uZHJk4V9zProwzV3BXN7x0Skc+Dq+coH+wdR8Bbcg==
X-Received: by 2002:a2e:9e59:0:b0:2ee:8071:5f03 with SMTP id 38308e7fff4ca-2eef2dc0b7bmr3468451fa.5.1721082493205;
        Mon, 15 Jul 2024 15:28:13 -0700 (PDT)
Received: from [10.100.102.74] (85.65.198.251.dynamic.barak-online.net. [85.65.198.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4279f239876sm136929735e9.3.2024.07.15.15.28.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jul 2024 15:28:12 -0700 (PDT)
Message-ID: <76fbe503-a8e7-47aa-9335-6e0a90cba4c2@grimberg.me>
Date: Tue, 16 Jul 2024 01:28:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] nvme_core: scan namespaces asynchronously
To: Stuart Hayes <stuart.w.hayes@gmail.com>, linux-kernel@vger.kernel.org,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
Cc: Hannes Reinecke <hare@suse.de>, Martin Wilck <martin.wilck@suse.com>,
 Ayush Siddarath <ayush.siddarath@dell.com>
References: <20240715203434.20212-1-stuart.w.hayes@gmail.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240715203434.20212-1-stuart.w.hayes@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240715_152818_092278_76AF1266 
X-CRM114-Status: GOOD (  38.05  )
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



On 15/07/2024 23:34, Stuart Hayes wrote:
> Use async function calls to make namespace scanning happen in parallel.
>
> Without the patch, NVME namespaces are scanned serially, so it can take
> a long time for all of a controller's namespaces to become available,
> especially with a slower (TCP) interface with large number of
> namespaces.
>
> It is not uncommon to have large numbers (hundreds or thousands) of
> namespaces on nvme-of with storage servers.
>
> The time it took for all namespaces to show up after connecting (via
> TCP) to a controller with 1002 namespaces was measured on one system:
>
> network latency   without patch   with patch
>       0                 6s            1s
>      50ms             210s           10s
>     100ms             417s           18s
>
> Measurements taken on another system show the effect of the patch on the
> time nvme_scan_work() took to complete, when connecting to a linux
> nvme-of target with varying numbers of namespaces, on a network of
> 400us.
>
> namespaces    without patch   with patch
>       1            16ms           14ms
>       2            24ms           16ms
>       4            49ms           22ms
>       8           101ms           33ms
>      16           207ms           56ms
>     100           1.4s           0.6s
>    1000          12.9s           2.0s

Not sure how common is the 1000 namespaces use-case, but the dozens of 
namespaces
seems compelling enough.

>
> On the same system, connecting to a local PCIe NVMe drive (a Samsung
> PM1733) instead of a network target:
>
> namespaces    without patch   with patch
>       1            13ms           12ms
>       2            41ms           13ms
>
> Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
> ---
> changes from V2:
>    * make a separate function nvme_scan_ns_async() that calls
>      nvme_scan_ns(), instead of modifying nvme_scan_ns()
>    * only scan asynchronously from nvme_scan_ns_list(), not from
>      nvme_scan_ns_sequential()
>    * provide more timing data in the commit message
>
> changes from V1:
>    * remove module param to enable/disable async scanning
>    * add scan time measurements to commit message
>
>
>   drivers/nvme/host/core.c | 48 +++++++++++++++++++++++++++++++++-------
>   1 file changed, 40 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 782090ce0bc1..dbf05cfea063 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -4,6 +4,7 @@
>    * Copyright (c) 2011-2014, Intel Corporation.
>    */
>   
> +#include <linux/async.h>
>   #include <linux/blkdev.h>
>   #include <linux/blk-mq.h>
>   #include <linux/blk-integrity.h>
> @@ -3952,6 +3953,30 @@ static void nvme_scan_ns(struct nvme_ctrl *ctrl, unsigned nsid)
>   	}
>   }
>   
> +/*
> + * struct async_scan_info - keeps track of controller & NSIDs to scan
> + * @ctrl:	Controller on which namespaces are being scanned
> + * @next_idx:	Index of next NSID to scan in ns_list
> + * @ns_list:	Pointer to list of NSIDs to scan
> + */
> +struct async_scan_info {
> +	struct nvme_ctrl *ctrl;
> +	atomic_t next_idx;

next_nsid ?

> +	__le32 *ns_list;
> +};
> +
> +static void nvme_scan_ns_async(void *data, async_cookie_t cookie)
> +{
> +	struct async_scan_info *scan_info = data;
> +	int idx;
> +	u32 nsid;
> +
> +	idx = (u32)atomic_fetch_add(1, &scan_info->next_idx);
> +	nsid = le32_to_cpu(scan_info->ns_list[idx]);
> +
> +	nvme_scan_ns(scan_info->ctrl, nsid);
> +}
> +
>   static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
>   					unsigned nsid)
>   {
> @@ -3975,12 +4000,14 @@ static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
>   static int nvme_scan_ns_list(struct nvme_ctrl *ctrl)
>   {
>   	const int nr_entries = NVME_IDENTIFY_DATA_SIZE / sizeof(__le32);
> -	__le32 *ns_list;
> +	struct async_scan_info scan_info;

What initializes next_idx?

>   	u32 prev = 0;
>   	int ret = 0, i;
> +	ASYNC_DOMAIN(domain);
>   
> -	ns_list = kzalloc(NVME_IDENTIFY_DATA_SIZE, GFP_KERNEL);
> -	if (!ns_list)
> +	scan_info.ctrl = ctrl;
> +	scan_info.ns_list = kzalloc(NVME_IDENTIFY_DATA_SIZE, GFP_KERNEL);
> +	if (!scan_info.ns_list)
>   		return -ENOMEM;

I think you can leave the local variable ns_list as is, and just assign 
it to scan_info
after, its common practice to allocate to a local pointer and use it to 
init a struct member.

Plus it will make the patch diff simpler.

>   
>   	for (;;) {
> @@ -3990,28 +4017,33 @@ static int nvme_scan_ns_list(struct nvme_ctrl *ctrl)
>   			.identify.nsid		= cpu_to_le32(prev),
>   		};
>   
> -		ret = nvme_submit_sync_cmd(ctrl->admin_q, &cmd, ns_list,
> -					    NVME_IDENTIFY_DATA_SIZE);
> +		ret = nvme_submit_sync_cmd(ctrl->admin_q, &cmd,
> +					   scan_info.ns_list,
> +					   NVME_IDENTIFY_DATA_SIZE);
>   		if (ret) {
>   			dev_warn(ctrl->device,
>   				"Identify NS List failed (status=0x%x)\n", ret);
>   			goto free;
>   		}
>   
> +		atomic_set(&scan_info.next_idx, 0);
>   		for (i = 0; i < nr_entries; i++) {
> -			u32 nsid = le32_to_cpu(ns_list[i]);
> +			u32 nsid = le32_to_cpu(scan_info.ns_list[i]);
>   
>   			if (!nsid)	/* end of the list? */
>   				goto out;
> -			nvme_scan_ns(ctrl, nsid);
> +			async_schedule_domain(nvme_scan_ns_async, &scan_info,
> +						&domain);
>   			while (++prev < nsid)
>   				nvme_ns_remove_by_nsid(ctrl, prev);
>   		}
> +		async_synchronize_full_domain(&domain);
>   	}
>    out:
>   	nvme_remove_invalid_namespaces(ctrl, prev);
>    free:
> -	kfree(ns_list);
> +	async_synchronize_full_domain(&domain);
> +	kfree(scan_info.ns_list);
>   	return ret;
>   }
>   


