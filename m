Return-Path: <SRS0=/Y//=CD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 686AEC433DF
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Aug 2020 10:00:48 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F9822075B
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Aug 2020 10:00:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="czGnGH53";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KeyDvF/0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F9822075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=NAgT7vGrcIWyCoHndyp5bzNx/DgDkHSGCWIfurGqyPA=; b=czGnGH53oskLMILNIkAqMfEurw
	Uq0epTwfWYEjZh/0qfnOc5ebBhqDhE6YfIDeFyv9ILSCel4cXqmoJ4iPsDoLtCYoILtLzlwbu++u/
	u63mqskTwtv9ofE9CiTpolofsrDkkpYjhiKueKFm4d9YmnEmDALs+gWB83CWvsH6J8YSmyDHY4i0e
	HfBzpXmH5UDcTefZ2D4OFecxpZfendc53aVM/Q9AtQHPF6Wamyt4UVz4Sd33hhYrcndOiwDn4Q1sF
	qzPSipsves7AF5AkS50nXCk4QEemK2NL5sag2rO0TmZYvESJa5wwTA06gqFBIhZ/yqoxj2UEju4EK
	kZru1K1A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kAVkt-0007hJ-EG; Tue, 25 Aug 2020 10:00:39 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kAVks-0007gj-0z
 for linux-nvme@merlin.infradead.org; Tue, 25 Aug 2020 10:00:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=x/fsC2QXiQ/OW0Z9fLQXA0wcdoOcWHu6ACzi1HPcNcE=; b=KeyDvF/0oBvyjiEozbR1ZcXQPq
 tSseHALQqKNgyGgxgUT3xCn0rA2zpLUiqZ3HXHUy3cqa161b3Sv0agb2wFqT7KELoBBXSAxpi3G6d
 fds9j0URQeCLtt6tVSiCT+Lr6W8z06IkNvS4UA1G4qmAXL2mmyvWEWP6FGXKTw0D46QxEz34HOZak
 BLqYqCK/ytzfGg1/ZcdXogpnFSsC4jZ6XU0wT7ATHieBGpmAWwK97pgLRakSgLPfGbaBHC5ZYpbba
 HH8XvQiHmM+msT5tF1nSuI1OoOLSlH/w6YaQ6tJ4UQd1JnWMVmGB44qghHJ1uCCiFKZ/scmkmk9vO
 l6JE+muQ==;
Received: from 213-225-6-196.nat.highway.a1.net ([213.225.6.196]
 helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kAVkp-0002rO-P7; Tue, 25 Aug 2020 10:00:36 +0000
From: Christoph Hellwig <hch@lst.de>
To: kbusch@kernel.org,
	sagi@grimberg.me
Subject: [PATCH] nvme: fix error handling in nvme_ns_report_zones
Date: Tue, 25 Aug 2020 11:58:24 +0200
Message-Id: <20200825095824.3542647-1-hch@lst.de>
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
index 57cfd78731fbbe..e7798804d5afab 100644
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
@@ -182,10 +160,18 @@ static int nvme_ns_report_zones(struct nvme_ns *ns, sector_t sector,
 			unsigned int nr_zones, report_zones_cb cb, void *data)
 {
 	struct nvme_zone_report *report;
+	struct nvme_command c = { };
 	int ret, zone_idx = 0;
 	unsigned int nz, i;
 	size_t buflen;
 
+	c.zmr.opcode = nvme_cmd_zone_mgmt_recv;
+	c.zmr.nsid = cpu_to_le32(ns->head->ns_id);
+	c.zmr.numd = cpu_to_le32(nvme_bytes_to_numd(buflen));
+	c.zmr.zra = NVME_ZRA_ZONE_REPORT;
+	c.zmr.zrasf = NVME_ZRASF_ZONE_REPORT_ALL;
+	c.zmr.pr = NVME_REPORT_ZONE_PARTIAL;
+
 	report = nvme_zns_alloc_report_buffer(ns, nr_zones, &buflen);
 	if (!report)
 		return -ENOMEM;
@@ -193,11 +179,13 @@ static int nvme_ns_report_zones(struct nvme_ns *ns, sector_t sector,
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
