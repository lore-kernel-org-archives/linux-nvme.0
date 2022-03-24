Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8E6CC433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Mar 2022 00:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=N/4hcQ2XyjzgQEqcQ2RrltKuHGCDEo3rwulTaaoLSBc=; b=lQgdDRCWa2Lz9CQsRSz2NBZhpa
	d/lUA8LcD9dBiIsEilGx0Pl7IxCNCJvJ+lRtFiIrieFY/vqYXUfjrQkyU7uoQ0lAR8+AStqQOOpVc
	AhFk1ZqycftUA/jtQpuAs1guCfxp7YnBzIf6Tet6tAMq7fBPYYsVoPRRpMabTT+X4NBUs81Swk1TN
	IMMY/o48EBgcVhsWi49luiX2UWBKULRCU+o3+JhkJUUAYHqBNWWBDN15VBFMq/S4maSDzd4WrW6Z8
	5CeMJbwSh1eA1hItpSbfqzyK/uvnaf+RzXDGdX6Q/XRXOdyEe30Q0jFq5RlYACCvxmP0VhZHpdmHf
	HPlYpVTA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nXBVs-00FDeS-Gs; Thu, 24 Mar 2022 00:39:40 +0000
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nXBVp-00FDdc-Pt
 for linux-nvme@lists.infradead.org; Thu, 24 Mar 2022 00:39:39 +0000
Received: by mail-wr1-x429.google.com with SMTP id r13so4418588wrr.9
 for <linux-nvme@lists.infradead.org>; Wed, 23 Mar 2022 17:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=N/4hcQ2XyjzgQEqcQ2RrltKuHGCDEo3rwulTaaoLSBc=;
 b=pJnSqIo+b+tQqMKhbtabz8MrUfYXD465cRwgHlbmcuJTcSAOJsdomaF7+886fZtHrO
 Jli5vS6saTMv99zT3lBcB50M0SjAxAEs8a/70k9qrqez8QkHFxbdzcLYlmBMqYfsYTPJ
 +6pqkSdlgLdZEuNl4wYsWui7wx3qiNeMb98mTpWw9sTHlTkUiKbAZ8EdqAOK/GZ0j5Ob
 rqSQ+R86MAQzLmhTPIrhEmau8DHDs4ZOSyYStXXtlPRbA4wSDABrmuihepH56AOaDq4j
 kKtraPTlWOjQ35DI16vtP5lshS8DND4OTcFCL+Wk9Y1qy9FBSijnSYyzqPTi9hErMPlo
 MB/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=N/4hcQ2XyjzgQEqcQ2RrltKuHGCDEo3rwulTaaoLSBc=;
 b=rK/l7OId/ND7JHkNXIac5v73Z0T9zFW6cv5pZsjjxDhIBRzNG7GrMMvQcm2jnyyWta
 qXIqAxsHphuYTATvVX7gnu8focp3bM4SvBmWmsRyqtqV+ha9CXMByy7TA5XNFE0ZgGnS
 /UjgcfmYQ+tHxMX1u86MKZzyRkNFyHi2AO65QNXJXVaP6lXur5pmnltJ9AyKU/O1QjA6
 9ZT+QX7ZpyMEayjj+E7MHbIg+bc+8Ic+qmzYerQRwosCAGgo9cmysYberP7Fyhk9yJHL
 0gI5bqeCNER7oc/yJQLipAR4pNMTw2ymt4Gx4y9Tp3xAXaAsIw3/TEtad4k4iD8GK7Lh
 P5qg==
X-Gm-Message-State: AOAM533cEF0Oejmth4GcfnFCdJlF0O2tSThU4gpPQJn/1znLl+hOyP80
 d+Jvl3bf4f0A+X8Y3+6Y+hZc+OawYf5n3w==
X-Google-Smtp-Source: ABdhPJxFrjp3CJ3WJMAjPdpLJ1FFLXXxA76pijOLdCakPRCzBnhBpsMmsejjz0lTnxQmFo7yxj+ViQ==
X-Received: by 2002:a5d:60c5:0:b0:203:f85a:2ea3 with SMTP id
 x5-20020a5d60c5000000b00203f85a2ea3mr2286696wrt.316.1648082376367; 
 Wed, 23 Mar 2022 17:39:36 -0700 (PDT)
Received: from localhost.localdomain (c-76-23-2-87.hsd1.ut.comcast.net.
 [76.23.2.87]) by smtp.googlemail.com with ESMTPSA id
 n8-20020a5d5988000000b00203d5f1f3e4sm1187937wri.105.2022.03.23.17.39.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Mar 2022 17:39:35 -0700 (PDT)
From: Anton Eidelman <anton.eidelman@gmail.com>
X-Google-Original-From: Anton Eidelman <anton@lightbitslabs.com>
To: linux-nvme@lists.infradead.org, hch@lst.de, kbusch@kernel.org,
 sagi@grimberg.me, axboe@fb.com
Cc: Anton Eidelman <anton@lightbitslabs.com>
Subject: [PATCH v3 2/2] nvme/mpath: fix crash in nvme_mpath_update for non-ana
 ctrl
Date: Wed, 23 Mar 2022 18:39:00 -0600
Message-Id: <20220324003900.1589124-3-anton@lightbitslabs.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220324003900.1589124-1-anton@lightbitslabs.com>
References: <20220324003008.1588225-3-anton@lightbitslabs.com>
 <20220324003900.1589124-1-anton@lightbitslabs.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220323_173937_864382_AB96CDAF 
X-CRM114-Status: GOOD (  14.11  )
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

When CONFIG_NVME_MULTIPATH is enabled, the nvme_mpath_update()
is called from nvme_start_ctrl()
for both ANA and non-ANA ctrls and regardless of multipath on/off.

Unless multipath is on and the ctrl is ANA-enabled
the function will crash as the initializations
for ANA specific parts of the ctrl are skipped in such cases
in nvme_mpath_init_identify().

Fix: check as done in nvme_handle_aen_notice() for ana_work:
a NULL ctrl->ana_log_buf indicates ctrl does not have ANA.

Fixes: d50c992edf10 ("nvme-multipath: fix hang when disk goes live over reconnect")
Signed-off-by: Anton Eidelman <anton@lightbitslabs.com>
---
 drivers/nvme/host/multipath.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 12d4afde3662..d36f2543ebe1 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -712,11 +712,13 @@ static void nvme_ana_work(struct work_struct *work)
 
 void nvme_mpath_update(struct nvme_ctrl *ctrl)
 {
-	u32 nr_change_groups = 0;
+	if (ctrl->ana_log_buf) {
+		u32 nr_change_groups = 0;
 
-	mutex_lock(&ctrl->ana_lock);
-	nvme_parse_ana_log(ctrl, &nr_change_groups, nvme_update_ana_state);
-	mutex_unlock(&ctrl->ana_lock);
+		mutex_lock(&ctrl->ana_lock);
+		nvme_parse_ana_log(ctrl, &nr_change_groups, nvme_update_ana_state);
+		mutex_unlock(&ctrl->ana_lock);
+	}
 }
 
 static void nvme_anatt_timeout(struct timer_list *t)
-- 
2.25.1


