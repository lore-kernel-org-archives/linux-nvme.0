Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BFD2D2CE0B
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Oct 2024 17:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=9TNrysX+YGayunGQPEqgWCn7qxPJtfsOFzYvSMFHN+8=; b=E6YyYNfJTXY/AQmvUwd4sD1AHG
	9VCdUaz+I3YDQtoseEGvQnw3oMF/v5uWAV8ifr5E2/78hVWXocMa2OeM2qIjK+MfGmg5/CdqU+9Od
	9Crl1bTVaONUbxCwG7/hqozkullbGWe5k7hFk7xL0xMPdtYoJuNUs3XwG5qKQsPeSrUAkwEYB1dqg
	/bNNBW2YWWil/z0jldNSbT22LneOYcVqJbrzly+0DsaRemBZ6iRQ1MwVl2oSNooIp9C0Gg7+WMv6D
	PXwaLQcoYkIIdn96j5vY3pQBcPbFoJc5xaj+mlDGp7w32RT0OSkvrbbCwNgOTHNavmvasMWwf3nJS
	gTSgcyiQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t3IQj-0000000Bblx-39XY;
	Tue, 22 Oct 2024 17:12:25 +0000
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t3I9U-0000000BYY7-2VUV
	for linux-nvme@lists.infradead.org;
	Tue, 22 Oct 2024 16:54:37 +0000
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-7d4f85766f0so4408379a12.2
        for <linux-nvme@lists.infradead.org>; Tue, 22 Oct 2024 09:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729616075; x=1730220875; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9TNrysX+YGayunGQPEqgWCn7qxPJtfsOFzYvSMFHN+8=;
        b=VAr+3uVB0JjGhkCBBA33GYCbUXC2gAq1iZXqzyybwunUTG181nBE+wnlTWaBk73Bqq
         ffpq4mZbMfJA3NYwfGC8mDizuiCyv0zQsz4MHKvZa8oQSCLweJ5jDlzS4beulf0plWB6
         rVqujQKM74h7SAVwyqowctqFl+xDHU3btTb7xCw02jaj0WhKijy3oUdKQo99QBi/zRfz
         KBLX4L9cMtkGpjKwDIoL+7H/7Nz0WF7ZOpBqvV/hGjTiTy0HlI5/G2+8g2DKUsQn5BXt
         FQ6v9Osik0he45JUtQQY7isBgQdSOnn6f8JjpqJU0xxmQTZUJVFYr+IRPw2LZu83ABZC
         Vspw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729616075; x=1730220875;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9TNrysX+YGayunGQPEqgWCn7qxPJtfsOFzYvSMFHN+8=;
        b=rJB+sPwNMR2f6C4/ZBYlXFq7xna5h3vLV0+orVz9+oLCkq5RPHSutRm/fIM2Bk6Aea
         AFax/AzyCKivzHq2A2JP5+SfckcAx/q5noF4Dqg51vMLjap2TehfMhbRXqgIIbBMk0x1
         4160jhJyn1ZNsIWRYZU3z7e0HSBHRBVqKP0YsLfboO/IA1lFN7mQ/TaR+ypYJ6skkepb
         nvMM2ojtAYoiWBQXCewHgLGN3ErDZpf06h5sXgEIwYpugk1bnAxFcpSARL9qiXn6uxcL
         yxMpoU8D0hRPB5h3N5bFKz/7NNjKBM4GqC7p8Po8PmFhr+rO2DqDt/QsWCfOt58omLWn
         sO+A==
X-Gm-Message-State: AOJu0Yx9KFprijXWN0w9VHhWFbMEStyFQTfX/12P5CbBoW2YpX3Nm9eB
	LHpCo9/hP5LKSbnSqllWU0dNvVL4utMquX8fMVcAbZnVrtU3RrywFIUq4g==
X-Google-Smtp-Source: AGHT+IFkHcLEmgKasPpQr11VoQ17bs5o5J/NiIGNzuQ1XmlhatUPgo6ouFkAAXlzTtOBbW7QW3RDHw==
X-Received: by 2002:a17:90a:9a8d:b0:2e2:bd7a:71ea with SMTP id 98e67ed59e1d1-2e5ddb41859mr3395055a91.8.1729616075442;
        Tue, 22 Oct 2024 09:54:35 -0700 (PDT)
Received: from tokunori-desktop.flets-east.jp ([240b:10:2720:5500:f6f1:2f90:dd68:7e46])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e5ad25cb0asm6458637a91.10.2024.10.22.09.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 09:54:35 -0700 (PDT)
From: Tokunori Ikegami <ikegami.t@gmail.com>
To: linux-nvme@lists.infradead.org
Cc: Tokunori Ikegami <ikegami.t@gmail.com>
Subject: [PATCH v2] nvme: check PI size if metadata size or below
Date: Wed, 23 Oct 2024 01:54:12 +0900
Message-ID: <20241022165425.11644-1-ikegami.t@gmail.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241022_095436_654850_E65F6F51 
X-CRM114-Status: GOOD (  14.88  )
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

The PI is the first bytes or last bytes of the metadata.
So its size is not equal to the metadata size only but below also.

Signed-off-by: Tokunori Ikegami <ikegami.t@gmail.com>
---
Changes since v1:
- Fix the commit message spelling miss hte to the.

 drivers/nvme/host/ioctl.c | 4 ++--
 drivers/nvme/host/nvme.h  | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index b9b79ccfabf8..9fddaaddbbf1 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -232,8 +232,8 @@ static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
 
 	length = (io.nblocks + 1) << ns->head->lba_shift;
 
-	if ((io.control & NVME_RW_PRINFO_PRACT) &&
-	    (ns->head->ms == ns->head->pi_size)) {
+	if (io.control & NVME_RW_PRINFO_PRACT &&
+	    ns->head->ms >= ns->head->pi_size) {
 		/*
 		 * Protection information is stripped/inserted by the
 		 * controller.
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 093cb423f536..fbcb2243ba84 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -542,7 +542,7 @@ struct nvme_ns {
 /* NVMe ns supports metadata actions by the controller (generate/strip) */
 static inline bool nvme_ns_has_pi(struct nvme_ns_head *head)
 {
-	return head->pi_type && head->ms == head->pi_size;
+	return head->pi_type && head->ms >= head->pi_size;
 }
 
 struct nvme_ctrl_ops {
-- 
2.45.2


