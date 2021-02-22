Return-Path: <SRS0=neNW=HY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77B53C433DB
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Feb 2021 14:33:55 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0570A64DF0
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Feb 2021 14:33:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0570A64DF0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=4zaSm7EeXqpfDCnC5//t8vItdLe9vvBXToMx9RYU6Mc=; b=ohWoNBa2tW2nQRWwTsjBwvJ3W
	8Xiq5jvhhBugD7h7j36iIR39RvgIncAa2hhBfZAaHJuk70ByIoFXUf8gpHXGN6vr5e/ZTpm4q09vb
	ayEW8Ih0rhG0jgrE/cDQ9TQvaN4X9TW+cA2nSU/IQxxpzIeGO7OUJoc+Dg872wVA/czXShFtzw3kF
	AEmDtcm0F1AwritcbT8KxOIgX6/RgBNpdWeMf7IwrMtXvUihwp3NafI7b1FtFXac+MqfTUIrL6CYt
	c1FnEdTbx0+JQVWCVzp/TdmC/ziCR28D8QqOlpMKtB2VMZ8iNYi+/t0mgPbq5/UihuihrtAUK2Q0T
	WdkT6x5rg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lECHQ-00076Z-K9; Mon, 22 Feb 2021 14:33:44 +0000
Received: from mail-io1-xd34.google.com ([2607:f8b0:4864:20::d34])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lECHO-000767-CE
 for linux-nvme@lists.infradead.org; Mon, 22 Feb 2021 14:33:43 +0000
Received: by mail-io1-xd34.google.com with SMTP id q7so13447268iob.0
 for <linux-nvme@lists.infradead.org>; Mon, 22 Feb 2021 06:33:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=JO32q5fPn0DGWos0JK/kEGYznlXgZQ3x7QyQiycLWM4=;
 b=09PGHVV9iHjJ2KgS1fZmUroAPCg2DpQj8+75pLjnHRIkUBUHc1dcDMPB3m5YmdJk/N
 KrH3S+VlUktXPgbTuCSFX9ATlQ9EyCvg+kZDD38HIqEM4t4vh6NL/L5NII7SESQLVJvE
 98vyscYJcD9WQfOxVsUMoKKieXsvDDAbcjpVXiDnhH6Cew48TLBMMQfCVZl2x2BhVeIz
 or2YjVDlVUCpyq5Fyv6mYxS2tvvb/QQon983I/OlvmQ+pIBpVc+INCaWtC/025lOqPZP
 GUV+TCR3Z7MhLQ08pKOslWuLi37+VYC2Ap6q/Nyb/Xa1QAase9MI0chH8qm3VkZY981N
 /+DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=JO32q5fPn0DGWos0JK/kEGYznlXgZQ3x7QyQiycLWM4=;
 b=qNQCJxQosqW+aOtldVsEhkePi3bmD8vKwqCuaBZAGBZweqWk3rNzsYlo96SqmHvpII
 O6S/rm2hRcvEGiBN1aufMCdrEZXNCsynM1oNqy7BQbdiETMBS0qR2pzAkeRsPLMK+2HI
 Eyv2FhaNfv8da4QJVL1UjPL7QzrSWoKuDCHxqD99kGDpaUczeYe5FNRU2FC1eSW9OK+u
 cPnyT53Yve3qjNlHaOGn38hVXG/c1VzQwu0heLfhAz76DplUGZ4D0niaDe96nM6x4NM3
 Ut8c9FQ6QuhltbgloXgKG0BqO1wnqscaV7pgvq3cnZB92tmY5ZasQnrNyyLE7WyySaGI
 wpSw==
X-Gm-Message-State: AOAM53109Kfbp+qaNUxYsg7kot9RB+l21TCny2pP4LYAP7kz0valFWZT
 qYEm8uCPToRaD36SsbGgin700Q==
X-Google-Smtp-Source: ABdhPJyzVpeauR6vkegV1RB7nvXptTO6uzLp5CKgeWirnk2rWHV8k8twxWA94BkkuabkQp4U+BkNxg==
X-Received: by 2002:a6b:d01a:: with SMTP id x26mr15797193ioa.11.1614004420388; 
 Mon, 22 Feb 2021 06:33:40 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
 by smtp.gmail.com with ESMTPSA id h13sm13055345ioe.40.2021.02.22.06.33.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Feb 2021 06:33:39 -0800 (PST)
Subject: Re: [RFC PATCH 0/4] Asynchronous passthrough ioctl
To: Kanchan Joshi <joshiiitr@gmail.com>
References: <CGME20210127150134epcas5p251fc1de3ff3581dd4c68b3fbe0b9dd91@epcas5p2.samsung.com>
 <20210127150029.13766-1-joshi.k@samsung.com>
 <489691ce-3b1e-30ce-9f72-d32389e33901@gmail.com>
 <a287bd9e-3474-83a4-e5c2-98df17214dc7@gmail.com>
 <CA+1E3rJHHFyjwv7Kp32E9H-cf5ksh0pOHSVdGoTpktQrB8SE6A@mail.gmail.com>
 <2d37d0ca-5853-4bb6-1582-551b9044040c@kernel.dk>
 <CA+1E3rKeqaLXBuvpMcjZ37XH9RqJHjPnTFObJj0T-u8K9Otw-w@mail.gmail.com>
 <dd0392a1-acfa-ef4d-5531-5f1dddc9efe7@kernel.dk>
 <CA+1E3rJqtpfDbKVGBjSYhX=WfzZ2bE8b0U3drUNz_=bp0u9Vuw@mail.gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <03c15e42-c10a-1f67-c60b-ddc11902f9c5@kernel.dk>
Date: Mon, 22 Feb 2021 07:33:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CA+1E3rJqtpfDbKVGBjSYhX=WfzZ2bE8b0U3drUNz_=bp0u9Vuw@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210222_093342_473911_E9EA53A9 
X-CRM114-Status: GOOD (  37.43  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Selvakumar S <selvakuma.s1@samsung.com>, sagi@grimberg.me,
 Kanchan Joshi <joshi.k@samsung.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 linux-fsdevel@vger.kernel.org, Nitesh Shetty <nj.shetty@samsung.com>,
 Keith Busch <kbusch@kernel.org>, Javier Gonzalez <javier.gonz@samsung.com>,
 Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2/22/21 6:42 AM, Kanchan Joshi wrote:
> On Thu, Jan 28, 2021 at 10:54 PM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> On 1/28/21 10:13 AM, Kanchan Joshi wrote:
>>> On Thu, Jan 28, 2021 at 8:08 PM Jens Axboe <axboe@kernel.dk> wrote:
>>>>
>>>> On 1/28/21 5:04 AM, Kanchan Joshi wrote:
>>>>> On Wed, Jan 27, 2021 at 9:32 PM Pavel Begunkov <asml.silence@gmail.com> wrote:
>>>>>>
>>>>>> On 27/01/2021 15:42, Pavel Begunkov wrote:
>>>>>>> On 27/01/2021 15:00, Kanchan Joshi wrote:
>>>>>>>> This RFC patchset adds asynchronous ioctl capability for NVMe devices.
>>>>>>>> Purpose of RFC is to get the feedback and optimize the path.
>>>>>>>>
>>>>>>>> At the uppermost io-uring layer, a new opcode IORING_OP_IOCTL_PT is
>>>>>>>> presented to user-space applications. Like regular-ioctl, it takes
>>>>>>>> ioctl opcode and an optional argument (ioctl-specific input/output
>>>>>>>> parameter). Unlike regular-ioctl, it is made to skip the block-layer
>>>>>>>> and reach directly to the underlying driver (nvme in the case of this
>>>>>>>> patchset). This path between io-uring and nvme is via a newly
>>>>>>>> introduced block-device operation "async_ioctl". This operation
>>>>>>>> expects io-uring to supply a callback function which can be used to
>>>>>>>> report completion at later stage.
>>>>>>>>
>>>>>>>> For a regular ioctl, NVMe driver submits the command to the device and
>>>>>>>> the submitter (task) is made to wait until completion arrives. For
>>>>>>>> async-ioctl, completion is decoupled from submission. Submitter goes
>>>>>>>> back to its business without waiting for nvme-completion. When
>>>>>>>> nvme-completion arrives, it informs io-uring via the registered
>>>>>>>> completion-handler. But some ioctls may require updating certain
>>>>>>>> ioctl-specific fields which can be accessed only in context of the
>>>>>>>> submitter task. For that reason, NVMe driver uses task-work infra for
>>>>>>>> that ioctl-specific update. Since task-work is not exported, it cannot
>>>>>>>> be referenced when nvme is compiled as a module. Therefore, one of the
>>>>>>>> patch exports task-work API.
>>>>>>>>
>>>>>>>> Here goes example of usage (pseudo-code).
>>>>>>>> Actual nvme-cli source, modified to issue all ioctls via this opcode
>>>>>>>> is present at-
>>>>>>>> https://github.com/joshkan/nvme-cli/commit/a008a733f24ab5593e7874cfbc69ee04e88068c5
>>>>>>>
>>>>>>> see https://git.kernel.dk/cgit/linux-block/log/?h=io_uring-fops
>>>>>>>
>>>>>>> Looks like good time to bring that branch/discussion back
>>>>>>
>>>>>> a bit more context:
>>>>>> https://github.com/axboe/liburing/issues/270
>>>>>
>>>>> Thanks, it looked good. It seems key differences (compared to
>>>>> uring-patch that I posted) are -
>>>>> 1. using file-operation instead of block-dev operation.
>>>>
>>>> Right, it's meant to span wider than just block devices.
>>>>
>>>>> 2. repurpose the sqe memory for ioctl-cmd. If an application does
>>>>> ioctl with <=40 bytes of cmd, it does not have to allocate ioctl-cmd.
>>>>> That's nifty. We still need to support passing larger-cmd (e.g.
>>>>> nvme-passthru ioctl takes 72 bytes) but that shouldn't get too
>>>>> difficult I suppose.
>>>>
>>>> It's actually 48 bytes in the as-posted version, and I've bumped it to
>>>> 56 bytes in the latest branch. So not quite enough for everything,
>>>> nothing ever will be, but should work for a lot of cases without
>>>> requiring per-command allocations just for the actual command.
>>>
>>> Agreed. But if I got it right, you are open to support both in-the-sqe
>>> command (<= 56 bytes) and out-of-sqe command (> 56 bytes) with this
>>> interface.
>>> Driver processing the ioctl can fetch the cmd from user-space in one
>>> case (as it does now), and skips in another.
>>
>> Your out-of-seq command would be none of io_urings business, outside of
>> the fact that we'd need to ensure it's stable if we need to postpone
>> it. So yes, that would be fine, it just means your actual command is
>> passed in as a pointer, and you would be responsible for copying it
>> in for execution
>>
>> We're going to need something to handle postponing, and something
>> for ensuring that eg cancelations free the allocated memory.
> 
> I have few doubts about allocation/postponing. Are you referring to
> uring allocating memory for this case, similar to the way
> "req->async_data" is managed for few other opcodes?
> Or can it (i.e. larger cmd) remain a user-space pointer, and the
> underlying driver fetches the command in.
> If submission context changes (for sqo/io-wq case), uring seemed to
> apply context-grabbing techniques to make that work.

There are two concerns here:

1) We need more space than the 48 bytes, which means we need to allocate
   the command or part of the command when get the sqe, and of course
   free that when the command is done.

2) When io_uring_enter() returns and has consumed N commands, the state
   for those commands must be stable. Hence if you're passing in a
   pointer to a struct, that struct will have been read and store
   safely. This prevents things like on-stack structures from being an
   issue.

->async_data deals with #2 here, it's used when a command needs to store
data because we're switching to an async context to execute the command
(or the command is otherwise deferred, eg links and such). You can
always rely on the context being sane, it's either the task itself or
equivalent.

>>>>> And for some ioctls, driver may still need to use task-work to update
>>>>> the user-space pointers (embedded in uring/ioctl cmd) during
>>>>> completion.
>>>>>
>>>>> @Jens - will it be fine if I start looking at plumbing nvme-part of
>>>>> this series on top of your work?
>>>>
>>>> Sure, go ahead. Just beware that things are still changing, so you might
>>>> have to adapt it a few times. It's still early days, but I do think
>>>> that's the way forward in providing controlled access to what is
>>>> basically async ioctls.
>>>
>>> Sounds good, I will start with the latest branch that you posted. Thanks.
>>
>> It's io_uring-fops.v2 for now, use that one.
> 
> Moved to v3 now.
> nvme_user_io is 48 bytes, while nvme passthrough requires 72 or 80
> bytes (passthru with 64 bit result).
> The block_uring_cmd has 32 bytes of available space. If NVMe defines
> its own "nvme_uring_cmd" (which can be used for nvme char interface)
> that will buy some more space, but still won't be enough for passthru
> command.
> 
> So I am looking at adding support for large-cmd in uring. And felt the
> need to clear those doubts I mentioned above.

The simple solution is to just keep the command type the same on the
NVMe side, and just pass in a pointer to it. Then API could then be
nr_commands and **commands, for example.

But I think we're getting to the point where it'd be easier to just
discuss actual code. So if you rebase on top of the v3 code, then send
out those patches and we can discuss the most convenient API to present
for nvme passthrough and friends. Does that work?

-- 
Jens Axboe


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
