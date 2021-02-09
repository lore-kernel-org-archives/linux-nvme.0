Return-Path: <SRS0=1rws=HL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD79DC433DB
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Feb 2021 10:12:52 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CE2D64E6C
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Feb 2021 10:12:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CE2D64E6C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=AwumxuisXmSZca4iuEsCQRSegCVVuMnwPs5cXjB2+YQ=; b=xUseXFe/aqkmSEcF1Si8Z2EVI8
	QBB1fvLw4Plwi7J8GBv+Vfe1K48LDwjO+vSjoQfhRX0ukDyC0M4pQ93kC+dc8ZHniv73aT+H0VvOn
	MWsm841j7Fry+otNsA9xVq2vFKxFuOergp54ydJviFWo5rBvLUwXDwllYT9HFvHlwjwy2ZpjHXsJo
	FNWzxPiZn2YCinBgRk1Z5aEpaDSvzaMAcsTgmdbnyB2FI/Uj47gob5k3LtY63ccK/mnVQR1TneazU
	ziHHI4c1LY7MdXfhlbOOG5Vz2K5dR+LZfZ6QCyab3dHv8KHyu7o7trOilAfQJaJXq1qmtXB5oVe0e
	205TlNAQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l9Q0k-0004lo-Hd; Tue, 09 Feb 2021 10:12:46 +0000
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l9Q0h-0004kj-Hw
 for linux-nvme@lists.infradead.org; Tue, 09 Feb 2021 10:12:44 +0000
Received: by mail-wm1-f50.google.com with SMTP id i9so2900111wmq.1
 for <linux-nvme@lists.infradead.org>; Tue, 09 Feb 2021 02:12:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=mQOj3RoxD3ureYd4iXtGhyixc3bKSn+1Tsdkhks7j3M=;
 b=hGUfLwYfYdDCWTu1KSA6Bo3sio32YzHZpJPeHrH0u4/NOU9LepPvrldHXnKTZ4ZaH4
 R1SaPUcxBH6n0PFUlowH61QTRiIsFKKgbVs1ttriRcaAPknIC0mS/9hJwlgag+Q/4baJ
 sfRuFRGHjQd4Y0xoF6OMJd8odHYB4AtOz3LfGliNnzmBTfRn1WM9scSloH6z7KDCyuaP
 wqKUYtM7Jgd5vK+AB/kZZOUoYqLEMGpMFCemz38lpTFL8I7/cZa7thmvdMHVe2f6iYOL
 SGVbft1OduoKlrt+eZeaBD0P+qYTKs1qK4mu8cOvaDugY7BKbTWg67eUPLqXCXoDmB5U
 hSWw==
X-Gm-Message-State: AOAM530oqKjOqeUjuedngbUjau91cQA09lyVSkg7jfeJ8hE7FzdxycrA
 09Esqxxgu06yPFA/48b+C7h1JCsXum4=
X-Google-Smtp-Source: ABdhPJyrFLmoIT/oVWMowrG5ONrOLcxP533HSxXZUPXTv2lv03BCthHUk15op9V83YKXmHIcjxxPEg==
X-Received: by 2002:a1c:40d4:: with SMTP id n203mr2717130wma.46.1612865561843; 
 Tue, 09 Feb 2021 02:12:41 -0800 (PST)
Received: from localhost.localdomain ([2601:647:4802:9070:2121:4cf7:e6f6:2dc5])
 by smtp.gmail.com with ESMTPSA id h9sm11173396wrc.94.2021.02.09.02.12.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Feb 2021 02:12:41 -0800 (PST)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Subject: [PATCH 1/2] nvmet: don't check iosqes,
 iocqes for discovery controllers
Date: Tue,  9 Feb 2021 02:12:34 -0800
Message-Id: <20210209101235.1539917-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210209_051243_608615_7C8C08F5 
X-CRM114-Status: GOOD (  15.32  )
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
Cc: Martin.Belanger@dell.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From the base spec, Figure 78:
"Controller Configuration, these fields are defined as parameters to
configure an "I/O Controller (IOC)" and not to configure a "Discovery
Controller (DC)".
...
"If the controller does not support I/O queues, then this field shall
be read-only with a value of 0h"

Just have this check for I/O controllers.

Fixes: a07b4970f464 ("nvmet: add a generic NVMe target")
Reported-by: Belanger, Martin <Martin.Belanger@dell.com>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/target/core.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 8ce4d59cc9e7..baa26a65d83d 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1107,9 +1107,14 @@ static void nvmet_start_ctrl(struct nvmet_ctrl *ctrl)
 {
 	lockdep_assert_held(&ctrl->lock);
 
-	if (nvmet_cc_iosqes(ctrl->cc) != NVME_NVM_IOSQES ||
-	    nvmet_cc_iocqes(ctrl->cc) != NVME_NVM_IOCQES ||
-	    nvmet_cc_mps(ctrl->cc) != 0 ||
+	if (!ctrl->subsys->type == NVME_NQN_DISC &&
+	    (nvmet_cc_iosqes(ctrl->cc) != NVME_NVM_IOSQES ||
+	     nvmet_cc_iocqes(ctrl->cc) != NVME_NVM_IOCQES)) {
+		ctrl->csts = NVME_CSTS_CFS;
+		return;
+	}
+
+	if (nvmet_cc_mps(ctrl->cc) != 0 ||
 	    nvmet_cc_ams(ctrl->cc) != 0 ||
 	    nvmet_cc_css(ctrl->cc) != 0) {
 		ctrl->csts = NVME_CSTS_CFS;
-- 
2.27.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
