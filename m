Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96D91C41513
	for <linux-nvme@archiver.kernel.org>; Tue, 21 May 2024 20:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=fqfteumpgybDqvSHyAt3rAhUrYr4M4+mQHzMDbZ2V24=; b=fUlnr1CaJ379IJuxBgRTnSYeOQ
	2RUgGc9hH/cwtZtZUkk7p3L8XtHHa+SLEKkSka+DdVgq8Dzd8E/WmtBrdABvnIRVjRSGPAVlvFedq
	G2zGkWOMKkJhqJWW9Bzl5BrzgncAZKLTZkium4OW0LgyUkTn5QDq36ncCajuCTd2KBIY01k419lFA
	wqGBxTZpeh7yrHF3S0K9l5idLumc+uVNl1cOIFBFloMeZfpGVb7kL+frH2R6xu4RiBLvJpJPMMR+i
	8p1TQspMKV0jkjBl9CQ92h6TP251AzFtg1RqOdFcMBHvkBkr8Aqu2QvWaEHPb9F0aXm8uI51Rmpoc
	EiycmRQQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9VyO-00000000zd6-0Ojt;
	Tue, 21 May 2024 20:20:36 +0000
Received: from mail-wr1-f46.google.com ([209.85.221.46])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9VyL-00000000zc4-1cXE
	for linux-nvme@lists.infradead.org;
	Tue, 21 May 2024 20:20:34 +0000
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-354c9fe18a7so15538f8f.3
        for <linux-nvme@lists.infradead.org>; Tue, 21 May 2024 13:20:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716322830; x=1716927630;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fqfteumpgybDqvSHyAt3rAhUrYr4M4+mQHzMDbZ2V24=;
        b=Ic9yOPHEhD+o4xBPYCrTRLhzmDMVK7H7FnvHFb1tgJgVIqY3Vi4y9QIfEneIU9GS9o
         nhQxIyIFSsa/4Fr9dX8qXg2kT1ri5BP+bY6R3wH6hIuHzeAXq80Q254CHidpoFdYcLDe
         gH/s2Pt7QARz5/UknwqcMkdizc5ULwmn+3SfYMd/KK8Yghhav3K/gIZcSu1U20DT7p8Q
         jdS/HRHQ35wPix20RDirCH/HvWDUAdSemBzKF400+398eychQ81ID1zH9Zj3soaOYD4s
         paV1riwI5QMWLL+bs4jWADxLEoVvKA/1iYfXmGhxvfJkzcJJEYHE4+/rTujxg5K9Pm5b
         Yvzg==
X-Gm-Message-State: AOJu0YwJ8nPHhEKAIwna2sxv50sXYUQqZj4k3xms22n4lo2Qwg5RtzYU
	LggP62seIdnVkhSoNvKbgqH5al0DyvEwrxFOKOP684GUJaGCzreCVOjHIQ==
X-Google-Smtp-Source: AGHT+IF/zaLBvnhdTGp8adtM6IRw27lmGnmuG3LylmlX6SoZP5HjYQxlwbKzXV/lKcUKj3xeH8Mv/w==
X-Received: by 2002:a5d:5f42:0:b0:354:d14a:cb60 with SMTP id ffacd0b85a97d-354dabc037bmr106f8f.7.1716322830107;
        Tue, 21 May 2024 13:20:30 -0700 (PDT)
Received: from vastdata-ubuntu2.vstd.int (85.65.193.189.dynamic.barak-online.net. [85.65.193.189])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502b8a780fsm32449083f8f.59.2024.05.21.13.20.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 13:20:29 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: [PATCH v2] nvmet: fix ns enable/disable possible hang
Date: Tue, 21 May 2024 23:20:28 +0300
Message-Id: <20240521202028.356777-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240521_132033_449338_EDBEE800 
X-CRM114-Status: GOOD (  13.39  )
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

When disabling an nvmet namespace, there is a period where the
subsys->lock is released, as the ns disable waits for backend IO to
complete, and the ns percpu ref to be properly killed. The original
intent was to avoid taking the subsystem lock for a prolong period as
other processes may need to acquire it (for example new incoming
connections).

However, it opens up a window where another process may come in and
enable the ns, (re)intiailizing the ns percpu_ref, causing the disable
sequence to hang.

Solve this by taking the global nvmet_config_sem over the entire configfs
enable/disable sequence.

Fixes: a07b4970f464 ("nvmet: add a generic NVMe target")
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
Changes from v1:
- Added Fixes tag for stable
- edited changelog to 73 chars
- added code comment explaining the reasoning of taking the global sem

 drivers/nvme/target/configfs.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 6a736d28d767..c90d5b37bb4b 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -676,10 +676,18 @@ static ssize_t nvmet_ns_enable_store(struct config_item *item,
 	if (kstrtobool(page, &enable))
 		return -EINVAL;
 
+	/*
+	 * take a global nvmet_config_sem because the disable routine has a
+	 * window where it releases the subsys-lock, giving a chance to
+	 * a parallel enable to concurrently execute causing the disable to
+	 * have a misaccounting of the ns percpu_ref.
+	 */
+	down_write(&nvmet_config_sem);
 	if (enable)
 		ret = nvmet_ns_enable(ns);
 	else
 		nvmet_ns_disable(ns);
+	up_write(&nvmet_config_sem);
 
 	return ret ? ret : count;
 }
-- 
2.40.1


