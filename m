Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6E6AC6FD1D
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Mar 2023 14:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NEUvNbDbPm8hnO8+LS4V80mQGfcHkc1NjrcobICOSNo=; b=P1z/7cdPbZpF1n848vU/cZsmuo
	S+dn5RCEj4HqYK5gz4DkALqxcCTDomnx/cuLnEMSLVHCH/85pEd13yuoe2A+R0WhpH6g/Tlo7QvMu
	yHXkEGYhFiHJi7cEDGKJiP8nny0Dw16S+20Uf5fJYcV91OdnZq+BWS+/fCczDKHftgfEfmMsasXCo
	3Pk4JD4X6Uc9Txus4+pkszK9OPLMObyKVIch7bu/CmsHiDQdSpSjuHQs1gh6bTprkSu0LeppMH5eb
	OjaMJ6E6hbG9NmSlUzB2yDbliyTVni1CdVRnPJhpayQ92a6In1D1eW2NzAxOlL0CIEwvunp5qq4X9
	4xbKhiIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pcRzd-00Db4M-1o;
	Wed, 15 Mar 2023 14:20:41 +0000
Received: from [2001:4bb8:182:2e36:b846:e064:f469:69ed] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1pcRzb-00Db30-2q;
	Wed, 15 Mar 2023 14:20:40 +0000
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>,
	linux-nvme@lists.infradead.org
Subject: [PATCH 2/2] nvmet: rename nvmet_execute_identify_cns_cs_ns
Date: Wed, 15 Mar 2023 15:20:32 +0100
Message-Id: <20230315142032.507083-3-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230315142032.507083-1-hch@lst.de>
References: <20230315142032.507083-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

nvmet_execute_identify_ns_zns is a more descriptive name for the
function handling the "I/O Command Set Specific Identify Namespace
Data Structure for the Zoned Namespace Command Set".

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/target/admin-cmd.c | 2 +-
 drivers/nvme/target/nvmet.h     | 2 +-
 drivers/nvme/target/zns.c       | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index c0908031ce25ee..4ee30a4da50990 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -700,7 +700,7 @@ static void nvmet_execute_identify(struct nvmet_req *req)
 			break;
 		case NVME_CSI_ZNS:
 			if (IS_ENABLED(CONFIG_BLK_DEV_ZONED)) {
-				nvmet_execute_identify_cns_cs_ns(req);
+				nvmet_execute_identify_ns_zns(req);
 				return;
 			}
 			break;
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index ed3786140965f0..2c1522d4063bde 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -582,7 +582,7 @@ u16 blk_to_nvme_status(struct nvmet_req *req, blk_status_t blk_sts);
 
 bool nvmet_bdev_zns_enable(struct nvmet_ns *ns);
 void nvmet_execute_identify_ctrl_zns(struct nvmet_req *req);
-void nvmet_execute_identify_cns_cs_ns(struct nvmet_req *req);
+void nvmet_execute_identify_ns_zns(struct nvmet_req *req);
 void nvmet_bdev_execute_zone_mgmt_recv(struct nvmet_req *req);
 void nvmet_bdev_execute_zone_mgmt_send(struct nvmet_req *req);
 void nvmet_bdev_execute_zone_append(struct nvmet_req *req);
diff --git a/drivers/nvme/target/zns.c b/drivers/nvme/target/zns.c
index ae4d9d35e46ae4..5b5c1e48172213 100644
--- a/drivers/nvme/target/zns.c
+++ b/drivers/nvme/target/zns.c
@@ -95,7 +95,7 @@ void nvmet_execute_identify_ctrl_zns(struct nvmet_req *req)
 	nvmet_req_complete(req, status);
 }
 
-void nvmet_execute_identify_cns_cs_ns(struct nvmet_req *req)
+void nvmet_execute_identify_ns_zns(struct nvmet_req *req)
 {
 	struct nvme_id_ns_zns *id_zns = NULL;
 	u64 zsze;
-- 
2.39.2


