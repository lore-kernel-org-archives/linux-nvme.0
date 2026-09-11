Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5136C88E53
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Sep 2026 21:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=k2p8FtP3AGlh3ut8VRC50Ab+KYAxGDJIcjJQgH3hmPc=; b=q3yMQg+KMJY9f2pJcTfnqxvM53
	/d1QVlBpCkvcrBHJMvdnTRABz1abDGEdzhxJJebDIIIUKGG8G3N67HTLi1evT6yHKnvxKFdCHGAm1
	8IKGJXi1tWi/rLAJI2IFLGJTU5j+dJZMZP+Cn6a9TY/L8nKRRT4kTpiJkhgCfiE6zOCbeTesevfj2
	XLWAphYEx8BTiJBf3H3NACgy94PBuX0F0bqeNofNL2sMBORXnNlqvhbZwkf6Vo6pX7yrDHVGauSpT
	DObX6bBG8Z5kjRVccCt9FSAyqj/7ePAjG9NWAJ/1YX6VTlUzXFWOsyjK4BxHy2V7uJ8+SIp7bQcFQ
	c9iENAXg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x58Wt-000000009GK-12Fb;
	Fri, 11 Sep 2026 21:11:27 +0000
Received: from mail-wm1-f53.google.com ([209.85.128.53])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x58Wq-000000009Fg-1lns
	for linux-nvme@lists.infradead.org;
	Fri, 11 Sep 2026 21:11:25 +0000
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-49e6697179cso4796845e9.1
        for <linux-nvme@lists.infradead.org>; Fri, 11 Sep 2026 14:11:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789161082; x=1789765882;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=k2p8FtP3AGlh3ut8VRC50Ab+KYAxGDJIcjJQgH3hmPc=;
        b=JLeHZavdOnkbwVsdhA5swZUNvEe71zDRAKn4uEKOrEggVC7V+xsa5FFTO7N8xDalsZ
         TY4PHTla33by0+J7zK4yc7NKnmXOyX6x8MxdV1uqftOw3YPz/o0O78aXAFIfiE48ahfG
         oK5a36zMkHqzb0IkqMsr9GTVofw/gIUJ+KlkoKird776itie8GG5wv60Q8o8Mf70GcST
         lvb9knuwKo0RMOKfUS2gbqHafAgFZH23OHjbu2rf6PmJaaEx8035NCGedWUpUh6rRdlT
         ogFu4YhsolshQvHvKzWWptvx7kBZqaPMoKnaJ44NIV728I9TmzCufKbCjQF9LZVBMm08
         hnPw==
X-Forwarded-Encrypted: i=1; AKwUvBzz7rAcHlHwOLESzJkqaaoOQDHnwjARdE3bpyWGFA0TZ2I6oT4Ppc31PpZ7uvKU9S7wHgvd/BlVrF6N@lists.infradead.org
X-Gm-Message-State: AFuF++nwbnMUYZ4MG9AzMzBBLckis6OxLlxPVAhbB/fvyhKUxwy5BE8f
	z1HrFl/SAHjPU8CPIGw0It6ac1QtBD7A0Sz9VoBXUxnbL7OhuttsZrFZ
X-Gm-Gg: AYBFou0i0uN14c7mBEZmJU2dpXlg1KmvH0rPJ6Io0Xh+0rcsj51B3lEKLhdKWeixS9E
	umq1JerfTHEG+3xGXuba0LfTQ/Wl0eepyCi2YTuByI+eOlqmZmW24pm2hIen+UgC/4yGuBc7BWC
	74pAasoY/spxga9DwiiLIDghBWuf2rnCSkso+UXzj4PZ7RD4dUGWfUZiMP1FdYtrD0+ZpaBw/Cw
	rd2AAnopuYD9Od3RlMlTEM8E8zGmPCzbSdbol3yNjIuFqJ+4jjZvvVdu/ihtmxLF5sSDqff1gNe
	xEW7FpwTF1x9utYwzYewSnBEjiGZXGR4fJn02QBzcLHZqQ44RwfRRcJebf6PdU2rSuPoi1jA+Uo
	o+oPYorlpFKQYwPgEUpAnz+f8muFeyFpegl7IYjoNOnmRa0kJmKYClrTnaNJ+SsxDibVfJ9aMvI
	BuNemRbAScFs7grLYEo0SYm3oMYwFoXI1704FPvsMvyAhgmHqNhOnvTggZVHFLdSuEZWXskYeqM
	+y/BsdYBBs+vEgBBFgFFCF3epGNso1J
X-Received: by 2002:a05:600c:1c11:b0:49c:f504:2af5 with SMTP id 5b1f17b1804b1-49e61887fe2mr85200775e9.1.1789161082182;
        Fri, 11 Sep 2026 14:11:22 -0700 (PDT)
Received: from [10.100.102.74] (89-138-77-243.bb.netvision.net.il. [89.138.77.243])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e60ababd5sm139607975e9.4.2026.09.11.14.11.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2026 14:11:20 -0700 (PDT)
Message-ID: <13c160d0-0657-47ce-9a16-58d348267ab0@grimberg.me>
Date: Sat, 12 Sep 2026 00:11:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] nvme-tcp: allow setting per-queue io_cpu through sysfs
To: Saravanan D <saravanand@crusoe.ai>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de, axboe@kernel.dk, nilay@linux.ibm.com,
 dwagner@suse.de, linux-kernel@vger.kernel.org, iyamahata@crusoe.ai,
 kiyer@crusoe.ai, ganbalagane@crusoe.ai, sj@kernel.org
References: <20260909211432.6741-1-saravanand@crusoe.ai>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20260909211432.6741-1-saravanand@crusoe.ai>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260911_141124_494886_10B62484 
X-CRM114-Status: GOOD (  28.05  )
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



On 10/09/2026 0:14, Saravanan D wrote:
> nvme_tcp_set_queue_io_cpu() picks each queue's io_cpu at connect time
> as the least loaded CPU in the queue's blk-mq map group, and all socket
> work runs there for the connection's lifetime. This decision falls
> short when the host partitions its CPUs after connect time. On a 384
> cpu multi tenant host with 128 queue controllers, blk-mq folds three
> CPUs into every map group, some groups straddle two tenants' cpusets,
> and 9% of nvme_tcp_io_work executions ran outside the submitting VM's
> cpuset, seen by the neighbor as steal time.
>
> Expose each I/O queue's io_cpu as a writable sysfs attribute
>
>    /sys/class/nvme/nvmeX/tcp_queues/<qid>/io_cpu
>
> so a control plane that owns CPU placement can set it directly instead
> of relying on the driver's heuristic. A written value persists across
> reconnects, marked by NVME_TCP_Q_IO_CPU_USER. Writing -1 clears the
> mark and re-runs the connect time selection. Reading returns the CPU,
> or -1 when the queue is unbound.

No need for NVME_TCP_Q_IO_CPU_USER flag and restoring to the original 
connect time selection. -1 would mean WORK_CPU_UNBOUND. In fact lets 
allow this file to access "unbound" string (same as -1). I don't think 
we need to restore the connect time selection, the user who touches 
these settings is obviously interested to be in control.
>
> The store, the connect time selection and queue stop serialize their
> accounting of nvme_tcp_cpu_queues under the queue lock.

I think that the queue accounting is something we'd do anyways, 
regardless of how the
queue is set. It just represents the io_cpu spread across cpu cores.

>
> Suggested-by: Sagi Grimberg <sagi@grimberg.me>
> Link: https://lore.kernel.org/linux-nvme/220e9da3-f756-4a16-8de1-d4b171f15009@grimberg.me/
> Assisted-by: Claude:claude-opus-4-8 [Claude Code]
> Signed-off-by: Saravanan D <saravanand@crusoe.ai>
> ---
> Changes since v2 [1]:
> - Replaced the io_cpu_adopt connect option and the submitter adoption
>    heuristic with a per queue writable sysfs attribute, following Sagi's
>    suggestion [2]. The control plane now sets each queue's io_cpu
>    directly, the assignment is kept across reconnects and writing -1
>    reverts to the connect time selection.
> - Retitled from "nvme-tcp: pin io_cpu to submitter cpu".
>
> The per queue directories follow the blk-mq mq/<hctx> sysfs pattern.
>
> Tested on a 2 socket 384 cpu host with 128 queue controllers. Writing
> a cpu number changed the queue's io_cpu to it. Writing an invalid
> value was rejected. Writing -1 re-ran the connect time selection.
> Pinned queues kept their io_cpu across a controller reset while
> unpinned queues received a fresh pick.
>
> The multiple queues per hctx RFC [3] found the same need to steer the
> socket work cpu, so this attribute may gain a second user.
>
> [1] https://lore.kernel.org/linux-nvme/20260820083634.71689-1-saravanand@crusoe.ai/
> [2] https://lore.kernel.org/linux-nvme/1d56144d-6987-40c1-ac02-b15333db121e@grimberg.me/
> [3] https://lore.kernel.org/linux-nvme/20260903152623.614951-1-kbusch@meta.com/
>
>   Documentation/ABI/stable/sysfs-nvme |  12 +++
>   drivers/nvme/host/tcp.c             | 153 +++++++++++++++++++++++++++-
>   2 files changed, 162 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/ABI/stable/sysfs-nvme b/Documentation/ABI/stable/sysfs-nvme
> index a2f5d0710db4..2bbb5a0b7c2e 100644
> --- a/Documentation/ABI/stable/sysfs-nvme
> +++ b/Documentation/ABI/stable/sysfs-nvme
> @@ -451,3 +451,15 @@ Contact:	Hannes Reinecke <hare@suse.de>
>   Description:
>   		Shows the subsystem type. Possible values: "discovery",
>   		"nvm", "reserved".
> +
> +What:		/sys/class/nvme/nvmeX/tcp_queues/<qid>/io_cpu
> +Date:		September 2026
> +KernelVersion:	7.4
> +Contact:	Saravanan D <saravanand@crusoe.ai>
> +Description:
> +		(RW) The CPU that runs the socket work for I/O queue <qid>
> +		of an NVMe over TCP controller, selected by the driver at
> +		connect time. Writing a CPU number overrides the selection
> +		and persists across reconnects. Writing -1 reverts to the
> +		driver's selection. Reads show the current CPU, or -1 when
> +		the queue is unbound.
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 921934028e0b..22ad1fdf4a12 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -93,6 +93,7 @@ enum nvme_tcp_queue_flags {
>   	NVME_TCP_Q_LIVE		= 1,
>   	NVME_TCP_Q_POLLING	= 2,
>   	NVME_TCP_Q_IO_CPU_SET	= 3,
> +	NVME_TCP_Q_IO_CPU_USER	= 4,
>   };
>   
>   enum nvme_tcp_recv_state {
> @@ -102,6 +103,17 @@ enum nvme_tcp_recv_state {
>   };
>   
>   struct nvme_tcp_ctrl;
> +struct nvme_tcp_queue;
> +
> +/*
> + * Allocated per registration and freed by its kobject release, so a
> + * reconnect never reuses a kobject whose release is still pending.
> + */
> +struct nvme_tcp_queue_kobj {
> +	struct kobject		kobj;
> +	struct nvme_tcp_queue	*queue;
> +};

I am wandering if it is time to introduce the core nvme queue:
struct nvme_queue {
         struct kobject        kobj;
         unsigned int          qid;
         u64                          flags;
};

And have the transport queue embed it:
struct nvme_tcp_queue {
         struct nvme_queue        nvmeq;
         ....
};

I suspect it will allow for better abstractions.

Thoughts? Keith, Christoph?

