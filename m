Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C60B9CFA45C
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Oct 2024 17:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=KAqwEXuL60uoZxUd1v5VVfKn1HAkWPJgxn+fVoLGUkw=; b=qpzjXj9tQCEpUUDQb1Dk5LuItp
	EJVas33asH+X3uPO/WCnlwkmFcLUuJMo/k4revkmvH2QqoMOu9ByYzGGUQJaLHHNzJECEH82aCuZJ
	gpcyl0pXDTslDRQQZ5Z8tA2spsP9GLw3k+BzRarM7Qlt2OxR+oBp91MEmBn3sRNYnOE6uCMPRQHtJ
	hTwc7hx8t1KAuSIRtEiwPPwWy9w7smIfndUbFu1J72KbrDhgpx0MtAtvpwlSnACJBdUv2uD7/m0mW
	AZ/xJhUWpPBf0QDnGL04xLJxHqz/gLgqSMuxCDN6i2h5UJyqrdp+LHhSsVtyZgWkBO09GinKe8vac
	xduj3QAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t3fMD-0000000FP8t-3A6P;
	Wed, 23 Oct 2024 17:41:17 +0000
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t3efV-0000000FFAA-159I
	for linux-nvme@lists.infradead.org;
	Wed, 23 Oct 2024 16:57:10 +0000
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-2e3fca72a41so59463a91.1
        for <linux-nvme@lists.infradead.org>; Wed, 23 Oct 2024 09:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729702627; x=1730307427; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KAqwEXuL60uoZxUd1v5VVfKn1HAkWPJgxn+fVoLGUkw=;
        b=DBbwyklZUs6OldWKJ9sqWe5RQVaXTOzFkqwXEPJeO3RAB58m16RMWYpFRCZmJodl0e
         WMPL4OnYvoEdLXPCyeFOCuqWgWaPCyqr4iQDnv4/mkW9o2s9tEXA7sAns4L2u3pY7afA
         CFpv4PCzDBQUf4IKH9AJCFXmIs1vFX94MC8KIgemBMLMZ/BBwSJmegVcE7DzZrSMS+VP
         1xHDAevgdYBnS/FQ9ULwSsj41aIFWyZgZHBRhyorLHRuvI04yeg4l3RE8g5F+bvxQzoS
         47kAwzxmmbCd/BBx0Pvtwj2LBpeqUwRC+vrZjRsKYbEcYqcbQhyzPbP9LxkW8j2Fyap9
         7NRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729702627; x=1730307427;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KAqwEXuL60uoZxUd1v5VVfKn1HAkWPJgxn+fVoLGUkw=;
        b=OEFxvlC6uYMcob+9LOwiMZSwJ/P7zKqJ5tSBpDcKjXYshs2gpLYrlHaVKqqYZjYC+3
         iHQIATAIvgv2Wc7b4kgIjRaKg3J8EqB5YqsuwPb+9CKP9V7Bq8vdvR90EjWNW4EnO062
         ABvtittClrF4rIxR4nwJBrgDlbPXq8irsodvjqkzu8akjmChMxKmvkNAan0/xgiZY1fe
         WQjUnHcJrcVsf+dMO6Smd4SlTf5ErYCmjvywBVDbD3pm4XOKAC9F+ygbH3MdC0tH7Xhw
         ruWe2k6f4YaWxgBmSrXUNgebpm7/f/hnnExox6mnUSKMqlcreE2ez41i90PhdvOploOL
         w3Tg==
X-Gm-Message-State: AOJu0YyTKJ2KmKP8588UXryPlVcbq7947CQ+sf9G2QS5X9CexRIGTQpf
	qHNnnEsmUwMr/CQrggu84qYlNsQhT2fzCSW4kd5/y0XiUxLzoptExMAe+w==
X-Google-Smtp-Source: AGHT+IGBLzbYKa7a6LdebK6KI70px9xkVZSSsZU19IeEYvA/GsulOwFwjhBUQIHoGIaeYfpVikSLgQ==
X-Received: by 2002:a17:90a:e389:b0:2e2:ba35:3573 with SMTP id 98e67ed59e1d1-2e76b60d445mr3551587a91.20.1729702627368;
        Wed, 23 Oct 2024 09:57:07 -0700 (PDT)
Received: from tokunori-desktop.flets-east.jp ([240b:10:2720:5500:2599:5aa5:a0f:e0fd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e76e05b775sm1670230a91.46.2024.10.23.09.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 09:57:07 -0700 (PDT)
From: Tokunori Ikegami <ikegami.t@gmail.com>
To: linux-nvme@lists.infradead.org
Cc: Tokunori Ikegami <ikegami.t@gmail.com>
Subject: [PATCH v5] nvme: rename nvme_ns_has_pi() to nvme_ns_supports_pract()
Date: Thu, 24 Oct 2024 01:56:51 +0900
Message-ID: <20241023165658.23375-1-ikegami.t@gmail.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241023_095709_349062_6F355E92 
X-CRM114-Status: GOOD (  17.66  )
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

It checks if supports metadata actions by the controller (generate/strip).
So change the function name as so correctly.
  Note: It is only supported when the metadata size and PI size are same.

Signed-off-by: Tokunori Ikegami <ikegami.t@gmail.com>
---
Changes since v4 to v5:
- Delete to change the ms >= PI check so just only the function name changed.

Changes since v3 to v4:
- Change the function name nvme_ns_has_pi() to nvme_ns_supports_pract().

Changes since v2 to v3:
- Delete the nvme_submit_io() changes as only change the nvme_ns_has_pi().

Changes since v1:
- Fix the commit message spelling miss hte to the.

 drivers/nvme/host/core.c | 12 +++++++-----
 drivers/nvme/host/nvme.h |  2 +-
 drivers/nvme/host/rdma.c |  2 +-
 3 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 84cb859a911d..5a7f7ce2bc49 100644
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
@@ -1929,14 +1929,16 @@ static void nvme_configure_metadata(struct nvme_ctrl *ctrl,
 
 		/*
 		 * The current fabrics transport drivers support namespace
-		 * metadata formats only if nvme_ns_has_pi() returns true.
+		 * metadata formats only if nvme_ns_supports_pract() returns
+		 * true.
 		 * Suppress support for all other formats so the namespace will
 		 * have a 0 capacity and not be usable through the block stack.
 		 *
 		 * Note, this check will need to be modified if any drivers
 		 * gain the ability to use other metadata formats.
 		 */
-		if (ctrl->max_integrity_segments && nvme_ns_has_pi(head))
+		if (ctrl->max_integrity_segments &&
+		    nvme_ns_supports_pract(head))
 			head->features |= NVME_NS_METADATA_SUPPORTED;
 	} else {
 		/*
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 093cb423f536..7f31e085f6a0 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -540,7 +540,7 @@ struct nvme_ns {
 };
 
 /* NVMe ns supports metadata actions by the controller (generate/strip) */
-static inline bool nvme_ns_has_pi(struct nvme_ns_head *head)
+static inline bool nvme_ns_supports_pract(struct nvme_ns_head *head)
 {
 	return head->pi_type && head->ms == head->pi_size;
 }
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


