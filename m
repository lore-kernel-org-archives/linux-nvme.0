Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F15EC5DF97
	for <linux-nvme@archiver.kernel.org>; Sun, 23 Aug 2026 08:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Content-Type:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZJDl1OiKAx2kedGagwPQfYPmUTAD/gB7XcGxpsr4evU=; b=PvhyU07Bx8nvJRv+/djQ9OueX8
	O4HUldKCDJDR6wusLENJsROMlyB1YgrZef3CEDFJIYWWYWwfNw+pfv3FyXj98wKKDAUD3HCFwKo2e
	kM7TAVoaBLFfGaSkq2CbLdDIuweUYJKqzFGr1Vwn/aLXJvA77HNF35OX6ZRcPwYyKwnxUyPny8EFO
	s/ZDs4aW4joUnas8zM42jhwt4XFbUletFAsZJe+IfDGkhfedQ8Pe32JEWORWN0yfmEzc2XgwG1lJx
	2OHe8GyZl44Xu5Y68+KPYs5i9RDoGi90/W2le2YuCSHaE+YnteVoNeqEPJ7KD/gYdgItTTbxBPUBU
	ZKA4iTXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wy3tC-0000000FBVW-1fUQ;
	Sun, 23 Aug 2026 08:49:14 +0000
Received: from mail-ed1-f52.google.com ([209.85.208.52])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wy3t9-0000000FBTo-2p0R
	for linux-nvme@lists.infradead.org;
	Sun, 23 Aug 2026 08:49:12 +0000
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-69fc9f25118so2663324a12.2
        for <linux-nvme@lists.infradead.org>; Sun, 23 Aug 2026 01:49:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787474950; x=1788079750;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZJDl1OiKAx2kedGagwPQfYPmUTAD/gB7XcGxpsr4evU=;
        b=jmrWgIlIR8lhkBW4tbgqNejQUcSvvgAWaB1tCy813yV+rZswPFrQ1CNqGPAiV17Ent
         d9Mro3YIzQz+EIjyRqUxbEuq73ik1x32IkA1oQjB/yYO2dCTd2AMGMnBKjFSG+2OvuC7
         JFvszev3cIZyDKYYf13y3UPyiSNcjmnSxE4gBrT+JsvHpK8QdSjSMygjQ1feYKAlN8eM
         B22ZBOBu3mjHqohDDLV1s4mzCxy5SRmcghgKeSewImC42Gx9o6nl8EVEnDN1mBNpZ28Q
         bqdUeP6aVRL8hWTv8F3h8HG+XYfmvOI7FDa+QdYh+h6Mh20pRTCZ9cNkNimimg3h0mmj
         9ZOQ==
X-Gm-Message-State: AFuF++m+468d0xhcG1Df1JFnOFURDNlJ4blj6hE3bdGxeChzmgzzzdYP
	KQ6qZ4yQciNuWUUVdsd+BrktjAKdbqShDfMt0siYmEnLA92gQ0EhSQsGtjnOMw==
X-Gm-Gg: AR+sD11fl0l3SZEKeMh81giYp3Afxy28grHqTprzPw9gVrW9K8wk/ELK4Cu2TlZ5r57
	rwvaLobIRDPq3PLP9MQM6gmo5asMrQLf903WfSIBEKNuswhCUJn6fghD7VCeze+sofJ3DbH1rLc
	tFw9M0ehKkcgEXpJSUn3HqMwJNJv2uul4U3kovW7v5o463V6y8aWO9yxOiW8zzi0bLErpufco0W
	M35oBoh87owv8EBg9ULPafHgrjdlagUwJcbnfWE/P53vZfESSPB9h/04xTnu9/aBEswfF36ndOk
	U4SWJANVIb+gCUxq1vy6VMNwEf309CU7stKJ28UG40wGUlDdn/+Xapiz4A1vnpzTZJevQc80yzB
	sMsu3iPjYVBn0PmV6sIOAXoq3tldekKdjon7hGHJanrPfRMe/fzjb68X8/A3/2ithk0z6jrN1Sk
	UKCudXyvBLtXjPepH2kv8c550Bv21eVgVxNE4CyIiuzF3FjZf7Rd6QDlnrgL/LZqLb8PsE+h8Fh
	G7AsGNG6JXlKb7GcRRhUdrh7IAQDqbLNhMiaDLr7qMTv4p/Ciw=
X-Received: by 2002:a05:6402:52d6:b0:6a1:29ca:681e with SMTP id 4fb4d7f45d1cf-6a42f131cdbmr20032716a12.7.1787474949643;
        Sun, 23 Aug 2026 01:49:09 -0700 (PDT)
Received: from vastdata-ubuntu2.vastdata.com (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a59e00129fsm2566761a12.1.2026.08.23.01.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 01:49:08 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: Daniel Wagner <dwagner@suse.de>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 2/6] nvme: add nvme_crd_msecs helper
Date: Sun, 23 Aug 2026 11:48:58 +0300
Message-ID: <20260823084903.193188-3-sagi@grimberg.me>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260823084903.193188-1-sagi@grimberg.me>
References: <20260823084903.193188-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260823_014911_736029_08910D7C 
X-CRM114-Status: GOOD (  12.09  )
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
Reply-To: sagi@grimberg.me
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hide the details of extracting the crd value. We'll need it from other
call-sites.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/core.c |  8 +-------
 drivers/nvme/host/nvme.h | 10 ++++++++++
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 453c1f0b2dd0..a49a86f96dd6 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -321,15 +321,9 @@ static blk_status_t nvme_error_status(u16 status)
 
 static void nvme_retry_req(struct request *req)
 {
-	unsigned long delay = 0;
-	u16 crd;
+	unsigned long delay = nvme_crd_msecs(nvme_req(req));
 	struct nvme_ns *ns = req->q->queuedata;
 
-	/* The mask and shift result must be <= 3 */
-	crd = (nvme_req(req)->status & NVME_STATUS_CRD) >> 11;
-	if (crd)
-		delay = nvme_req(req)->ctrl->crdt[crd - 1] * 100;
-
 	nvme_req(req)->retries++;
 	if (ns)
 		atomic_long_inc(&ns->retries);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 824651cc898d..6d8f6c541a61 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -921,6 +921,16 @@ static inline enum req_op nvme_req_op(struct nvme_command *cmd)
 	return nvme_is_write(cmd) ? REQ_OP_DRV_OUT : REQ_OP_DRV_IN;
 }
 
+static inline unsigned long nvme_crd_msecs(struct nvme_request *req)
+{
+	/* The mask and shift result must be <= 3 */
+	u16 crd = (req->status & NVME_STATUS_CRD) >> 11;
+
+	if (!crd)
+		return 0;
+	return req->ctrl->crdt[crd - 1] * 100;
+}
+
 #define NVME_QID_ANY -1
 void nvme_init_request(struct request *req, struct nvme_command *cmd);
 void nvme_cleanup_cmd(struct request *req);
-- 
2.43.0


