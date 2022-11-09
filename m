Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5C1DC433FE
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Nov 2022 02:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fyorhJCTSS6+0hPMlFzpEuVOTIRf/zjd/ug2ks95Ljg=; b=j+1p5QVsXP6PF6bIDcx5t7R1Ae
	oIwn0whHopfRiVyNdZ5iKaVHTJAYMQINeDbNhc9qmxZ3w9lJtlFV29DXO/SJf33QCMZYqsR4sbiho
	miPd/WHC5PuaHFTuU2Vyn1EOo7eRJHuN1Ho952TdKXUKEJaRZe0fi7dBQKneTz/S2UON4+zNFZo9b
	f6W8gIWrmKKd4rFRKD1P80eC2Ker9TVUAhnPberF3EdiWAOmxpRlV7Uk0Pdg3oFi4PJLcD/2JoFjx
	iN7nMFvIw0uOi5yEDJdec7s0IglwYZB6vZ+a9Jh+On8Zlp2IrDc5/CdNDlPZ4iXmqku2E8c5dCEgK
	xJDBqOcQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osbEb-00A6k9-KM; Wed, 09 Nov 2022 02:54:37 +0000
Received: from mail-pg1-f177.google.com ([209.85.215.177])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osbEQ-00A6iL-RW
	for linux-nvme@lists.infradead.org; Wed, 09 Nov 2022 02:54:28 +0000
Received: by mail-pg1-f177.google.com with SMTP id q1so15032132pgl.11
        for <linux-nvme@lists.infradead.org>; Tue, 08 Nov 2022 18:54:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fyorhJCTSS6+0hPMlFzpEuVOTIRf/zjd/ug2ks95Ljg=;
        b=VNWnpLppsdaWEHd//xjoZSb3gicZaBy+Z/M2GjHjvwz53MB/WNS7AUBO/ed6GHXX0r
         VaC4/Mb4gXc+3orCNVId73x7jm4CJmTGVVkSHS5jBeXPyCacFEglebOMnNlUNUMS2I8M
         cn6FTMnZ8V19yWvH6tA+7P0FEVRhEAt1PO4VrmoX88aK21iS04FW8HA1omuAA7x3rLYB
         CwFd/0qZPRAiuqC/S3mxzYvvfuLNXQ2BKi8wEMFrKPRI+QujrGNdjaW8jn7nnzgTm7ma
         QAC393ysKp2PYOHkb93vQDYbUXF1l4waP+aX4Gii1U9CSNvfgXUebkyZDTsMgOx/f/22
         TdYw==
X-Gm-Message-State: ACrzQf11AIAJ0xYoXBwYolb/uOesDwMEBWp0Sir8xHRRirbPxKCWstq5
	OJh2FsYqwv+pBJSbF2O9HVg=
X-Google-Smtp-Source: AMsMyM4prXtxl5s44uI/6xJLoeTZiIab88g/7ZFG+phWqVdgqrZxR8gRhNLQ5JxArDib8u7lOPzCUg==
X-Received: by 2002:a63:d60e:0:b0:46f:8979:30ba with SMTP id q14-20020a63d60e000000b0046f897930bamr47702265pgg.332.1667962460883;
        Tue, 08 Nov 2022 18:54:20 -0800 (PST)
Received: from [172.20.3.206] (69-170-33-158.static-ip.telepacific.net. [69.170.33.158])
        by smtp.gmail.com with ESMTPSA id ij26-20020a170902ab5a00b0017f6c9622b9sm7627594plb.183.2022.11.08.18.54.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Nov 2022 18:54:20 -0800 (PST)
Message-ID: <65f5d26b-b0af-f9c6-e77c-e82ac969e9f9@grimberg.me>
Date: Wed, 9 Nov 2022 04:54:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: nvme-pci: NULL pointer dereference in nvme_dev_disable() on
 linux-next
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Gerd Bayer <gbayer@linux.ibm.com>
Cc: Jens Axboe <axboe@fb.com>, Niklas Schnelle <schnelle@linux.ibm.com>,
 linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <fad4d2d5e24eabe1a4fcab75c5d080a6229dc88b.camel@linux.ibm.com>
 <20221108074846.GA22674@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221108074846.GA22674@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221108_185426_921165_7DA7B824 
X-CRM114-Status: GOOD (  14.19  )
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


> Below is the minimal fix.  I'll see if I sort out the mess that is
> probe/reset failure vs ->remove a bit better, though.
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index f94b05c585cbc..577bacdcfee08 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -5160,6 +5160,8 @@ EXPORT_SYMBOL_GPL(nvme_start_freeze);
>   
>   void nvme_stop_queues(struct nvme_ctrl *ctrl)
>   {
> +	if (!ctrl->tagset)
> +		return;
>   	if (!test_and_set_bit(NVME_CTRL_STOPPED, &ctrl->flags))
>   		blk_mq_quiesce_tagset(ctrl->tagset);
>   	else
> @@ -5169,6 +5171,8 @@ EXPORT_SYMBOL_GPL(nvme_stop_queues);
>   
>   void nvme_start_queues(struct nvme_ctrl *ctrl)
>   {
> +	if (!ctrl->tagset)
> +		return;
>   	if (test_and_clear_bit(NVME_CTRL_STOPPED, &ctrl->flags))
>   		blk_mq_unquiesce_tagset(ctrl->tagset);
>   }

Can we do that in the pci driver and not here?

