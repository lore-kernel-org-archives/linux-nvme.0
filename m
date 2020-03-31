Return-Path: <SRS0=yNQM=5Q=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 542ABC43331
	for <linux-nvme@archiver.kernel.org>; Tue, 31 Mar 2020 16:52:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23F5820784
	for <linux-nvme@archiver.kernel.org>; Tue, 31 Mar 2020 16:52:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="psLZk0dD";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QBvCtpA1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23F5820784
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=kIF9SU3tGKYtx6pc5C2Fu40yRxDx2m9NBxNcLrFyC88=; b=psLZk0dD4H19P4f/XhsLzFciZ/
	nPWeGMknEHeR6l/S8Dnz27kWB+HxyatChEYt21D22/k/iIXHHwmCgOF66rg0G2p1BSCzvkFOP5JYf
	OrwICcnejVPyVFMRfGzxpo3cLk3qxv8++cNZe51SEvcAFXabovVbLXTtK9S+Y5DfcpNFxJBdwC6i2
	pJVeiw8yMmB7bilu+tvWnOLmltS2R/vEYt2HeJN0hS5cLE2Tz3IZyPutMU52CTrJPJlZpM0elRn88
	Vohch+96fgmEnEDOYcfsOu8KXJNye/paT4ME+V0EchxpCiDPISjp4jlZaj9ZUq3WqXod5DfZQyDAh
	3zOp7/YA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jJK85-00064I-6i; Tue, 31 Mar 2020 16:52:45 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jJK61-0004gr-HK
 for linux-nvme@lists.infradead.org; Tue, 31 Mar 2020 16:50:39 +0000
Received: by mail-wm1-x344.google.com with SMTP id 11so2182997wmi.2
 for <linux-nvme@lists.infradead.org>; Tue, 31 Mar 2020 09:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=hSpKlwnboxOegtyYl7XsH/9Phzg+oyOLxrltkfmI7vw=;
 b=QBvCtpA1Jk8nybUHdap0OcqlKNWtjjgVmSGwFO5PqDCWMVQdm+mHAAJyUPhXmSZVKI
 plYmZz9VHhT/zHbmYmwmkymM53ES4jNB9iKrdG9IXx/+eqwRtU21JK6crd9snr7U82Hl
 16kV6ky4/NEDODQTgmgWqJpWUuZ2R14PwTcM6Jg9qSlFuzZrSlyZAQXMyCT+5yxgUTxa
 tTFr7/ofQK0Scb41yx7SLVelatXjQJU8U5UsuMqJEQtAljhiVlNdyoixaHsaAg0NTRlk
 GdbRmDD0jyBm1oXK0PakhpqLLaDxVD1U+Abze8O4e5mJef/Yi0gPVGNjNdcYJO+02JJ1
 +Ojw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=hSpKlwnboxOegtyYl7XsH/9Phzg+oyOLxrltkfmI7vw=;
 b=o1sUTwE/BmK+ZdI8/up1qAEQC0X9XtwNFXC6zsjy8R/npc+Q3K52/3tjxL4+XkTFtC
 iqAPIGruTeXYicd95EMb6BwA6QBmuk2xG6AOkd9nB/83BlmZVDz41udea8cskI9r47dB
 RC8uXH8h86sqO5dTzi0m7pi3mV/liwM6FIGoIOeccKSOkvb5BQcfoKUmzeyQp2HLkYSM
 3ii4bsBrG1TrPP9d0LA5TgHLk0IXi2W4jIk/ew69JzfG1AvC4GnOa9qen8vRwp/3Vl+y
 vif0drzailjqNwq8Rd/2ulHvLYL6GzqUIcYyhiVwRd/9IXe9yPfK8cSvxp8eKM0YfihY
 9a2g==
X-Gm-Message-State: ANhLgQ0rBwAwXHNWO9HzMdFjWfbvsTCmxDn0/fQK8e8llP2oppRgYL47
 3FwtcU9FIGgVZOfSDfWZe6D71kWL
X-Google-Smtp-Source: ADFU+vsj3/An7C+sE3C9uOc4EvbnQFakdnm0IwxiGQ1GyP4L0qfJ/4so6s5d0CSLgClw3mKuJm1drA==
X-Received: by 2002:a7b:c308:: with SMTP id k8mr4559786wmj.40.1585673435940;
 Tue, 31 Mar 2020 09:50:35 -0700 (PDT)
Received: from localhost.localdomain.localdomain ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id r14sm2711582wmg.0.2020.03.31.09.50.34
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 31 Mar 2020 09:50:35 -0700 (PDT)
From: James Smart <jsmart2021@gmail.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH v2 10/26] nvmet-fc: add LS failure messages
Date: Tue, 31 Mar 2020 09:49:55 -0700
Message-Id: <20200331165011.15819-11-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200331165011.15819-1-jsmart2021@gmail.com>
References: <20200331165011.15819-1-jsmart2021@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200331_095037_704831_E1DA8F66 
X-CRM114-Status: GOOD (  11.71  )
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
Cc: James Smart <jsmart2021@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Add LS reception failure messages

Signed-off-by: James Smart <jsmart2021@gmail.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/target/fc.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 5739df7edc59..a91c443c9098 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1598,15 +1598,31 @@ nvmet_fc_rcv_ls_req(struct nvmet_fc_target_port *target_port,
 {
 	struct nvmet_fc_tgtport *tgtport = targetport_to_tgtport(target_port);
 	struct nvmet_fc_ls_iod *iod;
-
-	if (lsreqbuf_len > sizeof(union nvmefc_ls_requests))
+	struct fcnvme_ls_rqst_w0 *w0 = (struct fcnvme_ls_rqst_w0 *)lsreqbuf;
+
+	if (lsreqbuf_len > sizeof(union nvmefc_ls_requests)) {
+		dev_info(tgtport->dev,
+			"RCV %s LS failed: payload too large (%d)\n",
+			(w0->ls_cmd <= NVME_FC_LAST_LS_CMD_VALUE) ?
+				nvmefc_ls_names[w0->ls_cmd] : "",
+			lsreqbuf_len);
 		return -E2BIG;
+	}
 
-	if (!nvmet_fc_tgtport_get(tgtport))
+	if (!nvmet_fc_tgtport_get(tgtport)) {
+		dev_info(tgtport->dev,
+			"RCV %s LS failed: target deleting\n",
+			(w0->ls_cmd <= NVME_FC_LAST_LS_CMD_VALUE) ?
+				nvmefc_ls_names[w0->ls_cmd] : "");
 		return -ESHUTDOWN;
+	}
 
 	iod = nvmet_fc_alloc_ls_iod(tgtport);
 	if (!iod) {
+		dev_info(tgtport->dev,
+			"RCV %s LS failed: context allocation failed\n",
+			(w0->ls_cmd <= NVME_FC_LAST_LS_CMD_VALUE) ?
+				nvmefc_ls_names[w0->ls_cmd] : "");
 		nvmet_fc_tgtport_put(tgtport);
 		return -ENOENT;
 	}
-- 
2.16.4


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
