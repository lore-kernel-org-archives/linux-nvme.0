Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE5DEC433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Nov 2021 08:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RC3vqKD9hTcCEz5IFzW1f6PPJL6TcyhoZreRczcumkw=; b=LQBGNNQ8pEeakqNUnb3iSeDvLX
	KUmIJFoJ5I9/bSHJJh3wji/BTRMX5Z+j6hWXJk/+059/keTUeMvl24KHTaZ/nH1pMleJRH2wccUqq
	RrRGHgMZLC/nPPa7J74es0OFnUT2NqF3Tj2+aDMhTp6JDmVxtMdybWcra51yZOM2sQq0KhqgPtNiy
	zv649oJcUTV30nyDI23wM/s4HlC0haZLXVaQGRbXzMePcuFlWyX6M3Hc1FiP+lNt9GSj3BHX1ITPt
	OP40uOP+T1ynO9N/OIZBkgzByBh2/L65ZIk/XlUAnTZZY53Hj1tjeg5nMMs0+LI5+R66EsYyKCa4w
	apoKoLMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mp4Xa-00FFoK-J0; Mon, 22 Nov 2021 08:19:06 +0000
Received: from mail-wr1-f52.google.com ([209.85.221.52])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mp4MJ-00FDSE-P0
 for linux-nvme@lists.infradead.org; Mon, 22 Nov 2021 08:07:29 +0000
Received: by mail-wr1-f52.google.com with SMTP id n29so30987781wra.11
 for <linux-nvme@lists.infradead.org>; Mon, 22 Nov 2021 00:07:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=RC3vqKD9hTcCEz5IFzW1f6PPJL6TcyhoZreRczcumkw=;
 b=QNRpmcGs+D1Gfg/lRPKypz2LH4b6NAcpMFKAqRPWRL7xVTFIQ3nE9vaLW1DlBBnBRh
 jSvbYDhmprQlciNZqEhXA7pflknIQXwPEFdqmM2oGljTH3Qb3j4oJLjsbjmq8x44P4p+
 i5rC5TGp1S65yHys6XlelZ3H2+dPiRKEqF+GKv+3p3h60QhPkwx3NazgboYalJWqYi/l
 4qES6/sD24tu3HIbbEPR/k0SUO2M73AWkAod5zVrcXPUcfw1CGR283u8IXpJoGMKBjHj
 fzsm6MVUasjnbSNUjjJsGFHki1Hx/34Sn+Vu3XLYLqmiXUrZwjlaDS5syImKW1evWPGD
 5hew==
X-Gm-Message-State: AOAM531DlhaZqzm97K1qCgqhpEl3cDiPDeukNNVF3jv0WJlkEmkl7EyJ
 Ve6SfEDOO8RrUzNfQq6ueSE=
X-Google-Smtp-Source: ABdhPJxbNRaRTtAyqwOPZ4j2lhyUy3FE9JmpQkWy0BpH4ksV9H6Z70PwoM66ii78SHDO1pIjj879vA==
X-Received: by 2002:a5d:6347:: with SMTP id b7mr34477235wrw.36.1637568446438; 
 Mon, 22 Nov 2021 00:07:26 -0800 (PST)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id j17sm11054638wmq.41.2021.11.22.00.07.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Nov 2021 00:07:26 -0800 (PST)
Subject: Re: [PATCH 4/5] nvme: quiesce namespace queue in parallel
To: Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
 Jens Axboe <axboe@kernel.dk>,
 "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
 Chao Leng <lengchao@huawei.com>
References: <20211119021849.2259254-1-ming.lei@redhat.com>
 <20211119021849.2259254-5-ming.lei@redhat.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <37036ab3-da87-898e-5af6-1abf228b4390@grimberg.me>
Date: Mon, 22 Nov 2021 10:07:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211119021849.2259254-5-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211122_000727_884479_753D20C3 
X-CRM114-Status: GOOD (  23.02  )
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



On 11/19/21 4:18 AM, Ming Lei wrote:
> Chao Leng reported that in case of lots of namespaces, it may take quite a
> while for nvme_stop_queues() to quiesce all namespace queues.
> 
> Improve nvme_stop_queues() by running quiesce in parallel, and just wait
> once if global quiesce wait is allowed.
> 
> Link: https://lore.kernel.org/linux-block/cc732195-c053-9ce4-e1a7-e7f6dcf762ac@huawei.com/
> Reported-by: Chao Leng <lengchao@huawei.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   drivers/nvme/host/core.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 4b5de8f5435a..06741d3ed72b 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -4517,9 +4517,7 @@ static void nvme_start_ns_queue(struct nvme_ns *ns)
>   static void nvme_stop_ns_queue(struct nvme_ns *ns)
>   {
>   	if (!test_and_set_bit(NVME_NS_STOPPED, &ns->flags))
> -		blk_mq_quiesce_queue(ns->queue);
> -	else
> -		blk_mq_wait_quiesce_done(ns->queue);
> +		blk_mq_quiesce_queue_nowait(ns->queue);
>   }
>   
>   /*
> @@ -4620,6 +4618,11 @@ void nvme_stop_queues(struct nvme_ctrl *ctrl)
>   	down_read(&ctrl->namespaces_rwsem);
>   	list_for_each_entry(ns, &ctrl->namespaces, list)
>   		nvme_stop_ns_queue(ns);
> +	list_for_each_entry(ns, &ctrl->namespaces, list) {
> +		blk_mq_wait_quiesce_done(ns->queue);
> +		if (blk_mq_global_quiesce_wait(ns->queue))
> +			break;
> +	}
>   	up_read(&ctrl->namespaces_rwsem);


Can you quantify how much of a difference it is to do rcu_read_unlock()
for every queue? The big improvement here is that it is done in parallel
instead of serially. Just wandering if it is worth the less than elegant
interface...

