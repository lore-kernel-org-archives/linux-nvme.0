Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27025C61DA4
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Mar 2023 10:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=i7l1pxTV+Inqcu2/f1NXUGpt+oZmzLeqWLNnn+YepKU=; b=2Bx+ZN69sTew/kX1wgCOsJ0c/b
	5jFOVKq2qnl0Zxv3cTB8utcJq5jHk5gfsO8nzV2OLmddIaYPKWRpFtBuyY58JbM+MqFupf5xzYTxN
	lmUBSLEH5YmN8LPpsOADsXiQU1uz6nkWgaeYifAYJ1OaCltpu3MsKHACXxn5Q7P1GaFlvgZZWCIlH
	upqKC1I6dwlXsvIm1k1SnXv5F9/ko9yw+lIdDNRJrvD1T49Id+TvuPnRWPn9OjXQF0Y1uZWzV+rH9
	KAKqRsp4LtKDmqPzyOd9Zc/2e1tmFUm7ODSKBgJN+xPD4TRXgIS57lI8Cs6J9N4K624MQ/vo4sU6F
	xa/GDvig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pcOYv-00D5XZ-1F;
	Wed, 15 Mar 2023 10:40:53 +0000
Received: from mail-wm1-f50.google.com ([209.85.128.50])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pcOYq-00D5Wr-23
	for linux-nvme@lists.infradead.org;
	Wed, 15 Mar 2023 10:40:50 +0000
Received: by mail-wm1-f50.google.com with SMTP id j19-20020a05600c191300b003eb3e1eb0caso781693wmq.1
        for <linux-nvme@lists.infradead.org>; Wed, 15 Mar 2023 03:40:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678876845; x=1681468845;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i7l1pxTV+Inqcu2/f1NXUGpt+oZmzLeqWLNnn+YepKU=;
        b=KjbD8S9WBh2Eb71TS1lE2IYEoBKGbk0KW62yKOnZvU+Zm0+vWW2XSh95fHmuUp/PNj
         1Jd/ZKPpbso81MqgMopx2BDLBH2XfLkH9EmbS/zluTpH08vhWB3yLzINnX7cZNSQ7BkP
         wcQqa3aWxBDEAvD+lvduE1klBAfDnmMf+lfAb7rWiYd8rrgU7xMV+hsZbLxw5bsI+NUk
         eLvloU3BR1vuvAcgYYORJqMsFrHEXlLK20qMGKY5XBkj+vzFO3xeYX6CbmFID+kmPbAK
         QBFeBj1Tn79oQS/gkE+nb5j1yN3TXNiXoU2hMSmO8x/gmS5uUwlN46ep5K7nN4lyriTJ
         ooNw==
X-Gm-Message-State: AO0yUKUuNpSNjXWyyqwOIrDFja6ZPuDhl/onV2bdTA603w5/8TJKbEjc
	cLQGyIaF6QKUWZAiWQ/hS1I=
X-Google-Smtp-Source: AK7set+WUuWyA//zY8PXjGobEOEZWt7yt/uEwkHc4rMpRzZ8veHWf4ro/Ovoyd6g5t57k40JlUVzlA==
X-Received: by 2002:a05:600c:3b9f:b0:3ed:354b:7e4f with SMTP id n31-20020a05600c3b9f00b003ed354b7e4fmr827163wms.0.1678876845207;
        Wed, 15 Mar 2023 03:40:45 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id q7-20020a7bce87000000b003e8dc7a03basm1351575wmj.41.2023.03.15.03.40.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Mar 2023 03:40:44 -0700 (PDT)
Message-ID: <422141ca-53aa-16fd-e29d-9cf7adf4f07d@grimberg.me>
Date: Wed, 15 Mar 2023 12:40:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [RFC PATCH] nvme-tcp: fix possible crash when only partilal
 queues are allocated by nvme_tcp_alloc_queue
To: zhangyanjun@cestc.cn
Cc: kbusch@kernel.org, axboe@fb.com, hch@lst.de,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 xiang.li@cestc.cn, shaopeijie@cestc.cn
References: <20230315094149.2514239-1-zhangyanjun@cestc.cn>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230315094149.2514239-1-zhangyanjun@cestc.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230315_034048_699854_2209C7ED 
X-CRM114-Status: GOOD (  45.05  )
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



On 3/15/23 11:41, zhangyanjun@cestc.cn wrote:
> From: Yanjun Zhang <zhangyanjun@cestc.cn>
> 
> Thanks for your applying and suggestions!
> 
>> Hi Yanjun,
>>
>>> In storage clusters constructed by nvme-tcp driver, we have encountered
>>> the following two kinds of crashes on the host kernel repeatedly.
>>>
>>> one crash info:
>>> [16802.107284] nvme nvme4: starting error recovery
>>> [16802.109166] nvme nvme4: Reconnecting in 10 seconds...
>>> [16812.173535] nvme nvme4: failed to connect socket: -111
>>> [16812.173745] nvme nvme4: Failed reconnect attempt 1
>>> [16812.173747] nvme nvme4: Reconnecting in 10 seconds...
>>> [16822.413555] nvme nvme4: failed to connect socket: -111
>>> [16822.413762] nvme nvme4: Failed reconnect attempt 2
>>> [16822.413765] nvme nvme4: Reconnecting in 10 seconds...
>>> [16832.661274] nvme nvme4: creating 32 I/O queues.
>>> [16833.919887] BUG: kernel NULL pointer dereference, address: 0000000000000088
>>> [16833.920068] nvme nvme4: Failed reconnect attempt 3
>>> [16833.920094] #PF: supervisor write access in kernel mode
>>> [16833.920261] nvme nvme4: Reconnecting in 10 seconds...
>>> [16833.920368] #PF: error_code(0x0002) - not-present page
>>> [16833.920600] PGD a21a12067 P4D b998cf067 PUD c00be5067 PMD 0
>>> [16833.920731] Oops: 0002 [#1] SMP NOPTI
>>> [16833.920852] CPU: 28 PID: 1324 Comm: kworker/28:1H Kdump: loaded Tainted: G S 5.15.67.cl9.x86_64 #1
>>> [16833.920980] Hardware name: Inspur NF5280M6/NF5280M6, BIOS 06.00.04 07/07/2022
>>> [16833.921086] Workqueue: nvme_tcp_wq nvme_tcp_io_work [nvme_tcp]
>>> [16833.921191] RIP: 0010:_raw_spin_lock_bh+0x17/0x30
>>> [16833.921294] Code: ff 66 90 c3 cc cc cc cc 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 65 81 05 f0 ab 35 4a 00 02 00 00 31 c0 ba 01 00 00 00 <f0> 0f b1 17 75 05 c3 cc cc cc cc 89 c6 e8 c7 09 69 ff 66 90 c3 cc
>>> [16833.921539] RSP: 0018:ff5d9770a078fdf8 EFLAGS: 00010246
>>> [16833.921658] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
>>> [16833.921787] RDX: 0000000000000001 RSI: 0000000000000000 RDI: 0000000000000088
>>> [16833.921912] RBP: 0000000000000088 R08: ff4f755fca433f00 R09: ff4f7558374a7874
>>> [16833.922040] R10: 000000000000000c R11: 000000000000000c R12: ff4f7563dbbdad80
>>> [16833.922177] R13: 0000000100fc48f3 R14: ff4f754b6dbfa278 R15: ff8f97707db0b905
>>> [16833.922317] FS: 0000000000000000(0000) GS:ff4f756fccd00000(0000) knlGS:0000000000000000
>>> [16833.922454] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> [16833.922593] CR2: 0000000000000088 CR3: 0000000b8477e002 CR4: 0000000000771ee0
>>> [16833.922731] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>>> [16833.922869] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>>> [16833.923007] PKRU: 55555554
>>> [16833.923138] Call Trace:
>>> [16833.923271] <TASK>
>>> [16833.923402] lock_sock_nested+0x1e/0x50
>>> [16833.923545] nvme_tcp_try_recv+0x40/0xa0 [nvme_tcp]
>>> [16833.923685] nvme_tcp_io_work+0x68/0xa0 [nvme_tcp]
>>> [16833.923824] process_one_work+0x1e8/0x390
>>> [16833.923969] worker_thread+0x53/0x3d0
>>> [16833.924104] ? process_one_work+0x390/0x390
>>> [16833.924240] kthread+0x124/0x150
>>> [16833.924376] ? set_kthread_struct+0x50/0x50
>>> [16833.924518] ret_from_fork+0x1f/0x30
>>> [16833.924655] </TASK>
>>>
>>> By analyzing the vmcore, we confirm the direct cause is sock->sk=NULL
>>> and sock->ops=NULL attached to the struct nvme_tcp_queue. And we found
>>> this issue occurred during the execuation of __nvme_tcp_alloc_io_queues
>>> every time. Such as when nvme_tcp_alloc_queue failed to allocate the
>>> 29th I/O queue, the return flow would free previously allocated 28 I/O
>>> queues, but possibly some io_works attached to these allocated I/O queues
>>> have already been queued.
>>
>> That should not be possible, io_work is only triggered after a queue is
>> started. If io_work is running before the queue is started, we have
>> a wider issue. Did you confirm that the io_work belongs to an io queue
>> and not the admin queue?
> 
> Yes, we think that the io_work belongs to an io_queue by comparing the
> nvme_tcp_queue pointer and queues[] attached to nvme_tcp_ctrl, its qid is
> not zero. The size of struct nvme_tcp_queue in our kernel is 0x130.
> crash> nvme_tcp_queue.sock ff4f754b6dbfa270
>    sock = 0xff4f7563dbbdad80,
> crash> socket.sk 0xff4f7563dbbdad80
>    sk = 0x0,
> crash> socket.ops 0xff4f7563dbbdad80
>    ops = 0x0,
> crash> nvme_tcp_queue.ctrl ff4f754b6dbfa270
>    ctrl = 0xff4f75608c9a6000,
> crash> nvme_tcp_ctrl.queues 0xff4f75608c9a6000
>    queues = 0xff4f754b6dbf8000,
> 
> Obviously, the ff4f754b6dbfa270 which analysized from stack is not
> the admin queue pointer.

ff4f754b6dbfa270 is the sock pointer, not the queue pointer, but I
believe you that it is different from queues.

> And we found that sock attached to the
> 29th I/O queue is NULL, socks attached to other queues are all
> normal kernel addresses. We think it should be dealt with err_sock
> in nvme_tcp_alloc_queue due to some errors.
> 	err_sock:
> 		sock_release(queue->sock);
> 		queue->sock = NULL;
> crash> nvme_tcp_queue.sock ff4f754b6dbfa3a0
>    sock = 0x0,
> crash> nvme_tcp_queue.sock ff4f754b6dbfa4d0
>    sock = 0xff4f75641f4aa700,
>

Makes sense. thanks for confirming.


>>
>>> So we query that directly freeing these allocated
>>> I/O queues may result in this issue. To avoid this issuse, we try to make
>>> the following code modifications, but have not verified to be valid yet
>>> because of the occasionality of this issue.
>>>
>>> Now, we can not confirm the caller of queuing on the io_work during
>>> allocating all the I/O queues, but we doubt that the socket interface
>>> sk_data_ready=nvme_tcp_data_ready initialized by nvme_tcp_alloc_queue
>>> may do this action in this interval. Hope to get some suggestions, Thanks!
>>
>> I would start by determining that the running io_work is an io queue or
>> the admin queue. It is also possible that the admin queue cleanup after
>> we io queues allocation failed is the problematic teardown that is
>> causing this bug.
>>
>>>
>>> Signed-off-by: Yanjun Zhang <zhangyanjun@cestc.cn>
>>> ---
>>> drivers/nvme/host/tcp.c | 7 +++++--
>>> 1 file changed, 5 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
>>> index 9b47dcb2a..5782183b8 100644
>>> --- a/drivers/nvme/host/tcp.c
>>> +++ b/drivers/nvme/host/tcp.c
>>> @@ -1761,6 +1761,7 @@ static int nvme_tcp_alloc_admin_queue(struct nvme_ctrl *ctrl)
>>> static int __nvme_tcp_alloc_io_queues(struct nvme_ctrl *ctrl)
>>> {
>>> 	int i, ret;
>>> + 	struct nvme_tcp_ctrl *tcp_ctrl = NULL;
>>>
>>> 	for (i = 1; i < ctrl->queue_count; i++) {
>>> 		ret = nvme_tcp_alloc_queue(ctrl, i);
>>> @@ -1771,9 +1772,11 @@ static int __nvme_tcp_alloc_io_queues(struct nvme_ctrl *ctrl)
>>> 	return 0;
>>>
>>> 	out_free_queues:
>>> -	for (i--; i >= 1; i--)
>>> +	for (i--; i >= 1; i--) {
>>> +		tcp_ctrl = to_tcp_ctrl(ctrl);
>>> +		__nvme_tcp_stop_queue(&tcp_ctrl->queues[i]);
>>> 		nvme_tcp_free_queue(ctrl, i);
>>> -
>>> +	}
>>> 	return ret;
>>> }
>>>
>>
>> The crash dump reminds me of a reported issue fixed by:
>> 160f3549a907 ("nvme-tcp: fix UAF when detecting digest errors")
>>
>> Is this applied in your host kernel?
> 
> I checked the above issue, and the kernel we used have applied this fix.

Good to know.

> And I have add the following trace to our reproduction attempts.
> 
>>
>> I'd also add this trace to your reproduction attempts:
>> --
>> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
>> index 0ec7d3329595..0cbc8afb41c8 100644
>> --- a/drivers/nvme/host/tcp.c
>> +++ b/drivers/nvme/host/tcp.c
>> @@ -919,6 +919,10 @@ static void nvme_tcp_data_ready(struct sock *sk)
>>
>> 	read_lock_bh(&sk->sk_callback_lock);
>> 	queue = sk->sk_user_data;
>> + 	if (!test_bit(NVME_TCP_Q_ALLOCATED, &queue->flags)) {
>> + 		pr_err("got data on a deallocated queue %d\n",
>> 			nvme_tcp_queue_id(queue));
>> +		WARN_ON_ONCE(1);
>> + 	}
>> 	if (likely(queue && queue->rd_enabled) &&
>> 		!test_bit(NVME_TCP_Q_POLLING, &queue->flags))
>> 		queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
>> --
>>
> 
>> If indeed this is the io_queue and for some reason it is running,
>> perhaps the correct fix would be to set the socket ops later in
>> start_queue. It will also be symmetric because we clear them in
>> stop_queue:
>> --
>> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
>> index 0ec7d3329595..b3b1e39966c0 100644
>> --- a/drivers/nvme/host/tcp.c
>> +++ b/drivers/nvme/host/tcp.c
>> @@ -1617,22 +1617,7 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl
>> *nctrl, int qid)
>> 	if (ret)
>> 		goto err_init_connect;
>>
>> - 	queue->rd_enabled = true;
>> 	set_bit(NVME_TCP_Q_ALLOCATED, &queue->flags);
>> -	nvme_tcp_init_recv_ctx(queue);
>> -
>> -	write_lock_bh(&queue->sock->sk->sk_callback_lock);
>> -	queue->sock->sk->sk_user_data = queue;
>> -	queue->state_change = queue->sock->sk->sk_state_change;
>> -	queue->data_ready = queue->sock->sk->sk_data_ready;
>> -	queue->write_space = queue->sock->sk->sk_write_space;
>> -	queue->sock->sk->sk_data_ready = nvme_tcp_data_ready;
>> -	queue->sock->sk->sk_state_change = nvme_tcp_state_change;
>> -	queue->sock->sk->sk_write_space = nvme_tcp_write_space;
>> - #ifdef CONFIG_NET_RX_BUSY_POLL
>> -	queue->sock->sk->sk_ll_usec = 1;
>> - #endif
>> -	write_unlock_bh(&queue->sock->sk->sk_callback_lock);
>>
>> 	return 0;
>>
>> @@ -1690,6 +1675,21 @@ static int nvme_tcp_start_queue(struct nvme_ctrl
>> *nctrl, int idx)
>> 	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
>> 	int ret;
>>
>> +	queue->rd_enabled = true;
>> +	nvme_tcp_init_recv_ctx(queue);
>> +	write_lock_bh(&queue->sock->sk->sk_callback_lock);
>> +	queue->sock->sk->sk_user_data = queue;
>> +	queue->state_change = queue->sock->sk->sk_state_change;
>> + 	queue->data_ready = queue->sock->sk->sk_data_ready;
>> + 	queue->write_space = queue->sock->sk->sk_write_space;
>> +	queue->sock->sk->sk_data_ready = nvme_tcp_data_ready;
>> +	queue->sock->sk->sk_state_change = nvme_tcp_state_change;
>> +	queue->sock->sk->sk_write_space = nvme_tcp_write_space;
>> + #ifdef CONFIG_NET_RX_BUSY_POLL
>> +	queue->sock->sk->sk_ll_usec = 1;
>> + #endif
>> +	 write_unlock_bh(&queue->sock->sk->sk_callback_lock);
>> +
>> 	if (idx)
>> 		ret = nvmf_connect_io_queue(nctrl, idx);
>> 	else
>> --
> 
> Yes, your given fix seting the socket ops later in start_queue can correct
> this issue properly. Then I have an another doubt that it maybe have hidden
> trouble if the label out_free_queue in __nvme_tcp_alloc_io_queues does not
> call kernel_sock_shutdown before freeing io_queue. So do you think the
> following patch are needed?
> Hope to get your reply again!
> 
> --
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index b55b5a298..824c0ddb3 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -1761,6 +1761,8 @@ static int nvme_tcp_alloc_admin_queue(struct nvme_ctrl *ctrl)
>   static int __nvme_tcp_alloc_io_queues(struct nvme_ctrl *ctrl)
>   {
>   	int i, ret;
> +	struct nvme_tcp_ctrl *tcp_ctrl = to_tcp_ctrl(ctrl);
> +	struct nvme_tcp_queue *queue;
> 
>   	for (i = 1; i < ctrl->queue_count; i++) {
>   		ret = nvme_tcp_alloc_queue(ctrl, i);
> @@ -1771,8 +1773,11 @@ static int __nvme_tcp_alloc_io_queues(struct nvme_ctrl *ctrl)
>   	return 0;
> 
>   out_free_queues:
> -	for (i--; i >= 1; i--)
> +	for (i--; i >= 1; i--) {
> +		queue = &tcp_ctrl->queues[i];
> +		kernel_sock_shutdown(queue->sock, SHUT_RDWR);
> 		nvme_tcp_free_queue(ctrl, i);
> +	}
> 
> 	return ret;
>   }
> --

I don't see why this is needed. The shutdown prevents us from being able 
to read/write to/from the socket because it is going away. And at this 
point, if we have not triggered io_work (and if we didn't assign 
data_ready yet we can't), there should be no way some other context is
consuming the socket. This is the assumption of the current code.

