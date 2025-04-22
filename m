Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F0D0C369C2
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Apr 2025 12:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iRj6DP8+avdLnus4ChhnjVOnNURaZnIqY6L7WMC/pvA=; b=UvG+/nwTbZ4MkOs0v9wOERMJ+3
	Lx6kxrmNbUIx/dFAI6IEbmplaRjWaCq+b2D/rEI+YIDwhhYROXMiu/HvykqKIAr+X/s1O+1NaPpjT
	01NJtAyFt0cMp+6hA/R1MLMSvsvbCEgP4VG/wq7ihl5IC/yoXmqQ7H0cLFUPVMp4n6S0oCCTRyxso
	r/7t5LowqUZMin8kSTaJx+SATtDIdtkz4n0EhkfRXfl/stfDhq6izEF/yL0ja2BN3ruVlAPzU3uc2
	aNE7k5TrCF9bcZ0YXc9y4R9vBRkiieb9dzl3WS+ZQQ2Zcnrb11O5OqCMY/S94aiedmQub26G1YrRb
	r7CK1UZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7D3G-00000007BPf-3C7W;
	Tue, 22 Apr 2025 12:48:38 +0000
Received: from mail-wr1-f47.google.com ([209.85.221.47])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7C2G-00000006zrj-48JF
	for linux-nvme@lists.infradead.org;
	Tue, 22 Apr 2025 11:43:34 +0000
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-39c1efc4577so2667959f8f.0
        for <linux-nvme@lists.infradead.org>; Tue, 22 Apr 2025 04:43:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745322211; x=1745927011;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iRj6DP8+avdLnus4ChhnjVOnNURaZnIqY6L7WMC/pvA=;
        b=T9nbeXIF/V/D8rxcRq2KtpLJ5yyqo8gH2Ed9/0wA1UqN33iErhcQB9wQjTHQwacrLq
         GrDIuN0YzvgdqbhK4wdW/mePLbE+v4cVWeD/6WMJc1IpK1tDqxXiFeRM4VimVNf1142x
         ajisuBGUu3R8y2gkuvHkcey41ogCqhAXc1t5vw9nqJVX9Q2Q03J/EL/FPRBHgbMQJq/o
         zXU3oimF0k5/AaE3MWxP4Zw8FdOqgybAV3/j9ZS8UEi52ltBsxDJVW+iBwP3CunFFZHh
         NqzhiH6OoVF7H+3cBj24epzET8CglZhy36beclkYURBy/iY2POKEeEPGw6eDw8dPEH97
         0NLw==
X-Forwarded-Encrypted: i=1; AJvYcCUcmkx8yZ1KRN4UlT39/eqwQvOD+slPRJEMCjFXBHpLmZsRAWmh5k+RkwF3rDgp617FNGcGYj3PPqrm@lists.infradead.org
X-Gm-Message-State: AOJu0YxbcwNdqqiD9wKJ5hv7fCtxKT3q0iRD4lCPX4N/+BZCHVrWQxCX
	l3UwyeL+RmW2yu0Efftf5t9Ab9NfiDFalidbiHxL9tWh9AlInh1k
X-Gm-Gg: ASbGncujQZdx2tVqtglJ6djho4nJS62OfQjNuyWU2lB2kDGw6ocN+4iO8Zy9sCcObCQ
	r8829r9GF3QySwjnXWVfk0M4GoQp5lMLHOHGBRsKKA+GcjnYqBgxyZwVe2NUPIMOzIGWLi9dTTb
	EtVmKQi7Dyoaeqfl/wWmVEFpTEjg8B3PlRfkmiN4Z2ATd/lrtXc5pCbYF7w7nMjr/Xmd8s4IG+k
	YWv4hMoppPaaPyv+5f0IWxxcqdGUsEfOLFeHj7AMFMWulq0xsEdpUnu1Kd6pOF6t4s51MsLfAFh
	T9L1rh7luh7BPZ5CtA8mKeYiQil6A68DX9kDmV9CAcM5JWYq0gXLWpNk1kY17p4+UTJFuZ4yYlr
	HIIr16Q==
X-Google-Smtp-Source: AGHT+IHGxIBIHQ7WwxiX3FRDtp7qAsWSDpLBHX+7yOflW32wNboHYdkzKwHym8t+J1yf+ecW1EJzww==
X-Received: by 2002:a05:6000:4387:b0:39c:1257:febb with SMTP id ffacd0b85a97d-39efbb21ca8mr10663397f8f.59.1745322210549;
        Tue, 22 Apr 2025 04:43:30 -0700 (PDT)
Received: from [10.50.5.11] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39efa49312fsm14941406f8f.70.2025.04.22.04.43.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Apr 2025 04:43:29 -0700 (PDT)
Message-ID: <2223f6b3-d1c3-41d9-8adc-78b5a50a63ab@grimberg.me>
Date: Tue, 22 Apr 2025 14:43:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] nvme-tcp: fix I/O stalls on congested sockets
To: Kamaljit Singh <Kamaljit.Singh1@wdc.com>, Hannes Reinecke <hare@suse.de>,
 Hannes Reinecke <hare@kernel.org>, hch <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Chris Leech <cleech@redhat.com>
References: <20250403065522.90807-1-hare@kernel.org>
 <20250403065522.90807-4-hare@kernel.org>
 <1edc23f5-eb48-4006-a2f4-d303b05bd3e0@suse.de>
 <e7371b8a-e0b3-4387-a941-292e1f46b2aa@grimberg.me>
 <5446ef17-d922-4467-9a3c-5001713cc260@suse.de>
 <dac1d594-cf64-41ce-8a23-4b246db75b83@grimberg.me>
 <BY5PR04MB684996C1DB38F3BC4386B55EBCBC2@BY5PR04MB6849.namprd04.prod.outlook.com>
 <ee011198-9a15-44e5-a18e-02d3844ee48b@grimberg.me>
 <BY5PR04MB6849262F5822EC7132BE7414BCBF2@BY5PR04MB6849.namprd04.prod.outlook.com>
 <cb444a0b-ecaa-4f46-8323-e5c39a8c71e7@grimberg.me>
 <BY5PR04MB68498E95C971D95BD7964F9ABCB82@BY5PR04MB6849.namprd04.prod.outlook.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <BY5PR04MB68498E95C971D95BD7964F9ABCB82@BY5PR04MB6849.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250422_044333_023718_5FCDAD92 
X-CRM114-Status: GOOD (  31.44  )
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



On 21/04/2025 22:11, Kamaljit Singh wrote:
> Sagi,
>
>> However the log prints are WARN messages that does not exist in any of
>> the patches.
> Just found the issue with my patch integration. I had picked up Hannes' patch in email
> titled "[PATCH 2/3] nvme-tcp:  sanitize request list handling" and dated Fri Match 7th.
> This had the 3 WARN_ON msgs.
>
> I just found another patch-set with almost the same title dated March 27th.
> I'll integrate this one "PATCH 2/5] nvme-tcp: sanitize request list handling".
> This replaced those WARN_ON msgs w/ dev_err() after if-checks for the same
> conditions.
>
>>> The patches I applied are these:
>>> 1: nvme-tcp: partial write tcp-q-wake-sender untested by Sagi
>>> 2: nvme-tcp: recv-side EAGAIN untested fix by Sagi
>>> 3: nvme-tcp: fix I/O stalls on congested sockets
>> The patch I suggested was a replacement for patch (3). Didn't you
>> get conflicts?
> No. But I reviewed it again and have undone this part of patch-3 in my setup.
> -               else if (unlikely(result < 0))
> +               else if (unlikely(result < 0) && result != -EAGAIN)
>
>
>>> 4: nvme-tcp: sanitize request list handling
>>> 5: nvme-tcp: avoid inline sending when handling R2T PDUs
>>> [4]         nvme-tcp: sanitize request list handling
>>>
>>>       Validate the request in nvme_tcp_handle_r2t() to ensure it's not
>>>       part of any list, otherwise a malicious R2T PDU might inject a
>>>       loop in request list processing.
>>>
>>> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
>>> index 40dce5dc3ff5..4647d5d547f8 100644
>>> --- a/drivers/nvme/host/tcp.c
>>> +++ b/drivers/nvme/host/tcp.c
>>> @@ -455,6 +455,7 @@ nvme_tcp_fetch_request(struct nvme_tcp_queue *queue)
>>>           }
>>>
>>>           list_del(&req->entry);
>>> +       init_llist_node(&req->lentry);
>>>           return req;
>>>    }
>>>
>>> @@ -562,6 +563,8 @@ static int nvme_tcp_init_request(struct blk_mq_tag_set *set,
>>>           req->queue = queue;
>>>           nvme_req(rq)->ctrl = &ctrl->ctrl;
>>>           nvme_req(rq)->cmd = &pdu->cmd;
>>> +       init_llist_node(&req->lentry);
>>> +       INIT_LIST_HEAD(&req->entry);
>>>
>>>           return 0;
>>>    }
>>> @@ -773,8 +776,12 @@ static int nvme_tcp_handle_r2t(struct nvme_tcp_queue *queue,
>>>
>>>           nvme_tcp_setup_h2c_data_pdu(req);
>>>
>>> +       WARN_ON(queue->request == req);
>>> +       WARN_ON(llist_on_list(&req->lentry));
>>> +       WARN_ON(!list_empty(&req->entry));
>> These are not included in Hannes patch afaict.
> They were, as I noted on above.
>
>
>> I'm assuming that these are the stack traces that are firing...
>>
>> Can you please share the output of gdb:
>> l *nvme_tcp_recv_skb+0x115e
> It points to the 3rd WARN_ON msg. I've replaced those warnings with the patch you suggested below.
>
> (gdb) l *(nvme_tcp_recv_skb+0x115e)
> 0x628e is in nvme_tcp_recv_skb (tcp.c:782).
> 777
> 778             nvme_tcp_setup_h2c_data_pdu(req);
> 779
> 780             WARN_ON(queue->request == req);
> 781             WARN_ON(llist_on_list(&req->lentry));
> 782             WARN_ON(!list_empty(&req->entry));
> 783             llist_add(&req->lentry, &queue->req_list);
> 784             if (list_empty(&queue->send_list))
> 785                     queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);

That is strange - should not happen afaict. You did not change the code 
and recompile
before checking this correct?

>> My assumption is that in your case, queue->request is still referenced
>> with the current request when the r2t for it arrives, which is very much
>> possible...
>>
>> So this means that the patch "nvme-tcp: sanitize request list handling"
>> is wrong, queue->request may still be referenced when its r2t arrives.
>>
>> I think this patch needs the following:
>> --
>> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
>> index f2c829f1aff6..c2d4893ecb94 100644
>> --- a/drivers/nvme/host/tcp.c
>> +++ b/drivers/nvme/host/tcp.c
>> @@ -767,8 +767,7 @@ static int nvme_tcp_handle_r2t(struct nvme_tcp_queue
>> *queue,
>>                  return -EPROTO;
>>          }
>>
>> -       if (queue->request == req ||
>> -           llist_on_list(&req->lentry) ||
>> +       if (llist_on_list(&req->lentry) ||
>>              !list_empty(&req->entry)) {
>>                  dev_err(queue->ctrl->ctrl.device,
>>                          "req %d unexpected r2t while processing request\n",
>> --
>>
>> Or in your case - remove the above:
>> --
>>         WARN_ON(queue->request == req);
>> --
> Made that change. Tested and seeing this. -71 is -EPROTO that patch-2 returns .
> Trying to narrow it down further. If you have any suggestion, let me know.
>
> [Mon Apr 21 11:18:58 2025] nvme nvme0: req 7 unexpected r2t while processing request
> [Mon Apr 21 11:18:58 2025] nvme nvme0: receive failed:  -71
> [Mon Apr 21 11:18:58 2025] nvme nvme0: starting error recovery
> [Mon Apr 21 11:18:58 2025] nvme nvme0: req 11 unexpected r2t while processing request
> [Mon Apr 21 11:18:58 2025] block nvme0n1: no usable path - requeuing I/O
> [Mon Apr 21 11:18:58 2025] nvme nvme0: receive failed:  -71
>
>
>>> [2025-04-16 22:56:24.758] [Wed Apr 16 22:56:26 2025] WARNING: CPU: 22 PID: 134878 at tcp.c:782 nvme_tcp_recv_skb+0x115e/0x11c0 [nvme_tcp]
>> My assumption is that this is a result of
>> WARN_ON(queue->request == req);
>  From the gdb decode it points to WARN_ON(!list_empty(&req->entry))

Can you please apply this on top:
--
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 9453cf453d03..334154a58bdb 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -453,7 +453,7 @@ nvme_tcp_fetch_request(struct nvme_tcp_queue *queue)
                         return NULL;
         }

-       list_del(&req->entry);
+       list_del_init(&req->entry);
         init_llist_node(&req->lentry);
         return req;
  }
--

