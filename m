Return-Path: <SRS0=pD35=EE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FD1BC4363A
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Oct 2020 19:00:13 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80B082076D
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Oct 2020 19:00:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="zsrJDv3W";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Mnj8PcBQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80B082076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=4uPdRJvHUWnYdkRlQ/26/W7jBEiSNTk9UltKTGduoQE=; b=zsrJDv3Wo0PR+dk8S1oqLQQ/h
	BJHRrn/kwDAxuTlflRHQKwekogv+rDJW3hsdfnkh+vOehEyXb43t1VeVd72PGzEgSPbfwv1epD508
	hGO1nRJByOAI2GRmL/7gSLxYdsxA6ZgQY1naGLhg8Q1P+ZK3gdHgtSVGRxMzAM7zONXRXScHx+Ie6
	tZO8bjP9IMKbBLKXF8Mw6s/FN4tRr4QFJ5t+OrQuwvh2xJwYoFm1664ljHbKdQPzHTueDDtufbrKt
	Kkm+QE/ZwCDuOjCqLD8quX/qcKqegJHaofTjaYtZ2AC1ER9hK34hzKw1vmwLiRel2hlkqx97zoqLw
	kWOCd1PFQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kYD9d-00019J-AC; Thu, 29 Oct 2020 19:00:09 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kYD9a-00016S-CH
 for linux-nvme@lists.infradead.org; Thu, 29 Oct 2020 19:00:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1603998006; x=1635534006;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=vYWTH2FI4h/v7W2WdYrcZRVsImi6WMhVW6H/vhOS1lc=;
 b=Mnj8PcBQbE+nIFY39yhY43Y3FfPhpTMdIRAD0RmB1W8Ikey5CjqgEWh2
 g7o5o2pK6oIrR6NbJaMmRaZstpZ4XasmLgBJatHMGuy/or+S56y+bqOpu
 AxYiD6gTw7zbi4S/r5pHSxJBQRKxMxb201+kOF/S6HTdG0o5BCkFq/cbO
 3m2fAFiqordhpMCpQeeJJNgLmQXofdKnkDOAhn4vaA873CsyJgo+/cUwg
 bszArVPQG46MOTDsCvn5rrc7MknEC9p0QmdYBb64xw5QJjqD/NyAfq2tF
 a5xVhMhQfcD85lgMg8rk/PhqT0A0adsCAs0C/uOR4LvwTW7VPNtFY2qg9 g==;
IronPort-SDR: xzqCZGVSdPiwbpo4T4uEKn1CU10k8dIizuJSln5yTKiDS97Ky2hw58rjkQ+5D+mOBZ17xKlqk1
 XB+x/dE8xctZMAFsYi9cqkP83K1cJ3mDE/JQMuXxPklXiduDZy5C/D8wSG+IAQ7ddqhJ9fYOpR
 Z4EwHBmh4PPZ4/7LM5FomrecHeq9bJ2AEqY5FRjs87za7vRZR7iyRgmuBYHFBu+Pwn92zvncib
 t7EraspQKC31NLGOTvwkdog6cKgShYsigTlnXQHGn9H03qp1AK1q9/+tsocaKouD65rUfxNfxs
 vf4=
X-IronPort-AV: E=Sophos;i="5.77,430,1596470400"; d="scan'208";a="151175654"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 30 Oct 2020 03:00:06 +0800
IronPort-SDR: o5J3MCV+JUl+jDIKZEeX1ovif1BPlwEF6eDXzAMZSYaMNeXaEZQHQ6iHYTR3NKy3EpNFbXUlzQ
 LQqFaJmOwDCp5OB1XKLJGfF0rpjq37sQVHTsLF3KCSoItHIFVcCSTP6GDpzUwW8h/mRpqPIkxS
 yyz0bFVc/qNzIVwcmy3Fh0N0mAHOKQrQ2MKTfYCMSnFzJ5fowQMpQoHj670MKDx0AvwGJIdcaj
 SZsdAJpgkes/RAFzqSZ+1kTM4VZ+lGu649rLhsCN/4bRLMnTu1jLEhZ4UA6x0iL82pYZZEx+A9
 oXTicMY8iJ+Azxb904dNVWgG
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2020 11:46:21 -0700
IronPort-SDR: 9MHryEF6+KfIgigpEwJsz2FNLPM3+OvFbtI2cGueFM7/uHUfvN0YE/r2Iv3KiNvU9wMStQ9gDK
 hxktnmWngK2fBmg65KgZ6T75vJnbVSnLteKngMfNbfTnuYVNZubx7tXAUEOUpQ65gJCl1sLUq7
 e2XlEyKkkL/f3HRVXMUJGC0dusx3zhenR/utKSlzrsst+01hI++wtlZJ+fo2lFEWjzSm4BGPVQ
 kgi6uBDibAHZ6pNEMMU4uLubiTHpOOBK/CsCyrrJfgdWtIgBIeDXV02Un6s+nq2A244n0dzO/z
 xoc=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip01.wdc.com with ESMTP; 29 Oct 2020 12:00:06 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 1/2] nvme-core: cleanup nvme_pr_type()
Date: Thu, 29 Oct 2020 11:59:57 -0700
Message-Id: <20201029185958.7013-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201029185958.7013-1-chaitanya.kulkarni@wdc.com>
References: <20201029185958.7013-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201029_150006_557590_3C09F756 
X-CRM114-Status: GOOD (  12.26  )
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
Cc: kbusch@kernel.org, sagi@grimberg.me,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The switch in the nvme_pr_type() returns values which can be mapped 1:1
on the PR_XXX macors. Get rid of the long switch and replace with simple
conditional operator to return the value.

This is purely code cleanup and doesn't change any functionality.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/host/core.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 376096bfc54a..16f590a03486 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2149,23 +2149,11 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_id_ns *id)
 
 static char nvme_pr_type(enum pr_type type)
 {
-	switch (type) {
-	case PR_WRITE_EXCLUSIVE:
-		return 1;
-	case PR_EXCLUSIVE_ACCESS:
-		return 2;
-	case PR_WRITE_EXCLUSIVE_REG_ONLY:
-		return 3;
-	case PR_EXCLUSIVE_ACCESS_REG_ONLY:
-		return 4;
-	case PR_WRITE_EXCLUSIVE_ALL_REGS:
-		return 5;
-	case PR_EXCLUSIVE_ACCESS_ALL_REGS:
-		return 6;
-	default:
+	if (type < PR_WRITE_EXCLUSIVE || type > PR_EXCLUSIVE_ACCESS_ALL_REGS)
 		return 0;
-	}
-};
+
+	return type;
+}
 
 static int nvme_pr_command(struct block_device *bdev, u32 cdw10,
 				u64 key, u64 sa_key, u8 op)
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
