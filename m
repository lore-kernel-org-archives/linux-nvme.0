Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A21AC6FD1C
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Mar 2023 12:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AKdmd3ybGNzUKxSgz2QwAW61PV0agkT7vVa3w7/HBa8=; b=NqB26krOWYJFGbC+e+aZOjsQB7
	DKhDoDODa8lDoPTlw4IRNtToPG6Nl3FWCU7aQ22M7Ah3uuoKb5YhJJhCddpLy4SXbRBtuNbjR1BdN
	6BVCvVEshbOSunryQlYPBgpeZK88uYKanCRLkV0Gs8HO+4Bok4I/c7KLMaqOooDps8o3+1sZQaZhw
	KCIh2S0rx7biUngLp8Rc5AbFXVdiRBSMcAD/oGluqH0KAFtgKChmkxAHvgMqLTcSM1tebBm5XRxMV
	FDQFLtGmMXE99uoK0q/HUQB7J5e/GZkE1TaJiyVNsaWULmFDWJ2v5p55mFGmSP+uuoI8Elbep86gE
	Supi95rA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pbgyz-005dBP-Oj; Mon, 13 Mar 2023 12:08:53 +0000
Received: from mail-wr1-f53.google.com ([209.85.221.53])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pbgyv-005dA4-6f
	for linux-nvme@lists.infradead.org; Mon, 13 Mar 2023 12:08:51 +0000
Received: by mail-wr1-f53.google.com with SMTP id r18so11094803wrx.1
        for <linux-nvme@lists.infradead.org>; Mon, 13 Mar 2023 05:08:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678709325;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AKdmd3ybGNzUKxSgz2QwAW61PV0agkT7vVa3w7/HBa8=;
        b=WQ5tubOVRcxETvBjp3yFvkaXBFzLEP2fOC/s23qnCSguKmqbMH4GSZFrV5JkFNw9uA
         PC0IA6beErtThfGturDsBE1PwVz45k4LoNh9OCuOmmePNUZyuy4PzlkAskrzrjChla+M
         +XRpa5k4xD/KsKrEI+7T5BiG0TXzkCIdUNjZt4mCAvhgf4lshTo/lCbp/84yzvqWC3F3
         vndmBpof/OZUYhuG9+xUf//NQB8GZRhAcbOZsMnQCPkrmcNZAZZf38gKv5aB8LhjNhCo
         ewi/A637so799cReOwSy9Txq8/ljDsWDRSc1+tRyO13MQHmCON/+nGvGvNuyETPlO05q
         qrGQ==
X-Gm-Message-State: AO0yUKXiidw8JFcMq9mRgYnSDbD2hF3zwhoXX3fzi9bsEZ1/LOU0S/Jb
	zb2uf53krsHPHFpj5qNJSCQ=
X-Google-Smtp-Source: AK7set+Gh0PeK9DtTZuhRQ55dLUGwLC53aKNGmhgDxP8+p1hm1aabAGHBTTcAKhwM7PqgL/OQMVupw==
X-Received: by 2002:a5d:68c2:0:b0:2c7:175e:e201 with SMTP id p2-20020a5d68c2000000b002c7175ee201mr9603882wrw.1.1678709324990;
        Mon, 13 Mar 2023 05:08:44 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id f2-20020adfdb42000000b002cf1c435afcsm2809475wrj.11.2023.03.13.05.08.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Mar 2023 05:08:44 -0700 (PDT)
Message-ID: <adf88c55-64b0-6138-fea8-797d2b30b770@grimberg.me>
Date: Mon, 13 Mar 2023 14:08:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [RFC PATCH] nvme-tcp: fix possible crash when only partilal
 queues are allocated by nvme_tcp_alloc_queue
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
To: zhangyanjun@cestc.cn, kbusch@kernel.org, axboe@fb.com, hch@lst.de
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 xiang.li@cestc.cn, shaopeijie@cestc.cn
References: <20230313113204.2205730-1-zhangyanjun@cestc.cn>
 <55bfaef2-1faf-ac7a-53b1-60f9e7b8afea@grimberg.me>
In-Reply-To: <55bfaef2-1faf-ac7a-53b1-60f9e7b8afea@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230313_050849_264636_3090C033 
X-CRM114-Status: GOOD (  29.99  )
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


>   So we query that directly freeing these allocated
>> I/O queues may result in this issue. To avoid this issuse, we try to make
>> the following code modifications, but have not verified to be valid yet
>> because of the occasionality of this issue.
>>
>> Now, we can not confirm the caller of queuing on the io_work during
>> allocating all the I/O queues, but we doubt that the socket interface
>> sk_data_ready=nvme_tcp_data_ready initialized by nvme_tcp_alloc_queue
>> may do this action in this interval. Hope to get some suggestions, 
>> Thanks!
> 
> I would start by determining that the running io_work is an io queue or
> the admin queue. It is also possible that the admin queue cleanup after
> we io queues allocation failed is the problematic teardown that is
> causing this bug.
> 
>>
>> Signed-off-by: Yanjun Zhang <zhangyanjun@cestc.cn>
>> ---
>>   drivers/nvme/host/tcp.c | 7 +++++--
>>   1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
>> index 9b47dcb2a..5782183b8 100644
>> --- a/drivers/nvme/host/tcp.c
>> +++ b/drivers/nvme/host/tcp.c
>> @@ -1761,6 +1761,7 @@ static int nvme_tcp_alloc_admin_queue(struct 
>> nvme_ctrl *ctrl)
>>   static int __nvme_tcp_alloc_io_queues(struct nvme_ctrl *ctrl)
>>   {
>>       int i, ret;
>> +    struct nvme_tcp_ctrl *tcp_ctrl = NULL;
>>       for (i = 1; i < ctrl->queue_count; i++) {
>>           ret = nvme_tcp_alloc_queue(ctrl, i);
>> @@ -1771,9 +1772,11 @@ static int __nvme_tcp_alloc_io_queues(struct 
>> nvme_ctrl *ctrl)
>>       return 0;
>>   out_free_queues:
>> -    for (i--; i >= 1; i--)
>> +    for (i--; i >= 1; i--) {
>> +        tcp_ctrl = to_tcp_ctrl(ctrl);
>> +        __nvme_tcp_stop_queue(&tcp_ctrl->queues[i]);
>>           nvme_tcp_free_queue(ctrl, i);
>> -
>> +    }
>>       return ret;
>>   }
> 
> The crash dump reminds me of a reported issue fixed by:
> 160f3549a907 ("nvme-tcp: fix UAF when detecting digest errors")
> 
> Is this applied in your host kernel?
> 
> I'd also add this trace to your reproduction attempts:
> -- 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 0ec7d3329595..0cbc8afb41c8 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -919,6 +919,10 @@ static void nvme_tcp_data_ready(struct sock *sk)
> 
>          read_lock_bh(&sk->sk_callback_lock);
>          queue = sk->sk_user_data;
> +       if (!test_bit(NVME_TCP_Q_ALLOCATED, &queue->flags)) {
> +               pr_err("got data on a deallocated queue %d\n", 
> nvme_tcp_queue_id(queue));
> +               WARN_ON_ONCE(1);
> +       }
>          if (likely(queue && queue->rd_enabled) &&
>              !test_bit(NVME_TCP_Q_POLLING, &queue->flags))
>                  queue_work_on(queue->io_cpu, nvme_tcp_wq, 
> &queue->io_work);
> -- 

If indeed this is the io_queue and for some reason it is running,
perhaps the correct fix would be to set the socket ops later in
start_queue. It will also be symmetric because we clear them in
stop_queue:
--
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 0ec7d3329595..b3b1e39966c0 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1617,22 +1617,7 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl 
*nctrl, int qid)
         if (ret)
                 goto err_init_connect;

-       queue->rd_enabled = true;
         set_bit(NVME_TCP_Q_ALLOCATED, &queue->flags);
-       nvme_tcp_init_recv_ctx(queue);
-
-       write_lock_bh(&queue->sock->sk->sk_callback_lock);
-       queue->sock->sk->sk_user_data = queue;
-       queue->state_change = queue->sock->sk->sk_state_change;
-       queue->data_ready = queue->sock->sk->sk_data_ready;
-       queue->write_space = queue->sock->sk->sk_write_space;
-       queue->sock->sk->sk_data_ready = nvme_tcp_data_ready;
-       queue->sock->sk->sk_state_change = nvme_tcp_state_change;
-       queue->sock->sk->sk_write_space = nvme_tcp_write_space;
-#ifdef CONFIG_NET_RX_BUSY_POLL
-       queue->sock->sk->sk_ll_usec = 1;
-#endif
-       write_unlock_bh(&queue->sock->sk->sk_callback_lock);

         return 0;

@@ -1690,6 +1675,21 @@ static int nvme_tcp_start_queue(struct nvme_ctrl 
*nctrl, int idx)
         struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
         int ret;

+       queue->rd_enabled = true;
+       nvme_tcp_init_recv_ctx(queue);
+       write_lock_bh(&queue->sock->sk->sk_callback_lock);
+       queue->sock->sk->sk_user_data = queue;
+       queue->state_change = queue->sock->sk->sk_state_change;
+       queue->data_ready = queue->sock->sk->sk_data_ready;
+       queue->write_space = queue->sock->sk->sk_write_space;
+       queue->sock->sk->sk_data_ready = nvme_tcp_data_ready;
+       queue->sock->sk->sk_state_change = nvme_tcp_state_change;
+       queue->sock->sk->sk_write_space = nvme_tcp_write_space;
+#ifdef CONFIG_NET_RX_BUSY_POLL
+       queue->sock->sk->sk_ll_usec = 1;
+#endif
+       write_unlock_bh(&queue->sock->sk->sk_callback_lock);
+
         if (idx)
                 ret = nvmf_connect_io_queue(nctrl, idx);
         else
--

