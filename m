Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B13E8C47258
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Jan 2024 16:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=y5hXF80CUQjVCS8We9t+6lq7j/iXCsHqiHaf/Wz3tEU=; b=dBPNQE0xrG757AR3otlbCRULo5
	CdZ9LF1+/KEogzzc3ZFzX27x/xVN9Pz+T6AFM3Nr78puvQgMcqDRgTEY7/T6aB3Ces67OD2cEwYHO
	W7Vffv+cNU47IhbG/rWvkrZLbpoEDKgbCGMMEiKO9Q+6D84LFh0xkWoDqUs0HzaheBEAxsYedicmF
	4GdX+Wl3oNWuB4Yez62fSto2rpQYaFh4+ATiJKbJtLxm3UiIK00ROqt3klzeN7egJ3FFp0R/4qnfM
	wp6fa5KQxeg6EP4VdafZ7BfNJkYwINk6eLAL0fsRlGMAxxiMv5zCsvTEfS/179935BSrhId1j4RRu
	rPWWClww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVDh3-00000004aw0-1SqL;
	Wed, 31 Jan 2024 16:44:09 +0000
Received: from mail-yb1-xb62.google.com ([2607:f8b0:4864:20::b62])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVDh1-00000004auA-2Qvv
	for linux-nvme@lists.infradead.org;
	Wed, 31 Jan 2024 16:44:08 +0000
Received: by mail-yb1-xb62.google.com with SMTP id 3f1490d57ef6-dc6bae46ec2so781295276.3
        for <linux-nvme@lists.infradead.org>; Wed, 31 Jan 2024 08:44:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1706719445; x=1707324245; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y5hXF80CUQjVCS8We9t+6lq7j/iXCsHqiHaf/Wz3tEU=;
        b=cw4z4slfhhl12skccbjUOOUGT/njwOGtp5K+jV0eL9vc8Jn/BygY6cM3hB43PNmGBz
         5w1Te2j3TpA30PVL4qXegnNik3CJIELdanBX9h32B8uOoZFaUa3JnmbfZTWi8zkqcIFO
         0LrMmSUxZXxgEa7tz2VFpRqDpU5WeCzkRyuDqtKEkL2Dz4vLe99Q0fEv4TNHo3M3Su64
         ysmZMYWA8kJdqXChg/qxHKbAQRvkIifu/FUkeNUrk09u4nS8uZHCxPKRS2tF8zIGJk0p
         On8zS85yRE9G55dYUmrBK2ULto0AwLMbjGvczAlXG2d4/5KDV+sPM9S/cELrvJDI0w36
         vS4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706719445; x=1707324245;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y5hXF80CUQjVCS8We9t+6lq7j/iXCsHqiHaf/Wz3tEU=;
        b=QxOWIwapwPP63SXGR1N4mTvLJd+roTRMszNmEoXm6XOfbgHT0Bp1slP0dpE8GrBj8u
         anqSzsoJiXxRotYAeFByzuhiNRKZP8v0gTcCkW04lOxG+Jx/061CjEQ1hXEO/RfpnnBL
         j4lGnls7TdRX7RKaarm0kVf42NtcXjf02OuM8S914tDFMkrWo2uagD3GB9TVlM90k7IC
         7P/kjBZEI2l3o/wvnr9GSv3sjepa2tXeA1itsZQ/lRYXh2GmPbohz/QbFCyt7oW/rVPF
         SrDSZkNNiwSy7G7jAweBqSsp2Hjn5iFtGK/vridHrDWWYSNFdLmNfgMd7uyptY6oGVve
         cmzQ==
X-Gm-Message-State: AOJu0YyiREVZm79MzHVHk9cR3X25PAtq70n4580cDBNQXx1xeUAJhigz
	D1pndjUhHFoB1vv5WBh7evM5wrtR+IV8F/LYqZOovY0CM3VFk69a34QurvDrsccs1dF1/EW2r6h
	f9eGcj/tzFetWVshR9x7ZZ7NhwOOe3JAE
X-Google-Smtp-Source: AGHT+IGviUdpndBWqvqILthkhK35tO8a+p6WWWGqWY9O7D+V2iN54UME1NFcCEZYePbVVC+R/4ZHlsHvVDP3
X-Received: by 2002:a25:d613:0:b0:dc6:bd9d:87c1 with SMTP id n19-20020a25d613000000b00dc6bd9d87c1mr2090651ybg.0.1706719444840;
        Wed, 31 Jan 2024 08:44:04 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id eb5-20020a056902278500b00dc24368c50asm523757ybb.31.2024.01.31.08.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 08:44:04 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id DDFBD34071F;
	Wed, 31 Jan 2024 09:44:03 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id D1E60E434DB; Wed, 31 Jan 2024 09:43:33 -0700 (MST)
From: Caleb Sander <csander@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>,
	linux-nvme@lists.infradead.org
Cc: Caleb Sander <csander@purestorage.com>
Subject: [PATCH 1/5] nvme: return string as char *, not unsigned char *
Date: Wed, 31 Jan 2024 09:43:11 -0700
Message-Id: <20240131164315.160042-1-csander@purestorage.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240131_084407_656168_14C97695 
X-CRM114-Status: GOOD (  13.26  )
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

The functions in drivers/nvme/host/constants.c returning human-readable
status and opcode strings currently use type "const unsigned char *".
Typically string constants use type "const char *",
so remove "unsigned" from the return types.
This is a purely cosmetic change to clarify that the functions
return text strings instead of an array of bytes, for example.

Signed-off-by: Caleb Sander <csander@purestorage.com>
---
 drivers/nvme/host/constants.c |  8 ++++----
 drivers/nvme/host/nvme.h      | 18 +++++++++---------
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/nvme/host/constants.c b/drivers/nvme/host/constants.c
index 20f46c230885..8791283ec6ad 100644
--- a/drivers/nvme/host/constants.c
+++ b/drivers/nvme/host/constants.c
@@ -169,35 +169,35 @@ static const char * const nvme_statuses[] = {
 	[NVME_SC_CTRL_PATH_ERROR] = "Controller Pathing Error",
 	[NVME_SC_HOST_PATH_ERROR] = "Host Pathing Error",
 	[NVME_SC_HOST_ABORTED_CMD] = "Host Aborted Command",
 };
 
-const unsigned char *nvme_get_error_status_str(u16 status)
+const char *nvme_get_error_status_str(u16 status)
 {
 	status &= 0x7ff;
 	if (status < ARRAY_SIZE(nvme_statuses) && nvme_statuses[status])
 		return nvme_statuses[status & 0x7ff];
 	return "Unknown";
 }
 
-const unsigned char *nvme_get_opcode_str(u8 opcode)
+const char *nvme_get_opcode_str(u8 opcode)
 {
 	if (opcode < ARRAY_SIZE(nvme_ops) && nvme_ops[opcode])
 		return nvme_ops[opcode];
 	return "Unknown";
 }
 EXPORT_SYMBOL_GPL(nvme_get_opcode_str);
 
-const unsigned char *nvme_get_admin_opcode_str(u8 opcode)
+const char *nvme_get_admin_opcode_str(u8 opcode)
 {
 	if (opcode < ARRAY_SIZE(nvme_admin_ops) && nvme_admin_ops[opcode])
 		return nvme_admin_ops[opcode];
 	return "Unknown";
 }
 EXPORT_SYMBOL_GPL(nvme_get_admin_opcode_str);
 
-const unsigned char *nvme_get_fabrics_opcode_str(u8 opcode) {
+const char *nvme_get_fabrics_opcode_str(u8 opcode) {
 	if (opcode < ARRAY_SIZE(nvme_fabrics_ops) && nvme_fabrics_ops[opcode])
 		return nvme_fabrics_ops[opcode];
 	return "Unknown";
 }
 EXPORT_SYMBOL_GPL(nvme_get_fabrics_opcode_str);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 1700063bc24d..403df30fc3cc 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -1123,35 +1123,35 @@ static inline bool nvme_multi_css(struct nvme_ctrl *ctrl)
 {
 	return (ctrl->ctrl_config & NVME_CC_CSS_MASK) == NVME_CC_CSS_CSI;
 }
 
 #ifdef CONFIG_NVME_VERBOSE_ERRORS
-const unsigned char *nvme_get_error_status_str(u16 status);
-const unsigned char *nvme_get_opcode_str(u8 opcode);
-const unsigned char *nvme_get_admin_opcode_str(u8 opcode);
-const unsigned char *nvme_get_fabrics_opcode_str(u8 opcode);
+const char *nvme_get_error_status_str(u16 status);
+const char *nvme_get_opcode_str(u8 opcode);
+const char *nvme_get_admin_opcode_str(u8 opcode);
+const char *nvme_get_fabrics_opcode_str(u8 opcode);
 #else /* CONFIG_NVME_VERBOSE_ERRORS */
-static inline const unsigned char *nvme_get_error_status_str(u16 status)
+static inline const char *nvme_get_error_status_str(u16 status)
 {
 	return "I/O Error";
 }
-static inline const unsigned char *nvme_get_opcode_str(u8 opcode)
+static inline const char *nvme_get_opcode_str(u8 opcode)
 {
 	return "I/O Cmd";
 }
-static inline const unsigned char *nvme_get_admin_opcode_str(u8 opcode)
+static inline const char *nvme_get_admin_opcode_str(u8 opcode)
 {
 	return "Admin Cmd";
 }
 
-static inline const unsigned char *nvme_get_fabrics_opcode_str(u8 opcode)
+static inline const char *nvme_get_fabrics_opcode_str(u8 opcode)
 {
 	return "Fabrics Cmd";
 }
 #endif /* CONFIG_NVME_VERBOSE_ERRORS */
 
-static inline const unsigned char *nvme_opcode_str(int qid, u8 opcode, u8 fctype)
+static inline const char *nvme_opcode_str(int qid, u8 opcode, u8 fctype)
 {
 	if (opcode == nvme_fabrics_command)
 		return nvme_get_fabrics_opcode_str(fctype);
 	return qid ? nvme_get_opcode_str(opcode) :
 		nvme_get_admin_opcode_str(opcode);
-- 
2.25.1


