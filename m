Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD13FC6FD1C
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Mar 2023 07:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=f36CQ2LGxSpynrKi3vbHO2cLh81qIlI83RA3W7nzUak=; b=zWOYXCkvRr3puI9jGfzIpPdnFa
	NlUz2KXsvdej/jpysdt4G7RH4NG/OagE/686+7LxAYIWHPiN3GHhltyXve4kffvEYA5+5a16t2XMo
	yB0Cw9+FWnlaum4ryG4VyrLt73DItcADQcH5aMQDiEwTpNDMPgYvtaWaR8oBf43MFHCP+GIZF3jyg
	/z1TqXOjbRbU9iu7ux9kC2UGJtIiej8ebMa7GCihfSUfy8f06vuLwAvWW6p1fcqDcZMqrLsA+PYoS
	AfrVpyGAVtFYbNqSjXPviiGOZmmVajM605ibCRgMejgCGJj0qTx0LIMw/hXtYm0/cP5iSam2OiFtU
	zU4LBG7Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pfFo4-001BMj-1C;
	Thu, 23 Mar 2023 07:56:20 +0000
Received: from mail-wm1-f52.google.com ([209.85.128.52])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pfFo1-001BLV-0f
	for linux-nvme@lists.infradead.org;
	Thu, 23 Mar 2023 07:56:18 +0000
Received: by mail-wm1-f52.google.com with SMTP id t17-20020a05600c451100b003edc906aeeaso1445430wmo.1
        for <linux-nvme@lists.infradead.org>; Thu, 23 Mar 2023 00:56:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679558175; x=1682150175;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f36CQ2LGxSpynrKi3vbHO2cLh81qIlI83RA3W7nzUak=;
        b=myh9zkyJ7phm78M4ihidgCTcSAJIKZKtJIMOklKhTRZiI+zh9CYlIDJRZynhEfbsDc
         qxCvLgQ4YpsAMRKZeRDW0ao/kwA/dp+pFaRoH+BzeUOz5j/uALVphd69xN9YLGD8jaZK
         yX638AccPYawoHcSXzJJSmogsMSWxM4hFKCuIZcWKihQ4j9c347pWlAoH07WeLyNFbJb
         OJaEiDb9HuW7if30rupJCPIxNL9fojL55gNtNS/nGloZW81c9KLQfICRxWNLNlb4za9S
         NEP5ZxJAEiKt7RFLp8A48gYdZEGAOTI1uX5dIuNvb7tB7OfL0BnRLRPjQnfvzDNJ2EjS
         0fFw==
X-Gm-Message-State: AO0yUKX9Ec3ByXamiWfDxro/7jh7lAHdQF9wQXjVmLQFRcUFF0l86BV7
	YtahvWUOrZldsY8HlPZo33A=
X-Google-Smtp-Source: AK7set8ueGhlC1JCXU0HmBwifd8WhTOIWRyBz9nufSt5MhgRb+aDMsQues1FNMXrL99INW+nKY1EoQ==
X-Received: by 2002:a05:600c:3b90:b0:3ee:52fb:6dd9 with SMTP id n16-20020a05600c3b9000b003ee52fb6dd9mr5043974wms.4.1679558175238;
        Thu, 23 Mar 2023 00:56:15 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id o14-20020a05600c378e00b003ed2276cd0dsm1068298wmr.38.2023.03.23.00.56.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Mar 2023 00:56:14 -0700 (PDT)
Message-ID: <5639f28e-ec89-f2f8-5737-8209b36088e9@grimberg.me>
Date: Thu, 23 Mar 2023 09:56:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/9] nvme-core: use uint type for shutdown timeout
Content-Language: en-US
To: Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de, hare@suse.de
References: <20230323033636.812758-1-kch@nvidia.com>
 <20230323033636.812758-2-kch@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230323033636.812758-2-kch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230323_005617_245628_42C5AF77 
X-CRM114-Status: GOOD (  17.16  )
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

> Use consistent type unsigned int for shutdown_timeout that matches
> other timeout types.

Does it make sense to allow shutdown timeout to be that long?

  Also, use this oppurtunity to print default
> timeout values in the module parameter description that saves a trip
> to source code.

Or simply reading from sys modparams, which one may do anyway.

> 
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
>   drivers/nvme/host/core.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index d4be525f8100..c9636be68d74 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -43,17 +43,17 @@ struct nvme_ns_info {
>   
>   unsigned int admin_timeout = 60;
>   module_param(admin_timeout, uint, 0644);
> -MODULE_PARM_DESC(admin_timeout, "timeout in seconds for admin commands");
> +MODULE_PARM_DESC(admin_timeout, "timeout in seconds for admin commands, default:60");
>   EXPORT_SYMBOL_GPL(admin_timeout);
>   
>   unsigned int nvme_io_timeout = 30;
>   module_param_named(io_timeout, nvme_io_timeout, uint, 0644);
> -MODULE_PARM_DESC(io_timeout, "timeout in seconds for I/O");
> +MODULE_PARM_DESC(io_timeout, "timeout in seconds for I/O, default:30");
>   EXPORT_SYMBOL_GPL(nvme_io_timeout);
>   
> -static unsigned char shutdown_timeout = 5;
> -module_param(shutdown_timeout, byte, 0644);
> -MODULE_PARM_DESC(shutdown_timeout, "timeout in seconds for controller shutdown");
> +static unsigned int shutdown_timeout = 5;
> +module_param(shutdown_timeout, uint, 0644);
> +MODULE_PARM_DESC(shutdown_timeout, "timeout in seconds for controller shutdown default:5");
>   
>   static u8 nvme_max_retries = 5;
>   module_param_named(max_retries, nvme_max_retries, byte, 0644);

