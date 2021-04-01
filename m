Return-Path: <SRS0=sXsN=I6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82E1BC433ED
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Apr 2021 04:00:34 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFF1961008
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Apr 2021 04:00:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFF1961008
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=oo41qB/peRKGnRQ30lntAe4f+Q1FSiz2kcqRECTcws8=; b=PoQ8+2W+1plCofxO34wEQucCdV
	IX4Sy3rEFK/RGcEECXYYAljLyR2kVejf5uPZQknTYFrTivmO40XF3siHugB7eEaJj2D02W6CUjarZ
	ypOOdxHHSgd+rJwnsCTr0mkUkmI7CAdNss+MjTxxsQripzyk0r2KUgR1y1YmDQXRTOoPz92lYiF1b
	Q0uvVQCpkhOJ8pmAn+Xj3lpqt1qyml0YjKxO+ZVAoT6e4McCZ0JU9RYKOvkB4AOfbRSGP3U6sA+p5
	LCU3ezRXHXN+2RW02Tft663lyh9DnobSlMJMqltGPoT6RkECAa8zDHFyFGdXGvrZgh1PRtXwQgG/i
	0omkmMAw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lRoV9-008NLf-3o; Thu, 01 Apr 2021 04:00:11 +0000
Received: from mail-pj1-f54.google.com ([209.85.216.54])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lRoUz-008NJY-Kd
 for linux-nvme@lists.infradead.org; Thu, 01 Apr 2021 04:00:03 +0000
Received: by mail-pj1-f54.google.com with SMTP id
 kk2-20020a17090b4a02b02900c777aa746fso282246pjb.3
 for <linux-nvme@lists.infradead.org>; Wed, 31 Mar 2021 21:00:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=CM1JIXx0R1MzT5DxxHKvDG0Xic1hHBz3dcnm4AGL9+8=;
 b=HIrVxTzne5cwst/7cVwwY23IMLVgA8h1I7yFz3ONK1OSwdWB5A1QKz/sP3KGYFXoqL
 p0fIEVDt94C3ty9tXQWBjhdlrmqnsUuYG8gnO+0rgSP3d8Srj3N30Kgpqp3Ng7KwJjMV
 WP5BalNhotMsDCwQdzHsc2w/OBrV+Wd/fV+zNZB6IS40bhK1IobepxQ5f2oIJZQU3jIo
 s6l8flsOKgcWP3e5IK4CC/3R8Nca/qH4/LveMlrLArO0WCAKVxCqXRgeJQpdYTYYKc7D
 J1c414j+qj+1DlZyCNNpuB0cgkVqmgCik3TA5bmnwRXuXdqTP9DmGur/RJl0SL6daKi1
 yI+A==
X-Gm-Message-State: AOAM530MythND8XvGw1ABqItWEPmpfra3GKSam+AJJwAN9aEy7qEJ//V
 o59KF94j17fXs4VdWVGPcr0=
X-Google-Smtp-Source: ABdhPJwaf1YHzql/JgUeu8hWTyX1lo2qi22ZVbATd9g4MvJ2NfImqyVYQYHdChPFHnf3E+BYg5T++Q==
X-Received: by 2002:a17:90a:5898:: with SMTP id
 j24mr6814804pji.103.1617249599301; 
 Wed, 31 Mar 2021 20:59:59 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net
 ([2601:647:4000:d7:be87:d7bf:6a65:f00d])
 by smtp.gmail.com with ESMTPSA id q19sm3694981pff.91.2021.03.31.20.59.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Mar 2021 20:59:58 -0700 (PDT)
From: Bart Van Assche <bvanassche@acm.org>
To: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v2] nvme: Fix handling of large MDTS values
Date: Wed, 31 Mar 2021 20:59:52 -0700
Message-Id: <20210401035952.7249-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210401_050001_874803_8479A4D1 
X-CRM114-Status: GOOD (  11.47  )
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

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---

Changes compared to v1: removed a dev_err() call.

 drivers/nvme/host/core.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 40215a0246e4..25bc28e8845f 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3123,10 +3123,11 @@ static int nvme_init_identify(struct nvme_ctrl *ctrl)
 
 	atomic_set(&ctrl->abort_limit, id->acl + 1);
 	ctrl->vwc = id->vwc;
-	if (id->mdts)
-		max_hw_sectors = 1 << (id->mdts + page_shift - 9);
-	else
+	max_hw_sectors = UINT_MAX;
+	if (id->mdts && check_shl_overflow(1U, id->mdts + page_shift - 9,
+					   &max_hw_sectors)) {
 		max_hw_sectors = UINT_MAX;
+	}
 	ctrl->max_hw_sectors =
 		min_not_zero(ctrl->max_hw_sectors, max_hw_sectors);
 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
