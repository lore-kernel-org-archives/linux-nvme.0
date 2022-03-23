Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4025AC433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Mar 2022 23:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=JSGcvwXEnegiQrJY4N1UDOeHJa8hA4CPn2pXvAlq9B8=; b=yk8dzQQTu+y85HFAvE3SSeYlAa
	otkpKuNh8G6LhMJz+uFv8soXDYqpSaB+eA5407dwfu/ayRj/l2rHLJqKNcmsZf1+CBTQqnbVshtJN
	cv89MFc3UwteMZ/IKOLuL5NI1Ir0XOlEKzK6Atz08aBvGcRwM8YdClsCELH72SXi6Ly31KtYU4pGB
	KFOE6bX1fGNJQlZH4TnxDvQmCI+9J8adIIeE69BR6pmYe0xo30LL1Dypvddcc0VmIDn7BzuOrSUby
	sWTgCvcgv9vJftvZfyovcWvNZ1jqfNsftC/gXlC3k+UsTt3j6LxzJX2yg0xwBU8kWvMoQd44NHUMK
	yhRHeYqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nXAeN-00F4pO-Sk; Wed, 23 Mar 2022 23:44:23 +0000
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nXAeL-00F4oH-SU
 for linux-nvme@lists.infradead.org; Wed, 23 Mar 2022 23:44:23 +0000
Received: by mail-wr1-x436.google.com with SMTP id d7so4308403wrb.7
 for <linux-nvme@lists.infradead.org>; Wed, 23 Mar 2022 16:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=JSGcvwXEnegiQrJY4N1UDOeHJa8hA4CPn2pXvAlq9B8=;
 b=igyGA/KEoLS+rChVLGH/K9lK21Bl9KvyAmyAoH8rq9WZngqifan46tY/Ljg+mZhLI1
 qxhD7sdrxhbCt23ey9W44EZBgrHYGpneouFce0Nb2MDbgMF57IeW2Ux1kH+sBUBhXq/D
 4fysB0OecLDC+4WiKYMh8Y8FLNzOfs5tF0Y73y6jDNVYaXczNlfpeKj3nNAKp22GbiOp
 0SbQ/wOaBTmseWRBBwN6782iatwWxKfLiaXmoP3MGIsRH6cpNC+3JRCkIiQsYlUzWWNi
 BjCwUvBdlP4debo0q9vehbzgg72fTL7ugDEOtFn2356mSCKq0hDvwTZMinyygo1gxV1Y
 16KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=JSGcvwXEnegiQrJY4N1UDOeHJa8hA4CPn2pXvAlq9B8=;
 b=oHjZ30BkjFLGI8ic+vFRNvvAZnQAhRM0Lt4iwWUKtJjMRr+wNXAU2oH7yEVeqFx5hR
 nnQ/xNPW6U9bX5ZUe8i2m+kDOwiHccGCNkQyLd9L0f7OUKn0BkhAWDWSINSI0cMJ+St/
 pD7JIAsKyzA1BUGsqnW6o1/rwOeGAXRY9S+OUSCVv2RSCU9A+CzqIpXazj7/MeE0YPYG
 qaOC544mOWsKIwT3UZXeRU5WlLv+7CSkgvDYXb6yOrEBrZwUr/5VVi01EM9RQ7CLr4i3
 UiYYZozRhQnMhYQFyOrZ2a+7WySGEZU4xChuWdDZc0iX6ulK/uwKQcIJSLkN1a8hBvOe
 7vBg==
X-Gm-Message-State: AOAM530qxoZjuGX4B1pBgQn5DVzxmB6o4i1pOrvFiTkUsGQnL5tTAayE
 qxB9N9swixC0qM6gIiX95jyqbiC2l+pAhg==
X-Google-Smtp-Source: ABdhPJw/EaWek12aRV0TGe+coHZLWSJ+zlWtwbVMwjiCKJe4terzM5sIc2biZl7YT+A4qTOoic2Dvg==
X-Received: by 2002:adf:efd2:0:b0:203:db42:c56c with SMTP id
 i18-20020adfefd2000000b00203db42c56cmr2199583wrp.698.1648079058352; 
 Wed, 23 Mar 2022 16:44:18 -0700 (PDT)
Received: from localhost.localdomain (c-76-23-2-87.hsd1.ut.comcast.net.
 [76.23.2.87]) by smtp.googlemail.com with ESMTPSA id
 v10-20020a056000144a00b00203df06cf9bsm1049996wrx.106.2022.03.23.16.44.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Mar 2022 16:44:17 -0700 (PDT)
From: Anton Eidelman <anton.eidelman@gmail.com>
X-Google-Original-From: Anton Eidelman <anton@lightbitslabs.com>
To: linux-nvme@lists.infradead.org, hch@lst.de, kbusch@kernel.org,
 sagi@grimberg.me, axboe@fb.com
Cc: Anton Eidelman <anton@lightbitslabs.com>, kernel test robot <lkp@intel.com>
Subject: [PATCH] nvme: fix build error: nvme_mpath_update stub without static
Date: Wed, 23 Mar 2022 17:43:55 -0600
Message-Id: <20220323234355.1585346-1-anton@lightbitslabs.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220323_164421_942483_A2285795 
X-CRM114-Status: GOOD (  12.22  )
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


