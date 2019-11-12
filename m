Return-Path: <SRS0=/X2o=ZE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBA36C43331
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Nov 2019 17:35:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92577214E0
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Nov 2019 17:35:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="H+Pr4OOV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92577214E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=LFvNm8LLInPVEBqyJ8NtRkdwDfgvtl1orV8cj/tjB+w=; b=H+Pr4OOVIs4ja2X73fHR+aZKF
	x+mMC0i5IxULqYulQCk3QGxR1U3iUIYuCCGCCDoCbNVMdMdfqndEzGHRQDCPfLHC8in5thM/shhNO
	kev5hGYFk9i2f7Fa4fv+HadD4Qf0sDuz6zh43ZzxZei5tlE9kbTCueO8pKXHi+SELh/I6Lv7gJPJi
	iU6+l8oeIym6aBxIStJpZ6jeKRZHfctvWOy/RtDQNlFJLg78kwvqe0pXsYYmZb3xB79a38lkyDY+h
	GfoutrqzmShWfcQENukdDRuROClYHxg3jyhV14CV+H8+K6SW6qilJAuTbXkJlPUFfaZnVBNmseYtT
	ZrvK8V2xw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iUa4U-0001cu-Mw; Tue, 12 Nov 2019 17:35:18 +0000
Received: from mail-oi1-f194.google.com ([209.85.167.194])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iUa4R-0001b9-Ml
 for linux-nvme@lists.infradead.org; Tue, 12 Nov 2019 17:35:17 +0000
Received: by mail-oi1-f194.google.com with SMTP id s71so15547052oih.11
 for <linux-nvme@lists.infradead.org>; Tue, 12 Nov 2019 09:35:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=lGyPjIXtlWJFIYjt6G4W7mzAQOvtH4svXIj+1YQ2mpw=;
 b=YK4Dd0nTXlfIT33xypt98t5prX2lxJ/OiVK46DuTVTvbwMp07Kt/CO19b1JWbO+00j
 4TZN4bsdjEWPKRKdeXx0PDrZ9/t5bwcd+ZNeLw8sG3XSe/l8h057fqiZvfHQruwqUvc6
 ++aOuod9u9ZsoHWFx2mwEhuE/FYHmNKJuWgB7wv08uuwnKQR/0tiaKwmBJJwnizUJ2dg
 qp6ODCyIkr0NpzHvi/AurusNVeXwpCebWuMj5s3FBcUzOhxThTTSyb3/ibtwASadKYBz
 7O9vuKbEXvaGaQ1m9M909a2yyetTADE0nL4MGU0Fctfe5ZLeZHbAh2wYWU2NCsRJ+i8B
 MVlQ==
X-Gm-Message-State: APjAAAXmNIuMTrqntaxU87dQO1mQLEzgRN/wmvRJo6EajQGBGaDO4h1m
 ARHfZahKNIxCpUMtDfoK6LayJ6bx
X-Google-Smtp-Source: APXvYqwhcsOiaE2u1IuMlLcsKpTcS6LZsWIARF9Vthq4dhCIEbLtNTPkmlSbSnxlg38oCltMFTJnAw==
X-Received: by 2002:aca:be08:: with SMTP id o8mr88824oif.9.1573580113667;
 Tue, 12 Nov 2019 09:35:13 -0800 (PST)
Received: from [192.168.1.114]
 (162-195-240-247.lightspeed.sntcca.sbcglobal.net. [162.195.240.247])
 by smtp.gmail.com with ESMTPSA id h79sm6082989oib.3.2019.11.12.09.35.12
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 12 Nov 2019 09:35:13 -0800 (PST)
Subject: Re: [PATCH 2/2] nvme-pci: poll IO after batch submission for
 multi-mapping queue
To: Ming Lei <ming.lei@redhat.com>
References: <20191108035508.26395-1-ming.lei@redhat.com>
 <20191108035508.26395-3-ming.lei@redhat.com>
 <82fb330e-a507-999a-69f3-947f13bbaae1@grimberg.me>
 <20191112095649.GE15079@ming.t460p>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <4664ca6f-2ebb-c69c-5b7f-226a86394adf@grimberg.me>
Date: Tue, 12 Nov 2019 09:35:08 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191112095649.GE15079@ming.t460p>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191112_093515_738402_83562991 
X-CRM114-Status: GOOD (  24.46  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Long Li <longli@microsoft.com>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>>> f9dde187fa92("nvme-pci: remove cq check after submission") removes
>>> cq check after submission, this change actually causes performance
>>> regression on some NVMe drive in which single nvmeq handles requests
>>> originated from more than one blk-mq sw queues(call it multi-mapping
>>> queue).
>>>
>>> Actually polling IO after submission can handle IO more efficiently,
>>> especially for multi-mapping queue:
>>>
>>> 1) the poll itself is very cheap, and lockless check on cq is enough,
>>> see nvme_cqe_pending(). Especially the check can be done after batch
>>> submission is done.
>>>
>>> 2) when IO completion is observed via the poll in submission, the requst
>>> may be completed without interrupt involved, or the interrupt handler
>>> overload can be decreased.
>>>
>>> 3) when single sw queue is submiting IOs to this hw queue, if IOs completion
>>> is observed via this poll, the IO can be completed locally, which is
>>> cheaper than remote completion.
>>>
>>> Follows test result done on Azure L80sv2 guest with NVMe drive(
>>> Microsoft Corporation Device b111). This guest has 80 CPUs and 10
>>> numa nodes, and each NVMe drive supports 8 hw queues.
>>
>> I think that the cpu lockup is a different problem, and we should
>> separate this patch from that problem..
> 
> Why?
> 
> Most of CPU lockup is a performance issue in essence. In theory,
> improvement in IO path could alleviate the soft lockup.

I don't think its a performance issue, being exposed to stall in hard
irq is a fundamental issue. I don't see how this patch solves it.

>>> 1) test script:
>>> fio --bs=4k --ioengine=libaio --iodepth=64 --filename=/dev/nvme0n1 \
>>> 	--iodepth_batch_submit=16 --iodepth_batch_complete_min=16 \
>>> 	--direct=1 --runtime=30 --numjobs=1 --rw=randread \
>>> 	--name=test --group_reporting --gtod_reduce=1
>>>
>>> 2) test result:
>>>        | v5.3       | v5.3 with this patchset
>>> -------------------------------------------
>>> IOPS | 130K       | 424K
>>>
>>> Given IO is handled more efficiently in this way, the original report
>>> of CPU lockup[1] on Hyper-V can't be observed any more after this patch
>>> is applied. This issue is usually triggered when running IO from all
>>> CPUs concurrently.
>>>
>>
>> This is just adding code that we already removed but in a more
>> convoluted way...
> 
> That commit removing the code actually causes regression for Azure
> NVMe.

This issue has been observed long before we removed the polling from
the submission path and the cq_lock split.

>> The correct place that should optimize the polling is aio/io_uring and
>> not the driver locally IMO. Adding blk_poll to aio_getevents like
>> io_uring would be a lot better I think..
> 
> This poll is actually one-shot poll, and I shouldn't call it poll, and
> it should have been called as 'check cq'.
> 
> I believe it has been tried for supporting aio poll before, seems not
> successful.

Is there a fundamental reason why it can work for io_uring and cannot
work for aio?

>>> I also run test on Optane(32 hw queues) in big machine(96 cores, 2 numa
>>> nodes), small improvement is observed on running the above fio over two
>>> NVMe drive with batch 1.
>>
>> Given that you add shared lock and atomic ops in the data path you are
>> bound to hurt some latency oriented workloads in some way..
> 
> The spin_trylock_irqsave() is just called in case that nvme_cqe_pending() is
> true. My test on Optane doesn't show that latency is hurt.

It also condition on the multi-mapping bit..

Can we know for a fact that this doesn't hurt what-so-ever? If so, we
should always do it, not conditionally do it. I would test this for
io_uring test applications that are doing heavy polling. I think
Jens had some benchmarks he used for how fast io_uring can go in
a single cpu core...

> However, I just found the Azure's NVMe is a bit special, in which
> the 'Interrupt Coalescing' Feature register shows zero. But IO interrupt is
> often triggered when there are many commands completed by drive.
> 
> For example in fio test(4k, randread aio, single job), when IOPS is
> 110K, interrupts per second is just 13~14K. When running heavy IO, the
> interrupts per second can just reach 40~50K at most. And for normal nvme
> drive, if 'Interrupt Coalescing' isn't used, most of times one interrupt
> just complete one request in the rand IO test.
> 
> That said Azure's implementation must apply aggressive interrupt coalescing
> even though the register doesn't claim it.

Did you check how many completions a reaped per interrupt?

> That seems the root cause of soft lockup for Azure since lots of requests
> may be handled in one interrupt event, especially when interrupt event is
> delay-handled by CPU. Then it can explain why this patch improves Azure
> NVNe so much in single job fio.
> 
> But for other drives with N:1 mapping, the soft lockup risk still exists.

As I said, we can discuss this as an optimization, but we should not
consider this as a solution to the irq-stall issue reported on Azure as
we agree that it doesn't solve the fundamental problem.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
