Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85A51C982DE
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Sep 2026 07:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:Cc:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qspqS33YbYOK7/je4orVKpXphvpP4jNcv88NVYzzW/c=; b=VV21ledzwWlZvYeaypks6Jog59
	F2AbIk3v9NdlUBtgNnbo70upnfqboldxCnAhGqhHEI/RGu022HXmKplzsO8A1BYCGxLDNmmp9MkYv
	pgEuN5PxpsMaI2v8FGBx/48XTCBysM+XuaYD+1064JpIExYTnl/rkggKgGC4fghf3WINSw9jzaR1O
	Z9jLV0/1Jci9tH7GK4wA35lqMqn26Kw5DNRM/+/uCzfnlApZG7xAZ8Rem4JzPwP3CgO+PQ17MmdVy
	P1qL1U0oEs/p2ikuhlfU4p7zSQgZ1MgITTNu5lv0aHq7wzVy/f8j1DIcnDGg/wUA4MEXjX3wvnt1a
	YM35ivjQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8YQv-00000001D0V-0XBX;
	Mon, 21 Sep 2026 07:27:25 +0000
Received: from out-1.mta0.migadu.com ([2001:41d0:1004:224b::1] helo=mta0.migadu.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8YQs-00000001Cza-2d7i
	for linux-nvme@lists.infradead.org;
	Mon, 21 Sep 2026 07:27:23 +0000
X-Envelope-To: linux-nvme@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=IXoexxxwMj9ZHbqMM/S/tzSKGTmKj2ZFLeJiOwKWMgU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789975640; v=1; x=1790580440;
 b=KYZAW2BaT7BOilkJs6DE8Xrqj7Pl+P8wU/ntuSXDngs4dAhuEd3IcQO/o+tC3an4ztPbf0Qs
 W5j/3gIOb4xpd2oxwwKxZFRInNytNJK43PVprtE2G7WtCpOQxZ0Aac1FRXldw3INfSOqCoj7EX9
 /a988H9Z7iBO03z84jGT8IpM=
X-Envelope-To: linux-nvme@lists.infradead.org
Received: by smtp.migadu.com with ESMTPS id 10294fe07906a545;
	Mon, 21 Sep 2026 07:27:20 +0000
X-Mizu-Trace-ID: 10294fe07906a545
X-Migadu-Flow: FLOW_OUT
Message-ID: <d1509bf3-b56f-4f81-885f-329a5c710c56@linux.dev>
Date: Mon, 21 Sep 2026 15:27:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: cui.tao@linux.dev, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org, cuitao@kylinos.cn
Subject: Re: [RFC PATCH 0/1] block: charge passthrough requests to the
 submitter's cgroup
To: axboe@kernel.dk, kbusch@kernel.org, tj@kernel.org, hch@lst.de,
 sagi@grimberg.me, yukuai@fygo.io
References: <20260921070647.1928289-1-cui.tao@linux.dev>
From: Tao Cui <cui.tao@linux.dev>
In-Reply-To: <20260921070647.1928289-1-cui.tao@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260921_002722_820752_4E44D13E 
X-CRM114-Status: GOOD (  30.85  )
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

Hi,

在 2026/9/21 15:06, Tao Cui 写道:
> From: Tao Cui <cuitao@kylinos.cn>
> 
> While looking at cgroup IO control coverage, I stumbled into a hole
> that is probably familiar to people who have worked on passthrough:
> SG_IO, bsg, and the NVMe ioctl / uring command paths build requests
> directly and dispatch them through blk_execute_rq{,_nowait}(),
> never passing through submit_bio().  The mapped bio carries no blkcg
> association, so the bytes never show up in cgroup io.stat, and none
> of the rq_qos policies (iocost, iolatency, wbt) see these commands;
> blk-throttle, hooking submit_bio_noacct() directly, is equally
> blind.  On a scsi_debug device with iocost enabled and vrate pinned
> to its 1% floor, a direct writer in a cgroup is throttled ~10x while
> the same cgroup issuing sg_dd writes runs at full device speed with
> io.stat staying at zero.
> 
> This RFC is a prototype asking for feedback on one possible
> direction, not a proposal I am attached to: is charging passthrough
> at dispatch time the right layer and the right semantics at all?
> 
> The patch associates the mapped bio with the submitter's blkcg in
> blk_execute_rq{,_nowait}(), runs the regular bio accounting
> (blk_cgroup_bio_start()) and the rq_qos throttle path with it, and
> gates by opcode (READ/WRITE/DRV_IN/DRV_OUT, mapping the latter two
> to READ/WRITE for io.stat classification) and to queues that already
> have a gendisk so probing stays exempt.  On linux-next, with
> scsi_debug + sg_dd and qemu emulated nvme + an NVME_IOCTL_IO64_CMD
> loop, the transferred bytes are fully accounted in the issuing
> cgroup, and with vrate clamped the pacing bites: the same 128MB
> SG_IO run takes 0.025s unthrottled and 31.7s at the 1% floor, with
> the issuing task sleeping on the iocost waitqueue like any bio
> submitter.
> 
> Questions I am unsure about:
> 
>  1. Is always-on the right default, or should this hide behind the
>     queue/iostats_passthrough opt-in from the passthrough iostats
>     series, keeping default behavior unchanged?
>  2. The throttle may sleep; all callers I found (ioctl / uring_cmd
>     submit, target and error handling kthreads) are sleepable, and
>     kthread-issued charges land on root and turn into no-ops - but
>     I may have missed paths, and I'd rather ask than assume.
>  3. What should happen on nvme multipath failover, where the bio is
>     re-routed to another queue but carries the original queue's
>     blkg?  Untested; guidance welcome.
>  4. wbt also gains passthrough throttling through the same rq_qos
>     walk - probably benign since wbt targets buffered writeback,
>     but it is a behavior change I did not set out to make.
>  5. blk-throttle does not benefit (it is not an rq_qos policy, and
>     its queue-and-resubmit model does not fit bios already bound to
>     a dispatched request); would a synchronous wait variant there
>     be welcome as follow-up work, or is leaving it alone preferred?
> 
> Reproduction notes in case anyone tries: sg_dd coalesces into very
> large single commands by default (use bpt=1), and a short burst from
> a single cgroup rides the initial budget, so sustained transfers
> are what show the pacing.
> 

The cover letter summarized the motivation briefly, so let me add some
background on how this came up and what the prototype is trying to
address.

How this was found
------------------

This came from stress testing blk-iocost on linux-next with mixed IO
workloads and cgroup churn. With the known bio-path accounting gaps
(flush, zone append) already carrying posted fixes, the remaining
missing cases had one property in common: they build requests directly
and enter through blk_execute_rq(), bypassing submit_bio() entirely.

The invariant being violated is simple to state: any IO that consumes
device bandwidth but bypasses submit_bio() currently bypasses blkcg IO
accounting. Passthrough commands, including SG_IO, bsg, nvme ioctls and
uring commands, currently fall into this category: they have no blkcg
association, do not show up in io.stat, and do not participate in
blkcg-aware rq_qos policies such as iocost and iolatency.

The observable difference
-------------------------

On the same scsi_debug device, with the same cgroup and iocost enabled
with vrate pinned at its 1% floor:

  bio writer (fio)                 throttled ~10x
  SG_IO writer (sg_dd)             full device speed,
                                   io.stat remains zero

The NVMe ioctl path shows the same behavior: passthrough provides a
path that bypasses the existing accounting boundary.

With the prototype patch
------------------------

The mapped bio is associated with the submitting blkcg in
blk_execute_rq{,_nowait}(), and goes through the normal bio accounting
and rq_qos paths.

With the same setup:

  - a 128MB SG_IO write (bs=1M, bpt=1) is accounted to the issuing
    cgroup's io.stat, with wbytes/wios matching the transfer;
  - the same workload takes 0.025s without throttling and 31.7s with
    vrate at the 1% floor, with the task sleeping in the iocost throttle
    path.

Two reproduction notes: sg_dd combines transfers into large commands by
default, so bpt=1 is needed for scsi_debug. Also, short bursts can be
covered by the initial budget; sustained transfers make the difference
visible.

Relation to passthrough iostats
-------------------------------

This RFC builds on Keith's passthrough iostats work. That series made
disk-level passthrough accounting possible and provided block-device
association for passthrough bios where it is available.

This RFC is about the next layer: whether passthrough IO should also
participate in blkcg accounting and enforcement.

The questions from the cover letter still stand. In particular, I am
not sure whether attaching blkcg/accounting at this layer is the right
abstraction, or whether this should remain an opt-in behavior like
passthrough iostats.

Thanks,
Tao

> 
> Tao Cui (1):
>   block: charge passthrough requests to the submitter's cgroup
> 
>  block/blk-mq.c | 72 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 72 insertions(+)
> 


