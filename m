Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D7CCC369C2
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Apr 2025 22:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AWC3OGqnlpjQp80SgP+UTWaVedrLG/FMAwbtsEL42zE=; b=BEtS9xvUMRhf8ruj/WCzqqA9tL
	Nvt0RedMKwSHOGRS0PIXis+CSrt4v+Nk+SjW2pJLycqtZ3kRXZJszr7iuL1V0l/2WBLrwKrRz10Xb
	tQ0OD9emMVLDzwxsElTgo/mwMot2gbUJcsDxT/RtZQSN8koNwQBl/igNsLyjwKLCF/cDO9X4gmGpE
	TDAWJdQFpT+DT1IxO/2z6NjpVzb9vyR1ULM+8nQMLG9QVfvWjv6/AAosecgymB9GZSdviN2R+KM59
	BeM+hwpgWw+B5frSMKDUATVK1oXM6U09Mpv6bUbihzW5IICyhzwMPzw+DSr1+wEYvzLP/pUsxcTTJ
	5NyATbJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8RER-0000000118t-2quT;
	Fri, 25 Apr 2025 22:09:15 +0000
Received: from mail-wm1-f47.google.com ([209.85.128.47])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8REO-0000000118T-3l61
	for linux-nvme@lists.infradead.org;
	Fri, 25 Apr 2025 22:09:14 +0000
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43cfe63c592so27087715e9.2
        for <linux-nvme@lists.infradead.org>; Fri, 25 Apr 2025 15:09:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745618951; x=1746223751;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AWC3OGqnlpjQp80SgP+UTWaVedrLG/FMAwbtsEL42zE=;
        b=K2uS7AduvmCf514XcFJW6lw1qGMT+Bz2cfQSdrlKPVbJOkOaakiwTKanN3+nHwCw2l
         dOxXZbA91pYujPV18lu+i6x7OC5gnRmhtqaosuash4kUmSRn2jwmeupPl3iyYNslbOVh
         fvvzqaqon412sXqksM5sN7mYkjCDco0vXXRiOX4T4NjNXuyuSftIcGpvT6T39H/RXDVP
         sxpjw5Nxp1njEMF7MIV12QedK+jHTyuspC1/fM4CoKDdvkv9HOXdp1diFUPRE2VnAarw
         OWEOznHFGyJeBQv+z4TCRZH1Zxq5I3XiaoOpfeEyQahEGjD1apey/Q0SveFnx/0Hh3x3
         Nv4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWrl+7q+lfor/SQjkGvX5Uzbm+2kqlI735pkseIQWSGYb+QDPLnw6wOOp1V3mvpcjuy5ozXIbS3s06e@lists.infradead.org
X-Gm-Message-State: AOJu0YxNo/Px0zuqrrvd0dYKgxGfUggoIWCm/wLA3QR1vuE0bm76FSHt
	yrHfFVSziggFjFHju91+m8yzLNByAWZmeTYp3mpUC4vD+9Sx9Mwn
X-Gm-Gg: ASbGncuf6VLdYs2F7Vz/Vq2KR/itnIZGxq4nj+dddT5fn8q0iZt+B4bO5k3oEU8KJWd
	3zMNw1gr6wNInWIdmWBsZetHSl+kGzFD46UXUhmb3vUlTBhDDgaPgpr5TYBLSDz5VWRkq9Vgm78
	1FpsxGJpw+nrXeNSs8OyzdXTQhrKwz2z1bJkN7ymm/lN42HjCh++Y6F6Ec3/4wmiwkDh5MI0XPI
	HOps4u9VhqaBdRVSFE9GWziPF/d2Y6r9xSS/t7s1uXHKmsQ5Pzc9Ocay4NnUl4ua2Is4EcpnrX7
	Yu5UA0KsyKpXYkSCPhVAlwq2TgsTuslP7+/Z9rIb
X-Google-Smtp-Source: AGHT+IG4TvOOIsaHK5yVJr9MgkfbjVzALRauF//Butl/przMzboyR7VWXGmcm2eRhG9ZITtv3crzog==
X-Received: by 2002:a05:600c:3d87:b0:43c:f895:cb4e with SMTP id 5b1f17b1804b1-440aa428e25mr17335605e9.17.1745618951053;
        Fri, 25 Apr 2025 15:09:11 -0700 (PDT)
Received: from [10.100.102.74] ([95.35.174.203])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4409d2d8154sm69305765e9.30.2025.04.25.15.09.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Apr 2025 15:09:10 -0700 (PDT)
Message-ID: <30b16579-1a28-4d01-9afd-8ff3996db42d@grimberg.me>
Date: Sat, 26 Apr 2025 01:09:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] nvme-tcp: fix I/O stalls on congested sockets
From: Sagi Grimberg <sagi@grimberg.me>
To: Hannes Reinecke <hare@suse.de>, Hannes Reinecke <hare@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Chris Leech <cleech@redhat.com>
References: <20250403065522.90807-1-hare@kernel.org>
 <20250403065522.90807-4-hare@kernel.org>
 <1edc23f5-eb48-4006-a2f4-d303b05bd3e0@suse.de>
 <e7371b8a-e0b3-4387-a941-292e1f46b2aa@grimberg.me>
 <5446ef17-d922-4467-9a3c-5001713cc260@suse.de>
 <dac1d594-cf64-41ce-8a23-4b246db75b83@grimberg.me>
 <eda7a691-037b-442d-bd36-a31f93e95cb1@suse.de>
 <976af4b7-578b-4e47-a2ff-7c74af0b9afa@grimberg.me>
Content-Language: en-US
In-Reply-To: <976af4b7-578b-4e47-a2ff-7c74af0b9afa@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250425_150912_936359_F2318010 
X-CRM114-Status: GOOD (  33.45  )
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



On 26/04/2025 0:55, Sagi Grimberg wrote:
>
>
> On 24/04/2025 14:26, Hannes Reinecke wrote:
>> On 4/17/25 00:09, Sagi Grimberg wrote:
>>>
>>>
>>> On 16/04/2025 10:56, Hannes Reinecke wrote:
>>>> On 4/15/25 23:35, Sagi Grimberg wrote:
>>>>>
>>>>>
>>>>> On 15/04/2025 10:07, Hannes Reinecke wrote:
>>>>>> On 4/3/25 08:55, Hannes Reinecke wrote:
>>>>>>> When the socket is busy processing nvme_tcp_try_recv() might
>>>>>>> return -EAGAIN, but this doesn't automatically imply that
>>>>>>> the sending side is blocked, too.
>>>>>>> So check if there are pending requests once nvme_tcp_try_recv()
>>>>>>> returns -EAGAIN and continue with the sending loop to avoid
>>>>>>> I/O stalls.
>>>>>>>
>>>>>>> Acked-by: Chris Leech <cleech@redhat.com>
>>>>>>> Signed-off-by: Hannes Reinecke <hare@kernel.org>
>>>>>>> ---
>>>>>>>   drivers/nvme/host/tcp.c | 5 ++++-
>>>>>>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>>>>>>
>>>>>>> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
>>>>>>> index 1a319cb86453..87f1d7a4ea06 100644
>>>>>>> --- a/drivers/nvme/host/tcp.c
>>>>>>> +++ b/drivers/nvme/host/tcp.c
>>>>>>> @@ -1389,9 +1389,12 @@ static void nvme_tcp_io_work(struct 
>>>>>>> work_struct *w)
>>>>>>>           result = nvme_tcp_try_recv(queue);
>>>>>>>           if (result > 0)
>>>>>>>               pending = true;
>>>>>>> -        else if (unlikely(result < 0))
>>>>>>> +        else if (unlikely(result < 0) && result != -EAGAIN)
>>>>>>>               return;
>>>>>>>   +        if (nvme_tcp_queue_has_pending(queue))
>>>>>>> +            pending = true;
>>>>>>> +
>>>>>>>           if (!pending || !queue->rd_enabled)
>>>>>>>               return;
>>>>>>
>>>>>> The various 'try_send' function will return -EAGAIN for a partial 
>>>>>> send.
>>>>>> But it doesn't indicate a blocked Tx, rather we should retry 
>>>>>> directly.
>>>>>> Hence this check.
>>>>>>
>>>>>> Unless you tell me differently and even a partial send will cause
>>>>>> ->write_space() to be invoked, then we wouldn't _need_ it.
>>>>>
>>>>> Umm, that is my understanding. If you tried to send X and were 
>>>>> able to
>>>>> send Y where Y < X, you shouldn't have to keep trying in a busy 
>>>>> loop, the stack should tell you when you can send again.
>>>>>
>>>> Okay, I could try that.
>>>>
>>>>>> It would
>>>>>> still be an optimisation as we're saving the round-trip via socket
>>>>>> callbacks.
>>>>>
>>>>> But you are doing a busy loop on a socket that cannot accept new 
>>>>> data, there are other sockets that the kthread can be working on.
>>>>>
>>>> But we might be _sending_ data, right?
>>>
>>> I'd say that odds are you're not in the next attempt...
>>>
>>>>
>>>>>>
>>>>>> We could aim for a different error here, to differentiate between a
>>>>>> 'real' EAGAIN and a partial send.
>>>>>> Whatever you prefer.
>>>>>
>>>>> I still don't understand why a partial send warrants a busy loop 
>>>>> call to sock_sendmsg...
>>>>>
>>>> This is, it's not just sendmsg. It's the combination of send and recv.
>>>
>>> I agree with you that the recv fix is correct.
>>>
>>>> In my tests I have seen sendmsg return with a partial/incomplete 
>>>> status,
>>>> consequently recvmsg has nothing to receive, and io_work stops.
>>>> And that is what the patch fixes.
>>>
>>> The question is if the recv fix is sufficient?
>>>
>>>>
>>>> I haven't checked the ->write_space() callback (which should've 
>>>> been triggered), but my feeling is that the ->write_space() callback
>>>> hit when we were still busy processing, so the queue_work() went
>>>> nowhere.
>>>
>>> That makes sense.
>>>
>>>>
>>>> Maybe we can fix it with setting a flag when ->write_space()
>>>> triggers ('hey, more data to process'), to be evaluated during
>>>> the io_work() loop. But that would be pretty close to the
>>>> check 'nvme_tcp_queue_has_pending', so I'm not sure if we
>>>> gain anything.
>>>
>>> How about checking sk_stream_is_writeable() instead?
>>> I think we also need to flag the queue for the write_space during IO 
>>> work...
>>>
>>>>
>>>> And I really haven't seen any detrimental performance effects
>>>> with this patch; in the contrary, performance was on par,
>>>> and if anything standard deviation went down.
>>>
>>> Still you agree that busy looping a socket that may not have space 
>>> is less efficient?
>>> When there are other queues waiting to execute io_work?
>>>
>>> I agree there is a problem here, but I am trying to figure out what 
>>> we want to do here.
>>>
>>> How about these two (untested) patches:
>>> [1 based on your recv-side fix]:
>>> --diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
>>> index 72d260201d8c..4eb9a2dec07e 100644
>>> --- a/drivers/nvme/host/tcp.c
>>> +++ b/drivers/nvme/host/tcp.c
>>> @@ -1348,7 +1348,7 @@ static int nvme_tcp_try_recv(struct 
>>> nvme_tcp_queue *queue)
>>>          queue->nr_cqe = 0;
>>>          consumed = sock->ops->read_sock(sk, &rd_desc, 
>>> nvme_tcp_recv_skb);
>>>          release_sock(sk);
>>> -       return consumed;
>>> +       return consumed == -EAGAIN ? 0 : consumed;
>>>   }
>>>
>>>   static void nvme_tcp_io_work(struct work_struct *w)
>>> -- 
>>>
>>> [2 based on your partial write fix]:
>>> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
>>> index 4eb9a2dec07e..daf59e75cf15 100644
>>> --- a/drivers/nvme/host/tcp.c
>>> +++ b/drivers/nvme/host/tcp.c
>>> @@ -129,6 +129,7 @@ enum nvme_tcp_queue_flags {
>>>          NVME_TCP_Q_LIVE         = 1,
>>>          NVME_TCP_Q_POLLING      = 2,
>>>          NVME_TCP_Q_IO_CPU_SET   = 3,
>>> +       NVME_TCP_Q_WAKE_SENDER  = 4,
>>>   };
>>>
>>>   enum nvme_tcp_recv_state {
>>> @@ -1063,6 +1064,7 @@ static void nvme_tcp_write_space(struct sock *sk)
>>>          queue = sk->sk_user_data;
>>>          if (likely(queue && sk_stream_is_writeable(sk))) {
>>>                  clear_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
>>> +               set_bit(NVME_TCP_Q_WAKE_SENDER, &queue->flags);
>>>                  queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue- 
>>>  >io_work);
>>>          }
>>>          read_unlock_bh(&sk->sk_callback_lock);
>>> @@ -1357,6 +1359,7 @@ static void nvme_tcp_io_work(struct 
>>> work_struct *w)
>>>                  container_of(w, struct nvme_tcp_queue, io_work);
>>>          unsigned long deadline = jiffies + msecs_to_jiffies(1);
>>>
>>> +       clear_bit(NVME_TCP_Q_WAKE_SENDER, &queue->flags);
>>>          do {
>>>                  bool pending = false;
>>>                  int result;
>>> @@ -1376,7 +1379,15 @@ static void nvme_tcp_io_work(struct 
>>> work_struct *w)
>>>                  else if (unlikely(result < 0))
>>>                          return;
>>>
>>> -               if (!pending || !queue->rd_enabled)
>>> +               /* did we get some space after spending time in recv 
>>> ? */
>>> +               if (nvme_tcp_queue_has_pending(queue) &&
>>> + sk_stream_is_writeable(queue->sock->sk))
>>> +                       pending = true;
>>> +
>>> +               if (!queue->rd_enabled)
>>> +                       return;
>>> +
>>> +               if (!pending && !test_bit(NVME_TCP_Q_WAKE_SENDER, 
>>> &queue->flags))
>>>                          return;
>>>
>>>          } while (!time_after(jiffies, deadline)); /* quota is 
>>> exhausted */
>>> -- 
>>>
>> While trying to sift through the patches trying to come up with
>> a next version:
>> Why do you check for Q_WAKE_SENDER after checking for
>> sk_stream_is_writable?
>> Surely sk_stream_is_writable() is a necessary condition for 
>> nvme_tcp_try_send(), no?
>
> Right after the check sk_stream_is_writeable(), there could have new 
> room in the socket
> send buffer, state_change() fired, and queued io_work, before we get 
> to the pending
> check. This is the "lost event" problem.

Actually, this is incorrect. write_space() -> queue_work(io_work) will 
be re-queued if io_work
is currently running. Hence I'm not sure that this flag is needed.

Kamaljit, can you run with the below and report if it fixes your problem?
--
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 4d20fcc0a230..835e29014841 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1390,6 +1390,11 @@ static void nvme_tcp_io_work(struct work_struct *w)
                 else if (unlikely(result < 0))
                         return;

+               /* did we get some space after spending time in recv? */
+               if (nvme_tcp_queue_has_pending(queue) &&
+                   sk_stream_is_writeable(queue->sock->sk))
+                       pending = true;
+
                 if (!pending || !queue->rd_enabled)
                         return;
--



