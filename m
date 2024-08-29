Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73099C83F15
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Aug 2024 13:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:To:From:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=vvr7g01Sw9GYgNz0LoAAg4T3ibT+u+jm1p9VxTddzJ8=; b=ktuHwEuRkcqltC
	qCf6vE/6OqSSiOobQSJpPia/6CcYMVHuoSjnL5nxQmBVp/m7xVxlqB/WHkVRWJRPdONqBq9HXpiKw
	ZpbMYqiwWlbRof9oCGY4YL/+VL9+RFMwmKqsyuBlaT9thlFll7+FIIs7bNrfSAT7r53Oi/6bkyk8Z
	I4SP/DzyaMbav0DJZJ6cH+u21/+bKj+CmSM7K8KhAFVUbgVNtAhKn5QKAyWtkIPa2VVByVxN0z5i2
	8OIldJAnIs7jYRCG+sAT0rKPg3aAO07HP3xu+SnN25df8Hr8ILuArerNTXr0JSip0WUfSnU47kTlh
	He6ilHD263L5/62Gbbzg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjfGb-00000002CcS-16pA;
	Thu, 29 Aug 2024 13:32:49 +0000
Received: from smtp-fw-9102.amazon.com ([207.171.184.29])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjfGY-00000002CZP-1JwI
	for linux-nvme@lists.infradead.org;
	Thu, 29 Aug 2024 13:32:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1724938367; x=1756474367;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vvr7g01Sw9GYgNz0LoAAg4T3ibT+u+jm1p9VxTddzJ8=;
  b=tiF9xhltEt05JZ5ljbMehr0m/mOc3W5klckkVm0lQXKLkK+mBRctt/rc
   X+jTGSFsKMQjBJ0UzM5tvuln1OAhAOa2PMtkX63RLfhR2JcovgRuZYEhE
   n4XmS0bTyxacfAhSr/79SyejaDUI1xg9tY5tKQy5m21kJ0NUrFs52KSiz
   w=;
X-IronPort-AV: E=Sophos;i="6.10,185,1719878400"; 
   d="scan'208";a="448725231"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 13:32:38 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.7.35:31780]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.21.120:2525] with esmtp (Farcaster)
 id 52e6a62b-1635-4469-8507-9256d931fde3; Thu, 29 Aug 2024 13:32:36 +0000 (UTC)
X-Farcaster-Flow-ID: 52e6a62b-1635-4469-8507-9256d931fde3
Received: from EX19MTAUWA001.ant.amazon.com (10.250.64.218) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 29 Aug 2024 13:32:36 +0000
Received: from dev-dsk-pjy-1a-76bc80b3.eu-west-1.amazon.com (10.15.97.110) by
 mail-relay.amazon.com (10.250.64.204) with Microsoft SMTP Server id
 15.2.1258.34 via Frontend Transport; Thu, 29 Aug 2024 13:32:36 +0000
Received: by dev-dsk-pjy-1a-76bc80b3.eu-west-1.amazon.com (Postfix, from userid 22993570)
	id 0277A20836; Thu, 29 Aug 2024 13:32:35 +0000 (UTC)
From: Puranjay Mohan <pjy@amazon.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, "Christoph
 Hellwig" <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	<linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<puranjay@kernel.org>, <amazon-linux-kernel@amazon.com>
Subject: [PATCH v3] nvme: fix metadata handling in nvme-passthrough
Date: Thu, 29 Aug 2024 13:32:17 +0000
Message-ID: <20240829133217.1627-1-pjy@amazon.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240829_063246_422826_4341AF2A 
X-CRM114-Status: GOOD (  17.84  )
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
send an IO command with metadata through io-passthru. This allows issues
like [1] to trigger in the completion code path.
nvme_map_user_request() doesn't check if the namespace supports metadata
before sending it forward. It also allows admin commands with metadata to
be processed as it ignores metadata when bdev == NULL and may report
success.

Reject an IO command with metadata when the NVMe namespace doesn't
support it and reject an admin command if it has metadata.

[1] https://lore.kernel.org/all/mb61pcylvnym8.fsf@amazon.com/

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Puranjay Mohan <pjy@amazon.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>
---
V2: https://lore.kernel.org/all/20240827132327.1704-1-pjy@amazon.com/
Changes in V3
- Reject admin commands with metadata by also failing if there's no bdev

V1: https://lore.kernel.org/all/20240827121701.48792-1-pjy@amazon.com/
Changes in V2:
- Add a flag called 'has_metadata' and use it for the support check and
also for the check before calling bio_integrity_map_user()
---
 drivers/nvme/host/ioctl.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index f1d58e70933f..15c93ce07e26 100644
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
@@ -119,9 +120,14 @@ static int nvme_map_user_request(struct request *req, u64 ubuffer,
 	struct request_queue *q = req->q;
 	struct nvme_ns *ns = q->queuedata;
 	struct block_device *bdev = ns ? ns->disk->part0 : NULL;
+	bool supports_metadata = bdev && blk_get_integrity(bdev->bd_disk);
+	bool has_metadata = meta_buffer && meta_len;
 	struct bio *bio = NULL;
 	int ret;
 
+	if (has_metadata && !supports_metadata)
+		return -EINVAL;
+
 	if (ioucmd && (ioucmd->flags & IORING_URING_CMD_FIXED)) {
 		struct iov_iter iter;
 
@@ -143,15 +149,15 @@ static int nvme_map_user_request(struct request *req, u64 ubuffer,
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


