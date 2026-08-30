Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 186B8C61DE8
	for <linux-nvme@archiver.kernel.org>; Sun, 30 Aug 2026 22:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VP9Zagw5VoD6qq7csm1mPz96FCjjD0yXgAUiYmmOORQ=; b=3pRhFLfyljJKsfna82jZaIJm3D
	CgVhQLuNIxrnf1CYA+iPsHibcZ1sEABz9/IJIZ1+D1MVFpu7gleW2mUxWEuO0O5ceC/1fUj7qCqpx
	CbHW97dGyp+dCJDbMyCIuVmHH633JgMziRH0elnfTJWD9iXOXUi2LdeWzgzgod0naVsCMfhBIyBfc
	6Mcy2YluGAyh4LDHd1/u8zAV6YleQYYI8NmIt3GY0+sbetwbKTE3i9guUGH3/cA4A1Mve/cuadMhm
	rZ2rTkumddL+rEGdaoygthTCkTEQRcITJqG3nrYQzBEKuPPRIUXyV75jX4zxf8DZPod7eZCl2VmZu
	bWoI870Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x0naF-000000089Mg-3dvn;
	Sun, 30 Aug 2026 22:00:59 +0000
Received: from mail-wm1-f52.google.com ([209.85.128.52])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x0naD-000000089MM-11xx
	for linux-nvme@lists.infradead.org;
	Sun, 30 Aug 2026 22:00:58 +0000
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-49cca4ffdcfso12656625e9.0
        for <linux-nvme@lists.infradead.org>; Sun, 30 Aug 2026 15:00:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788127255; x=1788732055;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VP9Zagw5VoD6qq7csm1mPz96FCjjD0yXgAUiYmmOORQ=;
        b=HnSBAr1SjGDjU6F+r8kI3u+S4c1aQcXG9cV13JcekYLah75e1oVRtQstY75ieV6UaA
         y5Re/eAnJJXRfnMfA8ZtuE0zJB5neZXuHeQskGnr743CIT6OOGB4PHt1YOBuhfyyPuyw
         Ytz0/zH811zqQpYCWtrLbmr9NeizS8w9B13IamK0O0S1xeJDRna2/LXwDoeERjjkoz9l
         HtLPfrHT6BMz5t+eLcVKXDrZtSuT6RuPqfWrvvKwe+D9CZJFY4K77Or7CVdUl04tupjL
         CciZQ+s9br+Z6YT3bP5bIR8rwBzDKMJRcRkk/2RJhQZe8391+KQ9S+KmhRN1pmYOyqvR
         W1BA==
X-Gm-Message-State: AFuF++mcuuN4FHTuKD8q7/K9lSSY0lP6vSKdiTws37T0KHQtEP30Shjm
	DQVrbu+WzbFwZ2KJ4jN/5bgtYNWcQ/OA2SdamUyL4v7pKpCknq/zJlWY
X-Gm-Gg: AR+sD10ymVxkRNRK71Ueu6beOsqVBOOXXujC9NqUHjd1X6M0ocrBHEpJzETLlnO1lXB
	kn8cEQuweq0FhvCcUhYk1kvX2/xvi7Rz+O1txtfoHr/AdIsR9WNWn0Q1mD0RIeGRvkqoDhNuB35
	VT2YpT3z3H8boe3VaCEKvRUYLV1taUk/o1hGqCoNQ9oCdkbjxD9NxRV3kVxo7BflSWtfvw9OpOs
	YnHrrEt5YhPR7hur5d4vxe4BLs3KIQ0L9vSOiJMdKT347Ja6h9+u+3psd3DU6MPiZ2CgwLrWVsu
	Bu2Pfmf8hbnMhVfRtfJTi9MGO+Ddp37QCRSrG/tq+9C4hWucWckZfzmmivi0siwxvw0l1EU0TP7
	9FzJrxRK3f+ayHmTiMCrIXCI+bdpaU4YNsWnD3w6KMU8WCn9oSc30zdprByrUM1hqo1jRXI5eLv
	QA9J755ngFCI1ygIBzWl7QJk0ApFLcsHqUGvmvRiQmH4jjXCouIeAsw/R4nvTA0g8OXv4tm2Dvb
	1OzghoAuF8t9kU/gcXB+l9UhOx2UAOh
X-Received: by 2002:a05:600c:6088:b0:49b:2796:be30 with SMTP id 5b1f17b1804b1-49b91c433a4mr343856725e9.11.1788127255220;
        Sun, 30 Aug 2026 15:00:55 -0700 (PDT)
Received: from [10.100.102.74] (89-138-77-243.bb.netvision.net.il. [89.138.77.243])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cd2e9d9fcsm136655095e9.1.2026.08.30.15.00.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Aug 2026 15:00:53 -0700 (PDT)
Message-ID: <c98fe50c-172a-4e53-a30c-5416c40cb23f@grimberg.me>
Date: Mon, 31 Aug 2026 01:00:52 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] nvme-tcp: parallelize I/O queue allocation and
 startup
To: Surabhi Gogte <sgogte@purestorage.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 mkhalfella@purestorage.com, randyj@purestorage.com, adailey@purestorage.com
References: <20260824225648.316962-1-sgogte@purestorage.com>
 <20260824225648.316962-3-sgogte@purestorage.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20260824225648.316962-3-sgogte@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260830_150057_330726_DB062592 
X-CRM114-Status: GOOD (  29.45  )
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



On 25/08/2026 1:56, Surabhi Gogte wrote:
> Similar to commit 2a8513091d2f ("nvme-rdma: parallelize I/O queue
> allocation and startup"), refactor nvme tcp I/O queue setup to use async
> API, combining allocation and startup into a single parallel operation
> per queue. This reduces connection and reconnection setup time when
> there are delays in establishing connections, which is especially
> important for high-core-count hosts.
>
> Key changes:
> - Use async API to facilitate parallel calls for io queue setup.
> - Add nvme_tcp_setup_ctx for propagating errors from async workers.
> - Remove nvme_tcp_start_io_queues() and __nvme_tcp_alloc_io_queues();
>    their logic is folded into nvme_tcp_setup_io_queues() and
>    nvme_tcp_configure_io_queues().
> - Allocate the io tag set before the queues so that the queue range is
>    known, and only set up the reconnect grow case if the queue count
>    actually increased.
> - Serialize the cpu scan and claim in nvme_tcp_set_queue_io_cpu() with a
>    spinlock, as concurrent callers would otherwise select the same cpu.
>    The per-cpu counters no longer need to be atomics.
> - Use init_net in nvme_tcp_alloc_queue() instead of the namespace of
>    current, which is no longer the connecting task once the allocation
>    runs from a worker. A controller is not guaranteed to be tied to a
>    namespace, as the reconnect and error recovery paths already run from
>    a workqueue in init_net.

Well, I think this is breaking 1be52169c3488ef98582ed553ab35cefa3978817

>
> Testing on a 64-core host with 64 IO-queues shows nvme-tcp connection
> time reduced from 61ms to 11ms.
>
> Signed-off-by: Surabhi Gogte <sgogte@purestorage.com>
> ---
>   drivers/nvme/host/tcp.c | 126 +++++++++++++++++++++++++---------------
>   1 file changed, 80 insertions(+), 46 deletions(-)
>
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 354668ad29ac..30fe4c5abe0b 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -7,6 +7,7 @@
>   #include <linux/module.h>
>   #include <linux/init.h>
>   #include <linux/slab.h>
> +#include <linux/async.h>
>   #include <linux/err.h>
>   #include <linux/crc32.h>
>   #include <linux/nvme-tcp.h>
> @@ -54,7 +55,8 @@ MODULE_PARM_DESC(tls_handshake_timeout,
>   		 "nvme TLS handshake timeout in seconds (default 10)");
>   #endif
>   
> -static atomic_t nvme_tcp_cpu_queues[NR_CPUS];
> +static int nvme_tcp_cpu_queues[NR_CPUS];
> +static DEFINE_SPINLOCK(nvme_tcp_cpu_queues_lock);
>   
>   enum nvme_tcp_send_state {
>   	NVME_TCP_SEND_CMD_PDU = 0,
> @@ -154,6 +156,12 @@ struct nvme_tcp_queue {
>   static DEFINE_MUTEX(nvme_tcp_ctrl_mutex);
>   static LIST_HEAD_GUARDED(nvme_tcp_ctrl_list, nvme_tcp_ctrl_mutex);
>   
> +struct nvme_tcp_setup_ctx {

nvme_tcp_queue_setup_ctx?

> +	struct nvme_ctrl	*ctrl;
> +	int			qid;
> +	int			*err;
> +};
> +
>   struct nvme_tcp_ctrl {
>   	/* read only in the hot path */
>   	struct nvme_tcp_queue	*queues;
> @@ -1718,9 +1726,10 @@ static void nvme_tcp_set_queue_io_cpu(struct nvme_tcp_queue *queue)
>   		goto out;
>   
>   	/* Search for the least used cpu from the mq_map */
> +	spin_lock(&nvme_tcp_cpu_queues_lock);
>   	io_cpu = WORK_CPU_UNBOUND;
>   	for_each_online_cpu(cpu) {
> -		int num_queues = atomic_read(&nvme_tcp_cpu_queues[cpu]);
> +		int num_queues = nvme_tcp_cpu_queues[cpu];
>   
>   		if (mq_map[cpu] != qid)
>   			continue;
> @@ -1731,9 +1740,10 @@ static void nvme_tcp_set_queue_io_cpu(struct nvme_tcp_queue *queue)
>   	}
>   	if (io_cpu != WORK_CPU_UNBOUND) {
>   		queue->io_cpu = io_cpu;
> -		atomic_inc(&nvme_tcp_cpu_queues[io_cpu]);
> +		nvme_tcp_cpu_queues[io_cpu]++;
>   		set_bit(NVME_TCP_Q_IO_CPU_SET, &queue->flags);
>   	}
> +	spin_unlock(&nvme_tcp_cpu_queues_lock);
>   out:
>   	dev_dbg(ctrl->ctrl.device, "queue %d: using cpu %d\n",
>   		qid, queue->io_cpu);
> @@ -1846,7 +1856,7 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
>   		queue->cmnd_capsule_len = sizeof(struct nvme_command) +
>   						NVME_TCP_ADMIN_CCSZ;
>   
> -	ret = sock_create_kern(current->nsproxy->net_ns,
> +	ret = sock_create_kern(&init_net,

I don't think we can just change this...

