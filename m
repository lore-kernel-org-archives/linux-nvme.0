Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62946C77B7A
	for <linux-nvme@archiver.kernel.org>; Mon, 29 May 2023 10:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ep47zFrzrdEJ44Hqc9XXjwqqYSSyPX231+NhLADfiSE=; b=CdCrhkuLiiPuQO80bH/TJpw/h3
	CuJjAB91wPUqyeOUHHwJlzP8CA6LoyUtz1wKFNycqdLVPFLF5clLVsKC1VgOx9LRQ8i/kOiqaNpIR
	ZVmoB/SqFgDMMtT35CQRa+BQ+3P6g0X3IGKUcYw6d37fgmJEAXU+9u5FXT+dE+CmUkBe9SZOcCb93
	UIA12BEZ8QTZeR2Yas8wy2TAHufSXyIzTLsESbJmdHKkripRdf4DR91UNH/aj8an611uYIyBJ2kAu
	Re1X+S8tQSGpHF8whjF5wES9VnSoY7Zx/bG6EIQi4cM31iFwtpdPwEf2jV163mhNNGBx5+CX7G14x
	AmWswMMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q3abG-00AD1R-2R;
	Mon, 29 May 2023 10:59:42 +0000
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q3abE-00AD0C-0H
	for linux-nvme@lists.infradead.org;
	Mon, 29 May 2023 10:59:41 +0000
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-64d5b4c400fso3644228b3a.1
        for <linux-nvme@lists.infradead.org>; Mon, 29 May 2023 03:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685357978; x=1687949978;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ep47zFrzrdEJ44Hqc9XXjwqqYSSyPX231+NhLADfiSE=;
        b=BA2fC5N1ViNb2dN8CaIv6BZ9CCv38VCwNNvuctEjmYMVKzxpEkHud0V5SJbJaSgXw9
         zoplBdEAGJ0tbsPTqJx9bbZJGJirQztqVYGv7Qt4y1oMhENq68yp0BESuTZTgigN57Yr
         I08pIgJyGduPlNM/ePTDS9TqbTkXwo8PkOayh0vlouWBXRqcEGUQcyEXdm/V6/hnHeSf
         e0soX/X499Z8kzDESYgjPkSOWcWDextsasMh4MXWHrbx/dNuZCpu14Ni4Z5UOKKgueyy
         sZF4OkVi4l4Br7QuLAvZIuSwNe22BG8fNXhdm2RTagOXVbR3BB+GU43dNHl9pcamn5Pi
         KkWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685357978; x=1687949978;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ep47zFrzrdEJ44Hqc9XXjwqqYSSyPX231+NhLADfiSE=;
        b=U8nHkvp5yIuNyS01SCNFP2lu4ryjCfHwG/dsmx8ZxJ3qsenMI0jjpSxay9sln0E6xk
         WsycSidL3StJK83bz+feZ6Bw/cSxiVxCT8slPGPUQq0cnoQi57tK7UhY6NGnjniqj7S8
         juB9EEAdyxHSbeatX6NiwfWJlDhr4flipE5bhJJ10Lir68dv+W97ajo+u69l2AqMNyS7
         3BKy7jfr5GYL/0RVRG/XNDzNALmsVqwqLxLtW3Od1d0SzOUkrv4Y0urvMf16GOy/K+JN
         iamQ2ST7E/4tGwaB6cPHIyZ2k4b6Rd7f5mj0MArU3fB/yJhUgBEPNmh3auJOJay1/W8+
         QrXQ==
X-Gm-Message-State: AC+VfDwKdtKcFhVkCf70zhkZpbePZj1trCdSmO0USRrCtvHCxG1ozO5a
	8NgE6qdN70DGWz8XAO+iT18=
X-Google-Smtp-Source: ACHHUZ5d174/h7CwQtC7Bod/+WNGrMAoyHWHrWbfqf3DkpTp/xsWlFE4CKHSjR1+BQpvsXQDE83POw==
X-Received: by 2002:a05:6a20:d705:b0:107:10b6:4c84 with SMTP id iz5-20020a056a20d70500b0010710b64c84mr8144873pzb.21.1685357978667;
        Mon, 29 May 2023 03:59:38 -0700 (PDT)
Received: from localhost.localdomain ([143.92.64.20])
        by smtp.gmail.com with ESMTPSA id v7-20020a63d547000000b0053f22b76cdcsm6863110pgi.82.2023.05.29.03.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 May 2023 03:59:38 -0700 (PDT)
From: "brookxu.cn" <brookxu.cn@gmail.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 4/4] nvme-tcp: remove admin_q quiescing from nvme_tcp_teardown_io_queues
Date: Mon, 29 May 2023 18:59:26 +0800
Message-Id: <1976b5b41456b03a3c5acf68f25b8f6c0873da92.1685350577.git.chunguang.xu@shopee.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1685350577.git.chunguang.xu@shopee.com>
References: <cover.1685350577.git.chunguang.xu@shopee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230529_035940_127593_03CCCEF8 
X-CRM114-Status: GOOD (  10.31  )
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

From: Chunguang Xu <chunguang.xu@shopee.com>

remove admin q quiescing form nvme_tcp_teardown_io_queues(),
as it will done by nvme_tcp_teardown_admin_queue() and other
functions.

Signed-off-by: Chunguang Xu <chunguang.xu@shopee.com>
---
 drivers/nvme/host/tcp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index cfebcae7fc9b..75f39a02e685 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2020,7 +2020,6 @@ static void nvme_tcp_teardown_io_queues(struct nvme_ctrl *ctrl,
 {
 	if (ctrl->queue_count <= 1)
 		return;
-	nvme_quiesce_admin_queue(ctrl);
 	nvme_start_freeze(ctrl);
 	nvme_quiesce_io_queues(ctrl);
 	nvme_sync_io_queues(ctrl);
-- 
2.25.1


