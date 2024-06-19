Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB3B3C27C53
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Jun 2024 15:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aXkujdkNjQ1oDqa4zrVebO1f8+rS3Mp/Ml+uvfRE++o=; b=boVPtzIduml183rkON+BTjWFya
	5nrxSTfDNoDHVmIw8rR1bLcnxJnJh6aPZxJCDq8B6oupIQ/5Hk3y/XYZZZvhTwjayVPurn3YSDtfs
	myYqJTb3WZyGy736N9JW+io6Dd6ABaRGHCYD2MymEvdXhDiUj+SC87rcvyWT+EgnoTSXkQmHoX/3H
	GnkWr4He/y0OQUgfn2OAkXhdiTkN1c2SZV2khHTxNVD3WAbfpXOzS94AYZF238nct6bdrh2DIC6X8
	LHcjmE7V3pjjbLCIhFCQe5ymKRrAkzMUuLDUmBY06tekxlzoxo0zv9kdeJT8yjxD/HJ3gVj0g6nPJ
	m2L813aw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJxhf-00000001w3n-19py;
	Wed, 19 Jun 2024 15:58:31 +0000
Received: from mail-wm1-f45.google.com ([209.85.128.45])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJxhZ-00000001w1n-21zT
	for linux-nvme@lists.infradead.org;
	Wed, 19 Jun 2024 15:58:28 +0000
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42111cf2706so2705e9.0
        for <linux-nvme@lists.infradead.org>; Wed, 19 Jun 2024 08:58:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718812704; x=1719417504;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aXkujdkNjQ1oDqa4zrVebO1f8+rS3Mp/Ml+uvfRE++o=;
        b=lPt7kyb+rJ1ZRj1mkyOiG3RsS6W73EfG1tQoBeHfs/mihn7PHETqKIuLOGLElgS29Z
         Ju5iVED9Gqn7mqG4fxWhPwwlMd7pNPFNhxPUfviXfus7/Yqr5f948ggW07KG+nCzXJd9
         UiJXYVggnP8+txGnKy6ealAr1s0UbP51JL5gXlnGPXbOTfNNhiEwDW344/QtcxV8s8Jc
         dWPjktEtNUqPu+cn3BPihlXae82lPRq8erDO8C4zvOthf2NptODJuVz4GF7p+eh+9uAx
         BloHIcqmoTPTyYCpW6xEHH0u1SimqYoryGzH8TJVhpu0v0VNV+SXImOILtIKFpoyWyEe
         5uGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUvXXLB7UL9ta/6eACy7ZZxoT9jEFng54MhtIBQpXAF9OIFRJtcZEnTEbyY6OPd/uRNgUxclnTKySo22WfB96SHttdr/nLEmGl7d88pB8=
X-Gm-Message-State: AOJu0Yyr25ekcx7d0V/BTuJedHHUXYq6vTLMRBCjmmFRBFgr7Rm/98WE
	+svFK812oUuGcEDhoavok0CJzSWKpY/9z6FNaHv/s8a9fRUASF6c
X-Google-Smtp-Source: AGHT+IHGYwrXiqGf2p5hgrvFqJEcASckrY/J80glcwx3JIEK2CD4nk7ScxDCGmrR7C3rYPteNxZANg==
X-Received: by 2002:a05:600c:1d26:b0:421:67db:f251 with SMTP id 5b1f17b1804b1-4247516f320mr20298255e9.1.1718812703719;
        Wed, 19 Jun 2024 08:58:23 -0700 (PDT)
Received: from [10.50.4.180] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4246bddc59bsm95635095e9.5.2024.06.19.08.58.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jun 2024 08:58:23 -0700 (PDT)
Message-ID: <b4dc2a6a-1663-4144-a607-edb6beef48c0@grimberg.me>
Date: Wed, 19 Jun 2024 18:58:22 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2] nvme-tcp: align I/O cpu with blk-mq mapping
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
 Hannes Reinecke <hare@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20240619145553.89736-1-hare@kernel.org>
 <20240619145958.GA2254@lst.de> <d5c87821-54a7-4fb4-9222-501174d6058b@suse.de>
 <f1348234-1dcb-4ac2-a0d4-305c39643a48@grimberg.me>
 <eb0023bc-3a3b-4f31-955b-c6aad4cad4a3@suse.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <eb0023bc-3a3b-4f31-955b-c6aad4cad4a3@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240619_085825_566953_D805CE16 
X-CRM114-Status: GOOD (  22.68  )
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



>> I see how you address multiple controllers falling into the same 
>> mappings case in your patch.
>> You could have selected a different mq_map entry for each controller 
>> (out of the entries that map to the qid).
>>
> Looked at it, but hadn't any idea how to figure out the load.
> The load is actually per-cpu, but we only have per controller structures.
> So we would need to introduce a per-cpu counter, detailing out the
> number of queues scheduled on that CPU.
> But that won't help with the CPU oversubscription issue; we still 
> might have substantially higher number of overall queues than we have 
> CPUs...

I think that it would still be better than what you have right now:

IIUC Right now you will have for all controllers (based on your example):
queue 1: using cpu 6
queue 2: using cpu 9
queue 3: using cpu 18

But selecting a different mq_map entry can give:
ctrl1:
queue 1: using cpu 6
queue 2: using cpu 9
queue 3: using cpu 18

ctrl2:
queue 1: using cpu 7
queue 2: using cpu 10
queue 3: using cpu 19

ctrl3:
queue 1: using cpu 8
queue 2: using cpu 11
queue 3: using cpu 20

ctrl4:
queue 1: using cpu 54
queue 2: using cpu 57
queue 3: using cpu 66

and so on...





>
>>>
>>> Not sure how wq_unbound helps in this case; in theory the workqueue
>>> items can be pushed on arbitrary CPUs, but that only leads to even 
>>> worse
>>> thread bouncing.
>>>
>>> However, topic for ALPSS. We really should have some sore of 
>>> backpressure here.
>>
>> I have a patch that was sitting for some time now, to make the RX 
>> path run directly
>> from softirq, which should make RX execute from the cpu core mapped 
>> to the RSS hash.
>> Perhaps you or your customer can give it a go.
>>
> No s**t. That is pretty much what I wanted to do.
> I'm sure to give it a go.
> Thanks for that!

You will need another prep patch for it:
--
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 3649987c0a2d..b6ea7e337eb8 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -955,6 +955,18 @@ static int nvme_tcp_recv_skb(read_descriptor_t 
*desc, struct sk_buff *skb,
         return consumed;
  }

+static int nvme_tcp_try_recv_locked(struct nvme_tcp_queue *queue)
+{
+       struct socket *sock = queue->sock;
+       struct sock *sk = sock->sk;
+       read_descriptor_t rd_desc;
+
+       rd_desc.arg.data = queue;
+       rd_desc.count = 1;
+       queue->nr_cqe = 0;
+       return sock->ops->read_sock(sk, &rd_desc, nvme_tcp_recv_skb);
+}
+
  static void nvme_tcp_data_ready(struct sock *sk)
  {
         struct nvme_tcp_queue *queue;
@@ -1251,16 +1263,11 @@ static int nvme_tcp_try_send(struct 
nvme_tcp_queue *queue)

  static int nvme_tcp_try_recv(struct nvme_tcp_queue *queue)
  {
-       struct socket *sock = queue->sock;
-       struct sock *sk = sock->sk;
-       read_descriptor_t rd_desc;
+       struct sock *sk = queue->sock->sk;
         int consumed;

-       rd_desc.arg.data = queue;
-       rd_desc.count = 1;
         lock_sock(sk);
-       queue->nr_cqe = 0;
-       consumed = sock->ops->read_sock(sk, &rd_desc, nvme_tcp_recv_skb);
+       consumed = nvme_tcp_try_recv_locked(queue);
         release_sock(sk);
         return consumed;
  }
--

