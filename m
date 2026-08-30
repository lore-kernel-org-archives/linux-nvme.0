Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CEF2C61DD9
	for <linux-nvme@archiver.kernel.org>; Sun, 30 Aug 2026 22:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BPTYWB1156EFu+SymVVIBsNov2ioaQbk2iJPnHim86U=; b=ZER9xTDeGvNhkQ6QyVNLVZt3+9
	CN/Foc59vKh69HG1F1Tjyyuot30P4ng3hguo3LK7bLlkdkAK/QVUMBZODTbkwOAT8eGQAiJu9t11f
	7WfXY/tW+wA5Sf2SawHnUPFE8gN0zZIBFBgg4JtGdPpEkik0SYY21QTaiL2F2P2CMSFsvbdRnQ20l
	2Bs2xciYCHVLpszI+TVlzqimhq71BoRUgzJicO6ZtK+Rd8Gw94x0DbY2zSVhaKUBLFXEroIfcpEoe
	itY+XxNmYBxlMlXoiUd+6qcxRGB632ywAiCap1v3a/Vo2ankWqJIUB756gwSxD1h3Wfy6SUqVh7h4
	yqa/CqHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x0nfM-000000089jc-32PW;
	Sun, 30 Aug 2026 22:06:16 +0000
Received: from mail-wr1-f50.google.com ([209.85.221.50])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x0nfJ-000000089jE-3RPK
	for linux-nvme@lists.infradead.org;
	Sun, 30 Aug 2026 22:06:14 +0000
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-482fc2b44a7so2258390f8f.2
        for <linux-nvme@lists.infradead.org>; Sun, 30 Aug 2026 15:06:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788127572; x=1788732372;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BPTYWB1156EFu+SymVVIBsNov2ioaQbk2iJPnHim86U=;
        b=fG8h/pcOa3kmT8S8c4MEOo66IzI0GDLjl6JF166DDaSpel6LFDFdlLYy5XQHlJSYUm
         U/vxq4oKZXaQDSzGY4eyleJJ9KzLqpYae9fGIDtjurmQKBiBQHR0Nod+/yMGqpmv0KMw
         8CihkRhIK95ls7aq/3MUIxZnNvgk7M6euye64tLWP3Z+6GHPOjxBJSIKl5WWSFsZNhKI
         A9Th69huz/laDBkpHZKJUnGcK8aHW5ycL4sym3H1fm6eaSKjTxjHOVFfI8WtLSKr1Eyw
         CU6RKs0WFpobjl/iugLoAS3HvZAA5ozWtnwbVBjBDbPhMzB1Zl04nIQCANeeX5Db0DmG
         NKwA==
X-Forwarded-Encrypted: i=1; AKwUvBw2ZUqB6Q6BYNM33uOJnLERvX547LSKsGXG5z2ffX0SLhG40HlKxLkMmPBu6pHDW6BEYSYoknlSqj60@lists.infradead.org
X-Gm-Message-State: AFuF++mDv4OdBYd6AEjBK7K2kUPS0IR+Gq5HHSF7jdRjJAM2OSooh6+N
	PcPLUz8E49wL0wPBbgGLOpXl0w8fVpOIAisu4/01H0DzKhC9aaLIUkz1I7/GyHdbVHM=
X-Gm-Gg: AYBFou0Woq5rGOoALp83TN+nEfxsnjuSJjzWbG+L3MH3J4/e1NZTc6WPYpp+m4gNfzU
	2BjSCC41pQyIPY4Ao5cEd0wGlN7mbo+hUtThIUJCLyTqjPuuj4p2hPKN684CSOJwvnZbnAgEYR/
	4jwpRe9pBKm/XerSkcXklnfcI40d2jwyesHTt1V0y4oKL5cL56TeVxcjwnGekZozwc/BoNrzvl7
	X52cayJP+EueEPNk+12Kd/nCkUo6b/NzAdZLLN8wVLK0QZoIOP9QW95vnFElTEPqLOHHbU6IRkh
	DNwcbSXxxdYzR6Sxxg4NfT/BDGh5kXcW68VPlR1EvDAEnyJGspQEPhINQw2c8g6VqJe4G+Yw1+W
	X22ejRdM59E/lSxa/F9ynUaP3tROOQnRz0MKoM3052MRtmpTUrp8GJdnk+jYXwy3TujTIU+OztK
	qCVIup7VO5xeS1/2LxTNMG0tMnhyW/okFSAUryiE9SLVbncfvkUwPxvEH3mdNfORqltva5/RM2p
	Pg01d+YJFCRNs/DAFuyNPE=
X-Received: by 2002:a5d:5e02:0:b0:482:e2f2:19c1 with SMTP id ffacd0b85a97d-482f7975f7emr33713885f8f.2.1788127571691;
        Sun, 30 Aug 2026 15:06:11 -0700 (PDT)
Received: from [10.100.102.74] (89-138-77-243.bb.netvision.net.il. [89.138.77.243])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482fbb284cbsm18333397f8f.30.2026.08.30.15.06.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Aug 2026 15:06:10 -0700 (PDT)
Message-ID: <9271266f-3d7e-426e-93b6-6f1f28bc9b0f@grimberg.me>
Date: Mon, 31 Aug 2026 01:06:07 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] nvme-cli: NIC topology aware I/O queue scaling
To: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org
Cc: dwagner@suse.de, hare@suse.de, kbusch@kernel.org, hch@lst.de,
 gjoyce@linux.ibm.com, chaitanyak@nvidia.com
References: <20260821144329.3620389-1-nilay@linux.ibm.com>
 <4a80220a-2cba-4a4a-85c2-7c3d3ae8a20a@grimberg.me>
 <32bcaf68-a142-4612-9967-815dd28ee2a0@linux.ibm.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <32bcaf68-a142-4612-9967-815dd28ee2a0@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260830_150613_902238_7F836325 
X-CRM114-Status: GOOD (  20.85  )
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



On 24/08/2026 11:48, Nilay Shroff wrote:
> On 8/23/26 3:13 AM, Sagi Grimberg wrote:
>>
>>
>> On 21/08/2026 17:43, Nilay Shroff wrote:
>>> Hi,
>>>
>>> This series is a rework of the earlier patchset[1]. The main
>>> difference is that --nr-io-queues is now calculated in nvme-cli
>>> instead of in the kernel when establishing an NVMe/TCP connection.
>>>
>>> This rework is based on the feedback received[2] from the netdev
>>> maintainers.
>>>
>>> The original patchset determined the number of NVMe/TCP I/O queues
>>> based on the number of online CPUs and the number of hardware queues
>>> available on the NIC in kernel driver. This series moves that logic
>>> to nvme-cli.
>>>
>>> When --nr-io-queues is not explicitly specified, nvme-cli determines
>>> the egress netdev for the NVMe/TCP connection, retrieves its current
>>> hardware queue count, and calculates the default as:
>>>
>>>     min(nr_hw_queues, num_online_cpus)
>>
>> This looks reasonable Nilay.
>>
> Thank you...
>
>> I am wandering tho if we want to place some lower limit here.
>> For example, my laptop has a virtio device with 4 cpu cores and
>> a single combined ring:
>> -- 
>> $ lscpu | grep NUMA
>> NUMA node(s):                            1
>> NUMA node0 CPU(s):                       0-3
>> $ ethtool -l enp7s0
>> Channel parameters for enp7s0:
>> Pre-set maximums:
>> RX:        n/a
>> TX:        n/a
>> Other:        n/a
>> Combined:    1
>> Current hardware settings:
>> RX:        n/a
>> TX:        n/a
>> Other:        n/a
>> Combined:    1
>> -- 
>>
>> It would be kinda annoying for me to now explicitly pass the 
>> nr-io-queues...
>> I am wandering if some sort of threshold make sense as what you are 
>> aiming for
>> is reducing the amount of queues for large cpu counts...
>
> I think you're running a QEMU guest using user-mode (SLIRP) 
> networking, so having
> a combined queue count of 1 is expected.
>
> I also tested this setup before posting the change. With QEMU 
> user-mode networking,
> increasing --nr-io-queues beyond 1 (I tried 4 and 8 with vCPU set to 
> match those
> numbers) did not improve performance. In fact, limiting --nr-io-queues 
> to 1, which
> matches the netdev's single combined queue, gave slightly better 
> performance.
>
> My understanding is that in this topology there is only a single 
> underlying
> virtqueue/network queue, so creating multiple NVMe/TCP I/O queues does 
> not provide
> additional network parallelism. Instead, those NVMe/TCP queues end up 
> contending
> on the same virtqueue/network queue, which can add overhead without 
> providing additional
> throughput.

I don't care about performance. I care that if I am testing stuff, I 
want more than a single
queue. And it is annoying to explicitly change the queue count...

Also, I don't know if your performance statements are correct for TLS.

