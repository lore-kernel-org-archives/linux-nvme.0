Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 353A9C5DF8C
	for <linux-nvme@archiver.kernel.org>; Sun, 23 Aug 2026 17:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UJ2aHnzQI1Mta2slSMNw3vLT4xRrVbqhBIO3z2Qh3c4=; b=a43R0r2TU/G3CLKBr78OFf44Xf
	ZAESD7ldAUHdpjKG46kv3GTA4ZxMH39+qVd9HL1Jgwg7R/Aoy9P2wl9+o4jXx04SmtP2Vzb7T0vJO
	0dacWaSVhV9e98MwHbIhUvtsyrF8nuTWDuiZxve2q4HHMEg+sYYCkGhFibBUAUV/K8dNwNXiJJX2H
	bhp1Fhb2H+gFxpE+9bZG1sEeTTUjbmDVzzrjhppmOtBvof7PabfLRnxvlBhQVje1+UchRZyLsSRex
	Oil12P83VlQjMuajOestb5qGQ7jySgNPYLwI8mkUKAHdGYHEGQoIiN0h2fI5npxyz+XMAKV6MoCoE
	1BdVlisw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wyCEd-0000000FVsC-0syb;
	Sun, 23 Aug 2026 17:43:55 +0000
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wyCEb-0000000FVrm-0DtD
	for linux-nvme@lists.infradead.org;
	Sun, 23 Aug 2026 17:43:54 +0000
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-2cace91f112so29650095ad.0
        for <linux-nvme@lists.infradead.org>; Sun, 23 Aug 2026 10:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crusoe.ai; s=google; t=1787507031; x=1788111831; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UJ2aHnzQI1Mta2slSMNw3vLT4xRrVbqhBIO3z2Qh3c4=;
        b=Vdvs6VllnEZQFdzjZFVdSTShBVIAyPY7fM2tI4NZ73cyE26SmONak6PMUT5eDWMn1a
         CwzyJcokacgDcIK2bYrJ/ePLgTxI49gAwvhPyeZahTOqfom4lGpV+E4nBvzAGL5/VnAD
         IlixUu67jsloOgaE7QlfOz0yN3rcFvLBPvUWzK2TY2JxosHGhYaByowDrUmAhf8b1Tax
         dmhYdH3ZAq7Bdm+XopHYNK/0LCmhb1AjyakKDIyC9Iv84a1wukvBbjqFcqoNtlXkuJrv
         BiC/8ChE0uBVxqlUr9Tqgm0rIk1iK+1bVj+R09GZZ0Kv5IhMmfriBc9GS21ViaXY1N+/
         qMKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787507031; x=1788111831;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UJ2aHnzQI1Mta2slSMNw3vLT4xRrVbqhBIO3z2Qh3c4=;
        b=tMOyA4HRxhjsz8TBdax9MpKW2Q+LJX5ExU5hT6S7Ogi+5zKYYyWMoujuA4zHdKxh8s
         99UbVL0fXBtPOIzi2YDn3fpniyFsmDHjgLAGOnnWuPlv2FWAWYhxL6t1l2Vm02ppZWZB
         NBb824vLpB0fjtgueXpOp8cr/uia5KI4KC1XjYquF1gchyqwcmp2vpLi8txvDO07c5MY
         YswaI+Wdrifuc8/4ZuWk1Nkc219oKI1CSSmOQtNQTaSNK7bh7l6fRHO4d1all5dm9ojS
         d7vJY7F1u6D3DMF/25TMXDI6jR7VqB+yA5yfR2VevaH+qBUhvig8/wQ2rMdscCZ+A7Hp
         fsgQ==
X-Forwarded-Encrypted: i=1; AHgh+RoBEkESmcIl4hFtLwZXvswWJMxTkzYZqQWe70NvTA2yFRHWWQlpr0mynD6eacr2pJAqwAekMH7HGd6i@lists.infradead.org
X-Gm-Message-State: AFuF++nXeAmwhc81NZ2gjsrQQkIGedgvaPoGOw6eVDvYjyCdhde+YQJs
	u/7UVz16Pzv00i+GjSMgXsCITL7bIQEwVtXK5K3z15LIxYR1ihesT7TfQDe3KlqvTpY=
X-Gm-Gg: AR+sD103pvuiL0HGqB8WfymE63U8/zv2gUiUJ7pOW6wNigrihxzdsq0lW8BRQy2yQSe
	yxHzyN4kHoen+T35tN7vOWksuznJ7kDVGrSsLxRK9fQcYJ0javeu/2IHFOopqn2LwFPmgg5nAxU
	tsNWqCo2razORxR/kRiUQpUeDPAQ/2at9uJSU9sm4RKaf1p0NTOQXeIr2uF7KvGnk3UpgfIEkWh
	+Ox6Odb9qkpLsuXlw6jIDz9kvrsWG1uteJ1iidUrlB3wGzgOfg/WM+L1Gp7DwrUB1GfLQp5pm1s
	W79z7a2DaDbmXIW/bS6X3ZkrM97+zN+BnHgqu0AtifjHSrd6mRMS02VVz5gGj6eABB/kwIpUMMl
	7+UTRtuVcSj6bEpBLPfsjhTcNdft2A0TyUAdOSGyIM+RRxOUh/CImy+FgZ5Y/jO+/MjP1YYR3tZ
	gR633gBS9/4WjY+DPTpuaQ2bVqBpIws8znk0wHxRm1Q63/3OYYTEt4oBs3LBMaUsanHkkjEpyZW
	9xIz9YBIjE8XEeIejKGukdxkZJ8Gvp1Qu71Fq7dViw=
X-Received: by 2002:a05:6a21:600b:b0:3c3:bbe6:95de with SMTP id adf61e73a8af0-3cd4ba451c0mr25107304637.6.1787507031467;
        Sun, 23 Aug 2026 10:43:51 -0700 (PDT)
Received: from MBP-Saravanan-D.civet-hops.ts.net ([2601:647:4380:3400:41a8:82b2:de7f:e948])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1418617378bsm16691759c88.11.2026.08.23.10.43.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 23 Aug 2026 10:43:50 -0700 (PDT)
From: Saravanan D <saravanand@crusoe.ai>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Saravanan D <saravanand@crusoe.ai>,
	linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	linux-kernel@vger.kernel.org,
	Nilay Shroff <nilay@linux.ibm.com>,
	Daniel Wagner <dwagner@suse.de>
Subject: Re: [PATCH v2] nvme-tcp: pin io_cpu to submitter cpu
Date: Sun, 23 Aug 2026 10:43:28 -0700
Message-ID: <20260823174348.40236-1-saravanand@crusoe.ai>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <56829bb7-2067-4794-88ec-7ddac2d3f250@grimberg.me>
References: <20260820083634.71689-1-saravanand@crusoe.ai> <56829bb7-2067-4794-88ec-7ddac2d3f250@grimberg.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260823_104353_111647_82D6373D 
X-CRM114-Status: GOOD (  19.45  )
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

On Sun, 23 Aug 2026 00:20:21 +0300 Sagi Grimberg <sagi@grimberg.me> wrote:
> Can you share a concrete example?
> 1. lscpu
> 2. grep -r ''  /sys/block/nvmeXnY/mq/*/cpu_list
> Also, what would be the VMs cpusets on such a server?

Very grateful for your review and suggestions.

Concrete example from one of these hosts, where there are more cpus than
the io queues NVMe-oF targets offer.

lscpu (trimmed): AMD EPYC 9654, 2 sockets, 2 threads/core, 384 CPUs
  NUMA node0 CPUs: 0-95,192-287
  NUMA node1 CPUs: 96-191,288-383

Each nvme-tcp controller exposes 128 io queues (queue_count 129) against
384 CPUs, so blk_mq_map_queues() folds three CPUs into every hctx. cpu_list for the namespace's path device, around one tenant's boundary:

  hctx67:  6, 7, 198
  hctx68:  8, 9, 200
  hctx69:  10, 11, 202
  hctx75:  22, 23, 214
  hctx76:  24, 25, 216
  hctx113: 199, 201, 203
  hctx114: 205, 207, 209
  hctx115: 211, 213, 215

Two VMs are live on this same shared controller:
  VM A cpuset: 8-23,200-215
  VM B cpuset: 104-191,296-383

VM A owns 200-215, so hctx113's group {199,201,203} has 201 and 203 inside
VM A and 199 outside it. The connect time pick can select 199 as that
queue's io_cpu, so VM A's I/O through hctx113 runs its socket work on 199,
outside its cpuset for its entire lifetime. Adoption will pull it back 
to 201 or 203 when VM A submits I/O.

> In an ideal setting, the nvme controller would support $NR_CPUS worth of
> io queues [...] map cpu-queue with perfect alignment.

Right, and that is the case we cannot reach here. The controller tops out
at 128 io queues while the host has 384 CPUs, so the three to one folding
is unavoidable and some groups end up straddling a tenant boundary.

> I think that for controllers with low queue count this approach would not
> work very well. Plus the cpu<->queue mapping by the block layer is not
> guaranteed to align with how workloads/VMs are scheduled on the host...

Agreed on both. A queue whose cpu group straddles two busy tenants is only
partially addressed, since adoption then selects which tenant hosts that
shared queue rather than removing the sharing. It fixes the common case
where cpu group sits within one VM's cpuset and the case where only one
tenant on the queue is active, and it is strictly better than the connect
time pick, which chooses that queue's io_cpu before any I/O and can land on
any member. Solving the common case also lets the control plane, which owns
the VM cpusets, affinitize each VM's virtio-blk submitter threads away from
CPUs whose mapped queue would land socket work on a neighbor.

> To me the problem statement sounds to me like you are looking to get a
> "private" controller (set of IO queues) for each VM. [...]
> nvme connect -t tcp -a <traddr> --cpu-groups=0-63,64-127,128-191,192-255

A private controller or a cpu-groups partition fits workloads where the CPU
partition is known and stable at connect time. Our production constraint 
does not afford us that luxury. The nvme-tcp controllers are host wide and
shared, the tenant VMs are namespaces under one multipath subsystem, and the
control plane creates, destroys and bin packs VMs continuously on these core
dense compute hosts. A cpu-groups mask fixed at connect would be stale as
soon as the tenant mix changes, and re-partitioning would mean reconnecting
a controller that many live tenants depend on. We also cannot give each
tenant its own controller, because the overhead on the host adds up and we
run the risk of exceeding the target's connection limits. Adopting the
submitting CPU needs no per tenant configuration and follows the tenant
churn on its own, which is why it fits a long lived shared connection whose
tenant set is not known at connect time.

Next the fleet operators who care about VM steal time already steer NIC IRQs,
NAPI to a dedicated housekeeping CPU pool outside the tenant cpusets, so the
common network processing overhead Nilay raised does not run on tenant CPUs.
With that in place the remaining contributor that still lands on a
tenant's CPU is nvme_tcp_io_work, which this patch pins to the submitting
cpu and keeps within the tenant's cpuset.

Thanks,
Saravanan D.

