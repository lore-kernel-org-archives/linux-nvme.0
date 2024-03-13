Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ADFAC54791
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Mar 2024 09:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0LrhKiFFa243S9pGQsqrFwvvyDwPRCSO43o+8ovrLxA=; b=U1MRMsDC4uKa+kbtJX6XfUESTP
	tXGF4qynv9R4begr5ShR51wLjaSh3dUzKVOv+/y2GTV9kkFFM+eChJFA/p/8W0sOXTr+flGEEEetc
	YAZIpTyfLSz11RVqtZwg+t53DkyR57nIHjnwp6Z2IkdFEAinNq3oOwdukTu2NUQY3VnvSzknq3491
	1/JuhhV6Dz4k+mUwTOl82JS9bfwcpPABCh9MJzT4uEY2neIcUkGO10HHRAwIMU4qOILCuPkU80dZS
	e6MQqOhW3TOttMzfy8LaqVl2klHngz7ibocMqlEMuD9FaG6azNvoBR/FmJWTcsD74zk0slZg80Cg5
	zJaDU4AQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rkLCo-00000009Y7i-3Ad9;
	Wed, 13 Mar 2024 09:47:26 +0000
Received: from mail-lj1-f178.google.com ([209.85.208.178])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rkLCl-00000009Y6d-1LxA
	for linux-nvme@lists.infradead.org;
	Wed, 13 Mar 2024 09:47:24 +0000
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d2c8c1b76cso18336961fa.1
        for <linux-nvme@lists.infradead.org>; Wed, 13 Mar 2024 02:47:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710323238; x=1710928038;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0LrhKiFFa243S9pGQsqrFwvvyDwPRCSO43o+8ovrLxA=;
        b=HydtMF+19xDPlxl+cqjIYAAcFqdAyNbEUxRy72m4eOBukmB/XCgR6HNZBKRQlmWvmi
         tAG/X6NH5H5Kuz7uiCl6Ci4m+UkpjEIYCtrX04irvjYpZm44HMz755uQP9PC8jXwq08k
         duf05pD1f0DWOvzbHHZUsainEutJkOGxJd3IVZEjgCbCDkopGtj8VI7XiIMaCyfJFucs
         k7YEV/fRFTQDOUU5UsUZikrA+uqPLdOks0gVib8EQhkpoOwAJkU8i8z+hSCtlHHqizji
         LHwTW4hJw9dwfOSvqZr95KaDWIRLJIM9SCXL9a6CH9465wOycCE2dwMbrIbVCyAkd2Bz
         kXow==
X-Forwarded-Encrypted: i=1; AJvYcCVTyOejIbgo/hPbc0uTRk+7Xmsw4y4vebZNwEJuS6sTxCp6CXeUdK2ElittZG/kGTrDCGaESJddhWk0pPsYIo0VczLmMd8IduDXFVqmALM=
X-Gm-Message-State: AOJu0YxIND/PDLHbS8nBGrB/TM+1RD55++MIUMhzX1clGEMH3Ig8mxUP
	YwssYhGm/QQQOinfHV6aI4Y1rFiWRKPbEW6ZEqr3uqG08kHytTS6
X-Google-Smtp-Source: AGHT+IEFTZC4JCzPH+tjfdu5yGUCVD+jd3p4/hhDUFeaMkOCSaJjo4yWaw8ik7D3BXtmyXgYfWvWZQ==
X-Received: by 2002:a2e:a405:0:b0:2d2:40cb:54e3 with SMTP id p5-20020a2ea405000000b002d240cb54e3mr856558ljn.2.1710323237726;
        Wed, 13 Mar 2024 02:47:17 -0700 (PDT)
Received: from [10.50.4.153] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id n7-20020a05600c3b8700b00413ea3db648sm1323839wms.26.2024.03.13.02.47.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Mar 2024 02:47:17 -0700 (PDT)
Message-ID: <fc352d23-06e0-4f24-b220-fb87a229eec7@grimberg.me>
Date: Wed, 13 Mar 2024 11:47:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme/tcp: Add wq_unbound modparam for nvme_tcp_wq
Content-Language: he-IL, en-US
To: Li Feng <fengli@smartx.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
Cc: Anton.Gavriliuk@hpe.ua
References: <20240313085531.617633-1-fengli@smartx.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240313085531.617633-1-fengli@smartx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240313_024723_404252_DE959184 
X-CRM114-Status: GOOD (  22.43  )
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



On 13/03/2024 10:55, Li Feng wrote:
> The default nvme_tcp_wq will use all CPUs to process tasks. Sometimes it is
> necessary to set CPU affinity to improve performance.
>
> A new module parameter wq_unbound is added here. If set to true, users can
> configure cpu affinity through
> /sys/devices/virtual/workqueue/nvme_tcp_wq/cpumask.
>
> Signed-off-by: Li Feng <fengli@smartx.com>
> ---
>   drivers/nvme/host/tcp.c | 21 ++++++++++++++++++---
>   1 file changed, 18 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index a6d596e05602..5eaa275f436f 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -36,6 +36,14 @@ static int so_priority;
>   module_param(so_priority, int, 0644);
>   MODULE_PARM_DESC(so_priority, "nvme tcp socket optimize priority");
>   
> +/*
> + * Use the unbound workqueue for nvme_tcp_wq, then we can set the cpu affinity
> + * from sysfs.
> + */
> +static bool wq_unbound;
> +module_param(wq_unbound, bool, 0644);
> +MODULE_PARM_DESC(wq_unbound, "set unbound flag for nvme tcp work queue");

"Use unbound workqueue for nvme-tcp IO context (default false)"

> +
>   /*
>    * TLS handshake timeout
>    */
> @@ -1551,7 +1559,10 @@ static void nvme_tcp_set_queue_io_cpu(struct nvme_tcp_queue *queue)
>   	else if (nvme_tcp_poll_queue(queue))
>   		n = qid - ctrl->io_queues[HCTX_TYPE_DEFAULT] -
>   				ctrl->io_queues[HCTX_TYPE_READ] - 1;
> -	queue->io_cpu = cpumask_next_wrap(n - 1, cpu_online_mask, -1, false);
> +	if (wq_unbound)
> +		queue->io_cpu = WORK_CPU_UNBOUND;
> +	else
> +		queue->io_cpu = cpumask_next_wrap(n - 1, cpu_online_mask, -1, false);
>   }
>   
>   static void nvme_tcp_tls_done(void *data, int status, key_serial_t pskid)
> @@ -2790,6 +2801,8 @@ static struct nvmf_transport_ops nvme_tcp_transport = {
>   
>   static int __init nvme_tcp_init_module(void)
>   {
> +	unsigned int wq_flags = WQ_MEM_RECLAIM | WQ_HIGHPRI;
> +
>   	BUILD_BUG_ON(sizeof(struct nvme_tcp_hdr) != 8);
>   	BUILD_BUG_ON(sizeof(struct nvme_tcp_cmd_pdu) != 72);
>   	BUILD_BUG_ON(sizeof(struct nvme_tcp_data_pdu) != 24);
> @@ -2799,8 +2812,10 @@ static int __init nvme_tcp_init_module(void)
>   	BUILD_BUG_ON(sizeof(struct nvme_tcp_icresp_pdu) != 128);
>   	BUILD_BUG_ON(sizeof(struct nvme_tcp_term_pdu) != 24);
>   
> -	nvme_tcp_wq = alloc_workqueue("nvme_tcp_wq",
> -			WQ_MEM_RECLAIM | WQ_HIGHPRI, 0);
> +	if (wq_unbound)
> +		wq_flags |= WQ_UNBOUND | WQ_SYSFS;

I think we should have WQ_SYSFS exposed always. Add it in a seperate patch
that comes before this.

> +
> +	nvme_tcp_wq = alloc_workqueue("nvme_tcp_wq", wq_flags, 0);
>   	if (!nvme_tcp_wq)
>   		return -ENOMEM;
>   


