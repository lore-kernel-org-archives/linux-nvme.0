Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52D8EC982DE
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Sep 2026 07:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=cCfbmU01andLlshsBeZO/qeNdT/gnl71w3ewSjpN/uo=; b=sH1g8NVpBjhAYOwNrmJ5MlMs5c
	DSqwg9xjLmorBhdFt06nDuFd1QurBXXxgdfen5WUkJwERjTMuziVfuyAS14UglexKQPgKyTOITH5f
	xvGwKsRixoFZi27ErCRuGMzSieLCEqg1BehG1Dwjy8FDtFk23u1+/91LI3chIjIJMkAxJPJafgqkO
	pUkcAByP3AqdiN862nQHH0hWe5eYUQU5PHuA7shcI42MfLavCQW7kN70aQyP4vxUAVAYCdMymD6F4
	YDxblvXkMDLVV1forBTvYOpyau80C+0wIJ1o2jo9r3b2m3ralz9CYMkDKNOTt5JyIfrGW9xlnultt
	zkHhw2ig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8Y7F-000000019vD-30Hl;
	Mon, 21 Sep 2026 07:07:05 +0000
Received: from out-68.mta1.migadu.com ([95.215.58.68] helo=mta1.migadu.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8Y7C-000000019ta-3lVJ
	for linux-nvme@lists.infradead.org;
	Mon, 21 Sep 2026 07:07:04 +0000
X-Envelope-To: linux-nvme@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=uDT0ATYSKthF666srJ0UipySpgzzQDPQH/7dLSLIUMw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789974419; v=1; x=1790579219;
 b=H2iU+pMb+Q8nDOrleSC/ZtQil13XSkISiu+GdZGKtiZ7au90SJw/Rl5l1PCPtyXpJbHyzwVX
 T6rWuEa0B4GECs2zdLIBfi7FsKwI61bzAJf13XGF7ANfTXfYFmwoq2S8rzTE0r9Ab8zvVEAo4ph
 l0ESaoWyxz55/HLy0FLxnyTE=
X-Envelope-To: linux-nvme@lists.infradead.org
Received: by smtp.migadu.com with ESMTPS id 0634c950bb179c52;
	Mon, 21 Sep 2026 07:06:59 +0000
X-Mizu-Trace-ID: 0634c950bb179c52
X-Migadu-Flow: FLOW_OUT
From: Tao Cui <cui.tao@linux.dev>
To: axboe@kernel.dk,
	kbusch@kernel.org,
	tj@kernel.org,
	hch@lst.de,
	sagi@grimberg.me,
	yukuai@fygo.io
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cui.tao@linux.dev,
	cuitao@kylinos.cn
Subject: [RFC PATCH 0/1] block: charge passthrough requests to the submitter's cgroup
Date: Mon, 21 Sep 2026 15:06:46 +0800
Message-ID: <20260921070647.1928289-1-cui.tao@linux.dev>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260921_000703_260076_B4479E69 
X-CRM114-Status: GOOD (  13.08  )
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

From: Tao Cui <cuitao@kylinos.cn>

While looking at cgroup IO control coverage, I stumbled into a hole
that is probably familiar to people who have worked on passthrough:
SG_IO, bsg, and the NVMe ioctl / uring command paths build requests
directly and dispatch them through blk_execute_rq{,_nowait}(),
never passing through submit_bio().  The mapped bio carries no blkcg
association, so the bytes never show up in cgroup io.stat, and none
of the rq_qos policies (iocost, iolatency, wbt) see these commands;
blk-throttle, hooking submit_bio_noacct() directly, is equally
blind.  On a scsi_debug device with iocost enabled and vrate pinned
to its 1% floor, a direct writer in a cgroup is throttled ~10x while
the same cgroup issuing sg_dd writes runs at full device speed with
io.stat staying at zero.

This RFC is a prototype asking for feedback on one possible
direction, not a proposal I am attached to: is charging passthrough
at dispatch time the right layer and the right semantics at all?

The patch associates the mapped bio with the submitter's blkcg in
blk_execute_rq{,_nowait}(), runs the regular bio accounting
(blk_cgroup_bio_start()) and the rq_qos throttle path with it, and
gates by opcode (READ/WRITE/DRV_IN/DRV_OUT, mapping the latter two
to READ/WRITE for io.stat classification) and to queues that already
have a gendisk so probing stays exempt.  On linux-next, with
scsi_debug + sg_dd and qemu emulated nvme + an NVME_IOCTL_IO64_CMD
loop, the transferred bytes are fully accounted in the issuing
cgroup, and with vrate clamped the pacing bites: the same 128MB
SG_IO run takes 0.025s unthrottled and 31.7s at the 1% floor, with
the issuing task sleeping on the iocost waitqueue like any bio
submitter.

Questions I am unsure about:

 1. Is always-on the right default, or should this hide behind the
    queue/iostats_passthrough opt-in from the passthrough iostats
    series, keeping default behavior unchanged?
 2. The throttle may sleep; all callers I found (ioctl / uring_cmd
    submit, target and error handling kthreads) are sleepable, and
    kthread-issued charges land on root and turn into no-ops - but
    I may have missed paths, and I'd rather ask than assume.
 3. What should happen on nvme multipath failover, where the bio is
    re-routed to another queue but carries the original queue's
    blkg?  Untested; guidance welcome.
 4. wbt also gains passthrough throttling through the same rq_qos
    walk - probably benign since wbt targets buffered writeback,
    but it is a behavior change I did not set out to make.
 5. blk-throttle does not benefit (it is not an rq_qos policy, and
    its queue-and-resubmit model does not fit bios already bound to
    a dispatched request); would a synchronous wait variant there
    be welcome as follow-up work, or is leaving it alone preferred?

Reproduction notes in case anyone tries: sg_dd coalesces into very
large single commands by default (use bpt=1), and a short burst from
a single cgroup rides the initial budget, so sustained transfers
are what show the pacing.


Tao Cui (1):
  block: charge passthrough requests to the submitter's cgroup

 block/blk-mq.c | 72 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

-- 
2.43.0


