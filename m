Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1041AC369C2
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Apr 2025 22:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sFQ/EWsnGNlByweJUp2GfryScJQ5T/1jliWXFwWbuKs=; b=W362XHUOa1eZ3VecPMaCVuy6I+
	PdzAQ1pVwPAzCxLNsGTh8znHsU50rQdJcyCdPRYYidU5SxGXUneVR3dBirg5YmOaMjCKxF4L21thA
	Wtdw5ubZ8izxHIUjT1e3LGjvAafuvX6sb7wEq/auWjKgcYnl4LkNWkotYokcWP/AZc4wtUuSmzW51
	mcaF3157aKZIfTr/boDnU4EZB0u1UjF5+vgJYDtd4VUMdXwBB0zMBWfc4UC34Sve/hrhKTOKysVTu
	ZIO48vhgcMlnYkbpT8iiVtcHXqrN0DTlPegQFDdtg4rSByiaB9WdQeKi/zw6z7upWdnTnMHYjA526
	oRJ5APYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5AwZ-0000000B0p8-0Edq;
	Wed, 16 Apr 2025 22:09:19 +0000
Received: from mail-ej1-f51.google.com ([209.85.218.51])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5AwW-0000000B0of-3fkV
	for linux-nvme@lists.infradead.org;
	Wed, 16 Apr 2025 22:09:18 +0000
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-acb5ec407b1so9784866b.1
        for <linux-nvme@lists.infradead.org>; Wed, 16 Apr 2025 15:09:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744841354; x=1745446154;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sFQ/EWsnGNlByweJUp2GfryScJQ5T/1jliWXFwWbuKs=;
        b=DgErXyPxVUhjMvVmTmLz9tabGiJX5IqvF29dPtg74FU1kEXj2zYucahE+1Kw5Oslef
         MDQrx2nMyKksyynNfATmaiKHu7QJPHT9OMdfZbzK8mj/f9r8JtSLn43tsmBepcxk00dr
         RP/WC83xiGxRqK+CfVmKsWgOiDZJzADfwxVw73WrhYvZRWyEu1VTXl/x4j7KOHqfzScS
         lDCS5x4/FAbg1mMJ/orDMKgIWd31j5ME9mgUSdaO5pvygDyrWyNnoBXys23JdQr+YrC3
         l1by+Xm3O97Tjo9ImdWn0PG154UcHJK88lH1vYQUxMIiqYeII4jMfKoKTGxXC8Jdvp2i
         v7QQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhS6LZDWKA+FuvU7IbcrH2Fe+5XpKDY7i2T4MzuQrwFeXi03sQEWnPJHOzJCnjCDMwL0TQtktkj21k@lists.infradead.org
X-Gm-Message-State: AOJu0YyD8942rAwzh8zYSsQMdDUb5tUprpbuFKntObkEHWoZX+q+Xsu8
	XheUFmWeK+QgE+7beiZf9Sdn0BlGau1Gr/RWlc7Os5upRqF69z1E
X-Gm-Gg: ASbGncsECwnYBw3/xaNQhRCb5+fZFcCI7BD7eiYJi7SQBLAVGYxfm0avxdUeOdCaLnN
	3ZzswmTXEG3RDLcS+xPUhAFK+Bq7yzliEGnNHZ8GuX1yukGxxMnE2FOOVvFCmjG1Ze4uw4oRpne
	QoAN7HevSL8nr7bVCxU8or6iBONNv19FMSb2hvd8hPuu2LjkXgfCeoyhGqbNJ+8sgkIdme7xpf8
	4Z99m07/ICF7jLaIyifaSi0BshhRuE8cJN1V0cB8AjYpLDQUo09WcN22ZtD5CTH/K5+H6gMsZ6p
	ezujUT5loyxAu+cqmf8h8tdjky5M89QZCeOW2Gp15wbPw9mVUdMjhcBcrWkIVzmXxfNh/qSq1oS
	yBSvVG1I=
X-Google-Smtp-Source: AGHT+IHxD/7ei2qD3Ew9ANqk4uijFluK6zMkNkVqZ8/8pLQuvJytLBya0zJpqYlPTU9Kx1NmtF+vjg==
X-Received: by 2002:a17:906:f585:b0:ac8:17a1:e42 with SMTP id a640c23a62f3a-acb429860b3mr272337966b.22.1744841354146;
        Wed, 16 Apr 2025 15:09:14 -0700 (PDT)
Received: from [10.10.9.121] (u-1j-178-175-199.4bone.mynet.it. [178.175.199.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acb3d1c896esm192076966b.135.2025.04.16.15.09.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Apr 2025 15:09:13 -0700 (PDT)
Message-ID: <dac1d594-cf64-41ce-8a23-4b246db75b83@grimberg.me>
Date: Thu, 17 Apr 2025 01:09:12 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] nvme-tcp: fix I/O stalls on congested sockets
To: Hannes Reinecke <hare@suse.de>, Hannes Reinecke <hare@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Chris Leech <cleech@redhat.com>
References: <20250403065522.90807-1-hare@kernel.org>
 <20250403065522.90807-4-hare@kernel.org>
 <1edc23f5-eb48-4006-a2f4-d303b05bd3e0@suse.de>
 <e7371b8a-e0b3-4387-a941-292e1f46b2aa@grimberg.me>
 <5446ef17-d922-4467-9a3c-5001713cc260@suse.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <5446ef17-d922-4467-9a3c-5001713cc260@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250416_150916_937949_A67B338F 
X-CRM114-Status: GOOD (  38.47  )
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



On 16/04/2025 10:56, Hannes Reinecke wrote:
> On 4/15/25 23:35, Sagi Grimberg wrote:
>>
>>
>> On 15/04/2025 10:07, Hannes Reinecke wrote:
>>> On 4/3/25 08:55, Hannes Reinecke wrote:
>>>> When the socket is busy processing nvme_tcp_try_recv() might
>>>> return -EAGAIN, but this doesn't automatically imply that
>>>> the sending side is blocked, too.
>>>> So check if there are pending requests once nvme_tcp_try_recv()
>>>> returns -EAGAIN and continue with the sending loop to avoid
>>>> I/O stalls.
>>>>
>>>> Acked-by: Chris Leech <cleech@redhat.com>
>>>> Signed-off-by: Hannes Reinecke <hare@kernel.org>
>>>> ---
>>>>   drivers/nvme/host/tcp.c | 5 ++++-
>>>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
>>>> index 1a319cb86453..87f1d7a4ea06 100644
>>>> --- a/drivers/nvme/host/tcp.c
>>>> +++ b/drivers/nvme/host/tcp.c
>>>> @@ -1389,9 +1389,12 @@ static void nvme_tcp_io_work(struct 
>>>> work_struct *w)
>>>>           result = nvme_tcp_try_recv(queue);
>>>>           if (result > 0)
>>>>               pending = true;
>>>> -        else if (unlikely(result < 0))
>>>> +        else if (unlikely(result < 0) && result != -EAGAIN)
>>>>               return;
>>>>   +        if (nvme_tcp_queue_has_pending(queue))
>>>> +            pending = true;
>>>> +
>>>>           if (!pending || !queue->rd_enabled)
>>>>               return;
>>>
>>> The various 'try_send' function will return -EAGAIN for a partial send.
>>> But it doesn't indicate a blocked Tx, rather we should retry directly.
>>> Hence this check.
>>>
>>> Unless you tell me differently and even a partial send will cause
>>> ->write_space() to be invoked, then we wouldn't _need_ it.
>>
>> Umm, that is my understanding. If you tried to send X and were able to
>> send Y where Y < X, you shouldn't have to keep trying in a busy loop, 
>> the stack should tell you when you can send again.
>>
> Okay, I could try that.
>
>>> It would
>>> still be an optimisation as we're saving the round-trip via socket
>>> callbacks.
>>
>> But you are doing a busy loop on a socket that cannot accept new 
>> data, there are other sockets that the kthread can be working on.
>>
> But we might be _sending_ data, right?

I'd say that odds are you're not in the next attempt...

>
>>>
>>> We could aim for a different error here, to differentiate between a
>>> 'real' EAGAIN and a partial send.
>>> Whatever you prefer.
>>
>> I still don't understand why a partial send warrants a busy loop call 
>> to sock_sendmsg...
>>
> This is, it's not just sendmsg. It's the combination of send and recv.

I agree with you that the recv fix is correct.

> In my tests I have seen sendmsg return with a partial/incomplete status,
> consequently recvmsg has nothing to receive, and io_work stops.
> And that is what the patch fixes.

The question is if the recv fix is sufficient?

>
> I haven't checked the ->write_space() callback (which should've been 
> triggered), but my feeling is that the ->write_space() callback
> hit when we were still busy processing, so the queue_work() went
> nowhere.

That makes sense.

>
> Maybe we can fix it with setting a flag when ->write_space()
> triggers ('hey, more data to process'), to be evaluated during
> the io_work() loop. But that would be pretty close to the
> check 'nvme_tcp_queue_has_pending', so I'm not sure if we
> gain anything.

How about checking sk_stream_is_writeable() instead?
I think we also need to flag the queue for the write_space during IO work...

>
> And I really haven't seen any detrimental performance effects
> with this patch; in the contrary, performance was on par,
> and if anything standard deviation went down.

Still you agree that busy looping a socket that may not have space is 
less efficient?
When there are other queues waiting to execute io_work?

I agree there is a problem here, but I am trying to figure out what we 
want to do here.

How about these two (untested) patches:
[1 based on your recv-side fix]:
--diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 72d260201d8c..4eb9a2dec07e 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1348,7 +1348,7 @@ static int nvme_tcp_try_recv(struct nvme_tcp_queue 
*queue)
         queue->nr_cqe = 0;
         consumed = sock->ops->read_sock(sk, &rd_desc, nvme_tcp_recv_skb);
         release_sock(sk);
-       return consumed;
+       return consumed == -EAGAIN ? 0 : consumed;
  }

  static void nvme_tcp_io_work(struct work_struct *w)
--

[2 based on your partial write fix]:
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 4eb9a2dec07e..daf59e75cf15 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -129,6 +129,7 @@ enum nvme_tcp_queue_flags {
         NVME_TCP_Q_LIVE         = 1,
         NVME_TCP_Q_POLLING      = 2,
         NVME_TCP_Q_IO_CPU_SET   = 3,
+       NVME_TCP_Q_WAKE_SENDER  = 4,
  };

  enum nvme_tcp_recv_state {
@@ -1063,6 +1064,7 @@ static void nvme_tcp_write_space(struct sock *sk)
         queue = sk->sk_user_data;
         if (likely(queue && sk_stream_is_writeable(sk))) {
                 clear_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
+               set_bit(NVME_TCP_Q_WAKE_SENDER, &queue->flags);
                 queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
         }
         read_unlock_bh(&sk->sk_callback_lock);
@@ -1357,6 +1359,7 @@ static void nvme_tcp_io_work(struct work_struct *w)
                 container_of(w, struct nvme_tcp_queue, io_work);
         unsigned long deadline = jiffies + msecs_to_jiffies(1);

+       clear_bit(NVME_TCP_Q_WAKE_SENDER, &queue->flags);
         do {
                 bool pending = false;
                 int result;
@@ -1376,7 +1379,15 @@ static void nvme_tcp_io_work(struct work_struct *w)
                 else if (unlikely(result < 0))
                         return;

-               if (!pending || !queue->rd_enabled)
+               /* did we get some space after spending time in recv ? */
+               if (nvme_tcp_queue_has_pending(queue) &&
+                   sk_stream_is_writeable(queue->sock->sk))
+                       pending = true;
+
+               if (!queue->rd_enabled)
+                       return;
+
+               if (!pending && !test_bit(NVME_TCP_Q_WAKE_SENDER, 
&queue->flags))
                         return;

         } while (!time_after(jiffies, deadline)); /* quota is exhausted */
--

