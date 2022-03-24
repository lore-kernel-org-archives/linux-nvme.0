Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54A85C433FE
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Mar 2022 00:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Zp0iYxC1EhSi6ssqMfQgnknJAb2Efzhiwd/aAnjbe+Q=; b=tGj1puD/L9xbnCQaoU3NNeHtVQ
	Wf/fJFPb255/5eXyR3dXMX47Q+4/8164DzWaNAzXBTw07EwJktc7IPlxApH5yxWRwsTile960kOTY
	pAygulVsanP7GvJrS8SymvsLmhpkRNVge1rA9WxxL1+MT0vOt5Kdy4zJ3cv6Ud30BKj6Pm8r9Yr2m
	whGxvEOCh4vo5hXupDaoSI68wa7/VVLbcjD8Ml6pEMWV1iQm2zQtldvRcWt/8YmUaTu+bbi0iOGp4
	NFtUMmxhrNgoBBx3Edpk1YjShpvGEt9cCQIU7E7CtWm/fPIca9Bjl7bGJSi4QmBZRdmoV2zK7TGPs
	piIYSkWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nXBNZ-00FChx-Fu; Thu, 24 Mar 2022 00:31:05 +0000
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nXBNV-00FCh4-Kh
 for linux-nvme@lists.infradead.org; Thu, 24 Mar 2022 00:31:02 +0000
Received: by mail-wm1-x32d.google.com with SMTP id p189so1862461wmp.3
 for <linux-nvme@lists.infradead.org>; Wed, 23 Mar 2022 17:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Zp0iYxC1EhSi6ssqMfQgnknJAb2Efzhiwd/aAnjbe+Q=;
 b=c167xdQKZii6WcG1WfroGzESE8YiubNNf/TDhJLW1DHlJR4h8tXIu71CQN4Cutwuyr
 +tIEwgswADMyFYU+D5sQiPihRQ/sBQsQ/2qUWRS80h/ylsY2s9CDJpUfCfwloefvnN2X
 rhfyO95r+QjxvC6v7oAFrj08fOCiUqZuVtKJwEmQ8Xc/5JuHEBIIbN1KRvW7SIvVOVdl
 tc6JDquaO5uf/jiJATz16SirxsE6KOy9yv9RcWY/zMX7rhIoYqpOuunQdwhn1mGKBAbt
 f2roBhwpmuXeTEwIwdZ184kUB/ZWsRtJ38YCg8uSAszj7An/+bLLDF3AuSTAVe3S56Z+
 C1vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Zp0iYxC1EhSi6ssqMfQgnknJAb2Efzhiwd/aAnjbe+Q=;
 b=HF/X49/IiczL3Yirad+5ZRpCeTJoEGUxjGgaStqunbomBIY9skbA3V0C4ds9icsGf0
 /PLTqVSRQgikOWw+uO+ipdQ6/s8cYJs7vCM6LAIJF8qmdBKNUgDZuKOdd4JYEjpAzQ0w
 AXplMezD+6JZLWcy/3tRafqe/keggghiDlNN+TkFnqg96hzqEilkzXEoY8Cssq+H7CQm
 R7IgH+QT7dFyb03KWXD5DO6zyMUOZq3QU+uzJsM2oMGtDkvxAZs3J3WdvGmOu5bUZ4pt
 dtevegPMo7NHdbOgREe+iFcS+CMAgYWPYYcbwQBBAZPyf0IXerjDGX/lhiwop8wIBP6l
 0WWw==
X-Gm-Message-State: AOAM533/l59P50zVBrUfitD2v9MfVttDGNsF29/pDB30Wtrk70EmF4AH
 P6Zs35moRdnj6BVrFH5vjYKkjEi0/n7BRA==
X-Google-Smtp-Source: ABdhPJzqE5FDADAEkfMf8152MSN+bgVvx9R/NocFqxJOiPrSP+WkFxDEZCXwbvoyWZo55EO8B1+B2A==
X-Received: by 2002:a05:600c:1e8e:b0:38c:835a:10fd with SMTP id
 be14-20020a05600c1e8e00b0038c835a10fdmr2320818wmb.73.1648081859733; 
 Wed, 23 Mar 2022 17:30:59 -0700 (PDT)
Received: from localhost.localdomain (c-76-23-2-87.hsd1.ut.comcast.net.
 [76.23.2.87]) by smtp.googlemail.com with ESMTPSA id
 p30-20020a05600c1d9e00b0038cc9d6ff0bsm1716938wms.33.2022.03.23.17.30.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Mar 2022 17:30:59 -0700 (PDT)
From: Anton Eidelman <anton.eidelman@gmail.com>
X-Google-Original-From: Anton Eidelman <anton@lightbitslabs.com>
To: linux-nvme@lists.infradead.org, hch@lst.de, kbusch@kernel.org,
 sagi@grimberg.me, axboe@fb.com
Cc: Anton Eidelman <anton@lightbitslabs.com>
Subject: [PATCH v2 2/2] nvme/mpath: fix crash in nvme_mpath_update for non-ana
 ctrl
Date: Wed, 23 Mar 2022 18:30:08 -0600
Message-Id: <20220324003008.1588225-3-anton@lightbitslabs.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220324003008.1588225-1-anton@lightbitslabs.com>
References: <20220323234355.1585346-1-anton@lightbitslabs.com>
 <20220324003008.1588225-1-anton@lightbitslabs.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220323_173101_703577_33AB09E1 
X-CRM114-Status: GOOD (  14.11  )
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

When CONFIG_NVME_MULTIPATH is enabled, the nvme_mpath_update()
is called from nvme_start_ctrl()
for both ANA and non-ANA ctrls and regardless of multipath on/off.

Unless multipath is on and the ctrl is ANA-enabled
the function will crash as the initializations
for ANA specific parts of the ctrl are skipped in such cases
in nvme_mpath_init_identify().

Fix: check as done in nvme_handle_aen_notice() for ana_work:
a NULL ctrl->ana_log_buf indicates ctrl does not have ANA.

Fixes: d50c992edf10 ("nvme-multipath: fix hang when disk goes live over reconnect")
Signed-off-by: Anton Eidelman <anton@lightbitslabs.com>
---
 drivers/nvme/host/multipath.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 12d4afde3662..f15badc0410a 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -712,11 +712,13 @@ static void nvme_ana_work(struct work_struct *work)
 
 void nvme_mpath_update(struct nvme_ctrl *ctrl)
 {
-	u32 nr_change_groups = 0;
+	if (!ctrl->ana_log_buf) {
+		u32 nr_change_groups = 0;
 
-	mutex_lock(&ctrl->ana_lock);
-	nvme_parse_ana_log(ctrl, &nr_change_groups, nvme_update_ana_state);
-	mutex_unlock(&ctrl->ana_lock);
+		mutex_lock(&ctrl->ana_lock);
+		nvme_parse_ana_log(ctrl, &nr_change_groups, nvme_update_ana_state);
+		mutex_unlock(&ctrl->ana_lock);
+	}
 }
 
 static void nvme_anatt_timeout(struct timer_list *t)
-- 
2.25.1


