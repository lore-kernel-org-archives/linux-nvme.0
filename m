Return-Path: <SRS0=SWCy=JM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CC04C433ED
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Apr 2021 23:17:15 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5E4460FD7
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Apr 2021 23:17:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5E4460FD7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:MIME-Version:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:References:In-Reply-To:Message-Id:Date:Subject:Cc:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dzSjNEC7fHsE4D/jI5bVGNCsGdI0/1XnlndBb3rYhAM=; b=myNJeuuOiA8GiB5EaNjWU+MJTT
	vA6DWgAFvr8UNdGZaZp8e7AwSASCwqel09eNZaBstHXuwyr10q09jZ+8EzZfkiBBRfpxomZcE7Mso
	1MBNhpXsZ5ylEsNstwDh7sZEHaLPD53/nrQku2ckPCTZvHNDyL/5GxLTV9d0aQ6X5Eijg+z6Xm8je
	bJoALDbDKGs5HlVi070aIOkNXPtUPc6zYFq4LX+OI5Co/nvz1uQXldsmJiT9R1jClRvdzk7ao0Tn8
	rN5IcAKdFTUO5lJQvAL+bOXUfpPCRIxkBlB+GfQ1UsVKuf3+gqyoX98oDZapUtKXa0dwzTASJjJN6
	nwoO2Xbg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lXBEE-0002uM-6k; Thu, 15 Apr 2021 23:16:54 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lXBD3-0002h1-91
 for linux-nvme@desiato.infradead.org; Thu, 15 Apr 2021 23:15:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=tXpmcKx37TXtPWLF87d7oCaiXGljnrfqUN5eg+/JOIA=; b=SyP/Ng5Axmu2ZClWb0Z+YK3BZo
 MougJFc+zPibv2MpwQk8gGfS0a5KwzLhrmOs4ru1RXQMfEO3zDTD3dUA3w+yPod3JvjQCdpYjPDDU
 SnsOQ9F6ukML0aesTGdPOy4O9yaNT75f2j7yOAILq67Vpxo6WwZcdhHGXAEfVIyOlU0kzFLxqbcth
 bJO1Ew0Wm5GUvRqq1cOtYo9Aoe+bJsRsfqV5ER++HeMQ+x6SNwv6nor9X1FXTAROcPDHgSvTk5TUa
 bWdVOq8rUSqE/gP3rIX2gIyue50uX6pj9O6lf7Idv+naykZEc+EmT0eug6n9s9cWYG96Mf4JigW/w
 fHDHbLXw==;
Received: from mail-qk1-x731.google.com ([2607:f8b0:4864:20::731])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lXBD0-008xvo-JR
 for linux-nvme@lists.infradead.org; Thu, 15 Apr 2021 23:15:40 +0000
Received: by mail-qk1-x731.google.com with SMTP id e13so17252582qkl.6
 for <linux-nvme@lists.infradead.org>; Thu, 15 Apr 2021 16:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=tXpmcKx37TXtPWLF87d7oCaiXGljnrfqUN5eg+/JOIA=;
 b=du7nDOkKBU45OSJuZi0/c4J9eUQmeDwz8iIjf0M5r0A03peaU6Y5xb4KOkPKxz/6pN
 tDQr9bh66gzs8Lm3LQ0KWArAQXx9VLijApcIzaeZfYD71dghhhld+gOwdVL5+/iF3P9P
 Qm/Nr2GIw+/5AIGV5ZQWjtqVXd+8ofsI+NUA6/Vbi+sV0Tt8pb/iGlkZlbSmMEdye7UX
 CEXmg5sYwLsPyUxjqruA3p+dLUpMCL0vBHbRv8bvkm2cT3hC+4rLZnApMfxNxLToYBIP
 7KIHMfuHyjFM4Ymh5gRPpp+U3hRG8r5h3y4R1BOscoGBYMQhIAg7wFYsalaRo9wc3+DJ
 I1Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=tXpmcKx37TXtPWLF87d7oCaiXGljnrfqUN5eg+/JOIA=;
 b=KRQ9HYoYT7Ae3/Uv+VSfoRWFhZWY6IZ/eRJQPU3NYR+RDmNnrP/cKevYyC9nXIATsB
 uQtpXestMQd8wSq8aTwLrYEQOmRcb4OsuexrnystSlZzTldV8PRNtYjH12l+dKD41yCP
 clVjeOeEPzyG2sMVKBLB7WAsdTMpNhFyCx4ePJ0sOCAcoCse1KeB0chGkv0SHK+2l9PB
 me8ymkeXToc8bpb7bI+IEKWiq8FPnAZlIkUYHpK9sxMChFcv33p8DoCEZsEbny357RZA
 mIK27JXOD8Qz3Io3roKrW0Qlx90vzMHNcDa956+S8d5huvwdVOhHJbqopzvN2aBUf6Av
 bZYQ==
X-Gm-Message-State: AOAM532R6ohpYtW/FonXFzzHU5GozyB60TBmox54xWG+34JsZnvpWXv5
 7TtBkVtcHJwZkW3/GWPs607OO3NWmPQOLQ==
X-Google-Smtp-Source: ABdhPJzn2XMQrRfE5zOzauzWEZPLKDOf+rpDSwz3uLvZB7jaGyI4cR/XVZfVp/8Ed7whNRoHvV84hA==
X-Received: by 2002:a05:620a:214f:: with SMTP id
 m15mr5709548qkm.419.1618528537471; 
 Thu, 15 Apr 2021 16:15:37 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net.
 [68.160.176.52])
 by smtp.gmail.com with ESMTPSA id b26sm2741102qtr.28.2021.04.15.16.15.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Apr 2021 16:15:36 -0700 (PDT)
From: Mike Snitzer <snitzer@redhat.com>
To: Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>
Cc: dm-devel@redhat.com, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
Subject: [PATCH v2 4/4] nvme: decouple basic ANA log page re-read support from
 native multipathing
Date: Thu, 15 Apr 2021 19:15:30 -0400
Message-Id: <20210415231530.95464-5-snitzer@redhat.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20210415231530.95464-1-snitzer@redhat.com>
References: <20210415231530.95464-1-snitzer@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210415_161538_661989_84CE22F0 
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
index 10375197dd53..1c6dc3a6c24d 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -352,6 +352,8 @@ static void nvme_failup_req(struct request *req)
 {
 	blk_status_t status = nvme_error_status(nvme_req(req)->status);
 
+	nvme_update_ana(req);
+
 	if (WARN_ON_ONCE(!blk_path_error(status))) {
 		pr_debug("Request meant for failover but blk_status_t (errno=%d) was not retryable.\n",
 			 blk_status_to_errno(status));
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
