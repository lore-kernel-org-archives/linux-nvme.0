Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38A89C433FE
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Nov 2022 00:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=mQNrjS1zNaovPA1c7UCA7u0khlPktyUNcq14/ZDUISI=; b=QoXg6PfQGgndW/BX4OY8pk3xMH
	bA38GJydCsX8W7ae3rohsbW2fL9y3sK0AtqXzfyOzF+ZCtAZyi7Xq7vQjnLr/NDRCJ9TvMpdxVHa3
	phJos/h0CqCSepyPEws7mKBv67sj3KVYkN8vXo6BIAUfKl4EXsRZLFWIiHc6GBsENwQPE/fpVju0G
	1DTmAWcF9eAWlQjeU1h5roaNkOr/8ZegGNkmzRdTTUjKi88H4VbM6w2r6QPpuza1Vrw7WMxFFzP+e
	HmcYfsnw5tB5Cld1xAq0VBkEGZiLeaWYIZoK9qTIvAG+r7t9DgGIJR188KGsD1rL7KYBaYXSEchCc
	niL/mRcA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oujlB-0064OY-Su; Tue, 15 Nov 2022 00:25:05 +0000
Received: from mail-pj1-x1064.google.com ([2607:f8b0:4864:20::1064])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oujl8-0064Li-0C
	for linux-nvme@lists.infradead.org; Tue, 15 Nov 2022 00:25:03 +0000
Received: by mail-pj1-x1064.google.com with SMTP id v3-20020a17090ac90300b00218441ac0f6so376627pjt.0
        for <linux-nvme@lists.infradead.org>; Mon, 14 Nov 2022 16:24:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mQNrjS1zNaovPA1c7UCA7u0khlPktyUNcq14/ZDUISI=;
        b=mA6AjTbkzX4Z0d040mZSYzb4LSG2AUPdKwmbn2r85hpqGERpsq8/9g0cOpx6H05YHe
         fyzdzFJUJ2ay8HrEmYWZF4ZZruTJy2/ix/FtlCcbPC2Hw77Df/QuJclOQWVHbtO9IxdS
         D8LxXuG/+CclIROXCyG7c/FRJATntafANhGms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mQNrjS1zNaovPA1c7UCA7u0khlPktyUNcq14/ZDUISI=;
        b=zDt2yUvV24PvAZrJ/SJWTbeu1u4MyUwEqCFNg8Rqb7v/et6VoqV/9E8622Wvkejd2w
         ETe5Ye3yrO0nJRQLx5Idwd6KXLDnqt5d/FDQJZEfV0RroBijOMHmnEvklwGo1G16R/KF
         aiOoKRDHsh362dNtPxa3YV+PEFtFX+5qMSsKehOrZkMruV/7EkOB/rKyv5LJ77GnX5/2
         8ndzCv/VdQrmfhGE8o0nbN5X1SdgDD+mcNWeU3ke2yNOfBue5M+NWbHmkxzqy3hom/6n
         gdUTG99bfz1rs7ca1yuIaUWFyEDAzOCcDwj7jv9o1A41ls74zTYrOcVOmmnoYseKj+3g
         teog==
X-Gm-Message-State: ANoB5plphvRp8RL8NrlILXmudDVHvcrbh81xXScgzOxmDmKFMf35JVD1
	W1+CHOHCEdK5joflsS6CjcAKz1Jd6Vlg4dsBBaZ4gEf16rHUmA==
X-Google-Smtp-Source: AA0mqf4WL8SWwTQEE3lPtBAiTzSDkj28yrOpA/XHw62IIuNEYOwmwFcboL5c+15RlfA8bcSvJ3+LEVfVAC/9
X-Received: by 2002:a17:902:b488:b0:188:bc8f:5fb2 with SMTP id y8-20020a170902b48800b00188bc8f5fb2mr1652171plr.48.1668471898606;
        Mon, 14 Nov 2022 16:24:58 -0800 (PST)
Received: from c7-smtp.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id r17-20020a170902c61100b00179eaea7f55sm546061plr.47.2022.11.14.16.24.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Nov 2022 16:24:58 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp.dev.purestorage.com (Postfix) with ESMTP id 92CED2212A;
	Mon, 14 Nov 2022 17:24:57 -0700 (MST)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 8598BE40227; Mon, 14 Nov 2022 17:24:57 -0700 (MST)
From: Uday Shankar <ushankar@purestorage.com>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Jens Axboe <axboe@fb.com>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Guixin Liu <kanie@linux.alibaba.com>,
	Uday Shankar <ushankar@purestorage.com>
Subject: [PATCH v3] nvme: avoid fallback to sequential scan due to transient issues
Date: Mon, 14 Nov 2022 17:23:59 -0700
Message-Id: <20221115002357.3949804-1-ushankar@purestorage.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221114_162502_176766_76F64C18 
X-CRM114-Status: GOOD (  19.13  )
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

Currently, if nvme_scan_ns_list fails, nvme_scan_work will fall back to
a sequential scan. nvme_scan_ns_list can fail for a variety of reasons,
e.g. a transient transport issue, and the resulting sequential scan can
be extremely expensive on controllers reporting an NN value close to the
maximum allowed (>4 billion). Avoid sequential scans wherever possible
by only falling back to them in two cases:
- When the NVMe version supported (VS) value reported by the device is
  older than NVME_VS(1, 1, 0), before which support of Identify NS List
  not required.
- When the Identify NS List command fails with the DNR bit set in the
  status. This is to accommodate (non-compliant) devices which report a
  VS value which implies support for Identify NS List, but nevertheless
  do not support the command. Such devices will most likely fail the
  command with the DNR bit set.

The third case is when the device claims support for Identify NS List
but the command fails with DNR not set. In such cases, fallback to
sequential scan is potentially expensive and likely unnecessary, as a
retry of the list scan should succeed. So this change skips the fallback
in this third case.

Signed-off-by: Uday Shankar <ushankar@purestorage.com>
---
 drivers/nvme/host/core.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 1a87a072fbed..d8303c15c7ee 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4431,9 +4431,6 @@ static int nvme_scan_ns_list(struct nvme_ctrl *ctrl)
 	u32 prev = 0;
 	int ret = 0, i;
 
-	if (nvme_ctrl_limited_cns(ctrl))
-		return -EOPNOTSUPP;
-
 	ns_list = kzalloc(NVME_IDENTIFY_DATA_SIZE, GFP_KERNEL);
 	if (!ns_list)
 		return -ENOMEM;
@@ -4541,8 +4538,17 @@ static void nvme_scan_work(struct work_struct *work)
 	}
 
 	mutex_lock(&ctrl->scan_lock);
-	if (nvme_scan_ns_list(ctrl) != 0)
+	if (nvme_ctrl_limited_cns(ctrl)) {
 		nvme_scan_ns_sequential(ctrl);
+	} else {
+		ret = nvme_scan_ns_list(ctrl);
+		// fallback to sequential scan if DNR is set to handle broken devices
+		// which should support Identify NS List (as per the VS they report)
+		// but don't actually support it
+		if (ret > 0 && ret & NVME_SC_DNR) {
+			nvme_scan_ns_sequential(ctrl);
+		}
+	}
 	mutex_unlock(&ctrl->scan_lock);
 }
 

base-commit: b09985f97c356f1e87fe042faaa9947bb693ebeb
-- 
2.25.1


