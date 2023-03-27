Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82D7BC6FD1D
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Mar 2023 17:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FgC5m5HttmrxLNNlVxbB5YOEqPwXtWot9GfFEvDnqKA=; b=a3BAPsslpTs6tO0y0rD708OJYc
	AwdtoSoxsHXpk+1Zuhdxfvk2z/2bLltUDc8s6YyocYHR6cLbUtUxWGqF2AuqwEZbHVuLm+nxlsjDN
	H3ZZmFCaeWt/csECTAxccGJjezj91jh8nHmuVViwys7iCM+wVi7qycgoUNt/6EG2QY8uQbdT9pFW1
	lGy5w0d5D5BGs6jB3Rn+wXjBxsrx24h6q30z2GIv6g0b41rzLRL4sPFX5Hck9ETMf3t48hzPwiTOw
	J9v67XCCKeFUNwxvPRwh9qBC5ehHAZ5Eoyuz0mLhsw172bbxlENjk4ukJ2neb13PDheVpSrGeZhiX
	qQ+ykHWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pgqtz-00BvrY-1G;
	Mon, 27 Mar 2023 17:45:03 +0000
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pgqtw-00Bvqh-2b
	for linux-nvme@lists.infradead.org;
	Mon, 27 Mar 2023 17:45:02 +0000
Received: by mail-pl1-x62a.google.com with SMTP id o11so9177865ple.1
        for <linux-nvme@lists.infradead.org>; Mon, 27 Mar 2023 10:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679939097;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FgC5m5HttmrxLNNlVxbB5YOEqPwXtWot9GfFEvDnqKA=;
        b=nhgYWGwWYiH1PJi2uYY3SVgxR/0JiC7cawEJi5+yOYPmuWb97Wjozg1iZgw9sv5x8P
         0/VRn5ox63GeH07dVe1lVJ1hdEBMCKwHfu4yQNrvh7klAiVnvPrbex86dzx/Da1LbN0v
         F8pjiBI+bvaZibHtTHKn7x90U28Azc/S9czNTwU7BhbmD1thFk34vRjaA4s1wSgef8Rq
         qiheHL6nm1yS667pB734f384srP2KGN/E925daJ47gDzOE3mIiaFtY5qRzJJlqjMGAe8
         PaY9RRZosoU/F41cG5SUw8fDP9IfdJcz24LuyY/EQJPuhk/Xt3GO81f3SZTDUYqtMye8
         opAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679939097;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FgC5m5HttmrxLNNlVxbB5YOEqPwXtWot9GfFEvDnqKA=;
        b=Tv/AanmyL4uuHe+G0/zAEMUO+01r4IsKfu+XPyyi+zfjYJumrbPogbG2FpkNbmyv5Q
         BUz4VqpSOeWuxuo5TB1EG8e3bBW05Hd15MuN+sEWKOv8zRvhAvYcmfG68BWSpzOADS2n
         hZNBnjFXmAI9TnKInMTDO9adCq7Obm57jIUQ3/GTHHsXmrzIZu00oFcTmptCy+cj4lzu
         1soJmmkwk1fT9E8uZ4UmFPu5ufNvegLhb5jXgdJ1ELOkehZB7H2/QzV6B4Ih6gbVvUT7
         nlQ7/HimgegkxrnGLe0IPq/fV8RPRer3gNCh/+C7LEvyrnUdJH+535QICznbxgfdT40R
         sIdQ==
X-Gm-Message-State: AAQBX9cxXL4dYftCuDOe3T6l625eWola1aJay5bId7Vh339Kmi18EXBB
	3WH1uEL1LN/p5eWnmbb97B0=
X-Google-Smtp-Source: AKy350bzaWUM4Pe/doexjUcIinZ3uJDtPFjlreGncMHUmWOIXROHuRhgfa4D6a0c4wp2FLvUagJcnA==
X-Received: by 2002:a17:903:189:b0:19c:f476:4793 with SMTP id z9-20020a170903018900b0019cf4764793mr13648153plg.51.1679939097306;
        Mon, 27 Mar 2023 10:44:57 -0700 (PDT)
Received: from localhost.localdomain ([240f:34:212d:1:5a57:cb77:a4e:9d10])
        by smtp.gmail.com with ESMTPSA id 132-20020a63038a000000b004f27761a9e7sm18083221pgd.12.2023.03.27.10.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 10:44:56 -0700 (PDT)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: chaitanyak@nvidia.com
Cc: alan.adamson@oracle.com,
	linux-nvme@lists.infradead.org,
	Akinobu Mita <akinobu.mita@gmail.com>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH] nvme: fix error handling in nvme_init_ctrl()
Date: Tue, 28 Mar 2023 02:44:06 +0900
Message-Id: <20230327174406.10880-1-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <8ce877b6-5b25-e71e-9061-dcda19c2bf9b@nvidia.com>
References: <8ce877b6-5b25-e71e-9061-dcda19c2bf9b@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230327_104500_865707_512FDCEF 
X-CRM114-Status: GOOD (  10.20  )
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

This fixes error handling when nvme_auth_init_ctrl() returns an error in
nvme_init_ctrl().

This problem is reproducible by blktests nvme/044.
The nvme fault-injection debugfs directory was not removed after running
the test.

Reported-by: Chaitanya Kulkarni <kch@nvidia.com>
Link: https://lore.kernel.org/linux-nvme/40baa75e-fdf5-cb73-5fa8-b12d65bce4e7@nvidia.com
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
 drivers/nvme/host/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 4eb62a7dac44..0545b3ea5a44 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -5197,6 +5197,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 
 	return 0;
 out_free_cdev:
+	nvme_fault_inject_fini(&ctrl->fault_inject);
 	cdev_device_del(&ctrl->cdev, ctrl->device);
 out_free_name:
 	nvme_put_ctrl(ctrl);
-- 
2.34.1


