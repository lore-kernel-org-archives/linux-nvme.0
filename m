Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C4F5EEAA5F
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Sep 2023 18:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vYs34KjcKzqgd7h17/uOz3NHgyFCrVMNATUWDv2DPQY=; b=iocV4MkUTOWtuLIPt8aGOivyen
	NoCh/HrSIjxzdlDO/vVZzjngOORKWct6faAE8HUQH/tMuWPtSnrbwQnN0lbWLqx3pHcyc7XXu54oH
	+910nMu9FshWjL4CcuGzSPcfoL13BHvjpJa3ArR9IGbBVa1YfGJDxHukTV04sDpejBhBs2H7yRCAz
	Vpcn03vM9fU5CAjGGgjB4g3T+PaoJPgrMa7D9zFj1vrILJjx/UPMGkxJ6oIMftBGQbqwKdHlqPmJI
	7Da45+zYUVK4Z80IKyzOrC54HATaNrGQs0FguEvjqVFAlgbo0g34aWyfVCnYpiJDWwhYbyTUtVctc
	v2/85kKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qgqnX-0092ol-0n;
	Thu, 14 Sep 2023 18:10:39 +0000
Received: from mail-ej1-f50.google.com ([209.85.218.50])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qgqnU-0092oH-27
	for linux-nvme@lists.infradead.org;
	Thu, 14 Sep 2023 18:10:38 +0000
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-9a9e2ff58e1so36633466b.0
        for <linux-nvme@lists.infradead.org>; Thu, 14 Sep 2023 11:10:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694715033; x=1695319833;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vYs34KjcKzqgd7h17/uOz3NHgyFCrVMNATUWDv2DPQY=;
        b=tRhrFOAEnu1Gb3GwNep5u4bM3OzX3zfUiagb/d6u97b/PAiPiMeB0CstwkwnNiIZvo
         RiaRjSeBnM+P2O5zlJFwnmXTZGlEglkSJhSdwYE53uwJytCcKPXgALID/EdxgVVYbLoC
         G4kCZeySDn3PO7ZYe45bDFI2ilaXLv+/tlr76SEYEuMPrKtEwEEKMmmvVc4bLhfLS4if
         iI/42WiTNvGTLZ3cMFD++ZTMzczMr72HChBOg13s7mVR7/dYaD17pj5/KGqYTntPysTg
         4d46W7u7T7bSCflqiQGpVVlYSBfYuCYs7BxJV+Dch+UfDbsT2S2BuUCN27WuYvA5aHnj
         +oiw==
X-Gm-Message-State: AOJu0Yx8jaIwXHW7DsDWPDYgN75LjJUlSySDGRgFK0e8518eX2PS9y5C
	CQwoTWjihFe0HYa6633QdlA=
X-Google-Smtp-Source: AGHT+IEhhUvUY6EFpba1ea234vFuI+leTjmr7vAY11/UcjqRW8EWDnvfIXChwlvor9P2S2IY1/EPUw==
X-Received: by 2002:a17:906:5187:b0:9a1:be9b:c935 with SMTP id y7-20020a170906518700b009a1be9bc935mr5009960ejk.0.1694715032965;
        Thu, 14 Sep 2023 11:10:32 -0700 (PDT)
Received: from [10.100.102.67] (46-116-234-112.bb.netvision.net.il. [46.116.234.112])
        by smtp.gmail.com with ESMTPSA id g11-20020a170906198b00b009926928d486sm1325181ejd.35.2023.09.14.11.10.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Sep 2023 11:10:31 -0700 (PDT)
Message-ID: <5691d882-f450-4d77-a3cc-5627e15c3232@grimberg.me>
Date: Thu, 14 Sep 2023 21:10:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv11 00/18] nvme: In-kernel TLS support for TCP
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Pawel Baldysiak <pawel.baldysiak@dell.com>
Cc: linux-nvme@lists.infradead.org
References: <20230824143925.9098-1-hare@suse.de>
 <20230906084840.3710977-1-pawel.baldysiak@dell.com>
 <0e3fe3f6-3d14-4117-bff7-093b1b2edde2@suse.de>
 <46878e81-92ba-4624-af7a-c4d620ff524b@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <46878e81-92ba-4624-af7a-c4d620ff524b@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230914_111036_696035_767D4848 
X-CRM114-Status: GOOD (  17.44  )
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



On 9/11/23 15:09, Hannes Reinecke wrote:
> On 9/6/23 12:04, Hannes Reinecke wrote:
>> On 9/6/23 10:48, Pawel Baldysiak wrote:
>>> Hi Hannes,
>>>
>>> I'm testing v15 patchset in extensive way and observing that it is 
>>> not stable.
>>> I'm running it on two connected machines - one is used as a host, 
>>> second as target.
>>> Once connected I'm running I/Os with dd.
>>> Eventually I got I/O timeouts from nvme layer on host,
>>> causing connect/disconnect loops and I/O hung.
>>> Does not matter if the workload is reads or writes.
>>>
>> Do you have the kernel message log here?
>> It _might_ be that we're overloading the TLS stack, such that 
>> processing of individual packets is taking too long and triggering a 
>> KATO.
>>
>>> Second test is connect/disconnect loops.
>>> On disconnect I've got ocasional delays due to nvme commands timeouts.
>>> The disconnect happens eventually, but first it need to hit timeout.
>>>
>> Again, do you have message logs?
>>
> Managed to validate it with a larger setup.
> Message log is:
> nvme nvme0: mapped 16/0/0 default/read/poll queues.
> nvme nvme0: new ctrl: NQN "nqn.exuma", addr 10.168.136.124:4420
> nvme nvme0: Removing ctrl: NQN "nqn.exuma"
> nvme nvme0: queue 1: timeout cid 0x3071 type 4 opcode 0x2 (Read)
> nvme0c0n1: Read(0x2) @ LBA 15999927, 9 blocks, Host Aborted Command 
> (sct 0x3 / sc 0x71)
> nvme nvme0: queue 1: timeout cid 0x2078 type 4 opcode 0x2 (Read)
> nvme0c0n1: Read(0x2) @ LBA 15999872, 4 blocks, Host Aborted Command 
> (sct 0x3 / sc 0x71)
> nvme nvme0: queue 1: timeout cid 0x2079 type 4 opcode 0x2 (Read)
> nvme0c0n1: Read(0x2) @ LBA 15999877, 1 blocks, Host Aborted Command 
> (sct 0x3 / sc 0x71)
> nvme nvme0: queue 1: timeout cid 0x207a type 4 opcode 0x2 (Read)
> nvme0c0n1: Read(0x2) @ LBA 15999879, 2 blocks, Host Aborted Command 
> (sct 0x3 / sc 0x71)
> nvme nvme0: queue 1: timeout cid 0x207b type 4 opcode 0x2 (Read)
> nvme0c0n1: Read(0x2) @ LBA 15999882, 4 blocks, Host Aborted Command 
> (sct 0x3 / sc 0x71)
> nvme nvme0: queue 1: timeout cid 0x207c type 4 opcode 0x2 (Read)
> nvme0c0n1: Read(0x2) @ LBA 15999887, 21 blocks, Host Aborted Command 
> (sct 0x3 / sc 0x71)
> nvme nvme0: queue 1: timeout cid 0x207d type 4 opcode 0x2 (Read)
> nvme0c0n1: Read(0x2) @ LBA 15999909, 6 blocks, Host Aborted Command 
> (sct 0x3 / sc 0x71)
> nvme nvme0: queue 1: timeout cid 0x207e type 4 opcode 0x2 (Read)
> nvme0c0n1: Read(0x2) @ LBA 15999916, 10 blocks, Host Aborted Command 
> (sct 0x3 / sc 0x71)
> block nvme0n1: no available path - failing I/O
> Buffer I/O error on dev nvme0n1, logical block 15999872, async page read
> nvme nvme0: failed to send request -32
> nvme nvme0: Property Set error: 880, offset 0x14

Can you add timestamps to the log trace?

>
> Which actually points to an issue in the teardown flow.
> nvme_do_delete_ctrl() does this:
>
>         nvme_stop_ctrl(ctrl);
>         nvme_remove_namespaces(ctrl);
>         ctrl->ops->delete_ctrl(ctrl);
>
> and ->delete_ctrl()
>   ->nvme_tcp_delete_ctrl()
>     ->nvme_tcp_teardown_ctrl()
>       ->nvme_tcp_teardown_io_queues()
>
> has:
>         nvme_quiesce_admin_queue(ctrl);
>         nvme_quiesce_io_queues(ctrl);
>         nvme_sync_io_queues(ctrl);
>         nvme_tcp_stop_io_queues(ctrl);
>
> Now, if you look at 'nvme_sync_io_queues()' you'll find
>
>         down_read(&ctrl->namespaces_rwsem);
>         list_for_each_entry(ns, &ctrl->namespaces, list)
>                 blk_sync_queue(ns->queue);
>         up_read(&ctrl->namespaces_rwsem);
>
> but we've removed all namespaces right at the start in
> nvme_do_delete_ctr(), so this is a no-op and we'll never
> catch any I/O in flight causing the timeouts to occur :-(

Hannes, its not clear to me what you're saying here. What is different
in TLS that makes the teardown go that slow?

Also, what is being blocked here? Are there still I/Os to an already
deleted namespace?

