Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A302C369A6
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Apr 2025 12:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qrzsBvSf8qsU8a8aun/NmghH++8qOjRdyn6HRPR6fjk=; b=JkqT7f8Wb8BtApvcSDFxTnXg/I
	dKEWrX7NbDZnECVx3t/DycDDPxrDoUAww/j6JvCIZYVGSHjURXhnxOmG+FxiBQFDZqgaLOj82E48Y
	mPBoqWhgK//tqoAfAM4JhSZgfi2pidp9PlsUjkZoC7sZE972t1JWNOiTausIKNzaH4QAvFTM7msEl
	2UTIEYoix5IGbCzSt7DwBCPSQymluy7tsvNFZvUZrKh1dUHtnbzKtLpk4i/oSzBbyZ1C4EKyNyOBE
	aZ5oM7T7mygsj14320gEzzRovJ8ox5xS3i3v5Kgmkz2bpKAxyZtBkH/WnqMazi6AX7OoFm25Pf/x5
	sBYxozJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2quC-0000000ATKC-3xkf;
	Thu, 10 Apr 2025 12:21:16 +0000
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2quA-0000000ATIq-2Dxl
	for linux-nvme@lists.infradead.org;
	Thu, 10 Apr 2025 12:21:16 +0000
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-22548a28d0cso10003435ad.3
        for <linux-nvme@lists.infradead.org>; Thu, 10 Apr 2025 05:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1744287673; x=1744892473; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qrzsBvSf8qsU8a8aun/NmghH++8qOjRdyn6HRPR6fjk=;
        b=wko1b50zWVCeKUzRmNUjTzj0vN6ian0x5M3rzRB0aPBvbvG7tGA3a3vIv7ut/ay1rn
         /YZ5ocOLePcS+cKS63pAF/yvocf8dngAGN0bnAQKhoC/XOmtGhv/ppS88MsD686i2Ds5
         33xps2qwdkZm14v0agJzXH+vLCgRTFv1Ipvvo1cUmnC/k9okYBmze0peTf8tKC6myZdS
         siCYAf+lEsQMGEo2VF4UxoPxv7Eo1+JC1nfac2vUxdmM8lu70gn4cM/6UGZ36o6W8qDt
         1v6G443KtjNVPiyFE2NxOm3xiT0pMPABxUDSVkoke/QwsnX0gjUlH+CDNd5hNJXwsmDe
         TJ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744287673; x=1744892473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qrzsBvSf8qsU8a8aun/NmghH++8qOjRdyn6HRPR6fjk=;
        b=kqjKFSI3mumgnZV8WNKoCEQbFHVuzMcFi355Ly7JVfN1//pIoIA3y1FrtWfsNLguTE
         r8NTsFuPwZ7MCaW6B8GVZoiq3aw6A0Kq/AVexNQNI2DfPMd/On6aNNT3660CC5KgSQU9
         DWYoXTaPnPsQyCYEkk9Ux1gLOQQo9iPiCU+zDe0IekRS9ZYIn0Ohhr3vcxXJonDYjdsb
         gUY6obuUXdeEGBvHma+arcR1fKYuYY83Vvrxk1r6Jf8WrX6T8PkRSbQUAefnC5y2GOLa
         zTerzAErheYPDWOI0U55X5qtC/55gY8UkXLdBMvb4DDAaL42vPq7Rar4D4Ua7zZWKEia
         QL/w==
X-Forwarded-Encrypted: i=1; AJvYcCUfT/lgL57xHsbhlY0vYwLe2vDx5/Hk3Ky9z8MDL63OC7x5Dm+XDbtJJkSKMXPARwXyXR23rCb1TDpa@lists.infradead.org
X-Gm-Message-State: AOJu0Yzm85BsKN3DSzkDq16JXBXScwAwOm48WyQGra/hZJ5ie9ZkQRMf
	XOELhPMxdtxqMZKoiYSxURV7MQ7wBM1cX4Vtq+nItJXpzcJCq9M8RCtsleKpK909AirFfW32e51
	aCyb6AXAw
X-Gm-Gg: ASbGnctQnbPuZ89k+Lf7Hx3IL4N5X6UaXht/DcAaNMtt3dEuE4RW02yiwhqHTQ4GVJj
	JsMR/ww0xZjrbyb8yqyPYWnq1yPPjj3uMc8uVv82uxr5s79AxA1JK3mGi6E20PkwA7DgszaXPAa
	fIrwPchif1NDSVfrDh/gaapfRzEnJ9heSBKldOE1Z84h8Nkfg9niT7NDVyHaqjR04KvgvG4/8Bs
	XYm4kfi7FbMNrxhGoWRxPbb8m5RZoGAu+wei93tLMNxoACNIeDhlP3bkqu/81NxEjCLcVhIvBqV
	+l7OK4Pgx1qWXxl93IPVtVnZFpBGBH5d
X-Google-Smtp-Source: AGHT+IEnwcfD077+xKMm/Qs5Bg5yK4V53Gr/DgnUliik3+4gViBGrFVMZfJT5FBIWV+5+AOFsPVhXg==
X-Received: by 2002:a17:903:234d:b0:224:194c:6942 with SMTP id d9443c01a7336-22be03cf997mr28053795ad.34.1744287673371;
        Thu, 10 Apr 2025 05:21:13 -0700 (PDT)
Received: from localhost.localdomain.com ([2001:df0:a640:1::4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bb1e38258sm3186109b3a.107.2025.04.10.05.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 05:21:12 -0700 (PDT)
From: Jiewei Ke <jiewei@smartx.com>
To: hch@lst.de,
	linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org,
	sagi@grimberg.me,
	axboe@kernel.dk,
	kaiqi.chen@smartx.com
Subject: [PATCH 1/3] nvme: check IO queues liveness during controller reconnection
Date: Thu, 10 Apr 2025 08:20:52 -0400
Message-ID: <20250410122054.2526358-2-jiewei@smartx.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250410122054.2526358-1-jiewei@smartx.com>
References: <20250410122054.2526358-1-jiewei@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250410_052114_569254_6B50E1BC 
X-CRM114-Status: GOOD (  14.20  )
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

During the controller reconnection process, nvme_unquiesce_io_queues
temporarily allows IO submissions. If any IO times out,
nvme_[tcp|rdma]_complete_timed_out may close an individual IO queue. Due
to timing gaps, nvme_wait_freeze_timeout might not yet have timed out,
causing the controller to continue operating with some closed IO queues.
This issue can be reproduced by injecting high IO latency and resetting
the controller.

Add a check after nvme_wait_freeze_timeout to verify whether all IO
queues are in the LIVE state. If any IO queue is not LIVE, the
controller initialization will fail, and the controller will be cleaned
up accordingly.

Signed-off-by: Jiewei Ke <jiewei@smartx.com>
---
 drivers/nvme/host/rdma.c | 24 +++++++++++++++++++++++-
 drivers/nvme/host/tcp.c  | 24 +++++++++++++++++++++++-
 2 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index b5a0295b5bf4..4297507725cf 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -861,6 +861,23 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
 	return error;
 }
 
+static bool nvme_rdma_check_io_queues_liveness(struct nvme_rdma_ctrl *ctrl,
+					       int first, int last)
+{
+	int i;
+	struct nvme_rdma_queue *queue;
+
+	for (i = first; i < last; i++) {
+		queue = &ctrl->queues[i];
+		if (!test_bit(NVME_RDMA_Q_LIVE, &queue->flags)) {
+			dev_warn(ctrl->ctrl.device, "I/O queue %d not live", i);
+			return false;
+		}
+	}
+
+	return true;
+}
+
 static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
 {
 	int ret, nr_queues;
@@ -888,11 +905,16 @@ static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
 	if (!new) {
 		nvme_start_freeze(&ctrl->ctrl);
 		nvme_unquiesce_io_queues(&ctrl->ctrl);
-		if (!nvme_wait_freeze_timeout(&ctrl->ctrl, NVME_IO_TIMEOUT)) {
+		if (!nvme_wait_freeze_timeout(&ctrl->ctrl, NVME_IO_TIMEOUT) ||
+		    !nvme_rdma_check_io_queues_liveness(ctrl, 1, nr_queues)) {
 			/*
 			 * If we timed out waiting for freeze we are likely to
 			 * be stuck.  Fail the controller initialization just
 			 * to be safe.
+			 * If any IO timed out during waiting for freeze, some IO
+			 * queue may be stopped by nvme_rdma_complete_timed_out.
+			 * Fail the controller initialization to avoid running
+			 * with missing IO queues.
 			 */
 			ret = -ENODEV;
 			nvme_unfreeze(&ctrl->ctrl);
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 26c459f0198d..9109d5476417 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2152,6 +2152,23 @@ static int nvme_tcp_alloc_io_queues(struct nvme_ctrl *ctrl)
 	return __nvme_tcp_alloc_io_queues(ctrl);
 }
 
+static bool nvme_tcp_check_io_queues_liveness(struct nvme_tcp_ctrl *ctrl,
+					      int first, int last)
+{
+	int i;
+	struct nvme_tcp_queue *queue;
+
+	for (i = first; i < last; i++) {
+		queue = &ctrl->queues[i];
+		if (!test_bit(NVME_TCP_Q_LIVE, &queue->flags)) {
+			dev_warn(ctrl->ctrl.device, "I/O queue %d not live", i);
+			return false;
+		}
+	}
+
+	return true;
+}
+
 static int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
 {
 	int ret, nr_queues;
@@ -2182,11 +2199,16 @@ static int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
 	if (!new) {
 		nvme_start_freeze(ctrl);
 		nvme_unquiesce_io_queues(ctrl);
-		if (!nvme_wait_freeze_timeout(ctrl, NVME_IO_TIMEOUT)) {
+		if (!nvme_wait_freeze_timeout(ctrl, NVME_IO_TIMEOUT) ||
+		    !nvme_tcp_check_io_queues_liveness(to_tcp_ctrl(ctrl), 1, nr_queues)) {
 			/*
 			 * If we timed out waiting for freeze we are likely to
 			 * be stuck.  Fail the controller initialization just
 			 * to be safe.
+			 * If any IO timed out during waiting for freeze, some IO
+			 * queue may be stopped by nvme_tcp_complete_timed_out.
+			 * Fail the controller initialization to avoid running
+			 * with missing IO queues.
 			 */
 			ret = -ENODEV;
 			nvme_unfreeze(ctrl);
-- 
2.36.0


