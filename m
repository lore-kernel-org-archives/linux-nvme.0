Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83140C47422
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jan 2024 08:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JJSxCNNF8/PhXxa1hxb4OEEmpxczgqyBTh1CD1a3I6A=; b=c3jKv9l3TU5JEBqQrrGhh0VGoX
	FtTnNr0q0S1WZyrHMb3aro0ulVcXfU8VZ7im5u6jd1HvBtyHkekxkrBxI5mMiXSPdxBFaauGV49gI
	79RKErwkZO5FhzqlkAiIDNTBwROfYHenWV3CcZxpe6s2TUEvfuEiTQ9VTsn4dPFjBRBaE8qTILVht
	f63Y6Unr6ScxiZ6lcoN5dzBiSQEdVUos6eu/yGQKkdTuDkrvInqGBTdQOBfLDAkbwI3YLkGs4bfPt
	UDaU6iy/9ixZXHH5LBERhp+H3Y3pQY+Hm58K7AYotVm2Knd1fvaSasWwwph1l/VF//1eCSURTaQXl
	Fm9z43Ow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUMvD-0000000Bkkv-1efa;
	Mon, 29 Jan 2024 08:23:15 +0000
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUMv7-0000000BkjH-44j4
	for linux-nvme@lists.infradead.org;
	Mon, 29 Jan 2024 08:23:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1706516587; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=JJSxCNNF8/PhXxa1hxb4OEEmpxczgqyBTh1CD1a3I6A=;
	b=kMFJQ86ON+KT7NxThuWssoolF+dJs+DU00qWQCPrfrfJS9B7lLVXIa8YapTR4IYEj7Xf6fZAeqmg6ugQeyb7cCoCz8m9q7Ryf/L9ovW/1TSeBaKGSjRCSBG4s4IX4LtiaxpKaPhuxDJK3rFeZ01RGpR66IT8VFscCIX56w6yOKI=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0W.YlJmZ_1706516581;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0W.YlJmZ_1706516581)
          by smtp.aliyun-inc.com;
          Mon, 29 Jan 2024 16:23:05 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH 1/3] nvme: add tracing of reservation commands
Date: Mon, 29 Jan 2024 16:22:54 +0800
Message-ID: <20240129082256.63239-2-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129082256.63239-1-kanie@linux.alibaba.com>
References: <20240129082256.63239-1-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240129_002310_847073_3BE3C86B 
X-CRM114-Status: UNSURE (   7.88  )
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

Add detailed parsing of reservation commands to make the trace log
more consistent and human-readable.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/nvme/host/trace.c | 62 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/drivers/nvme/host/trace.c b/drivers/nvme/host/trace.c
index 1c36fcedea20..95572c85b22a 100644
--- a/drivers/nvme/host/trace.c
+++ b/drivers/nvme/host/trace.c
@@ -191,6 +191,60 @@ static const char *nvme_trace_zone_mgmt_recv(struct trace_seq *p, u8 *cdw10)
 	return ret;
 }
 
+static const char *nvme_trace_resv_reg(struct trace_seq *p, u8 *cdw10)
+{
+	const char *ret = trace_seq_buffer_ptr(p);
+	u8 rrega = cdw10[0] & 0x7;
+	u8 iekey = (cdw10[0] >> 3) & 0x1;
+	u8 ptpl = (cdw10[3] >> 6) & 0x3;
+
+	trace_seq_printf(p, "rrega=%u, iekey=%u, ptpl=%u",
+			 rrega, iekey, ptpl);
+	trace_seq_putc(p, 0);
+
+	return ret;
+}
+
+static const char *nvme_trace_resv_acq(struct trace_seq *p, u8 *cdw10)
+{
+	const char *ret = trace_seq_buffer_ptr(p);
+	u8 racqa = cdw10[0] & 0x7;
+	u8 iekey = (cdw10[0] >> 3) & 0x1;
+	u8 rtype = cdw10[1];
+
+	trace_seq_printf(p, "racqa=%u, iekey=%u, rtype=%u",
+			 racqa, iekey, rtype);
+	trace_seq_putc(p, 0);
+
+	return ret;
+}
+
+static const char *nvme_trace_resv_rel(struct trace_seq *p, u8 *cdw10)
+{
+	const char *ret = trace_seq_buffer_ptr(p);
+	u8 rrela = cdw10[0] & 0x7;
+	u8 iekey = (cdw10[0] >> 3) & 0x1;
+	u8 rtype = cdw10[1];
+
+	trace_seq_printf(p, "rrela=%u, iekey=%u, rtype=%u",
+			 rrela, iekey, rtype);
+	trace_seq_putc(p, 0);
+
+	return ret;
+}
+
+static const char *nvme_trace_resv_report(struct trace_seq *p, u8 *cdw10)
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
 static const char *nvme_trace_common(struct trace_seq *p, u8 *cdw10)
 {
 	const char *ret = trace_seq_buffer_ptr(p);
@@ -243,6 +297,14 @@ const char *nvme_trace_parse_nvm_cmd(struct trace_seq *p,
 		return nvme_trace_zone_mgmt_send(p, cdw10);
 	case nvme_cmd_zone_mgmt_recv:
 		return nvme_trace_zone_mgmt_recv(p, cdw10);
+	case nvme_cmd_resv_register:
+		return nvme_trace_resv_reg(p, cdw10);
+	case nvme_cmd_resv_acquire:
+		return nvme_trace_resv_acq(p, cdw10);
+	case nvme_cmd_resv_release:
+		return nvme_trace_resv_rel(p, cdw10);
+	case nvme_cmd_resv_report:
+		return nvme_trace_resv_report(p, cdw10);
 	default:
 		return nvme_trace_common(p, cdw10);
 	}
-- 
2.43.0


