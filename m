Return-Path: <SRS0=L2sc=BU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DD61C433DF
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2020 18:56:45 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38FB320774
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2020 18:56:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="3c7bs0dN";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="LcAzXy+3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38FB320774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=u3xIP5B4c28pUINNTH6R/gFzHVkvieQsQ7q1mfKYAFQ=; b=3c7bs0dNGtYz/jlEBw6eGX7BQ
	1na6CjKBDdYUGfILC7G9l2ZZjLdpcX/Q78WDUoy/56zP1aBq4xM2TrNGVJZFNRzEqbo+PP1RKP1YC
	PswOyZStvN1+gZYOrFTEaGEr4o2EcGQLarUZqsw0k0srYFx2u4KLHrK/nIsdL+h1Cmh594UUgctH9
	xy635dsPr9oZC+HRX5JiaNcUyqfFpXOakMn/uPqJGR11Idp4eQ46kVrwjoM/pNDFkZLpr8zvR+N+Q
	NGdvM57m6Z1FuwtIDPO2r/iSYvEFzqzWS5r+4rhtue2D9UK7NXlzLq3iPQm4vR2M+zhD0ETV+347k
	yIeUAziXA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k5CyP-0007Vk-V7; Mon, 10 Aug 2020 18:56:41 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k5CyK-0007Ru-7L
 for linux-nvme@lists.infradead.org; Mon, 10 Aug 2020 18:56:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1597085796; x=1628621796;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=rRzNWZMdz/OVTdfYH1/EiAkaa0hsxChPZSnQoNbf1ww=;
 b=LcAzXy+3o2iquvia5ph1bs7xWsXZK/aZ5dfFDjMTuPvJouZJ8jC1nrwW
 Asx2364FwgxUJBk2k3S5IA+vsTGYZqWGC62xv7Wod/M/DMde0x3b2fOKw
 9TURRfh8R9sb6G2D8ObdcxVSsp40muVXy/npCJSdwZjrL7oNt4mflEXzp
 WYyPufGE6oIY07OQHfvX+G7AmfLwf79oWUgWhUtKtyoX5FRYY9rWjQAaD
 q1Hf/o9Y4asuhMErjm2+LVxZCrQPnhYob0SvhEEFmkv7b06uP8mrpgmt8
 mjsEBWfrV2VAju/1710tXciKYf+HFhcEds/CXOJ02b1TjjV7KiBeiCK80 Q==;
IronPort-SDR: M+rVHVQKIZzvA5USxy56ftRN//O35cvvHIBLgFuOVBOqDAdUDayqxx0ciJGs8GHl5IuQr8qH2P
 5IH+iVQBWvxwVdmKiHNvNIJlWztfiolXAWDzm7KZ66gxCe0sVWouHzRuSGh4Riun8q6GJe1nFx
 rBRs3U2CXVHe8rrEm5V9fgYlsVNzPyBKqbzHK/Diz9pOHuvRvmzr5QpCeb0/uG0E4e11Mq27cr
 u3FArMDhaNpYvnDxUudQchDa/w3ByAYDkLNLG0ZNhOBlYLTgH1TAt0aCoUjAs0rj/T5stjGNej
 Z74=
X-IronPort-AV: E=Sophos;i="5.75,458,1589212800"; d="scan'208";a="144651278"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 11 Aug 2020 02:56:35 +0800
IronPort-SDR: 60cwVYrvIrD1yPYk7AiWD3MGXzE9Pl4XNIwja2Xp6uNwJYWrlwNfWIoknjA2WaKHvKlg83yShk
 APuLpom+4jkw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Aug 2020 11:43:46 -0700
IronPort-SDR: OCZuZwU1ACupqyKpE8nd8Qpq8pwxlORvEf2dDBUyxdhqv8cy47E4y1XmZ3LjY0/eKFpKJkHbCZ
 ayWeqYU1GPQA==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 10 Aug 2020 11:56:35 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 12/14] block: move blk_rq_bio_prep() to linux/blk-mq.h
Date: Mon, 10 Aug 2020 11:54:54 -0700
Message-Id: <20200810185456.7713-13-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20200810185456.7713-1-chaitanya.kulkarni@wdc.com>
References: <20200810185456.7713-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200810_145636_510164_D92FEF3F 
X-CRM114-Status: GOOD (  12.93  )
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
Cc: hch@lst.de, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

This is a preparation patch to have minimal block layer request bio
append functionality in the context of the NVMeOF Passthru driver which
falls in the fast path.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 block/blk.h            | 12 ------------
 include/linux/blk-mq.h | 12 ++++++++++++
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/block/blk.h b/block/blk.h
index 94f7c084f68f..cd107e60144c 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -96,18 +96,6 @@ static inline bool bvec_gap_to_prev(struct request_queue *q,
 	return __bvec_gap_to_prev(q, bprv, offset);
 }
 
-static inline void blk_rq_bio_prep(struct request *rq, struct bio *bio,
-		unsigned int nr_segs)
-{
-	rq->nr_phys_segments = nr_segs;
-	rq->__data_len = bio->bi_iter.bi_size;
-	rq->bio = rq->biotail = bio;
-	rq->ioprio = bio_prio(bio);
-
-	if (bio->bi_disk)
-		rq->rq_disk = bio->bi_disk;
-}
-
 #ifdef CONFIG_BLK_DEV_INTEGRITY
 void blk_flush_integrity(void);
 bool __bio_integrity_endio(struct bio *);
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 23230c1d031e..be7528231157 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -596,6 +596,18 @@ static inline void blk_mq_cleanup_rq(struct request *rq)
 		rq->q->mq_ops->cleanup_rq(rq);
 }
 
+static inline void blk_rq_bio_prep(struct request *rq, struct bio *bio,
+		unsigned int nr_segs)
+{
+	rq->nr_phys_segments = nr_segs;
+	rq->__data_len = bio->bi_iter.bi_size;
+	rq->bio = rq->biotail = bio;
+	rq->ioprio = bio_prio(bio);
+
+	if (bio->bi_disk)
+		rq->rq_disk = bio->bi_disk;
+}
+
 blk_qc_t blk_mq_submit_bio(struct bio *bio);
 
 #endif
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
