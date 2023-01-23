Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1107C05027
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Jan 2023 12:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hm+z0IAUZfYaC3MSTnrGM3Mjqo8j/dk28D4dsEzKvK0=; b=ptBDnHV2vEMUbpmGu1kpFamZLP
	PSMRbBtzRjOF3NG1qHZK8EUnVZpaXcKsglmeZwSqHQCH9gFm8/806ansiw1UVb7TCa3KOQOkUdcPg
	3cgegL0a7nEWAcwJfdZAs1yjCn/bgQVfWhjRkCJUxpEnORmogv3Kf2U6SQln78f7NgozEhDUxMh90
	X9/9C6dztYhM7aNLssuVXp2bjP39X2ahJXIKqCDvN5THZivH7+9s/Ac1Btshfcj3iSmXC8oNxes7l
	49dp4Ux1Faq+UsMpCTvCIzuzZh7kGlTRhIF3N8y3ecHAMJNNJo1Z1VJwqP/PKbFx02HL4mb4vMoZD
	KLKahbZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pJw3j-00H8i1-80; Mon, 23 Jan 2023 12:36:23 +0000
Received: from mail-wr1-f44.google.com ([209.85.221.44])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pJw0X-00H7ZT-BO
	for linux-nvme@lists.infradead.org; Mon, 23 Jan 2023 12:33:13 +0000
Received: by mail-wr1-f44.google.com with SMTP id b7so10661108wrt.3
        for <linux-nvme@lists.infradead.org>; Mon, 23 Jan 2023 04:33:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hm+z0IAUZfYaC3MSTnrGM3Mjqo8j/dk28D4dsEzKvK0=;
        b=eVGT+fPKoRq1slRdAf8jEoyg9DIwbsMXEReln+D713GpYsrdfMLMlWqqzoN/BkuefS
         6UGZuqs3n4kApUwqiBf6ET0NwBvEuQu8b0L20nlZYhifsRjR02O+oIk3l5/cNgbgzN0c
         9U2S0bgjcs7Zmwuyvp0HfpzQmtQyDGVFrVZF2HJMM3JR+wsTO8E3etE+R2tg86ndUrwn
         wclA7dJIExk//b6UEzYiYiQSflQb0o/Bc+NGImAH4dW0lgeNXjZWh8H9aULtykGYgwGw
         P6JZrqr+BTFflYIhgR6acVubdvf1G6c+fEVHvIp42o+A2wE9GgoTjCHm0ZBKIhHy0JIt
         M7Yw==
X-Gm-Message-State: AFqh2koPdF38m2zvtHbGpueFoVfg/swNr3TTY9TKA8phJRepJ3AspeqC
	DwG8k3kWMTUiSK5X0zTuVEM=
X-Google-Smtp-Source: AMrXdXv8f2ntIdP2SE98+SePzHp8TCq9rDf3SXGQ+d3fMgR/wxelZweQu7dKwKXcT2XHfTxDXLf7Wg==
X-Received: by 2002:adf:e443:0:b0:2be:54af:e958 with SMTP id t3-20020adfe443000000b002be54afe958mr10347974wrm.30.1674477183406;
        Mon, 23 Jan 2023 04:33:03 -0800 (PST)
Received: from [192.168.64.80] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id j14-20020adfb30e000000b002bbedd60a9asm368569wrd.77.2023.01.23.04.33.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 04:33:02 -0800 (PST)
Message-ID: <e89cc27a-4b8f-6503-fec9-670de2bb885e@grimberg.me>
Date: Mon, 23 Jan 2023 14:33:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/3] nvme-fabrics: introduce existing_ctrl operation
Content-Language: en-US
To: Max Gurtovoy <mgurtovoy@nvidia.com>, linux-nvme@lists.infradead.org,
 hch@infradead.org, kbusch@kernel.org
Cc: israelr@nvidia.com, chaitanyak@nvidia.com
References: <20230115100341.40347-1-mgurtovoy@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230115100341.40347-1-mgurtovoy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230123_043305_516070_D91AD598 
X-CRM114-Status: GOOD (  21.67  )
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


> The check if the connection request matches an existing controller is
> duplicated in several transports (such as RDMA and TCP). Move it to
> common code as optional operation.
> 
> Also, this check can be done before creating the controller to simplify
> the flow.
> 
> Reviewed-by: Israel Rukshin <israelr@nvidia.com>
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> ---
>   drivers/nvme/host/fabrics.c | 7 +++++++
>   drivers/nvme/host/fabrics.h | 3 +++
>   2 files changed, 10 insertions(+)
> 
> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
> index ce27276f552d..3d5035331b9f 100644
> --- a/drivers/nvme/host/fabrics.c
> +++ b/drivers/nvme/host/fabrics.c
> @@ -1100,6 +1100,13 @@ nvmf_create_ctrl(struct device *dev, const char *buf)
>   	if (ret)
>   		goto out_module_put;
>   
> +	if (ops->existing_ctrl) {
> +		if (!opts->duplicate_connect && ops->existing_ctrl(opts)) {
> +			ret = -EALREADY;
> +			goto out_module_put;
> +		}
> +	}
> +
>   	ctrl = ops->create_ctrl(dev, opts);
>   	if (IS_ERR(ctrl)) {
>   		ret = PTR_ERR(ctrl);
> diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
> index a6e22116e139..587b92575a9b 100644
> --- a/drivers/nvme/host/fabrics.h
> +++ b/drivers/nvme/host/fabrics.h
> @@ -153,6 +153,8 @@ struct nvmf_ctrl_options {
>    *			that would go into starting up that fabric
>    *			for the purpose of conneciton to an NVMe controller
>    *			using that fabric technology.
> + * @existing_ctrl():	optional function pointer that checks if a connection
> + * 			request matches an existing controller.
>    *
>    * Notes:
>    *	1. At minimum, 'required_opts' and 'allowed_opts' should
> @@ -170,6 +172,7 @@ struct nvmf_transport_ops {
>   	int			allowed_opts;
>   	struct nvme_ctrl	*(*create_ctrl)(struct device *dev,
>   					struct nvmf_ctrl_options *opts);
> +	bool			(*existing_ctrl)(struct nvmf_ctrl_options *opts);
>   };
>   
>   static inline bool

Maybe do nvmf_existing_ctrl() that iterates with device_for_each_child 
and filters by transport?

This will eliminate the identical code from rdma/tcp and potentially
from fc?

