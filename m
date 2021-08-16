Return-Path: <SRS0=M7ZW=NH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A1D7C4338F
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Aug 2021 18:11:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8302604D7
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Aug 2021 18:11:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C8302604D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=4vuHJ/89wa/ELklnfbX9v8d+VjlJDRdAiNrN4poh790=; b=k2D1erILasYvyD
	ITokYXeji9mBcs+8QuGp0OVLOkwBeMTAxs3159rk5QgCL+3FSL2A/3LNLzTnrJlIT7bGMeSOwUo90
	eMwvJykgMOwCSldZxkFEOhasNQjEfGjEnmTfMDimTBn8CQt8+t0uI0+XaZGNRq/+Kic7eIh0D3IW/
	bjdlpfxsqJ5Qb0wxITwDkY6qBAABrLAyTcbVLHeTtDzHSn3h7frtEdScUekPSL+y2ZJUF9DMUZgaj
	2fuiSS8PJ/sBvGltmmKODpymQy/8XsQ2SfCuCEMQ7Q3yFE4SzIBdSbozlwPHeLEybcXqQqZ1RJGPm
	Htlu+pGyZ8vMNPwu3byg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mFh4s-00HZ6a-2Z; Mon, 16 Aug 2021 18:11:14 +0000
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mFh4p-00HZ5i-45
 for linux-nvme@lists.infradead.org; Mon, 16 Aug 2021 18:11:12 +0000
Received: by mail-pl1-x630.google.com with SMTP id e19so21624736pla.10
 for <linux-nvme@lists.infradead.org>; Mon, 16 Aug 2021 11:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=359DCNilpb4s8u7PB1WaF0dttEV4ZpDUiC3p9/mhbII=;
 b=NvUqIJNdHvKIYkQKFvZUOPBCAQphCwSpatECgnhsgFhY1y07wi9He04/e+dxtgMjxa
 kesyLeO3xV4/vXI4eP26aYhKqDfBeps2MJgAyP5bUd6Ja2MrDim1BBxNRoNTA+vwnOAQ
 xtGn23nXGnQQaSVLylMSHBU/NtOd7AV0kuZSCwDfSW5ilEaIBAW/ua0+XTqu8LLyD7ne
 zBcQlVPcr6Ge3rZqjcVdJH6YWwiEUYnqnIhDO8w5OzV3AOwDYNxjHZkwk0sCaO8W6eu5
 Sg5ot9oQKMwkIupUM+Y07M7moXXr/FmfhOb6lseZEV/GBmYaotvlY3itNicw1N89ocCg
 JAmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=359DCNilpb4s8u7PB1WaF0dttEV4ZpDUiC3p9/mhbII=;
 b=jasrq/wckrAMgs5P+7rqYOX5mpLhFI/w/9xdVNTkyGIfXcjBQibmIHWXjRvIAG+Oa7
 WYGoZ1nYUNIw96vRQx6fYlCLBp0hMNVKbZx7vxYOE0mruYA+rkhz/660ILSYbn+Gbrv6
 zYMsbVsxeyzqkVk990fc62koRL91HtEV0R2N2AryResoLzOO7CT9bDg4LYBCAUFRkjYV
 qBsy3W7GNT2tiVme0ARtukGp12hOrrDxbNADW/3FFUiUWYXQgIz8kPlT/JXlmKNPqbeS
 NIVNk/bsROMcXWhFLT1DPZYDbQNxNag4Q4Neyrzb8BksXEoZcxaBJdqymOD2LxC+a05d
 GmTQ==
X-Gm-Message-State: AOAM533Eb6//qUz74NV3opDeCoOKopULpJDd5W/Ko/GJsJNkMsSCkIK3
 8SwesCyc3Tk+5GH+je0NQXJ3EJnn7r6ufA==
X-Google-Smtp-Source: ABdhPJwvVjc5lLHu1PFGIJiTSfhwSEKWsDQSamejsLFv5Y7fhyk5ytIyDiQfa4h4CYef5iBCPjv4RQ==
X-Received: by 2002:a05:6a00:d41:b0:3e1:3316:2ef with SMTP id
 n1-20020a056a000d4100b003e1331602efmr50332pfv.40.1629137469464; 
 Mon, 16 Aug 2021 11:11:09 -0700 (PDT)
Received: from ideapad.. ([161.81.119.34])
 by smtp.gmail.com with ESMTPSA id z2sm80731pgz.43.2021.08.16.11.11.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Aug 2021 11:11:09 -0700 (PDT)
From: Tom Yan <tom.ty89@gmail.com>
To: linux-nvme@lists.infradead.org,
	hch@lst.de
Cc: Tom Yan <tom.ty89@gmail.com>
Subject: [PATCH 1/2] nvme: use UINT_MAX >> SECTOR_SHIFT for maximums in number
 of sectors
Date: Tue, 17 Aug 2021 02:11:01 +0800
Message-Id: <20210816181102.4412-1-tom.ty89@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210816_111111_220393_096E42AE 
X-CRM114-Status: GOOD (  11.84  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The block layer uses UINT_MAX for maximums in bytes.

Signed-off-by: Tom Yan <tom.ty89@gmail.com>
---
 drivers/nvme/host/core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index dfd9dec0c1f6..3a1bfb45da2a 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1640,7 +1640,7 @@ static void nvme_config_discard(struct gendisk *disk, struct nvme_ns *ns)
 	blk_queue_max_discard_segments(queue, ctrl->max_discard_segments);
 
 	if (ctrl->quirks & NVME_QUIRK_DEALLOCATE_ZEROES)
-		blk_queue_max_write_zeroes_sectors(queue, UINT_MAX);
+		blk_queue_max_write_zeroes_sectors(queue, UINT_MAX >> SECTOR_SHIFT);
 }
 
 static bool nvme_ns_ids_valid(struct nvme_ns_ids *ids)
@@ -2762,7 +2762,7 @@ static inline u32 nvme_mps_to_sectors(struct nvme_ctrl *ctrl, u32 units)
 	u32 page_shift = NVME_CAP_MPSMIN(ctrl->cap) + 12, val;
 
 	if (check_shl_overflow(1U, units + page_shift - 9, &val))
-		return UINT_MAX;
+		return UINT_MAX >> SECTOR_SHIFT;
 	return val;
 }
 
@@ -2773,7 +2773,7 @@ static int nvme_init_non_mdts_limits(struct nvme_ctrl *ctrl)
 	int ret;
 
 	if (ctrl->oncs & NVME_CTRL_ONCS_DSM) {
-		ctrl->max_discard_sectors = UINT_MAX;
+		ctrl->max_discard_sectors = UINT_MAX >> SECTOR_SHIFT;
 		ctrl->max_discard_segments = NVME_DSM_MAX_RANGES;
 	} else {
 		ctrl->max_discard_sectors = 0;
@@ -2883,7 +2883,7 @@ static int nvme_init_identify(struct nvme_ctrl *ctrl)
 	if (id->mdts)
 		max_hw_sectors = nvme_mps_to_sectors(ctrl, id->mdts);
 	else
-		max_hw_sectors = UINT_MAX;
+		max_hw_sectors = UINT_MAX >> SECTOR_SHIFT;
 	ctrl->max_hw_sectors =
 		min_not_zero(ctrl->max_hw_sectors, max_hw_sectors);
 
-- 
2.32.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
