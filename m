Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF0EBCCF9F8
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Nov 2025 01:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gGpVp0sf3RU5GWhA29muWWrRWsTN1swIechnc1zK6hA=; b=MejuFqmgNQi0mGOZ42rODqjY2K
	GAgVgIJ8W8k7tXxrOYAOsLbCFgy85COC96rX8qMVG61Zl4HmBZQi3OmLCPKuryxLSKgaa74szx22/
	YRuO4pF8dmhSi1SPBvmp/h2XPAsbDqQ6b1BWNZC4MMkxXgmn97ZsIxQn71nC9LiAmXqC/abjSuGLI
	5oN0zYyAio/r60mTQ6hXRx7/aDfRlIaH8ovoXzb1W77U9iNfT8I0CnScP/ZzSa7wG+kAjK2q3I5AI
	GTwWq70/lWWL2zuCUFg/m8PHNfALk2sl3T5JbCWuPSi3jTZSds1pzXNOCuxVfF06coQJZsMyMkZRY
	7K48fHyg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vG5xb-0000000AuDm-1Ixc;
	Tue, 04 Nov 2025 01:35:47 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vG5xZ-0000000AuCp-3aVC
	for linux-nvme@lists.infradead.org;
	Tue, 04 Nov 2025 01:35:45 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id F3165601DC;
	Tue,  4 Nov 2025 01:35:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33D69C4CEE7;
	Tue,  4 Nov 2025 01:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762220144;
	bh=9InpRURhYbB7IrlbGJubi87XDnqd+ozFRAai+B84hx0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=EjpmhH30VnLBivCc2tVh6vrvOF2LLaiSVWlByDGxUaGaI6vHURjCtIWhpcTkdaeua
	 JByC5SDjTfF8ZH1ccSBPaY4aGZQyF5iF2cnJ93H0f727EOMbxMINpnJQCdYBdCiNYM
	 Zky/uJnx/130sNM2iLTFQ1EhrwPgznLXCGl3GKGcXdm/lA0mDzklndRgby+8DBOcp4
	 Gps2CiuLInvk3e5pbO0/UNVBIFpiSxeQBXj3oGa9hwsqMo7Jmsasj3Zl1yvImXva3O
	 DbH3wwFitnDeXjz+Kq2BSTjzuHuhDnUe+A/Dbgclk9yesCiZT7vtWEK63uMiRIIqkE
	 VcNH2rBLFG5Mg==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Keith Busch <keith.busch@wdc.com>,
	Christoph Hellwig <hch@lst.de>,
	dm-devel@lists.linux.dev,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	Carlos Maiolino <cem@kernel.org>,
	linux-btrfs@vger.kernel.org,
	David Sterba <dsterba@suse.com>
Subject: [PATCH v3 03/15] block: cleanup blkdev_report_zones()
Date: Tue,  4 Nov 2025 10:31:35 +0900
Message-ID: <20251104013147.913802-4-dlemoal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251104013147.913802-1-dlemoal@kernel.org>
References: <20251104013147.913802-1-dlemoal@kernel.org>
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

The variable capacity is used only in one place and so can be removed
and get_capacity(disk) used directly instead.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 block/blk-zoned.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 39381f2b2e94..345a99c0b031 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -161,7 +161,6 @@ int blkdev_report_zones(struct block_device *bdev, sector_t sector,
 			unsigned int nr_zones, report_zones_cb cb, void *data)
 {
 	struct gendisk *disk = bdev->bd_disk;
-	sector_t capacity = get_capacity(disk);
 	struct disk_report_zones_cb_args args = {
 		.disk = disk,
 		.user_cb = cb,
@@ -171,7 +170,7 @@ int blkdev_report_zones(struct block_device *bdev, sector_t sector,
 	if (!bdev_is_zoned(bdev) || WARN_ON_ONCE(!disk->fops->report_zones))
 		return -EOPNOTSUPP;
 
-	if (!nr_zones || sector >= capacity)
+	if (!nr_zones || sector >= get_capacity(disk))
 		return 0;
 
 	return disk->fops->report_zones(disk, sector, nr_zones,
-- 
2.51.0


