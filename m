Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55CBBC77B77
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Apr 2023 13:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cmW/SI7fpdJxrZhqaDGJvhOzwZEPO6crNIz1Esrg1R8=; b=XnUrMpglTdxh4+DoSfPdkkfMdS
	XT05LXIO/+0iQ8UEb+8TMtn4gVRFtGA8jxjS08Of10wwL1JKMCWedPgPp791pO/RGW3K927mZhmbs
	MZnS5F3i5zNJpLaT7tNJAYNk6XuvGgoc1T/glTTL6TH4Ey0zx60WtvvEPk77BdYb/VJyi66Z6arTI
	DYHZqWs34O0MmUULAPTaOosb/klhYJFkeq5YrIA/1VezlTkQ43zpFbtS3UxhTpOG4MIA6BaDZ6Rym
	CexuY9/9dC4bw/WIple36wz1pzYmDRET13paBovx00myd435GlfjjCKPqet/i4udVCjoO5a8+oohc
	bMwlH53g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1poOzO-00GPeV-2h;
	Mon, 17 Apr 2023 13:33:50 +0000
Received: from mail-wm1-f53.google.com ([209.85.128.53])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1poOzJ-00GPc8-1E
	for linux-nvme@lists.infradead.org;
	Mon, 17 Apr 2023 13:33:48 +0000
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-3f0968734f6so10292905e9.0
        for <linux-nvme@lists.infradead.org>; Mon, 17 Apr 2023 06:33:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681738423; x=1684330423;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cmW/SI7fpdJxrZhqaDGJvhOzwZEPO6crNIz1Esrg1R8=;
        b=dx8t+MQL6a8IGf6Ky+vs1a78eun9IdpS+jKwRTeHM5v54c18tuxJpcczRcTIT7e6B8
         5PPAUJwl7etEfImbBLPMeSO0PIEe9jYZTlT5KcuQCRPUU9P4LzKEdo2VHonHy3EgzOA7
         KGvLu/kF7OcTqTS3znXhEYxnBbng55RGsPwddeemKEu2iCI4pSEBQ1mXhK95CLDrhT8n
         8oa5hBHQeBEScQibNIiBlTw4A2WiLH2u5Qd4x4KVwI2uswSlzViXMlHILo/NMgnHl3c2
         nVDe3xwbqVUZ2jGpreoIpprm6GVlA+OuMXQbldHCDsmOyYaOe9oIC522jg76xbcJBCeG
         mrRQ==
X-Gm-Message-State: AAQBX9dhKdAKvdp2/gxoreLN/EAbxlSCfxUc8QFPTsQKEUs7VRRrlQX4
	kwp3BQz54smGEhDbAS18KrQpWXhkM9o=
X-Google-Smtp-Source: AKy350aMQ9I7nxPb9bzhWjyGmS9jsCUFadL9vxIcL1VcklZ6EwJh9bUQXfW3NJiKGNkeN5/ss96KcQ==
X-Received: by 2002:a05:600c:1ca6:b0:3f0:9deb:c60a with SMTP id k38-20020a05600c1ca600b003f09debc60amr8219511wms.4.1681738422693;
        Mon, 17 Apr 2023 06:33:42 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id m7-20020a7bcb87000000b003f17131952fsm4810834wmi.29.2023.04.17.06.33.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Apr 2023 06:33:41 -0700 (PDT)
Message-ID: <d71d4924-d2f0-3252-5268-5dafd1ebbc39@grimberg.me>
Date: Mon, 17 Apr 2023 16:33:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2] nvme/tcp: Add support to set the tcp worker cpu
 affinity
Content-Language: en-US
To: Ming Lei <ming.lei@redhat.com>, Li Feng <lifeng1519@gmail.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>,
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
 linux-kernel <linux-kernel@vger.kernel.org>
References: <20230413062339.2454616-1-fengli@smartx.com>
 <20230413132941.2489795-1-fengli@smartx.com>
 <ZDz3TlFUxMxaO1W4@ovpn-8-16.pek2.redhat.com>
 <D8FFAFCB-5486-4211-9AC8-2779AE368183@gmail.com>
 <ZDz9vv6tbmKyhK7h@ovpn-8-16.pek2.redhat.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <ZDz9vv6tbmKyhK7h@ovpn-8-16.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230417_063345_425061_940D2055 
X-CRM114-Status: GOOD (  26.45  )
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


>>> On Thu, Apr 13, 2023 at 09:29:41PM +0800, Li Feng wrote:
>>>> The default worker affinity policy is using all online cpus, e.g. from 0
>>>> to N-1. However, some cpus are busy for other jobs, then the nvme-tcp will
>>>> have a bad performance.
>>>
>>> Can you explain in detail how nvme-tcp performs worse in this situation?
>>>
>>> If some of CPUs are knows as busy, you can submit the nvme-tcp io jobs
>>> on other non-busy CPUs via taskset, or scheduler is supposed to choose
>>> proper CPUs for you. And usually nvme-tcp device should be saturated
>>> with limited io depth or jobs/cpus.
>>>
>>>
>>> Thanks,
>>> Ming
>>>
>>
>> Taskset can’t work on nvme-tcp io-queues, because the worker cpu has decided at the nvme-tcp ‘connect’ stage,
>> not the sending io stage. Assume there is only one io-queue, the binding cpu is CPU0, no matter io jobs
>> run other cpus.
> 
> OK, looks the problem is on queue->io_cpu, see nvme_tcp_queue_request().
> 
> But I am wondering why nvme-tcp doesn't queue the io work on the current
> cpu? And why is queue->io_cpu introduced? Given blk-mq defines cpu
> affinities for each hw queue, driver is supposed to submit IO request
> to hardware on the local CPU.
> 
> Sagi and Guys, any ideas about introducing queue->io_cpu?

Hey Ming,

I have some vague memories wrt to this, but from what I recall:

- The number of queues is dependent on both the controller and
the user (Not a reason/motivation on its own, just clarifying).

- It simply matches what pci does (to some extent, outside of rx side
entropy that may exist), it just happens to take more cpu cycles due to
the network stack overhead.

- I didn't want io threads to change CPUs because of RFS/aRFS
optimizations that people use, which allows the NIC to steer interrupts
(and napi context) to where the io thread is running, and thus minimize
latency due to improved locality. that on its own was shown to be worth
over 30% reduction.

- At some point nvme-tcp rx context used to run in softirq, and having
to synchronize different cores (on different numa nodes maybe, depends
on what RSS decided) when processing the socket resulted in high
latency as well. This is not the case today (due to some nics back then
that surfaced various issues with this) but it may be come back in
the future again (if shown to provide value).

- Also today when there is a sync network send from .queue_rq path,
it is only executed when the running cpu == queue->io_cpu, to avoid high
contention. My concern is that if the io context is not bound to
a specific cpu, it may create heavier contention on queue serialization.
Today there are at most 2 contexts that compete, io context (triggered 
from network rx or scheduled in the submission path) and .queue_rq sync
network send path. I'd prefer to not have to introduce more contention 
with increasing number of threads accessing an nvme controller.

Having said that, I don't think there is a fundamental issue with
using queue_work, or queue_work_node(cur_cpu) or
queue_work_node(netdev_home_cpu), if that does not introduce
additional latency in the common cases. Although having io threads
bounce around is going to regress users that use RFS/aRFS...

