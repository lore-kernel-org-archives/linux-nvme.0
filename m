Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D54BC369C9
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Apr 2025 10:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=d7lh68vGB9Q5qCSPY4qSJXzKxs/7qNh9HTtaXcCPM7I=; b=NZh0j0ipLXT2mzQ+ssyFv7a+eF
	HmSuttVdEVcmMrBMuskRxTPhQEGi6+RSyEidLTmEe9PLcvHEl1QxwpLOfnmx6R+JCLJTcneU9BVKh
	m3gKis6bh0bsFy71t83/XzfxMDm1MxzHL2RlxJdRDDkv9nLW9R5q76uhQWTc1rM0YNkzo3P9joGQh
	lkgkjUDGj4c0wWztTUcl6oD831tUoWif0twWXPd4Sk7iW8pvfbLDLkjVK8xGyf98jwNE4/w28QFFK
	A5Ky99LtA+CJHW4bwNl0ydW1jFSmNz4HNDtKOe5q7VI8omojyo26n/6IEPGmoZT+mLuKyNq9/4w0E
	Yp1gPQSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5jJa-0000000FuYX-1NbW;
	Fri, 18 Apr 2025 10:51:22 +0000
Received: from mail-wm1-f43.google.com ([209.85.128.43])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5jJY-0000000FuY2-12tM
	for linux-nvme@lists.infradead.org;
	Fri, 18 Apr 2025 10:51:21 +0000
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43cfebc343dso13915225e9.2
        for <linux-nvme@lists.infradead.org>; Fri, 18 Apr 2025 03:51:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744973478; x=1745578278;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d7lh68vGB9Q5qCSPY4qSJXzKxs/7qNh9HTtaXcCPM7I=;
        b=GYv5fvGUXaLPKKkl/Gb3wfu08NpbQ7/FKgNt0N/4yVsP6KJsSUMrZf7Qk9p4oxj+1w
         fY4vQNq1T6Ic+NTg6rSwuuodg5xOjxHog+05WDjHDdfLAcEEX0Epn6aig/XHCdByApM/
         hWUPvMqdgZyE31ooiyJpjNPdDSAHxGTfOedbCWOceGyZTiJnhRe73ou7KSIOlL0RRFF6
         GDGGPZQ4L/nDHwnS6W/JGXwS1mB7qd83LmVHAR+UKXDQi/KWhNXp4QQC/dWPrxzBfbMH
         i7TVvWFJskxCpae6451XgbQ5E3mCu0zdLv5PYvjZjgg6ZHsh14i9lwofAlJB336Nkl/9
         a27Q==
X-Forwarded-Encrypted: i=1; AJvYcCVrOMnsQBxa+d2W5YofMRg8WXC+91Gch3qb/R7I3zDvRrfIXDqBXv9RBJP+v0V7QTJudFH2K/Gr6ate@lists.infradead.org
X-Gm-Message-State: AOJu0Yzv6PODWfCpCjf8L0l6AglWK8eTjUKUnofwg+K/dtN3+p2ZVY3o
	lie0ZAuZP6S/RJQTszhtlJvz7D7/XmHAyvzXvknbkaK17vGtJPGrcAwYymtp
X-Gm-Gg: ASbGnctiUXrTpDx9hnKV917spBrs5j/9SDq6F1gqTnXYjVtW52obUNE07bi2MY5BvzZ
	ji9MVTwblPJSRbRucTqWF4d6up6+3p+6E9RMzuG1F1lnu003IzzBJktB144gbeUCLtVZbVR1L92
	9yOpjE+n+KWou+tyZSAy/2ZbaTlj6VLQE+UjmOPhpPhwCS/KqdfqCxJQkcfTpLGjLeSKS6885XZ
	+w4d+vxUjKVm2AYWhYAsw4/wDyiAQ9mnlGNultThN2ssyxDYzdttTpPjLUZeeIMaaE+/E2+/QVA
	5vKUp17GVVo3zL7FPPpIJ78nWlDvvFZ3TODUUyxF
X-Google-Smtp-Source: AGHT+IEdcOQDDzc9fXztICZj5NbG/GomTerl3BMFFqybL6qziYgJi8280UGSGVS4apgNA0RSw5edoA==
X-Received: by 2002:a05:600c:3594:b0:43c:fbba:41ba with SMTP id 5b1f17b1804b1-4406ac2035bmr17279025e9.28.1744973477782;
        Fri, 18 Apr 2025 03:51:17 -0700 (PDT)
Received: from [10.100.102.67] ([95.35.174.203])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4406d6db117sm17419105e9.26.2025.04.18.03.51.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Apr 2025 03:51:16 -0700 (PDT)
Message-ID: <ee011198-9a15-44e5-a18e-02d3844ee48b@grimberg.me>
Date: Fri, 18 Apr 2025 13:51:14 +0300
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
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <BY5PR04MB684996C1DB38F3BC4386B55EBCBC2@BY5PR04MB6849.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250418_035120_288220_F5E5BC47 
X-CRM114-Status: GOOD (  16.27  )
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



On 4/18/25 02:03, Kamaljit Singh wrote:
> Sagi,
> I tried both of these patches but looks like #1 causes an infinite loop. dmesg was full of panics.
> I had tried just #1 and later with #1+#2. Both failed the same way.

That's no good :)

Can you share the panics? This version should be identical to what
Hannes introduced in:

@@ -1389,9 +1389,12 @@ static void nvme_tcp_io_work(struct work_struct *w)
  		result = nvme_tcp_try_recv(queue);
  		if (result > 0)
  			pending = true;
-		else if (unlikely(result < 0))
+		else if (unlikely(result < 0) && result != -EAGAIN)
  			return;


>
>> How about these two (untested) patches:
>> [1 based on your recv-side fix]:
>> --diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
>> index 72d260201d8c..4eb9a2dec07e 100644
>> --- a/drivers/nvme/host/tcp.c
>> +++ b/drivers/nvme/host/tcp.c
>> @@ -1348,7 +1348,7 @@ static int nvme_tcp_try_recv(struct nvme_tcp_queue
>> *queue)
>>           queue->nr_cqe = 0;
>>           consumed = sock->ops->read_sock(sk, &rd_desc, nvme_tcp_recv_skb);
>>           release_sock(sk);
>> -       return consumed;
>> +       return consumed == -EAGAIN ? 0 : consumed;
>>    }
>>
>>    static void nvme_tcp_io_work(struct work_struct *w)
>> --
>>
>> [2 based on your partial write fix]:
>> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
>> index 4eb9a2dec07e..daf59e75cf15 100644
>> --- a/drivers/nvme/host/tcp.c
>> +++ b/drivers/nvme/host/tcp.c
>> @@ -129,6 +129,7 @@ enum nvme_tcp_queue_flags {
>>           NVME_TCP_Q_LIVE         = 1,
>>           NVME_TCP_Q_POLLING      = 2,
>>           NVME_TCP_Q_IO_CPU_SET   = 3,
>> +       NVME_TCP_Q_WAKE_SENDER  = 4,
>>    };
>>
>>    enum nvme_tcp_recv_state {
>> @@ -1063,6 +1064,7 @@ static void nvme_tcp_write_space(struct sock *sk)
>>           queue = sk->sk_user_data;
>>           if (likely(queue && sk_stream_is_writeable(sk))) {
>>                   clear_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
>> +               set_bit(NVME_TCP_Q_WAKE_SENDER, &queue->flags);
>>                   queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
>>           }
>>           read_unlock_bh(&sk->sk_callback_lock);
>> @@ -1357,6 +1359,7 @@ static void nvme_tcp_io_work(struct work_struct *w)
>>                   container_of(w, struct nvme_tcp_queue, io_work);
>>           unsigned long deadline = jiffies + msecs_to_jiffies(1);
>>
>> +       clear_bit(NVME_TCP_Q_WAKE_SENDER, &queue->flags);
>>           do {
>>                   bool pending = false;
>>                   int result;
>> @@ -1376,7 +1379,15 @@ static void nvme_tcp_io_work(struct work_struct *w)
>>                   else if (unlikely(result < 0))
>>                           return;
>>
>> -               if (!pending || !queue->rd_enabled)
>> +               /* did we get some space after spending time in recv ? */
>> +               if (nvme_tcp_queue_has_pending(queue) &&
>> +                   sk_stream_is_writeable(queue->sock->sk))
>> +                       pending = true;
>> +
>> +               if (!queue->rd_enabled)
>> +                       return;
>> +
>> +               if (!pending && !test_bit(NVME_TCP_Q_WAKE_SENDER,
>> &queue->flags))
>>                           return;
>>
>>           } while (!time_after(jiffies, deadline)); /* quota is exhausted */
>> --
>>   
> -Kamaljit


