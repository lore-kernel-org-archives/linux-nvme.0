Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38F76C04A95
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Oct 2022 13:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=N8BoximgElJsrxzJf9JIvgGd84lbgTM3vODxVOIjybk=; b=Ogfyol8TK7ySelZXXn+lkBXtQJ
	t8P7X4GlKXcj+S8wY09+WbGqx54L0PbbNW21iqzhJEhph1HXGnzRondmU3SCRQHG3i2zLo4SXeYYX
	JTgecYcKwlXCJ9rfchqtlNaJ9SGFO3yno1lZxPXdBuri7xXu4a0gdz6UU1+haJbjhgg0Qq8Wz1Ygx
	Pkj6JyVw0/CJDurDBKwnr4sgx8rnf7HYzV/XuiE5YitXZJTBIz2su9qPLRXYVv47tKmLaRQQa1rZM
	zj10V4MjHaGTRPnw+1GuGrt9cXaOMOqCyEITTdmqscHPRIrfYmgWvn9D/bNmPpNxQnnsAImDSIYGe
	F/vs/CTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onKDh-005Wi1-0m; Tue, 25 Oct 2022 13:43:53 +0000
Received: from mail-wr1-f52.google.com ([209.85.221.52])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onKDW-005Wdw-Al
	for linux-nvme@lists.infradead.org; Tue, 25 Oct 2022 13:43:43 +0000
Received: by mail-wr1-f52.google.com with SMTP id bu30so21107419wrb.8
        for <linux-nvme@lists.infradead.org>; Tue, 25 Oct 2022 06:43:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N8BoximgElJsrxzJf9JIvgGd84lbgTM3vODxVOIjybk=;
        b=k+OkAjlAyPgqokwVy+FXpwdiA3N+meuadfgnbcZtzTQvWMxYyRu7J4hRQY0JxGfobf
         S3yLKZNJY+BDhWpoMKtJzeeehvEyScDIfsSXH5Cd1s9ES2NfhaodaRldpvfhoKvqvFIZ
         b3FfJYQ+J1RtdQCcSTAcxyVRPEkfozSWk0Y3B1mkWIkfu4jAU0fwUBnQcb1PRk2uY8RM
         KpCIGnFFJWT0tjkRM73RFZaSYpM+pabXlfabPLwaJLfWF0BFxwkCjLVQ06p1vVyNKy6f
         Nt8DG7co5qJyV4Vo4iSx+WbmyTDY48W29s+vgN54DLPMrU26SUAYL/eDdbwp7Nnlw0+M
         9zLQ==
X-Gm-Message-State: ACrzQf2DIpdjFmc4C+txQQoXWFS4R5qZzckvxYfDBXTsLeKdqX+9lZak
	xjwpUDcY/XyEaeQ/vqO/S/+gEMXvLk4=
X-Google-Smtp-Source: AMsMyM5UTjHaEQAI0fNIJfY1SdeXUDZZAGryq1VvZKZMLT+kf+KMO2qmjavXlVYx3QghBsOe8vB0Gw==
X-Received: by 2002:a05:6000:1d82:b0:22c:ae77:c8dc with SMTP id bk2-20020a0560001d8200b0022cae77c8dcmr26023909wrb.413.1666705419417;
        Tue, 25 Oct 2022 06:43:39 -0700 (PDT)
Received: from localhost.localdomain (46-116-236-159.bb.netvision.net.il. [46.116.236.159])
        by smtp.gmail.com with ESMTPSA id n7-20020a05600c4f8700b003c6c1686b10sm11442239wmq.7.2022.10.25.06.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 06:43:38 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 3/6] nvme-auth: don't re-authenticate if the controller is not LIVE
Date: Tue, 25 Oct 2022 16:43:27 +0300
Message-Id: <20221025134330.1028352-4-sagi@grimberg.me>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221025134330.1028352-1-sagi@grimberg.me>
References: <20221025134330.1028352-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221025_064342_389858_0FC26578 
X-CRM114-Status: GOOD (  12.18  )
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

The connect sequence will re-authenticate.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/auth.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index 734928282d3e..93c0fc71bc7c 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -939,6 +939,13 @@ static void nvme_dhchap_auth_work(struct work_struct *work)
 		container_of(work, struct nvme_ctrl, dhchap_auth_work);
 	int ret, q;
 
+	/*
+	 * If the ctrl is no connected, bail as reconnect will handle
+	 * authentication.
+	 */
+	if (ctrl->state != NVME_CTRL_LIVE)
+		return;
+
 	/* Authenticate admin queue first */
 	ret = nvme_auth_negotiate(ctrl, 0);
 	if (ret) {
-- 
2.34.1


