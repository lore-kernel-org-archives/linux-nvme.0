Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B0F6D1AD30
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Oct 2024 09:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:To:From:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=UcTHLD6sRCmV7ayE8d9IppwXDwkVLKNLEKqgv4jGmMo=; b=dBqEAJiDRdcC4X
	+IYsLVbhpddiiz3JiAD1npkElEe+rM5TNehheMh0ux867F0bIGRbsZABX5BcIa70SY/naxz4YWW4r
	9EmZ4lMq+vmcy0Ikc19fduNWiNhy6nx/fUZFWUeRICYnNR+84VmtlXwHqhO7xJDwGe+2iotEr4ih0
	z35meUj8wL7qVlar7+wnNXhChzbp6prdVT4hrUWBQjXX+Vr2D4rXsV4gHXFT7ATvkvOiYAEA0HBiY
	x4JgTBD2ZSMw52TIOlQY/MeEt5SFKV3KFH0BdKmYAS1y6roUqqoAeXvrLGE8aHx23qCag5V00G5aE
	pJ2mwpxXlHEs068xXfdA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t101O-0000000BAhD-0xUu;
	Wed, 16 Oct 2024 09:08:46 +0000
Received: from smtp-fw-9102.amazon.com ([207.171.184.29])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t100W-0000000BAZq-2MZV
	for linux-nvme@lists.infradead.org;
	Wed, 16 Oct 2024 09:07:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1729069672; x=1760605672;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UcTHLD6sRCmV7ayE8d9IppwXDwkVLKNLEKqgv4jGmMo=;
  b=E4GfSZ0jEvLgaQ59jf0JvohNumvkjRq3HW5M9YzrgYNqpyn2SIG1xXfl
   gv8xJk89NnuceMFEgThWFjFT0i6ogvys9trU/jVsX/+W0QsAJcT1HkvRV
   nUtGxgHmCpCSceDAFv3cty4I5JcEE4rSJXsz+7koEtPavrl89jgCQ7R9N
   8=;
X-IronPort-AV: E=Sophos;i="6.11,207,1725321600"; 
   d="scan'208";a="461213309"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 09:07:43 +0000
Received: from EX19MTAUEB002.ant.amazon.com [10.0.0.204:24357]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.8.207:2525] with esmtp (Farcaster)
 id 2d14e9d2-f0ff-44c7-8c9b-a494451bfecb; Wed, 16 Oct 2024 09:07:42 +0000 (UTC)
X-Farcaster-Flow-ID: 2d14e9d2-f0ff-44c7-8c9b-a494451bfecb
Received: from EX19MTAUEA001.ant.amazon.com (10.252.134.203) by
 EX19MTAUEB002.ant.amazon.com (10.252.135.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 16 Oct 2024 09:07:42 +0000
Received: from email-imr-corp-prod-iad-all-1b-1323ce6b.us-east-1.amazon.com
 (10.43.8.2) by mail-relay.amazon.com (10.252.134.102) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.34 via Frontend Transport; Wed, 16 Oct 2024 09:07:42 +0000
Received: from dev-dsk-pjy-1a-76bc80b3.eu-west-1.amazon.com (dev-dsk-pjy-1a-76bc80b3.eu-west-1.amazon.com [10.15.97.110])
	by email-imr-corp-prod-iad-all-1b-1323ce6b.us-east-1.amazon.com (Postfix) with ESMTP id 44F154034D;
	Wed, 16 Oct 2024 09:07:42 +0000 (UTC)
Received: by dev-dsk-pjy-1a-76bc80b3.eu-west-1.amazon.com (Postfix, from userid 22993570)
	id 02C4B20849; Wed, 16 Oct 2024 09:07:41 +0000 (UTC)
From: Puranjay Mohan <pjy@amazon.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>, "Christoph
 Hellwig" <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	<linux-nvme@lists.infradead.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, <stable@vger.kernel.org>,
	<puranjay12@gmail.com>, <amazon-linux-kernel@amazon.com>
Subject: [PATCH 6.1.y] nvme: fix metadata handling in nvme-passthrough
Date: Wed, 16 Oct 2024 09:07:39 +0000
Message-ID: <20241016090739.43470-1-pjy@amazon.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241016_020752_803263_63503F20 
X-CRM114-Status: GOOD (  15.98  )
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

[ Upstream commit 7c2fd76048e95dd267055b5f5e0a48e6e7c81fd9 ]

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
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
[ Minor changes to make it work on 6.1 ]
Signed-off-by: Puranjay Mohan <pjy@amazon.com>
---
 drivers/nvme/host/ioctl.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index b3e322e4ade38..a02873792890e 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -3,6 +3,7 @@
  * Copyright (c) 2011-2014, Intel Corporation.
  * Copyright (c) 2017-2021 Christoph Hellwig.
  */
+#include <linux/blk-integrity.h>
 #include <linux/ptrace.h>	/* for force_successful_syscall_return */
 #include <linux/nvme_ioctl.h>
 #include <linux/io_uring.h>
@@ -95,10 +96,15 @@ static int nvme_map_user_request(struct request *req, u64 ubuffer,
 	struct request_queue *q = req->q;
 	struct nvme_ns *ns = q->queuedata;
 	struct block_device *bdev = ns ? ns->disk->part0 : NULL;
+	bool supports_metadata = bdev && blk_get_integrity(bdev->bd_disk);
+	bool has_metadata = meta_buffer && meta_len;
 	struct bio *bio = NULL;
 	void *meta = NULL;
 	int ret;
 
+	if (has_metadata && !supports_metadata)
+		return -EINVAL;
+
 	if (ioucmd && (ioucmd->flags & IORING_URING_CMD_FIXED)) {
 		struct iov_iter iter;
 
@@ -122,7 +128,7 @@ static int nvme_map_user_request(struct request *req, u64 ubuffer,
 	if (bdev)
 		bio_set_dev(bio, bdev);
 
-	if (bdev && meta_buffer && meta_len) {
+	if (has_metadata) {
 		meta = nvme_add_user_metadata(req, meta_buffer, meta_len,
 				meta_seed);
 		if (IS_ERR(meta)) {
-- 
2.40.1


