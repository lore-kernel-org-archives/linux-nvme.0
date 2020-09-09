Return-Path: <SRS0=XP6N=CS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE798C433E2
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Sep 2020 21:58:41 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72B9821D81
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Sep 2020 21:58:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NYv35tII"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72B9821D81
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=xLyaciEqo65C+z946FXBPXdqepHMex+UnJDN/ARWJbk=; b=NYv35tIInIfD+pH+oRxZSW2y9d
	yNhzuDeGftGdNJeWxxLP4sH+eTFi0cifJWx1SRXQVxcFmBSNveJ0upZRua6klTgt9iCc2C0XZ2NoN
	ENOiZpPotUQqLmQ9o5AfDIqzyb3S6FtnymcEiQMQN9S44omFpL9QcIi7yLzR6S23swZPmwKgi1lvP
	QgFxuFeVYReWvwnCkB2sLXkXOTHN9GZvWJX+Hw099X9j1Uqw+wFDD0JJqDyIAzMITLSDhlABK2+/T
	xcVh4A0tX9e0d0L/hlJMZwNr/I4jx1WOTc1EPFdeOPMFrutENqvBGO6Ej7YTJSC9zi1T7Q2qd0ltv
	tA9WD01g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kG86x-00011j-Fc; Wed, 09 Sep 2020 21:58:39 +0000
Received: from mail-pg1-f193.google.com ([209.85.215.193])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kG86u-000118-Ku
 for linux-nvme@lists.infradead.org; Wed, 09 Sep 2020 21:58:37 +0000
Received: by mail-pg1-f193.google.com with SMTP id j34so3058182pgi.7
 for <linux-nvme@lists.infradead.org>; Wed, 09 Sep 2020 14:58:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=D7Ld0JGUe2uHtunOWP4PWDnksDBp2mrmPCYJ3d23aA4=;
 b=rOzsffzY6r+QrF3ea6Xa8XQKfp3LBNVq3tDyUxkW7B03MLEgT0f0GCRwFIVMKiyPSN
 hayBZxJ2Wy/KoNh6JhoeKa0WrCnL0SRjXFLaDIFkX1UvEMJNnS+0h9NlAtVUyrsnlvLr
 nNE/tfaOm9uue7nCJ3acqAvrPU8RH/KFe6GqUxymTPHPIfvZrSSXV9lskZF+5wIyn0Mv
 uvZDTq/y0hplC80LL+xDedZzAXoX8/La4KzpNmzHHRRqUGhBFuPtZH/HTShdB+FlSAU8
 CLx3maBu4HxI76rIqCrOFd4WDSi85DL9w6VPz2/cYaPTJ8DVxrI2312SAW8kNzEwFB90
 Z1CA==
X-Gm-Message-State: AOAM5336Sz/JmnQuumYqdeDIwY1LOIT64+7qxXFN4ow22PEFLQNU+fm5
 DqRYJZSrk353knlfEePWmoQXxI9Jca0=
X-Google-Smtp-Source: ABdhPJxNOgjPDb39oO5IxlEXAiFBjA44TniWvauoHzXRJbyjAfXb2+xoBsjTagjEpdjHXMBcVxn+HA==
X-Received: by 2002:a17:902:6ac3:: with SMTP id
 i3mr2642660plt.21.1599688715084; 
 Wed, 09 Sep 2020 14:58:35 -0700 (PDT)
Received: from sagi-Latitude-7490.hsd1.ca.comcast.net
 ([2601:647:4802:9070:5905:3209:6aa:d817])
 by smtp.gmail.com with ESMTPSA id j14sm3035626pgf.76.2020.09.09.14.58.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2020 14:58:34 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>
Subject: [PATCH v2 nvme-cli] nvme-status: Don't reduce all negative statuses
 to ECOMM
Date: Wed,  9 Sep 2020 14:58:33 -0700
Message-Id: <20200909215833.317258-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200909_175836_701072_8036D3B2 
X-CRM114-Status: GOOD (  13.34  )
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

There should be no reason why we should reduce all the semantic status
codes we are getting from the device/driver to a single meaningless
status code.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
Changes from v1:
- return errno instead of status

 nvme-status.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/nvme-status.c b/nvme-status.c
index a78c1fd02797..7821de2df288 100644
--- a/nvme-status.c
+++ b/nvme-status.c
@@ -142,7 +142,7 @@ __u8 nvme_status_to_errno(int status, bool fabrics)
 		return 0;
 
 	if (status < 0)
-		return ECOMM;
+		return errno;
 
 	/*
 	 * The actual status code is enough with masking 0xff, but we need to
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
