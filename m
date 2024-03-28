Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C6BCC47DD9
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Mar 2024 01:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xtKR/2gyWqlRruFZ/kGmRSqGpoIQJ3mta4C3fsIRGlI=; b=cSN9OSMTxk4BEXUA6fGUBfS0pi
	QFoAPpRORXT6hBjWXX7S20xuXzd5VekunlS9ZbYpHwNzB9ZxH7nZU4Y7qlUoN8BVYMCqo+NoUBeyG
	x/tys76HirPsQsv5SoeBJC4DqLwjHI1sKbJ9ZRFwBPyHDoIgy3NczmX5OPOt0O65pRBW5eSjw0hCr
	RlBOUwtoDf17wuD3K+q1P6TW44VJRK7CNt8RRJloJvbz+mQLJyULVoKdvrX32YkaUYddZOGrj+7aE
	8BIbFWQgjhuEPFJcKPvzmU5XotCFV0qohw4lNwjAJXKG9vGYFl9s9VeQf+YKkqXFi3QKCjjWxU/ZX
	4VhYdYGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpesb-0000000BzQU-3Mxi;
	Thu, 28 Mar 2024 01:48:33 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpdse-0000000BnPZ-2wrP
	for linux-nvme@lists.infradead.org;
	Thu, 28 Mar 2024 00:44:35 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id D517661718;
	Thu, 28 Mar 2024 00:44:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EB25C43394;
	Thu, 28 Mar 2024 00:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711586671;
	bh=67vW/LNmxZSLw/yk2h3NDIMn1MfJX7wyN/BwdoeFk2Q=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=GE6GtSlJyTAwhFKAFGL3ad49VhCRk8fO53UwpVSWlBEoYVvlnwtBJOjPGXqrjdBCP
	 /7Xf8BXVnAU243M972uN86UMEuk5OlF7djhm1kslOim6NBuF8rlxX1HvBgsqgYUuGm
	 lOb9cogEODxmISzgfoE49SyaPTaCCRqaTJgMgAPXitMxA8w5agkLH+QEjWe/eB8EiC
	 6QyXXxdQvoyij1ENtv3VQlN1RBfRFlCSWTNcAs6JyV6QGntTNSQ+hpJE/NMIF+a0tD
	 FbhzK/gKBTTYfID2zW9R9GbW3CoKIdVB4aS2wmZC7XggPXSTchexXN1evJmJUlTtvN
	 qA6zVGhqvnCkA==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	linux-scsi@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	dm-devel@lists.linux.dev,
	Mike Snitzer <snitzer@redhat.com>,
	linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v3 10/30] block: Fake max open zones limit when there is no limit
Date: Thu, 28 Mar 2024 09:43:49 +0900
Message-ID: <20240328004409.594888-11-dlemoal@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240328004409.594888-1-dlemoal@kernel.org>
References: <20240328004409.594888-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240327_174432_993556_BAC6B63E 
X-CRM114-Status: GOOD (  15.23  )
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

For a zoned block device that has no limit on the number of open zones
and no limit on the number of active zones, the zone write plug free
list is initialized with 128 zone write plugs. For such case, set the
device max_open_zones queue limit to this value to indicate to the user
the potential performance penalty that may happen when writing
simultaneously to more zones than the free list size.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 block/blk-zoned.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 3084dae5408e..8ad5d271d3f8 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -1570,17 +1570,24 @@ static int disk_revalidate_zone_resources(struct gendisk *disk,
 {
 	struct queue_limits *lim = &disk->queue->limits;
 	unsigned int max_nr_zwplugs;
+	bool set_max_open = false;
 	int ret;
 
 	/*
 	 * If the device has no limit on the maximum number of open and active
 	 * zones, use BLK_ZONE_DEFAULT_MAX_NR_WPLUGS for the maximum number
-	 * of zone write plugs to hash.
+	 * of zone write plugs to hash and set the max_open_zones queue limit
+	 * of the device to indicate to the user the number of pre-allocated
+	 * zone write plugsso that the user is aware of the potential
+	 * performance penalty for simultaneously writing to more zones than
+	 * this limit.
 	 */
 	max_nr_zwplugs = max(lim->max_open_zones, lim->max_active_zones);
-	if (!max_nr_zwplugs)
+	if (!max_nr_zwplugs) {
 		max_nr_zwplugs =
 			min(BLK_ZONE_DEFAULT_MAX_NR_WPLUGS, nr_zones);
+		set_max_open = true;
+	}
 
 	if (!disk->zone_wplugs_hash) {
 		ret = disk_alloc_zone_resources(disk, max_nr_zwplugs);
@@ -1596,6 +1603,9 @@ static int disk_revalidate_zone_resources(struct gendisk *disk,
 			return ret;
 	}
 
+	if (set_max_open)
+		disk_set_max_open_zones(disk, max_nr_zwplugs);
+
 	return 0;
 }
 
-- 
2.44.0


