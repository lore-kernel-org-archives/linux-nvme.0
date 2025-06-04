Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FE42C5B552
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Jun 2025 07:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xJPaiZJsxvLRj8n9GtUojsvWhjC5TJnVjUXCQvcGx+o=; b=FIUlP1NeHAyqCG5QatK2WvRXIv
	3Iq0jucuIKzdrGxbBowcAjV+vmA860AsLwDuapDuYaFH1y/NlFt6IvV5xXRqkgFWxJEn5x0LKrHhf
	Z6K2TGCuvQpIJhHaNf1csjJ8+8NbcRLbBzvQ0fJJGR7+t8k3q1I53Xu0EbZ/Bbp7DUMLqhz5SyRsz
	ur8J2mvTaNCaAVjpKcV4C30X3Skp5eKxqLZ1FIGRFTuPGybsO9XL97fXhQ613DXGKlDwv5d/k9vLM
	p+BN+t3qhgtYSamWocGBMG6ymhbOI+1EokzN08Gr9dCYz8HPEvdQbM/jrwx1/BKUKbSWH7cbPT1iD
	9B2PhVBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uMiGF-0000000CjmZ-3pzc;
	Wed, 04 Jun 2025 07:10:07 +0000
Received: from mail-wm1-f53.google.com ([209.85.128.53])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uMiGD-0000000Cjkr-0ur1
	for linux-nvme@lists.infradead.org;
	Wed, 04 Jun 2025 07:10:07 +0000
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-450cf214200so59878715e9.1
        for <linux-nvme@lists.infradead.org>; Wed, 04 Jun 2025 00:10:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749021003; x=1749625803;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xJPaiZJsxvLRj8n9GtUojsvWhjC5TJnVjUXCQvcGx+o=;
        b=e2tUWymoMclmwkAkEMHrhmdmh6xaRYjxKayaAEE/AQcIADAmTc5rFhVE2YA3DvvO4v
         XjW9a4JIaUtEDNLFZ3idIDtrLrZfJGaa1uww+o7VafCgZAy6KvlnJHA1ABgNZcii5Khz
         oseZVRHp7Hm0SNJ72lqZMO0Zng6t35EQVjmELhLqGcDbpKc1hnA5V4my8Avd5N8fks7Y
         2UFnSNL/2RRT3p4zIIh+MnNqu05sbmEZxFlnBE3GoWRQ4zqjyuJLCEZSicqAFR81w9CJ
         q4QeXQfe0G1iOSLVAbc80vyopJ0uAMmmjkJ832BmmgYUgfvMUtFdTCcdz29VS+cU48bm
         YGlQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/TjEzxtBvMnWT4CKx2ITJaBHk2RHBFEp/CvgOHCnde/EerftkBDnfBgB+8OqPD6ELb9kBeZuKLr2K@lists.infradead.org
X-Gm-Message-State: AOJu0YyGrTK4PnnL7irV+Kz138p5BcmndCYH23GTEbFKkbvngPZQA9Ql
	TVILLjC9XVHo6Iq3bmL/HmaTTuSwANslSv9hnIkTVISNclkp3T+GNyG2
X-Gm-Gg: ASbGncu37wW3PfptA0p6hudlHoZQEZPEmVR7/Yc3E42J4rFCqR1N11jJQyw2ul5ev7a
	MjIcS2l5B0JARXKhVCGfzV8XsCyHRu8cr38dp2prdWCbm10rkBDGNZxYEOl3G6uQaX6LHNspeva
	lD+NufTRwJWoGefrRlcgPss0sPaqWbw9d6uxbh/wBXqAooK0Lc84iocH4yeolI4H2mZ+D21wDZe
	okWEBLBFz2DmjsIViDO/q+iOQkMryDNoG5i4BeQbSa0zo8xlDPj1uQ0DRDR8AURJGtv9WTXoE4b
	nwX+BidlE+D+WpkQgSQ5FXx3y2SafghtOuWGiewWNHvw+aSXROBDiqRU5Sggyfp778jovzsytPf
	/iLYY+DXC9Y8CoF8uJg==
X-Google-Smtp-Source: AGHT+IHon9DfcaPAiiToq2KeOmfxWZMKIYrPebJyfC50rCjcnfdd1+uduc+AwTinWfVAAaGbZImElA==
X-Received: by 2002:a05:600c:a015:b0:442:f8e7:25ef with SMTP id 5b1f17b1804b1-451f0a757bcmr12398775e9.11.1749021003216;
        Wed, 04 Jun 2025 00:10:03 -0700 (PDT)
Received: from [10.50.4.239] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450d7fb0654sm188090925e9.21.2025.06.04.00.10.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Jun 2025 00:10:02 -0700 (PDT)
Message-ID: <86e241dd-9065-4cf0-9c35-8b7502ab2d8a@grimberg.me>
Date: Wed, 4 Jun 2025 10:10:01 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] nvme-tcp: avoid race between nvme scan and reset
From: Sagi Grimberg <sagi@grimberg.me>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-nvme@lists.infradead.org, linux-block <linux-block@vger.kernel.org>
Cc: Hannes Reinecke <hare@kernel.org>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>
References: <20250602043522.55787-1-shinichiro.kawasaki@wdc.com>
 <20250602043522.55787-2-shinichiro.kawasaki@wdc.com>
 <910b31ba-1982-4365-961e-435f5e7611b2@grimberg.me>
Content-Language: en-US
In-Reply-To: <910b31ba-1982-4365-961e-435f5e7611b2@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250604_001005_256469_D78BA43E 
X-CRM114-Status: GOOD (  26.31  )
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



On 03/06/2025 13:58, Sagi Grimberg wrote:
>
>
> On 02/06/2025 7:35, Shin'ichiro Kawasaki wrote:
>> When the nvme scan work and the nvme controller reset work race, the
>> WARN below happens:
>>
>>    WARNING: CPU: 1 PID: 69 at block/blk-mq.c:330 
>> blk_mq_unquiesce_queue+0x8f/0xb0
>>
>> The WARN can be recreated by repeating the blktests test case nvme/063 a
>> few times [1]. Its cause is the new queue allocation for the tag set
>> by the scan work between blk_mq_quiesce_tagset() and
>> blk_mq_unquiesce_tagset() calls by the reset work.
>>
>> Reset work                     Scan work
>> ------------------------------------------------------------------------
>> nvme_reset_ctrl_work()
>>   nvme_tcp_teardown_ctrl()
>>    nvme_tcp_teardown_io_queues()
>>     nvme_quiesce_io_queues()
>>      blk_mq_quiesce_tagset()
>>       list_for_each_entry()                                 .. N queues
>>        blk_mq_quiesce_queue()
>>                                 nvme_scan_work()
>>                                  nvme_scan_ns_*()
>>                                   nvme_scan_ns()
>>                                    nvme_alloc_ns()
>>                                     blk_mq_alloc_disk()
>>                                      __blk_mq_alloc_disk()
>>                                       blk_mq_alloc_queue()
>> blk_mq_init_allocate_queue()
>> blk_mq_add_queue_tag_set()
>>                                          list_add_tail()    .. N+1 
>> queues
>>   nvme_tcp_setup_ctrl()
>>    nvme_start_ctrl()
>>     nvme_unquiesce_io_queues()
>>      blk_mq_unquiesce_tagset()
>>       list_for_each_entry()                                 .. N+1 
>> queues
>>        blk_mq_unquiesce_queue()
>>         WARN_ON_ONCE(q->quiesce_depth <= 0)
>>
>> blk_mq_quiesce_queue() is not called for the new queue added by the scan
>> work, while blk_mq_unquiesce_queue() is called for it. Hence the WARN.
>>
>> To suppress the WARN, avoid the race between the reset work and the scan
>> work by flushing the scan work at the beginning of the reset work.
>>
>> Link: 
>> https://lore.kernel.org/linux-nvme/6mhxskdlbo6fk6hotsffvwriauurqky33dfb3s44mqtr5dsxmf@gywwmnyh3twm/ 
>> [1]
>> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
>> ---
>>   drivers/nvme/host/tcp.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
>> index f6379aa33d77..14b9d67329b3 100644
>> --- a/drivers/nvme/host/tcp.c
>> +++ b/drivers/nvme/host/tcp.c
>> @@ -2491,6 +2491,9 @@ static void nvme_reset_ctrl_work(struct 
>> work_struct *work)
>>           container_of(work, struct nvme_ctrl, reset_work);
>>       int ret;
>>   +    /* prevent racing with ns scanning */
>> +    flush_work(&ctrl->scan_work);
>
> This is a problem. We are flushing a work that is IO bound, which can 
> take a long time to complete.
> Up until now, we have deliberately avoided introducing dependency 
> between reset forward progress
> and scan work IO to completely finish.
>
> I would like to keep it this way.
>
> BTW, this is not TCP specific.

blk_mq_unquiesce_queue is still very much safe to call as many times as 
we want.
The only thing that comes in the way is this pesky WARN. How about we 
make it go away and have
a debug print instead?

My preference would be to allow nvme to unquiesce queues that were not 
previously quiesced (just
like it historically was) instead of having to block a controller reset 
until the scan_work is completed (which
is admin I/O dependent, and may get stuck until admin timeout, which can 
be changed by the user for 60
minutes or something arbitrarily long btw).

How about something like this patch instead:
--
diff --git a/block/blk-mq.c b/block/blk-mq.c
index c2697db59109..74f3ad16e812 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -327,8 +327,10 @@ void blk_mq_unquiesce_queue(struct request_queue *q)
         bool run_queue = false;

         spin_lock_irqsave(&q->queue_lock, flags);
-       if (WARN_ON_ONCE(q->quiesce_depth <= 0)) {
-               ;
+       if (q->quiesce_depth <= 0) {
+               printk(KERN_DEBUG
+                       "dev %s: unquiescing a non-quiesced queue, 
expected?\n",
+                       q->disk ? q->disk->disk_name : "?", );
         } else if (!--q->quiesce_depth) {
                 blk_queue_flag_clear(QUEUE_FLAG_QUIESCED, q);
                 run_queue = true;
--

