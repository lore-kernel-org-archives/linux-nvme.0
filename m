Return-Path: <SRS0=v579=XM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14C43C4CEC9
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Sep 2019 18:52:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0A52206C2
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Sep 2019 18:52:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KaZipL6E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0A52206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=i98zx2BQCP27cLhhcUw84QvEyDVhpUxVkIU0sO1GtTo=; b=KaZ
	ipL6EP/5XIQdWzHqJVlg1MbNxwqbd/Cf15j8RbZ5Mk8byYNSmJqsSK5/Sd7Fg1n4MO7UTkr3M5Fkh
	9+hKPzzg2QMKLntTvmKFfZl73NOFXQJADPJNwRY9KTwlFs34+o9yGRgkL+QehmtA3YLanMFjBUBom
	2HdiWmmTC+HAonYBVdKc5aQC25+2AWKyLqfWF6+YTjNalEv0T1GhFE/OuMB5BnJzsQvp373kdy8IF
	asIKdThC4sB/FUCUOrUzH3p4MK49W5fcLKPd0r2mK7WRQFwfiGM7hCTa2Kh+q1dY+cdk7QUMemqg8
	feHtbDXKEWDlgTGadIMdVgnIe4Gs5VQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iAIaA-00028w-Sq; Tue, 17 Sep 2019 18:52:10 +0000
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iAIa8-00028S-AZ
 for linux-nvme@lists.infradead.org; Tue, 17 Sep 2019 18:52:09 +0000
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 971313091755;
 Tue, 17 Sep 2019 18:52:06 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-122-42.rdu2.redhat.com
 [10.10.122.42])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DF43D1001B11;
 Tue, 17 Sep 2019 18:52:05 +0000 (UTC)
From: John Pittman <jpittman@redhat.com>
To: hch@lst.de
Subject: [PATCH] nvmet: change ppl to lpp
Date: Tue, 17 Sep 2019 14:52:00 -0400
Message-Id: <20190917185200.24292-1-jpittman@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Tue, 17 Sep 2019 18:52:06 +0000 (UTC)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190917_115208_389818_EAE203A8 
X-CRM114-Status: GOOD (  12.88  )
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
Cc: John Pittman <jpittman@redhat.com>, sagi@grimberg.me,
 linux-nvme@lists.infradead.org, bvanassche@asm.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

In nvmet_bdev_set_limits() the number of logical blocks per
physical block is calculated, but the opposite is mentioned in
the associated comment and reflected in the variable name. Correct
the comment and adjust the variable name to reflect the calculation
done.

Signed-off-by: John Pittman <jpittman@redhat.com>
---
 drivers/nvme/target/io-cmd-bdev.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index de0bff70ebb6..32008d85172b 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -11,10 +11,10 @@
 void nvmet_bdev_set_limits(struct block_device *bdev, struct nvme_id_ns *id)
 {
 	const struct queue_limits *ql = &bdev_get_queue(bdev)->limits;
-	/* Number of physical blocks per logical block. */
-	const u32 ppl = ql->physical_block_size / ql->logical_block_size;
-	/* Physical blocks per logical block, 0's based. */
-	const __le16 ppl0b = to0based(ppl);
+	/* Number of logical blocks per physical block. */
+	const u32 lpp = ql->physical_block_size / ql->logical_block_size;
+	/* Logical blocks per physical block, 0's based. */
+	const __le16 lpp0b = to0based(lpp);
 
 	/*
 	 * For NVMe 1.2 and later, bit 1 indicates that the fields NAWUN,
@@ -25,9 +25,9 @@ void nvmet_bdev_set_limits(struct block_device *bdev, struct nvme_id_ns *id)
 	 * field from the identify controller data structure should be used.
 	 */
 	id->nsfeat |= 1 << 1;
-	id->nawun = ppl0b;
-	id->nawupf = ppl0b;
-	id->nacwu = ppl0b;
+	id->nawun = lpp0b;
+	id->nawupf = lpp0b;
+	id->nacwu = lpp0b;
 
 	/*
 	 * Bit 4 indicates that the fields NPWG, NPWA, NPDG, NPDA, and
@@ -36,7 +36,7 @@ void nvmet_bdev_set_limits(struct block_device *bdev, struct nvme_id_ns *id)
 	 */
 	id->nsfeat |= 1 << 4;
 	/* NPWG = Namespace Preferred Write Granularity. 0's based */
-	id->npwg = ppl0b;
+	id->npwg = lpp0b;
 	/* NPWA = Namespace Preferred Write Alignment. 0's based */
 	id->npwa = id->npwg;
 	/* NPDG = Namespace Preferred Deallocate Granularity. 0's based */
-- 
2.17.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
