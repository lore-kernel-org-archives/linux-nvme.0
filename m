Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29C7FC3DA6E
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Dec 2023 09:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6OMLfEPuyCSB3QeINwRatqoaMszzQalJ5WgjoX0+4LU=; b=YxgNvqDo+x0tEr5QqD7QmJq+7v
	pqtcDf/Kez7gGUMDAQ/+L9W3vYqoZZAr8tNTRq5qaEsvzt5lcInrlvwdVk8IvoWzzS6ULqUKd8fKz
	vp8qbZGXAks4Hu/d9AtMUbzakRLvq0KV6jNXk5D6Oh4pFJvCNo6W660zHitFL5Xt5STzCKbXiKiqe
	NJnasSzDqgD4Wq9fS+kYn5k57AYDmp4+Yll52AnmNfMyUiesXMYzqnwR/EkKGdDbA0djGDBzW1jlK
	5pn8oNcalrdwhnnW8jyr93bDBKMHeOhCRnrGkS2oPlJ2jKsrcACmcHhhP/If2VIxM6XVTGmReE8VG
	6zTM5ZGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rHhiu-00AVDC-02;
	Mon, 25 Dec 2023 09:58:12 +0000
Received: from mail-wr1-f49.google.com ([209.85.221.49])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rHhiq-00AVCt-29
	for linux-nvme@lists.infradead.org;
	Mon, 25 Dec 2023 09:58:10 +0000
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3367f8757d0so656659f8f.1
        for <linux-nvme@lists.infradead.org>; Mon, 25 Dec 2023 01:58:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703498287; x=1704103087;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6OMLfEPuyCSB3QeINwRatqoaMszzQalJ5WgjoX0+4LU=;
        b=ORRFchajc7D9QVEKi0f4ZDVEwrjgwbOznB5/vucFGh09rn8wINC4Ef71hfrKj6Ake6
         sYAFUDRGK1zHt1bPgarNl0sxmeOra4wr5WQ3/0hgyKABAslsudJ3TKNEYFm4L6G3wMZB
         8smZEWafvHoCsViGk/OMnDAnkDSRg53fyJirexTxZ2PNacPZx636hO5+EtLSxqZjsBKJ
         Z2PDMeYJo47PX/lgXkpH1/WZUS7LTDDc8iYNKZp9sqcensDzpGY8nOHJhR9lO6MsYlz3
         QCT5NXWvBLnBLW7hPVWLNdqirZ533nts+Qd0Ody1OY2JZ9ezSm1SGj0UyCzldFeWg45u
         GBeA==
X-Gm-Message-State: AOJu0Yypb2otiROucDYi4aF6Le4ohZO0jYvQ7af6dOdpLY6rOx93UU7g
	evX3ARyGjODlKdlx74JqsuY=
X-Google-Smtp-Source: AGHT+IH8TXzVpTacHOTAqcwU9AgbFSlS7wCBHin2NbtU9tdWFZP2gWovXuY6MMlxWZv0N7rcw3o4OA==
X-Received: by 2002:adf:e311:0:b0:336:62c0:5d6c with SMTP id b17-20020adfe311000000b0033662c05d6cmr6369657wrj.4.1703498287225;
        Mon, 25 Dec 2023 01:58:07 -0800 (PST)
Received: from [192.168.64.172] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id l4-20020adff484000000b003366d04b050sm10046708wro.38.2023.12.25.01.58.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Dec 2023 01:58:06 -0800 (PST)
Message-ID: <694ac9af-ac3b-41a0-a50d-abb89503d453@grimberg.me>
Date: Mon, 25 Dec 2023 11:58:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] nvme: Add two-pass shutdown support
Content-Language: en-US
To: Jeremy Allison <jallison@ciq.com>, jra@samba.org, tansuresh@google.com,
 hch@lst.de, gregkh@linuxfoundation.org, rafael@kernel.org,
 bhelgaas@google.com
Cc: linux-nvme@lists.infradead.org
References: <20231221172257.2234320-1-jallison@ciq.com>
 <20231221172257.2234320-5-jallison@ciq.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20231221172257.2234320-5-jallison@ciq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231225_015808_724690_46687D9F 
X-CRM114-Status: GOOD (  30.77  )
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



On 12/21/23 19:22, Jeremy Allison wrote:
> This works with the two-pass shutdown mechanism setup for the PCI
> drivers and participates to provide the shutdown_wait
> method at the pci_driver structure level.
> 
> Adds the new NVME_DISABLE_SHUTDOWN_ASYNC to enum shutdown_type.
> Changes the nvme shutdown() method to set the
> NVME_CC_SHN_NORMAL bit and then return to the caller when
> requested by NVME_DISABLE_SHUTDOWN_ASYNC.
> 
> nvme_shutdown_wait() is added to call an internal
> nvme_wait_for_shutdown_cmpl() function to synchronously
> wait for the device to wait for the NVME_CSTS_SHST_CMPLT bit.
> 
> This change speeds up the shutdown in a system which hosts
> many controllers.
> 
> Signed-off-by: Jeremy Allison <jallison@ciq.com>
> Signed-off-by: Tanjore Suresh <tansuresh@google.com>
> ---
>   drivers/nvme/host/core.c | 29 +++++++++++++++++++++++++++--
>   drivers/nvme/host/nvme.h |  4 +++-
>   drivers/nvme/host/pci.c  | 24 ++++++++++++++++++++++--
>   3 files changed, 52 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index bc7040da8e74..2ebcd40106b7 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2216,7 +2216,7 @@ int nvme_disable_ctrl(struct nvme_ctrl *ctrl, enum shutdown_type shutdown_type)
>   	int ret;
>   
>   	ctrl->ctrl_config &= ~NVME_CC_SHN_MASK;
> -	if (shutdown_type == NVME_DISABLE_SHUTDOWN_SYNC)
> +	if (shutdown_type != NVME_DISABLE_RESET)
>   		ctrl->ctrl_config |= NVME_CC_SHN_NORMAL;
>   	else
>   		ctrl->ctrl_config &= ~NVME_CC_ENABLE;
> @@ -2225,10 +2225,24 @@ int nvme_disable_ctrl(struct nvme_ctrl *ctrl, enum shutdown_type shutdown_type)
>   	if (ret)
>   		return ret;
>   
> -	if (shutdown_type == NVME_DISABLE_SHUTDOWN_SYNC) {
> +	switch (shutdown_type) {
> +	case NVME_DISABLE_SHUTDOWN_ASYNC:
> +		/*
> +		 * nvme_wait_for_shutdown_cmpl() will read the reply for this.
> +		*/
> +		return ret;
> +	case NVME_DISABLE_SHUTDOWN_SYNC:
> +		/*
> +		 * Spin on the read of the control register.
> +		 */
>   		return nvme_wait_ready(ctrl, NVME_CSTS_SHST_MASK,
>   				       NVME_CSTS_SHST_CMPLT,
>   				       ctrl->shutdown_timeout, "shutdown");
> +	case NVME_DISABLE_RESET:
> +		/*
> +		 * Doing a reset here. Handle below.
> +		 */
> +		break;
>   	}
>   	if (ctrl->quirks & NVME_QUIRK_DELAY_BEFORE_CHK_RDY)
>   		msleep(NVME_QUIRK_DELAY_AMOUNT);
> @@ -2237,6 +2251,17 @@ int nvme_disable_ctrl(struct nvme_ctrl *ctrl, enum shutdown_type shutdown_type)
>   }
>   EXPORT_SYMBOL_GPL(nvme_disable_ctrl);
>   
> +int nvme_wait_for_shutdown_cmpl(struct nvme_ctrl *ctrl)
> +{
> +	ctrl->ctrl_config &= ~NVME_CC_SHN_MASK;
> +	ctrl->ctrl_config |= NVME_CC_SHN_NORMAL;

Why is ctrl_config being set again?

> +
> +	return nvme_wait_ready(ctrl, NVME_CSTS_SHST_MASK,
> +			       NVME_CSTS_SHST_CMPLT,
> +			       ctrl->shutdown_timeout, "shutdown");
> +}
> +EXPORT_SYMBOL_GPL(nvme_wait_for_shutdown_cmpl);

Why export the symbol?

> +
>   int nvme_enable_ctrl(struct nvme_ctrl *ctrl)
>   {
>   	unsigned dev_page_min;
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index d880f1ee08d4..adbff23532de 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -189,7 +189,8 @@ enum {
>   
>   enum shutdown_type {
>   	NVME_DISABLE_RESET = 0,
> -	NVME_DISABLE_SHUTDOWN_SYNC = 1
> +	NVME_DISABLE_SHUTDOWN_SYNC = 1,
> +	NVME_DISABLE_SHUTDOWN_ASYNC = 2
>   };
>   
>   static inline struct nvme_request *nvme_req(struct request *req)
> @@ -756,6 +757,7 @@ void nvme_cancel_admin_tagset(struct nvme_ctrl *ctrl);
>   bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
>   		enum nvme_ctrl_state new_state);
>   int nvme_disable_ctrl(struct nvme_ctrl *ctrl, enum shutdown_type shutdown_type);
> +int nvme_wait_for_shutdown_cmpl(struct nvme_ctrl *ctrl);
>   int nvme_enable_ctrl(struct nvme_ctrl *ctrl);
>   int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
>   		const struct nvme_ctrl_ops *ops, unsigned long quirks);
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 77b015affb0b..9cb4436710dd 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2586,7 +2586,7 @@ static void nvme_dev_disable(struct nvme_dev *dev, enum shutdown_type shutdown_t
>   		 * Give the controller a chance to complete all entered requests
>   		 * if doing a safe shutdown.
>   		 */
> -		if (!dead && (shutdown_type == NVME_DISABLE_SHUTDOWN_SYNC))
> +		if (!dead && (shutdown_type != NVME_DISABLE_RESET))
>   			nvme_wait_freeze_timeout(&dev->ctrl, NVME_IO_TIMEOUT);
>   	}
>   
> @@ -3100,7 +3100,26 @@ static void nvme_shutdown(struct pci_dev *pdev)
>   {
>   	struct nvme_dev *dev = pci_get_drvdata(pdev);
>   
> -	nvme_disable_prepare_reset(dev, NVME_DISABLE_SHUTDOWN_SYNC);
> +	nvme_disable_prepare_reset(dev, NVME_DISABLE_SHUTDOWN_ASYNC);
> +}
> +
> +static void nvme_shutdown_wait(struct pci_dev *pdev)
> +{
> +	struct nvme_dev *dev = pci_get_drvdata(pdev);
> +
> +	mutex_lock(&dev->shutdown_lock);
> +	nvme_wait_for_shutdown_cmpl(&dev->ctrl);

If this is the only call-site? why not just open-code it here?

> +
> +	/*
> +	 * The driver will not be starting up queues again if shutting down so
> +	 * must flush all entered requests to their failed completion to avoid
> +	 * deadlocking blk-mq hot-cpu notifier.
> +	 */
> +	nvme_unquiesce_io_queues(&dev->ctrl);
> +	if (dev->ctrl.admin_q && !blk_queue_dying(dev->ctrl.admin_q))
> +		nvme_unquiesce_admin_queue(&dev->ctrl);
> +
> +	mutex_unlock(&dev->shutdown_lock);
>   }
>   
>   /*
> @@ -3492,6 +3511,7 @@ static struct pci_driver nvme_driver = {
>   	.probe		= nvme_probe,
>   	.remove		= nvme_remove,
>   	.shutdown	= nvme_shutdown,
> +	.shutdown_wait  = nvme_shutdown_wait,
>   	.driver		= {
>   		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
>   #ifdef CONFIG_PM_SLEEP

