Return-Path: <SRS0=ghx+=G7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6873C433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jan 2021 04:48:11 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A6F664DDA
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jan 2021 04:48:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A6F664DDA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=1OFuElIbl/I394EimYyh32LF6inDT4J7nTNo5A5Qe80=; b=ilp0wrzPQuT1iVmQItPBV++E9
	zV2/+hGnRQnBYMTRc7WcNm6AJGj9i/TpqZwzGlTGJX/EINV5XRMc+9MIn1CA9bKZB9e+lIasME6TR
	f9bXcuBlGV9mLaHdxftGlJrqqhXTJApdiIq/SEmihj/sGvABSHUYhJiyovbddUX7a2RWUVMKyfUUk
	8ilmRGOUDHlhCCcEYTsavcIiJT2cFdZ2QUPDUcCQOjCyo77NdAHguiDm2sTj6gpkRGo3Gd85Ln3iv
	ceQudhu+KrHVSeZKNy28dctzVJ7EqJgfGAtCSm+wP0eyxoADhWRVW/9B/e7NCJ0tu2e8C7Rnx09e4
	Bxj9l1AYA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l4zE0-0002EQ-BS; Thu, 28 Jan 2021 04:48:08 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l4zDf-00025x-AU
 for linux-nvme@lists.infradead.org; Thu, 28 Jan 2021 04:47:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1611809267; x=1643345267;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=To8ibe4IoXLbKNtSVr85Y+rPsQgn0MZHdGIA9grMAlY=;
 b=jRhGd7++a5VMyWxqLecVujygQ8LY1Db5N2KGv8awxKvsxyhkD7s3T8Ky
 r/9udmvrhbLV5/u4zP1caBHA7ORqGtdtqzCQtbZMXL2pQfx+w3Z88RVwq
 qStOmjIUchFg88rs/tzKIOwKFQq7XCoQCcyw2YtWP68PQb+XKrbLixT1H
 Kq4cps93jh11ZCyY1bIiOV0AWm6+D1/omAfM25RANoejh3Ob+lR5OQa5f
 S9PNoXhldlrpDTj+rJpjelYj3YwJovtf5H91iR3puziu87SEIojIRHYg8
 lfZhBXQlAeGUwf1/o5lznkWOin0Q8fDqqV2pyLUai268Hul93/vLk+YlM Q==;
IronPort-SDR: xAKFKx6BWuQbCnan9YS/84/HES08dkcihHo4zAudkpRgiTUoSM3Cv9hly04jZzv+wRItFRmMZg
 rdnLm8W7OuV/xfiD+++iEnrJtgPfvys38KNrESSNk+VSklCOpqAMVPK39fG4Alj2dQ/7cP7W/N
 XACgr/cbWqvpoRMz+/E2NxIfchOcKBk3rslb6aCVklTSZi1WU4OQL5HJ9dtXN3bp/gG1ESMgsm
 fZa2O4yr8iXMrTDitVONG0jvbEIgfzBbeJTJwGN/vHnEEnHOLhqBsNYJpx/KEXr3wBIuz41+wI
 QmA=
X-IronPort-AV: E=Sophos;i="5.79,381,1602518400"; d="scan'208";a="158509637"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 28 Jan 2021 12:47:47 +0800
IronPort-SDR: BxZ8r5oOpnp5X/fFecJP2IfTUk3o5TpRvzt/DugLoUm+cy7wzZChVc+xmY1ztazCAvzUzQM93X
 Vfzyfq62rRD0C0r1UFJhmTkIgr2QDln1RZPwly0y4EdrKqy9ZtFCvnndnRSJvJSFWYWYB0c+10
 G7jcOK41kgDXIDM6NJ6bU3Sj9jE5KXg8vuHlJc1ke/PZVWNmmjmXDglbmfQK5JC59TSvXapy8O
 TJFLv6USrRpbzVx01ALxc7KzXsf0fPhCnCs1jM8/d4BBwhFw9Hcv/7bq4sd8PDq8eG3BSVx2Gm
 RVu1Rfq1PCgWoEHjxKZhxxj2
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jan 2021 20:32:07 -0800
IronPort-SDR: kgqL13pGkC8QABIy4e6bYHJfwv9FlTi5e0mJkrgoRIiurS/qlobH/8gLRvVFaW2WqnXxqAx0Zk
 X1xIeQcLXveAeTMlasw9QF9po0Xl1/JmRVWjPqXx/LMqeXisQUsKKLWvTzwXJoeHpQ/4EL6KW0
 FwVwB5RH6c8vow0S5BXbHszwhzUvco0p2cKlowbRu58yxbUvzTwJIFzkJwTI1MwQdqmntJeFZY
 7/OH+3s/0PkTZM79M+d9+Oc3Oz586aak3QVemcPXkEKBJlwuBrhpp6S9b2bPVlR7/Cjl79oxwc
 bMg=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
 by uls-op-cesaip01.wdc.com with ESMTP; 27 Jan 2021 20:47:45 -0800
From: Damien Le Moal <damien.lemoal@wdc.com>
To: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v4 7/8] block: introduce blk_queue_clear_zone_settings()
Date: Thu, 28 Jan 2021 13:47:32 +0900
Message-Id: <20210128044733.503606-8-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210128044733.503606-1-damien.lemoal@wdc.com>
References: <20210128044733.503606-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210127_234747_706334_57BB9F71 
X-CRM114-Status: GOOD (  13.35  )
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

Introduce the internal function blk_queue_clear_zone_settings() to
cleanup all limits and resources related to zoned block devices. This
new function is called from blk_queue_set_zoned() when a disk zoned
model is set to BLK_ZONED_NONE. This particular case can happens when a
partition is created on a host-aware scsi disk.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 block/blk-settings.c |  2 ++
 block/blk-zoned.c    | 17 +++++++++++++++++
 block/blk.h          |  2 ++
 3 files changed, 21 insertions(+)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index a1e66165adcf..7dd8be314ac6 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -910,6 +910,8 @@ void blk_queue_set_zoned(struct gendisk *disk, enum blk_zoned_model model)
 		 */
 		blk_queue_zone_write_granularity(q,
 						queue_logical_block_size(q));
+	} else {
+		blk_queue_clear_zone_settings(q);
 	}
 }
 EXPORT_SYMBOL_GPL(blk_queue_set_zoned);
diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 7a68b6e4300c..833978c02e60 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -549,3 +549,20 @@ int blk_revalidate_disk_zones(struct gendisk *disk,
 	return ret;
 }
 EXPORT_SYMBOL_GPL(blk_revalidate_disk_zones);
+
+void blk_queue_clear_zone_settings(struct request_queue *q)
+{
+	blk_mq_freeze_queue(q);
+
+	blk_queue_free_zone_bitmaps(q);
+	blk_queue_flag_clear(QUEUE_FLAG_ZONE_RESETALL, q);
+	q->required_elevator_features &= ~ELEVATOR_F_ZBD_SEQ_WRITE;
+	q->nr_zones = 0;
+	q->max_open_zones = 0;
+	q->max_active_zones = 0;
+	q->limits.chunk_sectors = 0;
+	q->limits.zone_write_granularity = 0;
+	q->limits.max_zone_append_sectors = 0;
+
+	blk_mq_unfreeze_queue(q);
+}
diff --git a/block/blk.h b/block/blk.h
index 0198335c5838..977d79a0d99a 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -333,8 +333,10 @@ struct bio *blk_next_bio(struct bio *bio, unsigned int nr_pages, gfp_t gfp);
 
 #ifdef CONFIG_BLK_DEV_ZONED
 void blk_queue_free_zone_bitmaps(struct request_queue *q);
+void blk_queue_clear_zone_settings(struct request_queue *q);
 #else
 static inline void blk_queue_free_zone_bitmaps(struct request_queue *q) {}
+static inline void blk_queue_clear_zone_settings(struct request_queue *q) {}
 #endif
 
 int blk_alloc_devt(struct block_device *part, dev_t *devt);
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
