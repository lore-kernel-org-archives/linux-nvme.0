Return-Path: <SRS0=VgBB=FA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFC2AC56201
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Nov 2020 02:41:36 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31937206C0
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Nov 2020 02:41:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="zoyfVt4U";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Ue2iaXQ/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31937206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Vj9GnsCyZ50ilbMAqraLDjDfa6v6YAyzZ7vXoAdpUpU=; b=zoyfVt4UNtemMapgrvQg4RbIR
	ddbCZJLIr9HXMyzwOezi9sZxxOrIxlaFy3NhbYNxZ+vpTtCF2Urk1d0v+DhVvAmYIrg3ivj/Ruwjg
	pBO1et4J578hagq26XjYhhkvNMh3loxLwG/RhVh96VB5SAnIo/1EFuaC9duNsFVoPsuLQCXBZbeMo
	ZmW5d+ptGc0vyp8o+c9SVmIZMCIh3bwtBjrkcHKQM+Ei/RYHj88hsQpS9yiDl4O334HjQud7joFcb
	eZWlhoE4+id/rcDbeZA/b4EN6PYCo5H4JW5baYHlQ8QUirZSWPTwKefTTDXql18PCschJ2E/6LfJU
	FYrc/3CPg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ki7Dw-0005CE-7E; Thu, 26 Nov 2020 02:41:32 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ki7Do-0005Ai-2a
 for linux-nvme@lists.infradead.org; Thu, 26 Nov 2020 02:41:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1606358484; x=1637894484;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=AZ0ASPEdFnz/BJCpcrFT1z2buOCvE1xQZBqdQG2WuUM=;
 b=Ue2iaXQ/etOO3Bks+Hm5vMi5XPGFYZNqrsX4V+Ks2tWPimstbOoEHF8y
 VS4CDpJgtcP3Oo8VSAMupBY35xks02d5um8T14l2Y0TwQ1El8FMPFFnkT
 Pggo5c035xL0FSGH0hD24G/ENA5ReyWRvRhw8ZyqybEBHtQydbrNqJoiK
 o4YqRzfFP18K3WdV78m1bhBE4Q2S7VmBap+9w8zJAbrvIcfEyIXQ4LIMT
 kcz4lFIgFtf6HXpBIv3ebhk9pUZzXZnyez5vlfgKKcCJTO5HgwEQWHiX+
 +UbwudbiGHwiXOl3f5Zi6xsUTAJsxZUXy5pxBe+D4yicVKP4RrrcQt7oG g==;
IronPort-SDR: FSV6Jps6g3VDSKqqXDyK8yLKz5/QOUi1XO92F1VQFSEvfY9Fg6sZxQUi6wdBcmVMmkpoOtD39h
 f90jLpgTSn/sxp1EmQ+EvysL4LErYibwH+owWCUXuGvG6fmJH+ZoP49umYUwgwvogqezQYKZAF
 5MIxb/5atF+SzXuyBi2LFMtNYEXJSjGZWhiRxHBohR4ofysuu5wuL1O7CyQW4m5WyUjRe5SrYZ
 2bHTHLVAyb/p4vJM43RkNRdGa0nQdMGN+RxHXsBy2hOam17jf+FwkJn6BYkCM/yrKdSyfcwQNp
 UG8=
X-IronPort-AV: E=Sophos;i="5.78,370,1599494400"; d="scan'208";a="153586895"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 26 Nov 2020 10:41:22 +0800
IronPort-SDR: PbR/x1eCUbXDiqkEQo1C5twxkMrItmdFc1KVnUeELlCMsIXBCqhewbN23Q85CjTPnFZ2zb9m8r
 uCuoyBh28YniymI8zevGtgkxJY1iSZr1A=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2020 18:25:44 -0800
IronPort-SDR: 6M/AGqqa8B8wT+HwqCGGNoUVwG/Vvh+SMKOzt3MgE0GbfsWhRRM+Vg2DtFwiAPAKEgXcQ27FEO
 Z4EcVAAbeCNw==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 25 Nov 2020 18:41:22 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH 3/9] nvmet: trim down id-desclist to use req->ns
Date: Wed, 25 Nov 2020 18:40:37 -0800
Message-Id: <20201126024043.3392-4-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201126024043.3392-1-chaitanya.kulkarni@wdc.com>
References: <20201126024043.3392-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201125_214126_037575_290E9F12 
X-CRM114-Status: GOOD (  15.81  )
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
Cc: sagi@grimberg.me, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 hch@lst.de
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
