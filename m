Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E014FC47DDF
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Jan 2024 11:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YKFTwlxYDP9kqUgsrg0fQBurlimofPJvkImDgxfjBok=; b=OgUQOg7hkeOxEU1ss7m0GdqLRP
	DEqZH6IuMWleVDzzLOLIH3NhmIls85PtDCwmCV9Q8V8ENvwaZ6nh96RBzyxoz1kUSSbDt/D941B3+
	nyrZfb3oQBNUpsGx5OOOnVsUTBdxg7EibKKto/OurSuzX3/MmI1UBYfZtl8SivbFBhhGAwJm8kZDm
	w7cKEWonTaG1ktlh+ayiAa7CRl4JZdhA3VSawwOAzXM/5Uc1msOLwT728KVmLHEw7NGATyNJ2H4my
	0ENJEa36qeVM4eKqrLs6bZJTIAyB01plT0iO1EXbeWSW2eIvshMyAe/PohwZHWZsUKK6PCasWHPDe
	Y5snaTBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUm6K-0000000GNwB-2BxP;
	Tue, 30 Jan 2024 11:16:24 +0000
Received: from mail-lf1-f52.google.com ([209.85.167.52])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUm5l-0000000GNnf-2qIO
	for linux-nvme@lists.infradead.org;
	Tue, 30 Jan 2024 11:15:56 +0000
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-51116df27b9so301709e87.1
        for <linux-nvme@lists.infradead.org>; Tue, 30 Jan 2024 03:15:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706613347; x=1707218147;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YKFTwlxYDP9kqUgsrg0fQBurlimofPJvkImDgxfjBok=;
        b=B6mNW0vvYLeiAUqk0PhDStj+ZM65keX1CDzWTrt6ZchJj84zUSUmuLV1CoMhHf3fRb
         QnIaUShHP0vkqrTWPvN6w0iCTvRbW4A7r0EghaLKgJzDQcNnWrmUyMXmwDdKZoW1i2K7
         D4M2hOxn6nxSRWH0IhDakS8voDnl9pZXnqZMK8GxOcoZao1lg4MlQUVBpQJSSsY1AovC
         zgorPm5OGF71hLDayE/Am8GKEV+h1Nt6itTM9v5W6ZVQgXvjC5wxk7Owys5b4PnHKivr
         w/DwesUXF/y/glRre2tGYraUWoLQTAlAqXJrwCj4c9DAws/VXDabYwWCh6O99SAMYMUy
         skWQ==
X-Gm-Message-State: AOJu0YzTmGrKd7XgqF5y6Qt8RtVdcud1InMvWKRSr85w0sdKUqeCbW5M
	m5yqgTFEq/cJ1zLF8WGSuM3aPlkIf3CipN6WZruWhoSRUmDkvbZs
X-Google-Smtp-Source: AGHT+IEU6GUh2/5WKJMKOMPzP7yHOkW+SVuqKSyXKGL1m4K3ymVYjsc8lKvV1IwlQRFYTmj40Apmag==
X-Received: by 2002:a19:9146:0:b0:510:183c:3b67 with SMTP id y6-20020a199146000000b00510183c3b67mr5449920lfj.6.1706613346413;
        Tue, 30 Jan 2024 03:15:46 -0800 (PST)
Received: from [192.168.64.172] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id r6-20020adfca86000000b0033aed7423e8sm5183914wrh.11.2024.01.30.03.15.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 03:15:46 -0800 (PST)
Message-ID: <2639d18a-0cfd-4449-8caa-4d363c788d64@grimberg.me>
Date: Tue, 30 Jan 2024 13:15:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] nvme: Add two-pass shutdown support.
Content-Language: en-US
To: Jeremy Allison <jallison@ciq.com>, jra@samba.org, tansuresh@google.com,
 hch@lst.de, gregkh@linuxfoundation.org, rafael@kernel.org,
 bhelgaas@google.com
Cc: linux-nvme@lists.infradead.org
References: <20240129181953.1183084-1-jallison@ciq.com>
 <20240129181953.1183084-6-jallison@ciq.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240129181953.1183084-6-jallison@ciq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240130_031549_887499_700BA445 
X-CRM114-Status: GOOD (  31.06  )
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


> This works with the two-pass shutdown mechanism setup for the PCI
> drivers and participates to provide the shutdown_wait
> method at the pci_driver structure level.
> 
> This patch changes the nvme shutdown() method to pass
> down the NVME_PCI_DISABLE_SHUTDOWN_TWOPASS enum value instead
> of NVME_PCI_DISABLE_SHUTDOWN. nvme_dev_disable() is changed
> to call nvme_request_shutdown() instead of nvme_disable_ctrl()
> in this case.
> 
> nvme_request_shutdown() sets the shutdown bit,
> but does not wait for completion.
> 
> The nvme_shutdown_wait() callback is added to synchronously
> wait for the NVME_CSTS_SHST_CMPLT bit meaning the nvme
> device has shutdown.
> 
> This change speeds up the shutdown in a system which hosts
> many controllers.
> 
> Based on work by Tanjore Suresh <tansuresh@google.com>
> 
> Signed-off-by: Jeremy Allison <jallison@ciq.com>
> ---
>   drivers/nvme/host/pci.c | 39 ++++++++++++++++++++++++++++++++++++---
>   1 file changed, 36 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 8ee77f755d9d..bbd89eecf05a 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2607,7 +2607,14 @@ static void nvme_dev_disable(struct nvme_dev *dev,
>   
>   	if (!dead && dev->ctrl.queue_count > 0) {
>   		nvme_delete_io_queues(dev);
> -		nvme_disable_ctrl(&dev->ctrl, shutdown);
> +		/*
> +		 * NVME_PCI_DISABLE_SHUTDOWN_TWOPASS requests shutdown
> +		 * but doesn't wait for completion.
> +		 */
> +		if (shutdown_type == NVME_PCI_DISABLE_SHUTDOWN_TWOPASS)
> +			nvme_request_shutdown(&dev->ctrl);
> +		else
> +			nvme_disable_ctrl(&dev->ctrl, shutdown);
>   		nvme_poll_irqdisable(&dev->queues[0]);
>   	}
>   	nvme_suspend_io_queues(dev);
> @@ -2625,7 +2632,7 @@ static void nvme_dev_disable(struct nvme_dev *dev,
>   	 * must flush all entered requests to their failed completion to avoid
>   	 * deadlocking blk-mq hot-cpu notifier.
>   	 */
> -	if (shutdown) {
> +	if (shutdown_type == NVME_PCI_DISABLE_SHUTDOWN) {
>   		nvme_unquiesce_io_queues(&dev->ctrl);
>   		if (dev->ctrl.admin_q && !blk_queue_dying(dev->ctrl.admin_q))
>   			nvme_unquiesce_admin_queue(&dev->ctrl);
> @@ -3128,7 +3135,32 @@ static void nvme_shutdown(struct pci_dev *pdev)
>   {
>   	struct nvme_dev *dev = pci_get_drvdata(pdev);
>   
> -	nvme_disable_prepare_reset(dev, NVME_PCI_DISABLE_SHUTDOWN);
> +	nvme_disable_prepare_reset(dev, NVME_PCI_DISABLE_SHUTDOWN_TWOPASS);
> +}
> +
> +static void nvme_shutdown_wait(struct pci_dev *pdev)
> +{
> +	struct nvme_dev *dev = pci_get_drvdata(pdev);
> +
> +	mutex_lock(&dev->shutdown_lock);

General question that just came up, is there any risk here that the
shutdown_lock is released and re-taken later while the shutdown is still 
in progress? I don't spot anything immediate, but perhaps Keith can
comment?

If this change does expose us to potential issues, you can simply
release the shutdown_lock here (while taking it in ?

> +	/*
> +	 * Finish waiting for the shutdown request
> +	 * initiated in nvme_shutdown() above using
> +	 * NVME_PCI_DISABLE_SHUTDOWN_TWOPASS.
> +	 */
> +	nvme_wait_ready(&dev->ctrl, NVME_CSTS_SHST_MASK,
> +			NVME_CSTS_SHST_CMPLT,
> +			dev->ctrl.shutdown_timeout, "shutdown");
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
> @@ -3522,6 +3554,7 @@ static struct pci_driver nvme_driver = {
>   	.probe		= nvme_probe,
>   	.remove		= nvme_remove,
>   	.shutdown	= nvme_shutdown,
> +	.shutdown_wait	= nvme_shutdown_wait,
>   	.driver		= {
>   		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
>   #ifdef CONFIG_PM_SLEEP

