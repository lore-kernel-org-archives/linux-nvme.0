Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D62C1D7877C
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Nov 2024 14:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2+/66L19zIqWL9MK0xfwzldJbGf6XYUQHlYyTGOsrnI=; b=oXqWtHQvO0BNES0tzHEgO9xrlb
	d9xh8Pj1o2+VLg8ons1KIbLmeDdnFI77b8GVgfGRnuYeztaMTObmJHJ7W3WSp0fuEo6KLJT/kdPU2
	SCOCoznsmKMn+A55YaRNW+CIKYaSf0UeU38dKDPJFBKlE78fZhkEdTyXfQf/koR9N3G3/8nRfrCpv
	VjK0yNRVvoGU/oFDn/DDl++pAXboqs8OVucr0QjobkFM5q8DZbRthMB+GlgbC2RBZtpBs1lPudhYP
	7ZFuYnNOECH6cl9e8ZXvujE8x8oDi1bMk/YJX1cDEHNlm9Umn54nmRMoStdxtxDGqiD5TaeX9FNpb
	lYa79uaw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tE8Uw-00000000Fh8-0Oaq;
	Thu, 21 Nov 2024 14:49:34 +0000
Received: from mail-oa1-x2f.google.com ([2001:4860:4864:20::2f])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tE8Ut-00000000FfH-2N9w
	for linux-nvme@lists.infradead.org;
	Thu, 21 Nov 2024 14:49:32 +0000
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-2962feec93bso663658fac.1
        for <linux-nvme@lists.infradead.org>; Thu, 21 Nov 2024 06:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1732200570; x=1732805370; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2+/66L19zIqWL9MK0xfwzldJbGf6XYUQHlYyTGOsrnI=;
        b=e6cp3iAbrm4+0my7TYIfVEwn7oe+Ued1W9VPz02rPOko9j6Tb83ammsY1Uz/TX/qhY
         tvDJ0aYs4CmJVmLKXGv2KB2aDlahotFRxfPfgAoto/FLdajRn4kAMO5GcfzBdjux2X+F
         AIkj9uwKQx2242T0K3QqBny9vZQBeHX14R12wl1jhG34OGF8w2bNgR11Lq3mKyIGHVZ/
         Zfpg/BNSOUF06DQHR+ThC4t5KRTTC8HcGl5YhiwI4MkEQHWy0H83tc+Z1m7Aq9468uQH
         0Bk468iaXYp/vmUlISAd+xrbMM3FBNfd1ZL/9Qlu6L9XhWZ5jNoq1lgBhK55K7gBbFPF
         +jZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732200570; x=1732805370;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2+/66L19zIqWL9MK0xfwzldJbGf6XYUQHlYyTGOsrnI=;
        b=og4ze5KIHEJf/M84iMFj1X7vn3KE33ICAOvf4IekhJJM6RPIwtj0uN3NQ4zwhGCz4B
         2at1MobGGRZ+XbHJ9ulB4yjx+4IyH2AIRQkAzfWBUfu+KjAnAKrOdZrzvqWuc4tZUAkJ
         olQkRuc2LSgNb2C9wEZsJrm7A2OvBXs10BnUcUNkaz10Ye7mSmkCHj1Z4F55Svf0wLsY
         QOpegMgM1x7z+p6Bryud/Ym+6nMxbt66f4jH+zuOhrJxe5LMQ8Y0yX6YwVU+HaHIBvxG
         4uM05xfVMUmUAsUD7aqvPTFQisSQai7ckxjQqoqZMZPlPc3/38KZOBVa3w5eolo0MyOm
         qwbg==
X-Forwarded-Encrypted: i=1; AJvYcCWyIhEdInOPox3snpPlYBrdoktmD0DsAmDAfOth7UIgRpEPtGl/NpFhKVPBJ/FaMK8NsV+SCEOASMQj@lists.infradead.org
X-Gm-Message-State: AOJu0Yxnkjae4KSla6T9IERqrvWLQ2PR+vDeNuaKE4auD30AkbR/LCgS
	y78344IZCPXT0lpAOIUqgXDITTxFFMl/Oq3qTIEbZtzE/a5+azfeDi1kvKfwjwo=
X-Gm-Gg: ASbGncuitMbiypJyrzpnWqCPmbJsMoWW81ZLRYOZV3495FRhp3kPljReBPB92yDYobs
	3qc38ysD1KBOKShJALlYhRpYAGbFKFmya8QlQVonUPSbb/KP8T4ZF8FaJg/7EXpquloCRcpZ7v5
	4NlOQXOtipAU3ViZUSKnGf+LsvKI5tsjH9ytGOXZV7ckcwialkf8JSFCUT7apqltKbdG2yjHlZ8
	7EACC0Kt/pNaG72Y+JDvey0TYwtGZQerRPo4ZHKHiMs5A==
X-Google-Smtp-Source: AGHT+IFNrnSalwJ8Ln03ltl79/WoctqRlWoKBzFj94ZqnpbO7kUvel0Z5aZJ8hZfVYejeQ5nDN2fHg==
X-Received: by 2002:a05:6870:b50f:b0:296:9dba:6398 with SMTP id 586e51a60fabf-296d9ae3ab8mr7166734fac.7.1732200569835;
        Thu, 21 Nov 2024 06:49:29 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-29651b2fbd4sm4927124fac.44.2024.11.21.06.49.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2024 06:49:29 -0800 (PST)
Message-ID: <a01ead6b-bd1d-4cd3-ade6-59ad905273e7@kernel.dk>
Date: Thu, 21 Nov 2024 07:49:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug-report] 5-9% FIO randomwrite ext4 perf regression on 6.12.y
 kernel
To: Phil Auld <pauld@redhat.com>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Ramanan Govindarajan <ramanan.govindarajan@oracle.com>,
 Sagi Grimberg <sagi@grimberg.me>, Paul Webb <paul.x.webb@oracle.com>,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
References: <392209D9-5AC6-4FDE-8D84-FB8A82AD9AEF@oracle.com>
 <0cfbfcf6-08f5-4d1b-82c4-729db9198896@nvidia.com>
 <d6049cd0-5755-48ee-87af-eb928016f95b@kernel.dk>
 <20241121113058.GA394828@pauld.westford.csb>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20241121113058.GA394828@pauld.westford.csb>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241121_064931_605932_9691558D 
X-CRM114-Status: GOOD (  23.62  )
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

On 11/21/24 4:30 AM, Phil Auld wrote:
> 
> Hi,
> 
> On Wed, Nov 20, 2024 at 06:20:12PM -0700 Jens Axboe wrote:
>> On 11/20/24 5:00 PM, Chaitanya Kulkarni wrote:
>>> On 11/20/24 13:35, Saeed Mirzamohammadi wrote:
>>>> Hi,
>>>>
>>>> I?m reporting a performance regression of up to 9-10% with FIO randomwrite benchmark on ext4 comparing 6.12.0-rc2 kernel and v5.15.161. Also, standard deviation after this change grows up to 5-6%.
>>>>
>>>> Bisect root cause commit
>>>> ===================
>>>> - commit 63dfa1004322 ("nvme: move NVME_QUIRK_DEALLOCATE_ZEROES out of nvme_config_discard?)
>>>>
>>>>
>>>> Test details
>>>> =========
>>>> - readwrite=randwrite bs=4k size=1G ioengine=libaio iodepth=16 direct=1 time_based=1 ramp_time=180 runtime=1800 randrepeat=1 gtod_reduce=1
>>>> - Test is on ext4 filesystem
>>>> - System has 4 NVMe disks
>>>>
>>>
>>> Thanks a lot for the report, to narrow down this problem can you
>>> please :-
>>>
>>> 1. Run the same test on the raw nvme device /dev/nvme0n1 that you
>>>     have used for this benchmark ?
>>> 2. Run the same test on the  XFS formatted nvme device instead of ext4 ?
>>>
>>> This way we will know if there is an issue only with the ext4 or
>>> with other file systems are suffering from this problem too or
>>> it is below the file system layer such as block layer and nvme pci driver ?
>>>
>>> It will also help if you can repeat these numbers for io_uring fio io_engine
>>> to narrow down this problem to know if the issue is ioengine specific.
>>>
>>> Looking at the commit [1], it only sets the max value to write zeroes 
>>> sectors
>>> if NVME_QUIRK_DEALLOCATE_ZEROES is set, else uses the controller max
>>> write zeroes value.
>>
>> There's no way that commit is involved, the test as quoted doesn't even
>> touch write zeroes. Hence if there really is a regression here, then
>> it's either not easily bisectable, some error was injected while
>> bisecting, or the test itself is bimodal.
> 
> I was just going to ask how confident we are in that bisect result.
> 
> I suspect this is the same issue I've been fighting here:
> 
> https://lore.kernel.org/lkml/20241101124715.GA689589@pauld.westford.csb/
> 
> Saeed, can you try your randwrite test after
> 
>   "echo NO_DELAY_DEQUEUE > /sys/kernel/debug/sched/features"
> 
> please?
> 
> We don't as yet have a general fix for it as it seems to be a bit of
> a trade off.

Interesting. Might explain some regressions I've seen too related to
performance.

-- 
Jens Axboe


