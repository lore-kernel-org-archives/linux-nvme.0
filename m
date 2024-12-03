Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEC5BE6C5F8
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Dec 2024 03:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=BHuI4q2u3Xl91rfhMIm9f5VhokkqjUJEzUCp8oqzmXk=; b=u55dq+xeDlSXYAIwusQl4kt52B
	lqZ8JiGZxV1+XtHR2yqgbEwfPYuXHti7woBf2A7E1jdT/FH4jcWLSAgO9A3O+LCmZqlDTvnlabQmZ
	cp2qsQcK23EslyxQ2Frn+HBwtYT+9+m2Pf/IRbraz9BxDcsKTT02ontD4+NSIuvkZFQVIOGZje8Tt
	tOcDzcqOuvQuMBiQUdzN1ISK7BBWtZACD38Mech7kN154OCuVrPrwlkumxYwURTg7zkc2sPhm+XXV
	9Fq3sm2iU2+lkxm+A/PqrHy9XsKp4CmNflN27Ljh73xCMm2qA0vnfYIzR+b4UJ2mQDEG/+lX7QXeZ
	d5eyWmIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tIJla-000000088g7-1X0R;
	Tue, 03 Dec 2024 03:40:02 +0000
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tIJlX-000000088er-3HL7
	for linux-nvme@lists.infradead.org;
	Tue, 03 Dec 2024 03:40:00 +0000
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-2154e3af730so27149525ad.3
        for <linux-nvme@lists.infradead.org>; Mon, 02 Dec 2024 19:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733197199; x=1733801999; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BHuI4q2u3Xl91rfhMIm9f5VhokkqjUJEzUCp8oqzmXk=;
        b=DLuXRHjSgkVC72uGue7ArY31lLsxjqs2H/RKSwzbuVu6DtHGqhUiC/TJsE3ROBXiyB
         GPBkDglGF+fi7ShPCY0/Ibo8Ku3jgZF6DzbLe2qXIUZyZK8q/gA5jOg8Ric6KgVpL4DU
         qOBwbC+LqMyf49fnFQuvx/f4OjhLMslnFXIxE1k1rdzY3h2+L0LrOnz9chVSHVzs2gt/
         ClmratbfdohcBBRes90CQXRvm6PNs3L62+fWXpY3FbdDyDGPcQ+9Vn35/zO9dBhI5TxP
         8izFfqJfKc/eMiSG1wtlfxooLnS+pSI9p/3RGuabO/oRFWMipriSDWHNsZVjh7u8/RTd
         s15A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733197199; x=1733801999;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BHuI4q2u3Xl91rfhMIm9f5VhokkqjUJEzUCp8oqzmXk=;
        b=HuQSjmAakujm3AlkGFCzrIFXOmjsicoGR58XeP0s0kGv215v0uGvZKQBBXn7hHvvEN
         jkpBN5uj+sVVt8IufqygeMoN1NlEIzSC68vwdojoCV9wxfUq7IuDUeUogj1UyB0b6o3R
         q6DFuVKtmNwbsR+mZWls/miyMDjRgdYXbJBkFdCS1hRNpM5rOs5gmvLyMZ8hLpgtdHlX
         /2YoOZF+qL5JwYkKPxWv9+TcLmC499XL0zHWUASZv9C3nQV3BPXV0ydE0/RkFRCL6WVQ
         5YNHdYRWewHf+7TFTLJBrnPNFGaqOBb9dRl3KWfoXvF46tdFw7wlZOyqXTYN1OoPkdK4
         sscQ==
X-Forwarded-Encrypted: i=1; AJvYcCWctFmodXR0OR4VMjjuNo9bVmLBKgArhbf0LW6H5OdMdVLDaM9vCDXoM2Uxfi+fn5g94raWbrQeydef@lists.infradead.org
X-Gm-Message-State: AOJu0YxPTLc8mpUbldy1zPcDxZAFy3NaBDPuiOpf0oXq9D5qy15rYo/U
	MAx2xA8I4uf7p/J8mspuVShcbCBf5j2YLBDI/KCi/YNg6/AFj1uH
X-Gm-Gg: ASbGnctLvtTJTLGyHtX+743RY0F2M3EBNFDWJQmmLXIKmFO5xp/Cci7QzKzxu8Fzfa2
	g/Q8K8g+o4WlqNxEm9V7okjtjV/u5v/AwfrBmBbRMIOhOh2lExXW9DsPZ8yXqyCK20mC0W6aFCg
	OT/PKXeRiGiYRw4LVDfHFiUg7C23p5ku1X3gFKKC7qg5IXGatNHlp7rXLlTzcgM4ufLISPvfta7
	nSQuumPOA5y0dSiVwMolxNBjqP0A1fp2sm4i67ghv6sFc8CdiaVI9Msx3bwTw==
X-Google-Smtp-Source: AGHT+IFdiELg8otAdb63Wp3uKOJdKRAdTD7LtaAi/HuX4oHsglR1rRUYPytDrXhRXE/C8BQ0mZejzg==
X-Received: by 2002:a17:902:da86:b0:215:6cb2:7877 with SMTP id d9443c01a7336-215bce9d120mr18082965ad.4.1733197198990;
        Mon, 02 Dec 2024 19:39:58 -0800 (PST)
Received: from localhost.localdomain ([143.92.64.18])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215218f4787sm84909765ad.53.2024.12.02.19.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 19:39:58 -0800 (PST)
From: "brookxu.cn" <brookxu.cn@gmail.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: hare@suse.de
Subject: [PATCH] nvme-tcp: remove nvme_tcp_destroy_io_queues()
Date: Tue,  3 Dec 2024 11:39:55 +0800
Message-Id: <20241203033955.394595-1-brookxu.cn@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241202_193959_816340_DEE55603 
X-CRM114-Status: GOOD (  12.00  )
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

From: "Chunguang.xu" <chunguang.xu@shopee.com>

Now when destroying the IO queue we call nvme_tcp_stop_io_queues()
twice, nvme_tcp_destroy_io_queues() has an unnecessary call. Here we
try to remove nvme_tcp_destroy_io_queues() and merge it into
nvme_tcp_teardown_io_queues(), simplify the code and align with
nvme-rdma, make it easy to maintaince.

Signed-off-by: Chunguang.xu <chunguang.xu@shopee.com>
---
 drivers/nvme/host/tcp.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 28c76a3e1bd2..b127d41dbbfe 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2024,14 +2024,6 @@ static int nvme_tcp_alloc_io_queues(struct nvme_ctrl *ctrl)
 	return __nvme_tcp_alloc_io_queues(ctrl);
 }
 
-static void nvme_tcp_destroy_io_queues(struct nvme_ctrl *ctrl, bool remove)
-{
-	nvme_tcp_stop_io_queues(ctrl);
-	if (remove)
-		nvme_remove_io_tag_set(ctrl);
-	nvme_tcp_free_io_queues(ctrl);
-}
-
 static int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
 {
 	int ret, nr_queues;
@@ -2176,9 +2168,11 @@ static void nvme_tcp_teardown_io_queues(struct nvme_ctrl *ctrl,
 	nvme_sync_io_queues(ctrl);
 	nvme_tcp_stop_io_queues(ctrl);
 	nvme_cancel_tagset(ctrl);
-	if (remove)
+	if (remove) {
 		nvme_unquiesce_io_queues(ctrl);
-	nvme_tcp_destroy_io_queues(ctrl, remove);
+		nvme_remove_io_tag_set(ctrl);
+	}
+	nvme_tcp_free_io_queues(ctrl);
 }
 
 static void nvme_tcp_reconnect_or_remove(struct nvme_ctrl *ctrl,
@@ -2267,7 +2261,9 @@ static int nvme_tcp_setup_ctrl(struct nvme_ctrl *ctrl, bool new)
 		nvme_sync_io_queues(ctrl);
 		nvme_tcp_stop_io_queues(ctrl);
 		nvme_cancel_tagset(ctrl);
-		nvme_tcp_destroy_io_queues(ctrl, new);
+		if (new)
+			nvme_remove_io_tag_set(ctrl);
+		nvme_tcp_free_io_queues(ctrl);
 	}
 destroy_admin:
 	nvme_stop_keep_alive(ctrl);
-- 
2.25.1


