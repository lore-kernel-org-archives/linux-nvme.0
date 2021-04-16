Return-Path: <SRS0=jca5=JN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68FD7C433ED
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Apr 2021 23:54:19 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D753761166
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Apr 2021 23:54:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D753761166
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:MIME-Version:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:References:In-Reply-To:Message-Id:Date:Subject:Cc:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6GzZhAcCn+hCDCFNB15XqXxgl8h2kaaFokf0NLWzMxs=; b=MQKUPgtkj/9+jEC55unoNcnL0B
	NXSiL4xD510Yie14s9jYUe94RBnIgBlDOv4BGt/DMSB3HP7XP3mn8HN5FWJyjYWWGmuzru94L0fe3
	Cvnj5CoyStaak6lHW+E3v1PAfiZAWJC3G0dtSjhz4/ruex4/jHX6dRNzzo6cdzpkrDrMuD3XcBmAY
	FzRQ6ucZkF6bAKh3YJ93f+9Z4TpnCOcwSq8Gm4s7qklF8kDCUJmpAFCITCMgcjSAYnGRUhCJPhctI
	uz9TfxTCuRgZzFl4BzqBbFC4o9L6SdXXHuGjvEgJLWFX2q6mFyUvh1qfOmlJ/oCtfcQQNgFHjuSED
	tbXeo87g==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lXYHl-003m6p-0W; Fri, 16 Apr 2021 23:54:05 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lXYHL-003m4F-Kt
 for linux-nvme@desiato.infradead.org; Fri, 16 Apr 2021 23:53:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=6W4dFuQZFZDxrcjNEtMiTx3DGVpbYyuLvbl05NbuH68=; b=E5gZDIoqZWwgw1QfghlOTI2n9i
 T2qoq+NFuuuximTxJWmgzsaOEC79LygQi/uVymGb9QeEjvAtLeo6IH4ou23aGFIuPHWdMz+Ld23aD
 /gJqNRLlbcBDqHbwbZfyQqtu4kGt91C11Cg40m2O9IP1YjCwQVhk82/UJqLlSxg5T7xqar5165d7w
 DB+FA1ooVCkXHr6juYWxc1s6rYyDPfR2Boj9f33kyE7e8CqQCmzTuQA08GqbrVvjtRudfeIBtVOIc
 sRtXcYPKKzjIvsGbHCKdjONO9LA1uBcLfiYlEZprgwvK3/4vVtfDSgoOxRICl7F5vqVU2+UO9jBna
 J0AnaDpw==;
Received: from mail-qv1-xf33.google.com ([2607:f8b0:4864:20::f33])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lXYHH-009n0w-Sv
 for linux-nvme@lists.infradead.org; Fri, 16 Apr 2021 23:53:38 +0000
Received: by mail-qv1-xf33.google.com with SMTP id gv2so5000990qvb.8
 for <linux-nvme@lists.infradead.org>; Fri, 16 Apr 2021 16:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=6W4dFuQZFZDxrcjNEtMiTx3DGVpbYyuLvbl05NbuH68=;
 b=iCDnN0TcD52pcBDWvZyNoGF+BkPDWGIe5uDS4cKKGP9YY2a4hlr0Z4q4Y3d75SNPvL
 ubKGKLnjxaJ2YsNM+A9O0JzXzsvM7k85bTCUQwKPPc/HeTPbd9b9tSizDy81e/yvakuy
 3lh2DUBiUsLxj6yn5qDz95ZMXw/WpAECviYxGuCdxgN8la/cJHygPOaYvYn0A+vbL0KT
 iktznhNE3ErCMkc5uxGwSbVThavjgQ1gGIPSPycjmgkSQYTt/rkzL49pIeMQqPiFfPGy
 NDSKmSC+SqwQhFE03WCCHB8LC1mz+nlZvidwljqPMMa5kUcJwRarhH/ifunqIPRiBv6K
 gTsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=6W4dFuQZFZDxrcjNEtMiTx3DGVpbYyuLvbl05NbuH68=;
 b=ZhtvO0zTZUEgB4SPsrIhhdPS5w14018UW5Kej+a+ZSKoVy4wOEKfuU5lLPUG6ZhL77
 aCKQT3sI9VwdMnMvjIoCIpY5bkuBRY6oP6X7L2VHiqjmqorYhhWXB0eP7vKqL1PssS/a
 qL5holNaBbJbv+6FcS7+V4yHrCxlLSJzlhq8G0S+Z3YFK8G9BzUcdwmoFiooFCF0Kkg1
 gj0SQBjzGv3/pXuN5for4aA3LcPG+65ohsrFxjjH1YISG6ci/LbYiEgpFLSzSRUv8Qur
 Mj3230NSeSjsMUl0JNKRQEMgUGv2DU9WGZs5d3YBAoZVFuMP7UBCiDJxgnIALaR84DuS
 ZXhQ==
X-Gm-Message-State: AOAM531J4COjpUkUjEk7SOjcSIHirl/MmHluwSOchGPq5itMUEfJsLb0
 fXQitcpzm8Z7TEbRCbMyvhE=
X-Google-Smtp-Source: ABdhPJwh6XHQ4W/sFJBzn//P5eE+pQK3iiAapSkSAHYWj127GoJpxUHJsFoe6ImvSyp0IpaHo7CJxA==
X-Received: by 2002:a0c:b38b:: with SMTP id t11mr11025259qve.25.1618617214793; 
 Fri, 16 Apr 2021 16:53:34 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net.
 [68.160.176.52])
 by smtp.gmail.com with ESMTPSA id l199sm768557qke.118.2021.04.16.16.53.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Apr 2021 16:53:34 -0700 (PDT)
From: Mike Snitzer <snitzer@redhat.com>
To: Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>
Cc: dm-devel@redhat.com, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
Subject: [PATCH v4 3/3] nvme: decouple basic ANA log page re-read support from
 native multipathing
Date: Fri, 16 Apr 2021 19:53:29 -0400
Message-Id: <20210416235329.49234-4-snitzer@redhat.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20210416235329.49234-1-snitzer@redhat.com>
References: <20210416235329.49234-1-snitzer@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210416_165335_953711_F349F9A6 
X-CRM114-Status: GOOD (  18.70  )
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
index a12b10a1383c..83ca96292157 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -340,6 +340,8 @@ static inline void nvme_end_req(struct request *req)
 
 static inline void nvme_failup_req(struct request *req)
 {
+	nvme_update_ana(req);
+
 	nvme_req(req)->status = NVME_SC_HOST_PATH_ERROR;
 	nvme_end_req(req);
 }
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
