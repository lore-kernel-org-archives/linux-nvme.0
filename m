Return-Path: <SRS0=jca5=JN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EB90C433B4
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Apr 2021 22:07:39 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3575610F7
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Apr 2021 22:07:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3575610F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:MIME-Version:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:References:In-Reply-To:Message-Id:Date:Subject:Cc:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jnWkKjscR6X7aHoAMpd01VLsxzdknUIOQx6D4z8S7I4=; b=dZ4aFeKxPh1NMBMaE8ElR8LL8v
	UUZRsimLM7PI1WsteHopH4wQS2XFPzvdR0VQd5K7mssuFsswuPHZIh56q5zQ6tfxFAgmUYTCoMTUW
	Qd8S6XhVGNLDYqFJ4XT7LShNaKmHCxQ9RCuqxQ5Di9dLRQGoYZ+hBhdn7XlNfZDKLqCc9Gag8klKM
	V8m7yPbmZsKcJld6AfK3qQhMjJhZ0VqC5MSca7TiLmQcKtNo+W/diERjZvIBl6RARFiXQQ3doda4P
	7Qx2lD6PEorHFQc6QfYCJ8LCQ0VqR0JSZkmg/sLapzhU1JW4d94hdQa2K7+cIrK64moi7bNTS4AGA
	l7Y0ylBg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lXWcR-003XFl-P0; Fri, 16 Apr 2021 22:07:20 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lXWbv-003XBI-RA
 for linux-nvme@desiato.infradead.org; Fri, 16 Apr 2021 22:06:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=rDUiV58X75hPG1P5uWek/G5MSETfeVhGHbmBONCaZ8U=; b=2+LXXjIMe/ZL2WoV3z+ta3c97a
 2skvCd9X7CXPn7JB/oRJM6NP4MYHlok6MpG28uc3fLXb5iGdIGKmBRJqQJPfB21jQhkiCJQ0bqBD4
 25AeaEMBrhtHng86xJ3ylG9dYCBkwp6WOSoMm0HPCw1Rwt3mUIlNAJwEdCYeR4L7hE6/S+LvJJXk6
 qTG9Vf4tKf62//q6fRWoQ1MU+CNiWFbFfd7VSAPVuwr0zHcd036Y4UnzI3uZ+ZqD+e/62ijjC9WpG
 s7Gqqh5VB7ajMCLAfjNE0ks4gdvoARbBpYTeUIO3tifSJxkNNxiRy8dlFvtp64PP+qJIld3NnqeAk
 pmzJRsJw==;
Received: from mail-qk1-x732.google.com ([2607:f8b0:4864:20::732])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lXWbt-009jkT-3C
 for linux-nvme@lists.infradead.org; Fri, 16 Apr 2021 22:06:46 +0000
Received: by mail-qk1-x732.google.com with SMTP id t17so1997010qkg.4
 for <linux-nvme@lists.infradead.org>; Fri, 16 Apr 2021 15:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=rDUiV58X75hPG1P5uWek/G5MSETfeVhGHbmBONCaZ8U=;
 b=CKj5b28UASeTOfqPWz2oTGQYrduQxQZ2eAG3FT5PPVb8fdVDOOEKtJWkRcoYjAzuFc
 sn0wYTkzxYbNVPpJ3G6aPgjV986ykrnqPpLuTeHUlplzLZCEjLzD35cvh96xpre24pgJ
 qn1zA9POnl5XUHMKv+5bLtr94YthtfWjPwvNjLwjMKR3nGxy6UaGKhz+OAiN+RNG4GFK
 2a1aJY/O9wImAS/STIru/YR9iWLevZtnYSmqyncOgWv6rRizKsXMdOPozJIgniljDwET
 EO477RXXJbHey8Y3MjWjpyQq60MAarpTff+yOghpQW1Srv8llLnIRInzD2lSZYnY95X7
 V/2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=rDUiV58X75hPG1P5uWek/G5MSETfeVhGHbmBONCaZ8U=;
 b=SqpJEWEgeNJkbqpeqquBvC04OGPvYxpDNnI79dUqbUV9LjiyaLhpPbhmwesDFG+CWz
 MjPkmX8tPrs4Z7Uyhs3Skb4yM+Wf5CT0nTViL6L9cEjzCsfgotg+RtkH56KoQRopviIx
 82/0cryYKRpU7q0K3JH/RNkFPSMqb+kl94aHyc96GgaI7bAysjuAN1VfFWvF4FJSkxu5
 VhGK+H9cjmMcbjoIDg9HbOpaoVHcVsB3mKw+Eg0IwNdajAf1vRq3HiFFTUvhFfNF1LVu
 Wy2QXt1e9+/5H1QOOZLpjKD7DUekvQSnWFkS2cp5k37H+JTGyBAVBnj9klPthUrYg4xz
 iMfA==
X-Gm-Message-State: AOAM533IAX7oCluVTEW7qzqEOjn/nXlQGsuJsIyuoURg3NSloUIdNndP
 F3L9bJfIpBYesDTAwhtHKs0=
X-Google-Smtp-Source: ABdhPJwQGhrESLAHtZ/cMgCEXSH14BFWFw6ZctlPgcT4kjH9HsxQmaXkprC7Mn2+sEKVYnurrbUTtQ==
X-Received: by 2002:a37:a1d3:: with SMTP id k202mr1452014qke.97.1618610804004; 
 Fri, 16 Apr 2021 15:06:44 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net.
 [68.160.176.52])
 by smtp.gmail.com with ESMTPSA id 132sm5094410qkn.52.2021.04.16.15.06.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Apr 2021 15:06:43 -0700 (PDT)
From: Mike Snitzer <snitzer@redhat.com>
To: Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>
Cc: dm-devel@redhat.com, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
Subject: [PATCH v3 4/4] nvme: decouple basic ANA log page re-read support from
 native multipathing
Date: Fri, 16 Apr 2021 18:06:37 -0400
Message-Id: <20210416220637.41111-5-snitzer@redhat.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20210416220637.41111-1-snitzer@redhat.com>
References: <20210416220637.41111-1-snitzer@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210416_150645_158435_7273A86B 
X-CRM114-Status: GOOD (  19.45  )
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Whether or not ANA is present is a choice of the target implementation;
the host (and whether it supports multipathing) has _zero_ influence on
this. If the target declares a path as 'inaccessible' the path _is_
inaccessible to the host. As such, ANA support should be functional
even if native multipathing is not.

Introduce ability to always re-read ANA log page as required due to ANA
error and make current ANA state available via sysfs -- even if native
multipathing is disabled on the host (e.g. nvme_core.multipath=N).
This is achieved by factoring out nvme_update_ana() and calling it in
nvme_complete_rq() for all FAILOVER requests.

This affords userspace access to the current ANA state independent of
which layer might be doing multipathing. This makes 'nvme list-subsys'
show ANA state for all NVMe subsystems with multiple controllers. It
also allows userspace multipath-tools to rely on the NVMe driver for
ANA support while dm-multipath takes care of multipathing.

And as always, if embedded NVMe users do not want any performance
overhead associated with ANA or native NVMe multipathing they can
disable CONFIG_NVME_MULTIPATH.

Signed-off-by: Mike Snitzer <snitzer@redhat.com>
---
 drivers/nvme/host/core.c      |  2 ++
 drivers/nvme/host/multipath.c | 16 +++++++++++-----
 drivers/nvme/host/nvme.h      |  4 ++++
 3 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 605ffba6835f..9a878a599897 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -349,6 +349,8 @@ static void nvme_failup_req(struct request *req)
 {
 	blk_status_t status = nvme_error_status(nvme_req(req)->status);
 
+	nvme_update_ana(req);
+
 	/* Ensure a retryable path error is returned */
 	if (WARN_ON_ONCE(!blk_path_error(status))) {
 		/*
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index a1d476e1ac02..7d94250264aa 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -65,23 +65,29 @@ void nvme_set_disk_name(char *disk_name, struct nvme_ns *ns,
 	}
 }
 
-void nvme_failover_req(struct request *req)
+void nvme_update_ana(struct request *req)
 {
 	struct nvme_ns *ns = req->q->queuedata;
 	u16 status = nvme_req(req)->status & 0x7ff;
-	unsigned long flags;
-
-	nvme_mpath_clear_current_path(ns);
 
 	/*
 	 * If we got back an ANA error, we know the controller is alive but not
-	 * ready to serve this namespace.  Kick of a re-read of the ANA
+	 * ready to serve this namespace.  Kick off a re-read of the ANA
 	 * information page, and just try any other available path for now.
 	 */
 	if (nvme_is_ana_error(status) && ns->ctrl->ana_log_buf) {
 		set_bit(NVME_NS_ANA_PENDING, &ns->flags);
 		queue_work(nvme_wq, &ns->ctrl->ana_work);
 	}
+}
+
+void nvme_failover_req(struct request *req)
+{
+	struct nvme_ns *ns = req->q->queuedata;
+	unsigned long flags;
+
+	nvme_mpath_clear_current_path(ns);
+	nvme_update_ana(req);
 
 	spin_lock_irqsave(&ns->head->requeue_lock, flags);
 	blk_steal_bios(&ns->head->requeue_list, req);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 07b34175c6ce..4eed8536625c 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -664,6 +664,7 @@ void nvme_mpath_start_freeze(struct nvme_subsystem *subsys);
 void nvme_set_disk_name(char *disk_name, struct nvme_ns *ns,
 			struct nvme_ctrl *ctrl, int *flags);
 void nvme_failover_req(struct request *req);
+void nvme_update_ana(struct request *req);
 void nvme_kick_requeue_lists(struct nvme_ctrl *ctrl);
 int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl,struct nvme_ns_head *head);
 void nvme_mpath_add_disk(struct nvme_ns *ns, struct nvme_id_ns *id);
@@ -714,6 +715,9 @@ static inline void nvme_set_disk_name(char *disk_name, struct nvme_ns *ns,
 static inline void nvme_failover_req(struct request *req)
 {
 }
+static inline void nvme_update_ana(struct request *req)
+{
+}
 static inline void nvme_kick_requeue_lists(struct nvme_ctrl *ctrl)
 {
 }
-- 
2.15.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
