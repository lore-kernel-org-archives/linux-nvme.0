Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5769C4345F
	for <linux-nvme@archiver.kernel.org>; Sun,  5 May 2024 10:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=X7twm5mr4WHe3cshlHyndeqLsYlRbyl96q9//wbd7lw=; b=Oa6X5xNd9P+m6CQC7DTRY0qF/L
	6fLyYIr3QzSjsaMnfVo2uaWQ7LvulAiJWZRf6TEqsOrAoXwnzaT6ivu8QwR1Itx3C2GUpPuUC1D3H
	55TY7YMspf+bPb+bjVVDkZmgwbt6Zukg7f8dOBLDZN0v/og5DlZPtEUBMbajDvnsVN0+m8KMBSbFW
	AbjK7qCGEK5KZjsUCyyOmngS3+n43hjUxRllTw3l4HwPMCcONQNvUsDhVgmgc75BC8vr+lSN5PyAU
	BgPESn3dAGi+NbZOcpOUkWGZkbbDKwKXxg2Ar7SwLOSpSxkk+7PX4bV1qGLtZs+Iix0cc5yBhbwSl
	EkCjq9pQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s3ZHj-000000045e1-3kP9;
	Sun, 05 May 2024 10:39:59 +0000
Received: from mail-wm1-f44.google.com ([209.85.128.44])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s3ZHd-000000045cZ-0E1z
	for linux-nvme@lists.infradead.org;
	Sun, 05 May 2024 10:39:54 +0000
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-41c26dcc3ecso1472855e9.2
        for <linux-nvme@lists.infradead.org>; Sun, 05 May 2024 03:39:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714905587; x=1715510387;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X7twm5mr4WHe3cshlHyndeqLsYlRbyl96q9//wbd7lw=;
        b=pqH3dCYVu9Jh4mlnfX7Ja5ci0xu5JQe2/OpUAeBu+wSHjksGhvyXjNTmZDKMPFGXkL
         tub9KVRnSocq5k+KmgwmU2M4H9fxsRo+nw9n3hQh9QiFFJBl1woqnkFX8y8zG6Sgscb6
         YME0FnC/8ozs8HlyM8zBJoBuWI7DsDPfY06vW/hmsdIB9SobrwjqDS6QmxWGaMA1QoH1
         5mSkw/r6/fc/TzoHFJU2OvSsWvDw74vwxGsY8KVR1f9hWHWBsKqHii+gsAvyftYdHBTN
         4jwVmaIDovg4ojo7UFohCVco/f75jEgKkZ9t5xg/DQRZOwFvhR0Xpsfn2kPyau7qrBKh
         yAKg==
X-Gm-Message-State: AOJu0Yx8WjiWOUg4Qfb3ewlagiHZhwDYFsCX7rc3FBfdq5QGE+UNKSlp
	efvYgn6UNfUy77H8DtsNLAfACVPeAd2qmlRzdoMXKUVSDgFAeGWngxYLcQ==
X-Google-Smtp-Source: AGHT+IHuX/NP3SfjyMFiSh32QYg0q799qLTcAWjLiovfZyxlkmHNFkhB5pdrAhTsEQPxMXlbKP/M/A==
X-Received: by 2002:a05:6000:a83:b0:34d:756d:e43f with SMTP id dh3-20020a0560000a8300b0034d756de43fmr5256956wrb.7.1714905586648;
        Sun, 05 May 2024 03:39:46 -0700 (PDT)
Received: from vastdata-ubuntu2.vastdata.com (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id cx14-20020a056000092e00b0034a2d0b9a4fsm8055461wrb.17.2024.05.05.03.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 May 2024 03:39:46 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: [PATCH] nvmet-rdma: Avoid o(n^2) loop in delete_ctrl
Date: Sun,  5 May 2024 13:39:44 +0300
Message-Id: <20240505103944.52275-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240505_033953_122036_C574CEB6 
X-CRM114-Status: GOOD (  12.04  )
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

From: Sagi Grimberg <sagi.grimberg@vastdata.com>

When deleting a nvmet-rdma ctrl, we essentially loop over all
queues that belong to the controller and schedule a removal of
each. Instead of restarting the loop every time a queue is found,
do a simple safe list traversal.

This addresses an unneeded time spent scheduling queue removal in
cases there a lot of queues.

Signed-off-by: Sagi Grimberg <sagi.grimberg@vastdata.com>
---
 drivers/nvme/target/rdma.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 5b8c63e74639..26db04360e8c 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -1814,18 +1814,14 @@ static int nvmet_rdma_cm_handler(struct rdma_cm_id *cm_id,
 
 static void nvmet_rdma_delete_ctrl(struct nvmet_ctrl *ctrl)
 {
-	struct nvmet_rdma_queue *queue;
+	struct nvmet_rdma_queue *queue, *tmp;
 
-restart:
 	mutex_lock(&nvmet_rdma_queue_mutex);
-	list_for_each_entry(queue, &nvmet_rdma_queue_list, queue_list) {
-		if (queue->nvme_sq.ctrl == ctrl) {
-			list_del_init(&queue->queue_list);
-			mutex_unlock(&nvmet_rdma_queue_mutex);
-
-			__nvmet_rdma_queue_disconnect(queue);
-			goto restart;
-		}
+	list_for_each_entry_safe(queue, tmp, &nvmet_rdma_queue_list, queue_list) {
+		if (queue->nvme_sq.ctrl != ctrl)
+			continue;
+		list_del_init(&queue->queue_list);
+		__nvmet_rdma_queue_disconnect(queue);
 	}
 	mutex_unlock(&nvmet_rdma_queue_mutex);
 }
-- 
2.40.1


