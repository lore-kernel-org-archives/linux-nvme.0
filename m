Return-Path: <SRS0=8S6Q=LW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67ABCC2B9F4
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Jun 2021 05:09:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07E6F61C17
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Jun 2021 05:09:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07E6F61C17
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gz+E3OHROymeyJdt/MmnzhCAgL8tv4SrT3+js+A2cMg=; b=0GljBxpL9J9uKh
	mZWMgrl+MgbSIyAepmGeYS1WOPIOIMDmTaHzbu4EWD0+FhzbhDLzQF1VfcJsejeaJMAhNtf92ou0V
	A8SNptGdR5bFXzyuYKQSIAmIT5y+SXAuM4NyvGDfHiyXmpYpDmTV4zvMj4O8uVjj6wBKxF1mgjDpz
	XrGdVdJhH+uowDgXKBoIwvfRTDwsjERuKx7gQL9OqRmXBAFY4tLN4qwpC0ScuYQVaqqvnwgP4IjN2
	lu/k+V2x1l8BhjsdYWHVp+8OpUhRlKWUx4r2L4Ce5DOvajGfs/CSP0X+/OInHOWOmHdlFfEHwiJDX
	Lfv/XP7I4ybojbnqly6A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lxjVu-006lFj-NF; Mon, 28 Jun 2021 05:08:54 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lxjVi-006lEV-SK
 for linux-nvme@lists.infradead.org; Mon, 28 Jun 2021 05:08:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1624856922; x=1656392922;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=1t2/acyvzliXebqGLOcQO/+o2dpDT/xwK0efoQze0qU=;
 b=elh566ifH+TI7p8ILs2SMdGnBqmAlHtlAxD14niXqIGGhx2wadLZVxVF
 IKdMmUm3kE+Z2Pc2SF8n3e26EHaMXoe/57kfqMWEqGGUHW1q8Bl5gpjoj
 cm7yubof7Yox6Oklj/b0iIcI3/aGARHrBoCxwQjzp4fowG5NPLZ7lopxH
 xNyFkSXacr59XFQ1F+OnRrfQRAHApNvWiO5k8SlqLoM+gARcRQzOXVViO
 eMQqmCSIxhIcGQ19FAadOffUE43Y8H6+k8nWVk35fFNlOsuqusZ3DmuKm
 dNwhoodJsMkvIQuazy0IREEiWYANewmi/qTjPDSBB6+WPpq/3RPhOUtja w==;
IronPort-SDR: 9m31jzniGoinxyftZ/zv6LerYmeYPn9eyj3c9vgqHWKehmkeEwPNl+Rgkxql6M2/Bs9E4ByR2x
 ihdz1daNa66+aRUYXL7/oV/F4sLnkWbqFAlQulOHpMN48qpQhIWwn0wMfnEUp+RJmcbKiatYRr
 a131PvTZBWGyGCEKChk67DnY+0nJ6tJzjn+dfjdwvALMwtOu20vCynVvaZz4xowSmx3qIxmFz0
 MoNbaB5uT1PPBeLuemRblZO4f1AknmdrtPuc48MDsesQfLzskaYL2d6HUQUItgQHuwFSREqZkK
 1vk=
X-IronPort-AV: E=Sophos;i="5.83,305,1616428800"; d="scan'208";a="177847668"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 28 Jun 2021 13:08:42 +0800
IronPort-SDR: 4Sd2FPO5CM7zeiLhJxcVFwo6Pq4nm7MYVFXrZz2AHMYqhRzGsEFOBBxS9xSv8SOWhm4+Z14HLU
 KuJElIYCGEDDUxtn/kbE1PAiMhU7DW0rvYUPFaII1xgFie2vXmH2ssjDTlLN3V10SX7F6tCWWQ
 piuToRLTSoHNhQr5bGeQwBB+JlJvoE+yKkZUsxF4nlfr3LVhPABW6JAFyxrGDZc3aE4R5AR5gQ
 pR2G/MzqxUC+dzyZli5q/wXWQ11zEW3BSVt/Zmoz+lLl5v1ACfCo+dNKI3DrmfggZN74Cl+x47
 G/5QC98pUqmhcENUZ5JTV7MK
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jun 2021 21:47:11 -0700
IronPort-SDR: WX7TMNrr8Clgd/HFt6JVW26Og+RSC/1KuLY46ToRnvMmfZgd1GCrncFJ5C8fvWcju7gmaTHsKQ
 8Yzdug89aURWV688XlS1ka2v8VyNsA65Ghr5h8X5ZC++Rh8XZn1oxKdTR0FRMDINxpCzR3Ukxk
 BTSK+dhI9x3KihDdS+acf1Zoy5cL7pS266ig+4FsaIVLY2f7blqOymXRDv3mLbb1CpnAoVnkSu
 hkhTAprHYR7Lqbvwk6w2nLgmYJ9ZZGMLX2BxaHNZAhxpDv9gpsvP15ZdbwqXV5a2xxaGzE64zR
 X9I=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 27 Jun 2021 22:08:43 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de, sagi@grimberg.me,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 02/14] nvmet: remove repeated call for error log page
Date: Sun, 27 Jun 2021 22:08:05 -0700
Message-Id: <20210628050817.19788-3-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210628050817.19788-1-chaitanya.kulkarni@wdc.com>
References: <20210628050817.19788-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210627_220842_964980_E00C281C 
X-CRM114-Status: GOOD (  11.68  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Return status from nvmet_execute_get_log_page_error() and complete the
request in nvmet_execute_get_log_page(). This reduces number of
repeated nvmet_req_complete() calls for log page handlers.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/admin-cmd.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 03bfd8676456..66bb5b649ffd 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -45,7 +45,7 @@ static void nvmet_execute_get_log_page_noop(struct nvmet_req *req)
 	nvmet_req_complete(req, nvmet_zero_sgl(req, 0, req->transfer_len));
 }
 
-static void nvmet_execute_get_log_page_error(struct nvmet_req *req)
+static u16 nvmet_execute_get_log_page_error(struct nvmet_req *req)
 {
 	struct nvmet_ctrl *ctrl = req->sq->ctrl;
 	unsigned long flags;
@@ -68,7 +68,7 @@ static void nvmet_execute_get_log_page_error(struct nvmet_req *req)
 		offset += sizeof(struct nvme_error_slot);
 	}
 	spin_unlock_irqrestore(&ctrl->error_lock, flags);
-	nvmet_req_complete(req, 0);
+	return NVME_SC_SUCCESS;
 }
 
 static u16 nvmet_get_smart_log_nsid(struct nvmet_req *req,
@@ -321,7 +321,8 @@ static void nvmet_execute_get_log_page(struct nvmet_req *req)
 
 	switch (req->cmd->get_log_page.lid) {
 	case NVME_LOG_ERROR:
-		return nvmet_execute_get_log_page_error(req);
+		status = nvmet_execute_get_log_page_error(req);
+		break;
 	case NVME_LOG_SMART:
 		return nvmet_execute_get_log_page_smart(req);
 	case NVME_LOG_FW_SLOT:
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
