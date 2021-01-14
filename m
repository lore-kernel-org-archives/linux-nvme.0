Return-Path: <SRS0=kiw1=GR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 154A1C433DB
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 01:34:35 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97A7423435
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 01:34:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97A7423435
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=cyKX+UWJokETjcoeTrM5XwyJlwoU3xVZOJAGMDl24os=; b=IjZal+JSzUZHX0D92USm9gI8j
	oPGuC2d6ifdLOKNvTt30wkJA0Ht7BuuIAjOngXpHTkb7rhTT+X7TyyKm4ytmNw6dsJQwLWopqveQf
	j9wpLy4xB+32fFeXLXfJF8JbChe38ZfRHmxKc11Xd425jv85hj38pyF7aXOXtlPHwyJ0tx9d6GtC/
	7CMeunbX6+5RkbgXoqe5q7GzBVDxuMY1TrYnPVD3atf8b5M19n0MyCIyPeeo0OZ0TL19xcx60CB9v
	mZyomvogbJeQLyH7gK66TkX2WiITVhvS944Ox+/uYn3YPJTlGYVs0nj+ZE9RlKwX+7mgxuvttL1Hg
	aiNsSNWeA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kzrWk-0006iT-Vd; Thu, 14 Jan 2021 01:34:19 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kzrWg-0006gx-FB
 for linux-nvme@lists.infradead.org; Thu, 14 Jan 2021 01:34:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1610589011; x=1642125011;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=9aCEvoSMpbURSKTFvDbIjRBs7Qty25CGkczmyRXqpwQ=;
 b=NX2fLVwDcis4GyMttO3IUeI7Ek4SKyOgrm3dq68dUv5V4GDI4Li28usw
 YscZgFBOnaIZ+yqwBIPuiJxRAwo7YCO7hHqHt9+aaXbooM9xRKfUqABwa
 GQDt3UWaoIAbhOi60nQVvcgPv8eEjtyJPmb8V90X+tzNHWjokt4NsvTO5
 B3m5/T+hfxELkkY7WHf02Hqu9Yx5LzqLMheoqSKfyE1Vz9w0OHPL673SU
 EgAKC9vDwBd8zEJvKuDt26cnloSspgmuuSyHo/9dxrLikzkUPQo/LbQn/
 1fZv8e81QGIzvFqmdkazucHPOmk+zNx1aaiMWwcd6WuwF4Gu8yhyfgubl Q==;
IronPort-SDR: vxloL910Q607/78skPOCJ7kIIUDo5j1ggefvYeb31t+JIVbQl4JcxWs7JcX+djTm3dffjHtlJs
 3fuknHdSb6ExfoYy+R5AlVcNvA3e61JFLZe/Xo/ae+p/2XBJ8zLrxxkW00eZ+y/wrb6zt91CI+
 FrsgEHR0gO9qlJLnPzpL2RyZw9OtaLGSdNLEuB7bct6ftxmzAAcUPM4uPz6XaHMAd2aSIaQ9CL
 qpRf/2Do7OecCfMYd/wAd8kzQ/A4AgRF1EgFeShHVrFjdzN0DVObxv3FP5FrK01SJuS3pltHIc
 bSI=
X-IronPort-AV: E=Sophos;i="5.79,345,1602518400"; d="scan'208";a="261291927"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 14 Jan 2021 09:50:10 +0800
IronPort-SDR: kEClWRA8Fvw0y+oFHEfywATO61m0XD4S6u9sk+yBiyrTsZQKMx6e4eU/d/knT3zL/TiXbBhab7
 mERkrsFQnmL+gSpZmwXFa+h/Fl3xPyjOawGUTfhUInrGKcjMZ7mU/egtoz889S7eeEH/bD1Opk
 wXFAD3x1HCd9EYfqmnG/3Gg33X6JWNEqH2IVumQ8moVmagBVAfAsWLGjQccoY3ywhefUZWRkI/
 SaDgNotRqOP67sX3rFNnz5CqjznSG5zw8OXzUjDnwE52i2kIXsxSKX/CQj8RBm+Xamb3gHAhpr
 K6LV4mfoxY8Yjm/8yqmlzEjS
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jan 2021 17:18:56 -0800
IronPort-SDR: t1+9ncVK7W9eSTQ2/RmIiv25k+TTj5KXwhIvDvhswmTkwOutPN1Sm+lsxBfaa1bKnZ3CGFVR7x
 sltXhQnmAxUrzosqXw1rsc6tW+OSUpi82g8q3TIZ72jTClx3NWPdg7aniq+WuFmvhzuV7aHw/s
 bN+8kmVUT1EHQgdFeUR15z//8Tc7MlkyCW/+UjCMymxH7701zKzikhMoXTGindDS56miJBNhYm
 LIsWcnjU6w+bs86bKgyvq6N2VsrnMWrRBmgGUo5tdBv31s6gCrgd9evUMTZF2b3vfmSZkbwPss
 UD0=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 13 Jan 2021 17:34:13 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V4 2/4] nvmet: remove extra variable in smart log nsid
Date: Wed, 13 Jan 2021 17:33:52 -0800
Message-Id: <20210114013354.33946-3-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20210114013354.33946-1-chaitanya.kulkarni@wdc.com>
References: <20210114013354.33946-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210113_203414_690462_87E3690E 
X-CRM114-Status: GOOD (  14.49  )
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

We remove the extra local variable struct nvmet_ns in
nvmet_get_smart_log_nsid() since req already has ns member that can be
reused, this also eliminates the explicit call to nvmet_put_namespace()
which is already present in the request completion path.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/admin-cmd.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index dc1ea468b182..de804d9762dd 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -74,11 +74,11 @@ static void nvmet_execute_get_log_page_error(struct nvmet_req *req)
 static u16 nvmet_get_smart_log_nsid(struct nvmet_req *req,
 		struct nvme_smart_log *slog)
 {
-	struct nvmet_ns *ns;
 	u64 host_reads, host_writes, data_units_read, data_units_written;
 
-	ns = nvmet_find_namespace(req->sq->ctrl, req->cmd->get_log_page.nsid);
-	if (!ns) {
+	req->ns = nvmet_find_namespace(req->sq->ctrl,
+				       req->cmd->get_log_page.nsid);
+	if (!req->ns) {
 		pr_err("Could not find namespace id : %d\n",
 				le32_to_cpu(req->cmd->get_log_page.nsid));
 		req->error_loc = offsetof(struct nvme_rw_command, nsid);
@@ -86,22 +86,20 @@ static u16 nvmet_get_smart_log_nsid(struct nvmet_req *req,
 	}
 
 	/* we don't have the right data for file backed ns */
-	if (!ns->bdev)
-		goto out;
+	if (!req->ns->bdev)
+		return NVME_SC_SUCCESS;
 
-	host_reads = part_stat_read(ns->bdev, ios[READ]);
+	host_reads = part_stat_read(req->ns->bdev, ios[READ]);
 	data_units_read =
-		DIV_ROUND_UP(part_stat_read(ns->bdev, sectors[READ]), 1000);
-	host_writes = part_stat_read(ns->bdev, ios[WRITE]);
+		DIV_ROUND_UP(part_stat_read(req->ns->bdev, sectors[READ]), 1000);
+	host_writes = part_stat_read(req->ns->bdev, ios[WRITE]);
 	data_units_written =
-		DIV_ROUND_UP(part_stat_read(ns->bdev, sectors[WRITE]), 1000);
+		DIV_ROUND_UP(part_stat_read(req->ns->bdev, sectors[WRITE]), 1000);
 
 	put_unaligned_le64(host_reads, &slog->host_reads[0]);
 	put_unaligned_le64(data_units_read, &slog->data_units_read[0]);
 	put_unaligned_le64(host_writes, &slog->host_writes[0]);
 	put_unaligned_le64(data_units_written, &slog->data_units_written[0]);
-out:
-	nvmet_put_namespace(ns);
 
 	return NVME_SC_SUCCESS;
 }
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
