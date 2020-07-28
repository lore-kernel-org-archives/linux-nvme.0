Return-Path: <SRS0=l2Ft=BH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36774C433E8
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jul 2020 18:36:08 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CBB620786
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jul 2020 18:36:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dzBNvDF1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CBB620786
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=emSgtTJFK5p3Wzr2N+5A1qXJU4JOD1oeYjeYmNZxsGw=; b=dzBNvDF1FP2b7lFF6eNAwmED0
	cRG1sORFeYAOZDYdR/IpiIHFqZ2ZHLirlG5sXb/FI/vOpaZXlogsdgZHG0pjtdVPTGSQU5OPgFMa1
	EeeIWM9yFuI0hwsiBViOscmdADalbjzmUwZLaQFVm1zX22W9F23qQZjaS+ZhplGcfA1LdaVmwct+l
	7oKoVWq8KgPG+26sRwjOkFndRgUxjLkjNJkRPKqYSD/7kW70bAy2mjSXNLK+zfPe6kFZjUSsUbHGx
	AlVffvgJo7ttvymCItyekPXn3ujWA8nMznXx54g4x04H3x3a7yfaaKoszBvI4Ovcb32kVSeHWtQrY
	fg2FsgE+g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k0USH-0006vA-4I; Tue, 28 Jul 2020 18:36:01 +0000
Received: from mail-pj1-f68.google.com ([209.85.216.68])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k0USE-0006uN-1d
 for linux-nvme@lists.infradead.org; Tue, 28 Jul 2020 18:35:59 +0000
Received: by mail-pj1-f68.google.com with SMTP id k71so329139pje.0
 for <linux-nvme@lists.infradead.org>; Tue, 28 Jul 2020 11:35:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9i5BBHREORuTzj8FAN14ckMlGcQgcgOsiBwHPLWsVpE=;
 b=Wcw9eFUDG5jL5PxmfuRWMPX4HQYKDnAYXKCQ1L3+8gohLT6pRDShHhgZG5wUUGFTz0
 wcBksNgeZHq263Wg+QfafYj5rLQ+CXLEKTMYaFWqql+y7tfUAY1/UF18sVv+C3OT1fxv
 60njsjV6275nWBC2lMdbuZyQR+Id7/8xaM/FkcQQmlwecrGhOhDcTaM4hZm1VXfsVuZd
 Z0w0KZcrkdikeIUdityu/0qQ/q0i8GADexCFKUNZmo10A0+1cyAygnfXKAMXhK8ZGbM2
 9lBVQpj3fU82YFrA+Q8oNzqX+oZ9mhAaOqVRgVE4QLB0R65EEVA+cmcgcJHcD426ucJj
 1vRQ==
X-Gm-Message-State: AOAM533qyYn28xr7gcFds7NmyaauIGy6IlLRruMvF33XQQIdJtBDmx5k
 Cb9cx4DFQfuEvRWZdBKSML4=
X-Google-Smtp-Source: ABdhPJwJV/Nd3Zr81y3cR4096NvjviTeoZrcTQ//uuEkvRbHfzsey1tjXRxCYL7+JA/op/f/XWhQUA==
X-Received: by 2002:a17:902:6b08:: with SMTP id
 o8mr24268973plk.104.1595961356381; 
 Tue, 28 Jul 2020 11:35:56 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:541c:8b1b:5ac:35fe?
 ([2601:647:4802:9070:541c:8b1b:5ac:35fe])
 by smtp.gmail.com with ESMTPSA id s194sm19172559pgs.24.2020.07.28.11.35.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jul 2020 11:35:55 -0700 (PDT)
Subject: Re: Hang at NVME Host caused by Controller reset
To: Krishnamraju Eraparaju <krishna2@chelsio.com>
References: <20200727181944.GA5484@chelsio.com>
 <9b8dae53-1fcc-3c03-5fcd-cfb55cd8cc80@grimberg.me>
 <20200728115904.GA5508@chelsio.com>
 <4d87ffbb-24a2-9342-4507-cabd9e3b76c2@grimberg.me>
 <20200728174224.GA5497@chelsio.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <3963dc58-1d64-b6e1-ea27-06f3030d5c6e@grimberg.me>
Date: Tue, 28 Jul 2020 11:35:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200728174224.GA5497@chelsio.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200728_143558_103337_B94BF855 
X-CRM114-Status: GOOD (  15.44  )
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
Cc: linux-rdma@vger.kernel.org, bharat@chelsio.com,
 linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

> Sagi,
> 
> Yes, Multipath is disabled.

Thanks.

> This time, with "nvme-fabrics: allow to queue requests for live queues"
> patch applied, I see hang only at blk_queue_enter():

Interesting, does the reset loop hang? or is it able to make forward
progress?

> [Jul28 17:25] INFO: task nvme:21119 blocked for more than 122 seconds.
> [  +0.000061]       Not tainted 5.8.0-rc7ekr+ #2
> [  +0.000052] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> disables this message.
> [  +0.000059] nvme            D14392 21119   2456 0x00004000
> [  +0.000059] Call Trace:
> [  +0.000110]  __schedule+0x32b/0x670
> [  +0.000108]  schedule+0x45/0xb0
> [  +0.000107]  blk_queue_enter+0x1e9/0x250
> [  +0.000109]  ? wait_woken+0x70/0x70
> [  +0.000110]  blk_mq_alloc_request+0x53/0xc0
> [  +0.000111]  nvme_alloc_request+0x61/0x70 [nvme_core]
> [  +0.000121]  nvme_submit_user_cmd+0x50/0x310 [nvme_core]
> [  +0.000118]  nvme_user_cmd+0x12e/0x1c0 [nvme_core]
> [  +0.000163]  ? _copy_to_user+0x22/0x30
> [  +0.000113]  blkdev_ioctl+0x100/0x250
> [  +0.000115]  block_ioctl+0x34/0x40
> [  +0.000110]  ksys_ioctl+0x82/0xc0
> [  +0.000109]  __x64_sys_ioctl+0x11/0x20
> [  +0.000109]  do_syscall_64+0x3e/0x70
> [  +0.000120]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [  +0.000112] RIP: 0033:0x7fbe9cdbb67b
> [  +0.000110] Code: Bad RIP value.
> [  +0.000124] RSP: 002b:00007ffd61ff5778 EFLAGS: 00000246 ORIG_RAX:
> 0000000000000010
> [  +0.000170] RAX: ffffffffffffffda RBX: 0000000000000003 RCX:
> 00007fbe9cdbb67b
> [  +0.000114] RDX: 00007ffd61ff5780 RSI: 00000000c0484e43 RDI:
> 0000000000000003
> [  +0.000113] RBP: 0000000000000000 R08: 0000000000000001 R09:
> 0000000000000000
> [  +0.000115] R10: 0000000000000000 R11: 0000000000000246 R12:
> 00007ffd61ff7219
> [  +0.000123] R13: 0000000000000006 R14: 00007ffd61ff5e30 R15:
> 000055e09c1854a0
> [  +0.000115] Kernel panic - not syncing: hung_task: blocked tasks

For some reason the ioctl is not woken up when unfreezing the queue...

> You could easily reproduce this by running below, parallelly, for 10min:
>   while [ 1 ]; do  nvme write-zeroes /dev/nvme0n1 -s 1 -c 1; done
>   while [ 1 ]; do echo 1 > /sys/block/nvme0n1/device/reset_controller;
> done
>   while [ 1 ]; do ifconfig enp2s0f4 down; sleep 24; ifconfig enp2s0f4 up;
> sleep 28; done
>   
>   Not sure using nvme-write this way is valid or not..

sure it is, its I/O just like fs I/O.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
