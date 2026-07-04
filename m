Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DA12C43458
	for <linux-nvme@archiver.kernel.org>; Sat,  4 Jul 2026 19:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=XBefwgHbcKa8lF9fx4CimAkm/mOI1OLeJiYAKnbJMVM=; b=bNinCvKufcwra2SFS+5TBrtvbi
	ctSWFvQneeoU4z0myKM+064/kvJRTAGHNI/4VQXhNsIxLfLV7r6YOyZ/pdV3aZG/4ckAdDCFgqvaD
	DHJ2eGYeZn6uo1P/47By/qO9pVSOda5MTxn5YpfXm1z19PnCI9kUwrhglkyWS5Udy8WodmdoyTNpQ
	96UO9gPvwpksLBk4qQzPHTaVWZ1wXYAuIMdntckGQ8ZOaQW1zb+SLXZgittPlW/UvDrPr220fFxvc
	Px106haNP9cA0UONCjcKFebyle8sR0qPR5zUllPpa6mMJ6dczcGjEFcWLRyI0JF85oljz5uT0jb0S
	hPbGDjDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wg6Ox-00000008iU6-1qtq;
	Sat, 04 Jul 2026 19:51:47 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wg6Ov-00000008iTg-46Ry
	for linux-nvme@lists.infradead.org;
	Sat, 04 Jul 2026 19:51:46 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 54C94435AA;
	Sat,  4 Jul 2026 19:51:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB6A41F000E9;
	Sat,  4 Jul 2026 19:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783194705;
	bh=XBefwgHbcKa8lF9fx4CimAkm/mOI1OLeJiYAKnbJMVM=;
	h=From:To:Cc:Subject:Date;
	b=eyGDj+l9ou1O5f59vydhkXwbA3fDVbVY5wPAk+z0treKXGPKqXslTE3lUBAsGocd7
	 j4HWvk4BMNpWicrOIm4gLY3YVgF3Q6UEhK7cReG0YCnUSyd7h/IgSYc0DKYXfWNGK2
	 4NTeA2Sr3moCGhheLA2o94lnROHcghNi1lucHAcN49jDn2x5ypWvXlRjRz19Rb4+79
	 D3BUC+ZGPqCZb8zqM+3k0kbrkEvOlPw3Ll9PYCZOu2J/UuiBjkZaboSHjLU787V9b2
	 JaEC6vggxII6Lo1jd3LNPsKr4cE4QactM2ublptM5aeMxzXzOBZq6U+mCcpHFheYal
	 aWylKO5MUd0xw==
From: Yu Kuai <yukuai@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	Tejun Heo <tj@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Alasdair Kergon <agk@redhat.com>,
	Benjamin Marzinski <bmarzins@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Dongsheng Yang <dongsheng.yang@linux.dev>,
	Zheng Gu <cengku@gmail.com>,
	Coly Li <colyli@fygo.io>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Josef Bacik <josef@toxicpanda.com>,
	Yu Kuai <yukuai@fygo.io>,
	Nilay Shroff <nilay@linux.ibm.com>,
	linux-block@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	dm-devel@lists.linux.dev,
	linux-bcache@vger.kernel.org
Subject: [RFC PATCH v1 00/17] blk-cgroup: protect blkgs with blkcg_mutex
Date: Sun,  5 Jul 2026 03:51:07 +0800
Message-ID: <20260704195124.1375075-1-yukuai@kernel.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Yu Kuai <yukuai@fygo.io>

This RFC moves queue-local blkg topology synchronization from
q->queue_lock to q->blkcg_mutex.

q->queue_lock is a hot block-layer spinlock used by request queue runtime
paths, and it is also used in irq-disabled or otherwise atomic contexts.
Using it to protect blkg topology makes blkg lookup, creation,
destruction, policy activation, and policy-state walks inherit those atomic
locking constraints.  That forces awkward preallocation schemes such as
radix-tree preloading and prevents missing-blkg creation from sleeping,
even though blkg creation is a blkcg control-plane operation rather than a
queue dispatch fast-path operation.

q->blkcg_mutex is a better fit for blkg protection because it is already a
queue-local blkcg lock, it can serialize the full lookup/create/destroy and
policy activation path, and it allows allocation and parent lookup to run
from sleepable contexts.  Moving blkg topology under q->blkcg_mutex also
separates blkcg topology from queue runtime locking, reducing queue_lock
scope and making the locking rules for blkcg policy users explicit.

bio_set_dev() and bio allocation with a bdev can associate a bio with the
destination queue's blkg.  Once missing blkg creation is serialized by
q->blkcg_mutex, those helpers may sleep when they create a blkg.  The first
part of the series therefore audits callers that can reach these helpers
from completion, spinlocked, irq-disabled, GFP_NOWAIT, or other
non-blocking paths, and either moves association to process context or uses
a nowait association path that avoids sleeping.

The preparatory patches cover NVMe multipath requeue, dm-thin and
dm-snapshot map paths, blk-throttle's private runtime lock, atomic bio
allocation helpers, bcache, dm-bufio, dm-pcache, DM NOWAIT clones/remaps,
and BFQ's locked cgroup update path.  The final blkcg patches then move
blkg lookup/create/destroy, policy activation, and configuration
preparation to q->blkcg_mutex; remove radix-tree preloading; move blkg
allocation into blkg_create(); and share creation code between bio
association and config preparation.

This is RFC because the locking conversion changes a central blkcg lifetime
path and relies on all non-sleepable bio association users either being
converted or tolerating nowait association failure.

One intentional tradeoff is left in the nowait paths.  They first associate
with an existing blkg.  If a thread issues IO to a queue for the first time
from a GFP_NOWAIT or otherwise non-blocking path, the cgroup's blkg for
that queue may not exist yet.  After blkg topology moves to q->blkcg_mutex,
preemptible task-context callers try q->blkcg_mutex and attempt blkg
creation.  Once allocation moves into blkg_create(), that opportunistic
nowait creation uses GFP_ATOMIC.  If the caller is in atomic context,
q->blkcg_mutex is contended, or allocation fails, the nowait helper still
fails and the caller needs to retry from a blocking context, defer the
association, or fall back to an existing slow path.

Patch layout:

Patch 1: move NVMe multipath failover bio retargeting to requeue work so
bio_set_dev() runs from process context instead of completion context.

Patches 2-3: remove or avoid bio_set_dev() while dm-thin and dm-snapshot
locks are held, and restore blkcg association later where needed.

Patch 4: give blk-throttle its own runtime-state lock so blkcg topology
can be moved away from queue_lock.

Patches 5-7: add bio_alloc_atomic(), make bio association nowait-aware,
and make bio allocation with a bdev fail rather than sleep for
non-blocking callers.

Patches 8-12: convert bcache, dm-bufio, dm-pcache, block helper
allocations, and DM NOWAIT remaps/clones to the new nowait or deferred
association model.

Patch 13: avoid a sleeping blkg lookup from BFQ while bfqd->lock is held.

Patch 14: protect queue-local blkg lookup, creation, destruction, policy
activation, and policy state walks with q->blkcg_mutex.  This also makes
preemptible nowait bio association try q->blkcg_mutex instead of failing
immediately after an RCU lookup miss.

Patch 15: remove radix-tree preloading after blkg creation no longer runs
under queue_lock.

Patch 16: allocate blkgs inside blkg_create() and use GFP_ATOMIC for the
nowait bio-association trylock creation path.

Patch 17: share blkg creation between bio association and config
preparation.

Yu Kuai (17):
  nvme-multipath: retarget failedover bios from requeue work
  dm thin: avoid bio_set_dev under pool lock
  dm snapshot: avoid bio_set_dev in locked map paths
  blk-throttle: protect throttle state with td lock
  block: add bio_alloc_atomic() for atomic bio users
  blk-cgroup: support non-blocking bio association
  block: support non-blocking bio allocation with a bdev
  bcache: avoid sleeping blkg association from locked paths
  dm bufio: avoid blkg association from GFP_NOWAIT bio init
  dm pcache: handle non-blocking bio clone init failure
  block: avoid scheduling from non-blocking helper allocations
  dm: avoid sleeping blkg association from NOWAIT remaps
  bfq: avoid blkg lookup from locked cgroup update
  blk-cgroup: protect blkgs with blkcg_mutex
  blk-cgroup: remove blkg radix tree preloading
  blk-cgroup: allocate blkgs in blkg_create
  blk-cgroup: share blkg creation between lookup and config prep

 block/bfq-cgroup.c                 |  26 +-
 block/bio.c                        |  50 +++-
 block/blk-cgroup.c                 | 397 ++++++++++++-----------------
 block/blk-cgroup.h                 |  16 +-
 block/blk-crypto-fallback.c        |   2 +-
 block/blk-iocost.c                 |   5 +-
 block/blk-iolatency.c              |   7 +-
 block/blk-lib.c                    |   3 +-
 block/blk-map.c                    |   7 +-
 block/blk-throttle.c               |  93 +++++--
 drivers/md/bcache/journal.c        |   9 +-
 drivers/md/bcache/request.c        |   4 +-
 drivers/md/dm-bufio.c              |   9 +-
 drivers/md/dm-linear.c             |   2 +-
 drivers/md/dm-pcache/backing_dev.c |  10 +-
 drivers/md/dm-snap.c               |  29 ++-
 drivers/md/dm-stripe.c             |   6 +-
 drivers/md/dm-switch.c             |   2 +-
 drivers/md/dm-thin.c               |   3 -
 drivers/md/dm-unstripe.c           |   2 +-
 drivers/md/dm.c                    |  28 +-
 drivers/md/md.c                    |   2 +-
 drivers/nvdimm/nd_virtio.c         |  11 +-
 drivers/nvme/host/multipath.c      |   4 +-
 fs/gfs2/lops.c                     |   3 +-
 fs/ocfs2/cluster/heartbeat.c       |  15 +-
 include/linux/bio.h                |  53 ++--
 include/linux/device-mapper.h      |   8 +
 include/linux/writeback.h          |   2 +-
 mm/page_io.c                       |   2 +-
 30 files changed, 467 insertions(+), 343 deletions(-)


base-commit: a1c8bdbbd72564cebb0d02948c1ed57b80b2e773
-- 
2.51.0

