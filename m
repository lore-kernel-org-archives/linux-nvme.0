Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ED50C47258
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Jan 2024 00:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=I45qqr9n38DIIRtEluaEbO4BQdx4bUm7wkLvhBzuhuU=; b=zuHdahwmy6t3oMjmJn3X8aAKLP
	8oMrIX0na4hTxVc3S/bUnJlo6NWD84oigG5V6R0kHbz806P9+hdFvaYdu8Npanes0KYqSc+y0SZdv
	Xt5HdQ99PGPQUP5UhHY0C5cv+FTpMvFvh+l0WzrruIHFY+wr1sXAhoe0UV9PiEiw9xP8PCC5TmaWo
	27hmg6eTkYTazWVRI13luGQ4SB3pxf61oR1oBBNDxnrXoEKY+U2Rf5mXWbYmQPd0hP0VDoYAZdLgp
	2IN2U3chAzxcVHZnSVHRZEApI/e7+/XAZH9Pqflgfgs6K2kolljmEYrGihcGrSCIuYSvvpHUAxgqo
	Dz4c0bJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rQGfz-001EMZ-27;
	Thu, 18 Jan 2024 00:54:35 +0000
Received: from mail-il1-f175.google.com ([209.85.166.175])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rQGfw-001EM1-1o
	for linux-nvme@lists.infradead.org;
	Thu, 18 Jan 2024 00:54:33 +0000
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3606f3f2f37so64588595ab.0
        for <linux-nvme@lists.infradead.org>; Wed, 17 Jan 2024 16:54:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705539270; x=1706144070;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I45qqr9n38DIIRtEluaEbO4BQdx4bUm7wkLvhBzuhuU=;
        b=s/0nhnNrGtNbRgMqIdsODXExQqzCFfskJjaqqyTNuoauYUA32ZVdgcqnQvsilrZWCp
         vXfZNQyxN4cz5L+MCtXalZktimoszRNyG98HFiVh7mgHcWOFy6umHUtt2KHMnq+eQY5G
         NA5QQ6u4poSvcFQCjPQumx5RSo87rb4qdleH4VBoaP6zv2/j+PBWsnZzZqm2LvH39HlP
         p6H6VBupOWfTPq3kE0EsV+VCEWIdzJ3e5BeqjhACdCb7FpBIvwfCrxuHEZFbOazBzhr8
         nyTtsgfH55YDACOo5AE61S1+27ZP7s/g/4KyuAuoFcg90CglS1pjcV+sZ2Q/4gxeAlEA
         7IVg==
X-Gm-Message-State: AOJu0YyVasSGDfV/8iEXBIWTS4qUEFDTyGVamR7FuE7J65aH1wJE7EG5
	gP3eVz59ZjliYeWTiNTcNhO0wRg3kz8pl7H6GVV0drr4sMr1736G
X-Google-Smtp-Source: AGHT+IHesprjDRDHKDmWAU1kXOqX9BSX1AEcL/MOMAN2IhfSYFpDHbPo2rnOkF9E8n7AzllJQIuYag==
X-Received: by 2002:a92:cec2:0:b0:360:70a9:12c5 with SMTP id z2-20020a92cec2000000b0036070a912c5mr173583ilq.11.1705539270228;
        Wed, 17 Jan 2024 16:54:30 -0800 (PST)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net. [73.231.117.72])
        by smtp.gmail.com with ESMTPSA id y63-20020a638a42000000b005c2185be2basm281448pgd.54.2024.01.17.16.54.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jan 2024 16:54:29 -0800 (PST)
Message-ID: <0853691b-0b70-48c5-825a-4b709d066e20@acm.org>
Date: Wed, 17 Jan 2024 16:54:28 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] Improving Zoned Storage Support
Content-Language: en-US
To: Jens Axboe <axboe@kernel.dk>, Damien Le Moal <dlemoal@kernel.org>,
 "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Christoph Hellwig <hch@lst.de>
References: <5b3e6a01-1039-4b68-8f02-386f3cc9ddd1@acm.org>
 <cc6999c2-2d53-4340-8e2b-c50cae1e5c3a@kernel.org>
 <43cc2e4c-1dce-40ab-b4dc-1aadbeb65371@acm.org>
 <c38ab7b2-63aa-4a0c-9fa6-96be304d8df1@kernel.dk>
 <2955b44a-68c0-4d95-8ff1-da38ef99810f@acm.org>
 <9af03351-a04a-4e61-a6d8-b58236b041a3@kernel.dk>
 <c6dfb4f5-10f9-461e-8743-b730a8384f95@acm.org>
 <e19746ce-fdea-4372-bc26-1ee7b1a9a22d@kernel.dk>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <e19746ce-fdea-4372-bc26-1ee7b1a9a22d@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240117_165432_624082_3D97FA2A 
X-CRM114-Status: GOOD (  10.67  )
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

On 1/17/24 16:42, Jens Axboe wrote:
> On 1/17/24 5:38 PM, Bart Van Assche wrote:
>> On 1/17/24 10:43, Jens Axboe wrote:
>>> Do we care? Maybe not, if we accept that an IO scheduler is just for
>>> "slower devices". But let's not go around spouting some 200K number as
>>> if it's gospel, when it depends on so many factors like IO workload,
>>> system used, etc.
>> I've never seen more than 200K IOPS in a single-threaded test. Since
>> your tests report higher IOPS numbers, I assume that you are submitting
>> I/O from multiple CPU cores at the same time.
> 
> Single core, using mq-deadline (with the poc patch, but number without
> you can already find in a previous reply):
> 
> axboe@7950x ~/g/fio (master)> cat /sys/block/nvme0n1/queue/scheduler
> none [mq-deadline]
> axboe@7950x ~/g/fio (master)> sudo t/io_uring -p1 -d128 -b512 -s32 -c32 -F1 -B1 -R1 -X1 -n1 /dev/nvme0n1
> 
> submitter=0, tid=1957, file=/dev/nvme0n1, node=-1
> polled=1, fixedbufs=1/0, register_files=1, buffered=0, QD=128
> Engine=io_uring, sq_ring=128, cq_ring=128
> IOPS=5.10M, BW=2.49GiB/s, IOS/call=32/31
> IOPS=5.10M, BW=2.49GiB/s, IOS/call=32/32
> IOPS=5.10M, BW=2.49GiB/s, IOS/call=31/31
> 
> Using non-polled IO, the number is around 4M.

A correction: my tests ran with 72 fio jobs instead of 1. I used
fio + io_uring + null_blk in my tests. I see about 1100 K IOPS with
a single fio job and about 150 K IOPS with 72 fio jobs. This shows
how I measured mq-deadline performance:

modprobe null_blk
fio --bs=4096 --group_reporting=1 --gtod_reduce=1 --invalidate=1 \
     --ioengine=io_uring --ioscheduler=mq-deadline --norandommap \
     --runtime=60 --rw=randread --thread --time_based=1 --buffered=0 \
     --numjobs=72 --iodepth=128 --iodepth_batch_submit=64 \
     --iodepth_batch_complete=64 --name=/dev/nullb0 --filename=/dev/nullb0

Thanks,

Bart.

