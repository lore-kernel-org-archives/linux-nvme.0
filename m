Return-Path: <SRS0=Br1a=5M=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D46BC2D0ED
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Mar 2020 17:18:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 353C420578
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Mar 2020 17:18:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fwBjyqzA";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kdzC8DB8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 353C420578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=i4PGgD3fyR90Kp0jAH0uXalBS1A64deZCDihJP8h61A=; b=fwBjyqzAT4SVu1
	Ol2leKw8VCRcp0fParqiplCsyd1q2o5s3kR/9X/CKLDic9/fqJvQdkxD+z1YHwZVYLyjTGaQQc8Kc
	37TeZW1dgujAnQCs7eukDibtI++Fh6SKnJfzcYx9yBiggqyVppKVR1h8XyL2mUTrRNOouPj8uXI9O
	qQgmwL5DEBzxZGx04AND4HMSP4Di3HOpgRGF5kDg7371AeartvjYtCm70ohGy+heQlMzSF9TOqOpt
	sQaXuGs6jfgY6LKy+BzN7uFvpGs7/LXnTe/qL0lBdj4ZNztEWrLuSI9OtH4g0eeXUevflEtJnV6cy
	joaKBWYQd312U4UKlLew==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jHscN-0001HE-H6; Fri, 27 Mar 2020 17:18:03 +0000
Received: from merlin.infradead.org ([205.233.59.134])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jHsaP-00080p-TL
 for linux-nvme@bombadil.infradead.org; Fri, 27 Mar 2020 17:16:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=/0BwuQ1Ay9IttLRsdhBHfrMhxDgTNj74wxx6suo7WDg=; b=kdzC8DB8qz7dM6rjv3G6v6wq8G
 v15jgytgeThNTcAyeuFpP0uRmO9VWwMl1/MrQEC3YBuLD+ukgodVdXfAXqnsN6S7hRxbxUd2ldOgQ
 sSuv2+9geaZ1tSVUC5fy0gzxOzjLWuCuNNlw6dz6l7eto2r7UbvIai6UtY3hmfpi4YguxHl/xWsGs
 nPoSVZFducXIvD/F6vSqqWUGETEmnQyBeHCXhTiFGk4Qwqh+C7IUUPhyppaiEHC5FOrDoBW8wBHNZ
 gLE0o6rfHSxUna1xl7AO9eKqWpOpvK5F/PDCJtRascjQaXFAKRNgm4CV34N6kLJ9H7YhuAWtc0p6M
 1ad1idBQ==;
Received: from mail-il-dmz.mellanox.com ([193.47.165.129] helo=mellanox.co.il)
 by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jHsaL-00082i-TQ
 for linux-nvme@lists.infradead.org; Fri, 27 Mar 2020 17:16:00 +0000
Received: from Internal Mail-Server by MTLPINE2 (envelope-from
 maxg@mellanox.com)
 with ESMTPS (AES256-SHA encrypted); 27 Mar 2020 20:15:48 +0300
Received: from mtr-vdi-031.wap.labs.mlnx. (mtr-vdi-031.wap.labs.mlnx
 [10.209.102.136])
 by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 02RHFjjJ004869;
 Fri, 27 Mar 2020 20:15:48 +0300
From: Max Gurtovoy <maxg@mellanox.com>
To: linux-nvme@lists.infradead.org, kbusch@kernel.org, hch@lst.de,
 sagi@grimberg.me, martin.petersen@oracle.com, jsmart2021@gmail.com,
 linux-rdma@vger.kernel.org
Subject: [PATCH 16/17] RDMA/rw: Expose maximal page list for a device per 1 MR
Date: Fri, 27 Mar 2020 20:15:44 +0300
Message-Id: <20200327171545.98970-18-maxg@mellanox.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200327171545.98970-1-maxg@mellanox.com>
References: <20200327171545.98970-1-maxg@mellanox.com>
MIME-Version: 1.0
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
Cc: axboe@kernel.dk, vladimirk@mellanox.com, shlomin@mellanox.com,
 israelr@mellanox.com, idanb@mellanox.com, jgg@mellanox.com, oren@mellanox.com,
 maxg@mellanox.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

ULP's will use this information to determine the maximal data transfer
size per IO operation.

Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
---
 drivers/infiniband/core/rw.c | 14 ++++++++++++--
 include/rdma/rw.h            |  1 +
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/rw.c b/drivers/infiniband/core/rw.c
index 4fad732..edc9bee 100644
--- a/drivers/infiniband/core/rw.c
+++ b/drivers/infiniband/core/rw.c
@@ -56,8 +56,17 @@ static inline bool rdma_rw_io_needs_mr(struct ib_device *dev, u8 port_num,
 	return false;
 }
 
-static inline u32 rdma_rw_fr_page_list_len(struct ib_device *dev,
-					   bool pi_support)
+/**
+ * rdma_rw_fr_page_list_len - return the max number of pages mapped by 1 MR
+ * @dev:	RDMA device that will eventually create a PD for needed MRs
+ * @pi_support:	Whether MRs will be created for protection information offload
+ *
+ * Returns the number of pages that one MR can map for RDMA operation by the
+ * given device. One can determine the maximal data size according to the
+ * result of this function, or chose using multiple MRs for the RDMA operation
+ * as well.
+ */
+u32 rdma_rw_fr_page_list_len(struct ib_device *dev, bool pi_support)
 {
 	u32 max_pages;
 
@@ -69,6 +78,7 @@ static inline u32 rdma_rw_fr_page_list_len(struct ib_device *dev,
 	/* arbitrary limit to avoid allocating gigantic resources */
 	return min_t(u32, max_pages, 256);
 }
+EXPORT_SYMBOL(rdma_rw_fr_page_list_len);
 
 static inline int rdma_rw_inv_key(struct rdma_rw_reg_ctx *reg)
 {
diff --git a/include/rdma/rw.h b/include/rdma/rw.h
index 6ad9dc8..a9bbda7 100644
--- a/include/rdma/rw.h
+++ b/include/rdma/rw.h
@@ -69,5 +69,6 @@ unsigned int rdma_rw_mr_factor(struct ib_device *device, u8 port_num,
 void rdma_rw_init_qp(struct ib_device *dev, struct ib_qp_init_attr *attr);
 int rdma_rw_init_mrs(struct ib_qp *qp, struct ib_qp_init_attr *attr);
 void rdma_rw_cleanup_mrs(struct ib_qp *qp);
+u32 rdma_rw_fr_page_list_len(struct ib_device *dev, bool pi_support);
 
 #endif /* _RDMA_RW_H */
-- 
1.8.3.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
