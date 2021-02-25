Return-Path: <SRS0=GtbF=H3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2BCCC433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Feb 2021 10:58:11 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CB8164EF5
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Feb 2021 10:58:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CB8164EF5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=dVRfBzwUdDH8qsB2Q0a2kPEUvEPCkZ4KBMHOx/96Zr0=; b=ArPxYnPQJ9HCoPMFsNa2KwX69w
	LblCIkhefQHQ0GRuQDyHG52+tFfRRws+9NIJ+RuSTZGsQ+w4jVoP8IzA9LAoq7sc+og7PhP4vCaw6
	7Tte5SNyNMydITk+KTL21MCRvJTgYm+uIiUotPzKf66Cmxpu6TcCSOpw1WETiftQ+BGdeEmvxBU4P
	fFLGNxw+2VngCTRWkme/eUFFGfP8FKDV5ogyZ1lxiF/wR1Cwwx+fL59bh9eool9dBRGOs4o8KIaSS
	iPGfYs7NIpdWjtADcXlMuUAb36OAr8rSjS+W+x13gsSchVZWzfVKsJrEGktcfD0TO7gt7vqC5/Tpe
	s3gdw4jA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lFELG-0005pO-77; Thu, 25 Feb 2021 10:57:58 +0000
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lFELC-0005o6-P2
 for linux-nvme@lists.infradead.org; Thu, 25 Feb 2021 10:57:55 +0000
Received: by mail-pj1-x102a.google.com with SMTP id l18so3315529pji.3
 for <linux-nvme@lists.infradead.org>; Thu, 25 Feb 2021 02:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=86C4G0hPTr8UvqM+4CwZofpqp7vUR5uMaTUxaI0NQHM=;
 b=Zm/rFAOnu507CG8dZQ7iu2GAaUEm3FWkZ6d9Iz0xPeS1auT0iDyNa0YPJPGbK24kLH
 sbAROa1FgOXMYFZjnpSQ6UyXOttriT1SaUG7ZMdSb30Vy5Dl+a50ClXYCzBhGedxOUwA
 Ai1o7BLpd7e5Gco7utAME1vM/4YzwyU/k+yqXdjEePGq2QkhiKMI+gs51/8eQB4n8QIm
 i3GIYnwrY36Dis3+7Rmb6z+rAxmYP7cFrRmwmlTImCxl2x7JB+FzH+BC8inJNfl/Z8me
 wzxmPjAn7uLv6Ie5VdrWrpaDP9BmHfyUQ2g+oM+WWFF7Zaw7+J183lT2ugieqdaRdhuo
 lSPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=86C4G0hPTr8UvqM+4CwZofpqp7vUR5uMaTUxaI0NQHM=;
 b=rA+BEHpvKNNWMqi6MlIEtpxZ/i5fTNa2MBSphh7TpkDTHKOL8/WUcLFJvDyQDNaPWt
 QKjSu9C9A+vK3PnPjd1Z/YchyMV4UYCbK17fP/8B/V2b/crabzLipBtyMocryjyjdywc
 bxQ908OTZZqq6UM9zUH+fBBJXAfWs6jRkFCvEGv44BGmyan/TT/DseROy+Zrwe4/s2a0
 uGSu2z4LZzAblCdkMU0uqItLglIBiqb4AAUbziLbKbLUsDRlxaPV4OLAp62MFWonAxVE
 T5kS+VCnHMsr6QovQJA16pVZ/NngUz+9Hy6xJ7mN6V25OwBVqK37epM0vssmCm6YlTAr
 XXow==
X-Gm-Message-State: AOAM530Y02pQK5UrNxNKu40tdfRweJxQft4qbe/1yvO+HGuYQJZj5CYa
 E1tsWY30EsLkpPkCiQeuwYPh/CAPlZA7Ww==
X-Google-Smtp-Source: ABdhPJxm6cB+BSS+1cIQCg0nd5p4Zg11fP2voJZS1qIL1TJWbxGnG+E85OWq6GfFGtQvvrGRaoOfNg==
X-Received: by 2002:a17:902:b902:b029:e4:156d:68be with SMTP id
 bf2-20020a170902b902b02900e4156d68bemr2612257plb.19.1614250672426; 
 Thu, 25 Feb 2021 02:57:52 -0800 (PST)
Received: from localhost.localdomain ([211.108.35.36])
 by smtp.gmail.com with ESMTPSA id z11sm5483372pgc.6.2021.02.25.02.57.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Feb 2021 02:57:52 -0800 (PST)
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH] nvme-multipath: use nvme_ctrl_use_ana helper to check ANA
Date: Thu, 25 Feb 2021 19:57:44 +0900
Message-Id: <20210225105744.69579-1-minwoo.im.dev@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210225_055754_853038_F9B55C42 
X-CRM114-Status: GOOD (  14.08  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Minwoo Im <minwoo.im.dev@gmail.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Call nvme_ctrl_use_ana helper to check whether the given controller uses
ANA or not.

Signed-off-by: Minwoo Im <minwoo.im.dev@gmail.com>
---
 drivers/nvme/host/multipath.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index c658b73a41b7..bbb582b12226 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -82,7 +82,7 @@ void nvme_failover_req(struct request *req)
 	 * ready to serve this namespace.  Kick of a re-read of the ANA
 	 * information page, and just try any other available path for now.
 	 */
-	if (nvme_is_ana_error(status) && ns->ctrl->ana_log_buf) {
+	if (nvme_is_ana_error(status) && nvme_ctrl_use_ana(ns->ctrl)) {
 		set_bit(NVME_NS_ANA_PENDING, &ns->flags);
 		queue_work(nvme_wq, &ns->ctrl->ana_work);
 	}
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
