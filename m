Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 394F3C369AB
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Apr 2025 11:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EVAZkueF6TO3vmEWTnRcjkq4LoD47LWe63XR/UPIPzA=; b=OZd32Dug+ZW+mhvTVDcyu+HXrA
	LjlZXJNRYp5xnCvEo0sC6v6TqiRZReX+vt8kuuJFYrx162pcIXrfShHS066eusnxpqoOlnt3C1Whs
	PGI8X8AyQxpr5rw+eiCdyNJta5iFfX5nGPMnwB+4y4+QAqqr1SbSYQfWAHDoTowwvZ/G7NYa8PkIN
	RZud8Fj66zc/dXxZl9+Sp1BHjEFRCOl2T/Nh9THnAZ+xtMkmIm+H/m3TcSpeydj7M1pPESk0uz0XT
	U+j+mgdpaogjgb8r3uzEY5d9+XFmUAIkp5vMqhvQ/GI1tmYa7yR4JwHlg7sBmEDXBWlxkeNSg63wM
	k2W2h4AA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5kDs-0000000G0Kp-0rge;
	Fri, 18 Apr 2025 11:49:32 +0000
Received: from mail-wr1-f41.google.com ([209.85.221.41])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5kDp-0000000G0K0-33Yn
	for linux-nvme@lists.infradead.org;
	Fri, 18 Apr 2025 11:49:30 +0000
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-39ee5ac4321so1598721f8f.1
        for <linux-nvme@lists.infradead.org>; Fri, 18 Apr 2025 04:49:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744976968; x=1745581768;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EVAZkueF6TO3vmEWTnRcjkq4LoD47LWe63XR/UPIPzA=;
        b=tDgmBTYpld91ovrljV59qXGMW6wIA1Aap3i8D9NqwlJG1FdioIX5buBH4Js3uU4Hdo
         JrWy8cqOuHvgBp8AJCHWzF2jXr5NaTlZ2p8VmuP4EDwY22cxMi1Axegpi3nlTXTg2Xcq
         2ydc6EC0NWXakLcIE7Mu4HZ682mWqJCJ/e+YMQh6lAnb+y/gJtExWQIhoLk6IDKvvtdm
         G7umYrOEAtWNb2YL8f5Hc5LDQaJ2Ri2+ye36gvubhhTxIUgS+R1soAz0KmD0HAO0vunq
         Dm137RIKuI10frsdpP26jT7Al/8Y4BliBcJ0ZC0d9yx14Ll1EtstgZZKINge2gDAcGNG
         qOvw==
X-Forwarded-Encrypted: i=1; AJvYcCUO5C+n4Vpwz16+Af9uAYYz7u2OmWzF0tAW8HK/SejyPYMfGr4P+AYHMmDkaDMKX7TVBDm19QJ/y/xV@lists.infradead.org
X-Gm-Message-State: AOJu0Ywc6wR/olmxzanay+HkH7FaSAU7x49qbotL8z0xHjFJC1w3YkQM
	dPizhiRX0N3makCP1Lr/3ftQjoK4HPR0qgK1cnhFMqx7IdJWdJUq
X-Gm-Gg: ASbGncvuAtBv/enBfAkw+boIMKJCE6oCAwq6sDwhBjp+9mw1sfWRK05XNSdkdUiIq9a
	hol6fBEEp+7F0y3qZybdKgnrWdaVWPHfIAMn7pNbTir0rHn5D1TWYT4WZaKiTP/G0Rb266+L9Nr
	dYNQnEnLzWq2qumQWWJ2rri0cbxrh0GbL+JAGXZdS98o6iO6NrGUk/yv5O4Ua85FwDyQ1okEPKT
	wUeGp+uAWP29k/SYvEZRiJkO8AWRMHke1q6z198RkklhZzemD266qiStLVo6uN6TkYGVhqxjeM+
	ZR5g41St/48HhtpldLx+jMtsWRfj1Ca6zm3rw/QSOMKALufmsdk=
X-Google-Smtp-Source: AGHT+IHAD5tCrAKdlb+hKiBaU767bCq+juH84w7mFehf7472CiKBwwZN5Ga2ogjoWSPneMEPliij4w==
X-Received: by 2002:a5d:5987:0:b0:39e:e438:8e4b with SMTP id ffacd0b85a97d-39efbaf6e96mr1812477f8f.50.1744976967991;
        Fri, 18 Apr 2025 04:49:27 -0700 (PDT)
Received: from [10.100.102.67] ([95.35.174.203])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4406d6db117sm19288545e9.26.2025.04.18.04.49.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Apr 2025 04:49:27 -0700 (PDT)
Message-ID: <4683e355-166f-4b9a-a3ea-529f7b058a84@grimberg.me>
Date: Fri, 18 Apr 2025 14:49:25 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] nvme-tcp: wait socket wmem to drain in queue stop
From: Sagi Grimberg <sagi@grimberg.me>
To: Michael Liang <mliang@purestorage.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Cc: Mohamed Khalfella <mkhalfella@purestorage.com>,
 Randy Jennings <randyj@purestorage.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250417071359.iw3fangcfcuopjza@purestorage.com>
 <acc46429-6228-475e-8fd8-bc3d43c7f710@grimberg.me>
Content-Language: en-US
In-Reply-To: <acc46429-6228-475e-8fd8-bc3d43c7f710@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250418_044929_770773_C31FF6A1 
X-CRM114-Status: GOOD (  24.23  )
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



On 4/18/25 14:30, Sagi Grimberg wrote:
>
>
> On 4/17/25 10:13, Michael Liang wrote:
>> This patch addresses a data corruption issue observed in nvme-tcp during
>> testing.
>>
>> Issue description:
>> In an NVMe native multipath setup, when an I/O timeout occurs, all 
>> inflight
>> I/Os are canceled almost immediately after the kernel socket is shut 
>> down.
>> These canceled I/Os are reported as host path errors, triggering a 
>> failover
>> that succeeds on a different path.
>>
>> However, at this point, the original I/O may still be outstanding in the
>> host's network transmission path (e.g., the NIC’s TX queue). From the
>> user-space app's perspective, the buffer associated with the I/O is 
>> considered
>> completed since they're acked on the different path and may be reused 
>> for new
>> I/O requests.
>>
>> Because nvme-tcp enables zero-copy by default in the transmission path,
>> this can lead to corrupted data being sent to the original target, 
>> ultimately
>> causing data corruption.
>>
>> We can reproduce this data corruption by injecting delay on one path and
>> triggering i/o timeout.
>>
>> To prevent this issue, this change ensures that all inflight 
>> transmissions are
>> fully completed from host's perspective before returning from queue
>> stop. To handle concurrent I/O timeout from multiple namespaces under
>> the same controller, always wait in queue stop regardless of queue's 
>> state.
>>
>> This aligns with the behavior of queue stopping in other NVMe fabric 
>> transports.
>>
>> Reviewed-by: Mohamed Khalfella <mkhalfella@purestorage.com>
>> Reviewed-by: Randy Jennings <randyj@purestorage.com>
>> Signed-off-by: Michael Liang <mliang@purestorage.com>
>> ---
>>   drivers/nvme/host/tcp.c | 16 ++++++++++++++++
>>   1 file changed, 16 insertions(+)
>>
>> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
>> index 26c459f0198d..62d73684e61e 100644
>> --- a/drivers/nvme/host/tcp.c
>> +++ b/drivers/nvme/host/tcp.c
>> @@ -1944,6 +1944,21 @@ static void __nvme_tcp_stop_queue(struct 
>> nvme_tcp_queue *queue)
>>       cancel_work_sync(&queue->io_work);
>>   }
>>   +static void nvme_tcp_stop_queue_wait(struct nvme_tcp_queue *queue)
>> +{
>> +    int timeout = 100;
>> +
>> +    while (timeout > 0) {
>> +        if (!sk_wmem_alloc_get(queue->sock->sk))
>> +            return;
>> +        msleep(2);
>> +        timeout -= 2;
>> +    }
>> +    dev_warn(queue->ctrl->ctrl.device,
>> +         "qid %d: wait draining sock wmem allocation timeout\n",
>> +         nvme_tcp_queue_id(queue));
>> +}
>> +
>>   static void nvme_tcp_stop_queue(struct nvme_ctrl *nctrl, int qid)
>>   {
>>       struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
>> @@ -1961,6 +1976,7 @@ static void nvme_tcp_stop_queue(struct 
>> nvme_ctrl *nctrl, int qid)
>>       /* Stopping the queue will disable TLS */
>>       queue->tls_enabled = false;
>>       mutex_unlock(&queue->queue_lock);
>> +    nvme_tcp_stop_queue_wait(queue);
>>   }
>>     static void nvme_tcp_setup_sock_ops(struct nvme_tcp_queue *queue)
>
> This makes sense. But I do not want to pay this price serially.
> As the concern is just failover, lets do something like: diff --git 
> a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c index 
> 5041cbfd8272..d482a8fe2c4b 100644 --- a/drivers/nvme/host/tcp.c +++ 
> b/drivers/nvme/host/tcp.c @@ -2031,6 +2031,8 @@ static void 
> nvme_tcp_stop_io_queues(struct nvme_ctrl *ctrl) for (i = 1; i < 
> ctrl->queue_count; i++) nvme_tcp_stop_queue(ctrl, i); + for (i = 1; i 
> < ctrl->queue_count; i++) + 
> nvme_tcp_stop_queue_wait(&ctrl->queues[i]); } static int 
> nvme_tcp_start_io_queues(struct nvme_ctrl *ctrl, @@ -2628,8 +2630,10 
> @@ static void nvme_tcp_complete_timed_out(struct request *rq) { 
> struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq); struct nvme_ctrl 
> *ctrl = &req->queue->ctrl->ctrl; + int idx = 
> nvme_tcp_queue_id(req->queue); - nvme_tcp_stop_queue(ctrl, 
> nvme_tcp_queue_id(req->queue)); + nvme_tcp_stop_queue(ctrl, idx); + 
> nvme_tcp_stop_queue_wait(&ctrl->queues[idx]); 
> nvmf_complete_timed_out_request(rq); }

Or perhaps something like:
--
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 5041cbfd8272..3e206a2cbbf3 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1944,7 +1944,7 @@ static void __nvme_tcp_stop_queue(struct 
nvme_tcp_queue *queue)
         cancel_work_sync(&queue->io_work);
  }

-static void nvme_tcp_stop_queue(struct nvme_ctrl *nctrl, int qid)
+static void nvme_tcp_stop_queue_nowait(struct nvme_ctrl *nctrl, int qid)
  {
         struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
         struct nvme_tcp_queue *queue = &ctrl->queues[qid];
@@ -1963,6 +1963,29 @@ static void nvme_tcp_stop_queue(struct nvme_ctrl 
*nctrl, int qid)
         mutex_unlock(&queue->queue_lock);
  }

+static void nvme_tcp_wait_queue(struct nvme_ctrl *nctrl, int qid)
+{
+       struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
+       struct nvme_tcp_queue *queue = ctrl->queues[qid];
+       int timeout = 100;
+
+       while (timeout > 0) {
+               if (!sk_wmem_alloc_get(queue->sock->sk))
+                       return;
+               msleep(2);
+               timeout -= 2;
+       }
+       dev_warn(queue->ctrl->ctrl.device,
+                "qid %d: timeout draining sock wmem allocation expired\n",
+                nvme_tcp_queue_id(queue));
+}
+
+static void nvme_tcp_stop_queue(struct nvme_ctrl *nctrl, int qid)
+{
+       nvme_tcp_stop_queue_nowait(nctrl, qid);
+       nvme_tcp_wait_queue(nctrl, qid);
+}
+
  static void nvme_tcp_setup_sock_ops(struct nvme_tcp_queue *queue)
  {
write_lock_bh(&queue->sock->sk->sk_callback_lock);
@@ -2030,7 +2053,9 @@ static void nvme_tcp_stop_io_queues(struct 
nvme_ctrl *ctrl)
         int i;

         for (i = 1; i < ctrl->queue_count; i++)
-               nvme_tcp_stop_queue(ctrl, i);
+               nvme_tcp_stop_queue_nowait(ctrl, i);
+       for (i = 1; i < ctrl->queue_count; i++)
+               nvme_tcp_wait_queue(ctrl, i);
  }

  static int nvme_tcp_start_io_queues(struct nvme_ctrl *ctrl,
--

