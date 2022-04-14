Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3D8DC433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Apr 2022 06:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oLqGrj25r2MbM8WhVi8GcmQ077zx61cOBMj/X7zRjSM=; b=Atu2+k3kT1nvTtG75YG46vnLD2
	5tjs9JBaIIEcj3yHREVx1t/VhEOXZJ8P6wmJj+dwmSEMijxr43tCqL7zf0Lsra82qYqMIaeiSIFUc
	zonmbdPY3vTlGELrLhPxJQp0dcJKBfvvvpMd0xxnubz3YNq0N9eBiI135Z57EFPbYhrWuFQYeoJ/D
	Ce9byUFGuosIdA9kUgI4efDydg9eJ83qOxQAeU6jtQhmLNf86pBGBCbMMs2oj3FhAShvTEc9tH61d
	cAiDL466p6YakW7uWc072eRMFOKJnPVEVpQJEFo9+CPZIec8DwEVgMNN89zKSQaj/eLg2SOJxl9nJ
	kg+aZ81Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nesYr-0040RR-6d; Thu, 14 Apr 2022 06:02:33 +0000
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nesYo-0040Qr-NU
 for linux-nvme@lists.infradead.org; Thu, 14 Apr 2022 06:02:32 +0000
Received: by mail-pl1-x630.google.com with SMTP id n18so3838886plg.5
 for <linux-nvme@lists.infradead.org>; Wed, 13 Apr 2022 23:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=oLqGrj25r2MbM8WhVi8GcmQ077zx61cOBMj/X7zRjSM=;
 b=JweLIY/ZyNgg1eFNGYYXH5aCabc/gVrH1FQcWyvunCvGKplrv/5Erv4ozLkLKv7yWs
 Wzn8OCI/Nu4+yC+DwARr6oTwyRdIYV1/fRv+Un3rzy4C6oWcBxsBXo6PO37TumgmlGNW
 zRbmGemiHVmnDiI/cG7TZAqcPi7fsK+1bdWnQvICum0xD67D0SLijPKxqBDPqTzE6moE
 cbLy8CGI0E9k7WCmpGLN/FDKnP/rEPP896UAUO9e5Uu8qVpbkEKlmEvabvU6s/kjb91s
 97eGpnGLoyITPwfkOaTyoPTEKqJzP06m+zVMKdEM3hybHkthEPpTc4VZdMgfP7Pm3bSx
 IA1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=oLqGrj25r2MbM8WhVi8GcmQ077zx61cOBMj/X7zRjSM=;
 b=5GrfwIntbVl7kPy8d1aBRggHFLvHZcKrBnRA7e/p2JwJyc9QJK234EiOxuRFUpc3oe
 PfD94AT7gxxOH5tFGucbVUk1ltHhimktTncuOhVwp22XGAyeyAlxkWzQk0kvsecEKsCC
 +Q+Hxdkh8ANzWMwQx+iqo6W4QHcFUabJBUSY7BOQWcE2ihuYtzv+w2RGt3i90JmylFoV
 vtkGyIUwO+GYERPYIGReCsnUywVUSXUY4nkqFwTPvYGzfdpGdD2J3K3GbSKVLWaOcYpI
 LOcqKH5ZDMAbHZafsd3FJDkoqJUggvB+ZM5Ym7tU+Ep0b/PWIg0SNlzCTsiDaczc73hp
 kzLg==
X-Gm-Message-State: AOAM530J/ofL9sW2j+IdrjDUTsG0YyjEoUxW4P4ARCcU++z8WwqEysb7
 fOdC4TK8h6RhqE6wJIkOj5uCuwLzba8=
X-Google-Smtp-Source: ABdhPJwwQSDYiBSgapD5+MKoHwOZg+Mn4/YW/1eZdVLyiyWI+sVqbLvtZSBifkcwbcfiXyH1k+91dA==
X-Received: by 2002:a17:903:22ce:b0:158:38a3:d0db with SMTP id
 y14-20020a17090322ce00b0015838a3d0dbmr24744060plg.100.1649916145670; 
 Wed, 13 Apr 2022 23:02:25 -0700 (PDT)
Received: from archlinux.. ([161.81.112.246]) by smtp.gmail.com with ESMTPSA id
 y6-20020a626406000000b005060889f2cdsm883588pfb.191.2022.04.13.23.02.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Apr 2022 23:02:25 -0700 (PDT)
From: Tom Yan <tom.ty89@gmail.com>
To: linux-nvme@lists.infradead.org
Cc: Tom Yan <tom.ty89@gmail.com>
Subject: [PATCH] nvme: fix interpretation of dmrsl
Date: Thu, 14 Apr 2022 14:02:19 +0800
Message-Id: <20220414060219.361433-1-tom.ty89@gmail.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220413112056.126198-1-tom.ty89@gmail.com>
References: <20220413112056.126198-1-tom.ty89@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220413_230230_829515_FAA18ADF 
X-CRM114-Status: GOOD (  12.64  )
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

dmrsl is in the unit of logical block, while max_discard_sectors is
in the unit of "linux sector".

Signed-off-by: Tom Yan <tom.ty89@gmail.com>
---
v2: ignore dmrsl if its sector-equivalent is larger than UINT_MAX
---
 drivers/nvme/host/core.c | 8 ++++++--
 drivers/nvme/host/nvme.h | 1 +
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index efb85c6d8e2d..9d2f32739a15 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1622,6 +1622,11 @@ static void nvme_config_discard(struct gendisk *disk, struct nvme_ns *ns)
 	if (blk_queue_flag_test_and_set(QUEUE_FLAG_DISCARD, queue))
 		return;
 
+	int lts_shift = ilog2(size) - 9;
+
+	if (ctrl->dmrsl && ctrl->dmrsl <= UINT_MAX >> lts_shift)
+		ctrl->max_discard_sectors = ctrl->dmrsl << lts_shift;
+
 	blk_queue_max_discard_sectors(queue, ctrl->max_discard_sectors);
 	blk_queue_max_discard_segments(queue, ctrl->max_discard_segments);
 
@@ -2881,8 +2886,7 @@ static int nvme_init_non_mdts_limits(struct nvme_ctrl *ctrl)
 
 	if (id->dmrl)
 		ctrl->max_discard_segments = id->dmrl;
-	if (id->dmrsl)
-		ctrl->max_discard_sectors = le32_to_cpu(id->dmrsl);
+	ctrl->dmrsl = le32_to_cpu(id->dmrsl);
 	if (id->wzsl)
 		ctrl->max_zeroes_sectors = nvme_mps_to_sectors(ctrl, id->wzsl);
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 1393bbf82d71..1c85edcf7dbb 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -279,6 +279,7 @@ struct nvme_ctrl {
 #endif
 	u16 crdt[3];
 	u16 oncs;
+	u32 dmrsl;
 	u16 oacs;
 	u16 sqsize;
 	u32 max_namespaces;
-- 
2.35.1


