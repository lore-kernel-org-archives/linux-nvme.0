Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81723C6FD1D
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Mar 2023 14:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Rc+rCy5eoNnYaLcI8b/C6lMPvRcN4AjBEkZR84CIkhg=; b=u3ElCLG987yWzq402F4TWIXQoQ
	XRdsL7m9jYgjtpJG3Fa5tg2HJzbnPJ6SyiNAf7Pi0fM+D0wbubnYdQDB1kRJw2uiwiFOhm35pwzz6
	SSDZgdxv/5SiA4xSJnaDVgaAWBXhP+GbjPQZ331A6mKnqPEXVk5Byaen2IS+/lnjx8q3uWBcgN3mi
	gzF05LsCzzfkCyAE30ZxFddHl0UyizDjvhozTAJ49F+IY0TVsY594fG1pTilCfno4CLRntAEeNF84
	LhIFsEa+WikXWDD8ZJKIMYb2Il8IMnad1+q4HqCRs0vDazNqTFTczzSoyGZp+mWMtycyHNe6+JMnj
	Nd2U+DyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pcRza-00Db39-2W;
	Wed, 15 Mar 2023 14:20:38 +0000
Received: from [2001:4bb8:182:2e36:b846:e064:f469:69ed] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1pcRzZ-00Db1t-13;
	Wed, 15 Mar 2023 14:20:37 +0000
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>,
	linux-nvme@lists.infradead.org
Subject: [PATCH 1/2] nvmet: fix Identify Identification Descriptor List handling
Date: Wed, 15 Mar 2023 15:20:31 +0100
Message-Id: <20230315142032.507083-2-hch@lst.de>
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

The Identification Descriptor List CNS value does not check the CSI
value, so remove the code trying to handle it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/target/admin-cmd.c | 20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 3c4f2ddc09604e..c0908031ce25ee 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -668,23 +668,6 @@ static void nvmet_execute_identify_desclist(struct nvmet_req *req)
 	nvmet_req_complete(req, status);
 }
 
-static bool nvmet_handle_identify_desclist(struct nvmet_req *req)
-{
-	switch (req->cmd->identify.csi) {
-	case NVME_CSI_NVM:
-		nvmet_execute_identify_desclist(req);
-		return true;
-	case NVME_CSI_ZNS:
-		if (IS_ENABLED(CONFIG_BLK_DEV_ZONED)) {
-			nvmet_execute_identify_desclist(req);
-			return true;
-		}
-		return false;
-	default:
-		return false;
-	}
-}
-
 static void nvmet_execute_identify_ctrl_nvm(struct nvmet_req *req)
 {
 	/* Not supported: return zeroes */
@@ -708,8 +691,7 @@ static void nvmet_execute_identify(struct nvmet_req *req)
 		nvmet_execute_identify_nslist(req);
 		return;
 	case NVME_ID_CNS_NS_DESC_LIST:
-		if (nvmet_handle_identify_desclist(req) == true)
-			return;
+		nvmet_execute_identify_desclist(req);
 		break;
 	case NVME_ID_CNS_CS_NS:
 		switch (req->cmd->identify.csi) {
-- 
2.39.2


