Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB376C02194
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Feb 2025 21:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=HcGHwBHCshi0yz2RQGryrnPpLkVHnABt1yCMpCIlUPI=; b=pymhXXh0feBdkTWibzLllEN39N
	TqFRu1s5aAOi6xyHP5Dh3WUAcpK6fV+6b6xYdLNER21FiwcUpYrUIl4Fo30FOBDgMZsdH4koNJxHW
	iXc+zyQqCt6ouJ7aIzSwk4DKfeQWVq9SGOnwxqhak1G21QGBChEqmuT/U0pAnpRr2PgKHV81iqh94
	3nffblWTjh3IXSmx1UKwaDjnO/vxLK7p+7nnu3efTVzi/GiBc+DgbHGWxdwsk8FRQ8kqqw8anfAQR
	FcCrH6N66Jms/O9Utp9Un7R9kAiUxlfZeNTkDep1+FPMZ/OXzRTaqf0yuIAJ5K/2BAdHCfolC8O3w
	0jTquydA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tfQVh-00000001bRf-3UE6;
	Tue, 04 Feb 2025 21:31:09 +0000
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tfPIC-00000001V8a-1ql2
	for linux-nvme@lists.infradead.org;
	Tue, 04 Feb 2025 20:13:09 +0000
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-38da88e6db0so597007f8f.2
        for <linux-nvme@lists.infradead.org>; Tue, 04 Feb 2025 12:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738699986; x=1739304786; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HcGHwBHCshi0yz2RQGryrnPpLkVHnABt1yCMpCIlUPI=;
        b=ZmSRPHI4mw3QsAJEkmBDWsZiZf1FoRiZuF50UkNYzO8IrAWRTBlYqUcdHQudjJKagS
         VQAwfw+h74NFf45B3DsFGCFM+06aaKARQ/DRZLb9RDJ69/XCFFoqUadP8klLA9OkJCa6
         I/KYy+sf8CAD/w9+eQPsXCh3EdDapcUWnPbQBZAYUQBaYTWqM0fLZFD+fl5W9P3O3auD
         XvSxD0iz2h3ulnlISnP7L3jj4hdh109e2v5uSrK/O/oWvUiAcamPo/m2M2Oxu+mOhPEg
         pGK77A9pB4QZXDQpgC6lDQIZg7euxLiGzopuWPKDntyi9a2oTiIndcSsEu0l7H8kLTcT
         hbgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738699986; x=1739304786;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HcGHwBHCshi0yz2RQGryrnPpLkVHnABt1yCMpCIlUPI=;
        b=t8FyehuDzTyL1thJ7Hueka1S2A3nmuJQSsF4dLIuH+8pQdn04x9+Cz1Z+EsY8LeM/M
         T5mlytQBNYYBPy9zzHsRmNEoSmQfPAW2Aap7LvOHQZwxsOCzX36OvhMmEFLDT3NJlFCs
         6g0cPltgdCmiLLME4OF5MKw2ZjS8FfMPIaD6klsQrE6fMq+H/uifZXE/rf1dQiBGFoOK
         Cyxq578x3KdZTJm0G6k1fwak16QIXGBv5NShZ6tHCl1sW/R46Q1dLsvvVC/lik6deOUe
         Rtg8/h4CsaoM0nrhNUmr4oKSIWYUZQvmzdWeAJohVL9aXDRD5Rbu0C0wobL+ud21kM0i
         0ACw==
X-Gm-Message-State: AOJu0YwYITkg7ayiS4muU1koLEDyxP74OmpVjErlS9l8HhvYTViS9nWq
	bX1QWtFHMzEfjwA9oYs0muZaUXfB1CaQNuJ62rYH5ws6Hq8QBKCNJfmrZI2G
X-Gm-Gg: ASbGncttbhcPLLMRw8Z54KBhfA+Hp5+DBVWTmF4PojtU4Z8er2MFXpeauK93OsFyeEI
	XwDTj1AFMNWgxj7KZ6+jBpeqVnpRgrV2K60x+e3XKVrFhPf5UvTjI/gwn2BMKIzzZle5qEUs6GR
	TjVwxLrZR5hGrg1RL750gK4ZWQhlI67jUJi4J/Dmp8cWa2i9of5/S6/IqeAawQltzHtRroOwVGF
	IFHQPGwwtroiWi57OGjyu4Wc1fKMU0ohxIDyoAaVWvHowVQ8klpjPjjTC5L5qNu9T+kLRiH6IeO
	wP72uIkrO7KCd01s
X-Google-Smtp-Source: AGHT+IF+VeTop4aATnyPfAkPdoHSxOw+0vdvZweY1tHe4D5i9kBHxnC20VPCDG2dWEByOUtt71EIaA==
X-Received: by 2002:a5d:4e4c:0:b0:38a:615b:9ec0 with SMTP id ffacd0b85a97d-38db4966770mr74032f8f.54.1738699986048;
        Tue, 04 Feb 2025 12:13:06 -0800 (PST)
Received: from qasdev.Home ([2a02:c7c:6696:8300:f765:48ca:214d:7a05])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c5c102ac9sm16465093f8f.29.2025.02.04.12.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 12:13:05 -0800 (PST)
From: Qasim Ijaz <qasdev00@gmail.com>
To: james.smart@broadcom.com,
	kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] nvme-fc: Utilise min3() to simplify queue count calculation
Date: Tue,  4 Feb 2025 20:12:56 +0000
Message-Id: <20250204201256.117194-1-qasdev00@gmail.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250204_121308_476010_052BCDD8 
X-CRM114-Status: GOOD (  11.50  )
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

Refactor nvme_fc_create_io_queues() and nvme_fc_recreate_io_queues() to
use the min3() macro to find the minimum between 3 values instead of
multiple min()'s. This shortens the code and makes it easier to read.

Signed-off-by: Qasim Ijaz <qasdev00@gmail.com>
---
 drivers/nvme/host/fc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 094be164ffdc..4fd1669231fd 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2897,7 +2897,7 @@ nvme_fc_create_io_queues(struct nvme_fc_ctrl *ctrl)
 	unsigned int nr_io_queues;
 	int ret;
 
-	nr_io_queues = min(min(opts->nr_io_queues, num_online_cpus()),
+	nr_io_queues = min3(opts->nr_io_queues, num_online_cpus(),
 				ctrl->lport->ops->max_hw_queues);
 	ret = nvme_set_queue_count(&ctrl->ctrl, &nr_io_queues);
 	if (ret) {
@@ -2951,7 +2951,7 @@ nvme_fc_recreate_io_queues(struct nvme_fc_ctrl *ctrl)
 	unsigned int nr_io_queues;
 	int ret;
 
-	nr_io_queues = min(min(opts->nr_io_queues, num_online_cpus()),
+	nr_io_queues = min3(opts->nr_io_queues, num_online_cpus(),
 				ctrl->lport->ops->max_hw_queues);
 	ret = nvme_set_queue_count(&ctrl->ctrl, &nr_io_queues);
 	if (ret) {
-- 
2.39.5


