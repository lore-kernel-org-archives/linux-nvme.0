Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AC24EB64DD
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Aug 2023 08:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ycqtuhCoWtsQsxaEDdpgpm5AvhPbSKD4HgJtkoMA3MY=; b=1aCmcqXLLeUxV/uQic0WHE8+z3
	SgeZM1nNK4lNHdzIMgGCaLcBHubq+h0s+wtQHtFb/24OCevWvX8tCNdPSaOCsNtkoRiDERmX52DHS
	RC1Mk47MSDQXVr8E5GAXNKiz8STO1Vdkc0mWcgxXDGxry9v7q8TdZp9uBho3MZzEMbN8cF1llHz9f
	yU1rG8dOuRZ1bY1klEFeMxtqUEnmlsXeuTSvV1ZscaU24DzzdZwh3GDxQ+iiCE2YulQD0QZGQcnwJ
	aDSRiCYGHyKxGMHH2ViL6har7ZkQZ1vNqy8VFVwE3JMPF89AKIPFHi8zzu6YiaxA+fxdMumXIn82s
	wb5245fg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qTeBq-004KFJ-0Y;
	Wed, 09 Aug 2023 08:05:10 +0000
Received: from mail-wm1-f44.google.com ([209.85.128.44])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qTeBn-004KES-1r
	for linux-nvme@lists.infradead.org;
	Wed, 09 Aug 2023 08:05:08 +0000
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-3fe247796ccso11752065e9.1
        for <linux-nvme@lists.infradead.org>; Wed, 09 Aug 2023 01:05:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691568305; x=1692173105;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ycqtuhCoWtsQsxaEDdpgpm5AvhPbSKD4HgJtkoMA3MY=;
        b=i5J5+4dpH5owouhF7f5Jl9kNqXL6wCvYCCBfMNDF3uaVtQkcF4FHuhtSzSsWUnA9tc
         WPPYYXP8hukgHZMVNWFU8rMy0NuGM9oF5POne5EoIxxXLtuF+ycNb2uZoKVKVY+rCplv
         NlQpD8xo77GoEyMXCnYqW/L+GSGZatcjJql3qPrnRzwXvVyPjgvsC5z9ooy9tlZHbnLQ
         brl8T5b8N9cwUZFX2M3hNCMFuze4vs+u3uxrFru7bAiaI780vPzAFJf1VDo+MOt9z/EH
         7rE/dcSzATXlISA9RYYPoxVj3R2fomp7MHVJ9bfELpe3WzNVQO7UGjBhJoRZjCa2WlIC
         4i2w==
X-Gm-Message-State: AOJu0YzNP2FnAG5uh/EXcUOmum8P9RIm0cYuNqfL3WbuauPJMaTZAIKf
	DynuimlAwSACTtpommHEhNE=
X-Google-Smtp-Source: AGHT+IHT5ZNEbGQFuD+ogPdomSkAEWAzqst+fNdyZwk2H712/UFR2hXNhncja+zh5uLznQ7B51VPkg==
X-Received: by 2002:a5d:50c4:0:b0:317:5559:a4e with SMTP id f4-20020a5d50c4000000b0031755590a4emr1181858wrt.6.1691568304911;
        Wed, 09 Aug 2023 01:05:04 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id n12-20020adff08c000000b00317b5c8a4f1sm15831390wro.60.2023.08.09.01.05.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Aug 2023 01:05:04 -0700 (PDT)
Message-ID: <02837791-9e54-5b17-28a5-0df35bb93806@grimberg.me>
Date: Wed, 9 Aug 2023 11:05:01 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v12 12/26] nvme-tcp: Only enable offload with TLS if the
 driver supports it
Content-Language: en-US
To: Aurelien Aptel <aaptel@nvidia.com>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org
Cc: aurelien.aptel@gmail.com, smalin@nvidia.com, malin1024@gmail.com,
 ogerlitz@nvidia.com, yorayz@nvidia.com, borisp@nvidia.com,
 galshalom@nvidia.com, mgurtovoy@nvidia.com
References: <20230712161513.134860-1-aaptel@nvidia.com>
 <20230712161513.134860-13-aaptel@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230712161513.134860-13-aaptel@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230809_010507_611796_C41ED7B5 
X-CRM114-Status: GOOD (  15.64  )
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



On 7/12/23 19:14, Aurelien Aptel wrote:
> Check if ULP offload driver supports ULP-over-TLS before enabling the
> offload with tls.
> 
> Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
> Signed-off-by: Shai Malin <smalin@nvidia.com>
> Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> ---
>   drivers/nvme/host/tcp.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index e560bdf3a023..afb3dedcbc0c 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -367,6 +367,10 @@ static inline bool is_netdev_ulp_offload_active(struct net_device *netdev,
>   	if (!nvme_tcp_ddp_query_limits(netdev, queue))
>   		return false;
>   
> +	/* If we are using TLS and netdev doesn't support it, do not offload */
> +	if (queue->ctrl->ctrl.opts->tls && !queue->ddp_limits.tls)
> +		return false;

Same for this, fold to the first patch.

Other than that I had a question on one of my other responses.
I don't think that tls_device supports 1.3, so what does tls
here mean? That any device that enables this supports _all_
tls versions?

