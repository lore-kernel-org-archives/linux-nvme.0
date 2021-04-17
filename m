Return-Path: <SRS0=qGt+=JO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B9CEC433B4
	for <linux-nvme@archiver.kernel.org>; Sat, 17 Apr 2021 02:34:26 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9953C61107
	for <linux-nvme@archiver.kernel.org>; Sat, 17 Apr 2021 02:34:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9953C61107
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=/dLQQxfg04m6SxE0Jrurq6wEDWZKnFxkpwveu72UKXM=; b=MlwA186sLeCiYVv9b7wJ7YBMe
	dvMvdIXGwmrjhv6RBKqi1rffJMaGb8xqg2DQ8ud7YTbiEOyCUcKY79aX/MY4uMXYkfdE0/ekGtJu2
	QIs0ieitO4bHxkY1KFhd2uYItbU1y2vRvfYIsMrwaBYhGfUEUBftWeI+0KONoGhs13F4jeRYnax3h
	7rH5VP8jwHaJ6JMGNE3VLs6qPpCK49j2soY5pjQRdAIm3fFg/fdU9NJ3fmhigyJHWMm1QDBq79Xdb
	Iz1jLPf0gnSmd4bcqjSk8R35FlnK3hOxEiCOTmVCt0kshqyPA/TbyCd+HhJE/OdNze/mdvDfdnRw2
	grV1FeGxQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lXamF-0045lZ-QF; Sat, 17 Apr 2021 02:33:44 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lXam7-0045kF-Pq
 for linux-nvme@desiato.infradead.org; Sat, 17 Apr 2021 02:33:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=HGEOxgLbx9h2Du54c7sYWSZ5IVr8lY801iHsraNjmJs=; b=NOMWmJ4Ag5ds7zfB17+knXc2J0
 bFT1+HqMd1MEXt03WhZgcUQWBuMBNC2Mh5fJfuS3pI2xkkYDBoUXVb5AofrY7/g0K/1Enaa6iA3fJ
 lyCdtu0i/+7cpOnWrSGzJnxmfeVhcd0xduSzJ4S7890TsizAtmyi5B1Z48WhrJGk4TLSHgO+z9/gl
 GNSuGW7lyANo3MCAzgHN18zbnhZmBx17V+q2GzWcrjhd6Aaw3TZk5q57sgk0B9KF7RznVQBJ1JrBM
 fOgYTFfaoHhgzM8+0jVtHyo9NF89F+/QYnzI0QtsTXyzt9uLWtH4VEC9wVuedMCeh2Mp44O+jP0Xw
 vALMH7dw==;
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lXam2-009pkE-Bf
 for linux-nvme@lists.infradead.org; Sat, 17 Apr 2021 02:33:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1618626810; x=1650162810;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=M2olJXYeF+UIjCTOBygvjDqf/S+qS1mKqstmI3YoyAQ=;
 b=jakr+LJe6xPBev36xIA3V81huhK0ZPEmLVHQH8RI833iwKdA4xSC3BMQ
 PXEL0zbFksU6iPrc9g8YyqUBjIWIWLiLiJ4J5tL9Y+/OxNmM6reRhGAkB
 ZIufKE27zOL1aFxYVpPPHqTmBNa2GQCEe9KiS+MW30YR2mGB1ZETObrJs
 yrSyVxkz+8bweGDPlmzVrkg+gCNOsMeR1+S0nyKuZHwfNgY2C8gQ9xaeR
 4OoBV1H1axM2m46u/LmU/PN8Xu5tMeFvApopO7awgjWiXj7AasKTVpqOx
 10ukYbHHdE/Uc+YLQDLhNTjSPSW0xUFM2noj3MXzkNYKMNIRkqbYSEZSB Q==;
IronPort-SDR: 0JYziiGDEJ88Ksd7uaiaIomalCir+cxyCyFjeUyu5UpJCwmYPxTeBVOtRQVGZWgyK7ky2xvhNZ
 Xn7IwN8HJetL84eXSgwjPWiTgafg7A8Jtieuu1AUYlu0iocGeWRwy7TbXK+uSoQi6f79ppymLy
 r5FYqtYbyQHMx4wCqnIt68a41oNoK74vB8azaleMCBBHMqnA+iIQqeNcsp/XPKsPNFQTrBrkkA
 5SjKsdyXPnKSj1o1wqyQEpBAxcTvyLDqJgBGx2vVEzgZO3PcC8ysfurDnynzIJVRNMQIj17e0N
 UwU=
X-IronPort-AV: E=Sophos;i="5.82,228,1613404800"; d="scan'208";a="276118889"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 17 Apr 2021 10:33:28 +0800
IronPort-SDR: BcwhBnOl+c5Nrv5CKruJrFAapu4GVbDeAOr/50+LNlLIxpF4zYHIESl0Dge+UiLkS+WwFEpOTf
 TDhIb3o6NihDPmdE/KzrRbpfgkDWQ+083+d7es5WdxUqZKt68Ip4HDLQ9GQoRkG394t8lZnSRk
 j7+lJDGFEr7ZZ0vvNpqE6+VVP21llQhQfpqDNiNsbWwono9pwjgbvBAaB5cMv6l2k1piAlypD8
 +qCinKPbw2KTwgKjMM4eV5UhuDyAplhXUz0ImTrBNwjMJG7RHRm2HxZ9u7CHCL1O2t3wS8SQSk
 FLh4uWI+qrPM9/tdbS1FpOqv
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Apr 2021 19:12:41 -0700
IronPort-SDR: UQflehws6aKDT+mFZ2nVQiUGb2lRUwWiMuBTx9jxGjceks+o06GOUReKHZ5fkVXjt7Kj5B/CZy
 Mp0Ws+qZfN+7WYGWYst3lEYumdIWJKlDCPxHvhR3q+AOWEUrWg4EIcgZ9stY6RgD8+AuNB0WNW
 xHduyhNolA7A+ImExw3mcQc08lDB9cUDyKFHP0pqsXMA73uC5RH42QEgfkZ4eBaL6/Q078vJpu
 wh5OcUneAqZuDkBjpm6TDPxIE0bhp4yo+cURINauqGwoe8qeHV11jqbhnar9TCvep01s+iLBkl
 cKw=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
 by uls-op-cesaip01.wdc.com with ESMTP; 16 Apr 2021 19:33:27 -0700
From: Damien Le Moal <damien.lemoal@wdc.com>
To: dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>,
 linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 linux-scsi@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-fsdevel@vger.kernel.org
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH v2 1/3] dm: Introduce zone append support control
Date: Sat, 17 Apr 2021 11:33:21 +0900
Message-Id: <20210417023323.852530-2-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210417023323.852530-1-damien.lemoal@wdc.com>
References: <20210417023323.852530-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210416_193330_431571_5A3EAAFA 
X-CRM114-Status: GOOD (  19.08  )
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

Fixes: 8e225f04d2dd ("dm crypt: Enable zoned block device support")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
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
