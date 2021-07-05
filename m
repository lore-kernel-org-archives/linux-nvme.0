Return-Path: <SRS0=DaCh=L5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0318EC07E95
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Jul 2021 03:16:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A906561350
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Jul 2021 03:16:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A906561350
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=U3YGHIxQ6sDCfL6Y9x3Rv7sxrbA72O7oq/LvfZJpGmc=; b=1tyZUTDhQORZdi
	62p9hHri1XrPtEOD5SFwpjjR8yYtzH5GvtPoXwt2n0t6jPDqHLM2+thWeBBd19jRofbcCRMUUr4pI
	Gr7jpBORx/gbcoHLNaXonxKl0S1xkhbZe/xA6ySV5mGNch/5bwmybf2thzGgMg4ZNps13SSUzYMpn
	3ck6Cgua/HiesQO/9uQuEx5aRXA2zVUBQJAl33JWRX2TBa11cZ7CotDH1wDbkDkE3x8ipQc+nZljR
	wwMwc95Zra2xosvrlf5bcg4iZQdUV1UiRUGO3ljFuhRJcr1pj3ZwlqKTbgAxg5RMB6pf3OZAmPmm1
	Ma+3iyK8fAkS7zcPj/LQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m0F5e-007Yqb-5U; Mon, 05 Jul 2021 03:16:10 +0000
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m0F5P-007YpK-H6
 for linux-nvme@lists.infradead.org; Mon, 05 Jul 2021 03:15:56 +0000
Received: by mail-pg1-x531.google.com with SMTP id d12so17004095pgd.9
 for <linux-nvme@lists.infradead.org>; Sun, 04 Jul 2021 20:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=MgqGxCnX0MCUqNepzriRsTCGN6tJAQRftXANBbFa3HU=;
 b=P5DyeVzboSUbyFctmYwhXcI9jqWgNg7Hig0HA2sa47bVEV9PzWHbs9e2pyDHFeKuAY
 xgbuCF2oXd8NUB52V3PHKSkhkI4nXpm94CXZRW5TrjmtK0fa34qxgoRYcPqORpFuZg2j
 jf/93StdaVp9PbPdhoM6hvkXDZIP2/4no9zTOJnPlZ4QhvE40YfLv21COYtvA1oHtbE7
 vqNlHscstttus57t7q16WL4nVHzLgGGLUyPtmzNwS15oaSVs1Q61WpbGSJ5fWIi2zYd/
 6J42dsXh5pmugS+hMWA68Gak4bsgz9ZBSai1128sOlymYZ5ZxQHJZnZzKF7G0Gv3ORrB
 lN2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=MgqGxCnX0MCUqNepzriRsTCGN6tJAQRftXANBbFa3HU=;
 b=oo8E7bYrl7Rb/EBeJlt3UQEXsd5dC+oQazErY4sYtvBkHQU85n3hoWX1auCDgSyAAy
 +4QOa5wh+/VQmZfRLwFfkf27RexTwrpDi6+d+JAc+3E9HqxgxTX5Yznkvzs3MaOWwiuP
 rYXLTIRMSXWtjYcu6TikqIdygEjuQVlWfL24YOXNyRT/sGBsxJsbXg52fyJ+zBISsmGV
 nS+OwIw2InqSXb/WUdHnW40zucrn6OtbakeeiU09fdJJSBeciEjRWd6xN11CnGHys2Gj
 p+D892G24s5Y6e2RKj2taplb/AuW1veT9f+FENHyKFoG1cJCeGtm24n8xw72gma9fQgz
 Gx5g==
X-Gm-Message-State: AOAM533WFZhUp44YRjSEEjFR9UV+A6YLrXymRgBA983BXbHiE1QpNq3n
 9UYKYN3fNUnD8XhGaQnJaXc=
X-Google-Smtp-Source: ABdhPJwfq/owpetAN6akWVvXvHng3FTOpkQSNs/CdfqB0rpNikV2MRL5pn7J8U9Qo/zoKR2AjcGGJw==
X-Received: by 2002:a63:471f:: with SMTP id u31mr13434894pga.85.1625454954495; 
 Sun, 04 Jul 2021 20:15:54 -0700 (PDT)
Received: from houpudeMacBook-Pro.local.net ([61.120.150.70])
 by smtp.gmail.com with ESMTPSA id 136sm11455570pfa.158.2021.07.04.20.15.51
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 04 Jul 2021 20:15:54 -0700 (PDT)
From: Hou Pu <houpu.main@gmail.com>
To: sagi@grimberg.me,
	hch@lst.de,
	chaitanya.kulkarni@wdc.com
Cc: linux-nvme@lists.infradead.org,
	houpu.main@gmail.com,
	maxg@mellanox.com
Subject: [PATCH 2/2] nvmet: add set feature tracing support
Date: Mon,  5 Jul 2021 11:15:29 +0800
Message-Id: <20210705031529.36001-3-houpu.main@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20210705031529.36001-1-houpu.main@gmail.com>
References: <20210705031529.36001-1-houpu.main@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210704_201555_607414_1ABA2D7F 
X-CRM114-Status: GOOD (  11.43  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

A nvme connect command produces following trace from the target side.

Before:
    kworker/0:1H-56      [000] ....  9012.155139: nvmet_req_init: nvmet1: qid=0, cmdid=16, nsid=0, flags=0x40, meta=0x0, cmd=(nvme_admin_set_features, cdw10=07 00 00 00 07 00 07 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00)
    kworker/0:1H-56      [000] ....  9012.872272: nvmet_req_init: nvmet1: qid=0, cmdid=13, nsid=0, flags=0x40, meta=0x0, cmd=(nvme_admin_set_features, cdw10=0b 00 00 00 00 09 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00)

cmdline:/sys/kernel/debug/tracing# cat trace | grep feature
    kworker/0:1H-56      [000] ....   203.493914: nvmet_req_init: nvmet1: qid=0, cmdid=29, nsid=0, flags=0x40, meta=0x0, cmd=(nvme_admin_set_features, fid=0x7, sv=0x0, cdw11=0x70007)
    kworker/0:1H-56      [000] ....   204.197079: nvmet_req_init: nvmet1: qid=0, cmdid=29, nsid=0, flags=0x40, meta=0x0, cmd=(nvme_admin_set_features, fid=0xb, sv=0x0, cdw11=0x900)

Using ',' to separate different field like others in
nvmet_trace_admin_get_features.

Signed-off-by: Hou Pu <houpu.main@gmail.com>
---
 drivers/nvme/target/trace.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/trace.c b/drivers/nvme/target/trace.c
index 1373a3c67962..bff454d46255 100644
--- a/drivers/nvme/target/trace.c
+++ b/drivers/nvme/target/trace.c
@@ -27,7 +27,7 @@ static const char *nvmet_trace_admin_get_features(struct trace_seq *p,
 	u8 sel = cdw10[1] & 0x7;
 	u32 cdw11 = get_unaligned_le32(cdw10 + 4);
 
-	trace_seq_printf(p, "fid=0x%x sel=0x%x cdw11=0x%x", fid, sel, cdw11);
+	trace_seq_printf(p, "fid=0x%x, sel=0x%x, cdw11=0x%x", fid, sel, cdw11);
 	trace_seq_putc(p, 0);
 
 	return ret;
@@ -49,6 +49,20 @@ static const char *nvmet_trace_get_lba_status(struct trace_seq *p,
 	return ret;
 }
 
+static const char *nvmet_trace_admin_set_features(struct trace_seq *p,
+						 u8 *cdw10)
+{
+	const char *ret = trace_seq_buffer_ptr(p);
+	u8 fid = cdw10[0];
+	u8 sv = cdw10[3] & 0x8;
+	u32 cdw11 = get_unaligned_le32(cdw10 + 4);
+
+	trace_seq_printf(p, "fid=0x%x, sv=0x%x, cdw11=0x%x", fid, sv, cdw11);
+	trace_seq_putc(p, 0);
+
+	return ret;
+}
+
 static const char *nvmet_trace_read_write(struct trace_seq *p, u8 *cdw10)
 {
 	const char *ret = trace_seq_buffer_ptr(p);
@@ -94,6 +108,8 @@ const char *nvmet_trace_parse_admin_cmd(struct trace_seq *p,
 	switch (opcode) {
 	case nvme_admin_identify:
 		return nvmet_trace_admin_identify(p, cdw10);
+	case nvme_admin_set_features:
+		return nvmet_trace_admin_set_features(p, cdw10);
 	case nvme_admin_get_features:
 		return nvmet_trace_admin_get_features(p, cdw10);
 	case nvme_admin_get_lba_status:
-- 
2.28.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
