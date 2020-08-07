Return-Path: <SRS0=rw3x=BR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B6D5C433E0
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Aug 2020 16:31:24 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34F1820748
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Aug 2020 16:31:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uW4XRUna"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34F1820748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=QwNQPQ9dfqpXsTGdbXYWN2j8I/oFV6x0KJt7W7lsscc=; b=uW4XRUna7G43c7Gb76cQsNv+2
	AJ1gQ6KvOwZRTjqUIv8IafcljWXoB8qmWrZcy2Fw0RSu1ZmlxoUtCq9tuyoWhoJbOY9XwAUso+kYu
	S6zvHYQpmQeV9hI3OevfhAOJWYQpMOYIjxZxMenVeaLRgkqNVO3tmYNBMQcW+uXXH473hM9a2Bq45
	fhBUkGnay0LH9uyiygpbFCeiKHJRub0KGQoqESvL8ix6E2XCTCPPxhMe49S7zLYDtI2wADVFtXbiD
	aR3tDpwmITE1lwAy1XxoF5cwFOySMZJE/XCQkJVSpfdRylT7ZSWmKM76/FUzA94AhLC5soUitKT3s
	K4pie/mDQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k45H7-0004ip-Ib; Fri, 07 Aug 2020 16:31:21 +0000
Received: from mail-pl1-f194.google.com ([209.85.214.194])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k45Gy-0004g9-NZ
 for linux-nvme@lists.infradead.org; Fri, 07 Aug 2020 16:31:19 +0000
Received: by mail-pl1-f194.google.com with SMTP id u10so1281806plr.7
 for <linux-nvme@lists.infradead.org>; Fri, 07 Aug 2020 09:31:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=aDl027rtAUy/rtWoV9iEXw/VLQyKVpK/I7yoleUZD5o=;
 b=Pv2oz1jrushjynhpmgnSKS0AWAlPwlMIm++HaHLXG2GX9ULxyKmz+DZqm9XOA9Iy9z
 t/dEGBy65FQa7uFrPsUxiP/A3si+Impq+VwXAcjKLF7ACyVJLjoYKUgSEl6bF/Vu5N0p
 kNZ1wX8wrMoz9GvHDa7w0kQpwzKxKRiAhG4p7vY1BU9klL/Z80jv9lISyhgcHajRDKrr
 +FogQVSZeaKgn2ivopRcG8E670N9hhF4/QBki1m8+sbp5bcjvu0PFnLR2+UHLw7JYCqm
 xTvFW2SVFj4eEf6W+sEOnIrbrvZQ2WGNylZbMibFhuLt+ClGY8iD4rFOQcIzm9AJWjrd
 /7+A==
X-Gm-Message-State: AOAM531eZ7oTAVJzBebq17T7+/ypHkEEtx97Bhp3XMpL9X0wzn5HSPiJ
 VL2b7mO5grPvKdSO9LH6KwS3l3HyH/o=
X-Google-Smtp-Source: ABdhPJxUYH1DXh8D+61eQu0tXfwBDA7jyvjkJGRZFc95eay3LGQQVD7TmdY0P6pRsY11rrPcsLLlhQ==
X-Received: by 2002:a17:90a:eb06:: with SMTP id
 j6mr14580690pjz.227.1596817871320; 
 Fri, 07 Aug 2020 09:31:11 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:d88d:857c:b14c:519a?
 ([2601:647:4802:9070:d88d:857c:b14c:519a])
 by smtp.gmail.com with ESMTPSA id m16sm10999428pjz.47.2020.08.07.09.31.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Aug 2020 09:31:10 -0700 (PDT)
Subject: Re: [PATCH] nvme: skip noiob for zoned devices
To: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org, hch@lst.de
References: <20200807162907.4155487-1-kbusch@kernel.org>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <961b6a7b-2afc-17bd-f20c-7c9e520bae51@grimberg.me>
Date: Fri, 7 Aug 2020 09:31:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200807162907.4155487-1-kbusch@kernel.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200807_123112_831173_C5C2B2BE 
X-CRM114-Status: GOOD (  18.34  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> Zoned block devices reuse the chunk_sectors queue limit to define zone
> boundaries. If a such a device happens to also report an optimal
> boundary, do not use that to define the chunk_sectors as that may
> intermittently interfere with io splitting and zone size queries.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>   drivers/nvme/host/core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 88cff309d8e4..4e0225d85e70 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2075,7 +2075,7 @@ static int __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
>   		}
>   	}
>   
> -	if (iob)
> +	if (iob && blk_queue_is_zoned(ns->queue))
>   		blk_queue_chunk_sectors(ns->queue, rounddown_pow_of_two(iob));
>   	nvme_update_disk_info(disk, ns, id);
>   #ifdef CONFIG_NVME_MULTIPATH

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
