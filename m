Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20BABC88E64
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Sep 2026 10:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=mUM2sZCJVaeqZYKP6IkcUXofWPnu0Bm+hmcYhC7PpOM=; b=Q8ot/Yj7YupOEqAfVsjRMqAX/Z
	t/zQi53y8naquY2oR9U+jSC4/tJbuFgFxecKa5n0sopKcejuWBM04uAXEepZYQSKiqOWtbHMreTQK
	9/p3Ys+p6Vcw3N6p2x+wDLCkZoaPxJ7GbWXNEZXMM52F2UG6AWEk2KpMvTlzaRn3JW0NB3umURQ33
	VmirKGmNkI66S7M6iQa8kDmOp5F664h+TYlgOEi/HJvXnoyv8p265ZcGqw0SvENzPLuBqu8DSP/3V
	ftzlFItXWLA/iQt4VuBkArTyoj5ikZ1jScEgdVa2b4bT2Ix87U1Qs/nEvw+zpeKqeEtnailvu4mZj
	nCfBGVbA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x64NL-00000003C6W-3i4G;
	Mon, 14 Sep 2026 10:57:27 +0000
Received: from out30-112.freemail.mail.aliyun.com ([115.124.30.112])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x64NI-00000003C5m-3ZvS
	for linux-nvme@lists.infradead.org;
	Mon, 14 Sep 2026 10:57:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1789383439; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=mUM2sZCJVaeqZYKP6IkcUXofWPnu0Bm+hmcYhC7PpOM=;
	b=WCGTLy9+QlzThPtm6Cl13eA+HYnvBl1VhxoU1nIxeTHB+FsskFahL/a/t0L2EYH2Bgc2o9RH5zq5dAZ6osoEp5RYL1Xw6iER8Wi8F9laNot4UsuviTDv+Hntvwsmx8TSneZGjE2tdTKsZoqAU200kKzHb0+PZPn0TMWOLKyA7UM=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R661e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0XAv8692_1789383438;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XAv8692_1789383438 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 14 Sep 2026 18:57:18 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Daniel Wagner <dwagner@suse.de>,
	John Garry <john.g.garry@oracle.com>,
	Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH] nvme-multipath: set BLK_FEAT_ZONED only after the zone info is known
Date: Mon, 14 Sep 2026 18:57:13 +0800
Message-ID: <20260914105713.155704-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260914_035725_584223_6B943F1E 
X-CRM114-Status: GOOD (  10.91  )
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

The namespace head is marked zoned at allocation time based only on
the command set identifier, before any zone information has been
queried.  If the zone info query fails on the first scan, the path
namespace is registered without zoned limits while the head still
advertises the zoned capability with a zone size of zero.  Reporting
zones or writing to the head then shifts by ilog2(0), triggering the
UBSAN shift-out-of-bounds report in the report-zones and write paths.

Drop the zoned feature from the head allocation and inherit it from
the path namespace: the head limits refresh already stacks the zoned
feature, the zone size and the zone resource limits from the path
queue, so the head matches the path namespace and becomes zoned once a
revalidation succeeds.  This also stops marking the head zoned when
CONFIG_BLK_DEV_ZONED is off, which used to fail the head allocation
with a WARN.

Found by code inspection while reviewing the nvme-7.3 branch.

Tested with a null_blk zoned namespace exported over two nvmet-tcp
ports, with the target patched to fail the command set specific
identify: the head no longer comes up zoned with zone size 0, the
UBSAN report is gone, and an ns-rescan once the identify succeeds again
transitions the head to zoned with the correct zone size.

Fixes: 28982ad73d6a ("nvme: set BLK_FEAT_ZONED for ZNS multipath disks")
Fixes: 3838e80fcfb3 ("nvme: skip the zoned limits update if the zone info query failed")
Cc: stable@vger.kernel.org
Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/nvme/host/multipath.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 75dbb58286a3..cdfaa04c25f8 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -763,8 +763,6 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
 	lim.dma_alignment = 3;
 	lim.features |= BLK_FEAT_IO_STAT | BLK_FEAT_NOWAIT |
 		BLK_FEAT_POLL | BLK_FEAT_ATOMIC_WRITES | BLK_FEAT_PCI_P2PDMA;
-	if (head->ids.csi == NVME_CSI_ZNS)
-		lim.features |= BLK_FEAT_ZONED;
 
 	head->disk = blk_alloc_disk(&lim, ctrl->numa_node);
 	if (IS_ERR(head->disk))
-- 
2.43.7


