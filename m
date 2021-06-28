Return-Path: <SRS0=8S6Q=LW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D099DC2B9F4
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Jun 2021 05:09:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81E6261C17
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Jun 2021 05:09:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81E6261C17
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Y7IDYhfONga9DGPmRVZWezkFAVAWT8lp/S7HPYcpCwg=; b=BsoVOc/uUeKJuj
	V2IkU/pFoJey+JKFyQPgOG/K9Evui48ZWULowOEOPlbDuaTcutLQk9mbSL3NjV0fvJtxRSqsrzHmF
	DR8v1Nlbc5rFwry6gwVwV1hfv9cXZVVjp4jNGdMWXDydsSzm9Oaf4wUnS0as4uSriuSXtZRTzSySB
	FUpxFq7zcJBtElHXnnBs0a1ow3oxprCGLt2EyoCqLTGwyEddSTzXLMYabk0hSSCggMmj75Cwldycr
	ZX/AEQJrpG+l4phT5GjYk1LFbQHis7EsNtCTu57QkQj4KW5s7hZrsb0SCwH7MGq2Zy1vq8r4L5oTq
	wRLKW1Vn+w52jOeeqdFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lxjVk-006lEs-IB; Mon, 28 Jun 2021 05:08:44 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lxjVa-006lDp-Ni
 for linux-nvme@lists.infradead.org; Mon, 28 Jun 2021 05:08:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1624856915; x=1656392915;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=8Uijo8xd0iA3ps0y2wt0kg5TpeloKHVEmGgd6p075QY=;
 b=r0/WjMwrRQ4Xwx6/0cDK83wkie6mTFvt78X94pK+6gj1usqpnd9bKc3I
 EIYIOEhbw3ZPyPKKsa1NFivjBghcNC7RBNWVhyTD3thHI3fEa3FEHOj8/
 8xSzbVnVzWmIdlBJ9lVVxJTU6vCRBNcHtyiuzz/gYLuEFk3RR58y38MMJ
 YIgcPXCGMXuMWbysMa5CzBb/K+3qmy3FCqXPkDKOUGpusej63IIUCTm27
 boF95QRRTI0GwcpV9N0u/EVrSSJPPWsRiB30PPfhClHhIHn7W2pzhUkOM
 E9sUlNqRe8ar0TVJSKuLyJ4BpOPhHaUrA+87/q3OfugDQha0blp/zVvQK g==;
IronPort-SDR: uEb62v72GYHSXs7bUdWHYgfS8AvgKa/WbKBETG7zHH4M+prsxTvZuC/iUrvL4aRVl8h6XiUYpe
 ooYGG0LZgpXtmVqP7qcunCp/50AVMaV/malYnxVOEjGRyE6d7+ekOtbHfxmFUUeT0CFa3JcWM5
 Nge6wPY6FavMrgHebtRlKNso3D4QAi2/Hsise4uGKB+1wnqhWy8WAcaXbyl7xbTobOYvAhqwbY
 YCRtZJ6EtLo2M89r4mxTnkok/4nNZyPFILRQ7aCOkHKkvlzTJ3X8myzekwTyKJRSYVdyBI55iD
 SqY=
X-IronPort-AV: E=Sophos;i="5.83,305,1616428800"; d="scan'208";a="173629795"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 28 Jun 2021 13:08:33 +0800
IronPort-SDR: JEcoVwFxeudecmS4HcVjRIk57BP4qntf3Az9BlyYN3VemTmfYlgMkw1Q27NzxayF8uie5yYc2j
 5knNLQJsgy0NVkKB8o19j80rsEt+2ryIfCZcmdkET746gCSNqoFemtEypnjTSUmQpQvDMTrXhc
 K/E+1SmqsA/c3YAb6Gsg/Y44fDNtX/ntx9ohtfxwnECAupdLb4oWfsSOgEUV5t+yIAofKWViBq
 wQjUz/mEjJ2GUxnapnNXKhvXdyEafKMzbPtJntLBT9F6My0oiyj8DcOd1Qbp9QGqsI1DYCGzWb
 Fok+k8/CKTWpX/MS2MjRwuuM
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jun 2021 21:45:42 -0700
IronPort-SDR: Ss10vQt79lv330Zj8RRW4Fbg8cQv5eqrYlpf/09NBcP9oQBkO62tSOMTrcM4Ms64VAayCmQGT7
 YTQ07WBWXk/KEzYKZgwNvd1ZRY+1zbOWhL/8sut16M5SmfDKo43d/C0M9z4a7680xpA0mxPddN
 ogCdiu1GYrUFonKWOLhrMKlrXRXj9NkO99sITJmB4mHRp2TW1ZZPHpEYPwNNzTHOReA9VBsoZG
 8FziYNzImFc6GZXIBE3WnCFLqkUViiDPBX4RjZWJV4aphuooS1EtrA8FPSrlU107b8HBtAPzIu
 17c=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 27 Jun 2021 22:08:33 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de, sagi@grimberg.me,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 01/14] nvmet: add common req complete for log page
Date: Sun, 27 Jun 2021 22:08:04 -0700
Message-Id: <20210628050817.19788-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210628050817.19788-1-chaitanya.kulkarni@wdc.com>
References: <20210628050817.19788-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210627_220834_903898_FE2D6BA0 
X-CRM114-Status: GOOD (  15.51  )
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

For set/get features command handlers we don't complete the request in
each feature handler instead we complete the request in the original
callback i.e. in nvmet_execute_set_feature() and
nvmet_execute_get_feature(). This reduces the number of repeated
nvmet_req_complete() calls needed for each feature to complete the
request.

A similar pattern can be used for the log page handler callback and its
helpers.

In this prep patch we add a default caes for unhandled log pages and
complete the request in the nvmet_execute_get_log_page(). Next patches
will use this call for request completion so we can remove the local
call from each log page handler.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/admin-cmd.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 0cb98f2bbc8c..03bfd8676456 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -314,6 +314,8 @@ static void nvmet_execute_get_log_page_ana(struct nvmet_req *req)
 
 static void nvmet_execute_get_log_page(struct nvmet_req *req)
 {
+	u16 status;
+
 	if (!nvmet_check_transfer_len(req, nvmet_get_log_page_len(req->cmd)))
 		return;
 
@@ -335,11 +337,13 @@ static void nvmet_execute_get_log_page(struct nvmet_req *req)
 		return nvmet_execute_get_log_cmd_effects_ns(req);
 	case NVME_LOG_ANA:
 		return nvmet_execute_get_log_page_ana(req);
+	default:
+		pr_err("unhandled lid %d on qid %d\n",
+		       req->cmd->get_log_page.lid, req->sq->qid);
+		req->error_loc = offsetof(struct nvme_get_log_page_command, lid);
+		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
 	}
-	pr_debug("unhandled lid %d on qid %d\n",
-	       req->cmd->get_log_page.lid, req->sq->qid);
-	req->error_loc = offsetof(struct nvme_get_log_page_command, lid);
-	nvmet_req_complete(req, NVME_SC_INVALID_FIELD | NVME_SC_DNR);
+	nvmet_req_complete(req, status);
 }
 
 static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
