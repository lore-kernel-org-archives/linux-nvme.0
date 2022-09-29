Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BF77C433FE
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Sep 2022 18:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Mza/eccPB742Mh5SYeGtuuzV3UVrHBhYB7Z24YUwANs=; b=poNmUVuAvxuCcsvUAst1sqP+a2
	y/llbW8y3JQPDCwMkoxFNS2bCaevX1WOd1U6CeWlQm+4EsYWep8wJAO971epmvonxCemRroyZBl/I
	8tt+sBfibJjoqwNWOqm/TmvRH8SACCXChcw9195seEMYMM5zWF1I8gslIOfyI+v1AFRfecU4og5IO
	bXWeX+nTjoWKXZZ+JetwT2emFIiCgS12/4msyR9iDXY7RxJVGX0inTYRGkr3hxopb0Fdq6HSEvR3Y
	6NVCYVdKRnVqWkGDT46gfBO4cOCaEZ6O2VBVIQe5DFqe3fE0dleQQcn1PdNo73fj3JDsseyW6Nlsb
	cTCSz9cg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odyZp-0051bR-On; Thu, 29 Sep 2022 18:48:05 +0000
Received: from mail-ej1-f47.google.com ([209.85.218.47])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odyZl-0051YS-PI
	for linux-nvme@lists.infradead.org; Thu, 29 Sep 2022 18:48:03 +0000
Received: by mail-ej1-f47.google.com with SMTP id r18so4612455eja.11
        for <linux-nvme@lists.infradead.org>; Thu, 29 Sep 2022 11:48:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Mza/eccPB742Mh5SYeGtuuzV3UVrHBhYB7Z24YUwANs=;
        b=59NgUVknj/KqBR2v/rLi1uUdIM98lPFKSg76QayhpORw35lwNQ+peDbLXx/1scq7iF
         VJYaMnJK6U0h6HgofVuaXNrxjCT1vLd/2qtA8wAcAWUsWbzoAdU6kVTrVQQA+FaxDsHi
         WjIJXuJ4gF8950RM44f23r0YPwM+n1VnrW8kfqMorSSm7bglb6PfibQm9bt22EwEvblN
         W7Y0WZrZgEHHMRrq/Ld1Rw3zlUWEZN11IFpuUeEczXwqhyIArbW8tVb03NOlkZoQOMEY
         KHXvm23Y4fDpqE6oHR5i/y15XBgdMYG8/WoMxCQfq4+YFl/VSl3t1ufu90nT4H+Z71AG
         s4nA==
X-Gm-Message-State: ACrzQf0aUki/hK2y55V3G7JuORP/G1t0zE2ONAmgnbYDjQ8DeKqsVKPn
	gPi8mq49AOJ3irMLgvfdk6o=
X-Google-Smtp-Source: AMsMyM42WIDv6+dK6BBYfV0u0LNEy8A3cOeXw31bjX3QrF2GZP557N3knNHy99c6DT7D3eP06zsm+Q==
X-Received: by 2002:a17:907:762b:b0:771:5755:82b7 with SMTP id jy11-20020a170907762b00b00771575582b7mr3618734ejc.684.1664477278947;
        Thu, 29 Sep 2022 11:47:58 -0700 (PDT)
Received: from [10.100.102.14] (46-116-236-159.bb.netvision.net.il. [46.116.236.159])
        by smtp.gmail.com with ESMTPSA id r20-20020aa7c154000000b004582a37889csm203820edp.16.2022.09.29.11.47.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Sep 2022 11:47:57 -0700 (PDT)
Message-ID: <a3b08c1b-b8d1-f3c8-71e5-59167eb3e58b@grimberg.me>
Date: Thu, 29 Sep 2022 21:47:54 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/1] nvme: use macro definitions for setting reservation
 values
Content-Language: en-US
To: Max Gurtovoy <mgurtovoy@nvidia.com>, linux-nvme@lists.infradead.org,
 hch@lst.de, kbusch@kernel.org
Cc: oren@nvidia.com, chaitanyak@nvidia.com, linux-block@vger.kernel.org
References: <20220929115919.9906-1-mgurtovoy@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220929115919.9906-1-mgurtovoy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220929_114801_857335_3399E70D 
X-CRM114-Status: GOOD (  17.88  )
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


> This makes the code more readable.

I find it readable as it is. But I don't particularly
care about it all that much.

> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> ---
>   drivers/nvme/host/core.c | 12 ++++++------
>   include/linux/nvme.h     | 12 ++++++++++++
>   2 files changed, 18 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 3f1a7dc2a2a3..50668e1bd9f1 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2068,17 +2068,17 @@ static char nvme_pr_type(enum pr_type type)
>   {
>   	switch (type) {
>   	case PR_WRITE_EXCLUSIVE:
> -		return 1;
> +		return NVME_PR_WRITE_EXCLUSIVE;
>   	case PR_EXCLUSIVE_ACCESS:
> -		return 2;
> +		return NVME_PR_EXCLUSIVE_ACCESS;
>   	case PR_WRITE_EXCLUSIVE_REG_ONLY:
> -		return 3;
> +		return NVME_PR_WRITE_EXCLUSIVE_REG_ONLY;
>   	case PR_EXCLUSIVE_ACCESS_REG_ONLY:
> -		return 4;
> +		return NVME_PR_EXCLUSIVE_ACCESS_REG_ONLY;
>   	case PR_WRITE_EXCLUSIVE_ALL_REGS:
> -		return 5;
> +		return NVME_PR_WRITE_EXCLUSIVE_ALL_REGS;
>   	case PR_EXCLUSIVE_ACCESS_ALL_REGS:
> -		return 6;
> +		return NVME_PR_EXCLUSIVE_ACCESS_ALL_REGS;
>   	default:
>   		return 0;
>   	}
> diff --git a/include/linux/nvme.h b/include/linux/nvme.h
> index ae53d74f3696..a925be0056f2 100644
> --- a/include/linux/nvme.h
> +++ b/include/linux/nvme.h
> @@ -238,6 +238,18 @@ enum {
>   	NVME_CAP_CRMS_CRIMS	= 1ULL << 60,
>   };
>   
> +/*
> + * Reservation Type Encoding
> + */
> +enum {
> +	NVME_PR_WRITE_EXCLUSIVE = 1, /* Write Exclusive Reservation */
> +	NVME_PR_EXCLUSIVE_ACCESS = 2, /* Exclusive Access Reservation */
> +	NVME_PR_WRITE_EXCLUSIVE_REG_ONLY = 3, /* Write Exclusive - Registrants Only Reservation */
> +	NVME_PR_EXCLUSIVE_ACCESS_REG_ONLY = 4, /* Exclusive Access - Registrants Only Reservation */
> +	NVME_PR_WRITE_EXCLUSIVE_ALL_REGS = 5, /* Write Exclusive - All Registrants Reservation */
> +	NVME_PR_EXCLUSIVE_ACCESS_ALL_REGS = 6, /* Exclusive Access - All Registrants Reservation */

The comments are unneeded, the enums themselves are
self-explanatory (and also mirror the pr_type enums themselves).

