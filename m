Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14D6EC433FE
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Oct 2022 10:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vETVOxbVj5KMETJrBODFj1FK7i7Pqa11nIJtNzfOqzg=; b=EeZn4P97OGuwLnGmiy+EzRNywv
	75GjzhcrQCFO+9FC/ViG/mZr8NZT4A0tbOS3KDJsr+qdH2F/mpZBoy7801V2V+8LMzf7jnt3/BW0p
	ATMgV9et6iDTgTAFdHVGC1wIQxFVJTO/en64z7rQ7RnTYQRKWO5QHuhNLDsW8GzHt2hP4eYRMnxpO
	ewMPTrBo5NWPX36dKX37Wp4kdKrh9FsudUvKa+qbvOzzrY73divhvHdbA7LAm/wAdA1qNSw5yFIt7
	3EDmFS1muv+2m0aKPb97/FLIndV/VxPiTbuXVhZnEEieTSRr1wB55zppNV8Z/kBupny62S+H+fRmX
	KEzaapsQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ofIIY-005DdH-I2; Mon, 03 Oct 2022 10:03:42 +0000
Received: from mail-wr1-f51.google.com ([209.85.221.51])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ofIIW-005DcT-3Z
	for linux-nvme@lists.infradead.org; Mon, 03 Oct 2022 10:03:41 +0000
Received: by mail-wr1-f51.google.com with SMTP id a3so3661347wrt.0
        for <linux-nvme@lists.infradead.org>; Mon, 03 Oct 2022 03:03:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=vETVOxbVj5KMETJrBODFj1FK7i7Pqa11nIJtNzfOqzg=;
        b=UNHtRfkyjviN8lxpT09j63fIO8IA7UBxhx53rWzYaO+hzeEgIBwinX9iEOdL78T4zi
         mw+VbA2APt3GCAaf1lC3Feico1dxxc4dp1yGxIcKulgk1zXpHOCRFv6EAExVpEz0UbIT
         8pIVoMl1QtmiISf7hpopGOZADbu2K3DR3SHEvJjaIT7Zyou1L4tQ88FMfvM7seev21UX
         ElIU+55LXT23GTw5qyXiK1+pvausA/E3V1TEFiXYhqqfzOHokw3z+QOx/OJLlE6//0Iz
         6cX/QLt4B2ABg854rXpNCXm1sVJYAEJHNRG66IthxCm1Uyv0cE4mxaTdsxlCSrCBUbYB
         fcbw==
X-Gm-Message-State: ACrzQf1JGRXu80HyJXnt+potLpN7zS4Xo/GvNVAyX9LH0ORxZNe9EEyq
	HHCfVpJyEo9Hqb+ShD5goD0=
X-Google-Smtp-Source: AMsMyM5eZILQIUOYFtClQfwBAG4J2FWi0gFye4Ur0Ekk3KjVGTcLrMcJxjPsQxOA77bcw26ps8IfBw==
X-Received: by 2002:adf:b64b:0:b0:22e:32e6:6ea7 with SMTP id i11-20020adfb64b000000b0022e32e66ea7mr4817222wre.686.1664791418723;
        Mon, 03 Oct 2022 03:03:38 -0700 (PDT)
Received: from [192.168.64.53] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id bg29-20020a05600c3c9d00b003b47a99d928sm12441631wmb.18.2022.10.03.03.03.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Oct 2022 03:03:38 -0700 (PDT)
Message-ID: <cfd01d2e-1f87-2295-13bb-c8705b3335f9@grimberg.me>
Date: Mon, 3 Oct 2022 13:03:36 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/1] nvme: use macro definitions for setting
 reservation values
Content-Language: en-US
To: Max Gurtovoy <mgurtovoy@nvidia.com>, linux-nvme@lists.infradead.org,
 hch@lst.de, kbusch@kernel.org
Cc: oren@nvidia.com, chaitanyak@nvidia.com, linux-block@vger.kernel.org
References: <20221002082851.13222-1-mgurtovoy@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221002082851.13222-1-mgurtovoy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221003_030340_173887_F243B4FB 
X-CRM114-Status: GOOD (  16.14  )
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
> 
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> ---
> Changes from v1:
>   - remove comments (Sagi/Keith)
>   - use tabs for constants alignment, similar to 'enum pr_type' (Keith)
> ---
>   drivers/nvme/host/core.c | 12 ++++++------
>   include/linux/nvme.h     |  9 +++++++++
>   2 files changed, 15 insertions(+), 6 deletions(-)
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
> index ae53d74f3696..4f777d8621a7 100644
> --- a/include/linux/nvme.h
> +++ b/include/linux/nvme.h
> @@ -238,6 +238,15 @@ enum {
>   	NVME_CAP_CRMS_CRIMS	= 1ULL << 60,
>   };
>   
> +enum {

I'd make this named nvme_pr_type

