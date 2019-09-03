Return-Path: <SRS0=NjBy=W6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91524C3A5A2
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Sep 2019 21:20:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D278204EC
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Sep 2019 21:20:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fXPmhjbu";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DzjXLCaj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D278204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=AHwAVdfoV6pn0V4atTQmaNcv5DxlNK40vvw7FEyvoTg=; b=fXP
	mhjbuwiPA8TNGTBo6ZaWCf6W4svyRA9P5rB/6o5GT+dwddabX+mZZpZ5fBTnW0As25oGE0xIqShpy
	bY48oOIBOJzyRzneF16ozxpzJbcqHxZ6aG1FEKh+Hr3l416uDmtnbvghlpLZfW8t6gylNGog9TycK
	DHBQck5tufKGRvYyjEQnAZouSUsa6Rw3xQO5DnyBVdR7jBxsoqRW3whMt1rnhYJkdou0qCeTrVUwy
	ft1uIiwpUVut1wNsLcr2+N8khtLNztD+m9+eeBoAlOmaG9ML5YsVK+wgbXmxVrqQa0aD2OYysTnrQ
	v1hNzh00DOChIgLGblIpwgi+Lr+BEFg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i5GER-0007hx-IN; Tue, 03 Sep 2019 21:20:55 +0000
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i5GEP-0007hd-0j
 for linux-nvme@lists.infradead.org; Tue, 03 Sep 2019 21:20:54 +0000
Received: by mail-pf1-x441.google.com with SMTP id h195so5156611pfe.5
 for <linux-nvme@lists.infradead.org>; Tue, 03 Sep 2019 14:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=NqEiNYHdPARmNtA1IAMl9byVCY+p6tGpqodGhO4dCbU=;
 b=DzjXLCajEDlcwVvmXwHIolNzODE91i1jz87q+l+B1p1xK/8oKOehC/tymMPAqPNyuy
 Sj5gE651Zuu8E1R7+V+fpFDp1oW/X0uNLEeNdKgmAh2f+5IekLFEP9Tnk62DAcv8Kemz
 vEKy3VsOhHNMmVK+O1u2MiPG6eSsifmOQP4P0D6TBBocRvLk1ZqS5jJTU+rCY+8AFfia
 tZE5ZcJdkvcyduMuCY9mxjY/OK++Fzts4bSFvkYuri+f+tz8n1eHCUmQ6yTROIlRF003
 vLT0ZzJq78nLbgx42ib1bU6GV3QtcUSTD3Ep8uEMLRdXQD8IS1BqCl/Go6tRB/SEGBlG
 ZzOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=NqEiNYHdPARmNtA1IAMl9byVCY+p6tGpqodGhO4dCbU=;
 b=Mc6dZrEgP0X+5afV1TIh0weM2uXVP7ozWlEagIElNcIewGm4MZPw/mUhWptyiiGK44
 RKkvSgEnpgaFudO95Noih1BSarSFXFCQ4KjrcJwiYKbCSLcwbqT6hSNdlo2rto2QseuJ
 dzXHqeCHzeG4UwzTJhESdMeYCrEfOiPGnnbL/jfFjIOT0Lu7e1nAxGy9uLHGQfooxLGr
 3hkVznWP3wGqlhtTkZD6XvewAKBd8hIuPgmbYkSJ0nvWzETZ65VnHyTQG2yYqpofz4N+
 jVMC0snWzmv9eeSLv5ahRwEp+5EEXbvnuQFtRMKNDys+UMhQek6AEcvEIlG9evdcS2dl
 MoSA==
X-Gm-Message-State: APjAAAUDNWLdSplE6xSgiSlQeZZPjHc2xOud+b5J/UN6s6ke5wHqFPui
 +iNLTggNLxCfxWpzjOTP/Q6dXcV8
X-Google-Smtp-Source: APXvYqw6+ggHWONsukEJDvjdoFpOBqhUE52aU4FFqBP13AnCTq8qAFIUky2dNbYBWwt+5GXdvlxWvg==
X-Received: by 2002:aa7:8498:: with SMTP id u24mr43214606pfn.61.1567545651916; 
 Tue, 03 Sep 2019 14:20:51 -0700 (PDT)
Received: from pallmd1.broadcom.com ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id h70sm17611349pgc.36.2019.09.03.14.20.51
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Tue, 03 Sep 2019 14:20:51 -0700 (PDT)
From: James Smart <jsmart2021@gmail.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH v2] nvme: Treat discovery subsystems as unique subsystems
Date: Tue,  3 Sep 2019 14:20:37 -0700
Message-Id: <20190903212037.29705-1-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.13.7
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190903_142053_090215_B55B3C2B 
X-CRM114-Status: GOOD (  11.35  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Current code matches subnqn and collapses all controllers to the
same subnqn to a single subsystem structure. This is good for
recognizing multiple controllers for the same subsystem. But with
the well-known discovery subnqn, the subsystems aren't truly the
same subsystem. As such, subsystem specific rules, such as no
overlap of controller id, do not apply. With today's behavior, the
check for overlap of controller id can fail, preventing the new
discovery controller from being created.

When searching for like subsystem nqn, exclude the discovery nqn
from matching. This will result in each discovery controller being
attached to a unique subsystem structure.

Signed-off-by: James Smart <jsmart2021@gmail.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Christoph Hellwig <hch@lst.de>

---
v2: add comment
---
 drivers/nvme/host/core.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 4660505eded9..6960781a514e 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2358,6 +2358,17 @@ static struct nvme_subsystem *__nvme_find_get_subsystem(const char *subsysnqn)
 
 	lockdep_assert_held(&nvme_subsystems_lock);
 
+	/*
+	 * Fail matches for discovery subsystems. This results
+	 * in each discovery controller bound to a unique subsystem.
+	 * This avoids issues with validating controller values
+	 * that can only be true when there is a single unique subsystem.
+	 * There may be multiple and completely independent entities
+	 * that provide discovery controllers.
+	 */
+	if (!strcmp(subsysnqn, NVME_DISC_SUBSYS_NAME))
+		return NULL;
+
 	list_for_each_entry(subsys, &nvme_subsystems, entry) {
 		if (strcmp(subsys->subnqn, subsysnqn))
 			continue;
-- 
2.13.7


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
