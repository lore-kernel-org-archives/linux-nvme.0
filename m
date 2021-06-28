Return-Path: <SRS0=8S6Q=LW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63840C2B9F4
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Jun 2021 05:10:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 280AE6162A
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Jun 2021 05:10:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 280AE6162A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qw21W1xSisJMj0vxlfbqxLcMx9IDEglos7Bsg6V5AAo=; b=FjVX5TqDlr4SKC
	g2Tvogkj3KmzbgWzJRhCPBuowQQBa8F1T7oFh9Xbm2sgwTyrdPF119lzW2hnVdAziKA+lSS0Ym6zp
	Ye7edn7e/wmqjAQ05mbG+jjMFqeaYl+37A40aogJMptGXOkO1xnV50O7Dux6KUhP4HIzD9KroT27h
	DYf2QPe0SVXrMLrxgf+I37LytmtwUH+gUbB5i3r4eKrP34dzciEes8b/ShdWMa/z9YyGMDZEytwDH
	zmHdIJRDR6eglSMad3Tv6dRmZj0Qty6GugFBKKJDNPc63PatbetZgVX+8KVHzVVoO9Rj1ahgjehwD
	xTwLs8gts1TYg62zjXHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lxjWx-006lXx-AI; Mon, 28 Jun 2021 05:09:59 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lxjWN-006lMg-Kc
 for linux-nvme@lists.infradead.org; Mon, 28 Jun 2021 05:09:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1624856963; x=1656392963;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=K+N7WzraQJFm7/QZyWyAECF3SGKIa87fXwnEvSldguI=;
 b=pFfCGr8y4Eaec8clCH4bzGJlcCp8UqSCETXn1T0YfyBAkSaXZpp6wzrB
 S065yAW5HbenE9LG8KFQaLqZtz9a6Bb4PzUutyDGxrls+wQXqoPUFtfW7
 v+/q4fp5F6rGlKn/KWJmfmEzl7LSHrBc8FD0kvXUGtu9W5PoD8NaGQ7PL
 DdifRuRZgUIP5yOEurxMo+ZU44+P/KQd20AtDwZwv1R1Ix7uDtA1YeM6Y
 zoqd6p0ez1vunENovsEE04y/GU+dzliUi9JUTn3HsbcMfv7e7upK+4kV/
 VQ7EP235QOQpT3ytgAuimn+KXzrPSiuNRuBvijXQwP2sneZSpO6+FapFE g==;
IronPort-SDR: ETK7nEL0tzz7MJIkOVCOYtmzBcNoSbnBvVw+l/oE+7AeRghPQgeAC1sIxknGhDdsF0hZsO5HZj
 m1NMRZyr+WojpdJ+xuAhfZpPb3GjNg3fd2OwnYHZdJUayDP+TdHv2L3tEBpi8yHR2PlaVYRfbb
 nyzvXo+ZrtHhXtussmCQNOJQ3/89Z4M4sxzVeIHEiPE5UmdoLSknDkWq/QUcizIuvn6Rh74ll6
 tsAiOnvYuWiDSg60bQPHr3OBJcMiMb0ya37Bj1p46Byy/3RhQNwvuB2115izCHMI5AxaO8h76C
 2s8=
X-IronPort-AV: E=Sophos;i="5.83,305,1616428800"; d="scan'208";a="172308709"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 28 Jun 2021 13:09:22 +0800
IronPort-SDR: NdWEzPfuEj6r6y1n1WXNVYPehDODX9QjMkDg0+PSCfT/ZsFHD8C4j3w99B9Akz/boOLQlV+LDv
 R9eKVE16ngc1Q5Urp7kknMShS2+BF1nGkJt6CXRXnbiCLVZFWVwmh3rBlr57S2RmJTV2QOCp+r
 abZIS09q/SXFXN4MX/EWL6WSymE9sQywkeYqX77xcK3jhX+O9bPzVlliPdCvpKjdv79buN0Na8
 1sfLpHZARi0tqBSQLfHPpqObPTD4uh8NWJevt4J4IKhfZhJ34ev1irVCNFlFLWlXJEY4/dDNtB
 sfV3YMwZmUiL9/RVskDK1WMo
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jun 2021 21:46:33 -0700
IronPort-SDR: uZfS4939rtVI2z8T1xUflG3ZX5jaz4h6KZQTxK7KMyiUXHK5EJscPQlRRfcu9qSRGXZal+eJdC
 PaqNgZEf/NGlIVWPLjVFxuK9jH8GHahluYD3nJiOZxB4Spga020/Afhfo5VOzb9dO7DmYs+s5F
 PF1CTkWAKx0HO8izGBQ9oA+dqW1yS3bf2esGzBz0rd5SFvJDyvNYGdNF6lEBZhHCfnpviQIqHW
 CodM/Se2iUQFUrvnIellyzf9PVzjtiFJwKEqNmB8ZP2PN/V4tZxVIXFe5d68lXdKUrziXN2qlM
 9L0=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 27 Jun 2021 22:09:23 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de, sagi@grimberg.me,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 06/14] nvmet: remove repeated call for effects log page
Date: Sun, 27 Jun 2021 22:08:09 -0700
Message-Id: <20210628050817.19788-7-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210628050817.19788-1-chaitanya.kulkarni@wdc.com>
References: <20210628050817.19788-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210627_220923_802331_4CB17F96 
X-CRM114-Status: GOOD (  12.72  )
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

Return status from nvmet_execute_get_log_page_cmd_effects_ns() and
complete the request in nvmet_execute_get_log_page(). This reduces
number of repeated nvmet_req_complete() calls for log page
handlers.

Also, now we can get rid of the goto and out label needed for request
completion and directly return.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/admin-cmd.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 2b018b84bf3f..cf02d70dedeb 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -186,16 +186,14 @@ static void nvmet_get_cmd_effects_zns(struct nvme_effects_log *log)
 	log->iocs[nvme_cmd_zone_mgmt_recv]	= cpu_to_le32(1 << 0);
 }
 
-static void nvmet_execute_get_log_cmd_effects_ns(struct nvmet_req *req)
+static u16 nvmet_execute_get_log_cmd_effects_ns(struct nvmet_req *req)
 {
 	struct nvme_effects_log *log;
 	u16 status = NVME_SC_SUCCESS;
 
 	log = kzalloc(sizeof(*log), GFP_KERNEL);
-	if (!log) {
-		status = NVME_SC_INTERNAL;
-		goto out;
-	}
+	if (!log)
+		return NVME_SC_INTERNAL;
 
 	switch (req->cmd->get_log_page.csi) {
 	case NVME_CSI_NVM:
@@ -217,8 +215,8 @@ static void nvmet_execute_get_log_cmd_effects_ns(struct nvmet_req *req)
 	status = nvmet_copy_to_sgl(req, 0, log, sizeof(*log));
 free:
 	kfree(log);
-out:
-	nvmet_req_complete(req, status);
+
+	return status;
 }
 
 static u16 nvmet_execute_get_log_changed_ns(struct nvmet_req *req)
@@ -338,7 +336,8 @@ static void nvmet_execute_get_log_page(struct nvmet_req *req)
 		status = nvmet_execute_get_log_changed_ns(req);
 		break;
 	case NVME_LOG_CMD_EFFECTS:
-		return nvmet_execute_get_log_cmd_effects_ns(req);
+		status = nvmet_execute_get_log_cmd_effects_ns(req);
+		break;
 	case NVME_LOG_ANA:
 		return nvmet_execute_get_log_page_ana(req);
 	default:
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
