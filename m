Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 130A9C61DE8
	for <linux-nvme@archiver.kernel.org>; Sun, 30 Aug 2026 22:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IDJve5c7BbhYquX3/va28qHfs9qVxgaGxAO1E5yp37M=; b=Hc2f4SSaUbSFUn9IQNeoaiTluc
	Bo+h38hzkYp1yAebgRU7j8FPdY7jJjMDecrprW8WTUJoXZiNaDh568pHAGyrEb/u8+AjhWam299nm
	Cg61i2chHPV1hsmzb0PhuhD3D3vj1qTPzlazzo8QArnyd+pKNuPnOeDML10Y25YqG3oGzMOqGyCFy
	oXUlSqWz3r6v42V7aWnwH7K2zBxiqpX+OuHnv+4q1E8dMyYxUdXtxUzXvgYAFp7evJgxY5iN1rtcn
	J1dZC48kvYJwdISPfLXDqSblxUrgZjOlmErV7uoZpFDjDJlCsohCf+fFfRT65c6aDAOUtgtEZaX9X
	35ke2gxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x0o2Y-00000008BZo-2wIk;
	Sun, 30 Aug 2026 22:30:14 +0000
Received: from mail-wm1-f54.google.com ([209.85.128.54])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x0o2W-00000008BZK-2z06
	for linux-nvme@lists.infradead.org;
	Sun, 30 Aug 2026 22:30:13 +0000
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-49557167508so29769835e9.1
        for <linux-nvme@lists.infradead.org>; Sun, 30 Aug 2026 15:30:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788129011; x=1788733811;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IDJve5c7BbhYquX3/va28qHfs9qVxgaGxAO1E5yp37M=;
        b=V029iPF14LRmJdHGic0HGphYWp1MdpeX+B6kTeOHsXW7j4MyzaIu7bit1wPESfMYRZ
         yFAmZqU052XB8W00rh1Gc44oS9/feK3ibHv94xZz+etZmSRXnJzKRCGSUHndv5B3dqZ6
         M+WH2tHYYRqrSXhZlR1nTnPuAodUJ9UTKSfzkPf6DoIQixA/9+9u0RELzx2xUjc+gPA0
         L1FPEbRt1m8XK1lQuJVrMxSZNbmeLLjwaGr4T0GdC4AMF/aBvMDtj3CmZFDqiwYuc2nN
         pC45DlSluth7Xllgs1zw3myqmgIRCHjZIxa3vQsJOp3J3RL4xCwFERxIN7QxIbnMGIst
         fgcQ==
X-Gm-Message-State: AFuF++nFEKIx3CFLqtkLU9RKdZfuzhTQ1jZ/kn0cHThiiO9haGkjtxCM
	firLsLI5JQFdK4W8IMf9PQkO9tgr9F7lH6iIF3ILthNf31pVrNSO4qhs
X-Gm-Gg: AR+sD10MGyk1YCSggagC+pJrVDswaWxrgbGa4tJH7LbXok2CQIHVBInUxO2w620r0fz
	89nvJ9qdg0JVYtFPZR04gTiV7EQfUNLvhp4AjKIGlYUB/9tHqT2/TmjJ8AFwEnoDPMIbafrhQL1
	YmarMPb9p/92f0gt0qhv6yg3a7VBDs67WjriaQjsnazvYYDH8k0d55kRW+HW47Zb/jM0n/xbVdQ
	XL41n9J87U8PiEeuZNzhMpFruaXDEuDcuGmJftrGJdTVrKyG0C4Cu6dnAIT2Rz5sy1CvvzNOigh
	GRdgD1ZlpE7e545vfnKs261zOFLqRl7bnVddMKBfm0dZJ0KupQ9Bom0ShttcHTE/kjEw7Xbamhz
	wN5R5gHkWiqnlJ5XQtyByb8wihMVwJhJIcl4Hnm3iBF85dXGJL0valFTFGhUmbUFdTQ989c7tEK
	YDIpW3yk4Rax2IR9Vk5tEQEuyC57iGGAFq2wAfxRvFisgxExN1AL4gBaYDJg+i1l2gW3QDG4S1l
	RoQekdtFfMdAesc7LDq5g==
X-Received: by 2002:a05:600c:468e:b0:499:b65e:49c9 with SMTP id 5b1f17b1804b1-49cd88f6b91mr769105e9.10.1788129010620;
        Sun, 30 Aug 2026 15:30:10 -0700 (PDT)
Received: from [10.100.102.74] (89-138-77-243.bb.netvision.net.il. [89.138.77.243])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cd8148fbdsm9351575e9.3.2026.08.30.15.30.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Aug 2026 15:30:10 -0700 (PDT)
Message-ID: <1d56144d-6987-40c1-ac02-b15333db121e@grimberg.me>
Date: Mon, 31 Aug 2026 01:30:08 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nvme-tcp: pin io_cpu to submitter cpu
To: Saravanan D <saravanand@crusoe.ai>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 linux-kernel@vger.kernel.org, Nilay Shroff <nilay@linux.ibm.com>,
 Daniel Wagner <dwagner@suse.de>
References: <20260820083634.71689-1-saravanand@crusoe.ai>
 <56829bb7-2067-4794-88ec-7ddac2d3f250@grimberg.me>
 <20260823174348.40236-1-saravanand@crusoe.ai>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20260823174348.40236-1-saravanand@crusoe.ai>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260830_153012_786630_FFC3EDDC 
X-CRM114-Status: GOOD (  28.56  )
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



On 23/08/2026 20:43, Saravanan D wrote:
> On Sun, 23 Aug 2026 00:20:21 +0300 Sagi Grimberg <sagi@grimberg.me> wrote:
>> Can you share a concrete example?
>> 1. lscpu
>> 2. grep -r ''  /sys/block/nvmeXnY/mq/*/cpu_list
>> Also, what would be the VMs cpusets on such a server?
> Very grateful for your review and suggestions.
>
> Concrete example from one of these hosts, where there are more cpus than
> the io queues NVMe-oF targets offer.
>
> lscpu (trimmed): AMD EPYC 9654, 2 sockets, 2 threads/core, 384 CPUs
>    NUMA node0 CPUs: 0-95,192-287
>    NUMA node1 CPUs: 96-191,288-383
>
> Each nvme-tcp controller exposes 128 io queues (queue_count 129) against
> 384 CPUs, so blk_mq_map_queues() folds three CPUs into every hctx. cpu_list for the namespace's path device, around one tenant's boundary:
>
>    hctx67:  6, 7, 198
>    hctx68:  8, 9, 200
>    hctx69:  10, 11, 202
>    hctx75:  22, 23, 214
>    hctx76:  24, 25, 216
>    hctx113: 199, 201, 203
>    hctx114: 205, 207, 209
>    hctx115: 211, 213, 215
>
> Two VMs are live on this same shared controller:
>    VM A cpuset: 8-23,200-215
>    VM B cpuset: 104-191,296-383
>
> VM A owns 200-215, so hctx113's group {199,201,203} has 201 and 203 inside
> VM A and 199 outside it. The connect time pick can select 199 as that
> queue's io_cpu, so VM A's I/O through hctx113 runs its socket work on 199,
> outside its cpuset for its entire lifetime. Adoption will pull it back
> to 201 or 203 when VM A submits I/O.
>
>> In an ideal setting, the nvme controller would support $NR_CPUS worth of
>> io queues [...] map cpu-queue with perfect alignment.
> Right, and that is the case we cannot reach here. The controller tops out
> at 128 io queues while the host has 384 CPUs, so the three to one folding
> is unavoidable and some groups end up straddling a tenant boundary.

Yes, most if not all nvme-of subsystems won't let the host open so many 
queues.

>
>> I think that for controllers with low queue count this approach would not
>> work very well. Plus the cpu<->queue mapping by the block layer is not
>> guaranteed to align with how workloads/VMs are scheduled on the host...
> Agreed on both. A queue whose cpu group straddles two busy tenants is only
> partially addressed, since adoption then selects which tenant hosts that
> shared queue rather than removing the sharing. It fixes the common case
> where cpu group sits within one VM's cpuset and the case where only one
> tenant on the queue is active, and it is strictly better than the connect
> time pick, which chooses that queue's io_cpu before any I/O and can land on
> any member. Solving the common case also lets the control plane, which owns
> the VM cpusets, affinitize each VM's virtio-blk submitter threads away from
> CPUs whose mapped queue would land socket work on a neighbor.

I just think that the adoption approach has downsides in many other 
workloads.
I wouldn't categorize your use-case as the common use-case. Not to say 
that it
shouldn't be solved.

>
>> To me the problem statement sounds to me like you are looking to get a
>> "private" controller (set of IO queues) for each VM. [...]
>> nvme connect -t tcp -a <traddr> --cpu-groups=0-63,64-127,128-191,192-255
> A private controller or a cpu-groups partition fits workloads where the CPU
> partition is known and stable at connect time. Our production constraint
> does not afford us that luxury. The nvme-tcp controllers are host wide and
> shared, the tenant VMs are namespaces under one multipath subsystem, and the
> control plane creates, destroys and bin packs VMs continuously on these core
> dense compute hosts. A cpu-groups mask fixed at connect would be stale as
> soon as the tenant mix changes, and re-partitioning would mean reconnecting
> a controller that many live tenants depend on. We also cannot give each
> tenant its own controller, because the overhead on the host adds up and we
> run the risk of exceeding the target's connection limits. Adopting the
> submitting CPU needs no per tenant configuration and follows the tenant
> churn on its own, which is why it fits a long lived shared connection whose
> tenant set is not known at connect time.
>
> Next the fleet operators who care about VM steal time already steer NIC IRQs,
> NAPI to a dedicated housekeeping CPU pool outside the tenant cpusets, so the
> common network processing overhead Nilay raised does not run on tenant CPUs.
> With that in place the remaining contributor that still lands on a
> tenant's CPU is nvme_tcp_io_work, which this patch pins to the submitting
> cpu and keeps within the tenant's cpuset.

I agree with you that queue io_cpu selection at connection time is too 
limiting.
Perhaps we can have each nvme-tcp queue expose a sysfs entry to set the 
io_cpu?

This way, its up to a control-plane to mangle with the queue io_cpu 
setting at
any point it would like.

Something like:
echo $CPU > /sys/class/nvme/nvme0/tcp_queues/$QUEUE/io_cpu

I am just trying to think of a way that will allow some control plane to 
set it exactly
as it wants, without the guessing part...

