Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83958C38145
	for <linux-nvme@archiver.kernel.org>; Sat,  3 Sep 2022 17:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+QQA4kmqlZ35Q9KKy4uiiOptiO8D9lsejYD6WEYmE3s=; b=fTuR7RrbowooKo64hSlKd3TqL6
	egCRkar2c4PXhpDRZe52wOInIHX9qmqyBj0TVP8TPq86/tIqC6ZZeKTuerNQC+0OJWSVmkFevKfVv
	JZAlSmsHyUAG1I8BJTqZ2Ggp+RjSO1wUh8eflFGcGPE9mQqOjD/FVvSVGz0hGafHeRB33Oq+DLUPh
	ADSlxKQspcGzUpl8sZE40kFdm3tGZRQgpJBRC3B7bTu4fzV+klEfrXiHvR4jtJc54RJNYjAUN2uzW
	DeU9Q3YxAdFkep97I3wuNtphEz+QuSzqkfC5XGwOaXltdT7pY0vM7wnPypijrPvPXaC2yJXHIct+N
	EXOSCWhQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oUWVt-00Dy3F-C7; Sat, 03 Sep 2022 17:00:57 +0000
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oUWVl-00DxyV-OS
	for linux-nvme@lists.infradead.org; Sat, 03 Sep 2022 17:00:51 +0000
Received: by mail-pl1-x62d.google.com with SMTP id jm11so4711942plb.13
        for <linux-nvme@lists.infradead.org>; Sat, 03 Sep 2022 10:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=+QQA4kmqlZ35Q9KKy4uiiOptiO8D9lsejYD6WEYmE3s=;
        b=nUIquInPQF+Vuc0kBJcJtkVAOf+0nG29BJiGkM0lyLDfVbz8EUpgyOuG7jp5cJwjrF
         uOO8Bg3yWUJ4o6OGTphq3Cq9UsujyQyNhtugvBJzHc7nPrcr0t68l8W45vOgPn6bsZsa
         wSClzXAMiKXulUR+smYJ/DyhTbE1+Te09RQ1UqRGVh/n/f6pf94sU20k7ZfYSFXSNRRD
         C+uEgVb1mm/zJrWXAR30KlmV8p16uL1nQFjBxWqlPWjF8NVvhjuFKaRUG2CorZ+kvmJw
         Kdvsv9ZZUHpZjCaKMQ+gN86A2FcfShJwjdIHoP4oBsiIfIIXsBzol9hI5rNpK3NpS9r6
         1TMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=+QQA4kmqlZ35Q9KKy4uiiOptiO8D9lsejYD6WEYmE3s=;
        b=7Xxu9hVqiCayrCLhM1A9vdIgEqlNGosZww+/SzF+F3dm0N3YzbAr1YRdcXycpVkHkv
         0KdimQFg+kmP6DHeOMLX9BDQNn5PY4pVGIGqJnTLDpez9eC9LvS/tk/i8UklRrlEDciz
         hdze7iIuzf572jhfYMYYqeOZDyVoW7QzPo2kMguoBlI9q3ieYCpn2++uOoWYJrg1hWWD
         ZIJw6MbIA1IcLhEw6PxOGandpmRNaghT66GRimnaVrbqKK5pdgs3ar3GWstyDSTinrsm
         mb9/QQOxB9ctQUuK1tT+DF2Px5lql1Vh0RuKD+k67la6icDDuXmFduYx/6TRtzP764Ww
         kh4Q==
X-Gm-Message-State: ACgBeo0CeiHThd58gdQwgzgja18gYZTo5jkbFSutHTSz8PAUgNJH1M0i
	w9TXfOm6r02L4AubcXdXbsm8aA==
X-Google-Smtp-Source: AA6agR4TH6UeLZwuJxAnHsCNafpBxYf6GeIod3zTkM8qkV5uPlNKTQxrWMC8VWxUSFUcj2cYFBCPjA==
X-Received: by 2002:a17:903:4043:b0:174:dd99:a589 with SMTP id n3-20020a170903404300b00174dd99a589mr27848171pla.56.1662224445803;
        Sat, 03 Sep 2022 10:00:45 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id w29-20020aa79a1d000000b0052d24402e52sm4159231pfj.79.2022.09.03.10.00.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Sep 2022 10:00:45 -0700 (PDT)
Message-ID: <75c6c9ea-a5b4-1ef5-7ff1-10735fac743e@kernel.dk>
Date: Sat, 3 Sep 2022 11:00:43 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH for-next v3 0/4] fixed-buffer for uring-cmd/passthrough
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: hch@lst.de, kbusch@kernel.org, asml.silence@gmail.com,
 io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, gost.dev@samsung.com
References: <CGME20220902152701epcas5p1d4aca8eebc90fb96ac7ed5a8270816cf@epcas5p1.samsung.com>
 <20220902151657.10766-1-joshi.k@samsung.com>
 <f1e8a7fa-a1f8-c60a-c365-b2164421f98d@kernel.dk>
 <2b4a935c-a6b1-6e42-ceca-35a8f09d8f46@kernel.dk>
 <20220902184608.GA6902@test-zns>
 <48856ca4-5158-154e-a1f5-124aadc9780f@kernel.dk>
 <c62c977d-9e81-c84c-e17c-e057295c071e@kernel.dk>
In-Reply-To: <c62c977d-9e81-c84c-e17c-e057295c071e@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220903_100049_821245_137DEABE 
X-CRM114-Status: GOOD (  12.66  )
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

On 9/2/22 3:25 PM, Jens Axboe wrote:
> On 9/2/22 1:32 PM, Jens Axboe wrote:
>> On 9/2/22 12:46 PM, Kanchan Joshi wrote:
>>> On Fri, Sep 02, 2022 at 10:32:16AM -0600, Jens Axboe wrote:
>>>> On 9/2/22 10:06 AM, Jens Axboe wrote:
>>>>> On 9/2/22 9:16 AM, Kanchan Joshi wrote:
>>>>>> Hi,
>>>>>>
>>>>>> Currently uring-cmd lacks the ability to leverage the pre-registered
>>>>>> buffers. This series adds the support in uring-cmd, and plumbs
>>>>>> nvme passthrough to work with it.
>>>>>>
>>>>>> Using registered-buffers showed peak-perf hike from 1.85M to 2.17M IOPS
>>>>>> in my setup.
>>>>>>
>>>>>> Without fixedbufs
>>>>>> *****************
>>>>>> # taskset -c 0 t/io_uring -b512 -d128 -c32 -s32 -p0 -F1 -B0 -O0 -n1 -u1 /dev/ng0n1
>>>>>> submitter=0, tid=5256, file=/dev/ng0n1, node=-1
>>>>>> polled=0, fixedbufs=0/0, register_files=1, buffered=1, QD=128
>>>>>> Engine=io_uring, sq_ring=128, cq_ring=128
>>>>>> IOPS=1.85M, BW=904MiB/s, IOS/call=32/31
>>>>>> IOPS=1.85M, BW=903MiB/s, IOS/call=32/32
>>>>>> IOPS=1.85M, BW=902MiB/s, IOS/call=32/32
>>>>>> ^CExiting on signal
>>>>>> Maximum IOPS=1.85M
>>>>>
>>>>> With the poll support queued up, I ran this one as well. tldr is:
>>>>>
>>>>> bdev (non pt)??? 122M IOPS
>>>>> irq driven??? 51-52M IOPS
>>>>> polled??????? 71M IOPS
>>>>> polled+fixed??? 78M IOPS

Followup on this, since t/io_uring didn't correctly detect NUMA nodes
for passthrough.

With the current tree and the patchset I just sent for iopoll and the
caching fix that's in the block tree, here's the final score:

polled+fixed passthrough	105M IOPS

which is getting pretty close to the bdev polled fixed path as well.
I think that is starting to look pretty good!

[...]
submitter=22, tid=4768, file=/dev/ng22n1, node=8
submitter=23, tid=4769, file=/dev/ng23n1, node=8
polled=1, fixedbufs=1/0, register_files=1, buffered=1, QD=128
Engine=io_uring, sq_ring=128, cq_ring=128
IOPS=102.51M, BW=50.05GiB/s, IOS/call=32/31
IOPS=105.29M, BW=51.41GiB/s, IOS/call=31/32
IOPS=105.34M, BW=51.43GiB/s, IOS/call=32/31
IOPS=105.37M, BW=51.45GiB/s, IOS/call=32/32
IOPS=105.37M, BW=51.45GiB/s, IOS/call=31/31
IOPS=105.38M, BW=51.45GiB/s, IOS/call=31/31
IOPS=105.35M, BW=51.44GiB/s, IOS/call=32/32
IOPS=105.49M, BW=51.51GiB/s, IOS/call=32/31
^CExiting on signal
Maximum IOPS=105.49M


-- 
Jens Axboe



