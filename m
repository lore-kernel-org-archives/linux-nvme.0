Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2214BC43217
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Nov 2022 14:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mcL/c2va//ihybL7+IRq8ycr26nOREJOCom8pQfBcmk=; b=xduXfwj8YQuw8E7tDgMjhy/YFy
	GwWdWtYlCuloTJaGyfdU+yP1ckLzjc5p7Z2i+Hr/H7PD6TwvgXigkfUSnySH7mo7CqX3zXhk3BBgw
	gaJ6+j621OFtvT+3QqEJbv9iPy3vL530o5mGU4cgSLE3smjbZOgLdrYSHsZAdteYaWSgcQxTBjvec
	9vp815UdkEx89QXUB/MCmrWxZJJ3jfLYNyr4zllB81GI0rKEr4e2AirB2gO6/NpMgHtKCUbzmJLUq
	+8TUXzdeTTnRHfeYPA5DXGlNXFH29VMOieRIckWqnz8dbMZO4zwAqLVTMMWTHKlUZfmgnriWe3723
	wyGyP5bg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oyD3H-009DhO-4a; Thu, 24 Nov 2022 14:18:07 +0000
Received: from mail-wr1-f45.google.com ([209.85.221.45])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oyD3B-009Dda-St
	for linux-nvme@lists.infradead.org; Thu, 24 Nov 2022 14:18:03 +0000
Received: by mail-wr1-f45.google.com with SMTP id n7so2645115wrr.13
        for <linux-nvme@lists.infradead.org>; Thu, 24 Nov 2022 06:17:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mcL/c2va//ihybL7+IRq8ycr26nOREJOCom8pQfBcmk=;
        b=qWJKjlWtvRaCa+CwZLzRNaaa+29CIShMws/PJ1L93LLVK5e73SbfchMOQTBV2kGE+g
         3vOGF9DG26fUZd0LBd7xyPn20mEsBZ5l41XCNCKFyuIkJ3c+blx2h1l0QAe49YDQeUZ7
         /B/kwjhmWgSnm5WiPOxSOxizU8MxPyIc4omF59mzQbF0upl4MmKTX6pzR+BtSaholQwF
         QzjKwgbB/1u5VGAqhtNFtwmcuvDfiZzCrTTxsKJQvo1nX8KZZKCmN4jB44BHPgQJeBln
         OUEiJjiQfaO8AV+1T75ti55Rr0r3PVGJqpP/MF6BBmzXXocKW197D/dGrLbI9rFOYnRk
         no2A==
X-Gm-Message-State: ANoB5pmSlKb9wyWomogsvt+D32Dd3fD2UcVn0oOHyNjiNAB7HCgjlavi
	xZoS7soLRQbjgzPNnrHKbIqpU441fIg=
X-Google-Smtp-Source: AA0mqf7YqpRU/j7gUFF46TfHT2H1XOqWo3WjIe8ea+vSP2BdmXiyr508ASxEIEcPO2tUVvQxiQlQZA==
X-Received: by 2002:adf:eb90:0:b0:236:b8b9:b018 with SMTP id t16-20020adfeb90000000b00236b8b9b018mr20857528wrn.596.1669299478206;
        Thu, 24 Nov 2022 06:17:58 -0800 (PST)
Received: from [10.100.102.14] (46-116-236-159.bb.netvision.net.il. [46.116.236.159])
        by smtp.gmail.com with ESMTPSA id l19-20020a056000023300b00241de5be3f0sm1470553wrz.37.2022.11.24.06.17.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Nov 2022 06:17:57 -0800 (PST)
Message-ID: <c19cbb68-ec39-0cfc-7e9b-772fa9d0dc77@grimberg.me>
Date: Thu, 24 Nov 2022 16:17:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] nvme: fix SRCU protection of nvme_ns_head list
To: Caleb Sander <csander@purestorage.com>
Cc: Christoph Hellwig <hch@lst.de>, paulmck@kernel.org,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 linux-nvme@lists.infradead.org, Uday Shankar <ushankar@purestorage.com>
References: <dfcd682c-126d-34ab-3858-a7a7fc0afcb3@grimberg.me>
 <20221121074039.GA24507@lst.de>
 <CADUfDZraHB6=i77i9Mivdf5cbUHpKxHofSZFnGhsywb=k-+y_w@mail.gmail.com>
 <20221121175932.GM4001@paulmck-ThinkPad-P17-Gen-1>
 <CADUfDZrVT2tCnUkorJ94Mzd20n-Ch-8cZaSeT0LbowH3dwQ=yw@mail.gmail.com>
 <b42a8825-a263-22fc-9f86-5c3dada173f1@grimberg.me>
 <20221122121449.GA3888@lst.de>
 <6a72cb78-8f23-a612-adab-10f4fe2a2174@grimberg.me>
 <CADUfDZpv43JmNiriEVQ_mFxZVS8QAcmbJaG3rK5KoUBaC9s17g@mail.gmail.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <CADUfDZpv43JmNiriEVQ_mFxZVS8QAcmbJaG3rK5KoUBaC9s17g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221124_061801_988305_E9E194A9 
X-CRM114-Status: GOOD (  31.14  )
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



On 11/24/22 02:12, Caleb Sander wrote:
> On Tue, Nov 22, 2022 at 7:08 AM Sagi Grimberg <sagi@grimberg.me> wrote:
>>
>>
>>>> 3. removes ns from head sibling list + synchronize rcu
>>>>      -> this should fence non-sleeping traversals (like revalidate_paths)
>>>
>>> Well, non-sleeping would only matter if those non-sleeping travesals
>>> are under rcu_read_lock(), but they are not.  They are either part of
>>> a longer srcu critical section because other code can sleep, or in
>>> case of revalidate_paths unprotected at all (which this patch fixes).
>>
>> The original patch comment was that rcu_read_lock/unlock would be
>> sufficient and we don't need to touch nvme_ns_remove()
>>
>>>
>>>> Maybe it is OK to have it also srcu locked and just accept that
>>>> nshead sibling list is srcu protected. In that case, your patch
>>>> needs to extend the srcu also the clearing of current_head pointer.
>>>
>>> I don't see how nvme_mpath_clear_current_path needs (S)RCU protection.
>>> It never dereferences the current_path, it just checks is for pointer
>>> equality and if they match clears it to NULL.  (I wonder if it should
>>> use cmpxchg though).
>>
>> Agree. it can stay out. because at this point it does not compete with
>> concurrent submissions due to prior synchronizations. The list traversal
>> needs to be under rcu lock.
>>
>>
>>>
>>>> But looking again at your bug report, you mention that there are
>>>> concurrent scans, one removing the ns and another accessing it.
>>>> That cannot happen due to the scan_lock held around this section afaict.
>>>>
>>>> I guess it can be that in general ns removal can compete with a scan
>>>> if due to some controller behavior that failed an identify command
>>>> transiently in a prior scan, and a subsequent scan finds it? worth
>>>> pinning down exactly what happened in the race you got because maybe we
>>>> have a different issue that may manifest in other issues.
>>>
>>> So scanning itself should be single threaded as it only happens from
>>> the workqueue.  But nvme_ns_remove can be called from
>>> nvme_remove_namespaces in in 6.1 and earlier from the passthrough
>>> handler.
>>
>> The original patch report did not include any sequence that removes all
>> namespaces, and given that it came from RockyLinux 8.6 kernel, it is not
>> 6.1... Hence I think that we need to understand how a namespace removal
>> happened at the same time that the namespace is being scanned. Maybe
>> something else is broken.
> 
> We can reliably cause the panic by sending a "NS Changed" AEN
> from multiple controllers at the same time, resulting in multiple scan works
> running concurrently for the same namespace heads.

That is fine.

> In our test, we have 4 controllers for the same subsystem, with 9 namespaces
> that are added one at a time, resulting in many AENs for each controller.
> We can see from the dmesg logs that the controllers' scan works overlap:
> [37311.530367] nvme nvme0: queue_size 128 > ctrl sqsize 32, clamping down
> [37311.530398] nvme nvme0: creating 32 I/O queues.
> [37311.819883] nvme nvme0: mapped 32/0/0 default/read/poll queues.
> [37311.828129] nvme nvme0: new ctrl: NQN
> "nqn.2010-06.com.purestorage:flasharray.7896f4eca47b4dea", addr
> 192.168.1.110:4420
> [37311.924908] nvme nvme1: queue_size 128 > ctrl sqsize 32, clamping down
> [37311.924935] nvme nvme1: creating 32 I/O queues.
> [37312.298561] nvme nvme1: mapped 32/0/0 default/read/poll queues.
> [37312.306296] nvme nvme1: new ctrl: NQN
> "nqn.2010-06.com.purestorage:flasharray.7896f4eca47b4dea", addr
> 192.168.3.110:4420
> [37312.400143] nvme nvme2: queue_size 128 > ctrl sqsize 32, clamping down
> [37312.400180] nvme nvme2: creating 32 I/O queues.
> [37312.671861] nvme nvme2: mapped 32/0/0 default/read/poll queues.
> [37312.678318] nvme nvme2: new ctrl: NQN
> "nqn.2010-06.com.purestorage:flasharray.7896f4eca47b4dea", addr
> 192.168.2.110:4420
> [37312.760833] nvme nvme3: queue_size 128 > ctrl sqsize 32, clamping down
> [37312.760860] nvme nvme3: creating 32 I/O queues.
> [37313.123490] nvme nvme3: mapped 32/0/0 default/read/poll queues.
> [37313.130407] nvme nvme3: new ctrl: NQN
> "nqn.2010-06.com.purestorage:flasharray.7896f4eca47b4dea", addr
> 192.168.4.110:4420
> [37313.654120] nvme nvme3: rescanning namespaces.
> [37313.654152] nvme nvme2: rescanning namespaces.
> [37313.654867] nvme0n1: detected capacity change from 0 to 11811160064
> [37313.654876] nvme0n1: detected capacity change from 0 to 11811160064
> [37313.655573] nvme nvme0: rescanning namespaces.
> [37313.655694] nvme nvme1: rescanning namespaces.
> [37313.656405] nvme0n1: detected capacity change from 0 to 11811160064
> [37313.656445] nvme0n1: detected capacity change from 0 to 11811160064
> [37313.897745] nvme nvme3: rescanning namespaces.
> [37313.897748] nvme nvme2: rescanning namespaces.
> [37313.898614] nvme0n2: detected capacity change from 0 to 11811160064
> [37313.907348] nvme nvme0: rescanning namespaces.
> [37313.907409] nvme nvme1: rescanning namespaces.
> [37314.191586] nvme nvme2: rescanning namespaces.
> [37314.191589] nvme nvme3: rescanning namespaces.
> [37314.193241] nvme nvme0: rescanning namespaces.
> [37314.193303] nvme nvme1: rescanning namespaces.
> [37314.205965] nvme0n3: detected capacity change from 0 to 11811160064
> [37314.206026] nvme0n3: detected capacity change from 0 to 11811160064
> [37314.206036] BUG: unable to handle kernel NULL pointer dereference
> at 0000000000000050
> [37314.206036] nvme0n3: detected capacity change from 0 to 11811160064
> 
> I don't see any mechanism to prevent scan work from running concurrently.
> scan_lock is per-controller, but there are 4 controllers in our test.
> I'm not very familiar with work queues in Linux, but it looks like they can run
> multiple pieces of work concurrently.

The scan is running sequentially per-controller, nothing prevents
different controllers to scan at the same time.

> The nvme-wq appears not CPU bound and has a high max concurrency:
> $ cat /sys/bus/workqueue/devices/nvme-wq/per_cpu
> 0
> $ cat /sys/bus/workqueue/devices/nvme-wq/max_active
> 256
> 
> At the end of the scan, nvme_remove_invalid_namespaces() is called,
> which I think explains how we end up with namespace removals during the scans.

I see. Makes sense that at least revalidate_paths is called in parallel
with ns remove which you indicated is being called.

