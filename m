Return-Path: <SRS0=qcAl=45=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D8DC10DCE
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Mar 2020 11:39:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60BDB206E7
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Mar 2020 11:39:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="grDOGRiU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60BDB206E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=i9ZAs/T8b0fzgNw0JkgCVP8pLH6iEowdKZDMXlZ3kKM=; b=grDOGRiU+QxK6L
	tejMXTwbfZOBULOVWq4/YKL6XwacxzMdEajkk+xHyyfrlDMblIoieJzBprmz+IYEs3Po0Xqtilcfp
	QGw+IvRO7f+RyTQreVsVwWT+ZfuBa1ky+/QrHrUl2oyV2dVZ+KaQD0sFQKfvbc9MT1jCeBMWvzi4U
	sp8cV2jK3HX5MGoe0qexwmJXc9zZAX6eyhFDLcUxj3GOxndaQbTjv/+7Nf0htxEUhOjfGb7TUoOyo
	naEQi+1U1zqXWFjf7jye8BZe98eStQoxIV9cDfUX1eS0JHGu9QxHmfOROobi9QOMhfQ/F0uYBWjeS
	ZOulbgpE/S7GrJsmMxsg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jCMBo-0003s4-Tp; Thu, 12 Mar 2020 11:39:48 +0000
Received: from mga12.intel.com ([192.55.52.136])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jCMBm-0003rP-B1
 for linux-nvme@lists.infradead.org; Thu, 12 Mar 2020 11:39:47 +0000
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 12 Mar 2020 04:39:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,544,1574150400"; d="scan'208";a="266305925"
Received: from black.fi.intel.com ([10.237.72.28])
 by fmsmga004.fm.intel.com with ESMTP; 12 Mar 2020 04:39:42 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
 id 978B8193; Thu, 12 Mar 2020 13:39:41 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org, Felipe Balbi <balbi@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 linux-scsi@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 linux-arch@vger.kernel.org
Subject: [PATCH v1] asm-generic: Provide generic {get, put}_unaligned_{l,
 b}e24()
Date: Thu, 12 Mar 2020 13:39:41 +0200
Message-Id: <20200312113941.81162-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200312_043946_393694_B2016034 
X-CRM114-Status: GOOD (  13.42  )
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
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

There are users in kernel that duplicate {get,put}_unaligned_{l,b}e24()
implementation. Provide generic helpers once for all.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/nvme/host/rdma.c                     |  8 -------
 drivers/nvme/target/rdma.c                   |  6 -----
 drivers/usb/gadget/function/storage_common.h |  5 ----
 include/asm-generic/unaligned.h              | 25 ++++++++++++++++++++
 include/target/target_core_backend.h         |  6 -----
 5 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 3e85c5cacefd..2845118e6e40 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -142,14 +142,6 @@ static void nvme_rdma_recv_done(struct ib_cq *cq, struct ib_wc *wc);
 static const struct blk_mq_ops nvme_rdma_mq_ops;
 static const struct blk_mq_ops nvme_rdma_admin_mq_ops;
 
-/* XXX: really should move to a generic header sooner or later.. */
-static inline void put_unaligned_le24(u32 val, u8 *p)
-{
-	*p++ = val;
-	*p++ = val >> 8;
-	*p++ = val >> 16;
-}
-
 static inline int nvme_rdma_queue_idx(struct nvme_rdma_queue *queue)
 {
 	return queue - queue->ctrl->queues;
diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 37d262a65877..8fcede75e02a 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -143,12 +143,6 @@ static int num_pages(int len)
 	return 1 + (((len - 1) & PAGE_MASK) >> PAGE_SHIFT);
 }
 
-/* XXX: really should move to a generic header sooner or later.. */
-static inline u32 get_unaligned_le24(const u8 *p)
-{
-	return (u32)p[0] | (u32)p[1] << 8 | (u32)p[2] << 16;
-}
-
 static inline bool nvmet_rdma_need_data_in(struct nvmet_rdma_rsp *rsp)
 {
 	return nvme_is_write(rsp->req.cmd) &&
diff --git a/drivers/usb/gadget/function/storage_common.h b/drivers/usb/gadget/function/storage_common.h
index e5e3a2553aaa..bdeb1e233fc9 100644
--- a/drivers/usb/gadget/function/storage_common.h
+++ b/drivers/usb/gadget/function/storage_common.h
@@ -172,11 +172,6 @@ enum data_direction {
 	DATA_DIR_NONE
 };
 
-static inline u32 get_unaligned_be24(u8 *buf)
-{
-	return 0xffffff & (u32) get_unaligned_be32(buf - 1);
-}
-
 static inline struct fsg_lun *fsg_lun_from_dev(struct device *dev)
 {
 	return container_of(dev, struct fsg_lun, dev);
diff --git a/include/asm-generic/unaligned.h b/include/asm-generic/unaligned.h
index 374c940e9be1..dd9f9695d1ba 100644
--- a/include/asm-generic/unaligned.h
+++ b/include/asm-generic/unaligned.h
@@ -33,4 +33,29 @@
 # error need to define endianess
 #endif
 
+/* 24-bit unaligned access is special for now, that's why explicitly here */
+static inline u32 get_unaligned_le24(const u8 *p)
+{
+	return (u32)p[0] | (u32)p[1] << 8 | (u32)p[2] << 16;
+}
+
+static inline void put_unaligned_le24(const u32 val, u8 *p)
+{
+	*p++ = val;
+	*p++ = val >> 8;
+	*p++ = val >> 16;
+}
+
+static inline u32 get_unaligned_be24(const u8 *buf)
+{
+	return (u32)p[0] << 16 | (u32)p[1] << 8 | (u32)p[2];
+}
+
+static inline void put_unaligned_be24(const u32 val, u8 *p)
+{
+	*p++ = val >> 16;
+	*p++ = val >> 8;
+	*p++ = val;
+}
+
 #endif /* __ASM_GENERIC_UNALIGNED_H */
diff --git a/include/target/target_core_backend.h b/include/target/target_core_backend.h
index 51b6f50eabee..1b752d8ea529 100644
--- a/include/target/target_core_backend.h
+++ b/include/target/target_core_backend.h
@@ -116,10 +116,4 @@ static inline bool target_dev_configured(struct se_device *se_dev)
 	return !!(se_dev->dev_flags & DF_CONFIGURED);
 }
 
-/* Only use get_unaligned_be24() if reading p - 1 is allowed. */
-static inline uint32_t get_unaligned_be24(const uint8_t *const p)
-{
-	return get_unaligned_be32(p - 1) & 0xffffffU;
-}
-
 #endif /* TARGET_CORE_BACKEND_H */
-- 
2.25.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
