Return-Path: <SRS0=8S6Q=LW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86568C2B9F4
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Jun 2021 05:09:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40F3C60E0B
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Jun 2021 05:09:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40F3C60E0B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4txuJKzElUwztkWLszcxRupnh3wkHf8kUZMhhUeGt/Y=; b=oJb6x4T18XQJ6f
	frALSNS9acY+f/FpFCA4/6nYX99Hozt+FM5lPJsYsPbZEnMIQB1vC1E6rE+bpgOilpblGla423B9m
	45EOuHMI7SMyr572ANh8qs+REMre9VvE/MYNrkYhWlVExhVXr6Xb7gUk1hhsdt1vRs14W9kg3Bufg
	eaaP3wk/rDn9ZqRML9C11Q8uvOPqF1TFQjIv7np+agaVYSV6KYLDImjtF8EMO8PI9ONhjUdphv8jt
	iVUmOPh1Zh133zwN6tPAaljtuaVIefvCzUNWjigt5yavTI/RppcOcKEeiDd8pyD0rsAAHORnE6xSB
	0aip97xFKaTyhr3N87fg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lxjWK-006lLj-QT; Mon, 28 Jun 2021 05:09:20 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lxjW5-006lGi-K3
 for linux-nvme@lists.infradead.org; Mon, 28 Jun 2021 05:09:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1624856945; x=1656392945;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=I1vVdpH/cH/SRI9nj9M2yAzYQAB99BdEJqKjJPeunJU=;
 b=E0b28XqsAQxa7lgJBItX804foGxenfPlaRxtBmXhQ7Gq4eWI3uu7uFx4
 Kiw5D2XLB1In8LdpSp1cOFqrYDm84rTfE1YenVCQ3nEYsFDGjwCt6r0sV
 QZTF4QqtDo3D8PHc/MV+yb2BSB29PjmRJ+BQQ+zMtCfWnreH1qFoQy3Lx
 xczyioA7X/wU9kX8Z/V0JnyVpJ4lVOhKguRfN1aXVKSm048caNHFkxD9P
 WIyW1Xm0e+HUaJu7Tc6ekV84uiNbVECec947td8W0ySwit0paVSGztoUS
 ZjeuIaNsCDjJOuuuS4QnUWA9hYbAgmL2tTHVF/9mhwo5V5pxjr5xtmqxW Q==;
IronPort-SDR: s4JevBjLPrdr0kfQ4vEF8sSJBaxBBjH32eLlQJI70iF+iygZgKssJQkvCdMETr+3CIaEB1Ac7v
 tE7dapZ2SqTp8aHQxSpeUKZtcAGi8udAk9L+emQkbH7vLTTGtMNBx3U+0eNZy3D+UtvU/V2vdx
 gYa4qaAEmd2N+F5sOy2zb/tUPP7XxZUnuXskSrZcEwpV7NMlt6Hfpivjq3fOiTQFuefcl9FWou
 cKLslrl0R2I9I1SArScTnOtMqkS/yFQMn/Ad3Y8a5C8ld+BAhKz3GsV77OBOX2ssgeKwVefbmW
 F7k=
X-IronPort-AV: E=Sophos;i="5.83,305,1616428800"; d="scan'208";a="172308682"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 28 Jun 2021 13:09:02 +0800
IronPort-SDR: saZELGYmcs3prw8Lsq8YqXg6yrERxHilDbPB51J7X9cZkGkHT+Uge5aF1TsbUc9KSnQZGqzStS
 NG3fe25+VO0pn4YLv8fKe59WL21dhqtLxR4foZSZcjPlnsNKCT5l3ollB2b3fcUYucbxvsN/8M
 FP+9GzrknH9n3gObDBWAFm+09XUfrb6H66awdxe3x5SlEorD8dCS3EJ3Su+i/ump4cTK9mVFPf
 Byyi+NcIsXtowK5IFY6Evi4N4TxW/soU04z52zbKU0s1E5Bi80jrkwA6a9ucb2QuERP/MSQsoi
 CYIscMcgxUVdXMaD4H39g5Mj
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jun 2021 21:46:13 -0700
IronPort-SDR: 5fthpGCo0Vhco4+dLeRCMWGSaeXPXMnlvb4UlfADoZGqYRovKIdJf4/xCj16s75IDmqSFFasc4
 xCFq0FldDdcPegeGYEn1zrpYHzntWya+fi3UnW53e8Dbw5WKWhdHZ1jLjRWXEY1inhjZpXdyXz
 5dYhFenkc3K95u+4tpygxXHpaXJljoINXArVg68mVxzP7LOkfcUEdy8i1nTQvQwbdSiCSdESZu
 32kWzwXUeAfA2anzWVYuEh5g5yOQT9bfkJm3rHWk62MQF1wYFpsP7KJEQUnohfh2UJkSxt7NV/
 aK4=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 27 Jun 2021 22:09:03 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de, sagi@grimberg.me,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 04/14] nvmet: remove repeated call for fw slot log page
Date: Sun, 27 Jun 2021 22:08:07 -0700
Message-Id: <20210628050817.19788-5-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210628050817.19788-1-chaitanya.kulkarni@wdc.com>
References: <20210628050817.19788-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210627_220905_768447_DF19DA1D 
X-CRM114-Status: GOOD (  11.94  )
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

Return status from nvmet_execute_get_log_page_noop() and complete the
request in nvmet_execute_get_log_page(). This reduces number of
repeated nvmet_req_complete() calls for log page handlers.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/admin-cmd.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 079fe04d0ee6..8c798559f1cc 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -40,9 +40,9 @@ u64 nvmet_get_log_page_offset(struct nvme_command *cmd)
 	return le64_to_cpu(cmd->get_log_page.lpo);
 }
 
-static void nvmet_execute_get_log_page_noop(struct nvmet_req *req)
+static u16 nvmet_execute_get_log_page_noop(struct nvmet_req *req)
 {
-	nvmet_req_complete(req, nvmet_zero_sgl(req, 0, req->transfer_len));
+	return nvmet_zero_sgl(req, 0, req->transfer_len);
 }
 
 static u16 nvmet_execute_get_log_page_error(struct nvmet_req *req)
@@ -332,7 +332,8 @@ static void nvmet_execute_get_log_page(struct nvmet_req *req)
 		 * active, so we can zero out the whole firmware slot log and
 		 * still claim to fully implement this mandatory log page.
 		 */
-		return nvmet_execute_get_log_page_noop(req);
+		status = nvmet_execute_get_log_page_noop(req);
+		break;
 	case NVME_LOG_CHANGED_NS:
 		return nvmet_execute_get_log_changed_ns(req);
 	case NVME_LOG_CMD_EFFECTS:
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
