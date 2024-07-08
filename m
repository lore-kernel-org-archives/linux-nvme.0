Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F571C3271E
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Jul 2024 12:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=skB7AxiGpsgWXbrSJeAcp8WjqQbBjzzk3Tlw7b6IJEU=; b=RZ0wONdkd/MSRSajVWvXfyurej
	pHfEAkapxEdubqHcWkvOMptz3QHs/ewtZgvzOOOSh9HU8fNxKSlfzTja6N0XSr6SV3DTDDUx9vcrN
	efOdy2Sh/uGMUuQFAXV5WHYK1+MnrkKw9KhHhQRF7bkYLFgbaVYO/IQAxSDsfi/ATik612/hlL9BL
	FMv2j1FPGiRbf7+Bgyo3W4SCiRk8AHYHpQRxwzZw/I6OroE8tR8w1nYbKPbpKOh7GAbEQyj7AwxqT
	q4btFgUDcllgnFYOp7Zg0Za3yyQk/9B5n8P+lN6QgQWyHo57X464cBDYFqdL1S/Jby1rpPsihkr+R
	2LzZb3Lg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sQnAO-00000003i9U-0pDC;
	Mon, 08 Jul 2024 12:08:24 +0000
Received: from mail-wm1-f52.google.com ([209.85.128.52])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sQnAL-00000003i8x-2jZk
	for linux-nvme@lists.infradead.org;
	Mon, 08 Jul 2024 12:08:22 +0000
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4266ea4e4bdso285945e9.3
        for <linux-nvme@lists.infradead.org>; Mon, 08 Jul 2024 05:08:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720440500; x=1721045300;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=skB7AxiGpsgWXbrSJeAcp8WjqQbBjzzk3Tlw7b6IJEU=;
        b=Z/b6YqlhuYboiRre+7ye8sOb/adYelehx3HfwX//lu4j3qoKM19XHBRbnjqDcoIPuF
         UToPyvNfZvTCxzNySI0nz9Zv0vhhkQyfEmpDlNiibrO5HOXs6AzgMh06goTBnkZFkQ7G
         fA8t5xKkpa4wSwbS7sklk4Un4iVf5R2rKJDoIQPNfVcXCbvTdKtrO0VqdlIJ4UpqtdmX
         vUsLF+QTvD9Gjq68JtZeADhQrOUDE+x1OOCQfGSqVVhqcWnF99DNpdXU4QBuaAZYaLuA
         vVF1EJsPjqeBI82SDnwwImq227CxhfFMmwZ/gM6c0Ln51AsF8cT7kMNKu2y5FKOHKzAk
         +Qbw==
X-Forwarded-Encrypted: i=1; AJvYcCXFywcoyYF9KjYzhRIiBmEK6/RKMx0AyT/UUSg53ro64livH8jRWfLLTQloscW2JY5Petuf+ahfrfiu25xhTxwa69d3aITZO2igPE13JD4=
X-Gm-Message-State: AOJu0YymvJ/xkBAODujEP1H1FOzSahhiJNwtM3szPbwTREMR1Rzz2uUO
	5+ZUpNAeet7V+QwT/yyV1SC/YC3JSeZlYA8e569lw3Bg/GnpARsuJahuHIRf
X-Google-Smtp-Source: AGHT+IGRDTsqze5rN/DKDQnrhDPQAqLVvBPqfuhsyQrQYMoPrKdS9C/eieYGTAFCCeb6ROxQBx0CQw==
X-Received: by 2002:a05:6000:4023:b0:367:9614:fdf7 with SMTP id ffacd0b85a97d-3679db88ce2mr8253269f8f.0.1720440499607;
        Mon, 08 Jul 2024 05:08:19 -0700 (PDT)
Received: from [10.50.4.202] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36799a54215sm11289011f8f.68.2024.07.08.05.08.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jul 2024 05:08:19 -0700 (PDT)
Message-ID: <a089cc30-fe38-46fe-b953-83a8ada222fd@grimberg.me>
Date: Mon, 8 Jul 2024 15:08:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] nvme-tcp: align I/O cpu with blk-mq mapping
To: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20240708071013.69984-1-hare@kernel.org>
 <20240708071013.69984-3-hare@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240708071013.69984-3-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240708_050821_727253_95A8815B 
X-CRM114-Status: GOOD (  31.16  )
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



On 08/07/2024 10:10, Hannes Reinecke wrote:
> We should align the 'io_cpu' setting with the blk-mq
> cpu mapping to ensure that we're not bouncing threads
> when doing I/O. To avoid cpu contention this patch also
> adds an atomic counter for the number of queues on each
> cpu to distribute the load across all CPUs in the blk-mq cpu set.
> Additionally we should always set the 'io_cpu' value, as
> in the WQ_UNBOUND case it'll be treated as a hint anyway.
>
> Performance comparison:
>                 baseline rx/tx    blk-mq align
> 4k seq write:  449MiB/s 480MiB/s 524MiB/s
> 4k rand write: 410MiB/s 481MiB/s 524MiB/s
> 4k seq read:   478MiB/s 481MiB/s 566MiB/s
> 4k rand read:  547MiB/s 480MiB/s 511MiB/s
>
> Signed-off-by: Hannes Reinecke <hare@kernel.org>
> ---
>   drivers/nvme/host/tcp.c | 65 +++++++++++++++++++++++++++++++----------
>   1 file changed, 49 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index f621d3ba89b2..a5c42a7b4bee 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -26,6 +26,8 @@
>   
>   struct nvme_tcp_queue;
>   
> +static atomic_t nvme_tcp_cpu_queues[NR_CPUS];
> +
>   /* Define the socket priority to use for connections were it is desirable
>    * that the NIC consider performing optimized packet processing or filtering.
>    * A non-zero value being sufficient to indicate general consideration of any
> @@ -1578,20 +1580,42 @@ static bool nvme_tcp_poll_queue(struct nvme_tcp_queue *queue)
>   static void nvme_tcp_set_queue_io_cpu(struct nvme_tcp_queue *queue)
>   {
>   	struct nvme_tcp_ctrl *ctrl = queue->ctrl;
> -	int qid = nvme_tcp_queue_id(queue);
> -	int n = 0;
> -
> -	if (nvme_tcp_default_queue(queue))
> -		n = qid - 1;
> -	else if (nvme_tcp_read_queue(queue))
> -		n = qid - ctrl->io_queues[HCTX_TYPE_DEFAULT] - 1;
> -	else if (nvme_tcp_poll_queue(queue))
> +	struct blk_mq_tag_set *set = &ctrl->tag_set;
> +	int qid = nvme_tcp_queue_id(queue) - 1;

umm, its not the qid, why change it? I mean it looks harmless, but
I don't see why.

> +	unsigned int *mq_map = NULL;;
> +	int n = 0, cpu, io_cpu, min_queues = WORK_CPU_UNBOUND;

min_queues initialization looks very very weird. I can't even parse it.
besides, why is it declared in this scope?

> +
> +	if (nvme_tcp_default_queue(queue)) {
> +		mq_map = set->map[HCTX_TYPE_DEFAULT].mq_map;
> +		n = qid;
> +	} else if (nvme_tcp_read_queue(queue)) {
> +		mq_map = set->map[HCTX_TYPE_READ].mq_map;
> +		n = qid - ctrl->io_queues[HCTX_TYPE_DEFAULT];
> +	} else if (nvme_tcp_poll_queue(queue)) {
> +		mq_map = set->map[HCTX_TYPE_POLL].mq_map;
>   		n = qid - ctrl->io_queues[HCTX_TYPE_DEFAULT] -
> -				ctrl->io_queues[HCTX_TYPE_READ] - 1;
> -	if (wq_unbound)
> -		queue->io_cpu = WORK_CPU_UNBOUND;
> -	else
> -		queue->io_cpu = cpumask_next_wrap(n - 1, cpu_online_mask, -1, false);
> +				ctrl->io_queues[HCTX_TYPE_READ];
> +	}
> +
> +	if (WARN_ON(!mq_map))
> +		return;
> +	for_each_online_cpu(cpu) {
> +		int num_queues;
> +
> +		if (mq_map[cpu] != qid)
> +			continue;
> +		num_queues = atomic_read(&nvme_tcp_cpu_queues[cpu]);
> +		if (num_queues < min_queues) {
> +			min_queues = num_queues;
> +			io_cpu = cpu;
> +		}
> +	}
> +	if (io_cpu != queue->io_cpu) {
> +		queue->io_cpu = io_cpu;
> +		atomic_inc(&nvme_tcp_cpu_queues[io_cpu]);
> +	}

Why is that conditioned ? why not always assign and inc the counter?

> +	dev_dbg(ctrl->ctrl.device, "queue %d: using cpu %d\n",
> +		qid, queue->io_cpu);
>   }
>   
>   static void nvme_tcp_tls_done(void *data, int status, key_serial_t pskid)
> @@ -1735,7 +1759,7 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
>   
>   	queue->sock->sk->sk_allocation = GFP_ATOMIC;
>   	queue->sock->sk->sk_use_task_frag = false;
> -	nvme_tcp_set_queue_io_cpu(queue);
> +	queue->io_cpu = WORK_CPU_UNBOUND;
>   	queue->request = NULL;
>   	queue->data_remaining = 0;
>   	queue->ddgst_remaining = 0;
> @@ -1847,6 +1871,10 @@ static void __nvme_tcp_stop_queue(struct nvme_tcp_queue *queue)
>   	kernel_sock_shutdown(queue->sock, SHUT_RDWR);
>   	nvme_tcp_restore_sock_ops(queue);
>   	cancel_work_sync(&queue->io_work);
> +	if (queue->io_cpu != WORK_CPU_UNBOUND) {
> +		atomic_dec(&nvme_tcp_cpu_queues[queue->io_cpu]);
> +		queue->io_cpu = WORK_CPU_UNBOUND;
> +	}

Does anything change if we still set the io_cpu in wq_unbound case?
If not, I think we should always do it and simplify the code.

>   }
>   
>   static void nvme_tcp_stop_queue(struct nvme_ctrl *nctrl, int qid)
> @@ -1891,9 +1919,10 @@ static int nvme_tcp_start_queue(struct nvme_ctrl *nctrl, int idx)
>   	nvme_tcp_init_recv_ctx(queue);
>   	nvme_tcp_setup_sock_ops(queue);
>   
> -	if (idx)
> +	if (idx) {
> +		nvme_tcp_set_queue_io_cpu(queue);
>   		ret = nvmf_connect_io_queue(nctrl, idx);
> -	else
> +	} else
>   		ret = nvmf_connect_admin_queue(nctrl);
>   
>   	if (!ret) {
> @@ -2920,6 +2949,7 @@ static struct nvmf_transport_ops nvme_tcp_transport = {
>   static int __init nvme_tcp_init_module(void)
>   {
>   	unsigned int wq_flags = WQ_MEM_RECLAIM | WQ_HIGHPRI | WQ_SYSFS;
> +	int cpu;
>   
>   	BUILD_BUG_ON(sizeof(struct nvme_tcp_hdr) != 8);
>   	BUILD_BUG_ON(sizeof(struct nvme_tcp_cmd_pdu) != 72);
> @@ -2937,6 +2967,9 @@ static int __init nvme_tcp_init_module(void)
>   	if (!nvme_tcp_wq)
>   		return -ENOMEM;
>   
> +	for_each_possible_cpu(cpu)
> +		atomic_set(&nvme_tcp_cpu_queues[cpu], 0);
> +

Why?

