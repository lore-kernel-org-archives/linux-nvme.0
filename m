Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F090EC54734
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Aug 2024 13:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:To:From:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=62szxidneznjILbAIpV8/I7PRmxZEtb/XE12nVr2RDA=; b=yJBVMprQ/k+evI
	29Isa1ktBcUSElj2ps64MguLjVam+nTYiWro2SAuPSbjJ0gE3hHmBIFz8GMrpOtVL4QsBPJ0g0fVd
	5IIcV/DM/wIxQEPxVJjdrmB9NXDMcQE8QMIYfHoq3Zml34CeJ4dN1SItV/SdiMkQIXAvlEDOok6MB
	qXIQWDINrpDxVyjI7KgVgyBWYSv5bHWWooF6NHPx7Y4mZ4OIWJhzUxLCjkoNvSfNAMBxdgMg94MpV
	hxtB1+LUwBC6dm7YpTJ0H44Zv3ps8Mhr2QUdo3Q2DhPe7R8yG3vLpCEO8mfjtBdgFl0b5cC2cEaeY
	3QOQ4dAXyym12FzHbc3g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1siwAb-0000000BRDH-2z5w;
	Tue, 27 Aug 2024 13:23:37 +0000
Received: from smtp-fw-52002.amazon.com ([52.119.213.150])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1siwAY-0000000BRBN-0iE6
	for linux-nvme@lists.infradead.org;
	Tue, 27 Aug 2024 13:23:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1724765015; x=1756301015;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=62szxidneznjILbAIpV8/I7PRmxZEtb/XE12nVr2RDA=;
  b=ag+wjooHwOmxJyH/r+2tjKzr57dhpcRm2nSaH/KymEgzonw/2GH9gvCZ
   8bx3NfuaHNUWWRGr+J2rxtqmPghSAwwNbIOCXX/C72qnPbebyMP/WYUcL
   N8Y7GU9cqmmTLm/NGVbSUkEu46x17VpYpVPGtoaIoGwYVAYnh/deKoXGk
   s=;
X-IronPort-AV: E=Sophos;i="6.10,180,1719878400"; 
   d="scan'208";a="655093382"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 13:23:31 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:30580]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.20.83:2525] with esmtp (Farcaster)
 id 992ff484-32b4-404e-8bfe-5b8840fc9acd; Tue, 27 Aug 2024 13:23:30 +0000 (UTC)
X-Farcaster-Flow-ID: 992ff484-32b4-404e-8bfe-5b8840fc9acd
Received: from EX19MTAUWA001.ant.amazon.com (10.250.64.218) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 27 Aug 2024 13:23:29 +0000
Received: from dev-dsk-pjy-1a-76bc80b3.eu-west-1.amazon.com (10.15.97.110) by
 mail-relay.amazon.com (10.250.64.204) with Microsoft SMTP Server id
 15.2.1258.34 via Frontend Transport; Tue, 27 Aug 2024 13:23:29 +0000
Received: by dev-dsk-pjy-1a-76bc80b3.eu-west-1.amazon.com (Postfix, from userid 22993570)
	id 536B320A60; Tue, 27 Aug 2024 13:23:29 +0000 (UTC)
From: Puranjay Mohan <pjy@amazon.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph
 Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	<linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<puranjay@kernel.org>
Subject: [PATCH v2] nvme: check if the namespace supports metadata in nvme_map_user_request()
Date: Tue, 27 Aug 2024 13:23:27 +0000
Message-ID: <20240827132327.1704-1-pjy@amazon.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240827_062334_399290_0937B0C6 
X-CRM114-Status: GOOD (  16.96  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On an NVMe namespace that does not support metadata, it is possible to
send an IO command with metadata through io-passthru.
nvme_map_user_request() doesn't check if the namespace supports metadata
before sending it forward.

Reject an IO command with metadata when the NVMe namespace doesn't
support it.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Puranjay Mohan <pjy@amazon.com>
---
V1: https://lore.kernel.org/all/20240827121701.48792-1-pjy@amazon.com/
Changes in V2:
- Add a flag called 'has_metadata' and use it for the support check and
also for the check before calling bio_integrity_map_user()
---
 drivers/nvme/host/ioctl.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index f1d58e70933f..74d963d425c4 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -4,6 +4,7 @@
  * Copyright (c) 2017-2021 Christoph Hellwig.
  */
 #include <linux/bio-integrity.h>
+#include <linux/blk-integrity.h>
 #include <linux/ptrace.h>	/* for force_successful_syscall_return */
 #include <linux/nvme_ioctl.h>
 #include <linux/io_uring/cmd.h>
@@ -119,9 +120,13 @@ static int nvme_map_user_request(struct request *req, u64 ubuffer,
 	struct request_queue *q = req->q;
 	struct nvme_ns *ns = q->queuedata;
 	struct block_device *bdev = ns ? ns->disk->part0 : NULL;
+	bool has_metadata = bdev && meta_buffer && meta_len;
 	struct bio *bio = NULL;
 	int ret;
 
+	if (has_metadata && !blk_get_integrity(bdev->bd_disk))
+		return -EINVAL;
+
 	if (ioucmd && (ioucmd->flags & IORING_URING_CMD_FIXED)) {
 		struct iov_iter iter;
 
@@ -143,15 +148,15 @@ static int nvme_map_user_request(struct request *req, u64 ubuffer,
 		goto out;
 
 	bio = req->bio;
-	if (bdev) {
+	if (bdev)
 		bio_set_dev(bio, bdev);
-		if (meta_buffer && meta_len) {
-			ret = bio_integrity_map_user(bio, meta_buffer, meta_len,
-						     meta_seed);
-			if (ret)
-				goto out_unmap;
-			req->cmd_flags |= REQ_INTEGRITY;
-		}
+
+	if (has_metadata) {
+		ret = bio_integrity_map_user(bio, meta_buffer, meta_len,
+					     meta_seed);
+		if (ret)
+			goto out_unmap;
+		req->cmd_flags |= REQ_INTEGRITY;
 	}
 
 	return ret;
-- 
2.40.1


