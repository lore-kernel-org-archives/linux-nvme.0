Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4795DC6FD1D
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Mar 2023 08:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=S6SUM1SxI6kpNLyZD4/nn69thvSzIjBr3T8FU89F0kg=; b=C+/3x5T6Rb9i4Sf1TSGPEEDP+O
	m1eStfADMvMfIxxXc6R/TpQdZE+rKE/mxfT0VqKFbvCiiTonm3yGoJpdLD/ps4a/uOohk5mbXyylM
	OJD/yaDUT/E6NAjvkfFgZsqif68ConiiGkcMs1eNE/bfvfMoHF9Idx3cAr1tbMgNg76EWbr11tLL9
	JvYloI7sKjOaml7sJc4iWKRcCO2qu9lGXUIlEaiHxh2WlVIMd6nzPODR8N6T0Y9QCRd9AXmty8Y9k
	CXi8NXpGufCDWcJHQLvTlQZzpWdW2haqNgwn95h1+W08q8cNkPYflzLBEy0QA2Axx3neCbzoVw/o4
	AuOxYsKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pfFuT-001CUa-2R;
	Thu, 23 Mar 2023 08:02:57 +0000
Received: from mail-wr1-f41.google.com ([209.85.221.41])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pfFuR-001CTO-2F
	for linux-nvme@lists.infradead.org;
	Thu, 23 Mar 2023 08:02:56 +0000
Received: by mail-wr1-f41.google.com with SMTP id d17so11026691wrb.11
        for <linux-nvme@lists.infradead.org>; Thu, 23 Mar 2023 01:02:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679558573;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S6SUM1SxI6kpNLyZD4/nn69thvSzIjBr3T8FU89F0kg=;
        b=oFaRTkGvXGXwuHveiswrglSHJnyDXo3S++aieV8A/OVUPVxUCu8hmSdupGKT+Z4Svj
         YTvknl0nz3PKYqOHUVhQ2SkOtfnyc8HkAlkFsexlyLQ1ObPxOg9kpxFrGsGLm9vdwpZD
         TQxVRw84SbDHcy1LD8Xc1B01GqBL8F9kocErXXF92e/Tm2EapMOQKcaxXwI6PuP2TG+k
         cPWp67uYT+w57cQZcAPphRFPghTkUkjiJN0P02Vd0X/eR6DSAokslQKAVv6DOEjTPSaw
         +KhXEsECVkY2VAeI9ZxMEvsK3KIIGG+J8f/xCHbD5EWW3YQCBuRCYI5Dghgfo5moI5dR
         1KbA==
X-Gm-Message-State: AO0yUKWxSbqOP8kgF1VkuzNbOzyPuf5itYVcQrMkOOI3j7DUaFHkZu4R
	WFKoUxVkpSj0gt4Puznvy2gEoeVAbwM=
X-Google-Smtp-Source: AK7set+GS/SlfllH0OOOKadRYyR/XL2SMoQIwFpeNzwWudJUkpggM44Agk6uBs9PJj/g2ftwMQWntw==
X-Received: by 2002:adf:fbc3:0:b0:2c7:660:9284 with SMTP id d3-20020adffbc3000000b002c706609284mr5438786wrs.0.1679558572746;
        Thu, 23 Mar 2023 01:02:52 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id s12-20020adfeb0c000000b002c57384dfe0sm15554918wrn.113.2023.03.23.01.02.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Mar 2023 01:02:52 -0700 (PDT)
Message-ID: <2ab1614a-4fc7-f496-5d72-378c78a9da7a@grimberg.me>
Date: Thu, 23 Mar 2023 10:02:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 4/9] nvme-core: code cleanup for __nvme_check_ready()
Content-Language: en-US
To: Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de, hare@suse.de
References: <20230323033636.812758-1-kch@nvidia.com>
 <20230323033636.812758-5-kch@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230323033636.812758-5-kch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230323_010255_730972_85BB2EE0 
X-CRM114-Status: GOOD (  24.97  )
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



On 3/23/23 05:36, Chaitanya Kulkarni wrote:
> We can avoid using nested indentation by returning early if the
> controller is not fabrics. Additionally, instead of using comparisons,
> we can use a switch statement to determine if the required command is
> connect/auth_send/auth_recv. This will also help to reduce the length of
> the lines in the code and makes code easy to read since we don't have to
> verify three different comparisons. Lastly, fix the spelling of
> "appropriate" in the second comment.
> 
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
>   drivers/nvme/host/core.c | 41 +++++++++++++++++++++++-----------------
>   1 file changed, 24 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index c2fb7a0eba3d..a380938f5a06 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -721,25 +721,32 @@ bool __nvme_check_ready(struct nvme_ctrl *ctrl, struct request *rq,
>   	if (rq->q == ctrl->admin_q && (req->flags & NVME_REQ_USERCMD))
>   		return false;
>   
> -	if (ctrl->ops->flags & NVME_F_FABRICS) {
> -		/*
> -		 * Only allow commands on a live queue, except for the connect
> -		 * command, which is require to set the queue live in the
> -		 * appropinquate states.
> -		 */
> -		switch (ctrl->state) {
> -		case NVME_CTRL_CONNECTING:
> -			if (blk_rq_is_passthrough(rq) && nvme_is_fabrics(req->cmd) &&
> -			    (req->cmd->fabrics.fctype == nvme_fabrics_type_connect ||
> -			     req->cmd->fabrics.fctype == nvme_fabrics_type_auth_send ||
> -			     req->cmd->fabrics.fctype == nvme_fabrics_type_auth_receive))
> +	if (!(ctrl->ops->flags & NVME_F_FABRICS))
> +		return queue_live;
> +
> +	/*
> +	 * Only allow commands on a live queue, except for connect/auth_send/
> +	 * auth_recv commands which are require to set the queue live in the
> +	 * appropriate states.
> +	 */
> +	switch (ctrl->state) {
> +	case NVME_CTRL_CONNECTING:
> +		if (blk_rq_is_passthrough(rq) &&
> +		    nvme_is_fabrics(req->cmd)) {
> +			switch (req->cmd->fabrics.fctype) {
> +			case nvme_fabrics_type_connect:
> +			case nvme_fabrics_type_auth_send:
> +			case nvme_fabrics_type_auth_receive:
>   				return true;
> -			break;
> -		default:
> -			break;
> -		case NVME_CTRL_DEAD:
> -			return false;
> +			default:
> +				break;

I think we can safely remove the default case here.

> +			}
>   		}
> +		break;
> +	default:
> +		break;

While we're at it, same here.

> +	case NVME_CTRL_DEAD:
> +		return false;


>   	}
>   
>   	return queue_live;

