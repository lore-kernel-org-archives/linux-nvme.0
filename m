Return-Path: <SRS0=LUST=DN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC485C4363D
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Oct 2020 23:31:25 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 423322087E
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Oct 2020 23:31:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PV5avafo";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="c5Z577zy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 423322087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=sTb7f9tUCzF2Y3XYbBoC6ZUdPsDw/TRZzem3QregxmE=; b=PV5avafoqGgcwWir9vLS+8iYS
	EClAc/InUfMUtCmu0vpkPDHMNqEfr6hLh7ED7zeaKUgnhoEBgTB8CBiqrG1kiAm00H0rPuI2R6Zs/
	EAh3MgMyHj/DK4kZp09P0vokU/titUtwZMW9MCpgsL4qcLPYDJBVYWP6RYhIPUXsGQmMmKgF3UMeu
	xSHjHYPjq6J9eujuPy371Do4Vwaa3Tj3pa0jedoPcUB5J5fR4ncOkjpuxn3haWE8UQLhyRf7xsVFa
	4rZXopJWh9HbyMFqTdJvyxoH0yAJcmvFx7eFY9p+DOSrKfPOLcc9lAlZoncYuv5xQXnyOE+25wMIt
	An/F1b4Og==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kPwQU-0006G2-MR; Tue, 06 Oct 2020 23:31:22 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kPwQR-0006FU-P5
 for linux-nvme@lists.infradead.org; Tue, 06 Oct 2020 23:31:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1602027079; x=1633563079;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=yIH+ca4t+tOUb96G5xPv3fZvsxUwo/PBFl6Z3GCnAIA=;
 b=c5Z577zyWArGBmJzDQErW7c52S6qZwNVH4CLpjSx2zG7KA0jT6Q+pO63
 r1lFp+L6qxutFwZITdV63NQkW/FX+13+SfwZfcWC9FraA5ufpEpxBNwV6
 KcLgcqlL8xMV7FN1sn+ZA9irKMNayY5r4CYeJk2GM2DbR6ysYNgwmlCQU
 9t6RZwjkNgXK+xzZQ9Wb05x5uOfblvkyGLj0axcwpWKuT/zyxCqMSkbZq
 W7xahqPZHyh2HET2yu+CYjN2hL/zZjsh/Sj5bqWg4REHU+4Fj+G2txJaS
 kRTv/wZxNj2NTU7c8n0jFbVfmsWMNcUcU2Qqot8V0Uq5VGf52HHFDgqtt g==;
IronPort-SDR: lchPox59ZAuUeTIgz76MHxn1asDebSD4I6tB5prDi3RUabT3nqb3CMenZZgB3GzbrOuTdSArbH
 Q6EeErPrqkTTm6ZTASUPS3AtyWRbsPMffyJzp40s5jjVhoOa1TPecYWyM9iskaKvqSHE9od3rL
 SuQFqCx5GBqPQqH2kIdHXFNrREtM52fVpTSCv8d9po02F8RmN2sS5zWSS3wP/r9LyzwARdDs87
 YbVtTD4qFxcUD6ZOLisgRgsHGhIsp4VH8xfshObuXK68vaEPgcai8quVHK3wTjhnZYZEjIkhp2
 J4M=
X-IronPort-AV: E=Sophos;i="5.77,344,1596470400"; d="scan'208";a="259008453"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 07 Oct 2020 07:31:18 +0800
IronPort-SDR: UuNbmkKKZz1858IzzGvgc8P+WL5C75r//N/zVmxblPRbP6ef52oZYDUuV/j8b4HZychgg/yUbJ
 zdLtVSIh4ZuA==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2020 16:17:09 -0700
IronPort-SDR: GokvEIze9VDDT8LAy8bMnoTC/Ed/A6Pwx3qbuvbbs9572/kIla5SFAqS7WXSO4jfAC42UELIDI
 4HuGnGcDtSGg==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip01.wdc.com with ESMTP; 06 Oct 2020 16:31:19 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V4 2/7] nvme-core: use I/O timeout in nvme_submit_user_cmd
Date: Tue,  6 Oct 2020 16:30:44 -0700
Message-Id: <20201006233049.55458-3-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201006233049.55458-1-chaitanya.kulkarni@wdc.com>
References: <20201006233049.55458-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201006_193119_954839_AA6E7EAB 
X-CRM114-Status: GOOD (  14.43  )
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
Cc: kbusch@kernel.org, hch@lst.de,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

In the function nvme_submit_user_cmd() it uses ADMIN_TIMEOUT when
caller doesn't specify value for the timeout variable. This function is
also called from the user I/O command contexts (nvme_submit_io,
nvme_user_cmd_XXX) where NVME_IO_TIMEOUT can be used instead of
ADMIN_TIMEOUT.

For now we don't set the request queue's queuedata for admin command.

Use newly introduced helper function nvme_default_timeout() to set the
block layer request timeout value.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/host/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 49662e2190d5..f97003e54db8 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1068,7 +1068,9 @@ static int nvme_submit_user_cmd(struct request_queue *q,
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 
-	req->timeout = timeout ? timeout : ADMIN_TIMEOUT;
+	if (!req->timeout)
+		nvme_req_set_default_timeout(req);
+
 	nvme_req(req)->flags |= NVME_REQ_USERCMD;
 
 	if (ubuffer && bufflen) {
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
