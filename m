Return-Path: <SRS0=ZbIm=I7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA272C433B4
	for <linux-nvme@archiver.kernel.org>; Fri,  2 Apr 2021 01:39:39 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84E4660FF3
	for <linux-nvme@archiver.kernel.org>; Fri,  2 Apr 2021 01:39:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84E4660FF3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=S5tZprP3VwZXmVNveQUPMRIgk+Glr8iUJbNrRD0RYEM=; b=RCNF1Q6QdwY2VaSL2jBiog6IPB
	D9Hl8dqK+vcV+VGmsRhGQURKH4krLQGTvF9Hx1hB57JKP0+c0zTI6CJh73K3fMK1opB4KqRya4Wjl
	HKilznwhIgguOTSuwmbtqnMSPcMgPwZpNYk4iDSp0pOIRHsB9XUGNoQORrYxKM7Rc/kAc/p16fXeb
	9jf51T80a2koHF1yX03Hp+DUc7rcB/nudQFq2iTcm6u+huvIfgiwKVgegapSraqZ0PBbp2271MSHx
	ykopEA1FyCQIvLUHWYNIr/g6FS+isCaWY22YoEP8QQHEDR7d206o7o6nGhkeFWcTjYgEnJheaCQh0
	cf264UDg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lS8mY-00BenJ-PZ; Fri, 02 Apr 2021 01:39:30 +0000
Received: from mail-pj1-f44.google.com ([209.85.216.44])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lS8mP-00Bemq-3f
 for linux-nvme@lists.infradead.org; Fri, 02 Apr 2021 01:39:28 +0000
Received: by mail-pj1-f44.google.com with SMTP id
 q6-20020a17090a4306b02900c42a012202so1901519pjg.5
 for <linux-nvme@lists.infradead.org>; Thu, 01 Apr 2021 18:39:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=f9rzSNFQL7WSw83vcVwbNTB/VHQPBi9t2QvqgsigC04=;
 b=DAWVnxCgevmcXPzEUJFBxyzJQeZd+TkqkuJnIKgY4cHjO3dPYfhC7mHb23fbt11m9A
 sZj9rrjaz0DJ90lheY1ORpzhgruFS3oUA764gRs5DHgJoEEgsD61g2umUfJGa+m3kxMM
 J6jH8WWREv/wgwr7Qewi8Rt1wSaYGSTBA964DdH8QDtWlhQZiRd9bkkOx0Mw1hR91QGQ
 +QY2imSuTsNFGND71Tw4cmCed8fkjl7Mgr/QMj5Sw7wmbYj0n8Lg9LCmLbI9zlPpJ/LQ
 i1LOvk9yvbLRhJroY5rao/T2ZN6zR36Xr5VElPa0XF4wuOpkj0uZpnROuH5SFyZx5M5y
 tFVA==
X-Gm-Message-State: AOAM533duPxlQ4jL86AWf/r31a++m6WeAUMSkSkRc07yf5N81P2XtVoc
 ZG6Q88sO0+hrUNA9lhY4MoE=
X-Google-Smtp-Source: ABdhPJx4vNHvktZTyi23gKIOc1lxgEOL2oZ61jF8ml5ZvP+eZKoRTsROXvmupI1rtlyd9LW2Rfb+nA==
X-Received: by 2002:a17:90a:d911:: with SMTP id
 c17mr11057210pjv.98.1617327559746; 
 Thu, 01 Apr 2021 18:39:19 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net
 ([2601:647:4000:d7:2046:e611:bcdf:eb50])
 by smtp.gmail.com with ESMTPSA id x25sm6655149pfn.81.2021.04.01.18.39.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Apr 2021 18:39:18 -0700 (PDT)
From: Bart Van Assche <bvanassche@acm.org>
To: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v3] nvme: Fix handling of large MDTS values
Date: Thu,  1 Apr 2021 18:39:07 -0700
Message-Id: <20210402013907.10131-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210402_023925_167163_CF7B87DB 
X-CRM114-Status: GOOD (  12.59  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Instead of triggering an integer overflow and undefined behavior if MDTS is
large, set max_hw_sectors to UINT_MAX.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Keith Busch <kbusch@kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---

Changes compared to v2: reduced the two max_hw_sectors = UINT_MAX statements into a single assignment.
Changes compared to v1: removed a dev_err() call.

 drivers/nvme/host/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 40215a0246e4..87d43309742b 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3123,10 +3123,10 @@ static int nvme_init_identify(struct nvme_ctrl *ctrl)
 
 	atomic_set(&ctrl->abort_limit, id->acl + 1);
 	ctrl->vwc = id->vwc;
-	if (id->mdts)
-		max_hw_sectors = 1 << (id->mdts + page_shift - 9);
-	else
+	if (!id->mdts || check_shl_overflow(1U, id->mdts + page_shift - 9,
+					    &max_hw_sectors)) {
 		max_hw_sectors = UINT_MAX;
+	}
 	ctrl->max_hw_sectors =
 		min_not_zero(ctrl->max_hw_sectors, max_hw_sectors);
 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
