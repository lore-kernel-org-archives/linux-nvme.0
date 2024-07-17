Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E434EC3DA5D
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Jul 2024 21:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ICbxNWFhdHxqR5hL1D+ilDJ0DvHbmoL13sa2BufyL4Y=; b=ynBDwbhRUwIvUi1ygg54i7i9ty
	ouq9SdzXqKIuMkPjuEGoPqcOJIsqlBLwrkwZkAcrOvD0+wmkmXvMmdYFsyRSDhZFSlWpKjnGsGmLj
	OPUDKhb/ex/YHcmQqTk6lwaVLfMp0uscgQ/Dvd4NqzL9CgbDAtjPAg952F0a+A4bhBkX+1dQEbmxR
	sNmsysUbN1fjq8BAZYKsegUe9I0MgErmIpuWIMV7DrmMrl+mj9w3HHmHH4s2IHIbPfJ/2thw+LqoE
	xzBvZphQYJtWUaoQxgjrOaeIjyWJPyEIgdFaBNt7h7t9dHa3+R2N6jF8V2MAvogB/UkREUnZ6R6oU
	T6Wz4wmg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUBo8-0000000EuuG-1XqR;
	Wed, 17 Jul 2024 21:03:28 +0000
Received: from mail-wr1-f48.google.com ([209.85.221.48])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUBo5-0000000EutY-3cwF
	for linux-nvme@lists.infradead.org;
	Wed, 17 Jul 2024 21:03:27 +0000
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3684e2d0d8bso3145f8f.2
        for <linux-nvme@lists.infradead.org>; Wed, 17 Jul 2024 14:03:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721250204; x=1721855004;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ICbxNWFhdHxqR5hL1D+ilDJ0DvHbmoL13sa2BufyL4Y=;
        b=hSRHe0RRfpO8Fh2F2Dlyhreof65q+5Nkjte8ceTMQf8X1kVai8TW8qTYnCJXUSsWbp
         AlVvXlCfObN8pkmbrQPPKIYzIaEDhj9HnQeFlrzqkirSK/VX4ShywoGDIAtW6VHPAsyT
         QNBnkpKRZy1FQ7Iqzy03LxVNdWiQZMkhRrhsu88PSfsZohgEE4gxdyz+w6O7Crg81D3l
         iQoct8f9//Kh6IsTx1aIZQqfLSbzd5OGQXklrfgqPtmdjDpI3c29XpXFgprR3VO/s6z8
         ZRS9rNaBLlqpREYuoC/ik3jII4w90fX/qQciqJvtlS+cVElK2LD3IPlzo1CRDrZsVcx7
         ypxg==
X-Forwarded-Encrypted: i=1; AJvYcCVidAXWs3pt9aqXcXH4XE07at/sdGlqS0eEJxLxDqyrmnz70mrVE4zjeYsBYQeMma51u9m0oDkwX9LJU1n+4T65uGwZuctcdteSEFGLuk4=
X-Gm-Message-State: AOJu0Yx93My1aCagqendnIt0vMCsZUmbrZ0VRHP8KWjJJbpEvLGWA1hf
	fD2NTit78icDQkmerQ/czRVJQpSjHR3i0aRTaVPFOvqVZzwIzkxw
X-Google-Smtp-Source: AGHT+IHBshIMW+PEifjwRBOyxK8Ix6qww9p4jnGK5AYW8YhDaTC4PHpd1tvXh0KLF9GA7TpIEopAzQ==
X-Received: by 2002:a05:6000:1543:b0:366:eb60:bd12 with SMTP id ffacd0b85a97d-36831609132mr1059373f8f.3.1721250204010;
        Wed, 17 Jul 2024 14:03:24 -0700 (PDT)
Received: from [10.100.102.74] (85.65.198.251.dynamic.barak-online.net. [85.65.198.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680dab3bd8sm12610111f8f.13.2024.07.17.14.03.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jul 2024 14:03:23 -0700 (PDT)
Message-ID: <f73ab2c4-e273-4da8-9a6e-462b3d2b8ac9@grimberg.me>
Date: Thu, 18 Jul 2024 00:03:22 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] nvme-tcp: switch TX deadline to microseconds and make
 it configurable
To: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20240716073616.84417-1-hare@kernel.org>
 <20240716073616.84417-2-hare@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240716073616.84417-2-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240717_140325_937790_4D9873B3 
X-CRM114-Status: GOOD (  18.19  )
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



On 16/07/2024 10:36, Hannes Reinecke wrote:
> The current TX deadline for the workqueue is pretty much arbitrary,
> and jiffies is not the best choice for sub-microseconds granularity.
> So make the deadline configurable via a config option and switch to
> ktime instead of jiffies.

I thought we agreed on bytes based limits. Did you try to look how does
that behave?

>
> Signed-off-by: Hannes Reinecke <hare@kernel.org>
> ---
>   drivers/nvme/host/tcp.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 0873b3949355..3cf9a9abb0e0 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -44,6 +44,10 @@ static bool wq_unbound;
>   module_param(wq_unbound, bool, 0644);
>   MODULE_PARM_DESC(wq_unbound, "Use unbound workqueue for nvme-tcp IO context (default false)");
>   
> +static int deadline = 1000;
> +module_param(deadline, int, 0644);
> +MODULE_PARM_DESC(deadline, "RX/TX deadline in microseconds (default: 1000)");
> +
>   /*
>    * TLS handshake timeout
>    */
> @@ -1278,7 +1282,8 @@ static void nvme_tcp_io_work(struct work_struct *w)
>   {
>   	struct nvme_tcp_queue *queue =
>   		container_of(w, struct nvme_tcp_queue, io_work);
> -	unsigned long deadline = jiffies + msecs_to_jiffies(1);
> +	u64 start = ktime_to_us(ktime_get());
> +	u64 tx_deadline = start + deadline;
>   
>   	do {
>   		bool pending = false;
> @@ -1302,7 +1307,7 @@ static void nvme_tcp_io_work(struct work_struct *w)
>   		if (!pending || !queue->rd_enabled)
>   			return;
>   
> -	} while (!time_after(jiffies, deadline)); /* quota is exhausted */
> +	} while (ktime_to_us(ktime_get()) < tx_deadline); /* quota is exhausted */
>   
>   	queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
>   }

The rename to tx_deadline does not make sense in the context of this patch.

