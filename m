Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D880C43334
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Jun 2022 16:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=AvXwoOU9CbMzPbV4r/jpFWa7Vg320foFVazEWVMmLVE=; b=ZWX5qY49fS7pPz38f9LwH/rYum
	CwGeF4tI3cX83x84G/HFVRYva/J7R57LF4gaUj3ZqZbCqfiNW7WF53l8+ulF/kH0LQy3UaLeb2yRa
	y2NMYm+E65bW/UOJM63GsT8lnwwxjz2B3vjrL9ZMLgA2R9ch0BkqWMAN1m0LNJkzDze6Pn0PsnWFb
	jLa0vLXM2z3NnSxBxwBIP0w1/ppLsq5zXYg72huIeTAkLLpb4qESma7beBLJ0VYzLk+DCLtUj52vP
	ZPfYakImAqkGAYdymV0tCQijOIhqDZwEW2eNBvn8Ng3GmYjPAQlJGjD6NlG5IFi/1rkhy5pUJZtXQ
	+U3knnDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nyy9g-00ECN2-4j; Wed, 08 Jun 2022 16:03:36 +0000
Received: from mail-il1-x163.google.com ([2607:f8b0:4864:20::163])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nyy9d-00ECLt-0Q
	for linux-nvme@lists.infradead.org; Wed, 08 Jun 2022 16:03:35 +0000
Received: by mail-il1-x163.google.com with SMTP id b17so12579791ilh.6
        for <linux-nvme@lists.infradead.org>; Wed, 08 Jun 2022 09:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AvXwoOU9CbMzPbV4r/jpFWa7Vg320foFVazEWVMmLVE=;
        b=doxAlvbfNofQGm5jciXNtIGCVe3OS54wckCtMhNH2eEIsd6G8GAin/yUUk6bSi5QnA
         1rKnzk30DSCDl1u+A01/yLI+98VrTD87BCzIV0HSA7bQGE4wAZwAcuR+C7n4v1//1qKm
         vsNgeaR98SVprC3vWMcWtyaey2/r43nV2xv+8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AvXwoOU9CbMzPbV4r/jpFWa7Vg320foFVazEWVMmLVE=;
        b=gxn7cWi/l3FCqZvIT78QXyscwHm1JPQWEDkRxR6gN7T6rn8qhVglU1f7enSPxMEbVb
         vc7CCN4C2LDxJn6HLXiW9UFmCg+UYOfar7uyqfXBiIWhfdbokB25NGRCdiY3of7DMoLw
         IJW3Wa7UPQqeTc75ryQN0z+PoUmq/5SKz1phB3gSzbI+CK/Qddv4intfwbp2WMS7ShAV
         71I081bObkLXDkfy0Q05qynOuP+3DBJjhGw3+H3Me2dY5O9p3yssc//neMwIKWEeNiMd
         5Nah7HczGBSK7Oo+zY56BZhFwmARCOaJnBePNEWunkgo0itA9OV6a0YCanbIzr+mJC6q
         Nx3g==
X-Gm-Message-State: AOAM533ktjDyfEWdrE40JQc5cbOGnC6R1TPaeY1gN78AyE77mojGisOW
	cNQkM7WKU3r94P8s1Vfcw4qXd1kEg/zLCt1Ch5gYZS0JWYXa+7S0Yt3XfHlSVq4YFA==
X-Google-Smtp-Source: ABdhPJya6HQS8mgm9+s9Vveqt5wTWBpILCALIwPNc2uiYRFB14zqrmpG87yCFiALB6PBVR+S1tjPO3sytQtZ
X-Received: by 2002:a05:6e02:164b:b0:2d3:ccea:ff38 with SMTP id v11-20020a056e02164b00b002d3cceaff38mr19599396ilu.37.1654704210438;
        Wed, 08 Jun 2022 09:03:30 -0700 (PDT)
Received: from c7-smtp.dev.purestorage.com ([2620:125:9007:320:7:32:106:0])
        by smtp-relay.gmail.com with ESMTPS id l28-20020a026a1c000000b0032e718ba02fsm1725656jac.24.2022.06.08.09.03.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Jun 2022 09:03:30 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp.dev.purestorage.com (Postfix) with ESMTP id 61E662210C;
	Wed,  8 Jun 2022 10:03:29 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 5C6C6E40F0C; Wed,  8 Jun 2022 10:03:29 -0600 (MDT)
From: Caleb Sander <csander@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
Cc: Caleb Sander <csander@purestorage.com>,
	Michael Liang <mliang@purestorage.com>
Subject: [PATCH] nvme: don't send unsupported NVME_ID_CNS_CS_CTRL
Date: Wed,  8 Jun 2022 10:03:05 -0600
Message-Id: <20220608160305.1781896-1-csander@purestorage.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220608_090333_092509_3D070E5B 
X-CRM114-Status: GOOD (  13.31  )
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

Identify CNS values 0x05 to 0x0F are reserved in NVMe base spec 1.4.
0x06 was only added in spec 2.0. Our array implementing spec version 1.3
correctly responds to this Identify with "Invalid Field in Command".
The driver ignores an error status code here, but the reserved CNS value
violates the spec and causes unnecessary traffic on the NVMe connection.

Require controller version 2.0 to send this command instead of 1.1.

Signed-off-by: Caleb Sander <csander@purestorage.com>
Reviewed-by: Michael Liang <mliang@purestorage.com>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 24165daee..ebffc3545 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2934,11 +2934,11 @@ static int nvme_init_non_mdts_limits(struct nvme_ctrl *ctrl)
 	    !(ctrl->quirks & NVME_QUIRK_DISABLE_WRITE_ZEROES))
 		ctrl->max_zeroes_sectors = ctrl->max_hw_sectors;
 	else
 		ctrl->max_zeroes_sectors = 0;
 
-	if (nvme_ctrl_limited_cns(ctrl))
+	if (ctrl->vs < NVME_VS(2, 0, 0))
 		return 0;
 
 	id = kzalloc(sizeof(*id), GFP_KERNEL);
 	if (!id)
 		return 0;
-- 
2.25.1


