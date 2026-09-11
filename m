Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4755C88E53
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Sep 2026 21:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9clTUYcfoxEDLNFpVDjj8fuFA9Sb6BYXsCWxbrtAK80=; b=lHJCqfip6HeuqabUTREL9Y1yjF
	6BI8d5DlTMcCUelsEVzJB7ao+YOF75ENR+xRqyOy2TMngTccsxtZqBpxOf8xvrz316wfIyO7aEYgz
	/gZNfwKmmBltPQtsf8YE232HjEEHJLxrByWF8o0i5C7/tR4E47lAyld9PxTUURZl7rOorixyzw+fG
	V7Ee6zlp5MpHHxWdPUVdwTVu3JZX9krfpMKxGLO97M0+AMyThZ3Lc71Fjch4Yg1xBSia/FG0RgyVM
	MNnL83j171tSFIF/XOTtSaVBiNZvEaOBZD7W81ktct117WDQiDwSya7AxNI2s12rRRPIuNGi91RyQ
	8YKAJsqQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x58mn-00000000B1k-2Kxt;
	Fri, 11 Sep 2026 21:27:53 +0000
Received: from mail-wr2-f12.google.com ([74.125.225.76])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x58mk-00000000B1N-3MMs
	for linux-nvme@lists.infradead.org;
	Fri, 11 Sep 2026 21:27:51 +0000
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-4843cedd129so165476f8f.0
        for <linux-nvme@lists.infradead.org>; Fri, 11 Sep 2026 14:27:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789162068; x=1789766868;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9clTUYcfoxEDLNFpVDjj8fuFA9Sb6BYXsCWxbrtAK80=;
        b=IJP00l0Pxm6EWIAZeQ/79lqu7XPpfLKai0h4W/qAggr8CpTIh46xhaAszdWXhi7RpX
         KEnjFK26n3fRkou4B4xOBAuVr6UNEnAa82+yMB6flkenVpWyZ+qcJMCCLtfKT+5NHVrB
         9UcBn2wC2Y4Xv4WJp4BaUWe56Xef1PBMyqtuvZvYCbBd8m6ODfs+R56L3wix/l2PnmKk
         BZ6rGas60BMBM8BDsWN8Okplf32MrdMDVn2IQyeBPKky3lQMAZkUZrkq6BpZQGoxFAf/
         wvrjeXUhCZ0mPLF5vE2YD47k4xd5vCudAoiedyFIYzletVrLaEtHZlQYoaGYRvjwjamS
         RW3A==
X-Forwarded-Encrypted: i=1; AKwUvBxl6dezXxTxWDDZJzaShSfdxkaHjNw230MQMRe3wPuc0nh+85V1kM1EqjpR/uyrvgzB8b0TQ8Naq2H8@lists.infradead.org
X-Gm-Message-State: AFuF++lmJIQ0pwT7ybybDGWW7mQVVRUFJrAloR4ETrlVN2puRAPdFRZl
	z2OTfX60aN9WQD20s1ogGuOTy+sT1ex66pxQZBMlnkL+MDaaU729kwy8
X-Gm-Gg: AYBFou1Ft2xYnfqdFQQQECopnEECY+fh/49hP3exlGrvSfYZJD8YAU8kuHr2N0qDo4q
	5kDSk7Hmqot5k74tq0j50fmB/e8+uAPXy3m0jLur+tDNLJkXBGxNEQxslR5SWsPrQErf5tEhe+Q
	XcXv0d42wbVRhdrEH6E3+xztogNbqdVH3aB97bt5Q3eRb+t63fMLAJ+UQv47aUGJfoUen90K0Gi
	V6PSQbv/OTMI/tNBwv3t9ngb8gm3qZDM12JBmrJCKCYWDOoDmxw4KaOcfXldliVE8bq0qgESfgK
	We/tW/afgyIpTgUjzd4oCiqgP0xTUnfftqZqp7fzuXH/7Ejgu1mw4Xvz3uHQgIU06/r0FIYNzqX
	jpLbPzIvTz+ms20U1hlW8xlvoAxvFUmPYQIEyB0JOr/YjkWcWJ/pI4kTdjmKE1Q37LiO/eDzsi/
	MxtDSHL3iVInucCvecv1bF778h9+uk2P0fzZcvSRLxFTQQXqbolkU2tSd9viHVtLWkmZ+oUUx2D
	etuYfk7JHdri6OpKHAtakylruQgfHa5
X-Received: by 2002:a05:6000:616:b0:485:b104:6e61 with SMTP id ffacd0b85a97d-486eb339548mr12616545f8f.20.1789162068490;
        Fri, 11 Sep 2026 14:27:48 -0700 (PDT)
Received: from [10.100.102.74] (89-138-77-243.bb.netvision.net.il. [89.138.77.243])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb33ea4fsm8713644f8f.21.2026.09.11.14.27.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2026 14:27:47 -0700 (PDT)
Message-ID: <bec91f99-4498-4be9-bf96-f3021c79f3f1@grimberg.me>
Date: Sat, 12 Sep 2026 00:27:46 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] nvme-tcp: parallelize I/O queue allocation and
 startup
To: Surabhi Gogte <sgogte@purestorage.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Cc: Solganik Alexander <sashas@lightbitslabs.com>,
 Roy Shterman <roys@lightbitslabs.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, mkhalfella@purestorage.com,
 randyj@purestorage.com, adailey@purestorage.com
References: <20260910202812.1642832-1-sgogte@purestorage.com>
 <20260910202812.1642832-4-sgogte@purestorage.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20260910202812.1642832-4-sgogte@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260911_142750_896897_3B844ADA 
X-CRM114-Status: GOOD (  36.10  )
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



On 10/09/2026 23:28, Surabhi Gogte wrote:
> Similar to commit 2a8513091d2f ("nvme-rdma: parallelize I/O queue
> allocation and startup"), refactor nvme tcp I/O queue setup to use async
> API, combining allocation and startup into a single parallel operation
> per queue. This reduces connection and reconnection setup time when
> there are delays in establishing connections, which is especially
> important for high-core-count hosts.
>
> Key changes:
> - Use async API to facilitate parallel calls for io queue setup.
> - Add nvme_tcp_queue_setup_ctx for propagating errors from async
>    workers.
> - Remove nvme_tcp_start_io_queues() and __nvme_tcp_alloc_io_queues();
>    their logic is folded into nvme_tcp_setup_io_queues() and
>    nvme_tcp_configure_io_queues().
> - Allocate the io tag set before the queues so that the queue range is
>    known, and only set up the reconnect grow case if the queue count
>    actually increased.
> - Serialize the cpu scan and claim in nvme_tcp_set_queue_io_cpu() with a
>    spinlock, as concurrent callers would otherwise select the same cpu.
>    The per-cpu counters no longer need to be atomics.
>
> Testing on a 64-core host with 64 IO-queues shows nvme-tcp connection
> time reduced from 61ms to 11ms.
>
> Signed-off-by: Surabhi Gogte <sgogte@purestorage.com>
> ---
>   drivers/nvme/host/tcp.c | 124 +++++++++++++++++++++++++---------------
>   1 file changed, 79 insertions(+), 45 deletions(-)
>
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index fe0e581608b4..0fc244e676f9 100644
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
> +struct nvme_tcp_queue_setup_ctx {
> +	struct nvme_ctrl	*ctrl;
> +	int			qid;
> +	int			*err;
> +};
> +
>   struct nvme_tcp_ctrl {
>   	/* read only in the hot path */
>   	struct nvme_tcp_queue	*queues;
> @@ -1719,9 +1727,10 @@ static void nvme_tcp_set_queue_io_cpu(struct nvme_tcp_queue *queue)
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
> @@ -1732,9 +1741,10 @@ static void nvme_tcp_set_queue_io_cpu(struct nvme_tcp_queue *queue)
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
> @@ -2011,8 +2021,11 @@ static void nvme_tcp_stop_queue_nowait(struct nvme_ctrl *nctrl, int qid)
>   	if (!test_bit(NVME_TCP_Q_ALLOCATED, &queue->flags))
>   		return;
>   
> -	if (test_and_clear_bit(NVME_TCP_Q_IO_CPU_SET, &queue->flags))
> -		atomic_dec(&nvme_tcp_cpu_queues[queue->io_cpu]);
> +	if (test_and_clear_bit(NVME_TCP_Q_IO_CPU_SET, &queue->flags)) {
> +		spin_lock(&nvme_tcp_cpu_queues_lock);
> +		nvme_tcp_cpu_queues[queue->io_cpu]--;
> +		spin_unlock(&nvme_tcp_cpu_queues_lock);
> +	}
>   
>   	mutex_lock(&queue->queue_lock);
>   	if (test_and_clear_bit(NVME_TCP_Q_LIVE, &queue->flags))
> @@ -2119,25 +2132,6 @@ static void nvme_tcp_stop_io_queues(struct nvme_ctrl *ctrl)
>   		nvme_tcp_wait_queue(ctrl, i);
>   }
>   
> -static int nvme_tcp_start_io_queues(struct nvme_ctrl *ctrl,
> -				    int first, int last)
> -{
> -	int i, ret;
> -
> -	for (i = first; i < last; i++) {
> -		ret = nvme_tcp_start_queue(ctrl, i);
> -		if (ret)
> -			goto out_stop_queues;
> -	}
> -
> -	return 0;
> -
> -out_stop_queues:
> -	for (i--; i >= first; i--)
> -		nvme_tcp_stop_queue(ctrl, i);
> -	return ret;
> -}
> -
>   static int nvme_tcp_alloc_admin_queue(struct nvme_ctrl *ctrl)
>   {
>   	int ret;
> @@ -2198,22 +2192,64 @@ static int nvme_tcp_tls_check_psk(struct nvme_ctrl *ctrl)
>   	return 0;
>   }
>   
> -static int __nvme_tcp_alloc_io_queues(struct nvme_ctrl *ctrl)
> +static void nvme_tcp_setup_queue_async(void *data, async_cookie_t cookie)
>   {
> -	int i, ret;
> +	struct nvme_tcp_queue_setup_ctx *ctx = data;
> +	struct nvme_ctrl *ctrl = ctx->ctrl;
> +	int ret;
>   
> -	for (i = 1; i < ctrl->queue_count; i++) {
> -		ret = nvme_tcp_alloc_queue(ctrl, i,
> -				ctrl->tls_pskid);
> -		if (ret)
> -			goto out_free_queues;
> +	ret = nvme_tcp_alloc_queue(ctrl, ctx->qid, ctrl->tls_pskid);
> +	if (ret)
> +		goto out_err;
> +
> +	ret = nvme_tcp_start_queue(ctrl, ctx->qid);
> +	if (ret)
> +		goto out_err;
> +
> +	return;
> +
> +out_err:
> +	WRITE_ONCE(*ctx->err, ret);
> +}
> +
> +static int nvme_tcp_setup_io_queues(struct nvme_ctrl *ctrl, unsigned int first,
> +		unsigned int last)
> +{
> +	ASYNC_DOMAIN_EXCLUSIVE(queue_domain);
> +	struct nvme_tcp_queue_setup_ctx *ctxs;
> +	int nr_queues = last - first;
> +	int err = 0, i, ret;
> +
> +	ctxs = kmalloc_objs(*ctxs, nr_queues);
> +	if (!ctxs)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < nr_queues; i++) {
> +		ctxs[i].ctrl = ctrl;
> +		ctxs[i].qid = first + i;
> +		ctxs[i].err = &err;
> +		async_schedule_domain(nvme_tcp_setup_queue_async, &ctxs[i],
> +				&queue_domain);
>   	}
>   
> +	async_synchronize_full_domain(&queue_domain);
> +	kfree(ctxs);
> +
> +	ret = READ_ONCE(err);
> +	if (ret)
> +		goto out_free_queues;
> +
>   	return 0;
>   
>   out_free_queues:
> -	for (i--; i >= 1; i--)
> -		nvme_tcp_free_queue(ctrl, i);
> +	for (i = first; i < last; i++) {
> +		struct nvme_tcp_queue *queue = &to_tcp_ctrl(ctrl)->queues[i];
> +
> +		if (test_bit(NVME_TCP_Q_LIVE, &queue->flags))
> +			nvme_tcp_stop_queue(ctrl, i);
> +		if (test_bit(NVME_TCP_Q_ALLOCATED, &queue->flags))
> +			nvme_tcp_free_queue(ctrl, i);
> +	}
>   
>   	return ret;
>   }
> @@ -2255,10 +2291,6 @@ static int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
>   	if (ret)
>   		return ret;
>   
> -	ret = __nvme_tcp_alloc_io_queues(ctrl);
> -	if (ret)
> -		return ret;
> -
>   	if (new) {
>   		ret = nvme_alloc_io_tag_set(ctrl, &to_tcp_ctrl(ctrl)->tag_set,
>   				&nvme_tcp_mq_ops,
> @@ -2269,12 +2301,12 @@ static int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
>   	}
>   
>   	/*
> -	 * Only start IO queues for which we have allocated the tagset
> +	 * Only setup IO queues for which we have allocated the tagset
>   	 * and limited it to the available queues. On reconnects, the
>   	 * queue number might have changed.
>   	 */
>   	nr_queues = min(ctrl->tagset->nr_hw_queues + 1, ctrl->queue_count);
> -	ret = nvme_tcp_start_io_queues(ctrl, 1, nr_queues);
> +	ret = nvme_tcp_setup_io_queues(ctrl, 1, nr_queues);
>   	if (ret)
>   		goto out_cleanup_connect_q;
>   
> @@ -2298,12 +2330,14 @@ static int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
>   
>   	/*
>   	 * If the number of queues has increased (reconnect case)
> -	 * start all new queues now.
> +	 * setup all new queues now.
>   	 */
> -	ret = nvme_tcp_start_io_queues(ctrl, nr_queues,
> -				       ctrl->tagset->nr_hw_queues + 1);
> -	if (ret)
> -		goto out_wait_freeze_timed_out;
> +	if (ctrl->tagset->nr_hw_queues + 1 > nr_queues) {
> +		ret = nvme_tcp_setup_io_queues(ctrl, nr_queues,
> +				ctrl->tagset->nr_hw_queues + 1);
> +		if (ret)
> +			goto out_wait_freeze_timed_out;
> +	}

This if condition can probably move into nvme_tcp_setup_io_queues() and 
exit early if both are the same. Other than that, patch looks solid. Can 
you please also run blktests to see that nothing broke. There may be 
some tests that have subtle race conditions. rdma and tcp btw.

