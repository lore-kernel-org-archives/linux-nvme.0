Return-Path: <SRS0=5twQ=XA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B96ACC43331
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Sep 2019 16:44:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79B9A2067B
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Sep 2019 16:44:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QSxEHxD8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79B9A2067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=xwtNittTBmsxe3cwKr7sTf3DY5o5QlxBM4ys9niMfdM=; b=QSxEHxD8st82q4ylAg8KwMMrmp
	wLpepqB6oD/fcxr1SVSTfIjOR4ILsPYKKfZYaAGQEbdFNto/NNL3IoPNpREU/c5QtawyyaNWi8zXp
	+fwmf0sd71MP5+QFDzkW1dP6EwAS7VLDsPuh3LmTmin2GSJPlO4LLAnSWpwVKVmD5xr/WaP7z1qZY
	3Zrz26zzhOHyj3K42BYGwT/azxf5EBBl8r9CQyk/lYBkexXOa50j8jRNWSZsuQrZnnAzpYT3NjWkf
	biHPtXGkMNkznwNWHMZUN6wUTdPc/Fnhh+IbCkXjCS7zfx2n3A/aCLO1WbSsFmadd3rS+nnmTM/g2
	v6vDm+7w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i5uri-0005iZ-5j; Thu, 05 Sep 2019 16:44:10 +0000
Received: from mail-il-dmz.mellanox.com ([193.47.165.129] helo=mellanox.co.il)
 by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
 id 1i5urf-0005bM-Gh
 for linux-nvme@lists.infradead.org; Thu, 05 Sep 2019 16:44:09 +0000
Received: from Internal Mail-Server by MTLPINE1 (envelope-from
 maxg@mellanox.com)
 with ESMTPS (AES256-SHA encrypted); 5 Sep 2019 19:43:57 +0300
Received: from r-vnc12.mtr.labs.mlnx (r-vnc12.mtr.labs.mlnx [10.208.0.12])
 by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x85Ghux3018224;
 Thu, 5 Sep 2019 19:43:56 +0300
From: Max Gurtovoy <maxg@mellanox.com>
To: linux-block@vger.kernel.org, axboe@kernel.dk, martin.petersen@oracle.com, 
 linux-nvme@lists.infradead.org, keith.busch@intel.com, hch@lst.de,
 sagi@grimberg.me
Subject: [PATCH 2/3] block: don't remap ref tag for T10 PI type 0
Date: Thu,  5 Sep 2019 19:43:55 +0300
Message-Id: <1567701836-29725-2-git-send-email-maxg@mellanox.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1567701836-29725-1-git-send-email-maxg@mellanox.com>
References: <1567701836-29725-1-git-send-email-maxg@mellanox.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190905_094407_953303_A0194BBB 
X-CRM114-Status: UNSURE (   7.95  )
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

Only type 1 and type 2 have a reference tag by definition.

Suggested-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
---
 block/t10-pi.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/block/t10-pi.c b/block/t10-pi.c
index 7d9a151..088c3c7 100644
--- a/block/t10-pi.c
+++ b/block/t10-pi.c
@@ -178,7 +178,7 @@ static blk_status_t t10_pi_type3_verify_ip(struct blk_integrity_iter *iter)
  * likely to be different. Remap protection information to match the
  * physical LBA.
  *
- * Type 3 does not have a reference tag so no remapping is required.
+ * Types 0 and 3 don't have a reference tag so no remapping is required.
  */
 void t10_pi_prepare(struct request *rq)
 {
@@ -186,7 +186,8 @@ void t10_pi_prepare(struct request *rq)
 	u32 ref_tag = t10_pi_ref_tag(rq);
 	struct bio *bio;
 
-	if (rq->rq_disk->protection_type == T10_PI_TYPE3_PROTECTION)
+	if (rq->rq_disk->protection_type == T10_PI_TYPE0_PROTECTION ||
+	    rq->rq_disk->protection_type == T10_PI_TYPE3_PROTECTION)
 		return;
 
 	__rq_for_each_bio(bio, rq) {
@@ -234,7 +235,7 @@ void t10_pi_prepare(struct request *rq)
  * to the device, we should remap it back to virtual values expected by the
  * block layer.
  *
- * Type 3 does not have a reference tag so no remapping is required.
+ * Types 0 and 3 don't have a reference tag so no remapping is required.
  */
 void t10_pi_complete(struct request *rq, unsigned int nr_bytes)
 {
@@ -243,7 +244,8 @@ void t10_pi_complete(struct request *rq, unsigned int nr_bytes)
 	u32 ref_tag = t10_pi_ref_tag(rq);
 	struct bio *bio;
 
-	if (rq->rq_disk->protection_type == T10_PI_TYPE3_PROTECTION)
+	if (rq->rq_disk->protection_type == T10_PI_TYPE0_PROTECTION ||
+	    rq->rq_disk->protection_type == T10_PI_TYPE3_PROTECTION)
 		return;
 
 	__rq_for_each_bio(bio, rq) {
-- 
1.8.3.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
