Return-Path: <SRS0=Ap99=CK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 381BFC433E2
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Sep 2020 15:58:01 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07191206EF
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Sep 2020 15:58:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Xt5ViEXR";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TsLN4Ki5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07191206EF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=DUvuw7oj/jMKbBthvrgbstJ5K2oEysuO8isgHTKIoBM=; b=Xt5ViEXREvc1FGRFSjXkuu8jo
	v9TUTDPlwZjw5EK/2vqGDf9L7PBV/cPTSY68NMW9g9ZcSF1+992jEuKo3cevUUG8clbXI+GCeTnS4
	ZHpmLwDj2u/FJrbpkx7IvHyr5Mw1lYJyLsraA021zlanRc0vPGPfSeBG1KT/hwoF5fZdRld+e2l5I
	QlZ6UemvnUk5Mro4FZwVJp5D36G8sXUWPzEKISdqukFYRsNGFGZKK4uTUB61nR1HB2RcX/RsksC5m
	xGzEOVzTfER2Jw5O8jONnDOpdJAOmF+4AkN/qBuSB3WzjRg7Kf5QQ3ueruj45ax0drWnxrnGIi73i
	nULu5iH1A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kD8fW-0002MD-F8; Tue, 01 Sep 2020 15:57:58 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kD8fT-0002Ke-0e
 for linux-nvme@merlin.infradead.org; Tue, 01 Sep 2020 15:57:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=JssZ/9cfFlKY9nXiXN1eWHNYfq2IqPkVO48PJ0G1HVM=; b=TsLN4Ki5H6wDqMT7EkDDmICR5s
 2ikY9tR6e67GKJEqjuS9L66bSUIo+pu5PYEAc9ljO3uyf6oMcNiepE5rzwUxhjE+/vnTmCPgENmda
 C0OeAfERJgyA7K8KeFysVlBHyF0BPeIG7el80V9O61CNCYuSKhfujxSQgjXJOjMOSEy03HwmPQuPh
 RJCdiSoEUrRAJIJ7z0BaLS8JSw/BmFlWFm/qiMtciExAsNyJHCr7Vvb8RIEQV1UW0Wnk6ZMFBndz3
 +EuD/g9pjFt/AGKn2OUIwLAq2rE5vGf6lWordEqx3jg+9VI6y7EPXjBeepMY6Nus8DQ6cZOSE4OGn
 R3KU2Xqg==;
Received: from [2001:4bb8:18c:45ba:2f95:e5:ca6b:9b4a] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kD8fR-0004Op-3n; Tue, 01 Sep 2020 15:57:53 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/9] block: don't clear bd_invalidated in
 check_disk_size_change
Date: Tue,  1 Sep 2020 17:57:41 +0200
Message-Id: <20200901155748.2884-3-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901155748.2884-1-hch@lst.de>
References: <20200901155748.2884-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: linux-raid@vger.kernel.org, linux-scsi@vger.kernel.org,
 "Martin K. Petersen" <martin.petersen@oracle.com>, linux-nvdimm@lists.01.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 Josef Bacik <josef@toxicpanda.com>, linux-block@vger.kernel.org,
 dm-devel@redhat.com, linux-fsdevel@vger.kernel.org,
 Dan Williams <dan.j.williams@intel.com>, nbd@other.debian.org,
 virtualization@lists.linux-foundation.org, ceph-devel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

bd_invalidated is set by check_disk_change or in add_disk to initiate a
partition scan.  Move it from check_disk_size_change which is called
from both revalidate_disk() and bdev_disk_changed() to only the latter,
as that is what is called from the block device open code (and nbd) to
deal with the bd_invalidated event.  revalidate_disk() on the other hand
is mostly used to propagate a size update from the gendisk to the block
device, which is entirely unrelated.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/block_dev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 08158bb2e76c85..2760292045c082 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1302,7 +1302,6 @@ static void check_disk_size_change(struct gendisk *disk,
 		}
 		i_size_write(bdev->bd_inode, disk_size);
 	}
-	bdev->bd_invalidated = 0;
 	spin_unlock(&bdev->bd_size_lock);
 
 	if (bdev_size > disk_size) {
@@ -1391,6 +1390,8 @@ int bdev_disk_changed(struct block_device *bdev, bool invalidate)
 
 	lockdep_assert_held(&bdev->bd_mutex);
 
+	bdev->bd_invalidated = 0;
+
 rescan:
 	ret = blk_drop_partitions(bdev);
 	if (ret)
-- 
2.28.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
