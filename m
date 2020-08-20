Return-Path: <SRS0=ANWg=B6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACDC5C433E1
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Aug 2020 05:37:15 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7ADDF2072D
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Aug 2020 05:37:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="zMIxxJ2q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7ADDF2072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:To:From:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=e9i83Um4/6BI5z5GGpOMRiv5Qa5eByRAKI1R1djQhqQ=; b=zMIxxJ2q+Ty7sW4bjfg9/j/tS7
	IelQXqbwh/LoKge1U0ppRipKk4WdNIM9+QidhgI9GNdEhzW0joDz2/bYfIEl7Raw65+w35NafhFEh
	QTubhS/1rgZOuwEQG1ARt3BVfZXaNCb/fhy1a44UIi2feTkLt2Oqt9ks9ZHkoS8nb/i0/jFoc8dx4
	XIvERHqzvIIL+Fn27pY7oCvBO8Uo3gQzfP6oLjpJ643n6Bs/B1Hx7p3LKqbEYK4kPlyxed8lY3b3I
	RBm+bQkK6kAmTsHJGarMXhMYl9+ONH+PPEL0B6VujX/n4HL96tx3j3AwkKZoe7BC/12Q4LEypsxxp
	Rv/aLn2g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k8dGD-0000eD-Kl; Thu, 20 Aug 2020 05:37:13 +0000
Received: from mail-wm1-f67.google.com ([209.85.128.67])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k8dGA-0000cq-Hz
 for linux-nvme@lists.infradead.org; Thu, 20 Aug 2020 05:37:11 +0000
Received: by mail-wm1-f67.google.com with SMTP id g75so503066wme.4
 for <linux-nvme@lists.infradead.org>; Wed, 19 Aug 2020 22:37:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=n1se3Qe9w50x3l1VijYXh2Hv3CNt7CLRd/pe39KdsGU=;
 b=eCrA6CYGAk+tqaYfxc+DFQtq1DHZJ7SCK1mJbIOIEy2tMLan2oA/W/EDMGZDRSjiMx
 xhnZTcod6ooMDN6yaMaMLQ/QfEM3pi1qiSaUXIAG7iwb/KQXLlxLflsb3OAKldpdv0Nd
 XyTt8Ple7hK4jVR4w+wHQZ3n7PYTcKWf//i4LWRkp8oYh+nvFjx4LQH9iihB5hLvqh53
 HPyVv/YNCGLXoGq4zdAArxhgHFSfIJDo31xlECq/oIfJNXs+aJWwzomWKQwTQXjNBd4l
 nIUk1ppVKjNDKZ8AKjh7HWuLiUxTLqntP464ycU1H42OwcoeFDkrIZyAbBNQNk/1jp75
 I2wQ==
X-Gm-Message-State: AOAM5326LoekdawI1L/QLiDhUUWhORdBOz3nnE168S713x5SxHdg3dOi
 JE1Tj2FVe6N9oAJbFGp3yEPGUi9WD/7z1g==
X-Google-Smtp-Source: ABdhPJzfIQ3SaRKlL+Ql+dCoez/RHU67iYzimyH5xJWLdXmAwAutkCia6jiDZXfj7yJrwGEkhpF2bg==
X-Received: by 2002:a7b:c1c3:: with SMTP id a3mr1729817wmj.111.1597901829550; 
 Wed, 19 Aug 2020 22:37:09 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4802:9070:7ced:8569:4373:1bd3])
 by smtp.gmail.com with ESMTPSA id a10sm1900353wro.35.2020.08.19.22.37.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2020 22:37:09 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, James Smart <james.smart@broadcom.com>
Subject: [PATCH v3 3/9] nvme: have nvme_wait_freeze_timeout return if it timed
 out
Date: Wed, 19 Aug 2020 22:36:45 -0700
Message-Id: <20200820053651.197057-4-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200820053651.197057-1-sagi@grimberg.me>
References: <20200820053651.197057-1-sagi@grimberg.me>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200820_013710_705825_A9DB44B8 
X-CRM114-Status: GOOD (  13.94  )
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

Users can detect if the wait has completed or not and take appropriate
actions based on this information (e.g. weather to continue
initialization or rather fail and schedule another initialization
attempt).

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/core.c | 3 ++-
 drivers/nvme/host/nvme.h | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 725f1263b7d2..65333f67e2ff 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4541,7 +4541,7 @@ void nvme_unfreeze(struct nvme_ctrl *ctrl)
 }
 EXPORT_SYMBOL_GPL(nvme_unfreeze);
 
-void nvme_wait_freeze_timeout(struct nvme_ctrl *ctrl, long timeout)
+int nvme_wait_freeze_timeout(struct nvme_ctrl *ctrl, long timeout)
 {
 	struct nvme_ns *ns;
 
@@ -4552,6 +4552,7 @@ void nvme_wait_freeze_timeout(struct nvme_ctrl *ctrl, long timeout)
 			break;
 	}
 	up_read(&ctrl->namespaces_rwsem);
+	return timeout;
 }
 EXPORT_SYMBOL_GPL(nvme_wait_freeze_timeout);
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 49a566d192a7..c676af150665 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -598,7 +598,7 @@ void nvme_kill_queues(struct nvme_ctrl *ctrl);
 void nvme_sync_queues(struct nvme_ctrl *ctrl);
 void nvme_unfreeze(struct nvme_ctrl *ctrl);
 void nvme_wait_freeze(struct nvme_ctrl *ctrl);
-void nvme_wait_freeze_timeout(struct nvme_ctrl *ctrl, long timeout);
+int nvme_wait_freeze_timeout(struct nvme_ctrl *ctrl, long timeout);
 void nvme_start_freeze(struct nvme_ctrl *ctrl);
 
 #define NVME_QID_ANY -1
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
