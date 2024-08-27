Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1818C54734
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Aug 2024 12:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:To:From:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=dZafkTBMgG7yzSjlIbdpVuKXbZLWp3xe1QfVap/dPy0=; b=ALDoOQETzpbYQt
	o1SHYfRslDQkOrIrgghCev1C51szIgfmU3/xvfY+32e5tNGSnvqn0j5hNRgJMXdguu+n+fOZkHrEQ
	kEai+I/XlNlWKSQBgXpBys/YIygIjONiUNPxWuvzSucS1XJMqKvQy8+AYoWHDYFJTdSoj3Gttsrcp
	hMsEDRg4d6OPcAiKh95AqfBGg+VS2dLQqi9JGOpaGcA2dJOHkKtm56oWsgBkbgtnquZvmxQ4a5zD6
	UyKm7gIJyS8W7s//AKLRCpkC8DzNnOtE6GoILzaK2c7OGcLR3P0BCrXkLDpt4B2np1tsz4mSKAg8g
	8bfGk17OEJ/+/sGU/1gQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sivAG-0000000BBTd-2R2l;
	Tue, 27 Aug 2024 12:19:12 +0000
Received: from smtp-fw-6001.amazon.com ([52.95.48.154])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1siv8J-0000000BAxD-1jt7
	for linux-nvme@lists.infradead.org;
	Tue, 27 Aug 2024 12:17:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1724761032; x=1756297032;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dZafkTBMgG7yzSjlIbdpVuKXbZLWp3xe1QfVap/dPy0=;
  b=t+3xvDFwL4LYrH+Bh36SD2wyUEzjBF03zUMD6A4pdYLVHMr+I3Anz/qH
   gZgsP95eZ99JNh0ifY6T7+cjXi7svJdueW/eaJkqQp76QjrcxaO060B93
   bZTQ9X54OHoiJTZq2900KMVmqD4g1ebr1Htfaup2NdwTy3IueMl5WLLIm
   E=;
X-IronPort-AV: E=Sophos;i="6.10,180,1719878400"; 
   d="scan'208";a="419835842"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 12:17:05 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:55652]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.4.67:2525] with esmtp (Farcaster)
 id f7dbd5e8-420e-40fc-b1d5-d92734efcffa; Tue, 27 Aug 2024 12:17:04 +0000 (UTC)
X-Farcaster-Flow-ID: f7dbd5e8-420e-40fc-b1d5-d92734efcffa
Received: from EX19MTAUWA001.ant.amazon.com (10.250.64.204) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 27 Aug 2024 12:17:03 +0000
Received: from dev-dsk-pjy-1a-76bc80b3.eu-west-1.amazon.com (10.15.97.110) by
 mail-relay.amazon.com (10.250.64.204) with Microsoft SMTP Server id
 15.2.1258.34 via Frontend Transport; Tue, 27 Aug 2024 12:17:03 +0000
Received: by dev-dsk-pjy-1a-76bc80b3.eu-west-1.amazon.com (Postfix, from userid 22993570)
	id 6351F20A60; Tue, 27 Aug 2024 12:17:03 +0000 (UTC)
From: Puranjay Mohan <pjy@amazon.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph
 Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	<linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<puranjay@kernel.org>
Subject: [PATCH] nvme: check if the namespace supports metadata in nvme_map_user_request()
Date: Tue, 27 Aug 2024 12:17:01 +0000
Message-ID: <20240827121701.48792-1-pjy@amazon.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240827_051711_620852_35203FAB 
X-CRM114-Status: GOOD (  13.41  )
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
 drivers/nvme/host/ioctl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index f1d58e70933f..4f49523b8a41 100644
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
@@ -122,6 +123,9 @@ static int nvme_map_user_request(struct request *req, u64 ubuffer,
 	struct bio *bio = NULL;
 	int ret;
 
+	if (meta_buffer && meta_len && bdev && !blk_get_integrity(bdev->bd_disk))
+		return -EINVAL;
+
 	if (ioucmd && (ioucmd->flags & IORING_URING_CMD_FIXED)) {
 		struct iov_iter iter;
 
-- 
2.40.1


