Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17BCBC001DE
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Jul 2023 13:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LC2swPqwzH8BSws38RvnTDd+dfBcN6Jd4BJtLXb5akw=; b=J9xQWGI8TOKMMbEHhSneJYjnJa
	y/JocUnrY/MjuvNLaCs0sOjdmqo5JPSMNHALjrR9SoV7fbbX8V6xb6fN1odjhkgAMaQnOYjC/epe8
	EU7waEiBgH0IjhFi10r8BoL3TAONa18mNau3OjxTsw0zmK/T9Pz1UFwqwGyyLeZrq2XAeylvyXhC9
	XiC/qs2XC/x92VfCj+z8ow954bXibXhHzy2P3VKEOqB1kFyKiCC6FDFaH5AgsUkea/f3km85OX5OR
	eI08kburQ5ezz3DeOFwa5lnv68Yea6QrGcBIH0kcuJwsuJOlHstioRKFnH5Y6tc+aj16K3yMT9XHr
	vq+6wLkQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qOeU5-00AWbp-1B;
	Wed, 26 Jul 2023 13:23:21 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qOeU1-00AWZZ-2Q
	for linux-nvme@lists.infradead.org;
	Wed, 26 Jul 2023 13:23:19 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out1.suse.de (Postfix) with ESMTP id CD8E921D5E;
	Wed, 26 Jul 2023 13:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1690377794; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LC2swPqwzH8BSws38RvnTDd+dfBcN6Jd4BJtLXb5akw=;
	b=eZB5beYDiO75bgNN7ok4UC4YdZYKmNCNsY1cam95x6YK9DIAVOLv1q4+SSOnTj9P9/RU36
	ruEhkdoVETdJPF7x96AR4VlWajA0dVIKPGj8rqLSOnP4xyKdTenGGc/9fmcFGAgePFHDEf
	+uHeB2HdqktCxlBcszLN80uv78g7Ats=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1690377794;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LC2swPqwzH8BSws38RvnTDd+dfBcN6Jd4BJtLXb5akw=;
	b=DgFf+a6wseBNFpPiqkXDPX2Ei5L+C9dTYe0Q8UiKnq9riK9TzD0PXHOrWSViUxW+Fme2TG
	2dN4azL53+EYmqBg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id AD7342C143;
	Wed, 26 Jul 2023 13:23:14 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id 9FB0351CA308; Wed, 26 Jul 2023 15:23:14 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	Ewan Milne <emilne@redhat.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Randy Jennings <randyj@purestorage.com>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 2/2] nvme-multipath: add 'latency' iopolicy
Date: Wed, 26 Jul 2023 15:23:05 +0200
Message-Id: <20230726132305.33739-3-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230726132305.33739-1-hare@suse.de>
References: <20230726132305.33739-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230726_062317_957166_3C43EBCC 
X-CRM114-Status: GOOD (  15.51  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Add an I/O policy for selecting paths based upon the least latency.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/core.c      |  1 +
 drivers/nvme/host/multipath.c | 19 +++++++++++++++++--
 drivers/nvme/host/nvme.h      |  5 +++++
 3 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index b52e9c9bffd6..bd506284af1f 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -397,6 +397,7 @@ void nvme_complete_rq(struct request *req)
 
 	trace_nvme_complete_rq(req);
 	nvme_cleanup_cmd(req);
+	nvme_mpath_complete_request(req);
 
 	/*
 	 * Completions of long-running commands should not be able to
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 7813608038bc..8052ba8085f0 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -18,6 +18,7 @@ static const char *nvme_iopolicy_names[] = {
 	[NVME_IOPOLICY_NUMA]	= "numa",
 	[NVME_IOPOLICY_RR]	= "round-robin",
 	[NVME_IOPOLICY_BW]	= "bandwidth",
+	[NVME_IOPOLICY_LAT]	= "latency",
 	[NVME_IOPOLICY_EWMA]	= "ewma",
 };
 
@@ -33,6 +34,8 @@ static int nvme_set_iopolicy(const char *val, const struct kernel_param *kp)
 		iopolicy = NVME_IOPOLICY_RR;
 	else if (!strncmp(val, "bandwidth", 9))
 		iopolicy = NVME_IOPOLICY_BW;
+	else if (!strncmp(val, "latency", 7))
+		iopolicy = NVME_IOPOLICY_LAT;
 	else if (!strncmp(val, "ewma", 4))
 		iopolicy = NVME_IOPOLICY_EWMA;
 	else
@@ -49,7 +52,7 @@ static int nvme_get_iopolicy(char *buf, const struct kernel_param *kp)
 module_param_call(iopolicy, nvme_set_iopolicy, nvme_get_iopolicy,
 	&iopolicy, 0644);
 MODULE_PARM_DESC(iopolicy,
-	"Default multipath I/O policy; 'numa' (default), 'round-robin', 'bandwidth', or 'ewma'");
+	"Default multipath I/O policy; 'numa' (default), 'round-robin', 'bandwidth', 'latency', or 'ewma'");
 
 void nvme_mpath_default_iopolicy(struct nvme_subsystem *subsys)
 {
@@ -153,6 +156,17 @@ void nvme_mpath_end_request(struct request *rq)
 			 nvme_req(rq)->start_time);
 }
 
+void nvme_mpath_complete_request(struct request *req)
+{
+	struct nvme_ns *ns = req->q->queuedata;
+
+	if (iopolicy == NVME_IOPOLICY_LAT) {
+		u64 lat = ktime_get_ns() - req->start_time_ns;
+
+		ns->path_weight += lat >> 10;
+	}
+}
+
 void nvme_kick_requeue_lists(struct nvme_ctrl *ctrl)
 {
 	struct nvme_ns *ns;
@@ -267,7 +281,8 @@ static struct nvme_ns *__nvme_find_path(struct nvme_ns_head *head, int node)
 
 		if (iopolicy == NVME_IOPOLICY_NUMA)
 			distance = node_distance(node, ns->ctrl->numa_node);
-		else if (iopolicy == NVME_IOPOLICY_BW)
+		else if (iopolicy == NVME_IOPOLICY_LAT ||
+			 iopolicy == NVME_IOPOLICY_BW)
 			distance = ns->path_weight;
 		else if (iopolicy == NVME_IOPOLICY_EWMA)
 			distance = nvme_path_ewma(ns);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 4eabb6ee563a..d9e9c1b5236a 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -391,6 +391,7 @@ enum nvme_iopolicy {
 	NVME_IOPOLICY_NUMA,
 	NVME_IOPOLICY_RR,
 	NVME_IOPOLICY_BW,
+	NVME_IOPOLICY_LAT,
 	NVME_IOPOLICY_EWMA,
 };
 
@@ -904,6 +905,7 @@ void nvme_mpath_clear_ctrl_paths(struct nvme_ctrl *ctrl);
 void nvme_mpath_shutdown_disk(struct nvme_ns_head *head);
 void nvme_mpath_start_request(struct request *rq);
 void nvme_mpath_end_request(struct request *rq);
+void nvme_mpath_complete_request(struct request *rq);
 
 static inline void nvme_trace_bio_complete(struct request *req)
 {
@@ -995,6 +997,9 @@ static inline void nvme_mpath_start_request(struct request *rq)
 static inline void nvme_mpath_end_request(struct request *rq)
 {
 }
+static inline void nvme_mpath_complete_request(struct request *rq)
+{
+}
 #endif /* CONFIG_NVME_MULTIPATH */
 
 int nvme_revalidate_zones(struct nvme_ns *ns);
-- 
2.35.3


