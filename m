Return-Path: <SRS0=dfbP=KU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2369C2B9F8
	for <linux-nvme@archiver.kernel.org>; Tue, 25 May 2021 16:14:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A05596140F
	for <linux-nvme@archiver.kernel.org>; Tue, 25 May 2021 16:14:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A05596140F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=amy1v+wB75UTMaQttZonrSSvYSe7JDE1EQ58o+D/Tro=; b=dDugHKFIEEHUT/
	tc5FvfeIuhzLE/RnC2qdN6z9YOHHLABkyEZ9+xVQKSDLZABiwSkNHOJ9mhPjLo1b+kNyS+PBf+5qU
	V56llBbaWzj9bBvbLS0NlJI/Z9vk6hUJ1ybY3Q7/W8fDmgnFeYYJJymd3W3qDTjwTmZrqutjSbwyP
	aP8OETkngU3stueKTP4+pi/dWdAHc1DexhcQOzDx7fzBU4s9bSoOLy02yx47vY3NXVdGARDoUJ+X3
	7B1WXx0jOMX5OY50HU4Jw0fmEiiwxVaEFq7TwsDrK9LZMIp+nNRks2VOBHxGtdd3KshbCATC8CFfU
	xmtgSeLb9EEnnDsAZ5Fg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1llZhT-006K3M-1m; Tue, 25 May 2021 16:14:35 +0000
Received: from mail-pj1-f47.google.com ([209.85.216.47])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1llZIt-0068su-0M
 for linux-nvme@lists.infradead.org; Tue, 25 May 2021 15:49:12 +0000
Received: by mail-pj1-f47.google.com with SMTP id
 j6-20020a17090adc86b02900cbfe6f2c96so13419411pjv.1
 for <linux-nvme@lists.infradead.org>; Tue, 25 May 2021 08:49:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=niLw+Wm4vEmMgHldUHv30vs/vub21hjzBiXivPZabso=;
 b=pRSzmo//fLHEvjCQEV5+d7kkIzbEw8eoZ2ziZ/FECIdcgJMNd9j0FQXBheh/EHmcAx
 2OS3GiOEgFAECsoxPEJ1IfklMiwPtzjE2dmvj3N03625JrSmWXp/dmMbzD/GzBjSSx2U
 TwCFxOVyyG41Kef8JlyvIfcCIgp2p2QqtOCzi3xKmiTV7vK5Dp2LxvoxKSl2w1PS5BC7
 LvmhqGOgYLpAwJ5YX4GMNy03t0ieiue7WZI/Y87QWZKa1bkTzRYOC53lbEhVTLT+zlm6
 OX2iDQfs/bTbHMykk6FznzhtCc5r3+xebTPErKWcCnEHLwZ23A6dOrZWeLhnUYpHyWbt
 Q1VQ==
X-Gm-Message-State: AOAM5334bfkqA0TtIW5Jv1drLOymG5GEIIxlHSeNQlEDl3AKRTrsib6K
 suNGU1eXjIn/o6GyKaSmJSAzIpRmLA4=
X-Google-Smtp-Source: ABdhPJwsI//zKtfG2FxhCWz6ttw/gcJDzItdJjw86tAmxAhZQex3Aod5joBxgFVKF2s/9TH5AZaIpg==
X-Received: by 2002:a17:90a:94ca:: with SMTP id
 j10mr5281731pjw.59.1621957748464; 
 Tue, 25 May 2021 08:49:08 -0700 (PDT)
Received: from sagi-Latitude-7490.hsd1.ca.comcast.net
 ([2601:647:4802:9070:4f6:7b8c:d4a2:7714])
 by smtp.gmail.com with ESMTPSA id h76sm14968679pfe.161.2021.05.25.08.49.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 May 2021 08:49:07 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>
Subject: [PATCH] nvmet: fix false keep-alive timeout when a controller is torn
 down
Date: Tue, 25 May 2021 08:49:05 -0700
Message-Id: <20210525154905.2245888-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210525_084911_089323_0D94DBFE 
X-CRM114-Status: GOOD (  15.42  )
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

Controller teardown flow may take some time in case it has many I/O
queues, and the host may not send us keep-alive during this period.
Hence reset the traffic based keep-alive timer so we don't trigger
a controller teardown as a result of a keep-alive expiration.

Reported-by: Yi Zhang <yi.zhang@redhat.com>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/target/core.c  | 16 ++++++++++++----
 drivers/nvme/target/nvmet.h |  2 +-
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 1853db38b682..e991b4671aeb 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -388,10 +388,10 @@ static void nvmet_keep_alive_timer(struct work_struct *work)
 {
 	struct nvmet_ctrl *ctrl = container_of(to_delayed_work(work),
 			struct nvmet_ctrl, ka_work);
-	bool cmd_seen = ctrl->cmd_seen;
+	bool reset_tbkas = ctrl->reset_tbkas;
 
-	ctrl->cmd_seen = false;
-	if (cmd_seen) {
+	ctrl->reset_tbkas = false;
+	if (reset_tbkas) {
 		pr_debug("ctrl %d reschedule traffic based keep-alive timer\n",
 			ctrl->cntlid);
 		schedule_delayed_work(&ctrl->ka_work, ctrl->kato * HZ);
@@ -804,6 +804,14 @@ void nvmet_sq_destroy(struct nvmet_sq *sq)
 	percpu_ref_exit(&sq->ref);
 
 	if (ctrl) {
+		/*
+		 * teardown flow may take some time, and the host
+		 * may not send us keep-alive during this period,
+		 * hence reset the traffic based keep-alive timer
+		 * so we don't trigger a controller teardown as
+		 * a result of a keep-alive expiration.
+		 */
+		ctrl->reset_tbkas = true;
 		nvmet_ctrl_put(ctrl);
 		sq->ctrl = NULL; /* allows reusing the queue later */
 	}
@@ -952,7 +960,7 @@ bool nvmet_req_init(struct nvmet_req *req, struct nvmet_cq *cq,
 	}
 
 	if (sq->ctrl)
-		sq->ctrl->cmd_seen = true;
+		sq->ctrl->reset_tbkas = true;
 
 	return true;
 
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index d69a409515d6..53aea9a8056e 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -167,7 +167,7 @@ struct nvmet_ctrl {
 	struct nvmet_subsys	*subsys;
 	struct nvmet_sq		**sqs;
 
-	bool			cmd_seen;
+	bool			reset_tbkas;
 
 	struct mutex		lock;
 	u64			cap;
-- 
2.27.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
