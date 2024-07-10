Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC733C3DA41
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Jul 2024 14:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cMYLwkygBaEm53rVFUkhtSxao6iNO48E5ZQHfPx86bI=; b=oKTyrrNAJ7Nt4fFSnOvnG7ymRR
	Rfg4mNEJbl2BClgcBSlNMY9bg1f7luLxA91277w7h9OZk6Vax/5ec9ojAFU2NfbH9JIe6gUcsOl+3
	Rq17IOc8JdTpUeZqBlJrKOyEoR/1miWJux6qfERw5UpozSg+vxIkneluV8C2KBh24oG2b1j/zhxWi
	2WwiPKyY2DX1nFOOVUFqGNqsP9NnLK6WQ2waoZdk+an0lVmh471nNgxuyboSE/wJS68zyNVP7sdtz
	ujXQUWs8s5Bx1n43gkzCcI3WLdl0tjJCP/3u0i4CBJ/Oj78bPbnbOHmrJK609qS7nIXLc881e3sGJ
	pH89DzJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRYa5-0000000ArhO-1fRD;
	Wed, 10 Jul 2024 14:46:05 +0000
Received: from mail-wr1-f45.google.com ([209.85.221.45])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRYZt-0000000Aret-2qbo
	for linux-nvme@lists.infradead.org;
	Wed, 10 Jul 2024 14:46:03 +0000
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3679bc8fa9cso168404f8f.0
        for <linux-nvme@lists.infradead.org>; Wed, 10 Jul 2024 07:45:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720622752; x=1721227552;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cMYLwkygBaEm53rVFUkhtSxao6iNO48E5ZQHfPx86bI=;
        b=CCRvCaFUpqOgfcL+ULfkIGlR5gchQofKxx4eQCI63eIGV7zMA0AbxNk10Sia5z7PQ3
         lqqWqCTOw5HIEzuYk2pF1pq6RrAlM33BL+2mqpf/s3xbWH0TBs2oh8DBC133XY0Uq5XD
         DXOhaYXpvzub0BHsgfQWICKBaz9NvK8Qy5+qZKlVJ3gjw8EiA1YKE4mUBSxJNydpCGly
         oNw2qGrzXDysWWeieVGDdhqdjIxDXr0HX6p5CWDaSbv4TtG06PPbl309H+GrhTDBjltM
         hUmWjgZzhV7AsuPIrdh105r/UCEpRA/GMvpWdBQ6iPGOXLbSuWeXOFKDkaV6a4RoKn+X
         hwVw==
X-Forwarded-Encrypted: i=1; AJvYcCXjGj+kI1hH4ZGORbhejSyx1kHA9HK3/CeOO29pQm4upmnz4EfKGq85uFC/lTlLRQA5XuZiMGtU10hCGGVg7qfmls+KncbbuYhJUzsNym0=
X-Gm-Message-State: AOJu0YzIRMM7CUf7wplV1iYlTUotg8XcIEnd6QOOA+X0bQLxrfYTqNVd
	41F5H6coA6ULiDNhRcv1/iYRCKbphPp4kzlCPRbTO23Z5EaDNg4j3caedtNy
X-Google-Smtp-Source: AGHT+IHEg6tknSC5E5a8UXXA5KTaQqrcNStGdnWR+FWiE64SKiGWRm4mD+HiwUHO+0klFA+VJTdmRA==
X-Received: by 2002:a05:6000:4029:b0:35f:2f97:e890 with SMTP id ffacd0b85a97d-367ce5de46cmr3984744f8f.0.1720622751450;
        Wed, 10 Jul 2024 07:45:51 -0700 (PDT)
Received: from [10.50.4.202] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cde8904csm5438045f8f.49.2024.07.10.07.45.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jul 2024 07:45:50 -0700 (PDT)
Message-ID: <5b47456d-d185-411d-8a53-2a3317207819@grimberg.me>
Date: Wed, 10 Jul 2024 17:45:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 0/3] nvme-tcp: improve scalability
To: Hannes Reinecke <hare@suse.de>, Hannes Reinecke <hare@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20240708071013.69984-1-hare@kernel.org>
 <33f72b7d-d1da-4c5d-8aa1-1df2559b9588@grimberg.me>
 <3dfdf2e8-800b-4e87-a65f-f32fdb5018b0@suse.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <3dfdf2e8-800b-4e87-a65f-f32fdb5018b0@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240710_074553_758068_44B05055 
X-CRM114-Status: GOOD (  15.69  )
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



On 10/07/2024 17:06, Hannes Reinecke wrote:
> On 7/10/24 13:56, Sagi Grimberg wrote:
>>
>>
>> On 08/07/2024 10:10, Hannes Reinecke wrote:
>>> Hi all,
>>>
>>> for workloads with a lot of controllers we run into workqueue 
>>> contention,
>>> where the single workqueue is not able to service requests fast enough,
>>> leading to spurious I/O errors and connect resets during high load.
>>> This patchset improves the situation by improve the fairness between
>>> rx and tx scheduling, introducing per-controller workqueues,
>>> and distribute the load accoring to the blk-mq cpu mapping.
>>> With this we reduce the spurious I/O errors and improve the overall
>>> performance for highly contended workloads.
>>>
>>> All performance number are derived from the 'tiobench-example.fio'
>>
>> Did you keep the fio file unmodified? I'd suggest to run it for longer
>> say 60 seconds each workload. 512 MB is a very short benchmark...
>
> Not for 32 queues :-)
> But yeah, I can keep it running for slightly longer.

How does the number of queues make a difference?
doesn't it simply write 512MB from 4 threads?

>
> Not making much progress, mind; your 'softirq' patch definitely speeds 
> up receiving, but seem to messing up the write side such that I'm 
> basically guaranteed to hit I/O timeouts on WRITE :-(
>
> Keep on debugging ...

Hannes, I think that now that we established that rx can starve tx, we 
must pace rx, so if we do something like softirq rx, it must be an 
initial batch, limited, and once we exhaust
it, we schedule a workqueue to continue processing. I'd also leave it 
alone for now, we'll add it once we have a good understanding of what is 
going on...

