Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70530CFC53E
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Oct 2024 10:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bvkXEQi/9d+imCXc+EuvkQBrZpmZYBwuESSBbtRrmrw=; b=MByz+4p1hVWKRp28H8eDqpfCEx
	KbEruT7r/zUylzIzLeN6FgMUS4ED/bkqIQqNwI5b9o6Z7RPx3Y51dTEEllGXHOBiZezNf11Mwq62m
	6w4mqUKJQqwxVls3wDlJbapsQzetGCSJVcwWHnPK5NavDb695MijFtmHHCWvKRMGbFT9TLpzKLr0J
	gHIRqXFz7+aGlGcT+IJttRdATzQUgcPS8yI2S4TF8bRZMkf1bORk9O5c1Y7ZRFI0j1Ro/75t7FCA3
	MqzUqrshprv1S3gVNh1ij7lakhoqyj1aqOEgmssrSh+Jvptt2j41vuUrJWfBCywEFpE3ovttECL3l
	DDuoG5Xg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t0IAy-00000004g1D-1Ixa;
	Mon, 14 Oct 2024 10:19:44 +0000
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t0I6d-00000004fTn-3Lw3
	for linux-nvme@lists.infradead.org;
	Mon, 14 Oct 2024 10:15:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728900913; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=bvkXEQi/9d+imCXc+EuvkQBrZpmZYBwuESSBbtRrmrw=;
	b=JQdgem7/F2VcoMNb4d06/uWEYgr1ew09EPtAvMmgW8P+/rcZpVBPMPdiOcVcYu6+cXCkLmqXYC9pG12G+jIcefoHlsSVu1BrMWNVWwB/hZp+ifuk4n4hqQKLhlJxLjeDeX+agQ9QfhbuCi9k1tgsiuhzwoO+4YzVXUpX0o/cQp8=
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WH52W-D_1728900908 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 14 Oct 2024 18:15:12 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH 2/2] nvmet: add tracing of reservation commands
Date: Mon, 14 Oct 2024 18:14:58 +0800
Message-ID: <20241014101458.80491-3-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241014101458.80491-1-kanie@linux.alibaba.com>
References: <20241014101458.80491-1-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241014_031516_009864_73BD9E1E 
X-CRM114-Status: UNSURE (   9.40  )
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

Add tracing of reservation commands, including register, acquire,
release and report, and also parse the action and rtype to string
to make the trace log more human-readable.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/nvme/target/trace.c | 108 ++++++++++++++++++++++++++++++++++++
 1 file changed, 108 insertions(+)

diff --git a/drivers/nvme/target/trace.c b/drivers/nvme/target/trace.c
index 9a3548179a8e..6dbc7036f2e4 100644
--- a/drivers/nvme/target/trace.c
+++ b/drivers/nvme/target/trace.c
@@ -180,6 +180,106 @@ static const char *nvmet_trace_zone_mgmt_recv(struct trace_seq *p, u8 *cdw10)
 	return ret;
 }
 
+static const char *nvmet_trace_resv_reg(struct trace_seq *p, u8 *cdw10)
+{
+	static const char * const rrega_strs[] = {
+		[0x00] = "register",
+		[0x01] = "unregister",
+		[0x02] = "replace",
+	};
+	const char *ret = trace_seq_buffer_ptr(p);
+	u8 rrega = cdw10[0] & 0x7;
+	u8 iekey = (cdw10[0] >> 3) & 0x1;
+	u8 ptpl = (cdw10[3] >> 6) & 0x3;
+	const char *rrega_str;
+
+	if (rrega < ARRAY_SIZE(rrega_strs) && rrega_strs[rrega])
+		rrega_str = rrega_strs[rrega];
+	else
+		rrega_str = "reserved";
+
+	trace_seq_printf(p, "rrega=%u:%s, iekey=%u, ptpl=%u",
+			 rrega, rrega_str, iekey, ptpl);
+	trace_seq_putc(p, 0);
+
+	return ret;
+}
+
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
+static const char *nvmet_trace_resv_acq(struct trace_seq *p, u8 *cdw10)
+{
+	static const char * const racqa_strs[] = {
+		[0x00] = "acquire",
+		[0x01] = "preempt",
+		[0x02] = "preempt and abort",
+	};
+	const char *ret = trace_seq_buffer_ptr(p);
+	u8 racqa = cdw10[0] & 0x7;
+	u8 iekey = (cdw10[0] >> 3) & 0x1;
+	u8 rtype = cdw10[1];
+	const char *racqa_str = "reserved";
+	const char *rtype_str = "reserved";
+
+	if (racqa < ARRAY_SIZE(racqa_strs) && racqa_strs[racqa])
+		racqa_str = racqa_strs[racqa];
+
+	if (rtype < ARRAY_SIZE(rtype_strs) && rtype_strs[rtype])
+		rtype_str = rtype_strs[rtype];
+
+	trace_seq_printf(p, "racqa=%u:%s, iekey=%u, rtype=%u:%s",
+			 racqa, racqa_str, iekey, rtype, rtype_str);
+	trace_seq_putc(p, 0);
+
+	return ret;
+}
+
+static const char *nvmet_trace_resv_rel(struct trace_seq *p, u8 *cdw10)
+{
+	static const char * const rrela_strs[] = {
+		[0x00] = "release",
+		[0x01] = "clear",
+	};
+	const char *ret = trace_seq_buffer_ptr(p);
+	u8 rrela = cdw10[0] & 0x7;
+	u8 iekey = (cdw10[0] >> 3) & 0x1;
+	u8 rtype = cdw10[1];
+	const char *rrela_str = "reserved";
+	const char *rtype_str = "reserved";
+
+	if (rrela < ARRAY_SIZE(rrela_strs) && rrela_strs[rrela])
+		rrela_str = rrela_strs[rrela];
+
+	if (rtype < ARRAY_SIZE(rtype_strs) && rtype_strs[rtype])
+		rtype_str = rtype_strs[rtype];
+
+	trace_seq_printf(p, "rrela=%u:%s, iekey=%u, rtype=%u:%s",
+			 rrela, rrela_str, iekey, rtype, rtype_str);
+	trace_seq_putc(p, 0);
+
+	return ret;
+}
+
+static const char *nvmet_trace_resv_report(struct trace_seq *p, u8 *cdw10)
+{
+	const char *ret = trace_seq_buffer_ptr(p);
+	u32 numd = get_unaligned_le32(cdw10);
+	u8 eds = cdw10[4] & 0x1;
+
+	trace_seq_printf(p, "numd=%u, eds=%u", numd, eds);
+	trace_seq_putc(p, 0);
+
+	return ret;
+}
+
 const char *nvmet_trace_parse_nvm_cmd(struct trace_seq *p,
 		u8 opcode, u8 *cdw10)
 {
@@ -195,6 +295,14 @@ const char *nvmet_trace_parse_nvm_cmd(struct trace_seq *p,
 		return nvmet_trace_zone_mgmt_send(p, cdw10);
 	case nvme_cmd_zone_mgmt_recv:
 		return nvmet_trace_zone_mgmt_recv(p, cdw10);
+	case nvme_cmd_resv_register:
+		return nvmet_trace_resv_reg(p, cdw10);
+	case nvme_cmd_resv_acquire:
+		return nvmet_trace_resv_acq(p, cdw10);
+	case nvme_cmd_resv_release:
+		return nvmet_trace_resv_rel(p, cdw10);
+	case nvme_cmd_resv_report:
+		return nvmet_trace_resv_report(p, cdw10);
 	default:
 		return nvmet_trace_common(p, cdw10);
 	}
-- 
2.43.0


