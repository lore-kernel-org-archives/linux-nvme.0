Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 161ABC43334
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Jun 2022 16:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZFZOF4kIZf5haKivlSJCFlw6yEpj+kTMN6wkZ1f2sSk=; b=f0QuGtLCT/X51U4+Wl2jan3WcG
	+JNpLt58QWlb9vHMinAG/fTGFUpEG0RgOrJohqAValRhw76t3t08CDW/yEEkbZvlKoR7G8LINS5CP
	mploNxE5NJOpz8TIG1z1qFEvdxgh/MooK2inu2Svuzn4Yh41QFZSlBO4Mf+58whc9z7AbejoFyCaa
	yrXoB+SZfUyJjjZPhfwrG6HXeaZQRJ2XM9tw2FPWTJPsrenLOMPOW3ArWDfchXdnmC40v7sMnvRy+
	SKQHR+tmWjcxqrZSHj9ucLp7QmueWOeS8zhRfd7alB4tucISLy1/RWWM72FRiSxKzsBqRb10nQuEB
	8/GYUmOw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o2EuN-008FAY-Bk; Fri, 17 Jun 2022 16:33:19 +0000
Received: from mail-pl1-f177.google.com ([209.85.214.177])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o2EuK-008F9J-JJ
	for linux-nvme@lists.infradead.org; Fri, 17 Jun 2022 16:33:17 +0000
Received: by mail-pl1-f177.google.com with SMTP id y6so4338864plg.0
        for <linux-nvme@lists.infradead.org>; Fri, 17 Jun 2022 09:33:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ZFZOF4kIZf5haKivlSJCFlw6yEpj+kTMN6wkZ1f2sSk=;
        b=4+h9JjWQWlR/2P4VKb8M8f5r+vH4W5rpmlym1nFR5nRsk9s4kdlyOGiHERxfFfbYDr
         KLKZDglTgVJG/SWH6s35ZISgjnfK+zsJ6RHoT4vo6Qg8wn6GMzsGx+BAzboGD7Q5fQOD
         cX7JRbLZpxNyAtDY3TbOI/b2zcl1G/KVSrq37+rRuwGGWhy9viSqIbpGboXX5R0OIY/q
         Se4dfcZk49ynuHQdCmibuYd3ajPEao6pu27tJ23yR6LLLsemmfBoJuaq/P5Y/G+Tp2V2
         Ts1/fdAeFZSgRjp+wGviNzu2t8DppDgLHR0vK/zRtau5/jrGbtTjOSqHbhBbwQjIi5LT
         D+hQ==
X-Gm-Message-State: AJIora9Ea5mpysl0D3Um4RJ993krtL7quhaLRglMa4hGwTRb86fJ/oj+
	qm79XjRuvaIQSLmA8kfhzn0=
X-Google-Smtp-Source: AGRyM1tFt6HG3OqcSvJKpLgUFiFTa/8qOGRuw+HZNz8Qnbyh9yDTQ+C2yWV2UI5DfkTd9FHmrT3DIw==
X-Received: by 2002:a17:902:7886:b0:167:5c8c:4d3e with SMTP id q6-20020a170902788600b001675c8c4d3emr10521665pll.74.1655483594617;
        Fri, 17 Jun 2022 09:33:14 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:5d24:3188:b21f:5671? ([2620:15c:211:201:5d24:3188:b21f:5671])
        by smtp.gmail.com with ESMTPSA id j1-20020a170903028100b00163d4c3ffabsm3774192plr.304.2022.06.17.09.33.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jun 2022 09:33:13 -0700 (PDT)
Message-ID: <017cae1e-b45f-04fd-d34c-22ae736b28e5@acm.org>
Date: Fri, 17 Jun 2022 09:33:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 5/5] blk-mq: Drop 'reserved' member of busy_tag_iter_fn
Content-Language: en-US
To: John Garry <john.garry@huawei.com>, axboe@kernel.dk,
 damien.lemoal@opensource.wdc.com, hch@lst.de, jejb@linux.ibm.com,
 martin.petersen@oracle.com, hare@suse.de, satishkh@cisco.com,
 sebaddel@cisco.com, kartilak@cisco.com
Cc: linux-rdma@vger.kernel.org, linux-mmc@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-scsi@vger.kernel.org, mpi3mr-linuxdrv.pdl@broadcom.com,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 nbd@other.debian.org
References: <1655463320-241202-1-git-send-email-john.garry@huawei.com>
 <1655463320-241202-6-git-send-email-john.garry@huawei.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <1655463320-241202-6-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220617_093316_678459_946F2AF4 
X-CRM114-Status: GOOD (  13.52  )
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

On 6/17/22 03:55, John Garry wrote:
> We no longer use the 'reserved' member in for any iter function so it
                                          ^^^^^^
One of these two words probably should be removed.

> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> index 2dcd738c6952..b8cc8b41553f 100644
> --- a/block/blk-mq-tag.c
> +++ b/block/blk-mq-tag.c
> @@ -266,7 +266,6 @@ static bool bt_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
>   	struct blk_mq_hw_ctx *hctx = iter_data->hctx;
>   	struct request_queue *q = iter_data->q;
>   	struct blk_mq_tag_set *set = q->tag_set;
> -	bool reserved = iter_data->reserved;
>   	struct blk_mq_tags *tags;
>   	struct request *rq;
>   	bool ret = true;
> @@ -276,7 +275,7 @@ static bool bt_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
>   	else
>   		tags = hctx->tags;
>   
> -	if (!reserved)
> +	if (!iter_data->reserved)
>   		bitnr += tags->nr_reserved_tags;
>   	/*
>   	 * We can hit rq == NULL here, because the tagging functions

Is the above change really necessary?

> @@ -337,12 +336,11 @@ static bool bt_tags_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
>   {
>   	struct bt_tags_iter_data *iter_data = data;
>   	struct blk_mq_tags *tags = iter_data->tags;
> -	bool reserved = iter_data->flags & BT_TAG_ITER_RESERVED;
>   	struct request *rq;
>   	bool ret = true;
>   	bool iter_static_rqs = !!(iter_data->flags & BT_TAG_ITER_STATIC_RQS);
>   
> -	if (!reserved)
> +	if (!(iter_data->flags & BT_TAG_ITER_RESERVED))
>   		bitnr += tags->nr_reserved_tags;
>   
>   	/*

Same question here: is the above change really necessary?

Thanks,

Bart.

