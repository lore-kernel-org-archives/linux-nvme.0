Return-Path: <SRS0=morU=AH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B43DFC433E1
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2020 15:41:16 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 858FF20706
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2020 15:41:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YTQGyUsc";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PY2VMyGA";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="bB22qYrC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 858FF20706
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-Id:Date:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=JtCwJLA7sEIeFP7AyrDzYEkizta/dJ8HSMPSDK9VUHw=; b=YTQGyUscPvT2A3qdM5YCv+74X
	gBVdYdsrRakKRwtolBj9ht6g65h5B24ozTWBk1kvSG5ah20oh+6VBjYXAPMh2qOcrton33Bi9mgSE
	vr3Z8/MvjUBweGS/iLexNeued304Ne14uY8PMyXRyYd7DZ6uopLWRwWLm2b7OkDycD0DtwKyAdsKl
	XtDyQVswFvZvUSLpO0UYbEuqazHWPD6/StgDGjDGjFMMmceIsm/3d2aHPdWFOxvZwyLdimnbh07FN
	qcxMm6bltSGuCxPgHExU8O1bFik8F3QSYrGzSHTUymfaYL6Tt79sIPfjH0BRi2Q7YD7P340WXHgpV
	ARIGq8YXQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1joqTY-0001SB-Gx; Fri, 26 Jun 2020 15:41:12 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1joqTJ-0001NT-KN
 for linux-nvme@merlin.infradead.org; Fri, 26 Jun 2020 15:40:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Subject:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Cc:To:From:Sender:
 Reply-To:Content-Type:Content-ID:Content-Description;
 bh=YVpFGCh6EGMUx4V1DZhBcdqMu33QeEIPAYjGc/iH+uU=; b=PY2VMyGABCfdkSit1SRqlfAjhA
 n6ICZm5+qn1ndqYOhw64zsWdNhzqprTs03Mv4dPLgp/OrSfebovED/dodgoAZIPhv3rasO5kyWBV2
 wE5F1lpEARyy5L35t7d3nCp47xjI60tXuU1kAVKXQ5UuV6ypJwiA43/8L2ai30ktAlIK5NixPPalZ
 4tZRgMW2G7vlxzt3lygFaKkg2NllJpYa7WDdv5wc65Q+9FXzv1ghvPTyYV/7sw8O2J8w505FHS1kX
 WGryLBDWBD7Jo+xGn+A6HBMkvrBz3W6ESTieaNilxxygPRw5wWma6/EOx+mlkyzwVTFDO+V4536MT
 QfoUNi/g==;
Received: from ale.deltatee.com ([207.54.116.67])
 by casper.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1joqSX-0004ie-BB
 for linux-nvme@lists.infradead.org; Fri, 26 Jun 2020 15:40:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=YVpFGCh6EGMUx4V1DZhBcdqMu33QeEIPAYjGc/iH+uU=; b=bB22qYrCaEH9GS6N7EoA2Hnmx6
 kz5rUm+2e5XV/Gj2EQT6dPMNvv4M3gdJHG0qKR/ZZ/zjqbrbDOHJrtIxZFxaNYfaE6JDLMz6GNlX/
 PDl+5dNtcLgsz33mmmaI2qkZpAlTjeYCiezLssfi5ltKhF2FJ8yefcPxjT0DWKg79DzcWzzyZFU3d
 lBrTIm3ClC8hvTWCCoMhYGM2etUbH+Z2uAzBd0x+7oAM0JztUu+9ygB7CFBsHOwef/sP9mnLh3QsD
 UyqO7b2REM1LkRFGI3j4I0auOUgLmxgVkY4U8IpJ77YQ3+5Xc0iwG3PPybg2Luq3R4zyVCSItEWJV
 F5c598pQ==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
 by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <gunthorp@deltatee.com>)
 id 1joqRu-0000oP-43; Fri, 26 Jun 2020 09:39:34 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
 (envelope-from <gunthorp@deltatee.com>)
 id 1joqRm-0007HQ-Tv; Fri, 26 Jun 2020 09:39:22 -0600
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org
Date: Fri, 26 Jun 2020 09:39:11 -0600
Message-Id: <20200626153918.27929-3-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200626153918.27929-1-logang@deltatee.com>
References: <20200626153918.27929-1-logang@deltatee.com>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 hch@lst.de, sagi@grimberg.me, kbusch@kernel.org, axboe@fb.com,
 Chaitanya.Kulkarni@wdc.com, maxg@mellanox.com, sbates@raithlin.com,
 logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v14 2/9] nvme: Create helper function to obtain command effects
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200626_164022_237930_6735A450 
X-CRM114-Status: GOOD (  14.10  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Stephen Bates <sbates@raithlin.com>, Jens Axboe <axboe@fb.com>,
 Keith Busch <kbusch@kernel.org>, Max Gurtovoy <maxg@mellanox.com>,
 Logan Gunthorpe <logang@deltatee.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Separate the code to obtain command effects from the code
to start a passthru request and open code nvme_known_admin_effects()
in the new helper.

The new helper function will be necessary for nvmet passthru
code to determine if we need to change out of interrupt context
to handle the effects.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/core.c | 39 ++++++++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 17 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index c0f5d82f2c3d..85521a523076 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1326,22 +1326,8 @@ static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
 			metadata, meta_len, lower_32_bits(io.slba), NULL, 0);
 }
 
-static u32 nvme_known_admin_effects(u8 opcode)
-{
-	switch (opcode) {
-	case nvme_admin_format_nvm:
-		return NVME_CMD_EFFECTS_CSUPP | NVME_CMD_EFFECTS_LBCC |
-					NVME_CMD_EFFECTS_CSE_MASK;
-	case nvme_admin_sanitize_nvm:
-		return NVME_CMD_EFFECTS_CSE_MASK;
-	default:
-		break;
-	}
-	return 0;
-}
-
-static u32 nvme_passthru_start(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
-								u8 opcode)
+static u32 nvme_command_effects(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
+				u8 opcode)
 {
 	u32 effects = 0;
 
@@ -1357,7 +1343,26 @@ static u32 nvme_passthru_start(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 
 	if (ctrl->effects)
 		effects = le32_to_cpu(ctrl->effects->acs[opcode]);
-	effects |= nvme_known_admin_effects(opcode);
+
+	switch (opcode) {
+	case nvme_admin_format_nvm:
+		effects |= NVME_CMD_EFFECTS_CSUPP | NVME_CMD_EFFECTS_LBCC |
+			NVME_CMD_EFFECTS_CSE_MASK;
+		break;
+	case nvme_admin_sanitize_nvm:
+		effects |= NVME_CMD_EFFECTS_CSE_MASK;
+		break;
+	default:
+		break;
+	}
+
+	return effects;
+}
+
+static u32 nvme_passthru_start(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
+			       u8 opcode)
+{
+	u32 effects = nvme_command_effects(ctrl, ns, opcode);
 
 	/*
 	 * For simplicity, IO to all namespaces is quiesced even if the command
-- 
2.20.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
