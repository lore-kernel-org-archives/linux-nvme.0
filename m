Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2E84ECAAD5
	for <linux-nvme@archiver.kernel.org>; Fri,  2 Sep 2022 19:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ry9qz4Ug3drArxnbcnODIH8HPoQFI54s25GygjQ0sKo=; b=qtnAIgx23O/gtNm6oOHv0lew3G
	VfjiI+z0Kdvum4DLM8PQIe4M2lfj3MjQjRcyJrPZEGWuwfuYtBTdU0ZR0NjOzo+rFgkU0xurz4Jt6
	RgFFx2DBTdnyC5D5JznK4TFWgXtTBvd+K9/VxllCcVmfOPo11Qpqi6+pNmW4za9X0Q4RadzsTzlLz
	GuCHKkyL1OmdH7o+7Yr8W55vk4Ee/Oiq0RL86/oTujgD6jAjetcPKZh1BPXsh6lMA27doKHt72JqV
	WgB25aYuKutxw3YD9QD56luhNNlrvhX9mQ51KTRM55cBgF1faPUfq4FRVI9CC+Zu8PAr6nWGmMH2z
	JV+MPZmg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oUCP2-00ALZ8-9Y; Fri, 02 Sep 2022 19:32:32 +0000
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oUCOz-00ALXh-9z
	for linux-nvme@lists.infradead.org; Fri, 02 Sep 2022 19:32:31 +0000
Received: by mail-pj1-x102c.google.com with SMTP id x1-20020a17090ab00100b001fda21bbc90so6419248pjq.3
        for <linux-nvme@lists.infradead.org>; Fri, 02 Sep 2022 12:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=Ry9qz4Ug3drArxnbcnODIH8HPoQFI54s25GygjQ0sKo=;
        b=a0ajXOH9mNVz1/N39f8ZJF3YF5bhV30o5rq0H70STqonqeujYUpv8MdBDfAieLFM31
         D5ICdUml4P3QyjlTxszdCBv//G/JfLZ/s7AhMVFbKt9jSuIJsxPOjaZNKGGfg5zmxZ53
         ZGnL69DW31DvDxV1thYJzfYbcore8G5fXx/boUVbY9xwQ2jADEFMU8U21aJJVoYbE0+r
         oUwVmDrABBHjBMxSs28k/bVcg7pMegIvipgJC3798fzaTSaR5lZWP3QUz9WUD9lJ6SWa
         kpV8X6vf2/ndocxO9Op+ScnK0aAwtWA+zC32sTb2c8zXgcS8Mo6dfjx0k7FkLeFPm4Eu
         qPeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Ry9qz4Ug3drArxnbcnODIH8HPoQFI54s25GygjQ0sKo=;
        b=VvlLBwxkYq2Jc0gQTBOTWwjWMdGlcP/2/AStlx8smG6+avQIiYlxWYATYSM4qGVX0F
         CB5kuyFHQG1QGaT17NuwLzwgeqXa9M0TNLcFuIrryBap59jDGg4S+HqBBEZUGvRuMzmX
         Zvyw0HzkfY5sbf6nr9ohWMaCNiJG4jzD+zW7D0BByYK9XNmbZd/Zi2SMp4tVvuWu5FeO
         syB7OboA+LY7CxH65MiEhe7LpEOWKRnYZLWrLTQP4s8NYkq0UzIepNd6pVndrPixq4xv
         1tsSXDqWfEAx6MjxbTviK4Sbiu8HNCiM000fTtcTwV0HS6toxhz03JE+KZ+lRRGp9ZYx
         xHVw==
X-Gm-Message-State: ACgBeo33O7K8AppUTKtBmehGhfeVWGsMeNXBS7N1ulIt8++HGj8NdfDB
	hC6RzN1ksQY5OiXYeY6knY84iA==
X-Google-Smtp-Source: AA6agR7Usv6PTE2jWCD39oaTpKAjmsJJNSWV0Z5hO6DIhiMc6IBH89jSLLrfTK3l0y2fIOTnHoozyg==
X-Received: by 2002:a17:90b:3e86:b0:1f5:2b4f:7460 with SMTP id rj6-20020a17090b3e8600b001f52b4f7460mr6509336pjb.97.1662147147188;
        Fri, 02 Sep 2022 12:32:27 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id u6-20020a62d446000000b00537f7d04fb3sm2244296pfl.145.2022.09.02.12.32.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Sep 2022 12:32:26 -0700 (PDT)
Message-ID: <48856ca4-5158-154e-a1f5-124aadc9780f@kernel.dk>
Date: Fri, 2 Sep 2022 13:32:24 -0600
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
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220902184608.GA6902@test-zns>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220902_123229_596549_EDA45327 
X-CRM114-Status: GOOD (  24.47  )
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

On 9/2/22 12:46 PM, Kanchan Joshi wrote:
> On Fri, Sep 02, 2022 at 10:32:16AM -0600, Jens Axboe wrote:
>> On 9/2/22 10:06 AM, Jens Axboe wrote:
>>> On 9/2/22 9:16 AM, Kanchan Joshi wrote:
>>>> Hi,
>>>>
>>>> Currently uring-cmd lacks the ability to leverage the pre-registered
>>>> buffers. This series adds the support in uring-cmd, and plumbs
>>>> nvme passthrough to work with it.
>>>>
>>>> Using registered-buffers showed peak-perf hike from 1.85M to 2.17M IOPS
>>>> in my setup.
>>>>
>>>> Without fixedbufs
>>>> *****************
>>>> # taskset -c 0 t/io_uring -b512 -d128 -c32 -s32 -p0 -F1 -B0 -O0 -n1 -u1 /dev/ng0n1
>>>> submitter=0, tid=5256, file=/dev/ng0n1, node=-1
>>>> polled=0, fixedbufs=0/0, register_files=1, buffered=1, QD=128
>>>> Engine=io_uring, sq_ring=128, cq_ring=128
>>>> IOPS=1.85M, BW=904MiB/s, IOS/call=32/31
>>>> IOPS=1.85M, BW=903MiB/s, IOS/call=32/32
>>>> IOPS=1.85M, BW=902MiB/s, IOS/call=32/32
>>>> ^CExiting on signal
>>>> Maximum IOPS=1.85M
>>>
>>> With the poll support queued up, I ran this one as well. tldr is:
>>>
>>> bdev (non pt)??? 122M IOPS
>>> irq driven??? 51-52M IOPS
>>> polled??????? 71M IOPS
>>> polled+fixed??? 78M IOPS
> 
> except first one, rest three entries are for passthru? somehow I didn't
> see that big of a gap. I will try to align my setup in coming days.

Right, sorry it was badly labeled. First one is bdev with polling,
registered buffers, etc. The others are all the passthrough mode. polled
goes to 74M with the caching fix, so it's about a 74M -> 82M bump using
registered buffers with passthrough and polling.

>> polled+fixed??? 82M
>>
>> I suspect the remainder is due to the lack of batching on the request
>> freeing side, at least some of it. Haven't really looked deeper yet.
>>
>> One issue I saw - try and use passthrough polling without having any
>> poll queues defined and it'll stall just spinning on completions. You
>> need to ensure that these are processed as well - look at how the
>> non-passthrough io_uring poll path handles it.
> 
> Had tested this earlier, and it used to run fine. And it does not now.
> I see that io are getting completed, irq-completion is arriving in nvme
> and it is triggering task-work based completion (by calling
> io_uring_cmd_complete_in_task). But task-work never got called and
> therefore no completion happened.
> 
> io_uring_cmd_complete_in_task -> io_req_task_work_add -> __io_req_task_work_add
> 
> Seems task work did not get added. Something about newly added
> IORING_SETUP_DEFER_TASKRUN changes the scenario.
> 
> static inline void __io_req_task_work_add(struct io_kiocb *req, bool allow_local)
> {
> ?????? struct io_uring_task *tctx = req->task->io_uring;
> ?????? struct io_ring_ctx *ctx = req->ctx;
> ?????? struct llist_node *node;
> 
> ?????? if (allow_local && ctx->flags & IORING_SETUP_DEFER_TASKRUN) {
> ?????????????? io_req_local_work_add(req);
> ?????????????? return;
> ?????? }
> ????....
> 
> To confirm, I commented that in t/io_uring and it runs fine.
> Please see if that changes anything for you? I will try to find the
> actual fix tomorow.

Ah gotcha, yes that actually makes a lot of sense. I wonder if regular
polling is then also broken without poll queues if
IORING_SETUP_DEFER_TASKRUN is set. It should be, I'll check into
io_iopoll_check().

-- 
Jens Axboe

