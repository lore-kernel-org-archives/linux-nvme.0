Return-Path: <SRS0=Gu9/=BD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EAC6C433E1
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Jul 2020 16:32:23 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DAA9206EB
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Jul 2020 16:32:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XT21Pasv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DAA9206EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=L4fMivVe9MeTyCINz6DWbfpwHBUbHpsXXssk1WyKd9A=; b=XT21PasvMI4MmJB+LQbOhyDhpC
	I+XrOU/v3g1U3GtD8q5SC/uvtKB3mpQk3RuXpNtsiUrtC8auU9xhLCMc6vZD2wSCZOhO64W9Q2hlP
	lrxrEmfkuvQ6lNQzZirprRsnKM4F023GmU622wLK28oEVUCaZefbdqEWiv33qYNPf39JW4TRFL1wT
	Brr8D178QJ3iZUeStAxRvxAdhEEkGLDbEJKU4ozTWxkvjpoFTuC67DecQ+Z28/QpAHHuXgsWbuAQ2
	jYGC5pKlHddhKHnu6Nq3JGqMZiNl3w8bgKXiopYd+dxFF1qmC/1GcZENa2qsCrtFTPM/5HDG16jl/
	zV7q3fxQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jz0cM-0006GP-20; Fri, 24 Jul 2020 16:32:18 +0000
Received: from mail-pg1-f195.google.com ([209.85.215.195])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jz0cJ-0006Fx-MU
 for linux-nvme@lists.infradead.org; Fri, 24 Jul 2020 16:32:16 +0000
Received: by mail-pg1-f195.google.com with SMTP id t6so5540026pgq.1
 for <linux-nvme@lists.infradead.org>; Fri, 24 Jul 2020 09:32:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=WDwV9GCfork4syz/xQoVq2g0QiGqh+QJBRcVvFpQp4A=;
 b=b4sWn6MtiaR6EJ/KUU1tJXYr2HDpucMeFKleyCB9NcjvJRdsTLrKw7rOSns4kbge19
 WssP0gT35lMi+iw5o6dxBNgn8SrlBpB5k1NFv5nPQfKqzo0r2h47XHTgLuNTvT/IfPsf
 I13WDMWZgcTab5a+XF2OkNxUHyRml7vn2yDybTDOSgU6oVigPV138VwsEdUM0HXCuPSO
 MkVtXG0wL+kNbFs3wVytdsgLHy/8VEcvlFxYyinv5oCZQ9aaYRDzC3us5NFaQL2EGuRw
 3F1cUsw5E7liPLEtI40hpBp15GkUco1Fck4hlj42ynsOnp7uBjapVAX3kYCBp7FMXOzp
 b1nQ==
X-Gm-Message-State: AOAM531oGal8wm+eyvMcafU3/1+rE/XXKuqZNoQ6ImfTikuHyZcdMuFq
 Eh72jFvhsb8LDBmfkwfJdsSlvDJY
X-Google-Smtp-Source: ABdhPJyYckWzSwS37xHEdbCbL44+0hHCMPVNEdHNBEYvPid1MqDRXurlTZBJqNxpLb5/rS8f031BPQ==
X-Received: by 2002:aa7:91d3:: with SMTP id z19mr9481941pfa.119.1595608332150; 
 Fri, 24 Jul 2020 09:32:12 -0700 (PDT)
Received: from sagi-Latitude-7490.hsd1.ca.comcast.net
 ([2601:647:4802:9070:a07e:34d2:a5fa:d770])
 by smtp.gmail.com with ESMTPSA id w1sm6499831pfc.55.2020.07.24.09.32.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2020 09:32:11 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>
Subject: [PATCH] nvme-fabrics: don't fast fail on ctrl state DELETING
Date: Fri, 24 Jul 2020 09:32:10 -0700
Message-Id: <20200724163210.614747-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200724_123215_762363_4F440514 
X-CRM114-Status: GOOD (  10.87  )
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

This is now an state that allows for I/O to be sent to the
device, and when the device shall transition into
NVME_CTRL_DELETING_NOIO we shall fail the I/O.

Note that this is fine because the transport itself has
a queue state to protect against queue access.

Reported-by: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/fabrics.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Christoph: this should probably be folded into
97e9bb2b27bc ("nvme: fix deadlock in disconnect during scan_work and/or ana_work")

diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index a0ec40ab62ee..a9c1e3b4585e 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -182,7 +182,8 @@ bool nvmf_ip_options_match(struct nvme_ctrl *ctrl,
 static inline bool nvmf_check_ready(struct nvme_ctrl *ctrl, struct request *rq,
 		bool queue_live)
 {
-	if (likely(ctrl->state == NVME_CTRL_LIVE))
+	if (likely(ctrl->state == NVME_CTRL_LIVE ||
+		   ctrl->state == NVME_CTRL_DELETING))
 		return true;
 	return __nvmf_check_ready(ctrl, rq, queue_live);
 }
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
