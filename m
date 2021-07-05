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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73381C07E99
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Jul 2021 11:30:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3590261279
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Jul 2021 11:30:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3590261279
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kEvLU9/oNQiRrUj0puVBbP7m5/ZKgItCucj7Lqbe6uo=; b=wDUnex3Fx4ScCt
	a7W+59U8uGRhl64Zj4Ao6zXBEsWNAX1wcMtvvA7elA3xF+4GH01aZPoNYa4AmJ05S4CKXTBFT+Wym
	9F/0Yfgi5gW/P27owfNuEUZEvFJcXg236q1s5xXia097PkmAHtmDgdQtTDSkOIzJxrzvMD7naSfs6
	BIWX5vPURiIoKWiO8PTYt3nCV32rBZczUBNqzKyi7NsKh1chrn11bSu1udZErq9EubtTe2IRpmDx1
	ImskdBS67rnhjcQ7oouRWqrYo0TOhLrjnvYLmtNRH8m6cw/8eyAxgHPEYfJcBtEF2Abr4J02GkSj3
	iROjtS07EMb5z3a+2fyw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m0MnX-008mnP-Uv; Mon, 05 Jul 2021 11:30:00 +0000
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m0Mmv-008mbP-3S
 for linux-nvme@lists.infradead.org; Mon, 05 Jul 2021 11:29:23 +0000
Received: by mail-pl1-x62c.google.com with SMTP id v13so10086514ple.9
 for <linux-nvme@lists.infradead.org>; Mon, 05 Jul 2021 04:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=DUCLTPnKjNPnRgQGtPYHBydSf61jPd7ZR+KhlBTMnvU=;
 b=NZyI3vfk56Xdagd7xRPyvRFzeHmKBopNm2Tdt2t6ilb57kntlhoXUx6AMGvBXOjpU6
 Rf9D+wstEoqLH8/3rbwqo2L02Ff0yPxW2VFH7+6svEE0U+6ICyKhPkoLMa0taubUyBjn
 s3oUIjG3Ldfv38Jf9cMB21fGlRYkOVGm+iyy8uXcfhV5v2XDwSatuMqyOk4zaNH41LIU
 hd/zVctaEk/LLgNmVVGTEKpCL6sNciu7ZEAHbsPNsizRyiM+JJZu4EqCdz2qWuLh42Wp
 buJm7J9GzQt/Uy+hqCFsNu9+hikNjZDFrGSff+0miypmUrY4kW+vVH2O5YKhWFvFaeZm
 SAQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=DUCLTPnKjNPnRgQGtPYHBydSf61jPd7ZR+KhlBTMnvU=;
 b=TUucwCvr2GsRcpOjHMQJamuyfEkT3LUlb8FlfYqPOza8WmuCH01NqmibcmlJfa6VhG
 puKtv36lFgF9wOdyL+UcP7vgXBSZH8WCHpixwHUkGyUtjk5Rd0MTIOBn1k73xt3Z7Jll
 vB8jl0xVDwQjgBDe5LbVPZmk4gVa1Asqm1HNqd6hacfxy3YpdXW0j303IIoFT/Fm0dSY
 ysJE805rU208+QnPkWL7NbND7q2rG9wkPi46CgwLENKaSrT5OaQja/Qn1j7LIvYdK+aj
 +oww+3O89LOdTX8byV2CDf0As+fNm83+9QCb0tjJkb6wUf7ag2Mc8blM5tLZwEqQ1dsm
 a5Tg==
X-Gm-Message-State: AOAM530BSlaXDL/LNDTFLYdDGZ4qQG4pK+0kUuS/lGN4AXFAF04yMW/X
 UcZ4JHIFSanYsl1osqNs/X0=
X-Google-Smtp-Source: ABdhPJx4V0wMNQaU/9CvWeorhFETfqbGT3Y7L9z3igfkfOCnfqkBpKoVsa70bL3hJN2i+iBh+G4LdA==
X-Received: by 2002:a17:90a:3d47:: with SMTP id
 o7mr15172583pjf.68.1625484560379; 
 Mon, 05 Jul 2021 04:29:20 -0700 (PDT)
Received: from houpudeMacBook-Pro.local.net ([61.120.150.70])
 by smtp.gmail.com with ESMTPSA id u14sm12705654pfk.10.2021.07.05.04.29.17
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 05 Jul 2021 04:29:20 -0700 (PDT)
From: Hou Pu <houpu.main@gmail.com>
To: sagi@grimberg.me, hch@lst.de, chaitanya.kulkarni@wdc.com, maxg@mellanox.com
Cc: linux-nvme@lists.infradead.org,
	houpu.main@gmail.com
Subject: [PATCH v2 2/3] nvme: add set feature tracing support
Date: Mon,  5 Jul 2021 19:28:17 +0800
Message-Id: <20210705112818.49577-3-houpu.main@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20210705112818.49577-1-houpu.main@gmail.com>
References: <20210705112818.49577-1-houpu.main@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210705_042921_203112_B49EA6B6 
X-CRM114-Status: GOOD (  10.49  )
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

A nvme connect command produces following trace.

Before:
    kworker/5:1H-98      [005] ....  3221.294844: nvme_setup_cmd: nvme0: qid=0, cmdid=25, nsid=0, flags=0x0, meta=0x0, cmd=(nvme_admin_set_features cdw10=07 00 00 00 07 00 07 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00)
    kworker/4:1H-124     [004] ....  3222.009186: nvme_setup_cmd: nvme0: qid=0, cmdid=17, nsid=0, flags=0x0, meta=0x0, cmd=(nvme_admin_set_features cdw10=0b 00 00 00 00 09 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00)

After:
    kworker/2:1H-107     [002] ....    88.541485: nvme_setup_cmd: nvme0: qid=0, cmdid=6, nsid=0, flags=0x0, meta=0x0, cmd=(nvme_admin_set_features fid=0x7, sv=0x0, cdw11=07 00 07 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00)
    kworker/2:1H-107     [002] ....    89.259507: nvme_setup_cmd: nvme0: qid=0, cmdid=7, nsid=0, flags=0x0, meta=0x0, cmd=(nvme_admin_set_features fid=0xb, sv=0x0, cdw11=00 09 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00)

Signed-off-by: Hou Pu <houpu.main@gmail.com>
---
 drivers/nvme/host/trace.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/nvme/host/trace.c b/drivers/nvme/host/trace.c
index 0e441bdad453..681ad2c930c0 100644
--- a/drivers/nvme/host/trace.c
+++ b/drivers/nvme/host/trace.c
@@ -72,6 +72,20 @@ static const char *nvme_trace_admin_identify(struct trace_seq *p, u8 *cdw10)
 	return ret;
 }
 
+static const char *nvme_trace_admin_set_features(struct trace_seq *p,
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
 static const char *nvme_trace_admin_get_features(struct trace_seq *p,
 						 u8 *cdw10)
 {
@@ -203,6 +217,8 @@ const char *nvme_trace_parse_admin_cmd(struct trace_seq *p,
 		return nvme_trace_create_cq(p, cdw10);
 	case nvme_admin_identify:
 		return nvme_trace_admin_identify(p, cdw10);
+	case nvme_admin_set_features:
+		return nvme_trace_admin_set_features(p, cdw10);
 	case nvme_admin_get_features:
 		return nvme_trace_admin_get_features(p, cdw10);
 	case nvme_admin_get_lba_status:
-- 
2.28.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
