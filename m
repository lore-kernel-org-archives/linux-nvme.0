Return-Path: <SRS0=Ae0q=BN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12C11C433E0
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Aug 2020 06:59:10 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D85522068F
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Aug 2020 06:59:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Gs9wWtbA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D85522068F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:To:From:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8tgVSuVxZth//iRFHovs0MRlPdSRmRmg+E/JOUN9HoU=; b=Gs9wWtbAPUFSZsI04sEoXbWqdE
	X1r5toqbIsV/f5OJxFyfhQXZPIzANtrfaFMV+NM2wH9q8l7e8j5luaB1JiIredPMLUlEqU+stnqmb
	f+2ipm7K3DRbm3n/F8q1xmgHT+q4yJmFYDroSTc8KiJ7HRIiaycdg1EOL3ipYdSGuagt722fKUWg7
	qkH8hJ9RxU2J6qbs15LXeTHuA/HADxdXMsAROkcZ/2bwI38VDmbO4qv2oLYGXEf/rMnjZinAJMMtm
	8GahdiqsY0WnRgqYs2ywTVKzd0t6GGT6f3/f5yuTspYujVxF5y48pwzZmo0KXCJqSKhacBU9Huic/
	+y5Me0BA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k2UR9-0004tw-Ft; Mon, 03 Aug 2020 06:59:07 +0000
Received: from mail-wm1-f67.google.com ([209.85.128.67])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k2UR6-0004s3-FF
 for linux-nvme@lists.infradead.org; Mon, 03 Aug 2020 06:59:05 +0000
Received: by mail-wm1-f67.google.com with SMTP id x5so13303020wmi.2
 for <linux-nvme@lists.infradead.org>; Sun, 02 Aug 2020 23:59:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7lOx1NKUjyA48c1HJ6UMtfILsFPQ7TUxKxaSnBY6Rjo=;
 b=ld46nJRlC8P57dKlWQxFHWWMK3e4hvTQEskxyng+rEkyQap0vO9f5bLQ3v7YvwrBDZ
 DUN/pX4fBKsBBJ7hQij2ULEZ9GyKieq9YPnj5WqOGH6FLZv2475TiT0YfiuJddc14WNv
 Sg1GOyM+UUzEvWI2L59eSdgKL5Rpq7NbCw1rvWKHsBt9iJZ9dLbyY2iIbajWyGpStO0f
 pdVGkwvINfLFKpWsUjF1G3oUxfdj+pgCA9B+XfiAZ2uKt+kDQwRNDH9DLpB9x3q6wHbh
 ED9v+Bg5iZOVdRwRWRP8myr++4prr5QIKdxNHiXPVj0g2p5UgVmnB/Fw3bOfaFcayQWS
 Qzmw==
X-Gm-Message-State: AOAM530pdmiCh82T+c76tDv+57b3qShdMkXzPMeylhDuGsP6Jxymz+K7
 Yz79kLHlWNkKzmF43DcBRmA7qCwE
X-Google-Smtp-Source: ABdhPJzwy/OWn0NWbYz1VySrfVsKOO0S2F6kSEM67+QuUh4rk3MIjNjCQcPSQ3aV6wwdhMlMWPf3JA==
X-Received: by 2002:a1c:80c1:: with SMTP id b184mr3666897wmd.121.1596437942781; 
 Sun, 02 Aug 2020 23:59:02 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4802:9070:6dac:e394:c378:553e])
 by smtp.gmail.com with ESMTPSA id c15sm21574511wme.23.2020.08.02.23.59.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Aug 2020 23:59:02 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, James Smart <james.smart@broadcom.com>
Subject: [PATCH 2/6] nvme: have nvme_wait_freeze_timeout return if it timed out
Date: Sun,  2 Aug 2020 23:58:48 -0700
Message-Id: <20200803065852.69987-3-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200803065852.69987-1-sagi@grimberg.me>
References: <20200803065852.69987-1-sagi@grimberg.me>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200803_025904_515658_F92A7AB8 
X-CRM114-Status: GOOD (  13.22  )
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

users can detect if the wait has completed or not

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/core.c | 3 ++-
 drivers/nvme/host/nvme.h | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index e8cc728dee46..fd99ec0118a3 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4519,7 +4519,7 @@ void nvme_unfreeze(struct nvme_ctrl *ctrl)
 }
 EXPORT_SYMBOL_GPL(nvme_unfreeze);
 
-void nvme_wait_freeze_timeout(struct nvme_ctrl *ctrl, long timeout)
+int nvme_wait_freeze_timeout(struct nvme_ctrl *ctrl, long timeout)
 {
 	struct nvme_ns *ns;
 
@@ -4530,6 +4530,7 @@ void nvme_wait_freeze_timeout(struct nvme_ctrl *ctrl, long timeout)
 			break;
 	}
 	up_read(&ctrl->namespaces_rwsem);
+	return timeout;
 }
 EXPORT_SYMBOL_GPL(nvme_wait_freeze_timeout);
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index c5c1bac797aa..e82744de3cd3 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -574,7 +574,7 @@ void nvme_kill_queues(struct nvme_ctrl *ctrl);
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
