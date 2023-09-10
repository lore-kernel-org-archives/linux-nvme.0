Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58B21C71153
	for <linux-nvme@archiver.kernel.org>; Sun, 10 Sep 2023 21:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=G3vyDGkHhGIgt9tKpS+4PfIZn5WSsDuTIQeg67GIK70=; b=NywgxooJeVZVV6panvzlUIWhAQ
	6c2dbc9ZBJWowsK9g6L6722RFZCxkEBJryofiRmHzA2kMe3xKYm1v9YB2pn03rANEMd3lsdmX+ejc
	aj/ImHXxqL5CE1P0saEK+IcpfRu5TgKpW1Q+YHlXONru1erOSD7F8rG9oLSHbG/lsKACmRD5leOJ8
	LsNW0/v32xQsZLYMAz1pW3ZHxBLI4Ru7MnS+Qs3D/BWOC98whT9+jdomGzSt2O74H2DhLtV1/IcVo
	euxUpNy3rsHtQvFaW5/YzgVX5bcxrpVQrDHshPbxuSNiqpgIpmeTxSYGi9j0G5BuOB80A0Z1EMHmX
	T15GQF8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qfRxm-00GuZt-08;
	Sun, 10 Sep 2023 21:27:26 +0000
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qfRxh-00GuZF-0L
	for linux-nvme@lists.infradead.org;
	Sun, 10 Sep 2023 21:27:22 +0000
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-5921a962adfso36946787b3.1
        for <linux-nvme@lists.infradead.org>; Sun, 10 Sep 2023 14:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ixsystems.com; s=google; t=1694381236; x=1694986036; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G3vyDGkHhGIgt9tKpS+4PfIZn5WSsDuTIQeg67GIK70=;
        b=HxwZ7jhc6vYVMPeCKkKz+WXB86j5eJ4yTlAm4iHPSgiOpKbU1XZDUstnK8hseaLgod
         UKOzReM8jF8YvFa1zNfqWd/Ob3c/J0M53cpIxvcNN7JpzrfRYKm0flv7QCEqM7Mmvv3T
         q01q2dIcqTNdWHkJyPWwKVnht3SWAoazQ8127yFpn0sfy/TPrLU3+RINTo+fYcfpa8En
         BNs1ELex0BtLvmTeP60Aw1102vqVA5Ko3HosZz7fsVXQrm6rtZ6ssmgzPejJBMKhfHTq
         sKREIk8nj7cHmoYIMCQ0qPJ92OwhaXUKNeW9uVYonP00TSat6S3Mi6MfDVC6uwayBYVA
         AGAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694381236; x=1694986036;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G3vyDGkHhGIgt9tKpS+4PfIZn5WSsDuTIQeg67GIK70=;
        b=U2R9K2ATfDADMiaSGKjD2xJIMc0FQn/wW+tB8sHzbJquVrBP0aSlhBP2Yjzgv/ZwO6
         68hUYQmARe5GvDZsyIkxokEuLz1lPnOSQttQUwoziEgMLnlmJgx9KcirnFESB5qWJ+gF
         779o6MkQ5krXpuvwGxoCI7x7F4AMLjH4yIlobQB3WRow5Wc+N7HHZOkJTGUXRg2cKpU3
         AzAZheXZnZ31R+587/7+i3hiStt47A0VO1YjK++H0Y+Jd0h94ygdSBrl4vepT295ofxc
         uXNaFZShbNn6IAM/t9+OkpibIzRu4ACmngx8qXlqCX962hKWvhbcNCZFKW875hwvTmxh
         YNKw==
X-Gm-Message-State: AOJu0YxJ0Y6Ct4bToN3OmOKdsCx9owc0c0xKXI5IC1RHuR1zAyhCJC2s
	GxuD7FTJ+LLQEmgL4fesl4D36Lbu3+p45Iflpld7p+zf3Ggb2ls9wIBrZUVKub9zGNaBmfwIROS
	rAbblyEPO4kTSZUojE/b4Tck3wQk5JoQShUncc9QPceG/MDbC/O8SenSSq9qpayTXpjEcff+/UB
	19gUiPYajULA==
X-Google-Smtp-Source: AGHT+IGdJ6M/MVpvzq9gg72gcpDLWx5bSBtAOXQLOr5GqodlmWOPUBZjXiPZ6TaYXYKGjwctfihBuQ==
X-Received: by 2002:a81:4e90:0:b0:59b:4675:29c6 with SMTP id c138-20020a814e90000000b0059b467529c6mr10301423ywb.9.1694381236266;
        Sun, 10 Sep 2023 14:27:16 -0700 (PDT)
Received: from hamza-pc.. ([202.47.34.142])
        by smtp.googlemail.com with ESMTPSA id r204-20020a815dd5000000b0058e37788bf7sm1602054ywb.72.2023.09.10.14.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Sep 2023 14:27:15 -0700 (PDT)
From: Ameer Hamza <ahamza@ixsystems.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	linux-kernel@vger.kernel.org,
	mav@ixsystems.com,
	edmund.nadolski@ixsystems.com,
	ahamza@ixsystems.com
Subject: [PATCH] nvme: prevent id ctrl csi for specs below 2.0
Date: Mon, 11 Sep 2023 02:26:41 +0500
Message-Id: <20230910212641.338438-1-ahamza@ixsystems.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230910_142721_245001_3BE0EF66 
X-CRM114-Status: GOOD (  14.03  )
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

The 'id ctrl csi' command was introduced in version 2.0, as specified
in Section 5.17.2.6 of the NVME Base Specification 2.0. Executing this
command on previous NVMe versions returns an "Invalid Field" error,
and the error entry is saved in the log page. Although, Commit
c917dd96fe41 ("nvme: skip optional id ctrl csi if it failed") reduced
the error occurrences, but the error persisted during the initial
module load. This patch ensures the command isn't executed on versions
older than 2.0, and it also eliminates the skip implementation because
NVME_ID_CNS_CS_CTRL is expected to succeed with version 2.0.

Signed-off-by: Ameer Hamza <ahamza@ixsystems.com>
---
 drivers/nvme/host/core.c | 6 ++----
 drivers/nvme/host/nvme.h | 3 +--
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f3a01b79148c..6c92aa5704f9 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2894,9 +2894,9 @@ static int nvme_init_non_mdts_limits(struct nvme_ctrl *ctrl)
 	else
 		ctrl->max_zeroes_sectors = 0;
 
+	/* NVME_ID_CNS_CS_CTRL is supported from v2.0 onwards. */
 	if (ctrl->subsys->subtype != NVME_NQN_NVME ||
-	    nvme_ctrl_limited_cns(ctrl) ||
-	    test_bit(NVME_CTRL_SKIP_ID_CNS_CS, &ctrl->flags))
+	    ctrl->vs < NVME_VS(2, 0, 0))
 		return 0;
 
 	id = kzalloc(sizeof(*id), GFP_KERNEL);
@@ -2918,8 +2918,6 @@ static int nvme_init_non_mdts_limits(struct nvme_ctrl *ctrl)
 		ctrl->max_zeroes_sectors = nvme_mps_to_sectors(ctrl, id->wzsl);
 
 free_data:
-	if (ret > 0)
-		set_bit(NVME_CTRL_SKIP_ID_CNS_CS, &ctrl->flags);
 	kfree(id);
 	return ret;
 }
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index f35647c470af..f3cf10710bce 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -249,8 +249,7 @@ enum nvme_ctrl_flags {
 	NVME_CTRL_ADMIN_Q_STOPPED	= 1,
 	NVME_CTRL_STARTED_ONCE		= 2,
 	NVME_CTRL_STOPPED		= 3,
-	NVME_CTRL_SKIP_ID_CNS_CS	= 4,
-	NVME_CTRL_DIRTY_CAPABILITY	= 5,
+	NVME_CTRL_DIRTY_CAPABILITY	= 4,
 };
 
 struct nvme_ctrl {
-- 
2.39.2


