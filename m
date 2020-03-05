Return-Path: <SRS0=uiYz=4W=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB781C3F2CD
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Mar 2020 09:55:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76869208CD
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Mar 2020 09:55:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DZcHDygf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76869208CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=37hSOnVdpQ10D08tG5VYU4mGNO0b0EfwLzqVkGukkRM=; b=DZcHDygfjh7vNQ
	9slclhojWhShRrQjtaQxh4KAarnLkzy2E3DiLjgli3IhsIxgQSUF+3z6BMu4lbfJkAf2W5OFGqJIq
	xWNJTGtbLBSIJejfInCdl3Hel6/5KtltNxgEo2wNEk5Ew73RtNkrwgLw5Ov12ODpBDQv8xRkJr1su
	UbMtSun1aZIoHwpDchGhOIXNcF5HVCjP4q/xFsSQRrajnmwqDdDRGYp4Zmnpi9WxfIRPWeqr5ipve
	pCPOTtcY3CbqNXDbdjyp3Xn2o2u3171UMVHZPxZ2MHMdMFOj3nhv0+MyuLCXjcmlMtkvBhCN35ZfL
	Uzl51qVa8EYr5Qve7Vug==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j9nEE-000174-AF; Thu, 05 Mar 2020 09:55:42 +0000
Received: from mail-il-dmz.mellanox.com ([193.47.165.129] helo=mellanox.co.il)
 by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j9nEB-00012Q-7r
 for linux-nvme@lists.infradead.org; Thu, 05 Mar 2020 09:55:40 +0000
Received: from Internal Mail-Server by MTLPINE1 (envelope-from
 maxg@mellanox.com)
 with ESMTPS (AES256-SHA encrypted); 5 Mar 2020 11:55:30 +0200
Received: from mtr-vdi-031.wap.labs.mlnx. (mtr-vdi-031.wap.labs.mlnx
 [10.209.102.136])
 by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 0259tUhP020720;
 Thu, 5 Mar 2020 11:55:30 +0200
From: Max Gurtovoy <maxg@mellanox.com>
To: jgg@mellanox.com, linux-nvme@lists.infradead.org, sagi@grimberg.me,
 hch@lst.de, kbusch@kernel.org, Chaitanya.Kulkarni@wdc.com
Subject: [PATCH V2 2/3] nvmet-rdma: Implement get_mdts controller op
Date: Thu,  5 Mar 2020 11:55:29 +0200
Message-Id: <20200305095530.132858-2-maxg@mellanox.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200305095530.132858-1-maxg@mellanox.com>
References: <20200305095530.132858-1-maxg@mellanox.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200305_015539_680454_630E1ABD 
X-CRM114-Status: UNSURE (   8.70  )
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
Cc: krishna2@chelsio.com, Max Gurtovoy <maxg@mellanox.com>, bharat@chelsio.com,
 nirranjan@chelsio.com, bvanassche@acm.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Set the maximal data transfer size to be 1MB (currently mdts is
unlimited). This will allow calculating the amount of MR's that
one ctrl should allocate to fulfill it's capabilities.

Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
---

changes from V1:
 - renamed nvmet_rdma_set_mdts to nvmet_rdma_get_mdts
 - align to get_mdts callback changes

---
 drivers/nvme/target/rdma.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 37d262a..d12ef0d 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -30,6 +30,7 @@
 #define NVMET_RDMA_DEFAULT_INLINE_DATA_SIZE	PAGE_SIZE
 #define NVMET_RDMA_MAX_INLINE_SGE		4
 #define NVMET_RDMA_MAX_INLINE_DATA_SIZE		max_t(int, SZ_16K, PAGE_SIZE)
+#define NVMET_RDMA_MAX_MDTS			8
 
 struct nvmet_rdma_cmd {
 	struct ib_sge		sge[NVMET_RDMA_MAX_INLINE_SGE + 1];
@@ -1602,6 +1603,12 @@ static void nvmet_rdma_disc_port_addr(struct nvmet_req *req,
 	}
 }
 
+static u8 nvmet_rdma_get_mdts(const struct nvmet_ctrl *ctrl)
+{
+	/* Assume mpsmin == device_page_size == 4KB */
+	return NVMET_RDMA_MAX_MDTS;
+}
+
 static const struct nvmet_fabrics_ops nvmet_rdma_ops = {
 	.owner			= THIS_MODULE,
 	.type			= NVMF_TRTYPE_RDMA,
@@ -1612,6 +1619,7 @@ static void nvmet_rdma_disc_port_addr(struct nvmet_req *req,
 	.queue_response		= nvmet_rdma_queue_response,
 	.delete_ctrl		= nvmet_rdma_delete_ctrl,
 	.disc_traddr		= nvmet_rdma_disc_port_addr,
+	.get_mdts		= nvmet_rdma_get_mdts,
 };
 
 static void nvmet_rdma_remove_one(struct ib_device *ib_device, void *client_data)
-- 
1.8.3.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
