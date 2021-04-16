Return-Path: <SRS0=jca5=JN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C862C433B4
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Apr 2021 03:05:58 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11A83610FB
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Apr 2021 03:05:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11A83610FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=MkgupA+uH9yV93hBlCdbgwVkUjORJMr5IwjgsAWsQzg=; b=CUPBL5YKYJTbyqMvezVmpcAGh
	64q22zijo7ldIusMgOBjDoCd17TA80EtF+KUZxAjbaZ9bFGGsvup+EIpy6ObQxWCKix0vxaRNGonr
	9d+yi6Ebivkr0GO3bhP2nOHuFqw+BmkDWD/Qhc2mGYTeK5Q4O2/KctpmEIjbu+FHIt11mUjjMeyjZ
	bGJwBojia6MHpzYatqDqtYiCLFON7mESeICdXsdddsf1F4O184GY+UIzdJZTNUky/9NJ+vt7/HUIf
	G7kfVb+zfL49BiMZJFZtb4WbjpZOQ41XRvDd7vpE+FfcdOD6qJjqNOvNnfR7waJ6ylRNnzBiIvVsV
	riLVgR5Hw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lXEni-000aDN-NI; Fri, 16 Apr 2021 03:05:46 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lXEne-000aCN-B1
 for linux-nvme@desiato.infradead.org; Fri, 16 Apr 2021 03:05:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=xRknxLjyAwxP/jwiwS6qiRwG8feNmGb83zUJDcGO+ok=; b=jhhc/628X91Aa3awn9rlnaP/US
 a50e7P4fWbQn9LBoF7g2KBjZXKRQ9AncpfwKAVd0KAmN8Tk+BbKMP5hX3WvZ0pGigLweGhyRXiamR
 cKVg8PCAsy1qgtkMNMH87Q1GNIA8iX2sGYA4X2hOVocyhXX/Cgkcn2AlZdWMgEbJq7/tQDcRQqxKt
 rFASapqYeqjHY8bRCUPS6Iq9DTXrQaDQR5ios7cKYMNR6vB6U/AfTaibz6HpsNB/EPumi+JSxHSqc
 /m63XPTYI89TfMKODHQbQFhEYmpJ+egMopTwQhsrd+elV2XT6CNvxZRSeQPdisOl+2LddjdaPb5Dm
 P3LJwMlA==;
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lXEnb-0092yZ-Nq
 for linux-nvme@lists.infradead.org; Fri, 16 Apr 2021 03:05:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1618542339; x=1650078339;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=NwfKGSQILmjdwgHuwjMoyjbZ2rm26aZiGYIjk3FC6bk=;
 b=HenAnBuKwzPT3vffes0zj4b25PRqFm1g7zqk1lyTNG9MabkXlpRj37UW
 glMyoaS4PC0vh+pHXCIsmsCHJTANwebxPXuvDrMFRjaLWc2ezusCqgdsy
 Z+BWjRaS/rRLOiaVKH35692eLQ4Wo6QgVW7dQx/RgRVC1RTAnnKyJOuMO
 h1SMAPKoukVRo0sV2DkEruZBIRWM+YJbXGBlxql/CVKrtffDmnAKwMEs3
 /oO19RAoQ40PW5Up8o5zVwtqYFuS59mc3Hun/tsVk79rFNOqXlNGwfRlk
 XsbKSZ6L9QS8hTXZJb7s4eO8fmDJB7kDlrZp4ulibUgWAzuO474mXa4wy w==;
IronPort-SDR: z5Jc/Tu8/jndnmYq4qHUH4tmxehVfFP/bw19YoU3ehMXaVqtbw6ab2Aiaa2rI1EZxfF6ks+9Fu
 qqrhnvyLlr2fKgZM87KgURwByoVJoKi+P1esSD4QxJ83cpO15za5xu7EjNJRiRTp7vYJmFSFvI
 3shq2MhTEw9e70IDJD9OaOR8KDipQEgFkxP7eqewmQ84QmdvhZITE+7mI5qrgGE+0AjcCTZ95J
 7DXKc5FmxYQBpw3VrIU/bBlzU059bF8fj//rmtpRrgON+yYiyU2JinoHK3crm/OgTOiOMVU+RY
 yBg=
X-IronPort-AV: E=Sophos;i="5.82,226,1613404800"; d="scan'208";a="275938859"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 16 Apr 2021 11:05:36 +0800
IronPort-SDR: gK/DBV0u5xHd2oKBTspQKfz8UK/ZHmjVvJ3IpOJlRiFsb6N8AdSEDXxO8TVgKqLeGapa/n5nY/
 SmTohMiGp6UXnDbsRXPhFsbw7FwAMBHFZ8l8yluf3jNAF7xgxglitAZ6bEAK46e3+Mrs9Jg4DB
 bhNbWzmuwxoGH/lHcaAnNIKklo0SZLWEncfDaGOPSUVQOVnZAOxA70G/FQY5Z/IqSDvBHCBjLg
 1z32PrurL3TZf8YPzCoO6kgZb1MXiVy1lZDfX9cdvGmgI0AjCc+HKXS6r1qlyvHJXhU/VaMiP8
 1l6IjumZb4/ZR2EfjNZ7X533
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Apr 2021 19:46:27 -0700
IronPort-SDR: Uc9KTrW6k6VQOr13ItTIaG8m3FB4YcJF1CzR6j/OxyKZ6But3DAOGBk6j8DkP8U3UokM2KOgF7
 bp6T/GYt4q1nYRIGoeV5RTgAl77CZr4yaRyzL+yL5c7TyFo7XOWZXM7gQgHLK5gymIHR6nlCfR
 iHQyTFiLU5CBMsrjLAlzrcCNPhqBRWgObvhXD4wNc83bClCRUuptsE2Ssn/mOwjvp72nn7sUMn
 0nPclDz8ZKEhM3vTrOVPZRiOZ5yCYZucvpACEdx8vTk9aaFV6EM0QgE7PsLZTC2lmjJAhNKH16
 wXc=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
 by uls-op-cesaip02.wdc.com with ESMTP; 15 Apr 2021 20:05:32 -0700
From: Damien Le Moal <damien.lemoal@wdc.com>
To: dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>,
 linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 linux-scsi@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
 David Sterba <dsterba@suse.com>, Josef Bacik <josef@toxicpanda.com>
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 1/4] dm: Introduce zone append support control
Date: Fri, 16 Apr 2021 12:05:25 +0900
Message-Id: <20210416030528.757513-2-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210416030528.757513-1-damien.lemoal@wdc.com>
References: <20210416030528.757513-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210415_200539_810345_D3F352CF 
X-CRM114-Status: GOOD (  19.19  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Add the boolean field zone_append_not_supported to the dm_target
structure to allow a target implementing a zoned block device to
explicitly opt out from zone append (REQ_OP_ZONE_APPEND) operations
support. When set to true by the target constructor, the target device
queue limit max_zone_append_sectors is set to 0 in
dm_table_set_restrictions() so that users of the target (e.g. file
systems) can detect that the device cannot process zone append
operations.

Detection for the target support of zone append is done similarly to
the detection for other device features such as secure erase, using a
helper function. For zone append, the function
dm_table_supports_zone_append() is defined if CONFIG_BLK_DEV_ZONED is
enabled.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 drivers/md/dm-table.c         | 41 +++++++++++++++++++++++++++++++++++
 include/linux/device-mapper.h |  6 +++++
 2 files changed, 47 insertions(+)

diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index e5f0f1703c5d..9efd7a0ee27e 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -1999,6 +1999,37 @@ static int device_requires_stable_pages(struct dm_target *ti,
 	return blk_queue_stable_writes(q);
 }
 
+#ifdef CONFIG_BLK_DEV_ZONED
+static int device_not_zone_append_capable(struct dm_target *ti,
+					  struct dm_dev *dev, sector_t start,
+					  sector_t len, void *data)
+{
+	struct request_queue *q = bdev_get_queue(dev->bdev);
+
+	return !blk_queue_is_zoned(q) ||
+		!q->limits.max_zone_append_sectors;
+}
+
+static bool dm_table_supports_zone_append(struct dm_table *t)
+{
+	struct dm_target *ti;
+	unsigned int i;
+
+	for (i = 0; i < dm_table_get_num_targets(t); i++) {
+		ti = dm_table_get_target(t, i);
+
+		if (ti->zone_append_not_supported)
+			return false;
+
+		if (!ti->type->iterate_devices ||
+		    ti->type->iterate_devices(ti, device_not_zone_append_capable, NULL))
+			return false;
+	}
+
+	return true;
+}
+#endif
+
 void dm_table_set_restrictions(struct dm_table *t, struct request_queue *q,
 			       struct queue_limits *limits)
 {
@@ -2091,6 +2122,16 @@ void dm_table_set_restrictions(struct dm_table *t, struct request_queue *q,
 	if (blk_queue_is_zoned(q)) {
 		WARN_ON_ONCE(queue_is_mq(q));
 		q->nr_zones = blkdev_nr_zones(t->md->disk);
+
+		/*
+		 * All zoned devices support zone append by default. However,
+		 * some zoned targets (e.g. dm-crypt) cannot support this
+		 * operation. Check here if the target indicated the lack of
+		 * support for zone append and set max_zone_append_sectors to 0
+		 * in that case so that users (e.g. an FS) can detect this fact.
+		 */
+		if (!dm_table_supports_zone_append(t))
+			q->limits.max_zone_append_sectors = 0;
 	}
 #endif
 
diff --git a/include/linux/device-mapper.h b/include/linux/device-mapper.h
index 5c641f930caf..4da699add262 100644
--- a/include/linux/device-mapper.h
+++ b/include/linux/device-mapper.h
@@ -361,6 +361,12 @@ struct dm_target {
 	 * Set if we need to limit the number of in-flight bios when swapping.
 	 */
 	bool limit_swap_bios:1;
+
+	/*
+	 * Set if this target is a zoned device that cannot accept
+	 * zone append operations.
+	 */
+	bool zone_append_not_supported:1;
 };
 
 void *dm_per_bio_data(struct bio *bio, size_t data_size);
-- 
2.30.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
