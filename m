Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7D70C77B7A
	for <linux-nvme@archiver.kernel.org>; Wed, 17 May 2023 07:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M1h3HND/vitt0BfguG9VcZxTls8i48bMGvOFA3QYcRM=; b=ryVo56VbaQwzFUYh47Ju/9yHh1
	U6QbJHepQ3xl5Z1DCTQkFKmwyPjz6fQHhtlH5WyD+RWyAMf/d3iyR0KP0NcX5XTGs4+aSjDQMURXT
	e8KWEP3OWtMizI6lZygSARsHo9sAnbBSIYPUDDLkQX/uX1oh+RFIaLqC8sLhCv5cSgwafE7fMx1DO
	/FJj78yiBpybsq8Li4SQSSOOiYRLLd8hlgb9q1zrAACdlC/1ZdC0IrAqbO7jc94M2JnK3QU0Mp9w0
	nTHr31r7g8Y8XZfyChlTwWOfBCfbrnQ91zkILWdNH0jfDYFoa+nv2FCG7Mq5lVkBS3lwOtE/jcLcV
	8YOO313w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pzBtF-008jDz-2W;
	Wed, 17 May 2023 07:48:05 +0000
Received: from mail-wm1-f53.google.com ([209.85.128.53])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pzBtC-008jDN-2S
	for linux-nvme@lists.infradead.org;
	Wed, 17 May 2023 07:48:04 +0000
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-3f50020e0f6so366565e9.1
        for <linux-nvme@lists.infradead.org>; Wed, 17 May 2023 00:47:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684309678; x=1686901678;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M1h3HND/vitt0BfguG9VcZxTls8i48bMGvOFA3QYcRM=;
        b=QT+z1DDxg6yk/pOC1OK6VYO/e5Cxl+44Kca9TP+uwNH4Uk/em4/FVEzioTRG8BZSim
         JUJSlnDc/TYuoNMLQYzUL3K19qVsYvFjV1VmScER/vVCGs5fKbB07k6wzLsGG8KyH8lT
         XPtjeBAX+dT8GfOoPyCgwbsNEkbiRh4uY9Ny43r47TGaYytDgDuqSH906FFmAJM0SWD4
         01tEDtE1he+u1LpNoSskbM70jUWBEt34v7LPvSv4QNvzoyxbUX7cy+mwoNORL945miEu
         3rL3oKSGlYKvcecXMEraSCYwZLJl4tmCzqfqo3B/KgJ4rlnyMFBWgDoAZu8aJTxHS7/9
         C1CQ==
X-Gm-Message-State: AC+VfDy3Dy9/TC3nYntL9Vc2CkOW0i1F722aI5OlLRudWtPgebien/iv
	J1WJVyDcsxnjoZCkdrtK6gwnHtOHJh0=
X-Google-Smtp-Source: ACHHUZ7r2O1s2Jjhy8bk43SvwtBFUHFFs2aG9OAXFQq4vdlUnSTOY9yiVz+TzHNwhkU+rJaSqxC8mg==
X-Received: by 2002:a05:600c:1c82:b0:3f1:7518:e37f with SMTP id k2-20020a05600c1c8200b003f17518e37fmr1610709wms.1.1684309678062;
        Wed, 17 May 2023 00:47:58 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id a18-20020a1cf012000000b003f42d8dd7d1sm1380015wmb.7.2023.05.17.00.47.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 00:47:57 -0700 (PDT)
Message-ID: <470d8e75-c2a2-ed21-6cd4-fc06d0b80e97@grimberg.me>
Date: Wed, 17 May 2023 10:47:56 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: Kmemleak on nvme-6.5
Content-Language: en-US
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <6344f121-f3a8-1a13-1024-c43fac23a9d8@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <6344f121-f3a8-1a13-1024-c43fac23a9d8@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230517_004802_970730_AA659EA9 
X-CRM114-Status: GOOD (  11.46  )
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


> Hi,
> 
> I've observed following kmemleak on nvme-6.5 with blktests
> nvme/003 HEAD:-
> 
> nvme (nvme-6.5) # git log
> commit 851c23be6fc95a48dbdac864f18be63f9a41e8a8 (HEAD -> nvme-6.5,
> origin/nvme-6.5)
> Author: Max Gurtovoy <mgurtovoy@nvidia.com>
> Date:   Tue Apr 25 00:12:42 2023 +0300
> 
>       nvme: move sysfs code to a dedicated sysfs.c file

I'm assuming this is not the result of a bisect correct?

> 
> 
> + cat /sys/kernel/debug/kmemleak
> unreferenced object 0xffff888114c610c0 (size 96):
>     comm "insmod", pid 2582, jiffies 4294980741 (age 48.260s)
>     hex dump (first 32 bytes):
>       c0 e6 a0 c0 ff ff ff ff 00 00 00 00 00 00 00 00 ................
>       00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
>     backtrace:
>       [<00000000430e7112>] kmalloc_trace+0x25/0x90
>       [<0000000023afbbe3>] class_create+0x21/0x70
>       [<0000000018569292>] 0xffffffffc0a11039
>       [<00000000ca4d41aa>] do_one_initcall+0x44/0x220
>       [<00000000cb8082be>] do_init_module+0x64/0x240
>       [<000000001b198e51>] __do_sys_finit_module+0xb4/0x130
>       [<000000003734a6e8>] do_syscall_64+0x3b/0x90
>       [<000000007e30a8f5>] entry_SYSCALL_64_after_hwframe+0x72/0xdc
> unreferenced object 0xffff88810a392a00 (size 512):
>     comm "insmod", pid 2582, jiffies 4294980741 (age 48.260s)
>     hex dump (first 32 bytes):
>       00 2a 39 0a 81 88 ff ff 00 2a 39 0a 81 88 ff ff .*9......*9.....
>       00 00 00 00 00 00 00 00 a0 b3 37 07 81 88 ff ff ..........7.....
>     backtrace:
>       [<00000000430e7112>] kmalloc_trace+0x25/0x90
>       [<00000000ae172de7>] class_register+0x29/0x130
>       [<0000000035f86164>] class_create+0x3c/0x70
>       [<0000000018569292>] 0xffffffffc0a11039
>       [<00000000ca4d41aa>] do_one_initcall+0x44/0x220
>       [<00000000cb8082be>] do_init_module+0x64/0x240
>       [<000000001b198e51>] __do_sys_finit_module+0xb4/0x130
>       [<000000003734a6e8>] do_syscall_64+0x3b/0x90
>       [<000000007e30a8f5>] entry_SYSCALL_64_after_hwframe+0x72/0xdc
> unreferenced object 0xffff88810737b3a0 (size 16):
>     comm "insmod", pid 2582, jiffies 4294980741 (age 48.260s)
>     hex dump (first 16 bytes):
>       6e 76 6d 65 2d 66 61 62 72 69 63 73 00 88 ff ff nvme-fabrics....
>     backtrace:
>       [<00000000e84e4b63>] __kmalloc_node_track_caller+0x4c/0x130
>       [<000000000198ce20>] kstrdup+0x33/0x60
>       [<0000000061fcf661>] kobject_set_name_vargs+0x1e/0x90
>       [<000000008c34e0dd>] kobject_set_name+0x4e/0x70
>       [<00000000ae7f3042>] class_register+0x94/0x130
>       [<0000000035f86164>] class_create+0x3c/0x70
>       [<0000000018569292>] 0xffffffffc0a11039
>       [<00000000ca4d41aa>] do_one_initcall+0x44/0x220
>       [<00000000cb8082be>] do_init_module+0x64/0x240
>       [<000000001b198e51>] __do_sys_finit_module+0xb4/0x130
>       [<000000003734a6e8>] do_syscall_64+0x3b/0x90
>       [<000000007e30a8f5>] entry_SYSCALL_64_after_hwframe+0x72/0xdc
> 
> 
> For me it is not that straight forward to reproduce that.
> 
> Thought I should document it.

Looks outside of nvme to me...

