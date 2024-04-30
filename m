Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC872C4345F
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Apr 2024 11:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aI03EuF8ZM4QyEdXiSTl6tAm2Vj64rLofeDwYKijk6k=; b=PwDjxRGzMfS7HJ2iuU+TItrCz1
	tc117ObH7e5S2ozhpfSSdfDdrxgfsAwTIVfMjHaVnt9yllEmEVv23NHopLBrJCceFlFWeZLbrtV8E
	gox0P2CD8SrJT1PKbjBpDCmr+wdcD8NrRhCMrZW5ANBZefessrAOTHcA6tsh1a6Q5+VTMoeI3/Zet
	AOVZvL79gKW9PnlDIovFnH/Y/lfOGdaPJ4W1jFnvlAQPLhlmx/QlpXAoOg3ZDdyWkY/IsR7nuWC+g
	zRoRkQQYGzppFcFEXpJ/OECAYKjc9KIqkhMch2kPLRJzKrScNFN6Th0tYweE3+NvyQ9OUq20RSMPy
	wN/6yQKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s1m3y-00000006EtV-2UM9;
	Tue, 30 Apr 2024 11:54:22 +0000
Received: from mail-wm1-f46.google.com ([209.85.128.46])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s1m3v-00000006Esr-1uHv
	for linux-nvme@lists.infradead.org;
	Tue, 30 Apr 2024 11:54:21 +0000
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-416463e82fbso1990515e9.1
        for <linux-nvme@lists.infradead.org>; Tue, 30 Apr 2024 04:54:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714478056; x=1715082856;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aI03EuF8ZM4QyEdXiSTl6tAm2Vj64rLofeDwYKijk6k=;
        b=HONML4qNO32OFy088v7VcPgwqqD8TbGoF15WuM0ld8P8gi7WGTBEbh4Ig3nFEBBQiJ
         PNwceJYLHgyT5RHWsTXvtu7jZbymbeSY2msb6RZRmO4Beo4O+HJl8KyQu8Kqgf8535Os
         XoerWmzbPWLaZGUnn0vivBTas+oNTvragG40Rf/ikES2shIydZjQPSUdQtGpc9X0tjqQ
         O6eknZlWAApVUcTya1A/g9FDX7uKwwPjx5uRZnowNJP2NDZjCbzJlqQudEelet4zY9ao
         7oQYt5B+ComVqQ57iJfzVMy14t1HqaVSYWffkoY//rTl8NH8UD+cP+s5W6Ya0JPHxESS
         V2Lw==
X-Forwarded-Encrypted: i=1; AJvYcCV+u/ZdILFESvr+0AxQz50USw6Oq/9PodkrZYXSK8WrqeazyoZNyOognHQ+9hjb5/Iu9U+lmHwDODHvJV2bIhDJlowfUdCZoLBb38krc2w=
X-Gm-Message-State: AOJu0Yw5AtKR7nyMPWphYFi2zUC3H7FzzuBNasZ42bbCVtK5eB1ZLpBt
	BKk0ORcrVcTJmFLEO6j0gTEFgyVYDYHsW6/z8ZpGvtv4HNAAJUNG
X-Google-Smtp-Source: AGHT+IHuVsQR5/yvCj+OaBR12hedijAAPkXtXNeG3df6QXogZQ5cKmjXk7OZbwHQT8Bs6EFA3qkMkQ==
X-Received: by 2002:a05:6000:c44:b0:34b:dc52:266d with SMTP id do4-20020a0560000c4400b0034bdc52266dmr9015797wrb.3.1714478055984;
        Tue, 30 Apr 2024 04:54:15 -0700 (PDT)
Received: from [10.50.4.180] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id v18-20020a5d43d2000000b0034a25339e47sm30981529wrr.69.2024.04.30.04.54.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Apr 2024 04:54:15 -0700 (PDT)
Message-ID: <2d4f4468-343a-4706-8469-56990c287dba@grimberg.me>
Date: Tue, 30 Apr 2024 14:54:13 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v24 01/20] net: Introduce direct data placement tcp
 offload
To: Aurelien Aptel <aaptel@nvidia.com>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org
Cc: Boris Pismenny <borisp@nvidia.com>, aurelien.aptel@gmail.com,
 smalin@nvidia.com, malin1024@gmail.com, ogerlitz@nvidia.com,
 yorayz@nvidia.com, galshalom@nvidia.com, mgurtovoy@nvidia.com,
 edumazet@google.com, pabeni@redhat.com, dsahern@kernel.org, ast@kernel.org,
 jacob.e.keller@intel.com
References: <20240404123717.11857-1-aaptel@nvidia.com>
 <20240404123717.11857-2-aaptel@nvidia.com>
 <3ab22e14-35eb-473e-a821-6dbddea96254@grimberg.me>
 <253o79wr3lh.fsf@mtr-vdi-124.i-did-not-set--mail-host-address--so-tickle-me>
 <9a38f4db-bff5-4f0f-ac54-6ac23f748441@grimberg.me>
 <253le4wqu4a.fsf@nvidia.com>
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <253le4wqu4a.fsf@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240430_045419_547574_4665A6E9 
X-CRM114-Status: GOOD (  20.43  )
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



On 29/04/2024 14:35, Aurelien Aptel wrote:
> Sagi Grimberg <sagi@grimberg.me> writes:
>> This is not simply a steering rule that can be overwritten at any point?
> No, unlike steering rules, the offload resources cannot be moved to a
> different queue.
>
> In order to move it we will need to re-create the queue and the
> resources assigned to it.  We will consider to improve the HW/FW/SW to
> allow this in future versions.

Well, you cannot rely on the fact that the application will be pinned to a
specific cpu core. That may be the case by accident, but you must not and
cannot assume it.

Even today, nvme-tcp has an option to run from an unbound wq context,
where queue->io_cpu is set to WORK_CPU_UNBOUND. What are you going
to do there?

nvme-tcp may handle rx side directly from .data_ready() in the future, what
will the offload do in that case?

>
>> I was simply referring to the fact that you set config->io_cpu from
>> sk->sk_incoming_cpu
>> and then you pass sk (and config) to .sk_add, so why does this
>> assignment need to
>> exist here and not below the interface down at the driver?
> You're correct, it doesn't need to exist *if* we use sk->incoming_cpu,
> which at the time it is used, is the wrong value.
> The right value for cfg->io_cpu is nvme_queue->io_cpu.

io_cpu may or may not mean anything. You cannot rely on it, nor dictate it.

>
> So either:
> - we do that and thus keep cfg->io_cpu.
> - or we remove cfg->io_cpu, and we offload the socket from
>    nvme_tcp_io_work() where the io_cpu is implicitly going to be
>    the current CPU.
What do you mean offload the socket from nvme_tcp_io_work? I do not
understand what this means.


