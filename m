Return-Path: <SRS0=Ir45=W2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 613D2C3A59B
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Aug 2019 20:12:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 346E123439
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Aug 2019 20:12:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RIYwG/gD";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N7A+aPT4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 346E123439
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=gJNi+TzOUPkIZRaRs2g6FLs6PSJp4z5RW1KuO8GEbTQ=; b=RIY
	wG/gDZ5sbb4anFGDuFN+2ZB9+biEw5LcCrC5DCut/UQd0b/lJf/bWNrHBmf2r2DehH2t+1TPPSz66
	enmXPlFCy/30W3MAw3FuGNQ6a7YTXo61pKFf4bCOgGmtqnIkN4Mmjk33WJJyZSarEMqCRb64pAO72
	1H4NDSEBZl+fNm0hS5uGlgf5tCKbVNK9dD9LR6woX+k3D7PHiKKgq+Glw/5kD3DuUqMQok7B6d9z8
	AG68a1vnx2C04rgBV6ymgwqkIoxTdEMUgrEl8S5zE234ig4pZL7HqRKQ8+y6SSDpp7HAoykkPJ2zT
	635Hc1lyjhXhraPENNJE9JsJCZ7TOPQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i3nFY-0003tk-4J; Fri, 30 Aug 2019 20:12:00 +0000
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i3nFU-0003tR-SJ
 for linux-nvme@lists.infradead.org; Fri, 30 Aug 2019 20:11:58 +0000
Received: by mail-pf1-x444.google.com with SMTP id q21so268600pfn.11
 for <linux-nvme@lists.infradead.org>; Fri, 30 Aug 2019 13:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=Ye53Of+X2rjWdqx45gvvaAXyLvZRrIy9uFa+5X81IlY=;
 b=N7A+aPT4j8f1WRIZsRFYG4E1QLJi8qft2SBYJfOchGKh0z88Y9LqMjYVAjCNsV7Jre
 mBkPl5VD64sz47iO9oOFTzM2W5gsCMOWzf0NuxOgZnPbUS0w3uEaQlGZUQ3EOd9bGq59
 mKdcAMNAMyCNTH+LV6xbSSjFCY6IKWhaJbC1S3MHmp0bepG94qD7c3kIYXxtl0FYIxIv
 epukWqC1PIwvup3//w9xA41+oyPAYwEoC311l4doFclRb408I5Fg3boS65mainHlvqdu
 MbyE47gh616uBVi63wWi1o8uyHOrGi5nU4Ud/KSFO3ZNDVAO/QvCFCODuStZizyrit4s
 LEUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=Ye53Of+X2rjWdqx45gvvaAXyLvZRrIy9uFa+5X81IlY=;
 b=FF9kJXxAJXhOujqXGe6puwg5w5BSMJPuRGhNiT6ar7S1h4xMDpue2uZeK8zaNgZOC3
 5OZsaEh4mj81BGQYZbx/1NkYHE6upDCucdV33SWiSJrXXwE6WKiG58TGGFzmktNV5Dqw
 8k2EX3Y2Ig2fGu4k24fUHlk12AZ3dDdlDx/tf+9zmo6Z2RzBDcmMAHDRiMi0AgESHQ/j
 b8nq/9OYEGH8/FWYo0OTvXN6TyH4M+yApD+XPCUKgdMkPSTpbDYqrX5TT6GG6gxMGXkn
 /WKXA27s79LYbGnNhA1HxhmpTDHwRqGWNpRGlJy85Li2AfQ8sK90jMgtMw8pRazw4P0k
 06yA==
X-Gm-Message-State: APjAAAWB4nXZ08z7D6UGgEWWn0Mu+CjfrucRa0WLkcu0f+EbxOlW9DZM
 3vieUsJAvqiu8zqJVPWuKVkJt1IS
X-Google-Smtp-Source: APXvYqxk/TXt1vcPJdfnaicZBUgy1qMBL2uuK1o7Lh2UCIoxG+kXm1t/US/qlR4m0gM/gD8EBBIgfQ==
X-Received: by 2002:a62:63c1:: with SMTP id x184mr20803740pfb.11.1567195915818; 
 Fri, 30 Aug 2019 13:11:55 -0700 (PDT)
Received: from pallmd1.broadcom.com ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id d189sm8243177pfd.165.2019.08.30.13.11.55
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Fri, 30 Aug 2019 13:11:55 -0700 (PDT)
From: James Smart <jsmart2021@gmail.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH] nvme: Treat discovery subsystems as unique subsystems
Date: Fri, 30 Aug 2019 13:11:45 -0700
Message-Id: <20190830201145.6729-1-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.13.7
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190830_131156_918582_F664B2FD 
X-CRM114-Status: UNSURE (   9.24  )
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
---
 drivers/nvme/host/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 4660505eded9..3edafe57c7f7 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2358,6 +2358,9 @@ static struct nvme_subsystem *__nvme_find_get_subsystem(const char *subsysnqn)
 
 	lockdep_assert_held(&nvme_subsystems_lock);
 
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
