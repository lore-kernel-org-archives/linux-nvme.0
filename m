Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67526CDDE5B
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Oct 2024 10:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=hgv6ibUPlu4ZwfyJFrpCjpJtljpJPmbw1Srcxa74IM0=; b=TgAd4sQQmLDKqQej4SC6fbZ4gy
	jnIJjw/5lMh5VATXf8JFV2aYDSSsKrQu5X8td6XV1in6IRFen+AcbgMnUMzAs1l+2jxr12tAmZ9Vk
	+FWenr1nkTFksmyodJv2GYvzvFvb3q5YQDfG4dOEJLQ1WmpCveLwtuWY8PLipD4g0Qj2/32cL/JuT
	t+yOLk3ows++7+x5G8aVIi7ptGD29IsjzyRnRGWzHUxYlX/KAfIB3W2DTeJj0MEADZhxnnkdldh+v
	vGKpaFjQzaVwPQe7AhxXQj4UBTNjSQgLilcqDw03K4PHBTKUcynjzNhXBprEHahPA/yjhOQCIegug
	/qqwAOkA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t3YTM-0000000Dxdh-1t7f;
	Wed, 23 Oct 2024 10:20:12 +0000
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t3YIr-0000000Dvmb-116c
	for linux-nvme@lists.infradead.org;
	Wed, 23 Oct 2024 10:09:22 +0000
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-20b5affde14so46396655ad.3
        for <linux-nvme@lists.infradead.org>; Wed, 23 Oct 2024 03:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729678160; x=1730282960; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hgv6ibUPlu4ZwfyJFrpCjpJtljpJPmbw1Srcxa74IM0=;
        b=m86on0Fs45Th80TSSf1DAV5SCTKsjS+4IFLMNvShnSc+yjq/8tf8iMVpwwFfHRwkwD
         Yxt9Lkx/HOpC7AcxhWjWEWEI77H75c+5n/yUHjIB16+9RjgVBRYUG5G5KH6+zJMVfgat
         SbJdVi3UcLCHmZj2fO2PmIIPzRmgoSqezDjVoDuXIDm2Fx8+a9yUWkPXeLc1UcyZl0R/
         U/BRxvZ3yWELZLTMj/KH9fp3a7kGALIfc9pn4OEcFykRcpMD43XnptQHshjUrSUHRtgT
         BMYjqOg3F0lyFMXT6DMch8BsAktF4bqlVi+aVUkvZLjSwkOs9/4JP7QtHgwIfGjCx9LH
         L4xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729678160; x=1730282960;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hgv6ibUPlu4ZwfyJFrpCjpJtljpJPmbw1Srcxa74IM0=;
        b=OIoX7TdQ5vOS8LlhbTNZxNxh4/5P3ko3YoyAqAARYAxHSUX6xCHwwwRHrKZFpjv3lS
         /hL1ThnCByRCUfT1xh3UjkUNlGb5HkzeG48w8baImmYPGGPDafa51Gmve/YVIH5L2dWE
         I0RrhNPS5+i2Yu/NL8cuDyoDjhXP999CDdv0jD+v+eYM6cH9vTQkoRiBZFcgj480br2R
         6/wL2DMTSPMRe2QX9Oab7KGt56WCt3Oc/+Jfl56oqPNm1qoRNmOs/p1QAaw+apgxvqH1
         YGW137bXs260XETZ8uUqC0/7fFRjesUYxoOC2DgWGPl8xsdTT115mWqC9A2bZDPKyV7U
         R6xw==
X-Gm-Message-State: AOJu0Yw2Td7Pg7dkonI+aCknZSEfIIQXAXuL1WRcLzIKz+nU+AmaIL0h
	zWSHn8tPfuaJVnykObocCRdZdAdrRE+xgTfuGJsFusOyt3jg0gwkrvwnWQ==
X-Google-Smtp-Source: AGHT+IED6cplJRChyoFndrIhnjwNXfXqTG4+Aw0LjB3oNBOKXopsdilMSI9DNmGYQ7II3Ns/E9wSBg==
X-Received: by 2002:a17:902:d4cb:b0:20c:f0dd:c408 with SMTP id d9443c01a7336-20fa9e1fb9bmr32369175ad.20.1729678160011;
        Wed, 23 Oct 2024 03:09:20 -0700 (PDT)
Received: from tokunori-desktop.flets-east.jp ([240b:10:2720:5500:2599:5aa5:a0f:e0fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7f0bd2cesm54691685ad.127.2024.10.23.03.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 03:09:19 -0700 (PDT)
From: Tokunori Ikegami <ikegami.t@gmail.com>
To: linux-nvme@lists.infradead.org
Cc: Tokunori Ikegami <ikegami.t@gmail.com>
Subject: [PATCH v4] nvme: change nvme_ns_has_pi() to nvme_ns_supports_pract()
Date: Wed, 23 Oct 2024 19:08:36 +0900
Message-ID: <20241023100915.11263-1-ikegami.t@gmail.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241023_030921_301881_570FA06F 
X-CRM114-Status: GOOD (  19.04  )
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
Then fix the function to check PI size if metadata size or below.

Signed-off-by: Tokunori Ikegami <ikegami.t@gmail.com>
---
Changes since v3 to v4:
- Change the function name nvme_ns_has_pi() to nvme_ns_supports_pract().

Changes since v2 to v3:
- Delete the nvme_submit_io() changes as only change the nvme_ns_has_pi().

Changes since v1:
- Fix the commit message spelling miss hte to the.

 drivers/nvme/host/core.c | 10 +++++-----
 drivers/nvme/host/nvme.h |  4 ++--
 drivers/nvme/host/rdma.c |  2 +-
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 84cb859a911d..37edd0ba423d 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -915,7 +915,7 @@ static inline blk_status_t nvme_setup_write_zeroes(struct nvme_ns *ns,
 	    (ns->head->features & NVME_NS_DEAC))
 		cmnd->write_zeroes.control |= cpu_to_le16(NVME_WZ_DEAC);
 
-	if (nvme_ns_has_pi(ns->head)) {
+	if (nvme_ns_supports_pract(ns->head)) {
 		cmnd->write_zeroes.control |= cpu_to_le16(NVME_RW_PRINFO_PRACT);
 
 		switch (ns->head->pi_type) {
@@ -999,7 +999,7 @@ static inline blk_status_t nvme_setup_rw(struct nvme_ns *ns,
 		 * namespace capacity to zero to prevent any I/O.
 		 */
 		if (!blk_integrity_rq(req)) {
-			if (WARN_ON_ONCE(!nvme_ns_has_pi(ns->head)))
+			if (WARN_ON_ONCE(!nvme_ns_supports_pract(ns->head)))
 				return BLK_STS_NOTSUPP;
 			control |= NVME_RW_PRINFO_PRACT;
 		}
@@ -1766,7 +1766,7 @@ static bool nvme_init_integrity(struct nvme_ns_head *head,
 	 */
 	if (!IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY) ||
 	    !(head->features & NVME_NS_METADATA_SUPPORTED))
-		return nvme_ns_has_pi(head);
+		return nvme_ns_supports_pract(head);
 
 	switch (head->pi_type) {
 	case NVME_NS_DPS_PI_TYPE3:
@@ -1929,14 +1929,14 @@ static void nvme_configure_metadata(struct nvme_ctrl *ctrl,
 
 		/*
 		 * The current fabrics transport drivers support namespace
-		 * metadata formats only if nvme_ns_has_pi() returns true.
+		 * metadata formats only if nvme_ns_supports_pract() returns true.
 		 * Suppress support for all other formats so the namespace will
 		 * have a 0 capacity and not be usable through the block stack.
 		 *
 		 * Note, this check will need to be modified if any drivers
 		 * gain the ability to use other metadata formats.
 		 */
-		if (ctrl->max_integrity_segments && nvme_ns_has_pi(head))
+		if (ctrl->max_integrity_segments && nvme_ns_supports_pract(head))
 			head->features |= NVME_NS_METADATA_SUPPORTED;
 	} else {
 		/*
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 093cb423f536..881418444a1a 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -540,9 +540,9 @@ struct nvme_ns {
 };
 
 /* NVMe ns supports metadata actions by the controller (generate/strip) */
-static inline bool nvme_ns_has_pi(struct nvme_ns_head *head)
+static inline bool nvme_ns_supports_pract(struct nvme_ns_head *head)
 {
-	return head->pi_type && head->ms == head->pi_size;
+	return head->pi_type && head->ms >= head->pi_size;
 }
 
 struct nvme_ctrl_ops {
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 24a2759798d0..e09fee1dd15c 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -2037,7 +2037,7 @@ static blk_status_t nvme_rdma_queue_rq(struct blk_mq_hw_ctx *hctx,
 	    queue->pi_support &&
 	    (c->common.opcode == nvme_cmd_write ||
 	     c->common.opcode == nvme_cmd_read) &&
-	    nvme_ns_has_pi(ns->head))
+	    nvme_ns_supports_pract(ns->head))
 		req->use_sig_mr = true;
 	else
 		req->use_sig_mr = false;
-- 
2.45.2


