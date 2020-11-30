Return-Path: <SRS0=wRjJ=FE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B742C63777
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Nov 2020 03:29:48 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A995620663
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Nov 2020 03:29:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lt6JFAWO";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="jA8rgonm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A995620663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Vj9GnsCyZ50ilbMAqraLDjDfa6v6YAyzZ7vXoAdpUpU=; b=lt6JFAWO05/s1JsP3+Wq7M1LF
	ImM6oG1nAnlGm/TjsjB89+H9PzfEbZzSzu5qCuYhHUPz9psCHfdcE+RO9gKLCqzgnuv2JMhKmhInB
	TPo7un0Gyi5sVeV64t0aPk/FcW78EfT/WKJaa7+fiGZ1IPDfWLX198lmP+5RymoNWyogLnY6Zdlha
	kRIzKhJ+Bi/vWs3JOui79PtvUXgqRjQgbuuP4BeQuKCSrY5gkBqdp8l2rRhWA7/t9FC3kOLvegxNG
	Qspu1CrHfQmW+vRmYqQ9UouRVg6HT61v/WKcLfG5jVnVsd3GcZccHNyjM6ojePUft9sUKTTAxnaf/
	ptUvFbN9A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kjZsn-0000eB-HP; Mon, 30 Nov 2020 03:29:45 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kjZsk-0000d5-Be
 for linux-nvme@lists.infradead.org; Mon, 30 Nov 2020 03:29:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1606706982; x=1638242982;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=AZ0ASPEdFnz/BJCpcrFT1z2buOCvE1xQZBqdQG2WuUM=;
 b=jA8rgonm7n6Pq42PzQwCYMNhgRRX/3S6Siv0xu/B1r+rBpdhqitR7ZkA
 YkHHh++e7zQgaGVRcvJxDKEYkfHXvHluDpGRLXFwRpX96CH3WbMcq2BnA
 1zDbKEtmd+c6gdCVyrBLb4MfMmSi4OOFsOgJcrP81PRYyqlTl0r/Ix35z
 Vm4kQidVkxUIXqLGqGOmsMOao29UteDwIcwOSj2cJPAarstqGh/XF3UAs
 rzl16Th74HbXmtnhbLvyffR8aJsqPp5CWHxiQhMY5dyigvL516o7CT0gA
 Ao+vGp7XE5axYzul2wMhnO+rlz5Q9AJLN7yGSjBffWGNbX9NBb765Qeyp g==;
IronPort-SDR: 1kyX5rSCTRhBo1UTD0IYe9LdE8n4af9+9xnpCGt5dCIRa2v6Z7Ss52WgKf/+OB9kniF2QUNK2R
 PngB98enVxPOceTSfObSqW84J0JQ372JFY+WusPSgo5jEwr9dbqcDjcNzH1KZfZHaWvijUxGrM
 4ln6sovqgJ1wuZeqoecJZvTyedHuvzo0YJxkHXnBIgXObrMk83MwkvEFyvMmqd+EO8t1JL453Z
 OgAyPkU4+RSJmadO1jUY/i43QEW88IH4nQbhA90ME+8XWVLfsbsjils6tqKnyWbYb9B3vsbH7U
 mgQ=
X-IronPort-AV: E=Sophos;i="5.78,379,1599494400"; d="scan'208";a="153710343"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 30 Nov 2020 11:29:39 +0800
IronPort-SDR: u9FHXcjX0Z/A2YhOr4VwNy8C8WisJR95ZQRlTHx28RoQh2Xrrt3XKhXCtIOgOrnwuQFcqaBnfW
 Aqv7bAjE+JSPpLVKBU9KfeWyZKOKNYES4=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Nov 2020 19:15:16 -0800
IronPort-SDR: yKyMZjhNk/mnExspfaixYDt4y+icg4sZftOOtN/oNyNL08lCZ87fPtnoUGYT879cStE/buz84X
 PWlWyymkpzAA==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 29 Nov 2020 19:29:39 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH V2 3/9] nvmet: trim down id-desclist to use req->ns
Date: Sun, 29 Nov 2020 19:29:03 -0800
Message-Id: <20201130032909.40638-4-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201130032909.40638-1-chaitanya.kulkarni@wdc.com>
References: <20201130032909.40638-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201129_222942_560575_92237970 
X-CRM114-Status: GOOD (  16.07  )
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
Cc: damien.lemoal@wdc.com, hch@lst.de,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, sagi@grimberg.me
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
