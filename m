Return-Path: <SRS0=JPfP=EQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2175C4741F
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Nov 2020 02:24:52 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64FD2206C0
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Nov 2020 02:24:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ojbc2pS0";
	dkim=permerror (0-bit key) header.d=wdc.com header.i=@wdc.com header.b="bZuHU2q7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64FD2206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=LkSJaOXnhc0rloJLXIgQJKqD+8v+hroy8TTceH3oJTA=; b=ojbc2pS0DGuT3Lk3lX4RgfQ6v
	8I16POeO0BD5VywugC32NfE+Rhk/tRbRnXw4r8D/Mn0CSg4RjoSbzQBZjHsW/XXvPlkXRML+LS1PA
	9NtxINEU654GPatJtwOZUbFlZn6XWv5hIC6PRGsRovLMVYqDJ5TlDjlDivy6F5l9Rh2tg7hSp99LR
	wa6zR/7jyt09SjYrGW6wmUu3ifQpiyWkXkOa2dIox9PhetK7fVp9z4LNMjXgirEp5re15v852orj9
	+mUVa/4gf9296EKKzFh0Vv5v4pPqxSLB9yYpAGcxK3/sjokPyIUiIDJ3tCYCGC0wVnGBm9q20YdJa
	6eIx5BN1g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kcJKx-0006HC-Ct; Tue, 10 Nov 2020 02:24:47 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kcJKo-0006BZ-Gn
 for linux-nvme@lists.infradead.org; Tue, 10 Nov 2020 02:24:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1604975778; x=1636511778;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=/RfTDNkwgpWkWBDLqJjIjFnT/dbeT/R3kr2Wn8mjMuQ=;
 b=bZuHU2q7iZFlBuAk64IFHUraENSGIraa8uffx6ZSFl4lV49vnnADvzzH
 OLuSvuNnA/7g+mEf/zpTTAscyEJHrTytRaGKqQDCgg6top7Kf+YyOTCbl
 WYUjrD46HH3EhG6gm/TMaVFaK/zyXVN8N5+f8GXlz4t8yVwVqu8A97Hmd
 LJQ1Df6g7rpDrzSWyv7lnvFZNJry0OUkTA6o89kT/A9gUUJumpSnscXZV
 4PkUWsZBxVeqrSAk+8s1YU7s8hqOHj5yvUVdSdbsh2lFQa+ynWrrQA6Tj
 oqkxYOxCfP2LAhBYMWRylCak+gF86euGLWKlJFKKPY3TyuJhLpiB2Mr/h w==;
IronPort-SDR: l/wsRoYb4c5GDh0bmg4EKIThr+BsZen8mX7m/N5sL2BnKcUkSGtgXKk1uZu7+elhZ+Fesa8yoL
 xz8CcSeHF/xB8XmEU3fD26XOicn5AKwvLiggoclZr3xmrelypRIB3a3eqZCWnOwPzeWFXoeBBK
 1mdSNGFAtL7PUKIYYtncoiNJW7PupifnjV1hDINFH/ic36ohBzYXx6skMMePKafsf8RYEwrgd6
 rz0cHLbHHoWyEQUgOgVH/rqaZPtjhG39JMTY0cCgEr0MdcauUQuiaJQ8+ZtQ0xHiXlKO+m9mwB
 g28=
X-IronPort-AV: E=Sophos;i="5.77,465,1596470400"; d="scan'208";a="255796344"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 10 Nov 2020 10:36:15 +0800
IronPort-SDR: rzSULTwBTwP12dRkHHZEkQwl8AjyIGz9Ckx+q4RJOVbGggql4Ynnl+HpOf9wT0UO1X9AfpkeYA
 vm01mNcEqr0uuYY/baRt3929LhLKRzs9cTyue0T/LXNKE3wQ4Wqg27vCXSTEUzYkFWPqF62cat
 /T0z152kICSb/yCb8ad49Q6uyETwqlfPFX5f3rl9oDrJNrhCDx1mVJjjabddebzKdPzNGZ006a
 GokGaIJgF9qNlZCFE8L2xW7xivCUmsL016BJxs8nBPbgpz4rCkCNZD3Lmr4P2M7eIYg7ENpZqI
 np3BAvU5836vuIq/6GQlX4eH
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2020 18:10:37 -0800
IronPort-SDR: fDganRMlCaQp3MSRVYAu8NWNLjqdHtujaw/NaGfjGAdpEVDU3gDumfmKd8N38DXOACk3t+iLy+
 ELUxRGG5cOedh6rH8wzXVq+NcDF8zy0y1/uUrl/pSF6OSqJEaX9LPsu8p89nrME4LSSuH+ee2c
 l97/rkz1j7rjRe9iQubX32xfgXXEovRQYlx7fQwULRbuvgi160JiDLuMriN7ZZvGiCAzpM8Lw3
 pRm5x96I+AlYVePekG6YOAPLtuiXJR2xNfhtrDD+A2SosNC4b55RZCx2tavOFhYVlyDS5TN44C
 6dk=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 09 Nov 2020 18:24:35 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: [PATCH V4 4/6] block: move blk_rq_bio_prep() to linux/blk-mq.h
Date: Mon,  9 Nov 2020 18:24:03 -0800
Message-Id: <20201110022405.6707-5-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201110022405.6707-1-chaitanya.kulkarni@wdc.com>
References: <20201110022405.6707-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201109_212438_778952_585876EA 
X-CRM114-Status: GOOD (  12.08  )
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
Cc: axboe@kernel.dk, sagi@grimberg.me,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, kbusch@kernel.org,
 Logan Gunthorpe <logang@deltatee.com>, hch@lst.de
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
index dfab98465db9..e05507a8d1e3 100644
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
index b23eeca4d677..d1d277073761 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -591,6 +591,18 @@ static inline void blk_mq_cleanup_rq(struct request *rq)
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
