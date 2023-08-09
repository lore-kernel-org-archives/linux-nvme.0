Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5BFDEB64DD
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Aug 2023 08:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zk90bIXL+yyvPk2okzm0tDjIZH3f7c861pF0b2flLdE=; b=whTYXZS0LZiddS5/3KskGqyvKj
	TXmzDwHIGPevPnmV79zctrMDaD500h646sxSF5KbJS+WMqQnKGEKGo8/pauGLakTvX8azMdbaC8Mi
	VdYED6icffM0FrUMTJWhoMYtTfFl3rwU3KE8vgF59D42WWqjLv7FR75OWBX4UnO3I0p7aCGkvX2mK
	eb0a+ehYyGV5WPbH06VaOzqZLC81Epr8amd/ijXG/uiybEaAFsgATpyKMivpQdfaxeLXXzrblVhgh
	Yi+JCdDpSjs1n5HJI1oS2NgilNSAP1DdG+++1eUXcMYQBpMceFMLRF0eMS4BlUFqdFe2PnHSWp5Xi
	atjljbTw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qTeA4-004K4b-1Z;
	Wed, 09 Aug 2023 08:03:20 +0000
Received: from mail-wm1-f45.google.com ([209.85.128.45])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qTeA1-004K3t-2o
	for linux-nvme@lists.infradead.org;
	Wed, 09 Aug 2023 08:03:19 +0000
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-3fc03d990daso10692105e9.1
        for <linux-nvme@lists.infradead.org>; Wed, 09 Aug 2023 01:03:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691568195; x=1692172995;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zk90bIXL+yyvPk2okzm0tDjIZH3f7c861pF0b2flLdE=;
        b=C2F/sMoawDD0nJ/I5vgoZMApI7MCzjJdg0Y1dgVRqxDhgAvaWUABBu8rZAtBuCvy35
         K2k1sYHAGL+8/uIcSTj+qXvle2fnSQb1bI1e4s320/9GgZ/v38d/SUECGhR0Hu0I3k9w
         AvDAG2uOLeaFALH9njTUISFE0+28XiDAAVrmhWsg9Em/CRRaUBq4638CmcHpzzL8HGyf
         SaDt7ig2PiGhkiaFAMMr01c6FtoD4ycMpnkf6HvFxSck4SzIxary4AgL4WSUeanVgYuN
         oY8WGWXvhMI5FK6S4vMbnkvDphnjACgUPABHOqZYkVrX0+argbHRAy5JqlfZ0PMPkS4l
         EDbg==
X-Gm-Message-State: AOJu0YzgwoWKY/wiHEEHhLGvMMl/BIj6RIwDtd4ZJWWjH6HbN8M6hIXc
	znsZZsAJxitAbb32Dr75sNQZ9k0oqyg=
X-Google-Smtp-Source: AGHT+IEMQHyxAFHpU7dAZZH278FaZvbsBd2+2urgwy5GgK3U2TTQvkV99io+fNVFL/vnz5azBLs3WQ==
X-Received: by 2002:a05:600c:a54:b0:3f7:fb5d:6e7a with SMTP id c20-20020a05600c0a5400b003f7fb5d6e7amr1677124wmq.0.1691568194861;
        Wed, 09 Aug 2023 01:03:14 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id j6-20020adfff86000000b003175f00e555sm15956798wrr.97.2023.08.09.01.03.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Aug 2023 01:03:14 -0700 (PDT)
Message-ID: <1f68b7ee-b559-177b-650a-a8683fb86768@grimberg.me>
Date: Wed, 9 Aug 2023 11:03:11 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v12 11/26] nvme-tcp: Add modparam to control the ULP
 offload enablement
Content-Language: en-US
To: Aurelien Aptel <aaptel@nvidia.com>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org
Cc: aurelien.aptel@gmail.com, smalin@nvidia.com, malin1024@gmail.com,
 ogerlitz@nvidia.com, yorayz@nvidia.com, borisp@nvidia.com,
 galshalom@nvidia.com, mgurtovoy@nvidia.com
References: <20230712161513.134860-1-aaptel@nvidia.com>
 <20230712161513.134860-12-aaptel@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230712161513.134860-12-aaptel@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230809_010317_907549_17D180B2 
X-CRM114-Status: GOOD (  21.37  )
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
> Add ulp_offload module parameter to the nvme-tcp module to control
> ULP offload at the NVMe-TCP layer.
> 
> Turn ULP offload off be default, regardless of the NIC driver support.
> 
> Overall, in order to enable ULP offload:
> - nvme-tcp ulp_offload modparam must be set to 1
> - netdev->ulp_ddp_caps.active must have ULP_DDP_C_NVME_TCP and/or
>    ULP_DDP_C_NVME_TCP_DDGST_RX capabilities flag set.
> 
> Signed-off-by: Yoray Zack <yorayz@nvidia.com>
> Signed-off-by: Shai Malin <smalin@nvidia.com>
> Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
> ---
>   drivers/nvme/host/tcp.c | 12 +++++++++++-
>   1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index e68e5da3df76..e560bdf3a023 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -49,6 +49,16 @@ MODULE_PARM_DESC(tls_handshake_timeout,
>   		 "nvme TLS handshake timeout in seconds (default 10)");
>   #endif
>   
> +#ifdef CONFIG_ULP_DDP
> +/* NVMeTCP direct data placement and data digest offload will not
> + * happen if this parameter false (default), regardless of what the
> + * underlying netdev capabilities are.
> + */
> +static bool ulp_offload;
> +module_param(ulp_offload, bool, 0644);
> +MODULE_PARM_DESC(ulp_offload, "Enable or disable NVMeTCP ULP support");

the name is strange.
maybe call it ddp_offload?
and in the description spell it as "direct data placement"

> +#endif
> +
>   #ifdef CONFIG_DEBUG_LOCK_ALLOC
>   /* lockdep can detect a circular dependency of the form
>    *   sk_lock -> mmap_lock (page fault) -> fs locks -> sk_lock
> @@ -350,7 +360,7 @@ static bool nvme_tcp_ddp_query_limits(struct net_device *netdev,
>   static inline bool is_netdev_ulp_offload_active(struct net_device *netdev,
>   						struct nvme_tcp_queue *queue)
>   {
> -	if (!netdev || !queue)
> +	if (!ulp_offload || !netdev || !queue)
>   		return false;
>   
>   	/* If we cannot query the netdev limitations, do not offload */

This patch should be folded to the control path. No reason for it to
stand on its own I think.

