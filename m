Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05F3CC5DF97
	for <linux-nvme@archiver.kernel.org>; Sun, 23 Aug 2026 00:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:To:From:Cc:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=fp1+K7GW3kcJSt3qmbbEalFTRKYsVCcoHZ1VYTGaRME=; b=dQot0sKbRymgdO
	AVnlol9oQRlyCrnUdL49mJWqFAQh5/jETpgQdPqd8rRu/PVoJdwHsiR9Nu/8rZD2hAeOsYbqJEB6i
	Wk0+sj/E0P754mTnX/kOrpQ2GmKnbCsHdd5HfIGkwygkZs3lw1ksIgOXwAHRhid5q7+NadhPeM26H
	O00J966Y3pQEj1chd1P0bH/dcz9J6o5hUXQtEBtcGUhPKA7E+r03zMhZ7uVH9G+PlbC53iWHhSWq+
	ogVlqJVJ8t8z3GDaWiow8+VvezTwP0BxcukYPe8vEJfjVSlyRnrkXKtIs1KAt7jyglnxS2+Lc7Q7/
	MmFK+EJuWVE8hep3saIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxvrn-0000000Euiq-3c1n;
	Sun, 23 Aug 2026 00:15:15 +0000
Received: from mail-ed1-f48.google.com ([209.85.208.48])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxvrl-0000000Eui2-2Do9
	for linux-nvme@lists.infradead.org;
	Sun, 23 Aug 2026 00:15:14 +0000
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-69c600f76ccso3845014a12.0
        for <linux-nvme@lists.infradead.org>; Sat, 22 Aug 2026 17:15:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787444112; x=1788048912;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fp1+K7GW3kcJSt3qmbbEalFTRKYsVCcoHZ1VYTGaRME=;
        b=J/zp7/YdCKC+u0xk1m2FwB9vHuKjzuFHo4RJv4xX5mAbRA0m4LoFtNcnhQglf7tig2
         i10LpIbKNMWnriCjWEcKfVGTywXrI2EXoOfqQIPCCeUEmQJ7FPiY0+csOMUx6ZqiySCW
         g3FHlhXLY1d9/XtF1WNp4d4NXb6eljMI/ZWn7dRRrqxp0aysRXV/HElWRirI+ByJ3Yf5
         5U+97OksY6NfGvQeWsfpykVzMll/vObnjG227wG/JaK/39yTIBB0QMPM8wtX8eFzkcUv
         r/j6vjNfRmewtW9bQZnOeUHE1EIgb122OPnPB0fcD/nq5vlfQQ++bJ8WVz2Ib1HZUe6F
         60Iw==
X-Gm-Message-State: AFuF++k1eQVLd0MHwqPtngVt+zFeQTEw6pce7Ze4rVNj9pBK6qWlhCkW
	3siuaURLSiwl3qkYkp2TszIP9X6KiF4/Dzv5J1Sy5o9IkYJlnAbKoPECYrPvMA==
X-Gm-Gg: AR+sD122iGh0W/xLxTkpQg9/B3yajkdj/gURVNymhY8mNyayi7RYl7qP1b5nQTHvhqD
	undJkd1seN4Ei7/+V0yEgjOBT3ldQnMhbwv8pGn626xAbWD3s4BJfB+WIucgzlp1HdOzenoMnRD
	pU3nGcDwOUivraWuTwSHm6sLe7iZG+/dN7EkHzkg4z0+hpujBqETEh65k1FeH+iWFO9A9Am73lN
	BKQG2sr5BbGayu+GOksFWNRmfsn0k5T3e/7VAXqUFuTI6sjCcCjBaSA7mYsi8erSS9j7PLnz68c
	Em7cddVZGE1Na2II0J6fdlZE+os3Picybat/bhnJ+zqBK1LC9IGo0SghyU6NnjW+RR8TvHepZtS
	34rLhqZT+IyPNRusHdTYBKDk5QHHfb6MPN6oKR4vpxGzj1cApqipF096vu1Yg4q+ZE1dYUGNO0U
	E6hH9Tn7HYOSvQL/6khvsRUMbpnjYpSDLVM7PEvDqK44Qcut8/GPNrfHTvLvYY6K/O46IjTnnsx
	dvVTA5oWTPTAKRBsy8vd1jNQCtOje57eUsP
X-Received: by 2002:a17:906:f049:b0:c1c:4db0:8314 with SMTP id a640c23a62f3a-c246a60c26cmr1608621866b.13.1787444111460;
        Sat, 22 Aug 2026 17:15:11 -0700 (PDT)
Received: from vastdata-ubuntu2.vstd.int (89-138-65-240.bb.netvision.net.il. [89.138.65.240])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c249685ef7bsm595736866b.52.2026.08.22.17.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 17:15:10 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>
Subject: [PATCH] nvme: fix cntlid uniqueness check for different hosts
Date: Sun, 23 Aug 2026 03:15:09 +0300
Message-ID: <20260823001509.119740-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260822_171513_574391_1A544CB3 
X-CRM114-Status: GOOD (  10.80  )
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
Reply-To: sagi@grimberg.me
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

A single physical host may use a separate {hostnqn, hostid} identifiers
when connecting to a controller. It is possible that the a distributed
nvmf controller may generate unique cntlid per hostnqn and not globally
unique. Hence, validate the cntlid is unique per nvmf host.

Fixes: 1b1031ca63b2 ("nvme: validate cntlid during controller initialisation")
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 11c24f89f4fd..86c59144da74 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3265,6 +3265,10 @@ static bool nvme_validate_cntlid(struct nvme_subsystem *subsys,
 		if (nvme_state_terminal(tmp))
 			continue;
 
+		if ((ctrl->ops->flags & NVME_F_FABRICS) &&
+		    !nvmf_ctlr_matches_baseopts(tmp, ctrl->opts))
+			continue;
+
 		if (tmp->cntlid == ctrl->cntlid) {
 			dev_err(ctrl->device,
 				"Duplicate cntlid %u with %s, subsys %s, rejecting\n",
-- 
2.43.0


