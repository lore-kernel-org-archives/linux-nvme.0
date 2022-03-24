Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16718C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Mar 2022 00:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JSGcvwXEnegiQrJY4N1UDOeHJa8hA4CPn2pXvAlq9B8=; b=qrqI7bF4Xr+Wdv5r5fcllsXr1E
	4pReG4iRK4AoLltfw24YdEznR3Xv7/U8PjNArxZs4i+DpKwLTWgPauEmASDO8UPNmKSHn3eXXXqDB
	X0hGp6uix9tdxzVS5On9Vi43ckQB2NetjejPuuJldVoEHumb2x+JLE8CvX3BTW3PsSH7LWgZonFP4
	heECds7Hi/gvyu26LXuP6s+PNO4vfNJEc74ce8W8GkT0aD8A8wvhZEflNVSUXzdrqhlCP8qicDs8w
	TMPNQ+Tz9RmDIAa8KdebhJpBiZ4wIcr/vI1v/mAjBQxN6MpqMRX1IwFEo9l8Oys8N+z9vY9IO/Zy1
	hbikrV4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nXBNU-00FCgn-1J; Thu, 24 Mar 2022 00:31:00 +0000
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nXBNO-00FCfy-Mk
 for linux-nvme@lists.infradead.org; Thu, 24 Mar 2022 00:30:55 +0000
Received: by mail-wr1-x429.google.com with SMTP id v22so4432946wra.2
 for <linux-nvme@lists.infradead.org>; Wed, 23 Mar 2022 17:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=JSGcvwXEnegiQrJY4N1UDOeHJa8hA4CPn2pXvAlq9B8=;
 b=Aue1ZTCK3XKUCGyfD33TirBgxIA7PBX8UERa4bQKTqeCgHSegFP0TbOw+qU5yDqKUM
 +xJJaEIG9C+hdB0JQwS4mQP8DZCuabcDxANCoRgnpRd9odsRiHhkg1oM+LCThkYX56Q+
 jAKk7szlsqTmWJb/6vPbUwFNEAErs/AuL8VPCsrT1jNc2jXpS4rFGTFAqlSTEaAFk3gq
 RsZAKC5c9Iug1sBtUl23g5h0Ad8tfUHaG5tS+yVpyKHClknlwT0U8kUbkN7YU8qXK9F2
 VG9DdwCf2VMphSEnmeSey8364FAW6j49K6KZCINUPj4MIftsbSYPM514uVwfoEEFhSmQ
 a1EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=JSGcvwXEnegiQrJY4N1UDOeHJa8hA4CPn2pXvAlq9B8=;
 b=7HXg55P4LxBqo7XfERYjdU6X3/9fULMc0hIhcqA+07HZN9tRBsPBEqYHf0NnYk16dK
 UAzdC1qjgUdQLrp99wp7HZ9CcUEV/MpsW6KkN28QkxuUxZhqODzZy9gGb/bvIUGl1JMy
 vl4xmGoT+5hEq4k/x15q4DFTHxdp/TuXC+TgpACInzPtVHEjmyRf9VDl57FZxDajbfus
 E48ve8yfB8a/jTMt/4mf2fjEvwZnHzE1XiLBJsUjvkfHUZhNQ3OvFGimsB01wAWRTpkG
 j58VCzBUxD4AY1LrZ2o05nTOthvfebAmFTgA8PM2cbNRbMQue96MCeblI+ZtSqIOZyn6
 aJZw==
X-Gm-Message-State: AOAM532OwdPC9ajHxpJh6NZ2i1tM8t/VicjRmhjcACsN0dgHxVHXV3sz
 PJURzHU6LzuEpSnXjbQ6lNSgGWDCo/IlZg==
X-Google-Smtp-Source: ABdhPJySdtsbRkaQumEWQYO7yPENAkwKLf7m2KT1RqlqB7FTl/mWKw6XGilZ7n6vmKLaiNZc4/ee+Q==
X-Received: by 2002:a5d:5982:0:b0:204:1b19:40da with SMTP id
 n2-20020a5d5982000000b002041b1940damr2247256wri.23.1648081853062; 
 Wed, 23 Mar 2022 17:30:53 -0700 (PDT)
Received: from localhost.localdomain (c-76-23-2-87.hsd1.ut.comcast.net.
 [76.23.2.87]) by smtp.googlemail.com with ESMTPSA id
 p30-20020a05600c1d9e00b0038cc9d6ff0bsm1716938wms.33.2022.03.23.17.30.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Mar 2022 17:30:52 -0700 (PDT)
From: Anton Eidelman <anton.eidelman@gmail.com>
X-Google-Original-From: Anton Eidelman <anton@lightbitslabs.com>
To: linux-nvme@lists.infradead.org, hch@lst.de, kbusch@kernel.org,
 sagi@grimberg.me, axboe@fb.com
Cc: Anton Eidelman <anton@lightbitslabs.com>, kernel test robot <lkp@intel.com>
Subject: [PATCH v2 1/2] nvme: fix build error: nvme_mpath_update stub without
 static
Date: Wed, 23 Mar 2022 18:30:07 -0600
Message-Id: <20220324003008.1588225-2-anton@lightbitslabs.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220324003008.1588225-1-anton@lightbitslabs.com>
References: <20220323234355.1585346-1-anton@lightbitslabs.com>
 <20220324003008.1588225-1-anton@lightbitslabs.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220323_173054_756144_81825900 
X-CRM114-Status: GOOD (  13.02  )
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

Fix multiple definition of nvme_mpath_update() on
builds with CONFIG_NVME_MULTIPATH disabled:
the stub function is missing "static inline".

Fixes: d50c992edf10 ("nvme-multipath: fix hang when disk goes live over reconnect")

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Anton Eidelman <anton@lightbitslabs.com>
---
 drivers/nvme/host/nvme.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 76f7a5f37379..8cf90c9ed667 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -853,7 +853,7 @@ static inline int nvme_mpath_init_identify(struct nvme_ctrl *ctrl,
 "Please enable CONFIG_NVME_MULTIPATH for full support of multi-port devices.\n");
 	return 0;
 }
-void nvme_mpath_update(struct nvme_ctrl *ctrl)
+static inline void nvme_mpath_update(struct nvme_ctrl *ctrl)
 {
 }
 static inline void nvme_mpath_uninit(struct nvme_ctrl *ctrl)
-- 
2.25.1


