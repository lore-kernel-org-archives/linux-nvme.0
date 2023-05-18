Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E6D3C7EE22
	for <linux-nvme@archiver.kernel.org>; Thu, 18 May 2023 09:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uBIUJy5gb3NA9HYbU6/qFHH1rjHl9BUgBoCMeFBvQug=; b=rtIGrvttY+dv4zaGFfR+4gMJ9j
	x3vyJP/Ex6E24y38zlKJqhfFXHBXQrGlwBcBLWd9wSyvGQVyqzxJMQ8E1XodRF0XZpSvuZ9Won1XZ
	E9nGL+vIJqMuS05/m6y2sQqs1RDjisCS4QFgZgr/WSH7D8TEp6QxDM4iQ7TWKbO1XlsegTCX0AhMc
	SwM5KvZw95ofISiImOgT32T2FccsOHjsFaXR887WvePWtqQ78lJRtdE7guaC5xqr+zqLQlKWljAhD
	v8T2ZG1n62l7Ymk2wiDIala1AuNP3/c8e81lFEXgLiXqwHXy6stfTGh65qa30UIiySUrzcrKFK+DV
	JjmnMvZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pzZW1-00CPKR-2Z;
	Thu, 18 May 2023 09:01:41 +0000
Received: from mail-wr1-f53.google.com ([209.85.221.53])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pzZVz-00CPK1-0Z
	for linux-nvme@lists.infradead.org;
	Thu, 18 May 2023 09:01:40 +0000
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3093aa2f2a5so295643f8f.0
        for <linux-nvme@lists.infradead.org>; Thu, 18 May 2023 02:01:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684400496; x=1686992496;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uBIUJy5gb3NA9HYbU6/qFHH1rjHl9BUgBoCMeFBvQug=;
        b=jwOcCIZYRpg8LzlHd527czhFiTDE4zrmyhj21FZoyMLwES/9I7jafvIxgLk0COeeA9
         dgXaY6dgmS4DTZb7tbekg+r7uv/UP2fRDtxmTt9INfFhyrVn+7U1FC1Xgaeu1fapKt2y
         2eCH8NbY9lMnHKtsQ3zxQKXyLcMiRTEAFByAHDtj1fRKYcTDTdKtFPQ2ht7ozQmLK6FB
         yo0ngiZx5fQOgFg1TO09O82GHqAP4mfct28cMFI2siCD5pue5m5pZTlXur9Wlen4Rh38
         gjCI1Bzire0XzpFGPixOoLB+RwXhCqjwwQ2wV+GLgkIIoFDhM7lfNJSh2Vnw0Mpdwrlc
         76PQ==
X-Gm-Message-State: AC+VfDyPFv7RhISX6O//HYD+kgGkXBz1OdNIUhLrwF8ZaVKDSKkc779E
	lirVNoJzurjfGB+pPqO5f10=
X-Google-Smtp-Source: ACHHUZ4OJ07+a4jZ9LPfeo2JLjqY+vR+7mqcjS65pohJQlxjyPEEHe07qnxW118T8F1KOmiLQYSs8g==
X-Received: by 2002:a05:6000:1812:b0:2fa:b265:a010 with SMTP id m18-20020a056000181200b002fab265a010mr3748649wrh.7.1684400495148;
        Thu, 18 May 2023 02:01:35 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id l2-20020adfe582000000b0030632833e74sm1521984wrm.11.2023.05.18.02.01.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 May 2023 02:01:34 -0700 (PDT)
Message-ID: <4fcc801e-b680-a60b-f7e1-99a59edc5109@grimberg.me>
Date: Thu, 18 May 2023 12:01:33 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 3/3] nvme: improve handling of long keep alives
Content-Language: en-US
To: Uday Shankar <ushankar@purestorage.com>,
 Costa Sapuntzakis <costa@purestorage.com>,
 Randy Jennings <randyj@purestorage.com>, Hannes Reinecke <hare@suse.de>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Jens Axboe <axboe@fb.com>
Cc: linux-nvme@lists.infradead.org
References: <20230424232225.1975793-1-ushankar@purestorage.com>
 <20230424232225.1975793-4-ushankar@purestorage.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230424232225.1975793-4-ushankar@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230518_020139_212821_AF397BA5 
X-CRM114-Status: GOOD (  24.26  )
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


> Upon keep alive completion, nvme_keep_alive_work is scheduled with the
> same delay every time. If keep alive commands are completing slowly,
> this may cause a keep alive timeout. The following trace illustrates the
> issue, taking KATO = 8 and TBKAS off for simplicity:
> 
> 1. t = 0: run nvme_keep_alive_work, send keep alive
> 2. t = ε: keep alive reaches controller, controller restarts its keep
>            alive timer
> 3. t = 4: host receives keep alive completion, schedules
>            nvme_keep_alive_work with delay 4
> 4. t = 8: run nvme_keep_alive_work, send keep alive
> 
> Here, a keep alive having RTT of 4 causes a delay of at least 8 - ε
> between the controller receiving successive keep alives. With ε small,
> the controller is likely to detect a keep alive timeout.
> 
> Fix this by calculating the RTT of the keep alive command, and adjusting
> the scheduling delay of the next keep alive work accordingly.
> 
> Reported-by: Costa Sapuntzakis <costa@purestorage.com>
> Reported-by: Randy Jennings <randyj@purestorage.com>
> Signed-off-by: Uday Shankar <ushankar@purestorage.com>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> ---
>   drivers/nvme/host/core.c | 20 +++++++++++++++++---
>   1 file changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 0215dcf643ef..2028fa050bcf 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1162,10 +1162,15 @@ EXPORT_SYMBOL_NS_GPL(nvme_passthru_end, NVME_TARGET_PASSTHRU);
>    * frequency, as one command completion can postpone sending a keep alive
>    * command by up to twice the delay between runs.
>    */
> +static unsigned long nvme_keep_alive_work_period(struct nvme_ctrl *ctrl)
> +{
> +	return (ctrl->ctratt & NVME_CTRL_ATTR_TBKAS) ?
> +		(ctrl->kato * HZ / 4) : (ctrl->kato * HZ / 2);
> +}
> +
>   static void nvme_queue_keep_alive_work(struct nvme_ctrl *ctrl)
>   {
> -	unsigned long delay = (ctrl->ctratt & NVME_CTRL_ATTR_TBKAS) ?
> -		ctrl->kato * HZ / 4 : ctrl->kato * HZ / 2;
> +	unsigned long delay = nvme_keep_alive_work_period(ctrl);
>   	queue_delayed_work(nvme_wq, &ctrl->ka_work, delay);
>   }
>   
> @@ -1175,6 +1180,15 @@ static enum rq_end_io_ret nvme_keep_alive_end_io(struct request *rq,
>   	struct nvme_ctrl *ctrl = rq->end_io_data;
>   	unsigned long flags;
>   	bool startka = false;
> +	unsigned long rtt = jiffies - nvme_req(rq)->start_time;
> +	unsigned long delay = nvme_keep_alive_work_period(ctrl);
> +
> +	/* Subtract off the keepalive RTT so nvme_keep_alive_work runs
> +	 * at the desired frequency. */
> +	if (rtt <= delay)
> +		delay -= rtt;
> +	else
> +		delay = 0;
This should probably log a warning or something... The controller has
such a slow response time to keep-alive that it exceeds the delay...

