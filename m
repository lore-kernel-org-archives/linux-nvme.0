Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E417C6FD1D
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Mar 2023 08:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YFqzYULjVnNFBQ0YYGQWh7ZVHxMmC/xJJXYoXvdK9CE=; b=UB37meRIuRSt2t69EuD0bJr+/b
	a7qH6ExqJ66o0kW6pVSzoQBsvpuXErRtxCkv/cwfloGUFvbEPeVF75VoHpJx4fFlQ50wQKaoSigvB
	Jp3vA9AbHSj91H7yfbST2/et9w77X2JdHFbeknd2jgve2mAgQIBdmKMmnhEzLE6XxsG+GgqC9aB49
	uJI8oFkojetU9Wfv9NyundEST6RD08LAtDYE6s6kcW0gDV9qBxr2MX8spoUKqr8XwrXLrwyyUdsLg
	NaJIPDF9lUs/Kqj0bhLhEAQENeh/7MUadv7UQZIDW0+GKObYF9d3/cmOK0HQWhxvU71kskrl0EgVv
	l/qhDMqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pfFwN-001Cw6-1A;
	Thu, 23 Mar 2023 08:04:55 +0000
Received: from mail-wr1-f45.google.com ([209.85.221.45])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pfFwI-001Ctp-1J
	for linux-nvme@lists.infradead.org;
	Thu, 23 Mar 2023 08:04:54 +0000
Received: by mail-wr1-f45.google.com with SMTP id e18so7929520wra.9
        for <linux-nvme@lists.infradead.org>; Thu, 23 Mar 2023 01:04:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679558686; x=1682150686;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YFqzYULjVnNFBQ0YYGQWh7ZVHxMmC/xJJXYoXvdK9CE=;
        b=VLA7/npCIN4nqSRtzV3gH6AWuDRE+ZUnHqo+NUpAs8N/nTOC/77NIk0cpcoP3SsB2/
         XlkZWAEXekO6k1fGT1eObxYwdWBff2ogBF5SnUiJwygzhLbYYbPDTnwX3EWYy9cd0UcU
         bg7/bDHyirsNKoPRusb/XYKm74sJJSjMKHOPkmW9lKJC3icmtrtiQ3rVPHywKRuxIHNS
         wtBe2Hi80W9F8hufpTvngPD5melAstFHphMzHOuNWkgxXMDD8vmdd15JKiiIdiScnwW4
         9Be8juTVWzhGl578MyLhSGrbc8E0ae0IBDsk/WTHTdEMtO1HImF7Cphh1Xayj7CAYEdi
         eV1w==
X-Gm-Message-State: AO0yUKUR9kXQxLZY+7T67rGWLOQ0k0gXpSpBOcBZE7b6Q+FXqFNP2U8b
	Jo5aXBbuvSSk7JhXbnTKWKk=
X-Google-Smtp-Source: AK7set8yDftBDRHIyRIwwW38g2CCF5CwQOjzuNRqCVwrr/zWGAwcQFW1FkQmRFPO/UoYzHwe7Rw6cQ==
X-Received: by 2002:a5d:6d42:0:b0:2c7:1c72:69ac with SMTP id k2-20020a5d6d42000000b002c71c7269acmr5241352wri.2.1679558686147;
        Thu, 23 Mar 2023 01:04:46 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id d10-20020adfe88a000000b002c70e60abd4sm15654128wrm.2.2023.03.23.01.04.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Mar 2023 01:04:45 -0700 (PDT)
Message-ID: <100e5652-d8cc-fa5c-1b8e-b23e26987af8@grimberg.me>
Date: Thu, 23 Mar 2023 10:04:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 5/9] nvme-core: use normal pattern
Content-Language: en-US
To: Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de, hare@suse.de
References: <20230323033636.812758-1-kch@nvidia.com>
 <20230323033636.812758-6-kch@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230323033636.812758-6-kch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230323_010450_443610_3C815747 
X-CRM114-Status: GOOD (  15.70  )
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


> Although return is allowed in the switch ... case when function is
> returing void, it creates confusion for future code which is desirable
> pattern to use for switch ... case. Repalce return in the switch with
> break that is standard pattern for the switch ... case.

Don't see the confusion, but ok,

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>


> 
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
>   drivers/nvme/host/core.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index a380938f5a06..3eb2299a81fc 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -403,13 +403,13 @@ void nvme_complete_rq(struct request *req)
>   	switch (nvme_decide_disposition(req)) {
>   	case COMPLETE:
>   		nvme_end_req(req);
> -		return;
> +		break;
>   	case RETRY:
>   		nvme_retry_req(req);
> -		return;
> +		break;
>   	case FAILOVER:
>   		nvme_failover_req(req);
> -		return;
> +		break;
>   	case AUTHENTICATE:
>   #ifdef CONFIG_NVME_AUTH
>   		queue_work(nvme_wq, &ctrl->dhchap_auth_work);
> @@ -417,7 +417,7 @@ void nvme_complete_rq(struct request *req)
>   #else
>   		nvme_end_req(req);
>   #endif
> -		return;
> +		break;
>   	}
>   }
>   EXPORT_SYMBOL_GPL(nvme_complete_rq);

