Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4770CC021A0
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Feb 2025 22:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=HcGHwBHCshi0yz2RQGryrnPpLkVHnABt1yCMpCIlUPI=; b=CISv++WWfsu3eltRuyCIvYD12B
	nNzMRlrOyVxDcwtF4I/YBXsvoo4C7z8UIsr/vQXOjODkWhSwvWGnJDqLnHSBduWUZJ1rdllSNtufD
	0vdM/2T83O6MbDHcXBcxUC4yG05hEoAcsd5ToTyAbbrHrbmrvQZGYw/ce1vyGp6PoCBmg9/y+tJtC
	XGoeYes4NxNvhV5h+9vAAE/AQ/c1G+WvIXVbk88Pl1x1RBUFD5aimYptKovnm54y2+r/QH1G21EyX
	BribwDMcfLZs0xER5C4NCKG5KRvY3Fe+O1qhJd2Bm8IEIoKHMa9iL+WGSu8kQXd+DC4RflpBrXtBF
	SYVsWAug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tihVW-0000000Cnfq-20wc;
	Thu, 13 Feb 2025 22:16:30 +0000
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tihVU-0000000Cnf3-1ASo
	for linux-nvme@lists.infradead.org;
	Thu, 13 Feb 2025 22:16:29 +0000
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-38dd93ace00so779608f8f.1
        for <linux-nvme@lists.infradead.org>; Thu, 13 Feb 2025 14:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739484986; x=1740089786; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HcGHwBHCshi0yz2RQGryrnPpLkVHnABt1yCMpCIlUPI=;
        b=BWElax8u3bquqe+B8ETKVmiEFV9+7N96OYQZ3XaDSTpWNo6nU2PXZvmL3edW4n/8Tj
         aBnKi9bCUfkXSAxbR/muLyPCWsGeO89JFAL6Mj11KMQFAyYAGLZtcFEqdzMfiiNTzNAS
         WN3jAC2xhUS7TxsyLUPae5YIzLWfXGHspVAjIX+8BmuU+G8543Labhhgh8cpwlp3MDXy
         tumuHXhkYnmuPJLAgIC5nqClOiuMzCQnGNh/T44GUi4hB1R+7D+MsKsbKwEajSA8RdoG
         ANHZy4IA2k+AirIJrycjqcljbNfzxHgFNQJ3rWRNObwEi+nZ1gZXIXzUL8Q0RPFTW8jt
         dvZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739484986; x=1740089786;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HcGHwBHCshi0yz2RQGryrnPpLkVHnABt1yCMpCIlUPI=;
        b=D5BrdlQH8/kws5Ic7XvWHrseT6MCI1Lycun1IFJ6XbG9D1cQY506sFtVK6emzAcCNB
         CeuJiurqMwD31DimKMg7bQL3s5MfD1sbRXN3FDq909FeHHG6URBAE33Iv4saVtCqmWDA
         ZkY5uvlFTYuVLGPwXDSi/guUupL8BhN36cekC6wgeInAZPEGTkkeXD+doz9/CTQccGws
         aQxzVrbUNHbTsqkOCKbi8+rPGVBF8iTk3yFGqXU3Upv0kgVHda3eQrQpmbevAV1122V8
         c/lnG4/IIEuqEHGp4BGft0ZH8E1kGq1yOF2stn/Km5Lm97e2QeEPFP/rnjtnL+XEEtoZ
         HjMA==
X-Gm-Message-State: AOJu0YzzFYaXGlEB+eEBMrgFy4n6Ny53c5VEgu3E4k8PjVdEqkf9YGTE
	zEjJvl5AosuTOxSZd2ROQAiXUt/q0erc+vxkfwZPQes50EGMloDY
X-Gm-Gg: ASbGncvgg9lLtQ4P6HbEz2gAj7mgNCm9yY8V5pFjb1zQQSiCE9osO2UKYOew18TlV63
	W/aKHQhWN+/i8ZGiO4eE96rJnibz6RPPUR0jrrT91ZijjWEulCO7ByVUUcRbqTdvpD0oigjNxJn
	U9+A9stA/5FfcCaFlEeJGFozd+p4OHvxrt+PrT+aZT6dbHODcz1KwfiXSyTac1NDxaEVjc85DZv
	lxfO6W48UJhCTJvtULZHt1hzA9M8W8pqkhNCbMy95+Rf9t2vXuLbYNQDIOMS+oUSE2fk4xxKVBZ
	68JwPLrWxzs119YT
X-Google-Smtp-Source: AGHT+IGECzW3fSF1xoqweSC//Ej3VoquTbE09pIlohYYLP6905BQnHOPle4p2ajo3BzRgmjrjGxIzg==
X-Received: by 2002:a05:6000:186b:b0:38f:278f:58e4 with SMTP id ffacd0b85a97d-38f278f5963mr2846752f8f.12.1739484985733;
        Thu, 13 Feb 2025 14:16:25 -0800 (PST)
Received: from qasdev.Home ([2a02:c7c:6696:8300:594f:c4b7:a2b1:c822])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258dcc45sm2974803f8f.33.2025.02.13.14.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 14:16:25 -0800 (PST)
From: Qasim Ijaz <qasdev00@gmail.com>
To: james.smart@broadcom.com,
	kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] nvme-fc: Utilise min3() to simplify queue count calculation
Date: Thu, 13 Feb 2025 22:16:22 +0000
Message-Id: <20250213221622.81457-1-qasdev00@gmail.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250213_141628_314401_0C4B384E 
X-CRM114-Status: GOOD (  10.78  )
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


