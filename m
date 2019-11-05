Return-Path: <SRS0=AJHE=Y5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB3D7CA9ED9
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Nov 2019 08:09:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D9C420869
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Nov 2019 08:09:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="g2gon1r4";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kalray.eu header.i=@kalray.eu header.b="B/0XETw1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D9C420869
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kalray.eu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:Message-ID:To:From
	:Date:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=eo4OxKfxQFevFZrdNBsL5nIAP2yE21JDCV8Lu+dpfqQ=; b=g2gon1r4LiTh27
	SsfTsUPED42YUmxUKjRBTfmu+XIEEUHO39Jb+ouFvmol0BuuxZakO/EoVfjH1V85Ok23mM5TC2ptc
	bA5c/lzlr7Q+I0pIHsRgGRuG/e4ZOXRGgzBLyLIdXXjOOzOva5kRDcqKACJLBRUvPIxLdLr53+yGm
	CaMCxggh+wj18SoyezAXQDhIF/Bbou6tVhZbuBaL4Dd9Q1/tZxWwEPzGrPVXI5vYPni/GJq0Eqs3z
	FqpisIkQiW99HWQoBMju32FmNoGx98rLw5V8zF3T0EeYsFJJ4qLXUvffAgne5MRbNJINBLrq8S4gX
	aNmm7Ej54T15XNFhVCfw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iRttz-0006G4-HK; Tue, 05 Nov 2019 08:09:23 +0000
Received: from zimbra2.kalray.eu ([92.103.151.219])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iRttw-0006Fa-Si
 for linux-nvme@lists.infradead.org; Tue, 05 Nov 2019 08:09:22 +0000
Received: from localhost (localhost [127.0.0.1])
 by zimbra2.kalray.eu (Postfix) with ESMTP id 758A127E038D;
 Tue,  5 Nov 2019 09:09:19 +0100 (CET)
Received: from zimbra2.kalray.eu ([127.0.0.1])
 by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id 5Wy3NMaHYt_J; Tue,  5 Nov 2019 09:09:19 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zimbra2.kalray.eu (Postfix) with ESMTP id 24A2327E0F36;
 Tue,  5 Nov 2019 09:09:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu 24A2327E0F36
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
 s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1572941359;
 bh=gbqBLGELggS9b8b3HyS9j8dZPVRHOX6ZKfNus9UYcUs=;
 h=Date:From:To:Message-ID:MIME-Version;
 b=B/0XETw1S1lHykqgnnerH4TIGFHqHMR0NmxXmjveeeteyir1SKt3+O8xgge4b06Z6
 +I1oU6HLRDe98Pl1llX4wpgMpCn/AelihZH2hd8VJyWjeR35nchuAIZtiKF0q5YLEl
 ORkQ+qOomdGK6zIeWaMyMO4lD66SxUe+2Bk89htY=
X-Virus-Scanned: amavisd-new at zimbra2.kalray.eu
Received: from zimbra2.kalray.eu ([127.0.0.1])
 by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id n9Hf43AsauDb; Tue,  5 Nov 2019 09:09:19 +0100 (CET)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1])
 by zimbra2.kalray.eu (Postfix) with ESMTP id 1017627E038D;
 Tue,  5 Nov 2019 09:09:19 +0100 (CET)
Date: Tue, 5 Nov 2019 09:09:19 +0100 (CET)
From: Marta Rybczynska <mrybczyn@kalray.eu>
To: Keith Busch <keith.busch@intel.com>, 
 linux-nvme <linux-nvme@lists.infradead.org>
Message-ID: <677052906.90381490.1572941359042.JavaMail.zimbra@kalray.eu>
Subject: [PATCH 3/4] nvme-cli: nvme_ioctl.h: update to latest kernel version
MIME-Version: 1.0
X-Originating-IP: [192.168.40.202]
X-Mailer: Zimbra 8.8.12_GA_3794 (ZimbraWebClient - FF57 (Linux)/8.8.12_GA_3794)
Thread-Index: /iOscU9FO9uuMqrBeXqqlLvwDn1xaQ==
Thread-Topic: nvme-cli: nvme_ioctl.h: update to latest kernel version
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191105_000921_266023_A1ED9AC3 
X-CRM114-Status: UNSURE (   8.33  )
X-CRM114-Notice: Please train this message.
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The latest version includes 64-bit ioctl() results support. Update the
header so that we can use this interface.

Signed-off-by: Marta Rybczynska <marta.rybczynska@kalray.eu>
---
 linux/nvme_ioctl.h | 34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/linux/nvme_ioctl.h b/linux/nvme_ioctl.h
index d25a532..e168dc5 100644
--- a/linux/nvme_ioctl.h
+++ b/linux/nvme_ioctl.h
@@ -1,22 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
 /*
  * Definitions for the NVM Express ioctl interface
  * Copyright (c) 2011-2014, Intel Corporation.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
  */
 
 #ifndef _UAPI_LINUX_NVME_IOCTL_H
 #define _UAPI_LINUX_NVME_IOCTL_H
 
 #include <linux/types.h>
-#include <sys/ioctl.h>
 
 struct nvme_user_io {
 	__u8	opcode;
@@ -54,6 +45,27 @@ struct nvme_passthru_cmd {
 	__u32	result;
 };
 
+struct nvme_passthru_cmd64 {
+	__u8	opcode;
+	__u8	flags;
+	__u16	rsvd1;
+	__u32	nsid;
+	__u32	cdw2;
+	__u32	cdw3;
+	__u64	metadata;
+	__u64	addr;
+	__u32	metadata_len;
+	__u32	data_len;
+	__u32	cdw10;
+	__u32	cdw11;
+	__u32	cdw12;
+	__u32	cdw13;
+	__u32	cdw14;
+	__u32	cdw15;
+	__u32	timeout_ms;
+	__u64	result;
+};
+
 #define nvme_admin_cmd nvme_passthru_cmd
 
 #define NVME_IOCTL_ID		_IO('N', 0x40)
@@ -63,5 +75,7 @@ struct nvme_passthru_cmd {
 #define NVME_IOCTL_RESET	_IO('N', 0x44)
 #define NVME_IOCTL_SUBSYS_RESET	_IO('N', 0x45)
 #define NVME_IOCTL_RESCAN	_IO('N', 0x46)
+#define NVME_IOCTL_ADMIN64_CMD	_IOWR('N', 0x47, struct nvme_passthru_cmd64)
+#define NVME_IOCTL_IO64_CMD	_IOWR('N', 0x48, struct nvme_passthru_cmd64)
 
 #endif /* _UAPI_LINUX_NVME_IOCTL_H */
-- 
1.8.3.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
