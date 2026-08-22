Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A2A2C5B572
	for <linux-nvme@archiver.kernel.org>; Sat, 22 Aug 2026 21:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8sGKGuKLvEa85XtEXyLwT7tNfMYb9gssTc/hnkukbrA=; b=H7XaDvZBPkKnKclWIDxHJdb+nF
	zRryRohS8MAziZOUWDHacXmqXLiLwJ/nKFsFfLVBAHXzX9pSqIzuHHYRJnqsY/88UBsLFxSyIpSkW
	TEqp7VYqYrPLjmag3hgD6liVK1PI+Gh/pQvJKIcrD0giez/NqLlLlaMSPUE4EZWtnamsLryyciZd0
	cEjLu2TqLcLPAjbM9YLdUX+xvBcWjJgF6MsHTs9FcdMR//05RgQq8ijW3SgjvyAy63T9iiAybR6u+
	jVz9XQdLR/+inqYteZUo42mKYEY4ZVrsLwR8bwjauvkdpNz/A2GYSwfOmmpCofvLw8FKbFnptTDKP
	/BST2/bA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxt8f-0000000Eo22-1H6T;
	Sat, 22 Aug 2026 21:20:29 +0000
Received: from mail-ed1-f50.google.com ([209.85.208.50])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxt8c-0000000Eo1R-3gBX
	for linux-nvme@lists.infradead.org;
	Sat, 22 Aug 2026 21:20:28 +0000
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6a0a4a28cbdso3982521a12.3
        for <linux-nvme@lists.infradead.org>; Sat, 22 Aug 2026 14:20:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787433624; x=1788038424;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8sGKGuKLvEa85XtEXyLwT7tNfMYb9gssTc/hnkukbrA=;
        b=GfWe0p0X4d/9kVAIGbUx6ZQM0xq0jv5klR75dQx/yGtF3PVaCspDBPwHjdLObFzHhK
         GDBXiCBduzjwIYfiPMVDYpbeSlkwSGrDjltCYWS8uUfUt300Xy2oGXfcnjEyio/ROKkw
         1pL8PfpepWnsd0Ksek4G/DVAs/rgoNE05eArI1YkCaDIa6efHRye+8FGzeK7u7Bs1pAP
         8cBa3EKwFjtbjc1b4KssFAMVcJqbvvPEcm2QpNA2Psdy9ynBSpG55Z7czPFzz7SV6POR
         oBXGEn9S3vhvo6HWLkVjNCLv+F1q9KOsgLCtFW+9Qb8Jif2brFTtZTq1yxiBke4vEyfq
         Hh7A==
X-Forwarded-Encrypted: i=1; AHgh+Rqvv7jMjtxwXeZreuZ11M0hqbeQ9Fz9v5GwFEThQLsIPz02mf75Fp2Aja/e+Jnb4x1vkOWrUDPyTLik@lists.infradead.org
X-Gm-Message-State: AFuF++myoaBiH4FxhilP8+w0t/FVr8JkNr9Pr89Rhny7G+zFyjIqTw23
	csvmh2TxbYUH//OaihtWhZ1NPXX8ZLD2jXmxSLxhiurR6HU/P9n/D6HA
X-Gm-Gg: AR+sD13hSkNqMWTNeUGKkJzupTOcQDlesHRB0i1BzqDsscevx0K6R/oX6RO3O9QLYuh
	URcvseQw4n6AfCkCIvRAAepToIPDhGTK6sD5Kuuw8CXsglIYaava5il6Rs9BD/lOIHQT6JZ2DUe
	1jgccBOAXKaF14QOr0pPHRb4Q5I5Nqf3gQcsqLClw2OpPx52bs+WTdxsKnzRmQvmwNi3tIkNcpN
	qMWI+zP60su2EKy+FyW0ja9t/TdhDjKCkjGwnpzrAkQYOVGQjHJeHwWWoKqmdNKMDJlEGMO58dR
	6pytXICBxCp2da6k3HbxM7XuM0POmbyrdHa4xmxnbidrmrfUUTum/CzcKuOOUsUnJoRWxfNADs8
	XzfJj3QhgbkPQHahkU/QzKkomKCKlaRD8lD9ByN9vnDMlAJwPh0so6Sc7QH7W3YXou+C6qGgTb8
	Q7XLn+LUH63PNHbctNA9JOSzPUu8OlrNAdLfkDkqzHORSjU9P7CKNUy2ziAYmYAmvvEz56ZBauc
	FsmhYTtXDX1a/8KQqWyloI=
X-Received: by 2002:a17:907:7254:b0:c20:af9d:4533 with SMTP id a640c23a62f3a-c2492625c49mr888091966b.19.1787433623644;
        Sat, 22 Aug 2026 14:20:23 -0700 (PDT)
Received: from [10.100.102.74] (89-138-65-240.bb.netvision.net.il. [89.138.65.240])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2496296b8bsm456672566b.16.2026.08.22.14.20.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Aug 2026 14:20:22 -0700 (PDT)
Message-ID: <56829bb7-2067-4794-88ec-7ddac2d3f250@grimberg.me>
Date: Sun, 23 Aug 2026 00:20:21 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nvme-tcp: pin io_cpu to submitter cpu
To: Saravanan D <saravanand@crusoe.ai>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de, axboe@kernel.dk,
 linux-kernel@vger.kernel.org
References: <20260820083634.71689-1-saravanand@crusoe.ai>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20260820083634.71689-1-saravanand@crusoe.ai>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260822_142026_940511_E3086446 
X-CRM114-Status: GOOD (  20.57  )
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

Hey Saravanan,

On 20/08/2026 11:36, Saravanan D wrote:
> nvme_tcp_set_queue_io_cpu() picks each queue's io_cpu at connect time,
> before any I/O exists, as the least loaded CPU in the queue's blk-mq
> map group, and all socket work then runs there for the connection's
> lifetime.

That is true. It effectively takes a sane heuristics given that there are
multiple factors it is not aware of.

>   On hosts that partition CPUs between pinned workloads a map
> group can straddle a partition boundary, so the pick can land one
> workload's socket processing on CPUs owned by another. On a 384 cpu
> multi tenant host with one VM driving ~1.1 GB/s of writes, 9% of
> nvme_tcp_io_work executions ran outside the submitting VM's cpuset,
> all on io_cpus of boundary straddling map groups, observed by the
> neighbor as steal time it did not cause.

Can you share a concrete example?
What is the output of:
1. lscpu
2. grep -r ''  /sys/block/nvmeXnY/mq/*/cpu_list

Also, what would be the VMs cpusets on such a server?

In an ideal setting, the nvme controller would support $NR_CPUS worth of
io queues, and both nvme_tcp_set_queue_io_cpu() and blk_mq_map_queues() 
would
map cpu-queue with perfect alignment.

FWIW, I don't think this is an nvme-tcp specific problem, other than the 
fact that TCP
is more CPU consuming than other transports (doing stuff that is not 
offloaded by
the HW...)

>
> Adopt the submitting CPU as io_cpu for every command except the
> fabrics Connect. The submitter is a member of the map group by
> construction, and the nvme_tcp_cpu_queues accounting moves with each
> adoption. Connect is the only command on an I/O queue that does not
> represent the data path, since it is injected on an arbitrary CPU by
> blk_mq_alloc_request_hctx(), so it is skipped and the first real read
> or write decides. User passthrough is submitted from a real task on
> the submitting CPU and adopts like any other command.
>
> Queues outlive the workloads that submit through them, so adoption
> re-arms after 30 seconds of queue quiet. An idle queue is reclaimed by
> its next submitter, while a busy queue keeps a stable io_cpu and
> cannot ping pong between two live submitters. Concurrent writers on
> different CPUs serialize on a cmpxchg on io_cpu.
>
> The behavior is opt in per controller via the io_cpu_adopt fabrics
> option at connect time. wq_unbound takes precedence when set.

I think that for controllers with low queue count this approach would not
work very well. Plus the cpu<->queue mapping by the block layer is not
guaranteed to align with how workloads/VMs are scheduled on the host...

To me the problem statement sounds to me like you are looking to get a 
"private"
controller (set of IO queues) for each VM. Wouldn't a better approach 
would be to pass
a "private controller" connect-param which would for TCP mean that the 
driver would
create a dedicated UNBOUND workqueue which allows setting its cpumask?

Something like: nvme connect -t tcp -a <traddr> --queues_scope=private ?
Then you'd set its IO queues to something like:
echo [cpumask] > /sys/devices/virtual/workqueue/nvmeX-unb-wq/cpumask

Even explicit cpu-groups would be a better approach IMO. This would make
nvme-tcp to override blk_mq_map_queues() and adhere to the passed groups and
try to divide queues between them.

Something like the below example:
nvme connect -t tcp -a <traddr> --cpu-groups=0-63,64-127,128-191,192-255

In this case, nvme-tcp would try to both assign queue->io_cpu within these
ranges, and also assign the cpu<->mapping according to these groups.

