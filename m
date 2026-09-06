Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5645C624DB
	for <linux-nvme@archiver.kernel.org>; Sun,  6 Sep 2026 00:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fF/vXxPLfH/LP55Q3picOAVcc+78Hi+CViiQRqbY41A=; b=UpQgKUmI9FXUYlS2GyFtZlVO70
	pfRcXBd8CVLAvg7VMbHes7Nuf6WqrRW1RGxhNJeBCqKKM2cy4EzereXcvsbnffN+zqr+Han12oI0x
	3/dsDOdbVLEHd3gJXmjR0T1Ufq2N1VTKHXf39cxuOuIlHGQH+4TnCH643vP61kTyLuo7ateizf3Jk
	Up5ZgNPDwWWBQy12zH+/N88QOQDChHztPx0UyeK+v7UAHR4RzA+c2WDNdin6RiZ4nB3QMzI38ViDV
	qHV1VI9w5dBo4OkzQaPSkQslU9RAs+kvZCCfu/1nrp1Z8Q90eATyWPuNOR8RbbQmHN0vkuAVAGtS9
	PcVA3/tg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x30jk-00000004Vr1-0hqe;
	Sun, 06 Sep 2026 00:27:56 +0000
Received: from mail-wm1-f41.google.com ([209.85.128.41])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x30jh-00000004VqJ-3q8J
	for linux-nvme@lists.infradead.org;
	Sun, 06 Sep 2026 00:27:55 +0000
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-49d0d2d37ceso43155e9.0
        for <linux-nvme@lists.infradead.org>; Sat, 05 Sep 2026 17:27:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788654472; x=1789259272;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fF/vXxPLfH/LP55Q3picOAVcc+78Hi+CViiQRqbY41A=;
        b=QcNRVcZhf8P1gx/RMizJ9q8z1+Px1L78pMbM1KfzWB3OGwaol2zhZkKS7xZO9E2TsX
         mRg/j29LVOJ7ywGKELnvbf2z21Su/MupONIIhp8wdf0c1TLthtHiWWhK8MadeEl9zhQ3
         68ZP8iekH/YNkPRHbISBiUQB64yyeptpb0daGaU7CGUseQ13w9CAqbDPpIYzN1royeOx
         05u4h14GQ735ZwxBWHev/RupXBcroKT1a/OJJiQY1nmKxCkd6iM5vGwt9RFjlb8kxzWF
         ukGsIsmdL9ouDVU/71NpUWgpsgRsIahoOfwYKiB2xGgU5ZuomxAYX7KC2k2esX/yV/Em
         sXlg==
X-Gm-Message-State: AFuF++kAac5QjlZX3AhIKRgjw9l0HJzg9Wfbu9jPz6ZuMqjleX58mdRD
	AR0O31y3KckbRAPxWDc6YjksLqm8kAw/zpTFHcFN3+BGspCRLAdh7j2b
X-Gm-Gg: AYBFou3NxjKBLziXkBiPNx4lj4/QPyKlCAmS6lkyaBj78tejRRKGWzRWblKuUuvTSZK
	eu9SLS9+7Ds92kIzxPCOWQeWQrr5tTgW0IxCizt8rUMsI+ayF585M9LSL9JmOKOefg0xyjcqE17
	z2+Dvidab5lL7HHwjq0VGpmLKYZ52hSb8i5Dr3R2lgwExTmfjo6doZ4V/ll3X8JXrJ44F8kysEJ
	+w+YVVxx98ji7lr37Ru17bsrX7YyHn8uH7sfO78jfc4HAe8HQ3YUPjW/tSI7dgzB8YG4tCwynq5
	GifdH0DfuW33ERiq6rAx9E/qup3VP5Yr/q3xJP8gTmm8GDVpSRJaM95H8DjcyKD8ixdbtbAYrFR
	xdVedOEn+4g2ePkOBUVPlRzIDRQESU+FO5uheR0hN25YKwJ6+7LXsJcbZmyNWrh8DHhEH7dEvLF
	pFJ5FqvbMYrBSCLroM3RUhun9W9iAuNUVGGiROjHNKffz+aDq0WUChZVISDq386eSy/qicpw9vv
	dxWBcgHODwQ+5LjPFBo/kA=
X-Received: by 2002:a05:600c:1986:b0:49c:fa21:e744 with SMTP id 5b1f17b1804b1-49cfa21e906mr115713335e9.26.1788654471726;
        Sat, 05 Sep 2026 17:27:51 -0700 (PDT)
Received: from [10.100.102.74] (89-138-77-243.bb.netvision.net.il. [89.138.77.243])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce831af89sm198027065e9.1.2026.09.05.17.27.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Sep 2026 17:27:51 -0700 (PDT)
Message-ID: <220e9da3-f756-4a16-8de1-d4b171f15009@grimberg.me>
Date: Sun, 6 Sep 2026 03:27:50 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nvme-tcp: pin io_cpu to submitter cpu
To: Saravanan D <saravanand@crusoe.ai>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 linux-kernel@vger.kernel.org, Nilay Shroff <nilay@linux.ibm.com>,
 Daniel Wagner <dwagner@suse.de>
References: <20260820083634.71689-1-saravanand@crusoe.ai>
 <20260823174348.40236-1-saravanand@crusoe.ai>
 <1d56144d-6987-40c1-ac02-b15333db121e@grimberg.me>
 <20260902062431.61412-1-saravanand@crusoe.ai>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20260902062431.61412-1-saravanand@crusoe.ai>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260905_172753_978850_6AAE3D9F 
X-CRM114-Status: GOOD (  25.54  )
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



On 02/09/2026 9:24, Saravanan D wrote:
> On Mon, 31 Aug 2026 01:30:08 +0300 Sagi Grimberg <sagi@grimberg.me> wrote:
>> I just think that the adoption approach has downsides in many other
>> workloads. I wouldn't categorize your use-case as the common use-case.
>> Not to say that it shouldn't be solved.
> Adoption in v2 is opt in per controller through the io_cpu_adopt
> connect option, so every workload that does not enable it
> keeps today's behavior unchanged. The downsides would only be borne by
> deployments that choose it. I concur with the broader point. Adoption
> makes the driver itself decide where socket work belongs, through a
> fixed rule that cannot fit every deployment, while a writable io_cpu
> is very flexible and leaves the decision to the control plane.
>
>> I agree with you that queue io_cpu selection at connection time is too
>> limiting. Perhaps we can have each nvme-tcp queue expose a sysfs entry
>> to set the io_cpu?
>>
>> Something like:
>> echo $CPU > /sys/class/nvme/nvme0/tcp_queues/$QUEUE/io_cpu
>>
>> I am just trying to think of a way that will allow some control plane
>> to set it exactly as it wants, without the guessing part...
> The per queue sysfs io_cpu works for us, and in one respect it works
> better than a connect option because a sysfs attribute can be set after
> the fact on any existing connection. The control plane already knows each
> VM's cpuset and can read the queue to cpu grouping from mq/*/cpu_list,
> so it can nail the socket work placement.
>
> Two questions before I spin the next version around this.
>
> 1. On reconnect the queues come back with the connect time io_cpu, so
> the control plane has to notice and reapply its placement. Is relying
> on the existing nvme udev events for controller state the intended
> signal, or would you want a dedicated notification ?

I think that io_cpu should not change in reconnect. We can use a
NVME_TCP_Q_ flag for it.

>
> 2. What should the write path enforce ? I would validate the cpu is
> online, rebalance the nvme_tcp_cpu_queues accounting, and let the new
> value take effect from the next queued io_work. I intend to restrict the
> value to the queue's map group.

I'd just do basic validation that override the queue io_cpu.. perhaps
xchg(queue->io_cpu, cpu).

>
> If this direction sounds right I will drop the adoption heuristic and
> send the next version v3 exposing each queue's io_cpu as a writeable
> sysfs attribute.
>
> Thanks,
> Saravanan D.


