Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C949C4332F
	for <linux-nvme@archiver.kernel.org>; Sun, 25 Dec 2022 11:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dBBDYQ1KxTDeOxCIy53VVCIrOpD+lQCCfGsn3ZQCB7E=; b=xYJt/dkWhGRtQeIYcbT4kpN7BY
	UHHFxWKst4Gxv5N81SBr980QQLyY5k7rc+BnqyHrlaQvivWoxZFyCvsPV6j9XzZ+rphuHL6FGNB9l
	PsyaiItL83gwEg9/pVSKZMRb8Kpj8vc9BXSSZtPlPRDWEYuCgzfuV4rV01zxTNDN0SvS1iDxG/FZp
	Y9Mx2we7kxujpgxk+jojjl0rlv01KcWzcX8jLmrjJNN/M+59e8YcFlay77W0HDsZ6t9qHkebkzmGk
	q+tPORtrSom1A1eY0v5BkZpxeOLaRFxWgJIYx9+jIQFi/B2zc4OQ/kva5OQBdXA21PiHvarR69QwN
	jzbadeLw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p9Owk-00AMhN-1h; Sun, 25 Dec 2022 11:13:38 +0000
Received: from mail-wm1-f49.google.com ([209.85.128.49])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p9ODG-009zOl-Pf
	for linux-nvme@lists.infradead.org; Sun, 25 Dec 2022 10:26:41 +0000
Received: by mail-wm1-f49.google.com with SMTP id fm16-20020a05600c0c1000b003d96fb976efso3728778wmb.3
        for <linux-nvme@lists.infradead.org>; Sun, 25 Dec 2022 02:26:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dBBDYQ1KxTDeOxCIy53VVCIrOpD+lQCCfGsn3ZQCB7E=;
        b=Yq9FFSvMD804IvdCzkoaWJJ2LlydH6y7jKikbtKqrl4G+aRN2Uxp/MZuJca8wJi+61
         1iH5YkidOGFo7WsXd4k28ZAV8QGD37C3xkhMmXXIfOt/L78gPDNsNmdBL3fg7dzPl49P
         xuclp5uxzol8HOqyJZmM0v4ZKpLaxBd+JbvNCd4b05X7y7+eNcgDK393VDpSt9+tVND+
         Qpp11d0dygFrBRP3sFgszyfCByfw2kx4cHoxSrhKnkHSVvePKU2fyIQNZy1lRcI3TjFX
         Vkl5S2ooJDtu8yrdT4o8/N97OsV7qZ+I1W3eGw1HsCgz/ufarMYcXhrZhVBfSgqAks3L
         fHvw==
X-Gm-Message-State: AFqh2koffVH7T3o2QZz1Hi/oT0X8dNwYXUBkme8b41gYKU+y75hOaLBB
	zVU4pyCi/Z0QmZ3Kew6x+9JmGbu8BAs=
X-Google-Smtp-Source: AMrXdXujebR2Ea/djrqn7GZSJuFyZthS5sCm9ey65grh53AdennOaGA4okXjixjztD/3MSAv2L5byg==
X-Received: by 2002:a1c:7410:0:b0:3cf:8957:806e with SMTP id p16-20020a1c7410000000b003cf8957806emr11065315wmc.5.1671963997487;
        Sun, 25 Dec 2022 02:26:37 -0800 (PST)
Received: from [192.168.64.177] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id c4-20020a05600c0a4400b003cf75213bb9sm17287505wmq.8.2022.12.25.02.26.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Dec 2022 02:26:37 -0800 (PST)
Message-ID: <74cdb20e-2f38-f001-0b82-cca2b3046df9@grimberg.me>
Date: Sun, 25 Dec 2022 12:26:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 5/6] nvme: also return I/O command effects from
 nvme_command_effects
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: Kanchan Joshi <joshi.k@samsung.com>, linux-nvme@lists.infradead.org
References: <20221223071814.43564-1-hch@lst.de>
 <20221223071814.43564-6-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221223071814.43564-6-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221225_022638_934892_F35F871C 
X-CRM114-Status: GOOD (  24.65  )
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



On 12/23/22 09:18, Christoph Hellwig wrote:
> To be able to use the Commands Supported and Effects Log for allowing
> unprivileged passtrough, it needs to be corretly reported for I/O
> commands as well.  Return the I/O command effects from
> nvme_command_effects, and also add a default list of effects for the
> NVM command set.  For other command sets, the Commands Supported and
> Effects log is required to be present already.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>
> ---
>   drivers/nvme/host/core.c | 32 ++++++++++++++++++++++++++------
>   1 file changed, 26 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index e26b085a007aea..21d79c186d8c14 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1074,6 +1074,18 @@ static u32 nvme_known_admin_effects(u8 opcode)
>   	return 0;
>   }
>   
> +static u32 nvme_known_nvm_effects(u8 opcode)
> +{
> +	switch (opcode) {
> +	case nvme_cmd_write:
> +	case nvme_cmd_write_zeroes:
> +	case nvme_cmd_write_uncor:
> +		 return NVME_CMD_EFFECTS_LBCC;
> +	default:
> +		return 0;
> +	}
> +}
> +
>   u32 nvme_command_effects(struct nvme_ctrl *ctrl, struct nvme_ns *ns, u8 opcode)
>   {
>   	u32 effects = 0;
> @@ -1081,16 +1093,24 @@ u32 nvme_command_effects(struct nvme_ctrl *ctrl, struct nvme_ns *ns, u8 opcode)
>   	if (ns) {
>   		if (ns->head->effects)
>   			effects = le32_to_cpu(ns->head->effects->iocs[opcode]);
> +		if (ns->head->ids.csi == NVME_CAP_CSS_NVM)
> +			effects |= nvme_known_nvm_effects(opcode);
>   		if (effects & ~(NVME_CMD_EFFECTS_CSUPP | NVME_CMD_EFFECTS_LBCC))
>   			dev_warn_once(ctrl->device,
> -				"IO command:%02x has unhandled effects:%08x\n",
> +				"IO command:%02x has unusual effects:%08x\n",
>   				opcode, effects);
> -		return 0;
> -	}
>   
> -	if (ctrl->effects)
> -		effects = le32_to_cpu(ctrl->effects->acs[opcode]);
> -	effects |= nvme_known_admin_effects(opcode);
> +		/*
> +		 * NVME_CMD_EFFECTS_CSE_MASK causes a freeze all I/O queues,
> +		 * which would deadlock when done on an I/O command.  Note that
> +		 * We already warn about an unusual effect above.
> +		 */

I think it would be helpful to warn that we are masking it out? The
warning above does not directly relate to the cse mask, but rather 
anthing outside of NVME_CMD_EFFECTS_CSUPP | NVME_CMD_EFFECTS_LBCC ?

> +		effects &= ~NVME_CMD_EFFECTS_CSE_MASK;
> +	} else {
> +		if (ctrl->effects)
> +			effects = le32_to_cpu(ctrl->effects->acs[opcode]);
> +		effects |= nvme_known_admin_effects(opcode);
> +	}
>   
>   	return effects;
>   }

