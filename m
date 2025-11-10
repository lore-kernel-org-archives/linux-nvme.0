Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BDDECCF9E3
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Nov 2025 15:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=i7J7C7wbHVXZYEnWHw5tr2cps0UUQ2yhnk9iJvnGkwo=; b=l6M9sLQEfWPQd3VtK9NlGTUViY
	xCriY/X1fzxEnbOEUGe52n/GKRAR7rYC14GKI8eUbPDoe4eT9mgUS91BmNdzcf44a0IhBMU4DYNXF
	rMp9WbBWk443ezY7Ms95s2QkLn5EtNLQ7HEJNcqI1Jcr5crqMcHk1FNuz8OyzHAaq3QmLoVDQvF8w
	qFbwlnXDxcB3dSpVQKJ3CcY7lzOMyQEnDX+EGbd33h1REGCMLiA5fA/KmfEgnS5n0vCJX9vi+foe8
	hHS/KEp06loMP1O5Z2cLGgSiW7ZEljoPTZzChevsi+EDfDp1gwdJTDE2BFC1rpUoicszl7ll7fAiO
	XjEtZH/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vITjy-00000005gaX-3tbY;
	Mon, 10 Nov 2025 15:23:34 +0000
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vITjx-00000005ga3-0rgu
	for linux-nvme@lists.infradead.org;
	Mon, 10 Nov 2025 15:23:34 +0000
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-59428d2d975so3233887e87.3
        for <linux-nvme@lists.infradead.org>; Mon, 10 Nov 2025 07:23:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762788211; x=1763393011; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i7J7C7wbHVXZYEnWHw5tr2cps0UUQ2yhnk9iJvnGkwo=;
        b=bRXPipoRqtHv35NSSr9fJNRnTxO/7u+i/7djXTwMva9qPgcTU3k6mfYHhywSB06r5J
         6rS+ytXFsvaL4VPb95Epx8wFchYejT9ZV8XtR2X4QJ/eIGLPjM+6LDvNyLyQ0In9xdy0
         p9/PR0PD9MFIX5/zLm/FKP53Gd7tRrJZBsZHwUA7NQsTJSrunWrRWrw+4FYLCTbFCHhS
         TMpXbIsPqr165jWIkuzkFqbOadnYrzNE6QgXvF/7hNOOqN4D3sSFZ+mX7tH6bVdF5JDR
         CqdkZZpjRR/Bk82RI1wKvDt7NxpPrYb9kQjXCAFm1tP3LFnyPlfyi9RPf0r2vcZ+pP9Z
         CoHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762788211; x=1763393011;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i7J7C7wbHVXZYEnWHw5tr2cps0UUQ2yhnk9iJvnGkwo=;
        b=UNSdPPuEbJGMk0IiK5fUaIlFIYONMIRegB4tDD0R7fIlnTkvDivyFll0rOM2vlZgsN
         Tw80E1TdgB+SPhjcfrATko8/IAMdORH0RxZ4MjXTWbkDxY8RUADQrbE83ughUspM07sp
         Y2E/qW6IhspAvl3963Y8y19eRn2QcuymCvnfIRddDz/J9cCz2V2riUQZ5MvQd3vIqhqv
         P4CABy6SDZQJ3NlgE2E8l3HyJFK48oCOIC9pu1+uxhUUhUT0IwawcX0ypCNEizVw8kGF
         kmE67kqA3HJjlyac2GdiZWU5FaKSnS7KzB2CGxWdvKKv2KJBWHLUhx2a+bc6BKwaLNI0
         kWng==
X-Forwarded-Encrypted: i=1; AJvYcCXI5wEyRwCRVvr5Dxp6d7N/hU0wBvba0Ut5XLvEOw3BznrATHpTwOLdoGCdQTX4ekvSFAe+gMDB9Eyq@lists.infradead.org
X-Gm-Message-State: AOJu0YxoUX6PrZiSZiXUoIg0fsblsAEDzwiqPRz6gVctxxNIEaZ4+m6w
	ILftA4zS9ZCtf2hUKg4ILUakCb++IG1KZ/SDlcun2X+UeBZY7uWkWweaz2dEFEnN
X-Gm-Gg: ASbGncvpBUS8kxr3l/uH9zZ8rfAL6+Nwcq9FutYGpk3ZRSPzYlWXvvfS/64PpQqCiHv
	T0TIVbrW46Q26ud4Y8hQNHyPxa6gNFVvuzF0RKrB+rf6siO2FsHrpJfJMjcUJfctbdxZDwE8Hgs
	WQT9cND3CUzwFSfA7OhMOlmY9lPGxUqb+3O5HjcYCKBmW+xHgyFU/ejiRUHKgFVxL1MLjIGa7gI
	N2FYFqt2yJapw0phzzterI2kVhlBmN6e/2Ya4G5M1K0AOCgEnSDTrqBIDU5wZelexnzQFEkmiG/
	vSVDq5Iv7oTOsLwbiuG0UWrN6h8uMDMS4q7Csot0ZhD+iOfypTUHlVfXJcf0E418XT6yT2M2Vhs
	oEMXOLeO7mbV53CPHm5jHfOLN5jjU7DZJeHuv6eMXFRc/hH+yZj6MjTYTH59R2EnRVSBr1+BY9U
	aV5qdrrDLHw3Zy2v05HjLcPgKvHtKA+PvspzuILqYeai7vXw/eZx8U/Qey3Q/ZU4cPQ8zH53KSO
	o7h1otAJp1gr0M4/N4=
X-Google-Smtp-Source: AGHT+IGpmyTorrxqqfyOLp5u4SrpQu7Rpqruo8E8kgCgcJIvPLF0QbvbOAIbXlHQFPaZX5TaXdWLbQ==
X-Received: by 2002:a05:6512:3b20:b0:594:51ac:13e with SMTP id 2adb3069b0e04-5945f15f87emr2348073e87.17.1762788210431;
        Mon, 10 Nov 2025 07:23:30 -0800 (PST)
Received: from localhost.localdomain (broadband-109-173-93-221.ip.moscow.rt.ru. [109.173.93.221])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5944a03459bsm4081392e87.48.2025.11.10.07.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 07:23:30 -0800 (PST)
From: Alexandr Sapozhnikov <alsp705@gmail.com>
To: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: Alexandr Sapozhnikov <alsp705@gmail.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5.10] nvmet: replace the dangerous sprintf function with the snprintf function
Date: Mon, 10 Nov 2025 18:23:26 +0300
Message-ID: <20251110152328.11-1-alsp705@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251110_072333_275629_E1891817 
X-CRM114-Status: GOOD (  12.21  )
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

Replaced the dangerous sprintf function with a safer equivalent, 
snprintf. This will improve driver security by checking for 
out-of-bounds errors in the page array.

Fixes: 7e764179c867 ("nvmet: use type-name map for address family")
Signed-off-by: Alexandr Sapozhnikov <alsp705@gmail.com>
---
 drivers/nvme/target/configfs.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 37e1d7784e17..49dfeb4194b9 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -60,10 +60,10 @@ static ssize_t nvmet_addr_adrfam_show(struct config_item *item, char *page)
 
 	for (i = 1; i < ARRAY_SIZE(nvmet_addr_family); i++) {
 		if (nvmet_addr_family[i].type == adrfam)
-			return sprintf(page, "%s\n", nvmet_addr_family[i].name);
+			return snprintf(page, PAGE_SIZE, "%s\n", nvmet_addr_family[i].name);
 	}
 
-	return sprintf(page, "\n");
+	return snprintf(page, PAGE_SIZE, "\n");
 }
 
 static ssize_t nvmet_addr_adrfam_store(struct config_item *item,
@@ -162,10 +162,10 @@ static ssize_t nvmet_addr_treq_show(struct config_item *item, char *page)
 
 	for (i = 0; i < ARRAY_SIZE(nvmet_addr_treq); i++) {
 		if (treq == nvmet_addr_treq[i].type)
-			return sprintf(page, "%s\n", nvmet_addr_treq[i].name);
+			return snprintf(page, PAGE_SIZE, "%s\n", nvmet_addr_treq[i].name);
 	}
 
-	return sprintf(page, "\n");
+	return snprintf(page, PAGE_SIZE, "\n");
 }
 
 static ssize_t nvmet_addr_treq_store(struct config_item *item,
@@ -286,10 +286,10 @@ static ssize_t nvmet_addr_trtype_show(struct config_item *item,
 
 	for (i = 0; i < ARRAY_SIZE(nvmet_transport); i++) {
 		if (port->disc_addr.trtype == nvmet_transport[i].type)
-			return sprintf(page, "%s\n", nvmet_transport[i].name);
+			return snprintf(page, PAGE_SIZE, "%s\n", nvmet_transport[i].name);
 	}
 
-	return sprintf(page, "\n");
+	return snprintf(page, PAGE_SIZE, "\n");
 }
 
 static void nvmet_port_init_tsas_rdma(struct nvmet_port *port)
@@ -331,7 +331,7 @@ CONFIGFS_ATTR(nvmet_, addr_trtype);
  */
 static ssize_t nvmet_ns_device_path_show(struct config_item *item, char *page)
 {
-	return sprintf(page, "%s\n", to_nvmet_ns(item)->device_path);
+	return snprintf(page, PAGE_SIZE, "%s\n", to_nvmet_ns(item)->device_path);
 }
 
 static ssize_t nvmet_ns_device_path_store(struct config_item *item,
@@ -412,7 +412,7 @@ CONFIGFS_ATTR(nvmet_ns_, p2pmem);
 
 static ssize_t nvmet_ns_device_uuid_show(struct config_item *item, char *page)
 {
-	return sprintf(page, "%pUb\n", &to_nvmet_ns(item)->uuid);
+	return snprintf(page, PAGE_SIZE, "%pUb\n", &to_nvmet_ns(item)->uuid);
 }
 
 static ssize_t nvmet_ns_device_uuid_store(struct config_item *item,
@@ -440,7 +440,7 @@ CONFIGFS_ATTR(nvmet_ns_, device_uuid);
 
 static ssize_t nvmet_ns_device_nguid_show(struct config_item *item, char *page)
 {
-	return sprintf(page, "%pUb\n", &to_nvmet_ns(item)->nguid);
+	return snprintf(page, PAGE_SIZE, "%pUb\n", &to_nvmet_ns(item)->nguid);
 }
 
 static ssize_t nvmet_ns_device_nguid_store(struct config_item *item,
@@ -486,7 +486,7 @@ CONFIGFS_ATTR(nvmet_ns_, device_nguid);
 
 static ssize_t nvmet_ns_ana_grpid_show(struct config_item *item, char *page)
 {
-	return sprintf(page, "%u\n", to_nvmet_ns(item)->anagrpid);
+	return snprintf(page, PAGE_SIZE, "%u\n", to_nvmet_ns(item)->anagrpid);
 }
 
 static ssize_t nvmet_ns_ana_grpid_store(struct config_item *item,
@@ -519,7 +519,7 @@ CONFIGFS_ATTR(nvmet_ns_, ana_grpid);
 
 static ssize_t nvmet_ns_enable_show(struct config_item *item, char *page)
 {
-	return sprintf(page, "%d\n", to_nvmet_ns(item)->enabled);
+	return snprintf(page, PAGE_SIZE, "%d\n", to_nvmet_ns(item)->enabled);
 }
 
 static ssize_t nvmet_ns_enable_store(struct config_item *item,
@@ -544,7 +544,7 @@ CONFIGFS_ATTR(nvmet_ns_, enable);
 
 static ssize_t nvmet_ns_buffered_io_show(struct config_item *item, char *page)
 {
-	return sprintf(page, "%d\n", to_nvmet_ns(item)->buffered_io);
+	return snprintf(page, PAGE_SIZE, "%d\n", to_nvmet_ns(item)->buffered_io);
 }
 
 static ssize_t nvmet_ns_buffered_io_store(struct config_item *item,
@@ -714,7 +714,7 @@ static ssize_t nvmet_passthru_enable_show(struct config_item *item,
 {
 	struct nvmet_subsys *subsys = to_subsys(item->ci_parent);
 
-	return sprintf(page, "%d\n", subsys->passthru_ctrl ? 1 : 0);
+	return snprintf(page, PAGE_SIZE, "%d\n", subsys->passthru_ctrl ? 1 : 0);
 }
 
 static ssize_t nvmet_passthru_enable_store(struct config_item *item,
@@ -1348,10 +1348,10 @@ static ssize_t nvmet_ana_group_ana_state_show(struct config_item *item,
 
 	for (i = 0; i < ARRAY_SIZE(nvmet_ana_state); i++) {
 		if (state == nvmet_ana_state[i].type)
-			return sprintf(page, "%s\n", nvmet_ana_state[i].name);
+			return snprintf(page, PAGE_SIZE, "%s\n", nvmet_ana_state[i].name);
 	}
 
-	return sprintf(page, "\n");
+	return snprintf(page, PAGE_SIZE, "\n");
 }
 
 static ssize_t nvmet_ana_group_ana_state_store(struct config_item *item,
-- 
2.51.0


