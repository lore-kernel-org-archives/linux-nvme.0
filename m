Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 688F7E810CD
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Sep 2023 10:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RNBlxpHUhx9WM3ToMjsaAz8fgKkxgFSAhwK1R49FERk=; b=afLt5qGEmrwH8gcWTUQ+a9lehw
	L50hM9RfKJIGSzKsr8G6SNMC4WEGXjwh+ey/DP8H3o5ll1sQMjbOWrxgDWkmKeHGIKo9pGAQpa+RC
	5VRWVJO7LNBmZwfjl5PRZ5HiUghIZBcH1RLRcHLexp0gsMHRJhh9YE41cwikLsJb0HyLvyNCJvGeH
	hHYyGikq12RcMyTsC6CkIxix5EtjP3ZUuP0lmJWGW1WnwUHUpbXNrCC1bAq55EwFHYT7dQaJRpxYW
	aU0yEoOi5TikW0vyisw7j67HLtYIgUJt0O+owA2Xa+EP4e/nG4aehc6vajIhv8beXOrmgSVCXMLVU
	ugCgAJng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qlSDG-000lHN-1Z;
	Wed, 27 Sep 2023 10:56:14 +0000
Received: from mail-wm1-f50.google.com ([209.85.128.50])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qlSDD-000lGm-2F
	for linux-nvme@lists.infradead.org;
	Wed, 27 Sep 2023 10:56:13 +0000
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-405e48d8e72so9134275e9.0
        for <linux-nvme@lists.infradead.org>; Wed, 27 Sep 2023 03:56:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695812169; x=1696416969;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RNBlxpHUhx9WM3ToMjsaAz8fgKkxgFSAhwK1R49FERk=;
        b=QpfFwzJXam98El4HgSqBAGa2/DR1IKI5QtrnAFA+N03b6rbBunOsqpgKREuup5vb+E
         dX5rjzyC1P/g+SsAGvD2IZftEVF7ZGNvq/pFhmGF5nl/N/6iRHk+S5vbhtyDJ+zI1qZF
         iVJrxLz+AkLizQB96tlBVijdKQq49jE6LDgKM17EGeI+QDgcmW91zrIS5oOoATqEhxh8
         IbC9ZkKKTOV2HsPkSlNm7ei5WGBogN66VX+MQWjD4U9waGWvZaaBdL105avrCIuExv0n
         siMgzn+QxH0+hAGrtx0US41SSnJiFlRosvARAanvvzXzKVFWrBwW9mtrjAJ8oQ4m5waA
         +x0g==
X-Gm-Message-State: AOJu0YzonV4VQMyZlcjk3roGfZIoae6dYUccHsdYZk/ULQTkcWlGUEIT
	qJS6hklsqkyVozVJWkkpn/k=
X-Google-Smtp-Source: AGHT+IFYaQ29saDwpzP+GEDhAXG4KCXnt3+g0Gsoyx6XGlXwGsdBAhjqbeBN+XY8Xu/60NSKOdajCg==
X-Received: by 2002:a05:600c:510b:b0:3fe:21a6:a18 with SMTP id o11-20020a05600c510b00b003fe21a60a18mr1692668wms.3.1695812168698;
        Wed, 27 Sep 2023 03:56:08 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id l7-20020a1c7907000000b003fef60005b5sm9808732wme.9.2023.09.27.03.56.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Sep 2023 03:56:08 -0700 (PDT)
Message-ID: <e034b1ec-68d7-9ccd-4c3f-2bf3c34d3ade@grimberg.me>
Date: Wed, 27 Sep 2023 13:56:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 1/3] block: introduce blk_queue_nr_active()
Content-Language: en-US
To: "Ewan D. Milne" <emilne@redhat.com>, linux-nvme@lists.infradead.org
Cc: tsong@purestorage.com, jmeneghi@redhat.com, mlombard@redhat.com
References: <20230925163123.16042-1-emilne@redhat.com>
 <20230925163123.16042-2-emilne@redhat.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230925163123.16042-2-emilne@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230927_035611_734573_418A96E4 
X-CRM114-Status: GOOD (  20.38  )
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



On 9/25/23 19:31, Ewan D. Milne wrote:
> Returns a count of the total number of active requests
> in a queue.  For non-shared tags (the usual case) this is
> the sum of nr_active from all of the hctxs.
> 
> Signed-off-by: Ewan D. Milne <emilne@redhat.com>
> ---
>   block/blk-mq.h         |  5 -----
>   include/linux/blk-mq.h | 33 ++++++++++++++++++++++++++-------
>   2 files changed, 26 insertions(+), 12 deletions(-)
> 
> diff --git a/block/blk-mq.h b/block/blk-mq.h
> index 1743857e0b01..fbc65eefa017 100644
> --- a/block/blk-mq.h
> +++ b/block/blk-mq.h
> @@ -214,11 +214,6 @@ static inline bool blk_mq_tag_is_reserved(struct blk_mq_tags *tags,
>   	return tag < tags->nr_reserved_tags;
>   }
>   
> -static inline bool blk_mq_is_shared_tags(unsigned int flags)
> -{
> -	return flags & BLK_MQ_F_TAG_HCTX_SHARED;
> -}
> -
>   static inline struct blk_mq_tags *blk_mq_tags_from_data(struct blk_mq_alloc_data *data)
>   {
>   	if (data->rq_flags & RQF_SCHED_TAGS)
> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> index 01e8c31db665..c921ae5236ab 100644
> --- a/include/linux/blk-mq.h
> +++ b/include/linux/blk-mq.h
> @@ -716,6 +716,32 @@ int blk_rq_poll(struct request *rq, struct io_comp_batch *iob,
>   
>   bool blk_mq_queue_inflight(struct request_queue *q);
>   
> +#define queue_for_each_hw_ctx(q, hctx, i)				\
> +	xa_for_each(&(q)->hctx_table, (i), (hctx))
> +
> +#define hctx_for_each_ctx(hctx, ctx, i)					\
> +	for ((i) = 0; (i) < (hctx)->nr_ctx &&				\
> +	     ({ ctx = (hctx)->ctxs[(i)]; 1; }); (i)++)
> +
> +static inline bool blk_mq_is_shared_tags(unsigned int flags)
> +{
> +	return flags & BLK_MQ_F_TAG_HCTX_SHARED;
> +}
> +
> +static inline unsigned int blk_mq_queue_nr_active(struct request_queue *q)
> +{
> +	unsigned int nr_active = 0;
> +	struct blk_mq_hw_ctx *hctx;
> +	unsigned long i;
> +
> +	queue_for_each_hw_ctx(q, hctx, i) {
> +		if (unlikely(blk_mq_is_shared_tags(hctx->flags)))
> +			return atomic_read(&q->nr_active_requests_shared_tags);
> +		nr_active += atomic_read(&hctx->nr_active);
> +	}

I think that for the purposes of nvme-mpath you should probably be
interested in the hctx mapped to the running cpu, and not the
cumulative active requests.

As for BLK_MQ_F_TAG_HCTX_SHARED, this is dead-code until scsi/null makes
any use of it... but seems fine in theory.

