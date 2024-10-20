Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63D1BD3C92A
	for <linux-nvme@archiver.kernel.org>; Sun, 20 Oct 2024 21:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zes+46wNSr+tLWY9lI2lTde1Td77BdawD/wLWBbHFNY=; b=m/SAd/yDA26NPuYfF9FTLm4EcW
	huoqQ1R9+nJYjoDrulipRBtdwtmQsQsBTZFKNz+Z84Za72qWpkS9R2DL+nOTUMESRbBChzCfUIeGX
	WoqjvZvTb4N8n55POBna/1/JZZGC1JTWRldQdZKCMSEb7w9AgS8N1xSsqjzI3oBD5qbHLKlsMHBfy
	LeamPwCNTN4OhY8H6E30UPnxQt3ymBE2tcHZx92/4WU/rwhfLLkUrnscxV7z7bhjAx2WKxAYFCoo6
	oJUJfL2qZHil+hnXeJCS/3cwUvjhIF7A497PWWUkEhGkFzB12reLkT9UHoLERjqG3adNf4d/zSUWu
	6e8gcgaA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t2dnn-00000005Vfe-0nsG;
	Sun, 20 Oct 2024 21:49:31 +0000
Received: from mail-wm1-f46.google.com ([209.85.128.46])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t2dnk-00000005VfD-3eww
	for linux-nvme@lists.infradead.org;
	Sun, 20 Oct 2024 21:49:30 +0000
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4314b316495so36237705e9.2
        for <linux-nvme@lists.infradead.org>; Sun, 20 Oct 2024 14:49:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729460967; x=1730065767;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zes+46wNSr+tLWY9lI2lTde1Td77BdawD/wLWBbHFNY=;
        b=kwMUhLrp3HKutRvmVTjMDwjGH9ATuw5qZ5JixCn8fzljIIpFhIM2Soys1D+qPDbcoo
         HLd+fYkf9mwiakf3BlydJS8s5dKCRCNHbNSmX1OeQLiPConxVPivTwC5TIwr+8HgT3jk
         NxCbDVELfka16v3Ra98TsUMUTbhWbujqTrgSiXZh7N/7qIxQjpEncAqb261PMWcmb63K
         R3k0PKZYhjwbwK3vteCu+jyUCM/g53L7dRqD5BHhU5mn4HHKubv012v9fwQ9YW76AkUI
         MlfaVVGdbhW1cfqCCAo7c4IhALCB+V38TgiaF4w38uyHlEI3C5ZoJVZjUGUi3UV04D/O
         nD8A==
X-Forwarded-Encrypted: i=1; AJvYcCVVSwhJ6zCyJMt+5zTO41xL1cKEa3mpjLDoGSrN0ChyTRWi6MiBDODK7eb4Hd+uZCAqaB3wDt+1OXOF@lists.infradead.org
X-Gm-Message-State: AOJu0YzimfddvGZqYPKodaVhrBwcEet+X8/bE8rnM866Z+a8f5tepbs8
	32ANTd7G5bnxMs5IpgVKRzmD8IbUnfjRMbBGwyi9l61tfqNCo90A
X-Google-Smtp-Source: AGHT+IEo4Ns/zlbNgaCjxm7uN3uX3gwB2ZkKJdYHjxNKaziSIhsTLtrHZRihrqOX0aCNuYoBKOgeTA==
X-Received: by 2002:adf:ed02:0:b0:37c:c5c4:627 with SMTP id ffacd0b85a97d-37ea2151b4fmr5805183f8f.5.1729460967050;
        Sun, 20 Oct 2024 14:49:27 -0700 (PDT)
Received: from [10.100.102.74] (89-138-78-158.bb.netvision.net.il. [89.138.78.158])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0b9bf8esm2622267f8f.110.2024.10.20.14.49.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Oct 2024 14:49:26 -0700 (PDT)
Message-ID: <a5908bbc-4230-460d-b814-a0b41d16a15d@grimberg.me>
Date: Mon, 21 Oct 2024 00:49:25 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] nvme: make keep-alive synchronous operation
To: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de, axboe@fb.com, chaitanyak@nvidia.com,
 dlemoal@kernel.org, gjoyce@linux.ibm.com
References: <20241016030339.54029-1-nilay@linux.ibm.com>
 <20241016030339.54029-3-nilay@linux.ibm.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20241016030339.54029-3-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241020_144928_953361_BD62C8E6 
X-CRM114-Status: GOOD (  23.51  )
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

Hey Nilay,

First, can you please phrase the patch title to describe what it
is addressing, not what it is changing, that can come (as it does)
in the body.

Second, I don't think we want to spend a thread waiting for
synchronous IO for the purpose of keep alive. Is this the only
way that this can be done?

Third, was this observed with non-loop transports?


On 16/10/2024 6:03, Nilay Shroff wrote:
> The nvme keep-alive operation, which executes at a periodic interval,
> could potentially sneak in while shutting down a fabric controller.
> This may lead to a race between the fabric controller admin queue
> destroy code path (invoked while shutting down controller) and hw/hctx
> queue dispatcher called from the nvme keep-alive async request queuing
> operation. This race could lead to the kernel crash shown below:

What is different about keep-alive than any other command?

>
> Call Trace:
>      autoremove_wake_function+0x0/0xbc (unreliable)
>      __blk_mq_sched_dispatch_requests+0x114/0x24c
>      blk_mq_sched_dispatch_requests+0x44/0x84
>      blk_mq_run_hw_queue+0x140/0x220
>      nvme_keep_alive_work+0xc8/0x19c [nvme_core]
>      process_one_work+0x200/0x4e0
>      worker_thread+0x340/0x504
>      kthread+0x138/0x140
>      start_kernel_thread+0x14/0x18

What is the "crash" here? use-after-free?

>
> While shutting down fabric controller, if nvme keep-alive request sneaks
> in then it would be flushed off. The nvme_keep_alive_end_io function is
> then invoked to handle the end of the keep-alive operation which
> decrements the admin->q_usage_counter and assuming this is the last/only
> request in the admin queue then the admin->q_usage_counter becomes zero.
> If that happens then blk-mq destroy queue operation (blk_mq_destroy_
> queue()) which could be potentially running simultaneously on another
> cpu (as this is the controller shutdown code path) would forward
> progress and deletes the admin queue. So, now from this point onward
> we are not supposed to access the admin queue resources. However the
> issue here's that the nvme keep-alive thread running hw/hctx queue
> dispatch operation hasn't yet finished its work and so it could still
> potentially access the admin queue resource while the admin queue had
> been already deleted and that causes the above crash.

Again, it is unclear to me what justifies the cure here. Every command can
race with the shutdown, and it can be sync or async.

>
> This fix helps avoid the observed crash by implementing keep-alive as a
> synchronous operation so that we decrement admin->q_usage_counter only
> after keep-alive command finished its execution and returns the command
> status back up to its caller (blk_execute_rq()). This would ensure that
> fabric shutdown code path doesn't destroy the fabric admin queue until
> keep-alive request finished execution and also keep-alive thread is not
> running hw/hctx queue dispatch operation.

I'd want to see exactly what is causing this race because we already flush
the keep alive work when starting the shutdown... so it only means it is
incorrectly firing again?

What I think we should do instead, is given that we already cancel_sync 
the keep
alive work before making progress with the teardown, we should just make 
sure
that it doesn't triggered afterwards again if it does.

