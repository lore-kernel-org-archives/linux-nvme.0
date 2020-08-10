Return-Path: <SRS0=L2sc=BU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 466E8C433E0
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2020 18:56:10 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1131E20774
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2020 18:56:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="x/SWSaRj";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="pQhOMtO6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1131E20774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=n0eNWzhrNydgNAmNPscx3bwuVP8Fhh3WhjRBobShxgc=; b=x/SWSaRjEo0YPgzYc7JDOtyNO
	9P9mpgRWlqaO+DCOq+ey0lPIZnUd0Qg6fBvBtmN8M/ng8i/l6Me/+RjuyZ4+Dgx6Ne6p+vrX9TFId
	PMWaMfVVkc43sxGAYmM0j6uxdea8m7EeuH71O1p06h3g95I5MSRM/G2aWuiiLaoq8MXLubm20TV/y
	4WckCd82hDWKDSWIA7UozVExua1xuiEH8wahPoXrMV9nDxbXx7qHBGqoEsMHZIvZtoEwJxCvGfisJ
	2z0JMiNb2IxnXJcXcR3sPPJXmxiJgzvdKmk11+vjP9N9eJK7RTUolxLkeSxnRSUJuzgLhoL5Y6t1l
	1WAVXJMTQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k5Cxr-0007DP-CT; Mon, 10 Aug 2020 18:56:07 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k5Cxo-0007C3-TQ
 for linux-nvme@lists.infradead.org; Mon, 10 Aug 2020 18:56:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1597085766; x=1628621766;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=xyNogZ4jocbc1XKbxQNWC0SilvNnJ+joFm8hjmukrGY=;
 b=pQhOMtO6e+ffkknriT9O6hCyrjdvnBm0HOlzHQsy0mwMe9rKZ2zm3zmz
 qK6N6M/3Wph0s+ZNYRagfDFXcyn/ewc9/f99zokjyMtcaNxnl42gU59sV
 ybzFUKf+Om06lQkMSTCN9KEDxrEdY6rvOmpbPW5afuvPPiG+i2MfK4l5O
 g1zoW5dwPL1awKlYn1is7NRvNFcxNKQhLAlAYBWPi/NYYFjuLw2Li7Uw1
 CKJh3BN57JM0R4SdN/AITKQjzdIE8zquvn9Ag7Bo72rDJKsCshZgM/Jda
 nxwXsyMRkFFJNCw8aHUCiOcQfzoqchLKLiwLXUxrQkh78dW+k7/OwOJoI g==;
IronPort-SDR: zULdLhJjWNxt0MHYs1hy9ZHanOZXcTta1INSUpS/0RKJ9pyHn7UVeRDqLywPYb3nQVjDgLo81s
 z8wXOvzHB8z773zA7wbYrcgoDcmZUsNtv7dA1J9HII24NhjbHJXF9UXNlDBTJlA5QX7erTvttk
 XBrLOeTpN3JEltccamIVNnThN83wb2Bwxc2qLNKPtG/Vpd1DfMoEPIX+FefixEbOAjuiGQ/wLU
 Caj+O/RWFYvV9yVO/a5PjAhbYtHiysZpJR8JEJs6KHfEDBhexpmPYjGdYLmTJ5EbzcUWh1uRFD
 6h0=
X-IronPort-AV: E=Sophos;i="5.75,458,1589212800"; d="scan'208";a="148924331"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 11 Aug 2020 02:56:05 +0800
IronPort-SDR: wSseo0/+w2YHB82vqjpJJlh1rYsNstDr1eik6Ce6EOwkJPn8X/aZvGCJ4GshFz984+YZQgZRgn
 gLhiNsrNEitg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Aug 2020 11:43:57 -0700
IronPort-SDR: auCSZzamL7HgXx7oHG1DF+ELPUzIsxjxgHly8IVgOMpUzhL4TACQDSxOIEhy1Z/2qSDZVsDBv2
 K2THFguUB4rw==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 10 Aug 2020 11:56:04 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 08/14] nvmet: use nvme write cmd group setting op_flag
Date: Mon, 10 Aug 2020 11:54:50 -0700
Message-Id: <20200810185456.7713-9-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20200810185456.7713-1-chaitanya.kulkarni@wdc.com>
References: <20200810185456.7713-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200810_145605_179581_67DDED92 
X-CRM114-Status: GOOD (  17.64  )
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
Cc: hch@lst.de, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The function nvme_is_write() only checks the last bit of the opcode to
determine if command is a write command or not based on that it sets
the bio->bi_opf for passthru bio with REQ_SYNC | REQ_IDLE.

The condition is true for nvme_cmd_write (opcode 0x01), but there are
commands present in the NVMe command set and are part for NVM Write
Command Group that doesn't have a last bit set. e.g.
nvme_cmd_write_zeroes 0x08. With current implementation for these
commands we will never set the REQ_SYNC for bio->bi_opf even though
command is from NVMe write command set.

For passthru backend introduce nvmet_write_cmd_group() and use the
commands from NVMe 1.4 spec write command group to set the REQ_SYNC
flag for passthru bio and update nvmet_passthru_map_sg accordingly.
Since these are low frequency commands annotate condition with
unlikely respectively.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/passthru.c | 31 ++++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index 0b18038c44bb..5f06f4290c52 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -176,6 +176,29 @@ static void nvmet_passthru_execute_cmd_work(struct work_struct *w)
 	nvmet_passthru_req_done(rq, 0 /* this value is not used for request */);
 }
 
+static inline bool nvmet_write_cmd_group(__u8 opcode)
+{
+	bool ret;
+
+	/* NVM Express Revision 1.4 Figure 462. */
+	switch (opcode) {
+	case nvme_admin_format_nvm:
+	case nvme_admin_ns_attach:
+	case nvme_admin_ns_mgmt:
+	case nvme_admin_sanitize_nvm:
+	case nvme_admin_security_send:
+	case nvme_cmd_write_zeroes:
+	case nvme_cmd_write_uncor:
+		ret = true;
+		break;
+	default:
+		ret = false;
+		break;
+	}
+
+	return ret;
+}
+
 static int nvmet_passthru_map_sg(struct nvmet_req *req, struct request *rq)
 {
 	unsigned int op_flags = 0;
@@ -184,10 +207,12 @@ static int nvmet_passthru_map_sg(struct nvmet_req *req, struct request *rq)
 	struct bio *bio;
 	int i, ret;
 
-	if (req->cmd->common.opcode == nvme_cmd_flush)
-		op_flags = REQ_FUA;
-	else if (nvme_is_write(req->cmd))
+	if (nvme_is_write(req->cmd))
 		op_flags = REQ_SYNC | REQ_IDLE;
+	else if (unlikely(nvmet_write_cmd_group(req->cmd->common.opcode)))
+		op_flags = REQ_SYNC;
+	else if (unlikely(req->cmd->common.opcode == nvme_cmd_flush))
+		op_flags = REQ_FUA;
 
 	bio = bio_alloc(GFP_KERNEL, min(sg_cnt, BIO_MAX_PAGES));
 	bio->bi_end_io = bio_put;
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
