Return-Path: <SRS0=EXAn=NX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EC11C432BE
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Sep 2021 13:22:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D820600D4
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Sep 2021 13:22:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3D820600D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=b2pAXRQ2DPwDH0upU02Sl+7T4r4vetEmjDOkXNZ/F9g=; b=jfJTe/yM2QePLITboAmRYFTlaC
	lD2cj00izUr+4miDummZyIRXWm7mHnkKRllTQ7Rn3x6rd07isy05JwpXMWsSWIRvj6YEuJXbSUiQJ
	WZ93prfoA/dRf2+guMl5akHES4APam7Fd4KXMMIRAwETrk+c4csuoZZpR6ctNEBqykVa2HYuJI+dL
	WYJEu/sYkNKnUobr6BeS1EmesbnlzN6BT/2lk1tm6GW3jvS6CSN5ItUBSUIfa+8qEV8VYLEBevicU
	Gg3Sgfb6P+ldBJAI3OAJ0aeG6VAJxf4MVAnUdHIMOu5lk1dXfI2pxA9MTZ3lCDZYAXKKtzYtZaXGq
	zzqU8nIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mLQBo-0067vX-8Y; Wed, 01 Sep 2021 13:22:04 +0000
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mLQBd-0067up-In
 for linux-nvme@lists.infradead.org; Wed, 01 Sep 2021 13:21:57 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 l7-20020a1c2507000000b002e6be5d86b3so1963196wml.3
 for <linux-nvme@lists.infradead.org>; Wed, 01 Sep 2021 06:21:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=iL9XStZQi1z0VI3r5iFNu4T+zl/Vow/gZ6tG0ZNMchQ=;
 b=Wa/440hzA9n8tGIBK+Oyy7rgfOJyGcKyODPzFHxJQ26ztdbtMR4RaCt2BcfzaArjVX
 01vEQmfQTlXpXFM4HOvuBJ77t0kCbpE9PTroHbVN8pKUsVwC/qUPWRlBt/uqhv0LY0WH
 qFqLciw7NME52LyRcMT9pY2AENO6XkHnsW4gIuy82GbT2msRcTSMXhwMaCTxDU+Zkv8f
 Xdm3tS8VU5HQmDzWjk0euOlJU5mw5z+uyJ2fUK+0EQQGskIA4yNFbad7mR7jIgWKN3eW
 k1NCN/oyimKu3j/Npyl3fzHfhkfQntXBMiNTEBd+yQlpeqECmgU8eMlfHV1Ra+eHMdcd
 AdgQ==
X-Gm-Message-State: AOAM533O1MhsExN71USUMYOwp8RSFNKAozehJXTxoz9gn8ApSjcLArGL
 Kin/F8sNYtAYDzKcqt8tGr8hHdxJYSA=
X-Google-Smtp-Source: ABdhPJwFHTLVvzNWHOscPNbyjIdC0flml2hasZpnElU7xuRKlHGqLIyZt1fEj93lcKaOmggurIONUw==
X-Received: by 2002:a1c:7515:: with SMTP id o21mr9854644wmc.150.1630502510996; 
 Wed, 01 Sep 2021 06:21:50 -0700 (PDT)
Received: from [10.100.102.14] (109-186-228-184.bb.netvision.net.il.
 [109.186.228.184])
 by smtp.gmail.com with ESMTPSA id s12sm21699899wru.41.2021.09.01.06.21.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Sep 2021 06:21:50 -0700 (PDT)
Subject: Re: Command timeouts with NVMe TCP kernel driver
To: Samuel Jones <sjones@kalrayinc.com>, Keith Busch <kbusch@kernel.org>
Cc: linux-nvme <linux-nvme@lists.infradead.org>
References: <1058345072.5039165.1630330229081.JavaMail.zimbra@kalray.eu>
 <20210831023712.GA4046@dhcp-10-100-145-180.wdc.com>
 <1306302519.5246175.1630450012705.JavaMail.zimbra@kalray.eu>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <6e2770ca-c0ea-872a-377e-a17fa12961d9@grimberg.me>
Date: Wed, 1 Sep 2021 16:21:49 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1306302519.5246175.1630450012705.JavaMail.zimbra@kalray.eu>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210901_062153_684705_4743B842 
X-CRM114-Status: GOOD (  48.66  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>>> Hi all,
>>>
>>> I'm experiencing command timeouts with recent versions of nvme-tcp driver. I
>>> have set up with a VM running 5.8 which is ok, but the same test load (100%RD
>>> 16K blocks) on a VM 5.11 or later, including 5.14-rc7, shows the same issue.
>>> The initatior complains as follows:
>>>
>>> Aug 30 14:58:05 centos7 kernel: nvme nvme0: queue 7: timeout request 0x10 type 4
>>> Aug 30 14:58:05 centos7 kernel: nvme nvme0: starting error recovery
>>>
>>> My target is a Kalray target, but I have no trace of any outstanding commands
>>> when this situation occurs. Quite the opposite: The Kalray board observes that
>>> the initiator stops sending new requests on the queue some time before this
>>> command times out.
>>>
>>> I don't have any similar issues using SPDK as an initiator. I made the following
>>> modification to nvme-tcp code and my problem has disappeared:
>>>
>>> --- a/drivers/nvme/host/tcp.c
>>> +++ b/drivers/nvme/host/tcp.c
>>> @@ -287,6 +287,7 @@ static inline void nvme_tcp_queue_request(struct
>>> nvme_tcp_request *req,
>>> * directly, otherwise queue io_work. Also, only do that if we
>>> * are on the same cpu, so we don't introduce contention.
>>> */
>>> +#if 0
>>> if (queue->io_cpu == raw_smp_processor_id() &&
>>> sync && empty && mutex_trylock(&queue->send_mutex)) {
>>> queue->more_requests = !last;
>>> @@ -296,6 +297,9 @@ static inline void nvme_tcp_queue_request(struct
>>> nvme_tcp_request *req,
>>> } else if (last) {
>>> queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
>>> }
>>> +#else
>>> + queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
>>> +#endif
>>> }
>>>
>>> To be honest, this bit of code has always bothered me: I don't understand how we
>>> can guarantee that the thread doesn't change CPU between the call to
>>> raw_smp_processor_id() and the trylock. I assume that even if this does occur,
>>> the fact that we hold queue->send_mutex() is supposed to make sure that there
>>> are no atomicity issues, but I'm concerned about the logic that tries to
>>> determine if there is any more pending work and reschedule io_work if and only
>>> if there is something to do. I can't pinpoint an issue from just reading the
>>> code though..
>>>
>>> Does anyone have any thoughts on this? Is my patch proof that there is an issue
>>> in this code, or am I likely to be changing the program flow so significantly
>>> that we can't conclude? Are there any open issues wrt command timeouts at the
>>> moment?
>>
>> I've seen similar, but I thought we'd fixed all those issues. Your poc
>> patch indicates to me that there is still at least another condition
>> that's not being considered. I don't think the possibility of CPU
>> rescheduling is the culprit, though.
>>
>> One thing that looks problematic is if 'bd.last' is true but
>> nvme_tcp_queue_rq() fails early after enqueuing previous commands in the
>> sequence. That could cause the io_work to never kick. There should have
>> been something else in dmesg indicating that error, though, so I'll look
>> for some other possibility.
>>
> 
> Thanks for your help on this Keith. I think I have a better idea about what is happening now. First of all, I have a large number of devices exposed over NVMe-TCP: I'm connecting to 4 remote NVMe devices each of which is multi-namespace, so I have a total of 37 block devices at once.

That shouldn't matter really, what matters is the number of controllers 
that you have. you have 4 controllers, and how many queues are there 
per-controller? and how many cores does the VM have?

> Then I run a userspace benchmark that's running 8 threads per block device and generating IO to each of them. I'm not sure how the multi queue block devices are layered over the X NVMe queues per device, but however it works my system is on its knees. I have been timestamping the time spent by NVMe-TCP threads inside kernel_sendpage() within nvme_tcp_try_send_cmd_pdu() when called from nvme_tcp_queue_rq() and I'm getting some ridiculous outliers : up to 60 seconds. I am confident this is what is responsible for my timeouts. If I increase the nvme_io_timeout to 300 seconds, my test case passes.

That is strange indeed. what are you taking the timing on? just
kernel_sendpage?

> What's interesting is my quick patch that removed the direct call to kernel_sendpage via queue_rq() makes the system behave much better: no more outliers and no timeouts. I don't know much about the kernel network stack or the block device layer but I imagine that the difference is due to the number of calls into the network stack that can happen in parallel. Is queue_rq executed from the context of the userspace caller? In this case I will have close to 300 threads active on this code path. Whereas when we go through the workqueue, I guess we have only N max calls into the network stack at once, where N = the number of CPUs on the system?
> 
> What do you think? Does my analysis make any sense?

I don't think this is related to the number of contexts you have running 
against the namespaces.

However, the difference between the submission from queue_rq and the
workqueue is that queue_rq may happen concurrently and hence may be
blocked by the socket mutex as the io_work does RX. Now I guess that
if RX is intensive (and it sounds like it is in your test) that the
TX path would be potentially starved...

But if the RX is so intensive, then I'd expect you to have timeouts
regardless as the context is not performing sends anyways, but maybe
this needs a bit more thought...

If this theory is correct, then a possible reason for the big delay
inside kernel_sendpage is due to the fact that io_work just ingest as 
much as the stack gives it (which can be a lot). If we were to break
the recvs into fixed chunks, it would allow to send between recvs and
avoid this potential starvation.

Will it be possible to tryout this untested patch?
--
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 032e8d582e6d..ec05b26cee38 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -837,6 +837,7 @@ static int nvme_tcp_recv_skb(read_descriptor_t 
*desc, struct sk_buff *skb,
                 }
         }

+       desc->count -= consumed;
         return consumed;
  }

@@ -1107,7 +1108,7 @@ static int nvme_tcp_try_recv(struct nvme_tcp_queue 
*queue)
         int consumed;

         rd_desc.arg.data = queue;
-       rd_desc.count = 1;
+       rd_desc.count = 0x4000; /* 16k */
         lock_sock(sk);
         queue->nr_cqe = 0;
         consumed = sock->ops->read_sock(sk, &rd_desc, nvme_tcp_recv_skb);
--

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
