Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97673CD1284
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Apr 2024 04:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JraQsMfUZT7bMuLpwlCiys85ADO6dNegWZxRc6QGHBY=; b=Xhx+26ISOJiyZIJMWYj/16x4iN
	86/xdFlrHeY1Ri9mPoldFeGOFdlgO89+abmm5TEBzKYkTjm/sF4hRuTMT3sODMqvD+2RGChpK/T5h
	TWKfvsdx8/KxhiYcBD3ZgKn9HVKRJoCy+rXoe/35O7chlqFEPe7NeLGzpKgjAlrlvqLcqsmH36pEH
	kboBPhMgSSHO9Bd7+/guOirG2T2pgChPJIW0O61an84VGtViGFUWvpBhs6TDY1eGJIdZIL4TzMFbD
	dhn8FozruWoYNsMGZxot1giofETqbuSqsp9CWK6t1+7JtQrsJAdD/Z3Mf7+Mye/PQSfloXeJqCuow
	cuqmWGWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsbPh-00000005Bde-1ehE;
	Fri, 05 Apr 2024 04:42:53 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsbPL-00000005BCJ-0anx
	for linux-nvme@lists.infradead.org;
	Fri, 05 Apr 2024 04:42:36 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 9E5C3CE35EF;
	Fri,  5 Apr 2024 04:42:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21FB0C43390;
	Fri,  5 Apr 2024 04:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712292150;
	bh=+UsofTSRNCMlf94NYmjkPcbpOdXaDsiqajIToD4TkE4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ta6cMJY/NeXh0miQ+0OY7xXqshJoVs7GaZwqlNfiLa2Vlg4jrGn5LSQk5N+Fo+JWc
	 vwgBpDzCnEb7SCfdG7EgJLtObZtbb18mc+7Oj8Stpn+mgusx36Zp9/9SQOaTYQridY
	 X2AwvsuSkv8zX7PZCJI/w/m0qiiWtda5MW/HcEkkrJK08SaP9UXUmOHq1HbhyswylS
	 jgmnISVcAnfvflk2n6GkTCp3QZiuhgIDjZJzQcYcySzt/TASGdfDLsYKmyBhUcgmKN
	 CrIqTeRN7GcqBY/pBaFCUxtdgp0XcaA1uyiHWoq1GITf3n4LlQ4z/Rn9IVAxTi03Ec
	 SdKlkHettNYdg==
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
Subject: [PATCH v6 14/28] ublk_drv: Do not request ELEVATOR_F_ZBD_SEQ_WRITE elevator feature
Date: Fri,  5 Apr 2024 13:41:53 +0900
Message-ID: <20240405044207.1123462-15-dlemoal@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240405044207.1123462-1-dlemoal@kernel.org>
References: <20240405044207.1123462-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240404_214231_851642_A9C5E910 
X-CRM114-Status: GOOD (  12.16  )
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

With zone write plugging enabled at the block layer level, any zone
device can only ever see at most a single write operation per zone.
There is thus no need to request a block scheduler with strick per-zone
sequential write ordering control through the ELEVATOR_F_ZBD_SEQ_WRITE
feature. Removing this allows using a zoned ublk device with any
scheduler, including "none".

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Tested-by: Hans Holmberg <hans.holmberg@wdc.com>
---
 drivers/block/ublk_drv.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index bea3d5cf8a83..ab6af84e327c 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -249,8 +249,7 @@ static int ublk_dev_param_zoned_validate(const struct ublk_device *ub)
 static void ublk_dev_param_zoned_apply(struct ublk_device *ub)
 {
 	blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, ub->ub_disk->queue);
-	blk_queue_required_elevator_features(ub->ub_disk->queue,
-					     ELEVATOR_F_ZBD_SEQ_WRITE);
+
 	ub->ub_disk->nr_zones = ublk_get_nr_zones(ub);
 }
 
-- 
2.44.0


