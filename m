Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CAF9C982DE
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Sep 2026 08:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=YF+QnJSI2IRYLX+BBvh35LbXmYpd77dILkjsHttGPm8=; b=Brj5fBUT0owGrTdVeIhiAY6T5K
	npaSmd39FmalP0wEVtE3O1DYCa1If260g51/dcumg3eG8HXCEYSNvqdQltTTpnPv5Jk+VXSCTa+oW
	z82V4OI6nqf3FyUbhYJOMDSNZkYm3Q1WKbocY9hvNpa3TL7YTBAXnd9wDQoE78sxUHUISN0Ex7QYC
	IxNFNDrWW7qN8ULRZUJcwGhjLNZ7uMTfcQ4F1mEuixqgxK569Khi0Y1ToH0MwXiZvHWpY6v31rvJf
	6FH5AhBYr4aBzxpXNDcZ3PdTBJoyMiMIn7wcHiWNkhnyaSLpMTgjTp9jNcyUiI4taWwBIREearacM
	5u0nZW0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8ZXW-00000001MRt-1dC5;
	Mon, 21 Sep 2026 08:38:18 +0000
Received: from out-37.mta1.migadu.com ([2001:41d0:203:375::25] helo=mta1.migadu.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8ZXT-00000001MP1-1Umm
	for linux-nvme@lists.infradead.org;
	Mon, 21 Sep 2026 08:38:17 +0000
X-Envelope-To: linux-nvme@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=DIJ7cgApn0K70wpDhKxctu+FTAf8hiJPt+G9sqtwaG4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789979891; v=1; x=1790584691;
 b=pRoccNxkS2OUoRDeN0e29rvPMV+Sj1w56a3tNWcQFuWgiYpeIkNRoLjeTJ6ns1E8s0cG05JM
 kPjN/uvFfkAZyrcFHIDrXpM2jVdH4tScPanwb3pIE6KPf2nyutwX1PCvcgRz6Whgj2oG/TyFosO
 8wi2NArAEh290CQgb7zdTY4Q=
X-Envelope-To: linux-nvme@lists.infradead.org
Received: by mta11.migadu.com with ESMTPS id 5dd44f618b7d12b2;
	Mon, 21 Sep 2026 08:38:11 +0000
X-Mizu-Trace-ID: 5dd44f618b7d12b2
X-Migadu-Flow: FLOW_OUT
From: John Garry <john.garry@linux.dev>
To: axboe@kernel.dk,
	kbusch@kernel.org,
	sagi@grimberg.me,
	hch@lst.de
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	John Garry <john.garry@linux.dev>
Subject: [PATCH v4 0/4] fix NVMe multipath partition diskstats
Date: Mon, 21 Sep 2026 09:37:48 +0100
Message-ID: <20260921083752.1154316-1-john.garry@linux.dev>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260921_013815_624955_FA317717 
X-CRM114-Status: GOOD (  10.24  )
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


Currently the NVMe multipath partition diskstats are not maintained.
This is because the functionality to update the diskstats only updates
for the whole disk (and not per partition).

As an example:
$ ./fio_read nvme1n1p1 # run traffic on /dev/nvme1n1p1
...
$ more /proc/diskstats | grep nvme1
 259       2 nvme1c1n1 49857 0 400344 768565 0 0 0 0 0 2334 768565 0 0 0 0 0 0
 259       3 nvme1n1 99710 0 800680 1599285 0 0 0 0 0 2346 1599285 0 0 0 0 0 0
 259       5 nvme1n1p1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
 259       4 nvme1c2n1 49853 0 400336 831472 0 0 0 0 0 2315 831472 0 0 0 0 0 0

Notice how all values are 0 for nvme1n1p1.

This series addresses that problem by first updating the gendisk code to
create the partition table for hidden disks, as suggested by Keith.

This is done by cloning the partition table from the multipath disk.

Secondly the NVMe multipath functionality to handle the diskstats is
modified to handle the gendisk partition, by looking up this partition
from the per-path disk partition.

Difference to v3:
- Add block device operation disk changed CB

Difference to v2:
- don't scan per-path disk, and clone from multipath disk instead

John Garry (4):
  block: support cloning partitions
  block: don't show partition diskstats for GENHD_FL_HIDDEN
  nvme-multipath: clone head disk partitions to per-path disks
  nvme-multipath: fix diskstats for partitions

 block/genhd.c                 |  3 +-
 block/partitions/core.c       | 43 ++++++++++++++++++
 drivers/nvme/host/multipath.c | 83 ++++++++++++++++++++++++++++++-----
 include/linux/blkdev.h        |  2 +
 4 files changed, 120 insertions(+), 11 deletions(-)

-- 
2.43.0


