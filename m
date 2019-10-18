Return-Path: <SRS0=X7Om=YL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06912CA9EA0
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Oct 2019 18:33:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA4E820869
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Oct 2019 18:33:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="I26k8w+F";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lightbitslabs-com.20150623.gappssmtp.com header.i=@lightbitslabs-com.20150623.gappssmtp.com header.b="p7DRxEWV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA4E820869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightbitslabs.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=1h4+zEYWjoznh00C7pr7ZVRXBCmkVbTs4soIDCYC8LY=; b=I26k8w+F1euj1bOknyl2bRwESX
	XADRlUEDvvrU5wcpJTkHJvwg88zTZu5eOPpJCulmVHoa5PWM63L2/ac90i9y3OkioiN6y4b4QrdWg
	TkNNH4lzZ4QHaPe3pGfRB7MowxvQzkJOD7FxyJ/u7PLrxitHZaqf260xq6yns7kwWD91kMBCqtriK
	2mnHB4z/I8hOZdnzXCaGWyb9B2XbDa1b71+/V8NCjnmxQ4fKm0q2Q/ze7gpdef99Nkcp10DfNWYo0
	BMAzqt3W7qzKv/zOiZ+BB4dd7Vroy6A4IpWmIw28pnPJrS96lxWLbTndBgBKcL/eMnY/wa0hFTkng
	xpj2kA2A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iLX4O-0007zm-Os; Fri, 18 Oct 2019 18:33:48 +0000
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iLX4I-0007ub-5Y
 for linux-nvme@lists.infradead.org; Fri, 18 Oct 2019 18:33:47 +0000
Received: by mail-pf1-x444.google.com with SMTP id q12so4383465pff.9
 for <linux-nvme@lists.infradead.org>; Fri, 18 Oct 2019 11:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lightbitslabs-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=28KEjRMlwYtEa+SEyIXxSXTc8zxEhQx02dJ0FcdDqKY=;
 b=p7DRxEWVOCX0vIg9nswCdOGj/8ZQqC29dyWeploka70nGZF88wEJbgJarByRgXGHAk
 t69IdSxkKfylsc1k1YjlXKpXu008JV+gVnfYlsSAN3Zq8cNCPo1Iot40oZKPvBPeixhZ
 AUx+Rnt2DGTRTVVn2d8TqSJqhX88ctTUyEifMJPWOLUcaB/+alDDCyOMYGLt+Jib4gyF
 IkY6FMjx8nryt73Szua2QHN89OV+OaZcUziK6fYQ6iZ7KHj5KOVdTXGNnPzZkgtaP4Np
 ihuwn4+nK3FLFnvYr+YclbFBf3UjhpaEKt6g0KUhsQGXgr6GOnxNHcp2fllNzgZYiZQi
 X3cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=28KEjRMlwYtEa+SEyIXxSXTc8zxEhQx02dJ0FcdDqKY=;
 b=rsKnb7q2BUsPPqmQdSPxNrz1eOlc4Xg8IJGWQlgFk6Ml1DKuhRInVH/hh1aFSPlhH4
 JnmyNU5myrGFLjXlSGU27CRHsoVWx0zzMyf/sMNDR3lJkPjuzSXXUZzmKEEWk5/8iPs0
 KxwORYSv8BWUHcOBanrd4y4K4DRRXwf9+wOUa7H3TyZqUg61xtUhMIGMf/ggHBzl6JCO
 ZOJqyXgHRGy+Q3lGLSMw76eaw+Ls0jlEQFlmlOWvUBZQjvTuyKS68kXex4DaqUEeLwHH
 dXbvtfj0kLlyPf9LysP/0/ri/UQqxQI+Zt7lEYcZihOU23o1tHG5IJX2bN2cYMFSyXi1
 gMuw==
X-Gm-Message-State: APjAAAVavID7t6V+YlmAYJgiPcu1S2G4qxnwdbzuwd4Kcqs1kgG86LDY
 zbeQT5b5NJR7h4jjdt1K68EGRuIPv2468w==
X-Google-Smtp-Source: APXvYqw2QUJXFAES2XL36BcBxjdA9AKpCPRsh6aTY7CpT2/t9rnLiabaabym2R2BD3/5HHVgWJ9LGQ==
X-Received: by 2002:a17:90a:868c:: with SMTP id
 p12mr13156402pjn.45.1571423620900; 
 Fri, 18 Oct 2019 11:33:40 -0700 (PDT)
Received: from localhost.localdomain
 ([2600:1700:65a0:78e0:b5b2:2e71:2e69:81ce])
 by smtp.googlemail.com with ESMTPSA id q33sm6822415pgm.50.2019.10.18.11.33.39
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 18 Oct 2019 11:33:40 -0700 (PDT)
From: Anton Eidelman <anton@lightbitslabs.com>
To: linux-nvme@lists.infradead.org, hch@lst.de, keith.busch@intel.com,
 sagi@grimberg.me, hare@suse.de
Subject: [PATCH v2 2/2] nvme-multipath: remove unused groups_only mode in ana
 log
Date: Fri, 18 Oct 2019 11:32:51 -0700
Message-Id: <20191018183251.501-2-anton@lightbitslabs.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20191018183251.501-1-anton@lightbitslabs.com>
References: <20191018091016.GA25478@lst.de>
 <20191018183251.501-1-anton@lightbitslabs.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191018_113342_256947_06DB3013 
X-CRM114-Status: GOOD (  12.95  )
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
Cc: Anton Eidelman <anton@lightbitslabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

groups_only mode in nvme_read_ana_log() is no longer used: remove it.

Signed-off-by: Anton Eidelman <anton@lightbitslabs.com>
---
 drivers/nvme/host/multipath.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index d320684d25b2..fc99a40c1ec4 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -522,14 +522,13 @@ static int nvme_update_ana_state(struct nvme_ctrl *ctrl,
 	return 0;
 }
 
-static int nvme_read_ana_log(struct nvme_ctrl *ctrl, bool groups_only)
+static int nvme_read_ana_log(struct nvme_ctrl *ctrl)
 {
 	u32 nr_change_groups = 0;
 	int error;
 
 	mutex_lock(&ctrl->ana_lock);
-	error = nvme_get_log(ctrl, NVME_NSID_ALL, NVME_LOG_ANA,
-			groups_only ? NVME_ANA_LOG_RGO : 0,
+	error = nvme_get_log(ctrl, NVME_NSID_ALL, NVME_LOG_ANA, 0,
 			ctrl->ana_log_buf, ctrl->ana_log_size, 0);
 	if (error) {
 		dev_warn(ctrl->device, "Failed to get ANA log: %d\n", error);
@@ -565,7 +564,7 @@ static void nvme_ana_work(struct work_struct *work)
 {
 	struct nvme_ctrl *ctrl = container_of(work, struct nvme_ctrl, ana_work);
 
-	nvme_read_ana_log(ctrl, false);
+	nvme_read_ana_log(ctrl);
 }
 
 static void nvme_anatt_timeout(struct timer_list *t)
@@ -715,7 +714,7 @@ int nvme_mpath_init(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 		goto out;
 	}
 
-	error = nvme_read_ana_log(ctrl, false);
+	error = nvme_read_ana_log(ctrl);
 	if (error)
 		goto out_free_ana_log_buf;
 	return 0;
-- 
2.14.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
