Return-Path: <SRS0=ghx+=G7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A51C433E6
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jan 2021 04:48:17 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8B7260235
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jan 2021 04:48:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8B7260235
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=J5KeBUaxvm1E3sEl+IxXGLE2zrqV7sK8oypmnJ8N4d4=; b=k8uGxmtS/Nug3385cC+vIP9cV
	2NBYw6KuCGPjXtoPI1AG6UxCDzXpbCmL+4ikSpAkW+x8+sWjN7I6o08MZ0JS+vHNCVPqMYbS57JNZ
	8eQ0hpnT90IO2ZRIfb193jLFcW5dg4fZmo16QsN2MkO2mhf4qb1WarVk85A7kqC/pqV+Mj2j52fdm
	GyEOlKC1u3qwim0XiZDLaQKlprC46FXSau7bPDsRosdZy4eLuhwS6fM22SdlSoBPeD+tVbFEURqnm
	dDjGsjj3myxE2PGl4ySFgL9+dCFiUuRNwKfBFzkpE+Dwd8JoHS6//CeoJqbOm8D/BJGDdwt6jeWHb
	K3/Z2oURQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l4zE3-0002Ft-CQ; Thu, 28 Jan 2021 04:48:11 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l4zDh-00026W-4Q
 for linux-nvme@lists.infradead.org; Thu, 28 Jan 2021 04:47:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1611809269; x=1643345269;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=EKhsyGUiAPT9iVQna/YmfrtwycQGpAjmcTYD4lMXNEs=;
 b=l2D5hAPkvyaXOZp06TubWIHiCI9ZR5/Q35vKY78ZE8LlVD3Z7fHLJszI
 R/AxE9Np3okdIfrWLP/ZubXGKe4Ip3FAyIiXeYL/Vg/logtO4WwqvVUnB
 sGQpgb2JtTDVViEkG0zKN0OBFhX7tG7KqD1my0Jk9bIeHkfp2+nn6Ia8o
 TSqaXUR9555pwM6dVzjCBFNdLV03Sqdi1kCNLixZiA98dAxVFg7O3w6ZI
 h0xRb49VOWHG7Id6GncR5QzBaqbmoZhGog+lunM4ARmC2IiDD1hMpG2aW
 9VAFxAQuQr0hlzVxnJL2E+U9kTJ07MGz/OV+eYeg/RKMKIoZaOXYAJgyv A==;
IronPort-SDR: c4IrC5+zXIVGZzEIaoOjsVQaNozry5f61CVbgrBm6ZI+TN4I5VvOz2SZcUoFBdsQrmlIinvypq
 vmn8ix/BcHucS/jKUQFEZG2lY7rCQXxBNXO0Lwp0jl2RCUHe2lhIIMaTRBui7ZHZpxFhXoq3T1
 8wSzE+Ryx/FoygWOvPcPfy9HhGWFjOs6Uz36yQRRtqTIFv2VEa2XXiQfwmBA+x70FogC8Pe5S/
 nkhqKwE1P94c/uS+hpHNStTY2AlhXL7x4nx12gLw3vBCPihv8J12kn8NU01ch1bR2wuF92+3SY
 V7A=
X-IronPort-AV: E=Sophos;i="5.79,381,1602518400"; d="scan'208";a="158509639"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 28 Jan 2021 12:47:48 +0800
IronPort-SDR: 23iGO9tGkMaMvYTAMlW4ekgDEh3mYGltYZJufikQ2zDEv8PBQDb/rBfJiBx3qTL3U8p1M9NiK2
 dTdvS2Ee2mk/KebQH+ALT2FmTVoEK9Qp8Fax9JzBQMcSPN1wMWPkNp5zdrVlFRusQ65ab2rUeB
 Kl2s3gdvS2k/12wgVZMIZz3FE4LlHwGd+aYeZdHAYEugL7pxJtvCTPMycHDUCvBQ6wPeOWKgh2
 Pwbsltx7CazOGwXsFPtiUo6PFwq0aJiLNoP2jPXpA7GlWNAbWdAZ+fGCwgtqIeipLzMK/ObsO5
 YdXdwOX6GZEDOC21yhMAALpI
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jan 2021 20:32:09 -0800
IronPort-SDR: knyvuuTglsAK3pbOeeqHjtips90rfYXAkh0tF9qiqV8q622wCBoNmRVWyT4smvYPHCxcmQW8Nv
 5n/7SR1uTfIc1B7bD3bC3dHb/4kWkp4ClLXSY+Ols9XKvR92VtUEyUEDwgyPw9Ptq3Sri5d0Eb
 mMBGu1ItA6JFERgoKHOrFitedPGVM89nDfpFO/smM+lfQcRTNrq+w0sS5bEsdovt5rr6arFNBX
 OPfmdQMrczo2Wnp8wPeuFBfoYFjYLXKj1DbOOBxX+EzO1WuCANQcdrTSCliTIrl3luDlpFezyn
 LKI=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
 by uls-op-cesaip01.wdc.com with ESMTP; 27 Jan 2021 20:47:47 -0800
From: Damien Le Moal <damien.lemoal@wdc.com>
To: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v4 8/8] sd_zbc: clear zone resources for non-zoned case
Date: Thu, 28 Jan 2021 13:47:33 +0900
Message-Id: <20210128044733.503606-9-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210128044733.503606-1-damien.lemoal@wdc.com>
References: <20210128044733.503606-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210127_234749_446429_A1187C14 
X-CRM114-Status: GOOD (  18.80  )
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
Cc: Keith Busch <keith.busch@wdc.com>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

For host-aware ZBC disk, setting the device zoned model to BLK_ZONED_HA
using blk_queue_set_zoned() in sd_read_block_characteristics() may
result in the block device effective zoned model to be "none"
(BLK_ZONED_NONE) if partitions are present on the device. In this case,
sd_zbc_read_zones() should not setup the zone related queue limits for
the disk so that the device limits and configuration is consistent with
a regular disk and resources not uselessly allocated (e.g. the zone
write pointer tracking array for zone append emulation).

Furthermore, if the disk zoned model changes at run time due to the
creation of a partition by the user, the zone related resources can be
released.

Fix both problems by introducing the function sd_zbc_clear_zone_info()
to reset the scsi disk zone information and free resources and by
returning early in sd_zbc_read_zones() for a block device that has a
zoned model equal to BLK_ZONED_NONE.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 drivers/scsi/sd_zbc.c | 37 ++++++++++++++++++++++++++++++++-----
 1 file changed, 32 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/sd_zbc.c b/drivers/scsi/sd_zbc.c
index 8293b29584b3..03adb39293c2 100644
--- a/drivers/scsi/sd_zbc.c
+++ b/drivers/scsi/sd_zbc.c
@@ -665,12 +665,28 @@ static int sd_zbc_init_disk(struct scsi_disk *sdkp)
 	return 0;
 }
 
-void sd_zbc_release_disk(struct scsi_disk *sdkp)
+static void sd_zbc_clear_zone_info(struct scsi_disk *sdkp)
 {
+	/* Serialize against revalidate zones */
+	mutex_lock(&sdkp->rev_mutex);
+
 	kvfree(sdkp->zones_wp_offset);
 	sdkp->zones_wp_offset = NULL;
 	kfree(sdkp->zone_wp_update_buf);
 	sdkp->zone_wp_update_buf = NULL;
+
+	sdkp->nr_zones = 0;
+	sdkp->rev_nr_zones = 0;
+	sdkp->zone_blocks = 0;
+	sdkp->rev_zone_blocks = 0;
+
+	mutex_unlock(&sdkp->rev_mutex);
+}
+
+void sd_zbc_release_disk(struct scsi_disk *sdkp)
+{
+	if (sd_is_zoned(sdkp))
+		sd_zbc_clear_zone_info(sdkp);
 }
 
 static void sd_zbc_revalidate_zones_cb(struct gendisk *disk)
@@ -769,6 +785,21 @@ int sd_zbc_read_zones(struct scsi_disk *sdkp, unsigned char *buf)
 		 */
 		return 0;
 
+	/* READ16/WRITE16 is mandatory for ZBC disks */
+	sdkp->device->use_16_for_rw = 1;
+	sdkp->device->use_10_for_rw = 0;
+
+	if (!blk_queue_is_zoned(q)) {
+		/*
+		 * This can happen for a host aware disk with partitions.
+		 * The block device zone information was already cleared
+		 * by blk_queue_set_zoned(). Only clear the scsi disk zone
+		 * information and exit early.
+		 */
+		sd_zbc_clear_zone_info(sdkp);
+		return 0;
+	}
+
 	/* Check zoned block device characteristics (unconstrained reads) */
 	ret = sd_zbc_check_zoned_characteristics(sdkp, buf);
 	if (ret)
@@ -797,10 +828,6 @@ int sd_zbc_read_zones(struct scsi_disk *sdkp, unsigned char *buf)
 	if (blk_queue_zoned_model(q) == BLK_ZONED_HM)
 		blk_queue_zone_write_granularity(q, sdkp->physical_block_size);
 
-	/* READ16/WRITE16 is mandatory for ZBC disks */
-	sdkp->device->use_16_for_rw = 1;
-	sdkp->device->use_10_for_rw = 0;
-
 	sdkp->rev_nr_zones = nr_zones;
 	sdkp->rev_zone_blocks = zone_blocks;
 
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
