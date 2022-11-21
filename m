Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 978D2C4332F
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Nov 2022 10:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eWbXVpspuUPy6zjkOvEDunyF1CsCwQ7V9RJ8Q3reGJA=; b=HEt33mcDILftYU8kYORMP+WvcG
	6f4V454e5MogMER/H8L3ftcdvRy9KOGjWvEaug7ERWTDY1LbS6vcf0ndkwWhQayL0oy8uK7Ily8XW
	EK9IVStcj1P2IJ159cSVpLZzzgfuG0s5RIUn48vp5SoAw+3pnsTy6WPLLOhjFdWDIsNEPC2CxoK6u
	cZkeG1Jy+DzHL3wqzcP9imKx5XHFEZp/CTCvF98s0T0HLKsVnBU4wjr/mG0dIWgV6ckfBhkSunXzp
	vYOM9QC++fTIkU6uYvHiLU3vjhCnbfW78ymcUZFX1mlRUJnK8r6tgvoheIVYBdojoOgRWHOc1t4cY
	6qJWMg4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ox42X-00CMQf-UP; Mon, 21 Nov 2022 10:28:37 +0000
Received: from mail-wm1-f42.google.com ([209.85.128.42])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ox42V-00CMPr-Ld
	for linux-nvme@lists.infradead.org; Mon, 21 Nov 2022 10:28:37 +0000
Received: by mail-wm1-f42.google.com with SMTP id o7-20020a05600c510700b003cffc0b3374so8499796wms.0
        for <linux-nvme@lists.infradead.org>; Mon, 21 Nov 2022 02:28:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eWbXVpspuUPy6zjkOvEDunyF1CsCwQ7V9RJ8Q3reGJA=;
        b=BR4CLEdJg8tgIqaJyT9SIFedYbkg4oJdrH+UVbvK9/TpnkB+7iI1ahQzNpsZDohjUk
         3YO+MIiMaaAq4wCUuwlAG0u4QDxtZsJGvUUJCOwQCAsiJWhJWU2T8w64qhTAqK7U8QZN
         DYipgkHjNTe89FVSzQL5QKRDuiKViIYPJDqSYtP/r0ac3SlBXopxGR99k7omGBj7dbog
         lTY/FL/QX2fM4hoCOWEyCDmXTFFcuWqhV+9KMQcbn+hP/VRE/XblrO3O/ne6UN4phlr+
         wmcylGh79r8k+P6JyTw2RUJB36utWDFF7LH9Ocr1i1fKIMNqW+G+Ea6zsnX2Prw6MOBr
         iXHA==
X-Gm-Message-State: ANoB5pmrSoMGWw0l1oMshyeKvSxqZ5PzNEuciTj3q5TbGSXNA8N15MlP
	ZXrMDD0nBPztvdnq6QDKUMA1NtruiKQ=
X-Google-Smtp-Source: AA0mqf6/+IWocVx64SV0V0xaQ6RUGklG7CeewU+ZXEAJZdR/f1FjLoTRznYCEUHv7sFtwKg7zu1JsA==
X-Received: by 2002:a05:600c:3d99:b0:3cf:cab4:a42b with SMTP id bi25-20020a05600c3d9900b003cfcab4a42bmr3174130wmb.36.1669026512968;
        Mon, 21 Nov 2022 02:28:32 -0800 (PST)
Received: from [192.168.64.178] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id r7-20020a05600c458700b003a3170a7af9sm13838239wmo.4.2022.11.21.02.28.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 02:28:32 -0800 (PST)
Message-ID: <47533ede-4660-23e2-96b5-0010b032e3dc@grimberg.me>
Date: Mon, 21 Nov 2022 12:28:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 02/13] nvme: move OPAL setup from PCIe to core
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc: Chaitanya Kulkarni <kch@nvidia.com>, Gerd Bayer <gbayer@linux.ibm.com>,
 asahi@lists.linux.dev, linux-nvme@lists.infradead.org
References: <20221113161138.883195-1-hch@lst.de>
 <20221113161138.883195-3-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221113161138.883195-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221121_022835_742945_4EC80CDE 
X-CRM114-Status: GOOD (  28.55  )
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



On 11/13/22 18:11, Christoph Hellwig wrote:
> Nothing about the TCG Opal support is PCIe transport specific, so move it
> to the core code.  For this nvme_init_ctrl_finish grows a new
> was_suspended argument that allows the transport driver to tell the OPAL
> code if the controller came out of a suspend cycle.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Keith Busch <kbusch@kernel.org>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> Tested-by Gerd Bayer <gbayer@linxu.ibm.com>
> ---
>   drivers/nvme/host/apple.c  |  2 +-
>   drivers/nvme/host/core.c   | 25 ++++++++++++++++++++++---
>   drivers/nvme/host/fc.c     |  2 +-
>   drivers/nvme/host/nvme.h   |  5 +----
>   drivers/nvme/host/pci.c    | 14 +-------------
>   drivers/nvme/host/rdma.c   |  2 +-
>   drivers/nvme/host/tcp.c    |  2 +-
>   drivers/nvme/target/loop.c |  2 +-
>   8 files changed, 29 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
> index 24e224c279a41..a85349a7e938c 100644
> --- a/drivers/nvme/host/apple.c
> +++ b/drivers/nvme/host/apple.c
> @@ -1102,7 +1102,7 @@ static void apple_nvme_reset_work(struct work_struct *work)
>   		goto out;
>   	}
>   
> -	ret = nvme_init_ctrl_finish(&anv->ctrl);
> +	ret = nvme_init_ctrl_finish(&anv->ctrl, false);
>   	if (ret)
>   		goto out;
>   
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index ce8314aee1ddf..aedacf2fba69e 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2192,7 +2192,7 @@ const struct pr_ops nvme_pr_ops = {
>   };
>   
>   #ifdef CONFIG_BLK_SED_OPAL
> -int nvme_sec_submit(void *data, u16 spsp, u8 secp, void *buffer, size_t len,
> +static int nvme_sec_submit(void *data, u16 spsp, u8 secp, void *buffer, size_t len,
>   		bool send)
>   {
>   	struct nvme_ctrl *ctrl = data;
> @@ -2209,7 +2209,23 @@ int nvme_sec_submit(void *data, u16 spsp, u8 secp, void *buffer, size_t len,
>   	return __nvme_submit_sync_cmd(ctrl->admin_q, &cmd, NULL, buffer, len,
>   			NVME_QID_ANY, 1, 0);
>   }
> -EXPORT_SYMBOL_GPL(nvme_sec_submit);
> +
> +static void nvme_configure_opal(struct nvme_ctrl *ctrl, bool was_suspended)
> +{
> +	if (ctrl->oacs & NVME_CTRL_OACS_SEC_SUPP) {
> +		if (!ctrl->opal_dev)
> +			ctrl->opal_dev = init_opal_dev(ctrl, &nvme_sec_submit);
> +		else if (was_suspended)
> +			opal_unlock_from_suspend(ctrl->opal_dev);
> +	} else {
> +		free_opal_dev(ctrl->opal_dev);
> +		ctrl->opal_dev = NULL;
> +	}
> +}
> +#else
> +static void nvme_configure_opal(struct nvme_ctrl *ctrl, bool was_suspended)
> +{
> +}
>   #endif /* CONFIG_BLK_SED_OPAL */
>   
>   #ifdef CONFIG_BLK_DEV_ZONED
> @@ -3242,7 +3258,7 @@ static int nvme_init_identify(struct nvme_ctrl *ctrl)
>    * register in our nvme_ctrl structure.  This should be called as soon as
>    * the admin queue is fully up and running.
>    */
> -int nvme_init_ctrl_finish(struct nvme_ctrl *ctrl)
> +int nvme_init_ctrl_finish(struct nvme_ctrl *ctrl, bool was_suspended)
>   {
>   	int ret;
>   
> @@ -3273,6 +3289,8 @@ int nvme_init_ctrl_finish(struct nvme_ctrl *ctrl)
>   	if (ret < 0)
>   		return ret;
>   
> +	nvme_configure_opal(ctrl, was_suspended);
> +
>   	if (!ctrl->identified && !nvme_discovery_ctrl(ctrl)) {
>   		/*
>   		 * Do not return errors unless we are in a controller reset,
> @@ -5007,6 +5025,7 @@ static void nvme_free_ctrl(struct device *dev)
>   	nvme_auth_stop(ctrl);
>   	nvme_auth_free(ctrl);
>   	__free_page(ctrl->discard_page);
> +	free_opal_dev(ctrl->opal_dev);
>   
>   	if (subsys) {
>   		mutex_lock(&nvme_subsystems_lock);
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index 2d3c54838496f..1f9f4075794b5 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -3107,7 +3107,7 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
>   
>   	nvme_start_admin_queue(&ctrl->ctrl);
>   
> -	ret = nvme_init_ctrl_finish(&ctrl->ctrl);
> +	ret = nvme_init_ctrl_finish(&ctrl->ctrl, false);

Completely imaginary question,

Since you correctly indicated that opal is not pcie specific, why is
this passed as always false?

Wandering if a opal fabrics device comes along and becomes
incompatible with this...

Although fabrics call nvme_shutdown_ctrl only when deleting the
controller, so there is no opal_dev in any case... There is no real
suspend in fabrics at all really. So I guess it makes sense.
It's just a bit confusing to think about in the fabrics context.

