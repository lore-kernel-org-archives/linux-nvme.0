Return-Path: <SRS0=XVsr=XL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 914DAC49ED7
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Sep 2019 15:44:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64D0F2184D
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Sep 2019 15:44:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uu+InmgY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64D0F2184D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=vfFADdrFURV72SuqMndbMABdWH6bv3Y9JVy1PDEBxi0=; b=uu+
	InmgYHwJL1lfgzCqA8zuBJN2v7/71kFFjjNvaeS2+uI4iDw2avrHkolW+1k2TcvPtWvcCPK5rHAhw
	bRWmNt2q3nstV08gBCqiV3TeYZgPg1ZQb+RbkoOq4Oobyz7ovNBHk0lh6DN/bngi5IGoKR0ulsCnw
	IFgtyqHq4W6Gztm3df8AMwjy+Ix6Z2VF+4qV4hc2+J5Ez//f3UdCIFSoqC7bZtypBh6zApqboGq4V
	nEUmPEPnNIfp9MSjg7se2EipFYFA0Z9BnONyY5+o0Ul3wT1MwXrmHuUHXPWtwImkHH1E1MVuRpV5B
	NZ5h8kQRDOZA5j4SFNgJX/t5fIMklAg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1i9tBL-00051C-KR; Mon, 16 Sep 2019 15:44:51 +0000
Received: from mail-il-dmz.mellanox.com ([193.47.165.129] helo=mellanox.co.il)
 by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
 id 1i9tB9-0004sW-7y
 for linux-nvme@lists.infradead.org; Mon, 16 Sep 2019 15:44:42 +0000
Received: from Internal Mail-Server by MTLPINE1 (envelope-from
 maxg@mellanox.com)
 with ESMTPS (AES256-SHA encrypted); 16 Sep 2019 18:44:31 +0300
Received: from r-vnc12.mtr.labs.mlnx (r-vnc12.mtr.labs.mlnx [10.208.0.12])
 by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x8GFiVxW010145;
 Mon, 16 Sep 2019 18:44:31 +0300
From: Max Gurtovoy <maxg@mellanox.com>
To: linux-block@vger.kernel.org, axboe@kernel.dk, martin.petersen@oracle.com, 
 linux-nvme@lists.infradead.org, keith.busch@intel.com, hch@lst.de,
 sagi@grimberg.me
Subject: [PATCH v7 1/2] block: use symbolic constants for t10_pi type
Date: Mon, 16 Sep 2019 18:44:28 +0300
Message-Id: <1568648669-5855-1-git-send-email-maxg@mellanox.com>
X-Mailer: git-send-email 1.7.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190916_084439_676974_68E94CF9 
X-CRM114-Status: UNSURE (   8.45  )
X-CRM114-Notice: Please train this message.
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
Cc: Max Gurtovoy <maxg@mellanox.com>, shlomin@mellanox.com,
 israelr@mellanox.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Replace all hard-coded values with T10_PI_TYPES to make the code more
readable.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
---

changes from v6:
 - added Reviewed-by signature
 - added commit message

changes from v5:
 - added Reviewed-by signature

---
 block/t10-pi.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/block/t10-pi.c b/block/t10-pi.c
index 0c00946..7fed587 100644
--- a/block/t10-pi.c
+++ b/block/t10-pi.c
@@ -27,7 +27,7 @@ static __be16 t10_pi_ip_fn(void *data, unsigned int len)
  * tag.
  */
 static blk_status_t t10_pi_generate(struct blk_integrity_iter *iter,
-		csum_fn *fn, unsigned int type)
+		csum_fn *fn, enum t10_dif_type type)
 {
 	unsigned int i;
 
@@ -37,7 +37,7 @@ static blk_status_t t10_pi_generate(struct blk_integrity_iter *iter,
 		pi->guard_tag = fn(iter->data_buf, iter->interval);
 		pi->app_tag = 0;
 
-		if (type == 1)
+		if (type == T10_PI_TYPE1_PROTECTION)
 			pi->ref_tag = cpu_to_be32(lower_32_bits(iter->seed));
 		else
 			pi->ref_tag = 0;
@@ -51,7 +51,7 @@ static blk_status_t t10_pi_generate(struct blk_integrity_iter *iter,
 }
 
 static blk_status_t t10_pi_verify(struct blk_integrity_iter *iter,
-		csum_fn *fn, unsigned int type)
+		csum_fn *fn, enum t10_dif_type type)
 {
 	unsigned int i;
 
@@ -60,8 +60,8 @@ static blk_status_t t10_pi_verify(struct blk_integrity_iter *iter,
 		__be16 csum;
 
 		switch (type) {
-		case 1:
-		case 2:
+		case T10_PI_TYPE1_PROTECTION:
+		case T10_PI_TYPE2_PROTECTION:
 			if (pi->app_tag == T10_PI_APP_ESCAPE)
 				goto next;
 
@@ -74,7 +74,7 @@ static blk_status_t t10_pi_verify(struct blk_integrity_iter *iter,
 				return BLK_STS_PROTECTION;
 			}
 			break;
-		case 3:
+		case T10_PI_TYPE3_PROTECTION:
 			if (pi->app_tag == T10_PI_APP_ESCAPE &&
 			    pi->ref_tag == T10_PI_REF_ESCAPE)
 				goto next;
@@ -102,42 +102,42 @@ static blk_status_t t10_pi_verify(struct blk_integrity_iter *iter,
 
 static blk_status_t t10_pi_type1_generate_crc(struct blk_integrity_iter *iter)
 {
-	return t10_pi_generate(iter, t10_pi_crc_fn, 1);
+	return t10_pi_generate(iter, t10_pi_crc_fn, T10_PI_TYPE1_PROTECTION);
 }
 
 static blk_status_t t10_pi_type1_generate_ip(struct blk_integrity_iter *iter)
 {
-	return t10_pi_generate(iter, t10_pi_ip_fn, 1);
+	return t10_pi_generate(iter, t10_pi_ip_fn, T10_PI_TYPE1_PROTECTION);
 }
 
 static blk_status_t t10_pi_type1_verify_crc(struct blk_integrity_iter *iter)
 {
-	return t10_pi_verify(iter, t10_pi_crc_fn, 1);
+	return t10_pi_verify(iter, t10_pi_crc_fn, T10_PI_TYPE1_PROTECTION);
 }
 
 static blk_status_t t10_pi_type1_verify_ip(struct blk_integrity_iter *iter)
 {
-	return t10_pi_verify(iter, t10_pi_ip_fn, 1);
+	return t10_pi_verify(iter, t10_pi_ip_fn, T10_PI_TYPE1_PROTECTION);
 }
 
 static blk_status_t t10_pi_type3_generate_crc(struct blk_integrity_iter *iter)
 {
-	return t10_pi_generate(iter, t10_pi_crc_fn, 3);
+	return t10_pi_generate(iter, t10_pi_crc_fn, T10_PI_TYPE3_PROTECTION);
 }
 
 static blk_status_t t10_pi_type3_generate_ip(struct blk_integrity_iter *iter)
 {
-	return t10_pi_generate(iter, t10_pi_ip_fn, 3);
+	return t10_pi_generate(iter, t10_pi_ip_fn, T10_PI_TYPE3_PROTECTION);
 }
 
 static blk_status_t t10_pi_type3_verify_crc(struct blk_integrity_iter *iter)
 {
-	return t10_pi_verify(iter, t10_pi_crc_fn, 3);
+	return t10_pi_verify(iter, t10_pi_crc_fn, T10_PI_TYPE3_PROTECTION);
 }
 
 static blk_status_t t10_pi_type3_verify_ip(struct blk_integrity_iter *iter)
 {
-	return t10_pi_verify(iter, t10_pi_ip_fn, 3);
+	return t10_pi_verify(iter, t10_pi_ip_fn, T10_PI_TYPE3_PROTECTION);
 }
 
 const struct blk_integrity_profile t10_pi_type1_crc = {
-- 
1.8.3.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
