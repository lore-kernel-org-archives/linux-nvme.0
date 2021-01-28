Return-Path: <SRS0=ghx+=G7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92CECC433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jan 2021 04:47:56 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3442464DD8
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jan 2021 04:47:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3442464DD8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=CH7e8ZZyynEiHXYf8vxRoQOZlwBMexkBT0gxxcusKVA=; b=PT2eQiumjsfaFS2xUddKHlYT1
	naS4nuL5I7+DB4XQcV0mIN+3Eo2SsqoDeIGOpoSJDpu027Bx+FIfszrHycp8G/zTY1k7SY8VE79aP
	asQQ+5m5KUKfKMKsYe3C0kNouGZFi+vEYpMUxOGW6Wqp2UQ8J1oSdRILKx3OVMp83K1vQGL3qQcen
	1MOsJdD9Tj1JMfbKnaKB/6Idu4Ipwcc+YecYKAfLNi6F90Cz2n1KUrq+Zlyj+hFliMSUOOKbiV0y6
	JhOjdpntXhNQWHna9apQSOCOiWZ25fhwY6BevGwRQhlE5g3uqMJRyoQI67xNATt8oGxv0dzhAaTCq
	JSMqcChrA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l4zDi-00028d-IT; Thu, 28 Jan 2021 04:47:50 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l4zDZ-00024w-E2
 for linux-nvme@lists.infradead.org; Thu, 28 Jan 2021 04:47:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1611809261; x=1643345261;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=YobZghyNsgskNB+fC+I1GvLwxiefgtnuuC0Tcp7ryyI=;
 b=L7todierLVtw2IiSOfn9jHq7dlFmIkh2lKSs7FB21fmeapciFIA/uY6b
 INpHH7l0xA5nmk10jwwtxrzq5Ci2Emr8QdTMMn5XD4ss81D99tm1OKmA3
 I9F1c3qRn6zLzRoRJhyvlJ9xqnez98wZbfx68IqB3OYPredrubhvHnyoV
 3eqDR6F3M+6gHW6qx9r8tqIzNobJ+daWOpuMI1TkCEypvCPk/qNJ+wZiE
 w5FAtUD0rm0NlEu3VZoVd9qk1a5lH9w18laTApT3wV51s87HtBp48DtyE
 XaoR+UGVLWNMrCqGJ47hewHstsY1RabyOl43ukjqr8qR93d9482l+BT1S w==;
IronPort-SDR: nmylbDMN6TaMot3RCA8Aa1/F1qRpjQvagPd6YgXvAHdGiRB+5ECYLxsAy2dzH4rDVAe4qjb5Jz
 YuP00d4C3PlB8oiVlWhfh3q3L3sZXe2XzYcZ9SierLY5twyrZNvNOQsRoettqnEHUVwlw2WwNJ
 lDvbVj04uWN4Ikt9FP+Y6bhbqp/SfwWoLKkAEe2X8RO4zGYGqaOIxzaT1PUiBydZ8Sh3a/TCyi
 jiUalcmq6+KRyEiolTKyKzJ1qxSlfAuce6BDDCcC986rL6Zen9+ulXU5NTUE0+ftWouxkukdgh
 tks=
X-IronPort-AV: E=Sophos;i="5.79,381,1602518400"; d="scan'208";a="158509624"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 28 Jan 2021 12:47:40 +0800
IronPort-SDR: nhgCxw1SrAqhfRx5jMdpvSJrqQpf7Z8tuWMPhZiSultKCeGy0skLHGntPRgoQ0OOBoh39A9tjg
 Hzz4HLYWsIvqrwjqakm5S4UT93WAbVBzbX5vSG4vKimW8uQZseOHp7zVq1FUq9khaBM/eschnt
 7zu97s7OoR/SgpVXUjJ1LMoy/3KDjt8vz95CF8ZndGnTCTeF5LIfqQuaMvt//0F7rbwysyaKFI
 crBeJIvdBhIJD1Pn0JAWw3K3gmIg14/joBigIFbTn7XRaOOunsEhqcidp314955FN7n9V0uUkh
 2KLXHiMt9CZrao0oV7DzV5S2
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jan 2021 20:32:01 -0800
IronPort-SDR: 9RcohAp9AMgU5B7rQIxsmbG4uch5GxDip1QD1xSnMBIuPmFlTmbHioiPbNRL2EDa/fBYDWBb08
 f9Q4NGR3usz6Ez9dTU6cRvCiM/DaUVDZz55/Dq2niCiGulwBXt9Q5eJjpwoF9ZRmGKkECu7Fly
 wUG9p3+HrZa0On4ZF0ntny/L7BWLJKixVz/R5j4b1xwAe4delg5B2v9/Yv4AbKTaM+FnN9KZMi
 9C1jqkMK2sq/P8NliAxdm6KzkwU9IMtTQK5eYWvsLALI9vUiWJuk6i8f5306kiBEX3ElOf2Wlk
 3iQ=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
 by uls-op-cesaip01.wdc.com with ESMTP; 27 Jan 2021 20:47:39 -0800
From: Damien Le Moal <damien.lemoal@wdc.com>
To: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v4 3/8] nullb: use blk_queue_set_zoned() to setup zoned devices
Date: Thu, 28 Jan 2021 13:47:28 +0900
Message-Id: <20210128044733.503606-4-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210128044733.503606-1-damien.lemoal@wdc.com>
References: <20210128044733.503606-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210127_234741_599876_F9FC6B40 
X-CRM114-Status: GOOD (  12.69  )
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

Use blk_queue_set_zoned() to set a nullb device zone model instead of
directly assigning the device queue zoned limit. This initialization of
the devicve zoned model as well as the setup of the queue flag
QUEUE_FLAG_ZONE_RESETALL and of the device queue elevator feature are
moved from null_init_zoned_dev() to null_register_zoned_dev() so that
the initialization of the queue limits is done when the gendisk of the
nullb device is available.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 drivers/block/null_blk/zoned.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/block/null_blk/zoned.c b/drivers/block/null_blk/zoned.c
index 148b871f263b..78cae8703dcf 100644
--- a/drivers/block/null_blk/zoned.c
+++ b/drivers/block/null_blk/zoned.c
@@ -146,10 +146,6 @@ int null_init_zoned_dev(struct nullb_device *dev, struct request_queue *q)
 		sector += dev->zone_size_sects;
 	}
 
-	q->limits.zoned = BLK_ZONED_HM;
-	blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, q);
-	blk_queue_required_elevator_features(q, ELEVATOR_F_ZBD_SEQ_WRITE);
-
 	return 0;
 }
 
@@ -158,6 +154,10 @@ int null_register_zoned_dev(struct nullb *nullb)
 	struct nullb_device *dev = nullb->dev;
 	struct request_queue *q = nullb->q;
 
+	blk_queue_set_zoned(nullb->disk, BLK_ZONED_HM);
+	blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, q);
+	blk_queue_required_elevator_features(q, ELEVATOR_F_ZBD_SEQ_WRITE);
+
 	if (queue_is_mq(q)) {
 		int ret = blk_revalidate_disk_zones(nullb->disk, NULL);
 
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
