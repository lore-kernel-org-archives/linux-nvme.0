Return-Path: <SRS0=R6Dd=FG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF28AC64E7C
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Dec 2020 06:23:23 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B776221E9
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Dec 2020 06:23:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B776221E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Vj9GnsCyZ50ilbMAqraLDjDfa6v6YAyzZ7vXoAdpUpU=; b=HlcN9FOzOIloz5ctaFMKqVk/Z
	sN1Wd0VidRO731Yen/QmcbEkaoU+ECa8g8pTlsKNxfuaoDGUItgRSvdOEy/bHFFjP1uhxYDaQqLn8
	i8xUgTwlyqDM34wxAlEpoUZQ6GxTK+jaxE+bgKiIKOuDiyOquNoDgBGKcErB2xAkkRC5oksYpacKW
	045FxFhEgoDXowrmyazMephbVCXhrLQ3GZaYfEeFHXfrF35MbrJbWY19EDheJXByJSm5yXbnAP7A8
	KM+/vxLM87zZhlINX5QYcMVGSpbZRlV2HxmraPv+OQjz9LJxKITxFLBF3NNoSAXDr68sXDnk+8Fc/
	aspkZm+wg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kkLXt-0005TU-4h; Wed, 02 Dec 2020 06:23:21 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kkLXq-0005RE-MM
 for linux-nvme@lists.infradead.org; Wed, 02 Dec 2020 06:23:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1606890198; x=1638426198;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=AZ0ASPEdFnz/BJCpcrFT1z2buOCvE1xQZBqdQG2WuUM=;
 b=Nl2JAz3NoOFqsEOC4qvdxJ4OyJ3hfMeW1fKDCbnRvuVm6c7r71ziT6Fg
 OttAainUOXIddPhXLqbjl+pX7zHslvTlKXXhYy/CCTKsWEFPmfQCl3wpe
 gfR8uPR+Fck27rTMj9ofz8JQYtNGwIJ2bdJImTGuBrhYHFUav+Anfj+d+
 QkreWyUo+ZjP0K5H2+hC+ftLZ1mW5lTJeileqMoKRiH2pHZxSqh7qzsC9
 7dMs4QBRK9Imxy8g+QoTrJFY+hJdiXdm36jAtu7efwle5Utuux3WIPEjN
 xAQPGTxLp8J1s4Q1dW8e5vYuEqFbeKgv4bj1Pix0tOByf/5Jr8qkQ3Wk9 A==;
IronPort-SDR: ge0NhQQOkf8Wq/PhN5KyZ/31pAvLgGx/dmiNLSfqRAFkhdPKMAeWXGv6MfZdmyHmpYLX4nQmOI
 CNsd/FHcCEVuOqwsLYHSJVvArj+V2ff0yQccE8s92C5SDtw1Oml7zc/UqBu4/Qt5I4bqyWWqFs
 mdBcmbGLZindPOLNbTPcDmYAeFwK0QkO6+RyqamOsAsXESZpoL324bo47Qh22CzFyP6SQzhwuD
 r+3UPtM1w9VawV7jIbnhrjz+ns2WfV6acQsyRauSu/7V9bkDzUHzwG6DzqnnzI4qa1DFH7SAIG
 eNw=
X-IronPort-AV: E=Sophos;i="5.78,385,1599494400"; d="scan'208";a="158458567"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 02 Dec 2020 14:23:18 +0800
IronPort-SDR: T/J3iRHwSS5RvKBdq9IX/3WjEprFl6JMgHivvpdaUV5ZuLYYpfexEetBUWt8TGExFeQYQ/tPEs
 plaf+VDD6DLqRoUUs5z5VqprGvL/GjUgk=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Dec 2020 22:07:29 -0800
IronPort-SDR: fvXvnYvW9CCbCNopboqCW4f6IOoKH6Nck7dA8qsIR76ZNVYo2e/bbbjNBVwvIGFL5YW+QXrNLm
 ves4U1GKZuQQ==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 01 Dec 2020 22:23:18 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH V4 3/9] nvmet: trim down id-desclist to use req->ns
Date: Tue,  1 Dec 2020 22:22:21 -0800
Message-Id: <20201202062227.9826-4-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201202062227.9826-1-chaitanya.kulkarni@wdc.com>
References: <20201202062227.9826-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201202_012318_945881_E87A2B87 
X-CRM114-Status: GOOD (  15.00  )
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
Cc: johannes.thumshirn@wdc.com, damien.lemoal@wdc.com, sagi@grimberg.me,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

In this prep patch we remove the extra local variable struct nvmet_ns
in nvmet_execute_identify_desclist() since req already has the member
that can be reused, this also eliminates the explicit call to
nvmet_put_namespace() which is already present in the request
completion path.

This reduces the arguments to the function in the following patch to
implement the ZNS for bdev-ns so we can get away with passing the req
argument instead of req and ns.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/admin-cmd.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 509fd8dcca0c..c64b40c631e0 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -603,37 +603,35 @@ u16 nvmet_copy_ns_identifier(struct nvmet_req *req, u8 type, u8 len,
 
 static void nvmet_execute_identify_desclist(struct nvmet_req *req)
 {
-	struct nvmet_ns *ns;
 	u16 status = 0;
 	off_t off = 0;
 
-	ns = nvmet_find_namespace(req->sq->ctrl, req->cmd->identify.nsid);
-	if (!ns) {
+	req->ns = nvmet_find_namespace(req->sq->ctrl, req->cmd->identify.nsid);
+	if (!req->ns) {
 		req->error_loc = offsetof(struct nvme_identify, nsid);
 		status = NVME_SC_INVALID_NS | NVME_SC_DNR;
 		goto out;
 	}
 
-	if (memchr_inv(&ns->uuid, 0, sizeof(ns->uuid))) {
+	if (memchr_inv(&req->ns->uuid, 0, sizeof(req->ns->uuid))) {
 		status = nvmet_copy_ns_identifier(req, NVME_NIDT_UUID,
 						  NVME_NIDT_UUID_LEN,
-						  &ns->uuid, &off);
+						  &req->ns->uuid, &off);
 		if (status)
-			goto out_put_ns;
+			goto out;
 	}
-	if (memchr_inv(ns->nguid, 0, sizeof(ns->nguid))) {
+	if (memchr_inv(req->ns->nguid, 0, sizeof(req->ns->nguid))) {
 		status = nvmet_copy_ns_identifier(req, NVME_NIDT_NGUID,
 						  NVME_NIDT_NGUID_LEN,
-						  &ns->nguid, &off);
+						  &req->ns->nguid, &off);
 		if (status)
-			goto out_put_ns;
+			goto out;
 	}
 
 	if (sg_zero_buffer(req->sg, req->sg_cnt, NVME_IDENTIFY_DATA_SIZE - off,
 			off) != NVME_IDENTIFY_DATA_SIZE - off)
 		status = NVME_SC_INTERNAL | NVME_SC_DNR;
-out_put_ns:
-	nvmet_put_namespace(ns);
+
 out:
 	nvmet_req_complete(req, status);
 }
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
