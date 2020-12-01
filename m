Return-Path: <SRS0=HgeD=FF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7634EC64E7A
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Dec 2020 04:14:53 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA38520725
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Dec 2020 04:14:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="0iZPOjGf";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="YuhIyqz+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA38520725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Vj9GnsCyZ50ilbMAqraLDjDfa6v6YAyzZ7vXoAdpUpU=; b=0iZPOjGfPtfFObjCfzd1Hlo3q
	zWt8EUtyRcfN82/7yICkVHqPjf4WKKIGMjcIMik536Jmhs49MXftxpqGEmYcC+SLcXzXOqars/ZEo
	GK7UgRqhsIbVUvKDGnMRo3nJXGcQmnvDhPLEb2h7p42IX78vhUjEEKbtFVt9p/L05RMuesFxSUgPn
	vOzxNidNRuc6wn4FiiaYHsluqr1HvU4z/GxYDn5+0dXV+8obhrhrNTDNN2H4zjFmHH/k6go4lI/WD
	2AO6Au53cvMQMU9BUA+22MwxsaynUwR2TfC8yT7S5nqVMezOFkI+dw8JhMCePoYMl+mhOtjr6jvrv
	rLvTN4UsQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kjx3y-0008KW-AW; Tue, 01 Dec 2020 04:14:50 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kjx3u-0008Jh-UG
 for linux-nvme@lists.infradead.org; Tue, 01 Dec 2020 04:14:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1606796086; x=1638332086;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=AZ0ASPEdFnz/BJCpcrFT1z2buOCvE1xQZBqdQG2WuUM=;
 b=YuhIyqz+70GEnnk7AgqDFwhBvRXGxDQhBS9PA3Zm7uFqtDBWEyzcQ28a
 2iBOrZOwygIPG8xwwwkdJQanFtKaMUPr+JhVlJlF1uVPkeVzwkx1ypr2M
 ZQ1v05z2pfuuMAQJSspY55u+6jQu0VamLj3xpz3Cp/VoOgg9WvIL060cQ
 YYIpXXayPx4ZXP+ouAVc8m9f/Xr4uzj1eJJg/p1Z8AhtDyGyxLxkt+Hll
 gr/LUnxFNYROnLu9WZ7AUdSidx4yYWXSGIla9agi5xtaFCVi2d9yJS1iM
 so3LemgjYDB6amcoaDUhv109wAFRYI4bId3N5RPT7RcLlc91r96NdUX8I g==;
IronPort-SDR: 7857yTwQVVSYXwf3aEqq89hCSDbydExLlMRVMeZMMCf6yUkj8Pw+y332+Yj5wZD4AJw95STI+N
 13Qr8Nh8mtMrFCWw+0pRrQ1VUNeAZpAWjvp9GWGi1nqEktjlujbcUIuqmsV+8k+LcL92vZoIsF
 W8ZtaAx3YCdWUjjQPB4iRRmhbPAjykT+D3GSyDd2H8spbeEP0xhaGetKX7YIez1Bsk0bZq9r43
 0katPgW6b8qtxKzsklV+wQ2tibifSERSX0iddIfVgQg5DspwmJHQ5kiT7HFcLGNJYsqwx2NWuV
 OME=
X-IronPort-AV: E=Sophos;i="5.78,383,1599494400"; d="scan'208";a="153948673"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 01 Dec 2020 12:14:45 +0800
IronPort-SDR: KFyCF1Idm7jHnbvCMLcYuFxyBsPeOSh0XLjkq833AawLWxEYrD9cIcpWE9k+WrHuKCHXK08s6Z
 tedkXtpMXogocNAUg2X+CpNcZeTjRHz0k=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Nov 2020 20:00:21 -0800
IronPort-SDR: YvkqHILlm6UWCuUEr04BRGq+HsD/5gFFCyYnGnQb47az3BFy7WnmUU7GIP53Lz78rLo1DN91hP
 I5qbVG31pwJA==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip01.wdc.com with ESMTP; 30 Nov 2020 20:14:46 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH V3 3/9] nvmet: trim down id-desclist to use req->ns
Date: Mon, 30 Nov 2020 20:14:10 -0800
Message-Id: <20201201041416.16293-4-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201201041416.16293-1-chaitanya.kulkarni@wdc.com>
References: <20201201041416.16293-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201130_231447_103013_1CB5CA46 
X-CRM114-Status: GOOD (  15.93  )
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
Cc: damien.lemoal@wdc.com, sagi@grimberg.me,
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
