Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 960F1C10F1A
	for <linux-nvme@archiver.kernel.org>; Tue,  7 May 2024 06:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=GbXroQ9nJNbCFdI6AvHycDcnwfIWgN2jHSxCuBfyUx0=; b=41s27h92DEAtPLJuQ0XkkD24P8
	IJaaXIjUxshlrqm47qh6xzIuGmObfuVMds59BeWwAwkAfzhYs1hL3/qeumj92TW/r6anH9YY2BNn1
	x/NntKMdd9P6ou/e+M6EK2lgtP7RVLbk4bFyAYj92GZlsEomJgr5hY56HWEfVzQWMMCq2q9eJcsjS
	swcHnDBHRQ5sZFdplPaEkOpZbs+l/Ho3wbVVpNmLxJB84AiISqV5+jEloEmBIjd2dTjC/FSyhMU94
	1YjGahOCUeSVJk368csiukAF3CO1sICF1fh7HnwqMGzSFH/GkphV/adPvCPO3GGJw1PFODMnO+RKP
	XGi2ygpg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4Eiy-00000009tsO-14WV;
	Tue, 07 May 2024 06:54:52 +0000
Received: from mail-lf1-f46.google.com ([209.85.167.46])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4Eiv-00000009trI-31ei
	for linux-nvme@lists.infradead.org;
	Tue, 07 May 2024 06:54:51 +0000
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-51f6382404cso575586e87.1
        for <linux-nvme@lists.infradead.org>; Mon, 06 May 2024 23:54:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715064886; x=1715669686;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GbXroQ9nJNbCFdI6AvHycDcnwfIWgN2jHSxCuBfyUx0=;
        b=lDies2HP/lLzz6TGia/ECyV+MPqyhdOocU9P6Vd73oqRiZdCi4fWVEAvfcU78YfP+V
         1IOReaGYcDmVL3Ld9AqJxLPVY9ZiO5CyMvoyMzHXWfC89rHEsYEO2XNaIMChpVdOe8y9
         OJ4tzzX4TFQ8Vu2AEhZZpcoqYwH+njGfG3dQEMXMtSysGVmo2jyrWHH1agZ1hPUTMZFg
         fU6Ufs17v9X37K9rdtHWrQ4IAGDI3v/TadmLfsEFbxDwtC3fg1KzXoHXD/05ItFzfi1G
         NbJqrcXEOF7cxvTbSdP/iyckxUZFq7m33S8NkrywmP7MjeZyC85k2oYc3JHx/AeYemjb
         hCFw==
X-Gm-Message-State: AOJu0YzgGGL87OxjFkXe/mFJqkHbkIZpOVlUP5TuspeLh5h1B02zsnDr
	ztfg/e5OdD/olLCz+nAy/eoBQu5FaDuP2AklUCyINk58EvIqy6TLXPaxmw==
X-Google-Smtp-Source: AGHT+IF0CyqTBfwdJpG6Jj8qYeGNIMDQRA5zPq7YA+EkpXC7h/PHOQvEWZHDum8ShO6DZoPWi+GcuQ==
X-Received: by 2002:a2e:3c0c:0:b0:2e2:177c:5f6 with SMTP id j12-20020a2e3c0c000000b002e2177c05f6mr7595039lja.0.1715064885832;
        Mon, 06 May 2024 23:54:45 -0700 (PDT)
Received: from vastdata-ubuntu2.vastdata.com (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id q27-20020adfab1b000000b0034e24be18a1sm12310680wrc.15.2024.05.06.23.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 23:54:45 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: [PATCH v2] nvmet-rdma: Avoid o(n^2) loop in delete_ctrl
Date: Tue,  7 May 2024 09:54:44 +0300
Message-Id: <20240507065444.1109334-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240506_235449_786792_2DD5037E 
X-CRM114-Status: GOOD (  12.32  )
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
Changes from v1:
- address exceed 80 characters

 drivers/nvme/target/rdma.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 5b8c63e74639..955296ac377f 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -1814,18 +1814,14 @@ static int nvmet_rdma_cm_handler(struct rdma_cm_id *cm_id,
 
 static void nvmet_rdma_delete_ctrl(struct nvmet_ctrl *ctrl)
 {
-	struct nvmet_rdma_queue *queue;
+	struct nvmet_rdma_queue *queue, *n;
 
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
+	list_for_each_entry_safe(queue, n, &nvmet_rdma_queue_list, queue_list) {
+		if (queue->nvme_sq.ctrl != ctrl)
+			continue;
+		list_del_init(&queue->queue_list);
+		__nvmet_rdma_queue_disconnect(queue);
 	}
 	mutex_unlock(&nvmet_rdma_queue_mutex);
 }
-- 
2.40.1


