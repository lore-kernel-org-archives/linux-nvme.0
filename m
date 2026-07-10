Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 539DEC44501
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Jul 2026 02:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Q1TRFmapyBVbWd7VNMC/WNlG0M10kUIkWE/yDLtryY8=; b=04oeo/v1Tl42OrpEFb41NYZdWc
	UnqbdM8ycsETYd6uY2PTGjfBNnyrMJCyFk+YDugyPhxPYMfPk4l5eXurBUfPhefuxdBmePrvJTrUO
	90Td06hh6e4ku9Rr0mtuGwDWY7arXIbNkLGaab2q8zJj/v+bZJFSbTW1D+yB89JC9A87ut2UdWDjO
	I1vlBECrNPbOL1zUPrqq/b1uuHccb08BEUi6Enr6UNhm5aaw9PBN9ITJ63GYh508cnPcpMU+ycohI
	WEbI9GQ/iDg22bDsa2Btdim9NVhhb2zTAVZufp2P205xqMuO2y/T9hoyVtWyAX4Fib3QyJNaB9cOK
	/PSmpL9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wi10X-00000003xh1-3wGn;
	Fri, 10 Jul 2026 02:30:29 +0000
Received: from mail-qk1-x72b.google.com ([2607:f8b0:4864:20::72b])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wi10V-00000003xfN-1xkE
	for linux-nvme@lists.infradead.org;
	Fri, 10 Jul 2026 02:30:28 +0000
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-92eafc94c9cso20585985a.0
        for <linux-nvme@lists.infradead.org>; Thu, 09 Jul 2026 19:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783650626; x=1784255426; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q1TRFmapyBVbWd7VNMC/WNlG0M10kUIkWE/yDLtryY8=;
        b=dF7iFq0B/WT7305IBk2IKgU7lv2BgMns2SQNzSbv7gq/88NHQJdllyEfJ7cNsohAtP
         29ifbnhj752yZN2n2qUnh+jRqQAcwb5ozW38WQtOQ/SCLjgC+qws21JpgnBX7EIhKlDm
         hNOD7znBaJyd4WC26R8ZjbmTuHPFzGm5/6MtdEqW1AcEZVVfFEQrNB2g6eFub38rKhZg
         CL7UpwUh37EY6bRAbSvqr6Eg24izvIvj6VG4pTynzcNiEPHr6dNng+xM+xkR2DuOAnjT
         JpUQ9UjhaU7brnkME1H4fXEJnZurs8xvEJnuJ1PmuzqroM4gyWD1AC5XNMuG7aV5ryvv
         Llrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783650626; x=1784255426;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Q1TRFmapyBVbWd7VNMC/WNlG0M10kUIkWE/yDLtryY8=;
        b=cwAr8TywMiZQbBu2o8obfopGt/nHYgIEwNmZ6vF6jQiabgKg2rUBeL00+gx62JBbvl
         FmfpRBmTsRB1XgRc6+DVlswDGSWWmltL9UQNNkdLNpjAsR+s7CDj1K71c+oLOjf/XBr4
         oEGCe7QoiahANR+a0tcs1cFLsxsXtmonxoZi2PknUOMnbXKncmnd1hKUfSsdrp19Y7mX
         854FuunGWNpz4mWkTCxSEEaKhAYEkx3GnY/mbOlr9yduXDk8TisYK72SX+QSXdXsLetV
         4h9p+H3w1dlzd4qSg0Ec5tTRqvGcaHUkq06VsqkUymA5Pb3DtSCh55KexsudcWKKm7I0
         HtRw==
X-Forwarded-Encrypted: i=1; AHgh+RpbospBheJOWOkP5lR7PJpODNAegUcZj9BgeuulKW1aGQmWf3D84CuU2mctKmAS/Mix8Ww2aTe1HNqD@lists.infradead.org
X-Gm-Message-State: AOJu0Yy2ge9aaZj3RHBxdWlXdvwnenjKJB882/31zcTPZAatIjZKBndW
	tMJAZfPKiX9zu1BfYJ8LNjvQCt90A+JxLsz2TRwqO1Emh5jUCQnHBED6
X-Gm-Gg: AfdE7clR2cqYaBUKbQBxe4ufLjR5jpMF8MpeifuV/cvSYoPKOr/bZZJE1xyfIQKtHIY
	PCe7eLDPJyE+J4HH05nCt7gesUHQ+2R0cN5JyoUITCZcU2fcis3Xp2fL9vg+ALkCTf0Y6/b/u0P
	2TPQ4UndcSJfrR8VRvgyabacJ9Va0fntfSVuv3EXy6Ckc6PbDZND7cyaocXq2szyQURbn14qcM0
	1BxtkbDTNNGT09273CC28+PMGRJ773AldRuSl0wb/+YdcguEU50MbW5p46SlfATsYtrNmbM9Wo+
	7/OYcuwUuHlb4DiXIPIQxKf2WO6n10IjFT09KsD3CfnI2KMoVw47SpOaXoyonHhK3Bfel0nIhlX
	8nwERowHa0eJdg3/FhWdcjvErG/yd/xTiTzmo5jYiM9mq0vLEuF6ebDquOMxSLXZ5jTXEEFzy7I
	ASlUjaJ2KOiPJZhPKCdNB9lbzOdscCKSlpthuGHh7SxhiLy7/Wxs4/2+wkMzG46DOgQOK9uAzF0
	dIlDys2PzqBbW0StHT1G4InYSlyP+0daOc0jlw1Fng=
X-Received: by 2002:a05:620a:2842:b0:915:abc4:b580 with SMTP id af79cd13be357-92ecf5ddb30mr1039946985a.49.1783650625775;
        Thu, 09 Jul 2026 19:30:25 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5cf9d9bsm88854685a.28.2026.07.09.19.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 19:30:25 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: kwilczynski@kernel.org,
	Damien Le Moal <dlemoal@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 2/2] nvmet-pci: add KUnit coverage for endpoint queue IDs
Date: Thu,  9 Jul 2026 22:30:15 -0400
Message-ID: <20260710023015.3744082-3-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260710023015.3744082-1-michael.bommarito@gmail.com>
References: <20260710023015.3744082-1-michael.bommarito@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260709_193027_523560_0C084A87 
X-CRM114-Status: GOOD (  14.46  )
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

Add KUnit coverage for the PCI endpoint target queue-id boundary. The tests
model the case where target-core max_qid is larger than the endpoint
transport's ctrl->nr_queues, confirm the common qid check accepts the
malformed id, and verify the endpoint callbacks reject out-of-range
Create/Delete SQ/CQ requests before indexing transport-private arrays.

This covers the regression fixed by the preceding patch.

Assisted-by: Codex:gpt-5-5-xhigh
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 drivers/nvme/target/Kconfig   |  11 ++++
 drivers/nvme/target/pci-epf.c | 120 ++++++++++++++++++++++++++++++++++
 2 files changed, 131 insertions(+)

diff --git a/drivers/nvme/target/Kconfig b/drivers/nvme/target/Kconfig
index 4904097dfd490..ea64bbe9882c5 100644
--- a/drivers/nvme/target/Kconfig
+++ b/drivers/nvme/target/Kconfig
@@ -127,3 +127,14 @@ config NVME_TARGET_PCI_EPF
 	  capable PCI controller.
 
 	  If unsure, say N.
+
+config NVMET_PCI_EPF_KUNIT_TEST
+	bool "NVMe PCI endpoint target KUnit tests" if !KUNIT_ALL_TESTS
+	depends on KUNIT
+	depends on NVME_TARGET_PCI_EPF=y
+	default KUNIT_ALL_TESTS
+	help
+	  KUnit tests for the NVMe PCI endpoint target transport.
+	  These tests exercise transport-private queue ID checks for
+	  Create/Delete SQ/CQ commands when target-core max_qid is larger than
+	  the endpoint controller's available queue arrays.
diff --git a/drivers/nvme/target/pci-epf.c b/drivers/nvme/target/pci-epf.c
index 5bddda09c0538..e2eb96f32fab5 100644
--- a/drivers/nvme/target/pci-epf.c
+++ b/drivers/nvme/target/pci-epf.c
@@ -20,6 +20,9 @@
 #include <linux/pci-epf.h>
 #include <linux/pci_regs.h>
 #include <linux/slab.h>
+#if IS_ENABLED(CONFIG_NVMET_PCI_EPF_KUNIT_TEST)
+#include <kunit/test.h>
+#endif
 
 #include "nvmet.h"
 
@@ -2667,3 +2670,120 @@ module_exit(nvmet_pci_epf_cleanup_module);
 MODULE_DESCRIPTION("NVMe PCI Endpoint Function target driver");
 MODULE_AUTHOR("Damien Le Moal <dlemoal@kernel.org>");
 MODULE_LICENSE("GPL");
+
+#if IS_ENABLED(CONFIG_NVMET_PCI_EPF_KUNIT_TEST)
+
+struct nvmet_pci_epf_kunit_ctx {
+	struct nvmet_ctrl tctrl;
+	struct nvmet_subsys subsys;
+	struct nvmet_pci_epf_ctrl ctrl;
+	struct nvmet_pci_epf nvme_epf;
+};
+
+static int nvmet_pci_epf_kunit_init(struct kunit *test)
+{
+	struct nvmet_pci_epf_kunit_ctx *ctx;
+	unsigned int qid;
+
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+
+	ctx->subsys.max_qid = 8;
+	ctx->tctrl.subsys = &ctx->subsys;
+	ctx->tctrl.drvdata = &ctx->ctrl;
+	ctx->tctrl.cqs = kunit_kcalloc(test, ctx->subsys.max_qid + 1,
+				       sizeof(*ctx->tctrl.cqs), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->tctrl.cqs);
+	ctx->tctrl.sqs = kunit_kcalloc(test, ctx->subsys.max_qid + 1,
+				       sizeof(*ctx->tctrl.sqs), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->tctrl.sqs);
+
+	ctx->ctrl.nr_queues = 2;
+	ctx->ctrl.tctrl = &ctx->tctrl;
+	ctx->ctrl.nvme_epf = &ctx->nvme_epf;
+	ctx->ctrl.sq = kunit_kcalloc(test, ctx->ctrl.nr_queues,
+				     sizeof(*ctx->ctrl.sq), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->ctrl.sq);
+	ctx->ctrl.cq = kunit_kcalloc(test, ctx->ctrl.nr_queues,
+				     sizeof(*ctx->ctrl.cq), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->ctrl.cq);
+
+	for (qid = 0; qid < ctx->ctrl.nr_queues; qid++) {
+		nvmet_pci_epf_init_queue(&ctx->ctrl, qid, true);
+		nvmet_pci_epf_init_queue(&ctx->ctrl, qid, false);
+	}
+
+	test->priv = ctx;
+	return 0;
+}
+
+static void nvmet_pci_epf_qid_control_test(struct kunit *test)
+{
+	struct nvmet_pci_epf_kunit_ctx *ctx = test->priv;
+	u16 status;
+
+	status = nvmet_check_io_cqid(&ctx->tctrl, 1, true);
+	KUNIT_EXPECT_EQ(test, status, (u16)NVME_SC_SUCCESS);
+
+	status = nvmet_pci_epf_create_cq(&ctx->tctrl, 1, 0, 1, 0, 0);
+	KUNIT_EXPECT_EQ(test, status,
+			(u16)(NVME_SC_INVALID_QUEUE | NVME_STATUS_DNR));
+}
+
+static void nvmet_pci_epf_qid_oob_test(struct kunit *test)
+{
+	struct nvmet_pci_epf_kunit_ctx *ctx = test->priv;
+	u16 bad_qid = ctx->ctrl.nr_queues;
+	u16 status;
+
+	status = nvmet_check_io_cqid(&ctx->tctrl, bad_qid, true);
+	KUNIT_EXPECT_EQ(test, status, (u16)NVME_SC_SUCCESS);
+
+	status = nvmet_pci_epf_create_cq(&ctx->tctrl, bad_qid, 0, 1, 0, 0);
+	KUNIT_EXPECT_EQ(test, status,
+			(u16)(NVME_SC_QID_INVALID | NVME_STATUS_DNR));
+}
+
+static void nvmet_pci_epf_qid_reject_all_test(struct kunit *test)
+{
+	struct nvmet_pci_epf_kunit_ctx *ctx = test->priv;
+	u16 bad_qid = ctx->ctrl.nr_queues;
+	u16 status;
+
+	status = nvmet_pci_epf_create_cq(&ctx->tctrl, bad_qid, 0, 1, 0, 0);
+	KUNIT_EXPECT_EQ(test, status,
+			(u16)(NVME_SC_QID_INVALID | NVME_STATUS_DNR));
+
+	status = nvmet_pci_epf_create_sq(&ctx->tctrl, bad_qid, 1, 0, 1, 0);
+	KUNIT_EXPECT_EQ(test, status,
+			(u16)(NVME_SC_QID_INVALID | NVME_STATUS_DNR));
+
+	status = nvmet_pci_epf_create_sq(&ctx->tctrl, 1, bad_qid, 0, 1, 0);
+	KUNIT_EXPECT_EQ(test, status,
+			(u16)(NVME_SC_QID_INVALID | NVME_STATUS_DNR));
+
+	status = nvmet_pci_epf_delete_cq(&ctx->tctrl, bad_qid);
+	KUNIT_EXPECT_EQ(test, status,
+			(u16)(NVME_SC_QID_INVALID | NVME_STATUS_DNR));
+
+	status = nvmet_pci_epf_delete_sq(&ctx->tctrl, bad_qid);
+	KUNIT_EXPECT_EQ(test, status,
+			(u16)(NVME_SC_QID_INVALID | NVME_STATUS_DNR));
+}
+
+static struct kunit_case nvmet_pci_epf_qid_test_cases[] = {
+	KUNIT_CASE(nvmet_pci_epf_qid_control_test),
+	KUNIT_CASE(nvmet_pci_epf_qid_oob_test),
+	KUNIT_CASE(nvmet_pci_epf_qid_reject_all_test),
+	{}
+};
+
+static struct kunit_suite nvmet_pci_epf_qid_test_suite = {
+	.name = "nvmet_pci_epf_qid",
+	.init = nvmet_pci_epf_kunit_init,
+	.test_cases = nvmet_pci_epf_qid_test_cases,
+};
+
+kunit_test_suite(nvmet_pci_epf_qid_test_suite);
+
+#endif
-- 
2.53.0

