Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE637C369AB
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Apr 2025 05:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xzSOwX9yW6WNKlj8yrhcI3Zo/7pC8tMAAJeXFna9CpI=; b=odxGFp+OO8IWgEjiFR1kGa660+
	u0W/ngsS2fMwhXH3LhiYAPGEApme10Wy9TrTj/YS+cjPLZjSfIGzWbmgRqhcy9v2CTSxLLBxcnff9
	gllHbHpCli+919geZDwVWELRKzSvVLMGYwrHfwditOewfH8C+cdF+oaHAx9jZmE5oBcuGDWXEet3x
	RFmAdu71oVBv81kByBObGAzcYAkTBQdl4xTOpG9GliWnxE8LAF71obOSgZiFcRPTt33hIdUHXPsqO
	t0BSE7lmTcwXAdJzb45FiaguKt44JyKzeIe92xf3x40iuSwl3t36yJOia4dXCyZXC43/uQlMqE55J
	cYJdA6hQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7out-0000000CrN0-12y6;
	Thu, 24 Apr 2025 05:14:31 +0000
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7ouq-0000000CrLs-2Lgq
	for linux-nvme@lists.infradead.org;
	Thu, 24 Apr 2025 05:14:29 +0000
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-b0b2d0b2843so428550a12.2
        for <linux-nvme@lists.infradead.org>; Wed, 23 Apr 2025 22:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745471667; x=1746076467; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xzSOwX9yW6WNKlj8yrhcI3Zo/7pC8tMAAJeXFna9CpI=;
        b=S8kR59jyBmhZqfghNhn99c9u3PHF4xcwa1CfnAW0+nLHo/vQN6joQIQTD4ud+yKoH0
         CBh2zrCAojzlBo6/qHIUpfOLFViEcKQptEGAned5yWAualGkYTWO6HEUtF4nWoFnVSb7
         YTtfh3hccD5E4rsKnN4beMrtMLZdFi0FUcytO4M7+r/fPvt5LFWSSnEwXTtXCzSmJUd7
         895wNxI2SzdSK3XdZHHX/2jVdKA2EvhRYZ46Xz2PiHJ0UKdRvuv8iv+O7a9jxjVLZ2qG
         e8/JSFAVXY0JC2m0jI3sYRnF6YEt/4R1s8SqfWimp9PbaDlDoi+Ayx89TE37S5QXTFQb
         t6BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745471667; x=1746076467;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xzSOwX9yW6WNKlj8yrhcI3Zo/7pC8tMAAJeXFna9CpI=;
        b=m0l4pZE1sUHNU7SX7dMUjZejBTYS5lakZUd31+RsTMKv/xrLewSriwNDmceIadQOlj
         fLe7QdlAimTmTvUV4e0OlXxL08zW6hcG+2a4JLVpKykGYy13W+3cQMhFu0WiBWnfNvI4
         0wWpB23qCiIbdsIgPi+fvbCAKcFkN9hk3SdC239UCPvXWVU4PNy/PK4c1rb4gNXARqSG
         FP3AUIc2+Mvz/2m+KYxtjQX5pCnbP53bWfKjaqa41S4tytBIjlOPw3SJI/gYd2mjpf60
         3+ilGoz2tlrYdGEqrA1fnFPkKb0JYjv1Ukf+yV9G5+APFtv3yMeBl3A2At5PBzYCO6de
         jfPA==
X-Gm-Message-State: AOJu0Yw11t4qQ4KG+dTwWAEil+PXYqOlT6A4FvwqdBws90dF1cCb9Vs8
	XgyWVjY9BpblyfyPfDvsXcndpSC5EpiNQJormGwe+eaxIgk+1NSqV9rEUw6y
X-Gm-Gg: ASbGncsoWW0aaEFd6LPN/b/KGXSHKkAEYq/nemyXhdNO8oF0Vz0QTW/kBS9yn+XaiHn
	LkuiE017rqQU8kuEBRihPi9HnjzjtNzEAVvcGxz5JV/gmpyxsApvElib7aIHLHwx/aIO4+xAHX5
	89TrdyLTQ7CO2d5BpFf+mCONfd+QcMJ6LJ7DbfCZtRBt5xJ9sBzXqU7d8FvzmeBfrmGzvjPYpP4
	KAJ+4Y5DKrsnwXNOes9BQPeEWglKB2dQgUjIt7WZQumc4eHlAi92tqjh/BDPY0fKjKM5obgU5iy
	v0b2rYDuW/035pL9QRP/UhLMdRFe99pvV6/l1UD+sG6UdnI=
X-Google-Smtp-Source: AGHT+IGBx3gm+izsItiejGvtAXh+2qOe+2kwKKzQXgCP4IcCM/ScKykIgH3oJQgDXbbNUyXGUoTl9A==
X-Received: by 2002:a17:90b:2648:b0:2fe:8a84:e033 with SMTP id 98e67ed59e1d1-309ed26d231mr2176802a91.2.1745471666930;
        Wed, 23 Apr 2025 22:14:26 -0700 (PDT)
Received: from fedora.. ([159.196.5.243])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-309ef097bdbsm324771a91.26.2025.04.23.22.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 22:14:26 -0700 (PDT)
From: Wilfred Mallawa <wilfred.opensource@gmail.com>
To: linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: dlemoal@kernel.org,
	alistair.francis@wdc.com,
	cassel@kernel.org,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>
Subject: [PATCH 1/5] nvmet: add a helper function for cqid checking
Date: Thu, 24 Apr 2025 15:13:49 +1000
Message-ID: <20250424051352.7980-3-wilfred.opensource@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250424051352.7980-2-wilfred.opensource@gmail.com>
References: <20250424051352.7980-2-wilfred.opensource@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250423_221428_604729_EE817322 
X-CRM114-Status: GOOD (  15.01  )
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

From: Wilfred Mallawa <wilfred.mallawa@wdc.com>

This patch adds a new helper function nvmet_check_io_cqid(). It is to be
used when parsing host commands for IO CQ creation/deletion and IO SQ
creation to ensure that the specified IO completion queue identifier
(CQID) is not 0 (Admin queue ID). This is a check that already occurs in
the nvmet_execute_x() functions prior to nvmet_check_cqid.

With the addition of this helper function, the CQ ID checks in the
nvmet_execute_x() function can be removed, and instead simply call
nvmet_check_io_cqid() in place of nvmet_check_cqid().

Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
---
 drivers/nvme/target/admin-cmd.c | 14 ++------------
 drivers/nvme/target/core.c      |  7 +++++++
 drivers/nvme/target/nvmet.h     |  1 +
 3 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index acc138bbf8f2..753166fbb133 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -96,12 +96,7 @@ static void nvmet_execute_delete_cq(struct nvmet_req *req)
 		goto complete;
 	}
 
-	if (!cqid) {
-		status = NVME_SC_QID_INVALID | NVME_STATUS_DNR;
-		goto complete;
-	}
-
-	status = nvmet_check_cqid(ctrl, cqid);
+	status = nvmet_check_io_cqid(ctrl, cqid);
 	if (status != NVME_SC_SUCCESS)
 		goto complete;
 
@@ -127,12 +122,7 @@ static void nvmet_execute_create_cq(struct nvmet_req *req)
 		goto complete;
 	}
 
-	if (!cqid) {
-		status = NVME_SC_QID_INVALID | NVME_STATUS_DNR;
-		goto complete;
-	}
-
-	status = nvmet_check_cqid(ctrl, cqid);
+	status = nvmet_check_io_cqid(ctrl, cqid);
 	if (status != NVME_SC_SUCCESS)
 		goto complete;
 
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 71f8d06998d6..4c0643a72f66 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -856,6 +856,13 @@ u16 nvmet_check_cqid(struct nvmet_ctrl *ctrl, u16 cqid)
 	return NVME_SC_SUCCESS;
 }
 
+u16 nvmet_check_io_cqid(struct nvmet_ctrl *ctrl, u16 cqid)
+{
+	if (!cqid)
+		return NVME_SC_QID_INVALID | NVME_STATUS_DNR;
+	return nvmet_check_cqid(ctrl, cqid);
+}
+
 u16 nvmet_cq_create(struct nvmet_ctrl *ctrl, struct nvmet_cq *cq,
 		    u16 qid, u16 size)
 {
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index b6db8b74dc4a..2f70db1284c9 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -572,6 +572,7 @@ void nvmet_execute_get_features(struct nvmet_req *req);
 void nvmet_execute_keep_alive(struct nvmet_req *req);
 
 u16 nvmet_check_cqid(struct nvmet_ctrl *ctrl, u16 cqid);
+u16 nvmet_check_io_cqid(struct nvmet_ctrl *ctrl, u16 cqid);
 void nvmet_cq_setup(struct nvmet_ctrl *ctrl, struct nvmet_cq *cq, u16 qid,
 		u16 size);
 u16 nvmet_cq_create(struct nvmet_ctrl *ctrl, struct nvmet_cq *cq, u16 qid,
-- 
2.49.0


