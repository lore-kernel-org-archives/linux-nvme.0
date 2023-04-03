Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA9BAC76196
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Apr 2023 00:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=HpxCKPte1UdD34ruQcoSh6A/9mGDDiN63zcRJIh/qCw=; b=z4hT/+gpQg8wMJvkzLJ1UmYDI3
	rh3mjmxz46neEFV+JofcuP+J+gWM4uWvyOTMsDoEMwx78uzFasbitO//VpIxq1Evqsp93EeT4LFB/
	4iyl6quK8eltRgEUM8hWhl94D9R0hf+DJ/AxJi6Gt8KPDAckp6sPATRpDj3SRiuhi4lNElUJRG6M1
	neTE6NlfU4RX7WXweUiwPztpif+pDxhUz1ZrNhQQcefQUKkHq1hOQi9tASX18f1HBhOhrR3Bu60cQ
	QgMAXOvNB3KXlP8B612RcUNeuHkO5/OAA6OZr9sgPcvuDAnVofwwiYp+KE1YSbed0u0ddweWZu57R
	ZhwSnmOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pj8Gb-00DWvo-2C;
	Mon, 03 Apr 2023 00:41:49 +0000
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pj8GV-00DWuu-0y
	for linux-nvme@lists.infradead.org;
	Mon, 03 Apr 2023 00:41:44 +0000
Received: by mail-wm1-x32b.google.com with SMTP id u11-20020a05600c19cb00b003edcc414997so17101642wmq.3
        for <linux-nvme@lists.infradead.org>; Sun, 02 Apr 2023 17:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680482501;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HpxCKPte1UdD34ruQcoSh6A/9mGDDiN63zcRJIh/qCw=;
        b=hPeDtY9G4gEfSVepZfYib013Cni6fykyaUPJeQxFYmS22BKfS9C5ZEb7sUOOaKY3+X
         Sl8OAvVBRnjlhOPaZ7fv2BD9sAj+qp88daM/HEw8VL1xqK+bRiQ1QmWWE99nZTjYOURb
         1yEUSrymptKWJFziizndha/Em2UhjkfWHIMkKNOwEBNFzIbnvC7/hPgr4yIPh0SMbc5U
         lzATEld/EISpABkwpMSpiBk8e2RkRQNTa51IakYvVqCghHmyMvyx1nzxZP5OOm9lj7bv
         wnXfs0PxewnvHNGrgqeWHcMN17KfZ9mZvi4f5kq1UvOf1lWuc6vLpeXQxIV0gL6o/T6Y
         Abgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680482501;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HpxCKPte1UdD34ruQcoSh6A/9mGDDiN63zcRJIh/qCw=;
        b=B17vrqv6U1TZoOk88MmVXM6O2wFtFKQ6Z8rQhxKpvldF2ZPK2ql/PiM5I7k6UiuKBD
         bh9w+9Z3TCMObmjm33xCjK5N7dDPGE4AVxVPqFuF9T7oLhUJwxaBM2IL6rOYYafFdC4T
         WhGt2GyvEuLo0yl7dZH02i9VaIBLgSz4bLXEoczkTNsFOMbn297yg2ArIFanfnYd1ASO
         xQsZPnOvZJia3UU75mkcJ3mAe39yr5tfBPWwHy/dLFVEBfn2o54zLYqfMhNLAjSOXUFM
         ETG8RKbU1YfH3/MVC/7DYqwNoqIdzfNj+CqAZRQdN2gBcpfcuX7/joGUMFKiTYkOVKC/
         dXAQ==
X-Gm-Message-State: AO0yUKVybjeVkEiu/MlHrZezbCzr3ROywF8J+y8ciH01NJOaQ/W8Stc6
	ERLgepWBI2GktxQksabkGnI=
X-Google-Smtp-Source: AK7set93XXY5OEHMsLqTzDXcxNxcyefFe+XxHvf3sUawqlI/tYGrmWAuLLmahFj0HlDG9kOESoNdhA==
X-Received: by 2002:a7b:c3c7:0:b0:3ea:f75d:4626 with SMTP id t7-20020a7bc3c7000000b003eaf75d4626mr24782878wmj.38.1680482501043;
        Sun, 02 Apr 2023 17:41:41 -0700 (PDT)
Received: from archlinux ([37.168.112.109])
        by smtp.gmail.com with ESMTPSA id u17-20020a05600c19d100b003dd1bd0b915sm17751161wmq.22.2023.04.02.17.41.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Apr 2023 17:41:40 -0700 (PDT)
Date: Sun, 2 Apr 2023 21:41:28 -0300
From: Irvin Cote <irvincoteg@gmail.com>
To: hch@lst.de
Cc: kbusch@kernel.org, axboe@fb.com, sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH] nvme-core: Fixing ctrl de-referencing in nvme_init_ctrl
Message-ID: <ZCoguA3gBUw1CIdd@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230402_174143_353655_2D5ACD30 
X-CRM114-Status: GOOD (  11.24  )
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

Correcting the de-reference count for
the controller in the core layer to avoid
a memory leak. Also cleaning a bit the
teardown logic of nvme_init_ctrl. 

Signed-off-by: Irvin Cote <irvincoteg@gmail.com>
---
 drivers/nvme/host/core.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 8698410aeb84..3d7aca7d0f2a 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -5137,14 +5137,12 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
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
+		goto out_free_page;
 	ctrl->instance = ret;
 
 	device_initialize(&ctrl->ctrl_device);
@@ -5191,10 +5189,10 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 	nvme_put_ctrl(ctrl);
 	kfree_const(ctrl->device->kobj.name);
 out_release_instance:
+	nvme_put_ctrl(ctrl);
 	ida_free(&nvme_instance_ida, ctrl->instance);
-out:
-	if (ctrl->discard_page)
-		__free_page(ctrl->discard_page);
+out_free_page:
+	__free_page(ctrl->discard_page);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(nvme_init_ctrl);
-- 
2.37.2


