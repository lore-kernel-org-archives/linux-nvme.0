Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48558CFC535
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Oct 2024 10:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AJCIgOT/feCjiFVDiA9sDiHZWeW8/E/JWoeAqgUa8nA=; b=NdxYbkyy61pbpYvASTZMYn20KM
	v+xQqbhrErVpVw8XbAbOToxR2sN7uUSp3Wo8Zi/P9w6Uq5XQ2XM2JiquvDs8MwpePKFRqCfk4FD8E
	81c95IlVx15YTUKrycA4CeHbIxH0KVY1ouyq+6Hw6yKWnOI5xsgiPdVsvf5kmf6csot/I3cJP1gWt
	cutJGPB6ApKJHlqr6Xq11xke2LrAcZjKV487PdgVdmlLzvFZ4VjdK9K8wKvskZf+w4MagFpLP75h8
	HuVife5EBB3wuGELMgDI6C+EFAMgnONyhv2uFprTS+pXxN9dADjvmb3DifS45OZ6ZQout3EUHfnGv
	Rrm7meQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t0IAx-00000004g13-2alW;
	Mon, 14 Oct 2024 10:19:43 +0000
Received: from out30-118.freemail.mail.aliyun.com ([115.124.30.118])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t0I6Z-00000004fRb-0vRg
	for linux-nvme@lists.infradead.org;
	Mon, 14 Oct 2024 10:15:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728900908; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=AJCIgOT/feCjiFVDiA9sDiHZWeW8/E/JWoeAqgUa8nA=;
	b=IOKzowr6HloJdp7uBRGF8tXpsEMivR6DSJV88RU+LXX14PFeWrUGgVivGz6lz0O2bGAik9VBLk9FCV7NBJCjw6QmrwQIghG0RKBJh+Kw9aCiQoDxwoO0HOYBGiXxiD2NmajoBY428ElPHrTfQnHodz9cUnh3rpItRp86dZC/zEE=
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WH4T2T8_1728900903 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 14 Oct 2024 18:15:08 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH 1/2] nvme: parse reservation commands's action and rtype to string
Date: Mon, 14 Oct 2024 18:14:57 +0800
Message-ID: <20241014101458.80491-2-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241014101458.80491-1-kanie@linux.alibaba.com>
References: <20241014101458.80491-1-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241014_031511_454972_33E36156 
X-CRM114-Status: UNSURE (   9.53  )
X-CRM114-Notice: Please train this message.
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Parse reservation commands's action(including rrega, racqa and rrela)
and rtype to string to make the trace log more human-readable.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/nvme/host/trace.c | 58 +++++++++++++++++++++++++++++++++++----
 1 file changed, 52 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/trace.c b/drivers/nvme/host/trace.c
index 87c437fc070d..ad25ad1e4041 100644
--- a/drivers/nvme/host/trace.c
+++ b/drivers/nvme/host/trace.c
@@ -228,27 +228,61 @@ static const char *nvme_trace_zone_mgmt_recv(struct trace_seq *p, u8 *cdw10)
 
 static const char *nvme_trace_resv_reg(struct trace_seq *p, u8 *cdw10)
 {
+	static const char * const rrega_strs[] = {
+		[0x00] = "register",
+		[0x01] = "unregister",
+		[0x02] = "replace",
+	};
 	const char *ret = trace_seq_buffer_ptr(p);
 	u8 rrega = cdw10[0] & 0x7;
 	u8 iekey = (cdw10[0] >> 3) & 0x1;
 	u8 ptpl = (cdw10[3] >> 6) & 0x3;
+	const char *rrega_str;
+
+	if (rrega < ARRAY_SIZE(rrega_strs) && rrega_strs[rrega])
+		rrega_str = rrega_strs[rrega];
+	else
+		rrega_str = "reserved";
 
-	trace_seq_printf(p, "rrega=%u, iekey=%u, ptpl=%u",
-			 rrega, iekey, ptpl);
+	trace_seq_printf(p, "rrega=%u:%s, iekey=%u, ptpl=%u",
+			 rrega, rrega_str, iekey, ptpl);
 	trace_seq_putc(p, 0);
 
 	return ret;
 }
 
+static const char * const rtype_strs[] = {
+	[0x00] = "reserved",
+	[0x01] = "write exclusive",
+	[0x02] = "exclusive access",
+	[0x03] = "write exclusive registrants only",
+	[0x04] = "exclusive access registrants only",
+	[0x05] = "write exclusive all registrants",
+	[0x06] = "exclusive access all registrants",
+};
+
 static const char *nvme_trace_resv_acq(struct trace_seq *p, u8 *cdw10)
 {
+	static const char * const racqa_strs[] = {
+		[0x00] = "acquire",
+		[0x01] = "preempt",
+		[0x02] = "preempt and abort",
+	};
 	const char *ret = trace_seq_buffer_ptr(p);
 	u8 racqa = cdw10[0] & 0x7;
 	u8 iekey = (cdw10[0] >> 3) & 0x1;
 	u8 rtype = cdw10[1];
+	const char *racqa_str = "reserved";
+	const char *rtype_str = "reserved";
 
-	trace_seq_printf(p, "racqa=%u, iekey=%u, rtype=%u",
-			 racqa, iekey, rtype);
+	if (racqa < ARRAY_SIZE(racqa_strs) && racqa_strs[racqa])
+		racqa_str = racqa_strs[racqa];
+
+	if (rtype < ARRAY_SIZE(rtype_strs) && rtype_strs[rtype])
+		rtype_str = rtype_strs[rtype];
+
+	trace_seq_printf(p, "racqa=%u:%s, iekey=%u, rtype=%u:%s",
+			 racqa, racqa_str, iekey, rtype, rtype_str);
 	trace_seq_putc(p, 0);
 
 	return ret;
@@ -256,13 +290,25 @@ static const char *nvme_trace_resv_acq(struct trace_seq *p, u8 *cdw10)
 
 static const char *nvme_trace_resv_rel(struct trace_seq *p, u8 *cdw10)
 {
+	static const char * const rrela_strs[] = {
+		[0x00] = "release",
+		[0x01] = "clear",
+	};
 	const char *ret = trace_seq_buffer_ptr(p);
 	u8 rrela = cdw10[0] & 0x7;
 	u8 iekey = (cdw10[0] >> 3) & 0x1;
 	u8 rtype = cdw10[1];
+	const char *rrela_str = "reserved";
+	const char *rtype_str = "reserved";
+
+	if (rrela < ARRAY_SIZE(rrela_strs) && rrela_strs[rrela])
+		rrela_str = rrela_strs[rrela];
+
+	if (rtype < ARRAY_SIZE(rtype_strs) && rtype_strs[rtype])
+		rtype_str = rtype_strs[rtype];
 
-	trace_seq_printf(p, "rrela=%u, iekey=%u, rtype=%u",
-			 rrela, iekey, rtype);
+	trace_seq_printf(p, "rrela=%u:%s, iekey=%u, rtype=%u:%s",
+			 rrela, rrela_str, iekey, rtype, rtype_str);
 	trace_seq_putc(p, 0);
 
 	return ret;
-- 
2.43.0


