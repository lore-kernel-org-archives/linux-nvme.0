Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 238BFC46CA1
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Sep 2023 12:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xOpV6hQZQfR4zAXxxdJHDxxMVmbI1YEv5V4S+uXf74U=; b=RnRPg7wpFEHbsDHfWH588cAvrH
	mJ9eiIxXqtwIL3dcHJkoB6Gnh+qiagJi64kR5CDx8oWx6gRC92M+OLXXWt5nSEcDy/ACfykrRyhSw
	lhu4bDvVLSqA9Z61YZAzAbn6ZoVjLAu0QYX++On2GLTLl/1IAs8ZkQLCUoSmkYucL+eqlUi7lCaz1
	hHOopFGiAtVqOW77k1siqT2nK58TKq1xZVFJRwljUZwbhjqedtHobcih6Gd09hkUXTFR/EUp2yLsy
	YpwbuffdH54NWmJncgCcqcK4qXq49SwzFb8LjkVcihWVfJqQW3ED4V2Li/+2C3SE6C2yn86OdQP0c
	H/a/qGqQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qiDaj-00FS6h-2A;
	Mon, 18 Sep 2023 12:43:05 +0000
Received: from mail-wm1-f54.google.com ([209.85.128.54])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qiDaf-00FS4A-2y
	for linux-nvme@lists.infradead.org;
	Mon, 18 Sep 2023 12:43:04 +0000
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4046f7d49a9so13678205e9.1
        for <linux-nvme@lists.infradead.org>; Mon, 18 Sep 2023 05:42:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695040978; x=1695645778;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xOpV6hQZQfR4zAXxxdJHDxxMVmbI1YEv5V4S+uXf74U=;
        b=AfllluOvcuO0nkXkSgLApk+Ds6T0oWtSPojnrR+mjFTwTQ1DtxG2ANXfQkupaJ2Qmg
         sVi+Xmm3ErHXj+9dXVZaRZE1gxv5qdtOFZTTtEaXqdTFDOpbDLj6r6ZQ//+QcYUiLkZy
         AutoYpu1Npz3SYuX/HwlIeENCbdjxc0qxLxp8vUx5HPtQ9+1XIdJPKoTWrodbJupPH1s
         I/1fBr7P7RpBDXKqfdFWi2A2g722vi9k33vRfuZZqmp6GGpUpX4c4gE7i21pifxn+36A
         W6dglVDU5FGD6Dhxa7ZMECC2TtSdyaWiiKiBo6parpfOHqqHXEKtaxvLEGB+MhjbIc85
         01Yw==
X-Gm-Message-State: AOJu0Yyv0WPsP20qaEZTnsLtVLc0bMKJHDKdfTWhLjK1LybQzQo0a4L9
	Pk4sFt9YExX+bRR1hanAgMkIMLP583E=
X-Google-Smtp-Source: AGHT+IEiXLVgj7Geg2yqOkay8HsFeA+jnBhYLKRUupJv4JYEHuy4lsJ5pFscKLi+odlv8QaUcDxHKA==
X-Received: by 2002:a05:600c:3b03:b0:3ff:8617:672b with SMTP id m3-20020a05600c3b0300b003ff8617672bmr8746900wms.2.1695040977259;
        Mon, 18 Sep 2023 05:42:57 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id 8-20020a05600c028800b00402c0a8a084sm15047710wmk.17.2023.09.18.05.42.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 05:42:56 -0700 (PDT)
Message-ID: <4305fe43-9742-9fd1-aef3-9547fa939f9a@grimberg.me>
Date: Mon, 18 Sep 2023 15:42:55 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCHv11 00/18] nvme: In-kernel TLS support for TCP
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Pawel Baldysiak <pawel.baldysiak@dell.com>
Cc: linux-nvme@lists.infradead.org
References: <20230824143925.9098-1-hare@suse.de>
 <20230906084840.3710977-1-pawel.baldysiak@dell.com>
 <0e3fe3f6-3d14-4117-bff7-093b1b2edde2@suse.de>
 <46878e81-92ba-4624-af7a-c4d620ff524b@suse.de>
 <5691d882-f450-4d77-a3cc-5627e15c3232@grimberg.me>
 <9761ba6d-3e81-4550-861e-73d08b6085f3@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <9761ba6d-3e81-4550-861e-73d08b6085f3@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230918_054301_961514_E2AC0C15 
X-CRM114-Status: GOOD (  24.22  )
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



On 9/18/23 15:15, Hannes Reinecke wrote:
> On 9/14/23 20:10, Sagi Grimberg wrote:
>>
>>
>> On 9/11/23 15:09, Hannes Reinecke wrote:
>>> On 9/6/23 12:04, Hannes Reinecke wrote:
>>>> On 9/6/23 10:48, Pawel Baldysiak wrote:
>>>>> Hi Hannes,
>>>>>
>>>>> I'm testing v15 patchset in extensive way and observing that it is 
>>>>> not stable.
>>>>> I'm running it on two connected machines - one is used as a host, 
>>>>> second as target.
>>>>> Once connected I'm running I/Os with dd.
>>>>> Eventually I got I/O timeouts from nvme layer on host,
>>>>> causing connect/disconnect loops and I/O hung.
>>>>> Does not matter if the workload is reads or writes.
>>>>>
>>>> Do you have the kernel message log here?
>>>> It _might_ be that we're overloading the TLS stack, such that 
>>>> processing of individual packets is taking too long and triggering a 
>>>> KATO.
>>>>
>>>>> Second test is connect/disconnect loops.
>>>>> On disconnect I've got ocasional delays due to nvme commands timeouts.
>>>>> The disconnect happens eventually, but first it need to hit timeout.
>>>>>
>>>> Again, do you have message logs?
>>>>
>>> Managed to validate it with a larger setup.
>>> Message log is:
>>> nvme nvme0: mapped 16/0/0 default/read/poll queues.
>>> nvme nvme0: new ctrl: NQN "nqn.exuma", addr 10.168.136.124:4420
>>> nvme nvme0: Removing ctrl: NQN "nqn.exuma"
>>> nvme nvme0: queue 1: timeout cid 0x3071 type 4 opcode 0x2 (Read)
>>> nvme0c0n1: Read(0x2) @ LBA 15999927, 9 blocks, Host Aborted Command 
>>> (sct 0x3 / sc 0x71)
>>> nvme nvme0: queue 1: timeout cid 0x2078 type 4 opcode 0x2 (Read)
>>> nvme0c0n1: Read(0x2) @ LBA 15999872, 4 blocks, Host Aborted Command 
>>> (sct 0x3 / sc 0x71)
>>> nvme nvme0: queue 1: timeout cid 0x2079 type 4 opcode 0x2 (Read)
>>> nvme0c0n1: Read(0x2) @ LBA 15999877, 1 blocks, Host Aborted Command 
>>> (sct 0x3 / sc 0x71)
>>> nvme nvme0: queue 1: timeout cid 0x207a type 4 opcode 0x2 (Read)
>>> nvme0c0n1: Read(0x2) @ LBA 15999879, 2 blocks, Host Aborted Command 
>>> (sct 0x3 / sc 0x71)
>>> nvme nvme0: queue 1: timeout cid 0x207b type 4 opcode 0x2 (Read)
>>> nvme0c0n1: Read(0x2) @ LBA 15999882, 4 blocks, Host Aborted Command 
>>> (sct 0x3 / sc 0x71)
>>> nvme nvme0: queue 1: timeout cid 0x207c type 4 opcode 0x2 (Read)
>>> nvme0c0n1: Read(0x2) @ LBA 15999887, 21 blocks, Host Aborted Command 
>>> (sct 0x3 / sc 0x71)
>>> nvme nvme0: queue 1: timeout cid 0x207d type 4 opcode 0x2 (Read)
>>> nvme0c0n1: Read(0x2) @ LBA 15999909, 6 blocks, Host Aborted Command 
>>> (sct 0x3 / sc 0x71)
>>> nvme nvme0: queue 1: timeout cid 0x207e type 4 opcode 0x2 (Read)
>>> nvme0c0n1: Read(0x2) @ LBA 15999916, 10 blocks, Host Aborted Command 
>>> (sct 0x3 / sc 0x71)
>>> block nvme0n1: no available path - failing I/O
>>> Buffer I/O error on dev nvme0n1, logical block 15999872, async page read
>>> nvme nvme0: failed to send request -32
>>> nvme nvme0: Property Set error: 880, offset 0x14
>>
>> Can you add timestamps to the log trace?
>>
>>>
>>> Which actually points to an issue in the teardown flow.
>>> nvme_do_delete_ctrl() does this:
>>>
>>>         nvme_stop_ctrl(ctrl);
>>>         nvme_remove_namespaces(ctrl);
>>>         ctrl->ops->delete_ctrl(ctrl);
>>>
>>> and ->delete_ctrl()
>>>   ->nvme_tcp_delete_ctrl()
>>>     ->nvme_tcp_teardown_ctrl()
>>>       ->nvme_tcp_teardown_io_queues()
>>>
>>> has:
>>>         nvme_quiesce_admin_queue(ctrl);
>>>         nvme_quiesce_io_queues(ctrl);
>>>         nvme_sync_io_queues(ctrl);
>>>         nvme_tcp_stop_io_queues(ctrl);
>>>
>>> Now, if you look at 'nvme_sync_io_queues()' you'll find
>>>
>>>         down_read(&ctrl->namespaces_rwsem);
>>>         list_for_each_entry(ns, &ctrl->namespaces, list)
>>>                 blk_sync_queue(ns->queue);
>>>         up_read(&ctrl->namespaces_rwsem);
>>>
>>> but we've removed all namespaces right at the start in
>>> nvme_do_delete_ctr(), so this is a no-op and we'll never
>>> catch any I/O in flight causing the timeouts to occur :-(
>>
>> Hannes, its not clear to me what you're saying here. What is different
>> in TLS that makes the teardown go that slow?
>>
>> Also, what is being blocked here? Are there still I/Os to an already
>> deleted namespace?
> 
> Hmm. Seems to be an interrelated issue. Problem is that TLS sessions 
> occasionally time out right after initiating the connection, and it'll
> take some reconnect attempts to get things sorts.

Sounds like the trigger to the problem. If there is some I/O stalls
that would explain why there are resets due to either an I/O or
the keep-alive timing out.

> Still debugging; seems like an issue with the network stack.

Interesting, please do share when you have some further insights.

> And while reconnection is underway of course the I/O is aborted, but
> depending on the timing namespace scanning might be underway, so we're
> blocked in 'flush_work(&ctrl->scan_work)' in nvme_remove_namespaces()
> and have to wait for command timeout on namespace identify et al.
> So that is probably expected,

The scan_work is fine to block if there is an ongoing admin command
that needs to timeout first. However this should be bound to the admin
timeout, not forever. After that any reconnection attempts should not
continue as the ctrl state is DELETING.

Is this a permanent phenomenon? or just stuck and gets released at some
point?

BTW, in your tests you are triggering a disconnect (delete), was that
step included as part of the report from Pawel?

> and I'll be concentrating on figuring out why we're seeing reconnections.

Sure, it'll also be good to align that you are doing the same tests.

