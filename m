Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 377B5C5479D
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Jan 2023 04:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=F1OuSTZ/ff90luHGSTPVfp/ZA1ziWXV0nowGCAVC+oI=; b=O6/Iz6XBzHTYBzJgygepV2U7EQ
	q1ZfD9bBbd/vO+4PBwQbKfUPaPb62gIdCdg7NNok+VXzOYQrLc3nzIuoiJJ1KSyXllBZS9J3dSTYT
	ay8qC8qlPcUmlUhtfbvIrU/Jc37HF/T1YQDv7TdDwjwIzGYEKkeRSTB/pxNfRdyjlsaSoCLwjGcLU
	d4xgtiuc6araBX6jahB1GjNxRsdWKB2IK9zH0vEGUuhK0cZnXtHaXEqUXhg/cFL9z7IUILthV6bZJ
	PjaV8Swry8kBEDs6PmfkpI6FGegpeZQWT7RjhGiWDm9GD4OVV/t8Xi5cA1chwHMOpizdmqztZbJzV
	5PMmTy3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pFStB-009Ygc-Fb; Wed, 11 Jan 2023 04:39:01 +0000
Received: from marcansoft.com ([212.63.210.85] helo=mail.marcansoft.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pFSsi-009YYX-NN; Wed, 11 Jan 2023 04:38:34 +0000
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sendonly@marcansoft.com)
	by mail.marcansoft.com (Postfix) with ESMTPSA id 9EA3E4245E;
	Wed, 11 Jan 2023 04:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
	t=1673411911; bh=3mwbRHlRhjEn6d7ialc4jgg5I5MLJj7InHbf8EL6vA0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gtOdbdn7hRKNeJrKJRvmsoB4h2WV3TdpgzrVGVcpQ+O/RUW4pAwhiS3d5c65/H4lv
	 pJhXSXKrNTs7s8odh9yDMffyHuPvieDbG3RC7gWLalFhXhltp/ytsHX1dcIN74JUES
	 tPz+pwugBCo+WOiapqL9nubi4zzwg1YjNgeqC0Uy7U4oVr9O0cH9ApVemrOaEE+SCW
	 +UjamWWPMvp/gXVXdzpdunJkBp7+G2p/42WU82fSJUFtZej9YELwvVRIXWvMx8JlS/
	 2YzLZGzn2w7Py8Wv3Bsjf4QEBty+FrMl0s1LX8po9TVKPCwyiAPUG2eAjpeeXyJnrB
	 1e+lPNgb1sjBA==
From: Hector Martin <marcan@marcan.st>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Eric Curtin <ecurtin@redhat.com>,
	Janne Grunau <j@jannau.net>,
	Sven Peter <sven@svenpeter.dev>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Hector Martin <marcan@marcan.st>
Subject: [PATCH 2/2] nvme: Handle shut down controllers during initialization
Date: Wed, 11 Jan 2023 13:36:14 +0900
Message-Id: <20230111043614.27087-3-marcan@marcan.st>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230111043614.27087-1-marcan@marcan.st>
References: <20230111043614.27087-1-marcan@marcan.st>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230110_203832_924055_9224F66F 
X-CRM114-Status: GOOD (  14.20  )
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

According to the spec, controllers need an explicit reset to become
active again after a controller shutdown. Check for this state in
nvme_enable_ctrl and issue an explicit disable if required, which will
trigger the required reset.

Fixes: c76b8308e4c9 ("nvme-apple: fix controller shutdown in apple_nvme_disable")
Signed-off-by: Hector Martin <marcan@marcan.st>
---
 drivers/nvme/host/core.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 7be562a4e1aa..84e5db192ff9 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2410,6 +2410,19 @@ int nvme_enable_ctrl(struct nvme_ctrl *ctrl)
 	if (ret)
 		return ret;
 
+	/*
+	 * If the controller is enabled but shut down, we need to disable it to
+	 * reset it and have it come up. If the controller has completed a
+	 * shutdown and is disabled, then we need to clear the shutdown request
+	 * and enable it in the same write to CC.
+	 * See NVMe Base Spec 2.0c Figure 47.
+	 */
+	if (ctrl->ctrl_config & NVME_CC_SHN_MASK && ctrl->ctrl_config & NVME_CC_ENABLE) {
+		ret = nvme_disable_ctrl(ctrl, false);
+		if (ret)
+			return ret;
+	}
+	ctrl->ctrl_config &= ~NVME_CC_SHN_MASK;
 	ctrl->ctrl_config |= NVME_CC_ENABLE;
 	ret = ctrl->ops->reg_write32(ctrl, NVME_REG_CC, ctrl->ctrl_config);
 	if (ret)
-- 
2.35.1


