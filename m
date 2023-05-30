Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52144C7EE24
	for <linux-nvme@archiver.kernel.org>; Tue, 30 May 2023 22:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Do+otLz1R3Kg7JM1dAxxGi8C7OI3Zdw9P8C57IS86Z4=; b=N12CUpNpnAbOSHwR2KWkXEpWi5
	n1D9Vd47lM1fkWkxKXBi5LVZbOuHJn/BVYwTlfYtROw2pGCIR5ja2qO9Dqvn8jkf9HdummSg6RBVm
	L+0Ln3a5/oNdg6afblEgrfwRNBfe/emLIUzE/Kf1LtDQAhbHAWyowOEdy4NDNJlK0wGKduodUBdLm
	qkW6q0mOwUTZ9XGIDEipncS3/CGB1pHZAH61QnwsdRP5W+WgeMfQQkeOoxmmzTfWdemRrkMzYX+o2
	m/FU4bbcwJDZFRTYS7ENF2McmIPXTs8q04VwQI0io9qdfMmLH+uoYqGa76XiPsxYTWZiBVOzQscpp
	5yzqXPbw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q47oL-00FJjh-1U;
	Tue, 30 May 2023 22:27:25 +0000
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q47oJ-00FJi8-0f
	for linux-nvme@lists.infradead.org;
	Tue, 30 May 2023 22:27:24 +0000
Received: by mail-oi1-x22e.google.com with SMTP id 5614622812f47-38c35975545so3432728b6e.1
        for <linux-nvme@lists.infradead.org>; Tue, 30 May 2023 15:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685485641; x=1688077641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Do+otLz1R3Kg7JM1dAxxGi8C7OI3Zdw9P8C57IS86Z4=;
        b=ZmQoej1L/1Fo6dZin9PUyBmxl60AiETa5tMIZ/DdZ/QGXMQFb9aFsvwdMdi88OeSy4
         yUgnh/LAFWIwbyk1P55vV/A7kww2EtDM4TarHEaaN5mH7Dn3vcdr9sTkUxsh188cHbYz
         QgcimnQ82X8c6+IgNwZFEOzzfX0FrqhBsOC3c10ptzZtrRiPK4FO2UU+R/86pcehLh4i
         zyFfZQPnfaI76E/xWxfZvcQozFckiRLdjhbgQ40V8XsCzUOriMawO3QpwDNk0CWA+ck/
         ZYaMTrJEdo7F242LleWsaNvjfAVGrd6u9kG87xz+FD+TMnm2p2mTJNtTtSQ2nTTO3NF/
         D9lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685485641; x=1688077641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Do+otLz1R3Kg7JM1dAxxGi8C7OI3Zdw9P8C57IS86Z4=;
        b=DJKBSLpKhSQ47B4WP6e2OTaqDdFuGLJmz88HdWY9iwNeJPSwf/jzgc0gN0xJogu93r
         lEp7OXNg2a1K294AsfIAb54pyQGcR4fZ56pCtE5Ib3NtYJ4WLdhBioCD2QVCPgowPl2B
         p9g9m+0V7ztRd/y6P0VwSYd7LoTprpVC4LUPowNXegPkHHxDLC7hP3i3j7/Ipk+OpOOo
         eZ20j1RvOExTTK5hHWqBeKTGLngZEv8N8tUxrBZDNCWG4EVuuvNlVES5ACnP01XQVpvL
         GMmkPgjXpS9vXwsbd0vKKfIGDmGanCtoLgsm6LuHuhQT7zAAKgbTjJYJ7VHUerO6zspZ
         vbKg==
X-Gm-Message-State: AC+VfDxRPt/bUj/HaXD8to5t5uJ7EP0m2oRPrje6lsJG3JktHohR5t3X
	posmrEL+Y4gHpAHGzATJ9Kk=
X-Google-Smtp-Source: ACHHUZ4VWmSWDdFM0kNVFmoeAKASqi5CE0b08e1pEFuaAOrWoK8Cww/5L7XolqJColxUSRFGShArCg==
X-Received: by 2002:a05:6808:2799:b0:398:7db6:7ee3 with SMTP id es25-20020a056808279900b003987db67ee3mr1962299oib.19.1685485641312;
        Tue, 30 May 2023 15:27:21 -0700 (PDT)
Received: from archlinux.fibertel.com.ar ([190.193.134.103])
        by smtp.gmail.com with ESMTPSA id o10-20020acaf00a000000b0038c35f512a2sm6359041oih.56.2023.05.30.15.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 15:27:21 -0700 (PDT)
From: Irvin Cote <irvincoteg@gmail.com>
To: hch@lst.de
Cc: kbusch@kernel.org,
	axboe@kernel.dk,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org,
	Irvin Cote <irvincoteg@gmail.com>
Subject: [PATCH 2/3] nvme-core: exit scan if shared ns but no multipath
Date: Tue, 30 May 2023 19:27:08 -0300
Message-Id: <20230530222709.28682-3-irvincoteg@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230530222709.28682-1-irvincoteg@gmail.com>
References: <20230530222709.28682-1-irvincoteg@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230530_152723_245715_15739071 
X-CRM114-Status: GOOD (  10.95  )
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

If a shared namespace is found during a scan but with multipathing not
enabled, inform the user that the driver must be built with
CONFIG_NVME_MULTIPATH and exit.

Signed-off-by: Irvin Cote <irvincoteg@gmail.com>
---
 drivers/nvme/host/core.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 2f89477e4878..6aa160529887 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3565,10 +3565,11 @@ static int nvme_init_ns_head(struct nvme_ns *ns, struct nvme_ns_info *info)
 
 		if (!multipath) {
 			dev_warn(ctrl->device,
-				"Found shared namespace %d, but multipathing not supported.\n",
+				"Found shared namespace %d, but multipathing not supported.
+				 Enable CONFIG_BLK_MULTIPATH when building to support
+				 shared namespaces\n",
 				info->nsid);
-			dev_warn_once(ctrl->device,
-				"Support for shared namespaces without CONFIG_NVME_MULTIPATH is deprecated and will be removed in Linux 6.0\n.");
+			goto out_put_ns_head;
 		}
 	}
 
-- 
2.40.1


