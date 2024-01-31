Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3513AC47DB3
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Jan 2024 21:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vMHnYEi/V9TdsWMW1HLUeOGo43E9TcsOYp0a6aWoeRA=; b=2FSJOKycC7BmypM5x1JB8QlI23
	BrDbj8n1p5VwXlfSImNBaVHcfFSPsZe48I8IQdYhh2XQJ+qc8pFP7crBcRc/u/owHz3dRY1+z+1gE
	oIFKHzlp91Bdrxt2d/tLml9bZEWxh2fseftSIzg8PZ02/Vb0GPfOS7Qgd5VVzLuNYE1APHQ7YJupd
	1a6FB9Om2Zh/Lq0OghKNFHwXpDqU9+X0HoI16WBwSwaxBTYP0v7FOJyjPoZGyR+IECDCpdkdZP8f6
	GbIBmeqcvyCyarxtE5uU50ubMm0Dp16eRDmE5og0/3tgSY/uaCDnuW5M3FFBdP8AU/AzDtUmBV4sH
	soEK5r1A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVHi9-00000005Q3M-0CsI;
	Wed, 31 Jan 2024 21:01:33 +0000
Received: from mail-wm1-f51.google.com ([209.85.128.51])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVHi6-00000005Q1x-0JOe
	for linux-nvme@lists.infradead.org;
	Wed, 31 Jan 2024 21:01:31 +0000
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40f030bf978so104265e9.0
        for <linux-nvme@lists.infradead.org>; Wed, 31 Jan 2024 13:01:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706734887; x=1707339687;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vMHnYEi/V9TdsWMW1HLUeOGo43E9TcsOYp0a6aWoeRA=;
        b=EN8npSdLqWjaHyf26toNjdyRufKYeMCQJjg0LVQEK22KeMTQ3s0ddLYo+mBnWgDL+/
         yurFO1KYtUPoTy6qHcwgfY6pC4iHTtjCWPKXJmtoAgAbYMRp8UVJRSCKfaVRvVJqZWRL
         /WoyqBukCPxVioJjq/unJOU0aktxPp5mOPsRCAMzD8lsHdu0LLGsHSF7EOi+Y7f9IfOg
         oKxPb8DqszXgXRJVc23v0nZLrJ2pEO4JV151dCIHV9+LEaA9UjYl6MqG/6Vxfa2R7dKb
         Qx/TqqXmzywrCauj1zP/sEstf9ZF11DjTdU1iPg8Y8JR4wpH166I70+Ig9RDRfnI1X8t
         0kVg==
X-Gm-Message-State: AOJu0YxVKtDe9N5aHtC8oOvLGCpDXxfWKIFs1nywYj/hmbC7rceGdVRP
	F4lLMwzCe2Vmjb8K1ebMMSBF15J28gWtYt74UNf7/7XbyXsCpiKw
X-Google-Smtp-Source: AGHT+IEUVn9skOXNOwH+7VS6kCRhJPr0OR53YvFn+2ndRNpSD9jBGGF0M5I+cctTZMyrRRDtRKcxLg==
X-Received: by 2002:a5d:54c8:0:b0:33b:d03:aeb2 with SMTP id x8-20020a5d54c8000000b0033b0d03aeb2mr398000wrv.7.1706734887524;
        Wed, 31 Jan 2024 13:01:27 -0800 (PST)
Received: from [10.100.102.14] (46-117-114-124.bb.netvision.net.il. [46.117.114.124])
        by smtp.gmail.com with ESMTPSA id ch19-20020a5d5d13000000b00337b47ae539sm14424026wrb.42.2024.01.31.13.01.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jan 2024 13:01:27 -0800 (PST)
Message-ID: <6f3b2ccb-5e11-4989-8cc7-2713d6c3a938@grimberg.me>
Date: Wed, 31 Jan 2024 23:01:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-common: add module description
Content-Language: en-US
To: Chaitanya Kulkarni <kch@nvidia.com>, hare@suse.de
Cc: kbusch@kernel.org, hch@lst.de, linux-nvme@lists.infradead.org
References: <20240131054325.47405-1-kch@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240131054325.47405-1-kch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240131_130130_146480_B8C7EB51 
X-CRM114-Status: GOOD (  12.91  )
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


> Add MODULE_DESCRIPTION() in order to remove warnings & get clean build:-
> 
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/nvme/common/nvme-auth.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/nvme/common/nvme-keyring.o
> 
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
>   drivers/nvme/common/auth.c    | 1 +
>   drivers/nvme/common/keyring.c | 1 +
>   2 files changed, 2 insertions(+)
> 
> diff --git a/drivers/nvme/common/auth.c b/drivers/nvme/common/auth.c
> index a23ab5c968b9..b707e6b7d263 100644
> --- a/drivers/nvme/common/auth.c
> +++ b/drivers/nvme/common/auth.c
> @@ -471,4 +471,5 @@ int nvme_auth_generate_key(u8 *secret, struct nvme_dhchap_key **ret_key)
>   }
>   EXPORT_SYMBOL_GPL(nvme_auth_generate_key);
>   
> +MODULE_DESCRIPTION("NVMe Authentication framework");
>   MODULE_LICENSE("GPL v2");
> diff --git a/drivers/nvme/common/keyring.c b/drivers/nvme/common/keyring.c
> index a5c0431c101c..394c3948e339 100644
> --- a/drivers/nvme/common/keyring.c
> +++ b/drivers/nvme/common/keyring.c
> @@ -181,5 +181,6 @@ static void __exit nvme_keyring_exit(void)
>   
>   MODULE_LICENSE("GPL v2");
>   MODULE_AUTHOR("Hannes Reinecke <hare@suse.de>");
> +MODULE_DESCRIPTION("NVMe TLS Keyring implementation");

iirc, I think Hannes had an intention to make the inband auth
implementation to use nvme keyring as well. So I'd omit TLS from
the description.

Other than that,
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

