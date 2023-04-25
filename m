Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D00CC77B61
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Apr 2023 21:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ygjDkVPQgfGjsoPj4ztBBlGdy3zJjHUpgPnvmJzFhnM=; b=o6Qt8xsnOle+x7GxrfEGi1gUko
	ZkKGY/7QAqy/cRYqIDpAzhaiTaZQ2Kw3u6yFeLsWSyGAGTbpc0b4PzgMOd0zRafAe+0xTamETsPCD
	fgWg2dNRgOQ6WdhgF1fO6mvHw6MrQwgWSwzGP1sVXkNEVeoSe+lgtMQ1WJQrPWPby5TyHUuGMi3Tl
	59oRZ/PPR/xidG6RJBQavmH3NZx2fM4SgnTUmdmBQkykqGQnRSqe3aYDaLa7QIhJHaG0so9lW/fEp
	AVMjskXfr25QOLzmZWqgPihhvxQz3khorfWC1h0VoS7QJNJ9Ai0LL9POr1BZlDxOUaFTlmU/gU3+1
	/6Sy37qQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1prQ4Q-002ERO-1I;
	Tue, 25 Apr 2023 21:19:30 +0000
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1prQ4O-002EQ6-1r
	for linux-nvme@lists.infradead.org;
	Tue, 25 Apr 2023 21:19:29 +0000
Received: by mail-ot1-x333.google.com with SMTP id 46e09a7af769-6a604259983so4843622a34.2
        for <linux-nvme@lists.infradead.org>; Tue, 25 Apr 2023 14:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682457566; x=1685049566;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ygjDkVPQgfGjsoPj4ztBBlGdy3zJjHUpgPnvmJzFhnM=;
        b=GJI5nq2Q4G+tHD6KeipBsfRVJc8Fmljl2vO+WId/4VIYKh/dR9Z9wrnJ7oS9ZZylNx
         0CFoI3aljnsV2lTVZPt6dnrgDZpM0YutXJNNrsbZSxkpDY6iAuNlf4onz+g/dNMoM3NE
         irXZG4UhZKx0PqAF2zKy8WyEd37hOouHjFGGFc7NkXOmorjXTNeGBC2w9dFBm70C2vTs
         dxPNvUWV/e27O83U/1gt/c7/TZbjcz0K4N8NdHrESdM/5kltzGKXBr/Rw8PIMqUVtEAY
         9lRW4BL3d9P1sH+iFSB5v3yt4mgfqKBlSrgySdXZYzdhcdGUq4ZOpo3Gu7Y1zFaspxqL
         euYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682457566; x=1685049566;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ygjDkVPQgfGjsoPj4ztBBlGdy3zJjHUpgPnvmJzFhnM=;
        b=eLVkDO1VPvL1NI6QsGGXEi+Dy1AJB0wH9B022cjX1ybX2QHUNcdz0HbthKz0BOSFJ2
         QDA5v4cb7Fa5Dv2x3BT6TgMAy2lixkf+9hk+hiqs0ZlqgiCOnlyRilhoyA/Y/x02bu4s
         PWNqWft9COnBoCVMQvy/qxQsVFVl8E6uCNiYqPdkwiWsuB8+p7fOXD3rO9FX9cOxBudq
         E8h6voYK7DJTVvzxqMT8tVipZp4Mx3/YJgbkl3qR8LdVzEPTXYTeYB4Z+tACloUCDqQV
         WxzAxhi2Px9ahJKoFDSMXtAeLxuVlWyXzT3Icw/erUrCmXok/IifH9UugpzEGpJhsWpL
         +bHQ==
X-Gm-Message-State: AAQBX9ezbIxOaFKTTNpyDzmMV0T1KlAz9+zivUGwsxbru5nEyLIEan6G
	i3Ya0lQmlBUTbYycsVMIdgM=
X-Google-Smtp-Source: AKy350Z8PUh0rBGLyeDgR9jbkFT/8xq7+kWgfs4RDjfk8Ex5RzJtRrrcpAdcMJTGcgCnqMcziuJbWw==
X-Received: by 2002:a54:411a:0:b0:38d:f298:6d00 with SMTP id l26-20020a54411a000000b0038df2986d00mr8050962oic.51.1682457566677;
        Tue, 25 Apr 2023 14:19:26 -0700 (PDT)
Received: from archlinux.fibertel.com.ar ([190.195.153.187])
        by smtp.gmail.com with ESMTPSA id u2-20020a05687036c200b00177c314a358sm5945357oak.22.2023.04.25.14.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 14:19:26 -0700 (PDT)
From: Irvin Cote <irvincoteg@gmail.com>
To: hch@lst.de
Cc: kbusch@kernel.org,
	axboe@fb.com,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org,
	chaitanyak@nvidia.com,
	Irvin Cote <irvincoteg@gmail.com>
Subject: [PATCH 1/3] nvme-core: nvme_init_ctrl cleanup
Date: Tue, 25 Apr 2023 18:18:34 -0300
Message-Id: <20230425211836.14283-2-irvincoteg@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230425211836.14283-1-irvincoteg@gmail.com>
References: <20230425211836.14283-1-irvincoteg@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230425_141928_615744_B7C41C77 
X-CRM114-Status: GOOD (  10.81  )
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

Removed an incoherent check at the last exit label
and renamed it for better clarity.

Signed-off-by: Irvin Cote <irvincoteg@gmail.com>
---
 drivers/nvme/host/core.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d6a9bac91a4c..353443250d48 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -5149,14 +5149,12 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 	BUILD_BUG_ON(NVME_DSM_MAX_RANGES * sizeof(struct nvme_dsm_range) >
 			PAGE_SIZE);
 	ctrl->discard_page = alloc_page(GFP_KERNEL);
-	if (!ctrl->discard_page) {
-		ret = -ENOMEM;
-		goto out;
-	}
+	if (!ctrl->discard_page)
+		return -ENOMEM;
 
 	ret = ida_alloc(&nvme_instance_ida, GFP_KERNEL);
 	if (ret < 0)
-		goto out;
+		goto out_free_discard_page;
 	ctrl->instance = ret;
 
 	device_initialize(&ctrl->ctrl_device);
@@ -5204,9 +5202,8 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 	kfree_const(ctrl->device->kobj.name);
 out_release_instance:
 	ida_free(&nvme_instance_ida, ctrl->instance);
-out:
-	if (ctrl->discard_page)
-		__free_page(ctrl->discard_page);
+out_free_discard_page:
+	__free_page(ctrl->discard_page);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(nvme_init_ctrl);
-- 
2.39.2


