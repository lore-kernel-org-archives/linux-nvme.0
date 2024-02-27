Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B83D5C54798
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Feb 2024 08:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QtqTf1fS6IklLMtyVOjSJjlrAJrlUaeBlC3RRDz911A=; b=aLBZByfCB7QY+JOi8uM9aqSbOq
	ZJ55Ww/9MSAQN1Be4glPgXBwklpd5HUYzrLhcGLPZlCgKYtbFUO/FT7SXL6TiHXKbLnQ3iM1Xlk/M
	Fes3RBrCfH8WkXTcOqUlSattkFk5Tv37brUmJKTJTCcg7h4N1MUlEkqHeu/p5gyczhscbE8cSlC4C
	ud5Kux28KEo1kpdbWLULdrPUQpOI1tGl5l/jcBTE3CytUlDeo5w+adSKPI6KTNIDdZDpbCeuFkHDO
	42PRcPFkV0BmadBPY/7Q7ZtHSqzFDS7+4IY0tk0+ZtWY/IaxrFzqPsNz1pi5cuk1vAcr2qXJQz8cm
	AnEAICPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1retEO-00000004PFL-1KpZ;
	Tue, 27 Feb 2024 08:54:32 +0000
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1retEK-00000004PC5-0hb7
	for linux-nvme@lists.infradead.org;
	Tue, 27 Feb 2024 08:54:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709024064; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=QtqTf1fS6IklLMtyVOjSJjlrAJrlUaeBlC3RRDz911A=;
	b=XN9tSt/oAHrowJYdFuzvUl1/31egAg1RShPv7D3IC7W+wXXOWHdT8EGxhkDjqhNs7VcivGd7CElRHKl4q97lJatxHhFfxUsvtVcZriFCz6NFOU55ez1b4qDBpNTVBDqb8xhFVhu7l9n9844GmdAIvOqtHfJ+RcV0yWSHrpiwSOg=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0W1MCVOv_1709024060;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0W1MCVOv_1709024060)
          by smtp.aliyun-inc.com;
          Tue, 27 Feb 2024 16:54:24 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH 2/3] nvmet: add tracing of zns commands
Date: Tue, 27 Feb 2024 16:54:07 +0800
Message-ID: <20240227085408.130161-3-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240227085408.130161-1-kanie@linux.alibaba.com>
References: <20240227085408.130161-1-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240227_005428_541330_5A771448 
X-CRM114-Status: UNSURE (   6.99  )
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


