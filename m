Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84C2DC982ED
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Sep 2026 08:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=A87oIfCynBaH9eBqcIOof8WpUzXLA6uzPV/2fLkGJZ0=; b=2KdRJcbi7ea/u4Gxc2MAtfFFTk
	DPdt0oAc1MFNsSzyvzqwd7No7vJx7okAq2qA+5zdGYP6a+UnnnijKGPHwr43Rogzd+kPohd3WZ4eh
	Cvy7eL7NSil5EClfpXBRj1r0crm8C9o/n7+Orf80SGrEnxXtIPvWG8yXt0zQf2IHrfZmRNp6ZYe3C
	VYvwMCrFRx77GDyHlBBnKh7ent/M88sLHYtfv82+qnppVeJsMG4gsfSh2ITTl5QQcHZIsBgXH4GYq
	vFYO8qEuvGtj+SgK6OmlXVLC75OaOUKahzn9ietZ64crvIo+DKvZ+E1TL0Kv9oikhfADX8c5D4pEU
	g6zAlnuA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8ZXk-00000001MbT-0CHT;
	Mon, 21 Sep 2026 08:38:32 +0000
Received: from out-41.mta1.migadu.com ([2001:41d0:203:375::29] helo=mta1.migadu.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8ZXX-00000001MRH-0dmB
	for linux-nvme@lists.infradead.org;
	Mon, 21 Sep 2026 08:38:21 +0000
X-Envelope-To: linux-nvme@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=NHMCDWteuexNV3uSWdsxCXrqYhHELeMCl+JXW4IoR8I=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789979897; v=1; x=1790584697;
 b=QOEPF9I2LI1TrBdOlk28v8xDTpgTSAydGMg24017vRCcePMlECQu/uhRwNKSwIam0LfNUaqR
 ozcQ8aASaRAlXH7mRN3+j0cNEa4/SqhvMRAUUy6Qnt6XwmBIvX7UQQ67OcY7he1Kql+hKzmuTTh
 0VUjN1XgRi7FpyQ9zH7tnS4U=
X-Envelope-To: linux-nvme@lists.infradead.org
Received: by mta11.migadu.com with ESMTPS id 92277e0fc02bb1cd;
	Mon, 21 Sep 2026 08:38:16 +0000
X-Mizu-Trace-ID: 92277e0fc02bb1cd
X-Migadu-Flow: FLOW_OUT
From: John Garry <john.garry@linux.dev>
To: axboe@kernel.dk,
	kbusch@kernel.org,
	sagi@grimberg.me,
	hch@lst.de
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	John Garry <john.garry@linux.dev>
Subject: [PATCH v4 2/4] block: don't show partition diskstats for GENHD_FL_HIDDEN
Date: Mon, 21 Sep 2026 09:37:50 +0100
Message-ID: <20260921083752.1154316-3-john.garry@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260921083752.1154316-1-john.garry@linux.dev>
References: <20260921083752.1154316-1-john.garry@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260921_013819_392406_6A70E70E 
X-CRM114-Status: GOOD (  10.85  )
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

When flag GENHD_FL_HIDDEN is set for a disk, normally the partition table
is not available and so we won't get its partitions showing in diskstats.

However, now hidden disks may partition tables.

The diskstats for partitions on disks with GENHD_FL_HIDDEN can bloat
the output and is not too interesting, so always hide it.

Signed-off-by: John Garry <john.garry@linux.dev>
---
 block/genhd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/genhd.c b/block/genhd.c
index 10ca8b4d6eea..60dc7a61ea8a 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1376,7 +1376,8 @@ static int diskstats_show(struct seq_file *seqf, void *v)
 
 	rcu_read_lock();
 	xa_for_each(&gp->part_tbl, idx, hd) {
-		if (bdev_is_partition(hd) && !bdev_nr_sectors(hd))
+		if (bdev_is_partition(hd) &&
+		    (!bdev_nr_sectors(hd) || (gp->flags & GENHD_FL_HIDDEN)))
 			continue;
 
 		inflight = bdev_count_inflight(hd);
-- 
2.43.0


