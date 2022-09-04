Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4232C54EE9
	for <linux-nvme@archiver.kernel.org>; Sun,  4 Sep 2022 20:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Vfwp8lW+77gEMyxyD1D46nuBw5vb4OcIgiJ5hx7SeT0=; b=upnYVXw/ulP5qjD1e3kn2nWE/4
	JR877CyVBfHZ+JC0C2tiDxDqRWSahwTrn2yMhuNLSNsAg9MvNWLiP6D6KtDiCpoWr2YOcjdLuGqZi
	nDRbD9259L8xqNV+VHJ5rSyLQSpWQvjCbBm5qO0EQfB4n4WJOVFL6YJmZv3da/iAlmYNbbpZa40+z
	OKa7R+lVQuHW/WrNhAJTWtLcGV5kZOjAR3Jh58dJ5it9UqQACTIw4g4a916t8wwOuK7ujdkk235CT
	AAlyy3uFppalILbDbdy97lo345Dv4z+zdoQvJ//FU97+gHWA2LYpGoORGGKX2ZMNpTxDUujdQkAht
	2nPqUouA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oUwUQ-00BNT8-Ao; Sun, 04 Sep 2022 20:45:11 +0000
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oUw3n-00B3j4-6x
	for linux-nvme@lists.infradead.org; Sun, 04 Sep 2022 20:17:43 +0000
Received: by mail-pj1-x102f.google.com with SMTP id o2-20020a17090a9f8200b0020025a22208so3134324pjp.2
        for <linux-nvme@lists.infradead.org>; Sun, 04 Sep 2022 13:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=Vfwp8lW+77gEMyxyD1D46nuBw5vb4OcIgiJ5hx7SeT0=;
        b=617Sia/FjjEAki8GGei2Iodf4exUefBYfrA6izFBsw8jtAEmwTX+4EwOwd4Ex54151
         2U26rgFT/dMtdzf91txcSTf1ZtQ5d6GA2jJL0ElfhHvCebpTdulqne2l8Xn4E1GLvRnd
         oIBYRfLsM3bkdtvuvIVSS3VrP3sUF9XgEmY5YC4zhcHwl7Dl1g/8CJuITFFDK/DCYMlS
         Bkc3ShL1lFdqF0ipqr90RE4WWxBVAl3+J90KAWpI0F3bijVKhjfgTDGyMtfgqfpXnBaT
         QrTBaADibiLrTFp/MNnOA585prhViN55rZxQBqUfEtwvyv1um6Ur+jJthIEgMRu8Ck45
         lqQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Vfwp8lW+77gEMyxyD1D46nuBw5vb4OcIgiJ5hx7SeT0=;
        b=o44U56kVYEWHv4BIx59+oc0RN2UJbv/nTUkkoKPplB4E40+TgpsidPMzIskXdvOzHU
         08iEnDwIPJkO6P9jfYIx2MGJ58TUO9ajqOhoUX/LfrBo3qWTRuHXA18q/oi3/r5IrSkQ
         AbueRYm+r3yZNk8uPA5B8pkzUQOy3WsVmbFYHhKCBd9bXHd/8yt3BX3xmL32Q2vrrwfp
         Gv2xC3YOHAfz7IAeD5Fcl9dx4i/XWNVAJ8v42ETl6la3swc3Y6F2MOnA9igpd95UWQXz
         mYLgYO/JjxotK+FAFuGax5MJlTaLgtOO4nWtk3g2TOaf7b7rpXXdyDcmCqaAnwxb5ho0
         XIcg==
X-Gm-Message-State: ACgBeo3qqHHlSnIOs8MrTU5JzuaEI7zCn9kZVPX5rTNQ2tpW3gIGraeS
	/FaFhb/gG1LgsbA0+khojj521Q==
X-Google-Smtp-Source: AA6agR4FSuFVNP11v6l7kDJCr/nMweBf5YlQyKp5qQjqi0zFZJiMk/xSInhOtczRxRO6HqP2ywCZ5A==
X-Received: by 2002:a17:90b:1bc4:b0:1fd:b913:ef58 with SMTP id oa4-20020a17090b1bc400b001fdb913ef58mr15516198pjb.220.1662322656465;
        Sun, 04 Sep 2022 13:17:36 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id p129-20020a622987000000b0052e6d5ee183sm6030727pfp.129.2022.09.04.13.17.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Sep 2022 13:17:35 -0700 (PDT)
Message-ID: <7c0fced8-11b0-fcd9-ac47-662af979b207@kernel.dk>
Date: Sun, 4 Sep 2022 14:17:33 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH for-next v3 0/4] fixed-buffer for uring-cmd/passthrough
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
 <75c6c9ea-a5b4-1ef5-7ff1-10735fac743e@kernel.dk>
 <20220904170124.GC10536@test-zns>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220904170124.GC10536@test-zns>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220904_131741_682734_8918B28E 
X-CRM114-Status: GOOD (  15.03  )
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

On 9/4/22 11:01 AM, Kanchan Joshi wrote:
> On Sat, Sep 03, 2022 at 11:00:43AM -0600, Jens Axboe wrote:
>> On 9/2/22 3:25 PM, Jens Axboe wrote:
>>> On 9/2/22 1:32 PM, Jens Axboe wrote:
>>>> On 9/2/22 12:46 PM, Kanchan Joshi wrote:
>>>>> On Fri, Sep 02, 2022 at 10:32:16AM -0600, Jens Axboe wrote:
>>>>>> On 9/2/22 10:06 AM, Jens Axboe wrote:
>>>>>>> On 9/2/22 9:16 AM, Kanchan Joshi wrote:
>>>>>>>> Hi,
>>>>>>>>
>>>>>>>> Currently uring-cmd lacks the ability to leverage the pre-registered
>>>>>>>> buffers. This series adds the support in uring-cmd, and plumbs
>>>>>>>> nvme passthrough to work with it.
>>>>>>>>
>>>>>>>> Using registered-buffers showed peak-perf hike from 1.85M to 2.17M IOPS
>>>>>>>> in my setup.
>>>>>>>>
>>>>>>>> Without fixedbufs
>>>>>>>> *****************
>>>>>>>> # taskset -c 0 t/io_uring -b512 -d128 -c32 -s32 -p0 -F1 -B0 -O0 -n1 -u1 /dev/ng0n1
>>>>>>>> submitter=0, tid=5256, file=/dev/ng0n1, node=-1
>>>>>>>> polled=0, fixedbufs=0/0, register_files=1, buffered=1, QD=128
>>>>>>>> Engine=io_uring, sq_ring=128, cq_ring=128
>>>>>>>> IOPS=1.85M, BW=904MiB/s, IOS/call=32/31
>>>>>>>> IOPS=1.85M, BW=903MiB/s, IOS/call=32/32
>>>>>>>> IOPS=1.85M, BW=902MiB/s, IOS/call=32/32
>>>>>>>> ^CExiting on signal
>>>>>>>> Maximum IOPS=1.85M
>>>>>>>
>>>>>>> With the poll support queued up, I ran this one as well. tldr is:
>>>>>>>
>>>>>>> bdev (non pt)??? 122M IOPS
>>>>>>> irq driven??? 51-52M IOPS
>>>>>>> polled??????? 71M IOPS
>>>>>>> polled+fixed??? 78M IOPS
>>
>> Followup on this, since t/io_uring didn't correctly detect NUMA nodes
>> for passthrough.
>>
>> With the current tree and the patchset I just sent for iopoll and the
>> caching fix that's in the block tree, here's the final score:
>>
>> polled+fixed passthrough??? 105M IOPS
>>
>> which is getting pretty close to the bdev polled fixed path as well.
>> I think that is starting to look pretty good!
> Great! In my setup (single disk/numa-node), current kernel shows-
> 
> Block MIOPS
> ***********
> command:t/io_uring -b512 -d128 -c32 -s32 -p0 -F1 -B0 -P1 -n1 /dev/nvme0n1
> plain: 1.52
> plain+fb: 1.77
> plain+poll: 2.23
> plain+fb+poll: 2.61
> 
> Passthru MIOPS
> **************
> command:t/io_uring -b512 -d128 -c32 -s32 -p0 -F1 -B0 -O0 -P1 -u1 -n1 /dev/ng0n1
> plain: 1.78
> plain+fb: 2.08
> plain+poll: 2.21
> plain+fb+poll: 2.69

Interesting, here's what I have:

Block MIOPS
============
plain: 2.90
plain+fb: 3.0
plain+poll: 4.04
plain+fb+poll: 5.09	

Passthru MIPS
=============
plain: 2.37
plain+fb: 2.84
plain+poll: 3.65
plain+fb+poll: 4.93

This is a gen2 optane, it maxes out at right around 5.1M IOPS. Note that
I have disabled iostats and merges generally in my runs:

echo 0 > /sys/block/nvme0n1/queue/iostats
echo 2 > /sys/block/nvme0n1/queue/nomerges

which will impact block more than passthru obviously, particularly
the nomerges. iostats should have a similar impact on both of them (but
I haven't tested either of those without those disabled).

-- 
Jens Axboe

