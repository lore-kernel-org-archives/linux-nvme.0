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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9CACC07E99
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Jul 2021 11:30:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6239E613C2
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Jul 2021 11:30:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6239E613C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AgQCiSTddYFczF0cae0zfp0AJE/Gm5D4Jz7lI4KTwH4=; b=AkL0BWdkgU0ASs
	2X3vlIKgOKJVydo4f6fj4y05Oa5KBW+phNNJ2a5oheDw0unF9QbUkxZk+ydVEcI0vLw6mpw7H+blt
	qbP27Evw6j37EdFTDxJm9j2yEEh6NRcu0ZLNDe3jmidCSK8OpkRJ1BKRWz+0XE8+BS7GzbNOpEukA
	q6bdXZnW70cDS44RVjaCraCVekJOZ6RoiqJ4j6IcO9MX8/WYZ+LmVoeWqEsNOf5DBIVwWK/l8ry9w
	pJaougyhAUsOiqblR80Za1RrQlChl+M5RarVvlWTkupYuS0RTeOdhrP99UmnBmV9JItngQCLuatZL
	CMtJdCq37NGtot4H+4rw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m0MoA-008mxs-Q4; Mon, 05 Jul 2021 11:30:38 +0000
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m0Mmy-008mcK-59
 for linux-nvme@lists.infradead.org; Mon, 05 Jul 2021 11:29:25 +0000
Received: by mail-pf1-x42d.google.com with SMTP id 17so16216486pfz.4
 for <linux-nvme@lists.infradead.org>; Mon, 05 Jul 2021 04:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=hiPD/5qt7vvZ8bj+GjSrOP3/nmDIZ3XekQvPWy9F6Os=;
 b=E8vEpnJGb6I9sQ9teY6O27AZV9jbMuVBBwYQo5X55oP8NsaVRGOhnqW5pRAsyJ/rOr
 qFq9eqz0B3I8M6L8MATC+EuPMV7LcfWaZa2FnLV07Uq4GTbp4kNjbZSW9nUTmWBNkmuO
 AvDJEB1y7ZlnQ+Qc+sWzw9fz73frDFM87/67R760W9L6PbZr7eduPbc/MkIBYpZADfk5
 yuEym+Q71OKSfWUjSBR+vyM2EsrkcAp7AeEGKb+cQIkgaJdfmNieNvL6XA0Hp7q9duMy
 FcaE7iBEVHKE4RPOfevGaxwatpRWKLE6C213R5q6y6G+b2qNVDKZgPW1rBseP5e6j7Mr
 fNxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hiPD/5qt7vvZ8bj+GjSrOP3/nmDIZ3XekQvPWy9F6Os=;
 b=dDitIc75I20oV8RiYwx6sz175SEfilLbkW5iuIYEI6ENXlvvGNuy4g8oqoXh8NzZn1
 WUFhYKcnAEeFPRSvNqECFjyywaZInRSNDArmCd0/Mw4QGlpiwfS9qUW4zOEwq/Xs3UTT
 2wPS/+SP2UkvTtpSO2pkOqIJWHO7Wa+bQlxx0CBT3QmN49kfYxqCCjBoEuLveOyiPl1l
 gcVru2qZSD/gyOoC2aRXcFQ56yG64vDH7oaORUkwKylc5DJyoZLRsCyCyiI3IOuIdqNe
 FPzBlPg63Ta7Nxx9fE9YcTSCGKhBhJDJObmeRtSybDOiQ1kR2yC+lt6ZDMyojAE4B5uX
 mRWQ==
X-Gm-Message-State: AOAM532sSGj8BvruepvpVYkqfaM+pcEzrvP5AzKJ8sKymJ5DR2avvaQi
 y6qFJZmOdN0M0FlYE7JY9H8=
X-Google-Smtp-Source: ABdhPJx4ABYPol8/nsVkr7I9vWOpEEOsHUEKs5cdPwSjn2fo1JDw3VBUuR1eU6naE/7dT0N7y7H5pw==
X-Received: by 2002:a62:37c2:0:b029:2ff:f7dd:1620 with SMTP id
 e185-20020a6237c20000b02902fff7dd1620mr14787469pfa.33.1625484563460; 
 Mon, 05 Jul 2021 04:29:23 -0700 (PDT)
Received: from houpudeMacBook-Pro.local.net ([61.120.150.70])
 by smtp.gmail.com with ESMTPSA id u14sm12705654pfk.10.2021.07.05.04.29.20
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 05 Jul 2021 04:29:23 -0700 (PDT)
From: Hou Pu <houpu.main@gmail.com>
To: sagi@grimberg.me, hch@lst.de, chaitanya.kulkarni@wdc.com, maxg@mellanox.com
Cc: linux-nvme@lists.infradead.org,
	houpu.main@gmail.com
Subject: [PATCH v2 3/3] nvmet: add set feature tracing support
Date: Mon,  5 Jul 2021 19:28:18 +0800
Message-Id: <20210705112818.49577-4-houpu.main@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20210705112818.49577-1-houpu.main@gmail.com>
References: <20210705112818.49577-1-houpu.main@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210705_042924_269299_40E6CF09 
X-CRM114-Status: GOOD (  11.11  )
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

After:
    kworker/0:1H-56      [000] ....    97.207441: nvmet_req_init: nvmet1: qid=0, cmdid=6, nsid=0, flags=0x40, meta=0x0, cmd=(nvme_admin_set_features, fid=0x7, sv=0x0, cdw11=07 00 07 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00)
    kworker/0:1H-56      [000] ....    97.925443: nvmet_req_init: nvmet1: qid=0, cmdid=7, nsid=0, flags=0x40, meta=0x0, cmd=(nvme_admin_set_features, fid=0xb, sv=0x0, cdw11=00 09 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00)

Signed-off-by: Hou Pu <houpu.main@gmail.com>
---
 drivers/nvme/target/trace.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/nvme/target/trace.c b/drivers/nvme/target/trace.c
index 902500a57185..a1200837646a 100644
--- a/drivers/nvme/target/trace.c
+++ b/drivers/nvme/target/trace.c
@@ -19,6 +19,20 @@ static const char *nvmet_trace_admin_identify(struct trace_seq *p, u8 *cdw10)
 	return ret;
 }
 
+static const char *nvmet_trace_admin_set_features(struct trace_seq *p,
+						 u8 *cdw10)
+{
+	const char *ret = trace_seq_buffer_ptr(p);
+	u8 fid = cdw10[0];
+	u8 sv = cdw10[3] & 0x8;
+
+	trace_seq_printf(p, "fid=0x%x, sv=0x%x, ", fid, sv);
+	trace_seq_printf(p, "cdw11=%*ph", 20, cdw10 + 4);
+	trace_seq_putc(p, 0);
+
+	return ret;
+}
+
 static const char *nvmet_trace_admin_get_features(struct trace_seq *p,
 						 u8 *cdw10)
 {
@@ -96,6 +110,8 @@ const char *nvmet_trace_parse_admin_cmd(struct trace_seq *p,
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
