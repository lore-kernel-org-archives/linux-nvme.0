Return-Path: <SRS0=W3/M=PH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA86BC433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Oct 2021 12:36:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B35F061260
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Oct 2021 12:36:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B35F061260
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gZqncm/fwk6m5hEzHIt/VUv4Y0lpLUuNsD7ULDi8nj0=; b=FiATN1nSXc2A/dyNDEE27dSm2X
	qL3HGLaPz0nQMAWID3hNB1/NMSmLDmVZFHvBlZA8AtkTxc5PmRx2JloaURrAdy23GsgJuo7SpFYpG
	W6qV2epqb6WaBKJTo6sj3oSmYYsSlMSxFXzfy6+9gg1T60mUG+paoCzNmeEy7VZJI9UWtO3Mio32b
	oBvhfhyFj+r/yYiKCpFNlJ+UUSJ/X6p059tJ6uY6hvLoyCKUSPIkSBt7OZtiQMHIHdEQ80hAPL5ag
	6KW4NsD7S+R3P9rLUV42NcNuNQQH25vVEdsiiWgLA+WRDEKthxfa0jh9fQcSLROtBgDKrbBkEnoQG
	bjvjcpiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mcoLg-001Emj-E6; Tue, 19 Oct 2021 12:36:08 +0000
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mcoLc-001Ekb-8t
 for linux-nvme@lists.infradead.org; Tue, 19 Oct 2021 12:36:05 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 y74-20020a1c7d4d000000b00322f53b9bbfso2525181wmc.3
 for <linux-nvme@lists.infradead.org>; Tue, 19 Oct 2021 05:36:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=gZqncm/fwk6m5hEzHIt/VUv4Y0lpLUuNsD7ULDi8nj0=;
 b=AXjqe2qlsqlr3uH5HR9BELO/Wi5P06+q2IPG2AtyZBoH89U3Yf6bfW9EIVRvGWUCU/
 t/GH0zDXJ6XpqEN/t09jYIC811ftPoghmlIDXOc2+7zteqdoiaHAz/1yPIRFgAfkRrDN
 cSPlrg4uoQbxigly9zDHQQ0SOJgEcCEoEvGsL9ITsAHMcfXjOYUoLsDyLuy0cw+8a3yU
 uz5V7hZPY6OVLl9yAsnYqkHKD8cf8ug2u45JLwRadz4eSUKdp0kgxkawVZUptgsmL4Bf
 1tYCMnaNLue+KoL2f0e4eDm1rN0HgF3B+N2I97Ec2us4ai3VrI51Xv02xKkBu+4/5PuC
 pgYA==
X-Gm-Message-State: AOAM532zCSezLqU3JAyPVJ+jB6SZM7Z8AjMDtFfdpfkLGeNrJkhpZySb
 HMuU7zDbBRb/P6holKIiXgg=
X-Google-Smtp-Source: ABdhPJyRwn3r8wpqxK6bTc9dCZWhLCrBpTr7V5oT+WIiC07FNTuGyjiLG+B/LJKKLdpaBgnBB9vZdg==
X-Received: by 2002:a05:600c:a08:: with SMTP id
 z8mr5750288wmp.52.1634646962872; 
 Tue, 19 Oct 2021 05:36:02 -0700 (PDT)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id l2sm6299394wrs.90.2021.10.19.05.36.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Oct 2021 05:36:02 -0700 (PDT)
Subject: Re: [PATCH 2/7] nvme-fabrics: introduce nvmf_reconnect_or_remove API
To: Max Gurtovoy <mgurtovoy@nvidia.com>, linux-nvme@lists.infradead.org,
 hch@lst.de, kbusch@kernel.org
Cc: chaitanyak@nvidia.com, israelr@nvidia.com, oren@nvidia.com,
 jsmart2021@gmail.com
References: <20211018134020.33838-1-mgurtovoy@nvidia.com>
 <20211018134020.33838-3-mgurtovoy@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <97e9e1ec-701c-fde7-809a-056b89655d99@grimberg.me>
Date: Tue, 19 Oct 2021 15:36:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211018134020.33838-3-mgurtovoy@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211019_053604_418557_D8CDB4EF 
X-CRM114-Status: GOOD (  21.86  )
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


> This logic is duplicated today for RDMA and TCP controllers. Move it to
> the fabrics driver and export it as a new API.
> 
> Also update the RDMA/TCP transport drivers to use this API and remove
> the duplicated code.
> 
> Reviewed-by: Israel Rukshin <israelr@nvidia.com>
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> ---
>   drivers/nvme/host/fabrics.c | 21 +++++++++++++++++++++
>   drivers/nvme/host/fabrics.h |  1 +
>   drivers/nvme/host/rdma.c    | 25 +++----------------------
>   drivers/nvme/host/tcp.c     | 26 +++-----------------------
>   4 files changed, 28 insertions(+), 45 deletions(-)
> 
> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
> index 668c6bb7a567..4a1ef67c6fb3 100644
> --- a/drivers/nvme/host/fabrics.c
> +++ b/drivers/nvme/host/fabrics.c
> @@ -472,6 +472,27 @@ bool nvmf_should_reconnect(struct nvme_ctrl *ctrl)
>   }
>   EXPORT_SYMBOL_GPL(nvmf_should_reconnect);
>   
> +void nvmf_reconnect_or_remove(struct nvme_ctrl *ctrl)
> +{
> +	/* If we are resetting/deleting then do nothing */
> +	if (ctrl->state != NVME_CTRL_CONNECTING) {
> +		WARN_ON_ONCE(ctrl->state == NVME_CTRL_NEW ||
> +			ctrl->state == NVME_CTRL_LIVE);
> +		return;
> +	}
> +
> +	if (nvmf_should_reconnect(ctrl)) {
> +		dev_info(ctrl->device, "Reconnecting in %d seconds...\n",
> +			ctrl->opts->reconnect_delay);
> +		queue_delayed_work(nvme_wq, &ctrl->connect_work,
> +				ctrl->opts->reconnect_delay * HZ);
> +	} else {
> +		dev_info(ctrl->device, "Removing controller...\n");
> +		nvme_delete_ctrl(ctrl);
> +	}

We need to look at fc here as it does this differently.
Can it converge somehow? if not we can add a callback for a driver
to override it.

