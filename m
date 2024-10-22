Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B4D0CDD0D1
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Oct 2024 19:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=c+8uGdgHzZO9AeZqvtTvUKqTqLZYpMEq6ysn9KoI0rA=; b=Skus40CpyiI0ZKCNS9MW2ncn/s
	K5qPKp9PBUPMHUaxDKWQMnyK3c1elvVpzO18MQN+82PFVW0MbPPIsf2w87WbD89Hgy/hvxjmBwtpJ
	kSk1so3sgkkVg5Fq46ZPeSyNfbhQ4ydLvlydMdWzL593/s/bvPx/u5MRpUSe9HhoP+CTDZyOEe1Ke
	Y1XAR7dxd/5RZAMUE7sbBqDH4Eu/A52X7Zid1RAxoOCQJ7qm6EI0jkSs/tMGnC7SwyOmercrr3Qfb
	0ncuWCexG+0bo2XsautCeY3gr/69lJ5IE6xLj3EUP9Q/5aU2c/7nVWXtO0wqLuaTIzfTCnfvhUpj4
	WU5zoY8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t3KM3-0000000BuB0-3mlG;
	Tue, 22 Oct 2024 19:15:43 +0000
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t3JM3-0000000BmI4-30YD
	for linux-nvme@lists.infradead.org;
	Tue, 22 Oct 2024 18:11:41 +0000
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-20cb47387ceso53504665ad.1
        for <linux-nvme@lists.infradead.org>; Tue, 22 Oct 2024 11:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729620698; x=1730225498; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c+8uGdgHzZO9AeZqvtTvUKqTqLZYpMEq6ysn9KoI0rA=;
        b=O7+9U+eyY3dqnURuwdhu5R5o+tCwoxMT7j5lOjzjTc68Ybyb17NzQpDjpiXkgAwo2L
         xyGokZW3rUzh6tipIZ2/cpls9+ObmgmCUN7xDFR80e4pvDRPpQKBxK3k7r0NdB10n48g
         gh7k9FoJ199geKaQpq2jI61wKSCj0a5MVKJuh+BNfw8qLw9qVCA4N5a/bxs7p+bK9i2f
         woUe9DWRo94I5oO5WX205W9e50WxSGtsEHukwY/GaSY+ZerRmoQgrlrMmilT5KwtEdBv
         6GSd9if7sArRp70q/VFYESqKvDY7O4c+Eho0OhF0zbynInc4G6UiG/IRXpVSouM+viQx
         VeLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729620698; x=1730225498;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c+8uGdgHzZO9AeZqvtTvUKqTqLZYpMEq6ysn9KoI0rA=;
        b=nsRb+UPTZ17PXDvZGb7renYvLGn6t/o9qhlzyK0CIWuXHdus+VEinStmTiaI3RlsiL
         6wEXx3Xq9isKwT37FOG0DrO6Ulzk99gJZ8i97vuYExwnfwgWmUBoIs9ThSVVi+dWkFlA
         9YC1VH+cLrGl2yTSraT0tk9KhQpeMpTVjUZrtKJug5jY0tl0WehQS/AIecpuQOXIjLWa
         f3OmFwWttIy7B2QjA/o0yMWgjnUGmPfzSfakP2HcwgmgOljGs3I9undNnXY4mXiyotUo
         11gKzbNARyJvCrHw0x586E6Zvm7gYX7n7u/7B+3yQn38Ds6xcB9G1pmDEfZipOUyCE7k
         9Hog==
X-Gm-Message-State: AOJu0Ywextaebg5wmndk9C8cUIa57/jbEI09P3b/08j1T8z7lEk8Lx65
	a63pZWgL46kZyV+Wc5rJYRstTdn1JNLkpZb3pVjGtIzHvKL46GRGaPT90Q==
X-Google-Smtp-Source: AGHT+IGsNHl7PONCzJFWv2BnZqBK9Q7mXM+xOk9VBOagdwjFRRizjFaH9x1PqmQJTijDMGCOwF1JJA==
X-Received: by 2002:a17:903:1c4:b0:20c:7a0b:74a5 with SMTP id d9443c01a7336-20fa9ea1583mr15355ad.39.1729620698303;
        Tue, 22 Oct 2024 11:11:38 -0700 (PDT)
Received: from tokunori-desktop.flets-east.jp ([240b:10:2720:5500:f6f1:2f90:dd68:7e46])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7ef08c4asm45525645ad.80.2024.10.22.11.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 11:11:38 -0700 (PDT)
From: Tokunori Ikegami <ikegami.t@gmail.com>
To: linux-nvme@lists.infradead.org
Cc: Tokunori Ikegami <ikegami.t@gmail.com>
Subject: [PATCH v3] nvme: fix nvme_ns_has_pi() to check PI size if metadata size or below
Date: Wed, 23 Oct 2024 03:10:54 +0900
Message-ID: <20241022181132.19871-1-ikegami.t@gmail.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241022_111139_782176_90C0A937 
X-CRM114-Status: GOOD (  13.75  )
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
Changes since v2 to v3:
- Delete the nvme_submit_io() changes as only change the nvme_ns_has_pi().

Changes since v1:
- Fix the commit message spelling miss hte to the.

 drivers/nvme/host/nvme.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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


