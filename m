Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2262BC47074
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Jan 2024 13:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NdOShdwtgwFhbT0OEsaY0M64FoRoHPSHLuoEjBsJPB0=; b=NZ7AuMVb0qKOit3RPZS91NV/tJ
	I6mmQMS82956zUEMK6ZCX1WZ/ITA25PHyRGs77jRUtPVsc+u3NixsV4VGn5GA8CQm3Dm5T/p42q0Z
	M1qCw7JzKeBa/1FGTCAFHLJSRRjBV6CqdhNYMBPC+AN48X1IDBQnmhFAElno/jz6wiyeqYcklodyw
	ULAHN9RL/5LR5e8WWLj3WXdNJtYoCMiNQmLFCXqj4mKyZoFrpQlhscJrP0eEqZvIW6KDOo/rSRSYy
	s7jsk5bkIg1xMmWY1psWeqqp14XJPIekBui+jfySkM7tDqRhDr3eamN2A/IQcnhJjylUiTXTnN0eN
	fUKvlIYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rLNjm-00E9AR-2j;
	Thu, 04 Jan 2024 13:26:18 +0000
Received: from mail-wm1-f51.google.com ([209.85.128.51])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rLNjj-00E99a-1p
	for linux-nvme@lists.infradead.org;
	Thu, 04 Jan 2024 13:26:16 +0000
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40d5d9adf6eso1116565e9.0
        for <linux-nvme@lists.infradead.org>; Thu, 04 Jan 2024 05:26:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704374774; x=1704979574;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NdOShdwtgwFhbT0OEsaY0M64FoRoHPSHLuoEjBsJPB0=;
        b=FqR/a7badwqVzfuNKZcwb1gXC2J3jhxrfsEZO3ZuY/rZrhZOP1GHxFsJrKwlnOFDSU
         Iqn+5StSCYxV4AbntOwWH8Vm9+HMQXyHkadQRtMW0KCc0gbFV1O5xWUCYWoqk/F5/vH9
         BBRqNVHIcAk5EL39bXZ8Vk+6KYFNKph8fkrYUzpg6pYhDyCUQ44v71M5ZpOPTpQSNQ+i
         vjHw+8TJyEjXknK3G93RMLODXWXy1UPenuSGLiARXOoJeJrXUv/Mhve5ajn950uGiCAW
         yLWA/hvY2+Dm0u6OUMxTRNam1Sel3539GzUMVlwoIkwXknGjEqo0gk2uiBYa4bz2aIKy
         ld9g==
X-Gm-Message-State: AOJu0YwtttM8UqJqwU3FdecMI0pRaIXqtkd6hhzW4hjqQuZyQ8i2XIwu
	ocTXZJQGsWAClZPJ6qThGgk=
X-Google-Smtp-Source: AGHT+IGksDX1L+9Mek+e5XJ6XVPDHWOs9DJQiA8hxb7oLCFxv5f4JRnpxVEP7C4iAQgOyzitE17NJg==
X-Received: by 2002:a05:600c:1d09:b0:40d:3dfb:1cbe with SMTP id l9-20020a05600c1d0900b0040d3dfb1cbemr789547wms.2.1704374773667;
        Thu, 04 Jan 2024 05:26:13 -0800 (PST)
Received: from [10.100.102.14] (46-116-232-10.bb.netvision.net.il. [46.116.232.10])
        by smtp.gmail.com with ESMTPSA id s10-20020a05600c384a00b0040e35acd0ecsm521010wmr.43.2024.01.04.05.26.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jan 2024 05:26:13 -0800 (PST)
Message-ID: <4486c671-af66-4466-bfca-e184584d884b@grimberg.me>
Date: Thu, 4 Jan 2024 15:26:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] nvme: Change 'bool shutdown' into an enum
 shutdown_type.
Content-Language: en-US
To: Jeremy Allison <jallison@ciq.com>, jra@samba.org, tansuresh@google.com,
 hch@lst.de, gregkh@linuxfoundation.org, rafael@kernel.org,
 bhelgaas@google.com
Cc: linux-nvme@lists.infradead.org
References: <20240103210405.3593499-1-jallison@ciq.com>
 <20240103210405.3593499-4-jallison@ciq.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240103210405.3593499-4-jallison@ciq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240104_052615_605593_41CB13EB 
X-CRM114-Status: GOOD (  20.94  )
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



On 1/3/24 23:04, Jeremy Allison wrote:
> Convert nvme_disable_ctrl() and nvme_dev_disable()
> inside drivers/nvme/host/pci.c to use this:
> 
> bool shutdown = false == NVME_DISABLE_RESET
> bool shutdown = true == NVME_DISABLE_SHUTDOWN_SYNC.
> 
> This will make it easier to add a third request later:
> NVME_DISABLE_SHUTDOWN_ASNYC
> 
> As nvme_disable_ctrl() is used outside of drivers/nvme/host/pci.c,
> convert the callers of nvme_disable_ctrl() to this convention too.
> 
> Signed-off-by: Jeremy Allison <jallison@ciq.com>
> ---
>   drivers/nvme/host/apple.c  |  4 ++--
>   drivers/nvme/host/core.c   |  6 +++---
>   drivers/nvme/host/nvme.h   |  7 +++++-
>   drivers/nvme/host/pci.c    | 44 +++++++++++++++++++-------------------
>   drivers/nvme/host/rdma.c   |  3 ++-
>   drivers/nvme/host/tcp.c    |  3 ++-
>   drivers/nvme/target/loop.c |  2 +-
>   7 files changed, 38 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
> index 596bb11eeba5..764639ede41d 100644
> --- a/drivers/nvme/host/apple.c
> +++ b/drivers/nvme/host/apple.c
> @@ -844,8 +844,8 @@ static void apple_nvme_disable(struct apple_nvme *anv, bool shutdown)
>   		 * NVMe disabled state, after a clean shutdown).
>   		 */
>   		if (shutdown)
> -			nvme_disable_ctrl(&anv->ctrl, shutdown);
> -		nvme_disable_ctrl(&anv->ctrl, false);
> +			nvme_disable_ctrl(&anv->ctrl, NVME_DISABLE_SHUTDOWN_SYNC);
> +		nvme_disable_ctrl(&anv->ctrl, NVME_DISABLE_RESET);
>   	}
>   
>   	WRITE_ONCE(anv->ioq.enabled, false);
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 50818dbcfa1a..e1b2facb7d6a 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2219,12 +2219,12 @@ static int nvme_wait_ready(struct nvme_ctrl *ctrl, u32 mask, u32 val,
>   	return ret;
>   }
>   
> -int nvme_disable_ctrl(struct nvme_ctrl *ctrl, bool shutdown)
> +int nvme_disable_ctrl(struct nvme_ctrl *ctrl, enum shutdown_type shutdown_type)
>   {
>   	int ret;
>   
>   	ctrl->ctrl_config &= ~NVME_CC_SHN_MASK;
> -	if (shutdown)
> +	if (shutdown_type == NVME_DISABLE_SHUTDOWN_SYNC)
>   		ctrl->ctrl_config |= NVME_CC_SHN_NORMAL;
>   	else
>   		ctrl->ctrl_config &= ~NVME_CC_ENABLE;
> @@ -2233,7 +2233,7 @@ int nvme_disable_ctrl(struct nvme_ctrl *ctrl, bool shutdown)
>   	if (ret)
>   		return ret;
>   
> -	if (shutdown) {
> +	if (shutdown_type == NVME_DISABLE_SHUTDOWN_SYNC) {
>   		return nvme_wait_ready(ctrl, NVME_CSTS_SHST_MASK,
>   				       NVME_CSTS_SHST_CMPLT,
>   				       ctrl->shutdown_timeout, "shutdown");
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 6092cc361837..1a748640f2fb 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -187,6 +187,11 @@ enum {
>   	NVME_MPATH_IO_STATS		= (1 << 2),
>   };
>   
> +enum shutdown_type {
> +	NVME_DISABLE_RESET = 0,
> +	NVME_DISABLE_SHUTDOWN_SYNC = 1
> +};

I also don't find this a bit awkward especially when another
enumeration value is added later on.

An alternative approach would be to stick with nvme_disable_ctrl that
accepts shutdown bool, and add nvme_disable_ctrl_nowait() wrapper for it
that call-sites can use. Or even better, because we only have a nowait
variant for shutdown, perhaps we can add nvme_shutdown_ctrl_nowait()
wrapper that accepts only the ctrl instead (this will require splitting
nvme_disable_ctrl to the disabling phase and the waiting phase, but that
is hidden in the core as static functions).

