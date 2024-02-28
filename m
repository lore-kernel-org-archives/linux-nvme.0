Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36717C5478C
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Feb 2024 02:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QtqTf1fS6IklLMtyVOjSJjlrAJrlUaeBlC3RRDz911A=; b=fS2FYNG1o9UHYgXomklMgM/gvj
	bFun7DUwi61G13C4FpRRnEXzrWQLJnhbPuYivGx6QtvC2ZEJLY1cjt+JK5MWsblcep0Xv03Y13Qk/
	s6b6aJj+0bbA2/I6MUuhIufm4gxCE3OTErplF4au7E75Vy1NRbLnJtPOm6B9AuMSYxCIeSp6vtI6k
	j65QZrZVYfSweztlc6NbrnnSMxYOcBnHvl2kwdvvpUYVeCMCnKEJPP+DWEzKBxR5yyikwZS0C7DYe
	M6Lt076wnwWZ3o6nadwb4xYXfA4KIyYoHxQKQb/trUAHEWmc79OWbN9pDbFzZu8rKO7qLGUQXGwrC
	VOCulAiQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rf9jM-00000007iZj-2oyG;
	Wed, 28 Feb 2024 02:31:36 +0000
Received: from out30-110.freemail.mail.aliyun.com ([115.124.30.110])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rf9jK-00000007iX8-2inC
	for linux-nvme@lists.infradead.org;
	Wed, 28 Feb 2024 02:31:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709087489; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=QtqTf1fS6IklLMtyVOjSJjlrAJrlUaeBlC3RRDz911A=;
	b=qbf4rl0cz/9xqWEctuC1JGsk8tUPh7YSoiYZNRgw4GK3cvzTrjsuwSw552e8scbgCBj91+OnnXHi8S1XPmOUbQCGiNJwLqi2UBmD/En2A8S8T7f+ppIdl/8/7UlVm2ATmWBu9x1HRu1vnQvX0gRwzp6QJYQ0C1NOsPmZHSL3xNA=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0W1OIIeF_1709087484;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0W1OIIeF_1709087484)
          by smtp.aliyun-inc.com;
          Wed, 28 Feb 2024 10:31:28 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH v2 1/2] nvmet: add tracing of zns commands
Date: Wed, 28 Feb 2024 10:31:17 +0800
Message-ID: <20240228023118.84959-2-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240228023118.84959-1-kanie@linux.alibaba.com>
References: <20240228023118.84959-1-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240227_183134_891411_78FC5E4F 
X-CRM114-Status: UNSURE (   6.87  )
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

Add nvme_cmd_zone_append, nvme_cmd_zone_mgmt_send and
nvme_cmd_zone_mgmt_recv parse to nvme target tracing.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/nvme/target/trace.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/nvme/target/trace.c b/drivers/nvme/target/trace.c
index 657bd31841b2..6604e5fe57d8 100644
--- a/drivers/nvme/target/trace.c
+++ b/drivers/nvme/target/trace.c
@@ -119,6 +119,35 @@ const char *nvmet_trace_parse_admin_cmd(struct trace_seq *p,
 	}
 }
 
+static const char *nvmet_trace_zone_mgmt_send(struct trace_seq *p, u8 *cdw10)
+{
+	const char *ret = trace_seq_buffer_ptr(p);
+	u64 slba = get_unaligned_le64(cdw10);
+	u8 zsa = cdw10[12];
+	u8 all = cdw10[13];
+
+	trace_seq_printf(p, "slba=%llu, zsa=%u, all=%u", slba, zsa, all);
+	trace_seq_putc(p, 0);
+
+	return ret;
+}
+
+static const char *nvmet_trace_zone_mgmt_recv(struct trace_seq *p, u8 *cdw10)
+{
+	const char *ret = trace_seq_buffer_ptr(p);
+	u64 slba = get_unaligned_le64(cdw10);
+	u32 numd = get_unaligned_le32(cdw10 + 8);
+	u8 zra = cdw10[12];
+	u8 zrasf = cdw10[13];
+	u8 pr = cdw10[14];
+
+	trace_seq_printf(p, "slba=%llu, numd=%u, zra=%u, zrasf=%u, pr=%u",
+			 slba, numd, zra, zrasf, pr);
+	trace_seq_putc(p, 0);
+
+	return ret;
+}
+
 const char *nvmet_trace_parse_nvm_cmd(struct trace_seq *p,
 		u8 opcode, u8 *cdw10)
 {
@@ -126,9 +155,14 @@ const char *nvmet_trace_parse_nvm_cmd(struct trace_seq *p,
 	case nvme_cmd_read:
 	case nvme_cmd_write:
 	case nvme_cmd_write_zeroes:
+	case nvme_cmd_zone_append:
 		return nvmet_trace_read_write(p, cdw10);
 	case nvme_cmd_dsm:
 		return nvmet_trace_dsm(p, cdw10);
+	case nvme_cmd_zone_mgmt_send:
+		return nvmet_trace_zone_mgmt_send(p, cdw10);
+	case nvme_cmd_zone_mgmt_recv:
+		return nvmet_trace_zone_mgmt_recv(p, cdw10);
 	default:
 		return nvmet_trace_common(p, cdw10);
 	}
-- 
2.43.0


