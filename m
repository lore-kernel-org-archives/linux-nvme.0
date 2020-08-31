Return-Path: <SRS0=W+Vz=CJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D7BC433E2
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Aug 2020 22:28:19 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD0C2207EA
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Aug 2020 22:28:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rgkcbZVa";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="kx+rY/wu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD0C2207EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=xBWJ/pTPMNgM9vEFublEF/4XnVCNDvOSQGMbqoo43f0=; b=rgkcbZVazm8uD0xn5y8D3D1n8
	G8KhwUzwSBnE/kruJk0JgCOUtH6fw8eemUAkK1Cf04luCwAzhe6vjZIwGVCbgTo2HmjMOl6W3QA1O
	DNX084EoKXuL4DhRqnrNh7h29rzLkirj+1j4S8VAt0riqRMXovWtphFmHb70b7BVyzioPOsZh3wPX
	M6dV72c1N2sdgnKOxeVPhsWI8SsKTaxj3JAvHSNUSd+xM4XfKrp38aZH0IAybwIzz7IfW7z0vQ+8n
	tGB5QKnNhYY0FrsHjvSjTc+UIO+6lVsn0D0gulBG2htoCjFMu0V1T2swF6Ug7Ci1E4zZxqmzvcjXC
	TChXzuS1g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kCsHe-0005oc-MO; Mon, 31 Aug 2020 22:28:14 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kCsHK-0005Vg-QP
 for linux-nvme@lists.infradead.org; Mon, 31 Aug 2020 22:27:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1598912875; x=1630448875;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Q1Kpgqtdq24Fc/VtkKNNkcb6HRIhJEzDeRKVF04OCUs=;
 b=kx+rY/wuNciinhlv2ZbRNgbX450/k975FnerTTK0YQzBt6VN24jRBIZR
 V+ji6TvUotc6LcjXgi5v42l/S1VziUG4mBRI4+W64VUg8BF6faxwoYhJM
 czEZuPFJ2SUH1Gx1WWb2NtqNWx0Iy1V5Rhjx8rDwNKQEC2vmnUyJzk/VN
 ukDQ8l2tHr35sUwj4jBBHoj2y8jmDlwLXeUjVd/GQnd27qh3t+Nv6K4/3
 aD7z6Gsg/6+svHWsmLaLC8gFUkJM0b7fuHFt6kGo2Go6U/7xls52M9yVY
 wWotiqN7bsvc1VudhcKh1v0JTv8qTE6SBuYjJaWFmV/ciXFPF9tDK6Uoi Q==;
IronPort-SDR: Fx+9qbgnIFIUrQhjxik/Ze7BmLxcd1vdUj2rf7G+UvSVzRCzWwVcb2rI2eQ39ydbCi04Vxu2io
 0wZPPIwwyktAXmkoQQB5dHLtpEHjXlkkLR/Sv/4Mp5l8V5fuYYqck/7j7FJLGFojb6ZgZbYumY
 DnVkXDuxRKuuZb5apx4InYAftSCov3P5GG+O/WvKBvh9C8Mrh0UzxgxjV9ha91dE8deK8OqwLC
 9gCnAmzjB3fhrYC+fwjsmgBBw/WAOuSd+Xj3W5TyYBaPGgrSSDEkxJIgW5Fj6CHhUqlUWzP+KR
 pRQ=
X-IronPort-AV: E=Sophos;i="5.76,376,1592841600"; d="scan'208";a="147482873"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 01 Sep 2020 06:27:55 +0800
IronPort-SDR: M8hgI4M6AU1vknxfmAKIf81bIGwGUvgsV21lllTYgXrRoHfMYkPPNC4ubt4Hg+YMis5anbQGIt
 cnC2xAEcwF2Q==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2020 15:15:22 -0700
IronPort-SDR: jCWDOeG8VNNMn/1A7PHC+lIgFWNlpGzbog+NaBmsh8KtslXARQFRbK13lPx9r7NJFjxXbXCuN4
 iop8YCcsKFpQ==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 31 Aug 2020 15:27:54 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V2 10/12] block: move blk_rq_bio_prep() to linux/blk-mq.h
Date: Mon, 31 Aug 2020 15:27:05 -0700
Message-Id: <20200831222707.35611-11-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20200831222707.35611-1-chaitanya.kulkarni@wdc.com>
References: <20200831222707.35611-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200831_182755_072126_48FE18D7 
X-CRM114-Status: GOOD (  14.25  )
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
Cc: kbusch@kernel.org, logang@deltatee.com, hch@lst.de,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

This is a preparation patch to have minimal block layer request bio
append functionality in the context of the NVMeOF Passthru driver which
falls in the fast path and doesn't need calls from blk_rq_append_bio().

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
---
 block/blk.h            | 12 ------------
 include/linux/blk-mq.h | 12 ++++++++++++
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/block/blk.h b/block/blk.h
index 49e2928a1632..6f60b39fc6a8 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -91,18 +91,6 @@ static inline bool bvec_gap_to_prev(struct request_queue *q,
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
index 9d2d5ad367a4..02b211e39b25 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -582,6 +582,18 @@ static inline void blk_mq_cleanup_rq(struct request *rq)
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
