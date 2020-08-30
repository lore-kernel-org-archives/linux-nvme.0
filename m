Return-Path: <SRS0=wYSH=CI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBE26C433E2
	for <linux-nvme@archiver.kernel.org>; Sun, 30 Aug 2020 10:00:26 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5821920714
	for <linux-nvme@archiver.kernel.org>; Sun, 30 Aug 2020 10:00:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CoXQsFlk";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HjgntuHm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5821920714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=KRQzJXAyvlRtWz9Q/vjg5rXPh5Q/TKtvdF1THCyb4zE=; b=CoXQsFlkqgahWbAEChBJXeCP3J
	aSN6ZXem8vZE+eqMHm+h3YS3v9Kuw0iw6k77VY0M1o2DR+GmZObnNP38tQSpoVys3Y8bd4+zEHVr3
	eu3GTCSvKs1me7TCiye6oLYsQKhDPinduAmiItxApj+maL0vOvZdKtBeNT7bl7osxFNELkfkCF36y
	7a47TLnCpdK5ROzYXQ4q4RPmL/b8WWDRo9AHYxNXv/nz2WbXK+qDYCPwudL3QaJjowZUlgQCW7yEy
	tFhm4I+CI1pwKjVL9neoZi+f5EHtPDqfYbIgsmq6DToo17UvgrXjsF/sJ37ZQnJxhOfBdH/M/S4eT
	tDJh51bg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kCK8H-0003gE-F7; Sun, 30 Aug 2020 10:00:17 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kCK8F-0003fs-9B
 for linux-nvme@merlin.infradead.org; Sun, 30 Aug 2020 10:00:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=u0gnNo/ZNfKI8Ru9huCNEUsTinKsQLxS83JOdz6jpCE=; b=HjgntuHmpbuBxyrkCfzhj7aYUy
 HF62uBrwIa9nNLnXaRYWaH9qHqUqs6bYE6EUsWZ6kqR8sGLu8OrD7mugTAS+uWSPiw0DNJtwmI+sZ
 exfl0w/S3+inNPkfWSXrJjsi0+Mz/pbn14awqr5tE9UwxfrDK15fNesdiHt7hDZrZvY/tTIrZiv0Y
 79CIjscf8woFkWGFEjXQR9vd7rjuaGPLI9kxpi4pGosoLNELtUwr1aeCqtXqIfuVekur3UnMsZ0sn
 iICEiNPrx1ZFM3B6gMhRDCe4NgcZ3tD4RmDnt5P2ZsF3BKsXGTUNngVZ4XOjKzJZT+zCv4YmAk7hJ
 /YN5Fexw==;
Received: from [2001:4bb8:18c:45ba:9892:9e86:5202:32f0] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kCK8C-0005La-Dy; Sun, 30 Aug 2020 10:00:13 +0000
From: Christoph Hellwig <hch@lst.de>
To: kbusch@kernel.org,
	sagi@grimberg.me
Subject: [PATCH v2] nvme: fix error handling in nvme_ns_report_zones
Date: Sun, 30 Aug 2020 12:00:10 +0200
Message-Id: <20200830100010.1262680-1-hch@lst.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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
Cc: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

nvme_submit_sync_cmd can return positive NVMe error codes in addition to
the negative Linux error code, which are currently ignored.  Fix this
by removing __nvme_ns_report_zones and handling the errors from
nvme_submit_sync_cmd in the caller instead of multiplexing the return
value and the zone size into a single return value.

Fixes: 240e6ee272c0 ("nvme: support for zoned namespaces")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/zns.c | 38 +++++++++++++-------------------------
 1 file changed, 13 insertions(+), 25 deletions(-)

diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
index 57cfd78731fbbe..b4f0543d74700e 100644
--- a/drivers/nvme/host/zns.c
+++ b/drivers/nvme/host/zns.c
@@ -133,28 +133,6 @@ static void *nvme_zns_alloc_report_buffer(struct nvme_ns *ns,
 	return NULL;
 }
 
-static int __nvme_ns_report_zones(struct nvme_ns *ns, sector_t sector,
-				  struct nvme_zone_report *report,
-				  size_t buflen)
-{
-	struct nvme_command c = { };
-	int ret;
-
-	c.zmr.opcode = nvme_cmd_zone_mgmt_recv;
-	c.zmr.nsid = cpu_to_le32(ns->head->ns_id);
-	c.zmr.slba = cpu_to_le64(nvme_sect_to_lba(ns, sector));
-	c.zmr.numd = cpu_to_le32(nvme_bytes_to_numd(buflen));
-	c.zmr.zra = NVME_ZRA_ZONE_REPORT;
-	c.zmr.zrasf = NVME_ZRASF_ZONE_REPORT_ALL;
-	c.zmr.pr = NVME_REPORT_ZONE_PARTIAL;
-
-	ret = nvme_submit_sync_cmd(ns->queue, &c, report, buflen);
-	if (ret)
-		return ret;
-
-	return le64_to_cpu(report->nr_zones);
-}
-
 static int nvme_zone_parse_entry(struct nvme_ns *ns,
 				 struct nvme_zone_descriptor *entry,
 				 unsigned int idx, report_zones_cb cb,
@@ -182,6 +160,7 @@ static int nvme_ns_report_zones(struct nvme_ns *ns, sector_t sector,
 			unsigned int nr_zones, report_zones_cb cb, void *data)
 {
 	struct nvme_zone_report *report;
+	struct nvme_command c = { };
 	int ret, zone_idx = 0;
 	unsigned int nz, i;
 	size_t buflen;
@@ -190,14 +169,23 @@ static int nvme_ns_report_zones(struct nvme_ns *ns, sector_t sector,
 	if (!report)
 		return -ENOMEM;
 
+	c.zmr.opcode = nvme_cmd_zone_mgmt_recv;
+	c.zmr.nsid = cpu_to_le32(ns->head->ns_id);
+	c.zmr.numd = cpu_to_le32(nvme_bytes_to_numd(buflen));
+	c.zmr.zra = NVME_ZRA_ZONE_REPORT;
+	c.zmr.zrasf = NVME_ZRASF_ZONE_REPORT_ALL;
+	c.zmr.pr = NVME_REPORT_ZONE_PARTIAL;
+
 	sector &= ~(ns->zsze - 1);
 	while (zone_idx < nr_zones && sector < get_capacity(ns->disk)) {
 		memset(report, 0, buflen);
-		ret = __nvme_ns_report_zones(ns, sector, report, buflen);
-		if (ret < 0)
+
+		c.zmr.slba = cpu_to_le64(nvme_sect_to_lba(ns, sector));
+		ret = nvme_submit_sync_cmd(ns->queue, &c, report, buflen);
+		if (ret)
 			goto out_free;
 
-		nz = min_t(unsigned int, ret, nr_zones);
+		nz = min((unsigned int)le64_to_cpu(report->nr_zones), nr_zones);
 		if (!nz)
 			break;
 
-- 
2.28.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
