Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3A78C001DC
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Jul 2023 21:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TgTVnA2PFNS3TTAMOBn0sODIfT++lGhKtJ9Vw8zaglI=; b=g+wEla2wxRafky5WFYp4apjnEr
	90Cf7QiVpjxj5kYafJGRW3o/y56oDHFVsAfuWXZGKiBcowPfVcHWUE+zLTeHUCUKZjnGbSU9WtkXG
	9SFXXVLEO2ovMn+o4vrUkDDiLfatKQ/DCNC7pegpIFBKi0bLRmfqI6bZ5GZVG/TSSe69FZKzWY5/8
	8O7haun9Zpq6X2SYANethvBOOe7ZKTkJPvHvD76xrXjTbObvAgmqdu76DBnkGHC9GhT1QeG0MkTcg
	KQFMDw+8Z92KbowR+5ynf4NHhhLWVY2s/q+46BwQR/qZZZ3HIRt7YitcISeSWTcn3IDkqzNSw/JiJ
	OKcw08Uw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qHsuB-005ihM-2e;
	Fri, 07 Jul 2023 21:22:19 +0000
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qHsu8-005ifu-1n
	for linux-nvme@lists.infradead.org;
	Fri, 07 Jul 2023 21:22:17 +0000
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-66f3fc56ef4so2429653b3a.0
        for <linux-nvme@lists.infradead.org>; Fri, 07 Jul 2023 14:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1688764934; x=1691356934;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TgTVnA2PFNS3TTAMOBn0sODIfT++lGhKtJ9Vw8zaglI=;
        b=UXkWbYNHfEYDCf+UEwkjLZNUFR3pI8VV0jrg3vLzEqyTUxi4JEGt5/pqxvG7EwaQ1v
         ICy4+wHmE/s+SdzkzYJogju/dFm8qFiwD38av96od/EMMRZ0les1oB763nPU1U72AuWd
         qhkFXYRGLgaPVCykRFzHcEszwyg8+PKpALzBdx2ai0OQsMskXaUO3KODvQ6BMRr/ehVb
         Nn3f1GCE9aq1BCtZ4ii4KbkLM6xDB7KCnIEmPNEJjm26p/oV4Wo9J1Cda6DiaEl/N13Y
         YwMUQ+PE6zH+MNCBnWSuu5j4nfcitXRBcG4joXSKuYI6QIbCF6r4vg93oaPjOJ/+kqSt
         UT5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688764934; x=1691356934;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TgTVnA2PFNS3TTAMOBn0sODIfT++lGhKtJ9Vw8zaglI=;
        b=LyqOmenS0RQlet1bvCHsUa7eXuXxMB0n+YFp7sq3jVRYaNfwX45iX+BJjLh0w0XU3a
         b86+lzoUxc+R/SkAKimzartYpcESIoBg35btCDsm8qlay35+XdKCDlT1ng7s+o4YAShr
         t7EqKz57OIpiFhUZHZpsdvpgoEii3xSgUyoftdGOGDfLrEpo8l+0IfFIinOYispzMVjA
         hLnS0Y/uYmNZ4AnN/UH7A7mA7PKom0jSWQpxN19Cjh+IEho2ldAPIuF17qv87CPz1vxJ
         4LWUHUbMj9HrGbZUr7pBsI5OKFswaT8HPaQz1Acd54+2+1COI2OP/VKiP9U2epr9n2Yk
         JDJg==
X-Gm-Message-State: ABy/qLabK1hoc3F3tnvj8mnaxuv7GJsc9lf6S1PZZQFvp2e3v/pr4ZEv
	nyVMvgtXBZQX0idog/yw8WMgC+ZWCV4qoaLReTbQn4ViMSG0+jVaTUACelORbE4v0Q8pUYOq14r
	jWZ7Ras4qWk8gNDYvPBN0Tts6Wvkecqsj4lWTw3JCynLv/l1ZuhYsWBs2BsDtN4tOCzEdLk0oRM
	5iT/SO+9/PvK0o
X-Google-Smtp-Source: APBJJlFB9BVfs0RCHpxLTIUt+pCmL68uTFTa40keC/BlArd0YmoiDeGLOTWBbtIiylIMDTq1eW0inQ==
X-Received: by 2002:a05:6a00:3911:b0:67f:d5e7:4604 with SMTP id fh17-20020a056a00391100b0067fd5e74604mr9054057pfb.13.1688764934350;
        Fri, 07 Jul 2023 14:22:14 -0700 (PDT)
Received: from dev-mliang.dev.purestorage.com ([208.88.159.128])
        by smtp.gmail.com with ESMTPSA id fm15-20020a056a002f8f00b006828ee9fdaesm3274967pfb.127.2023.07.07.14.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 14:22:13 -0700 (PDT)
From: Michael Liang <mliang@purestorage.com>
To: linux-nvme@lists.infradead.org,
	jsmart2021@gmail.com
Cc: randyj@purestorage.com,
	csander@purestorage.com,
	ushankar@purestorage.com,
	psajeepa@purestorage.com,
	Michael Liang <mliang@purestorage.com>
Subject: [PATCH 2/2] nvme-fc: fix race between error recovery and creating association
Date: Fri,  7 Jul 2023 15:21:57 -0600
Message-Id: <20230707212157.1158725-3-mliang@purestorage.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230707212157.1158725-1-mliang@purestorage.com>
References: <20230707212157.1158725-1-mliang@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230707_142216_594370_FAB06A82 
X-CRM114-Status: GOOD (  12.66  )
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

There is a small race window between nvme-fc association creation and error
recovery. Fix this race condition by protecting accessing to controller
state and ASSOC_FAILED flag under nvme-fc controller lock.

Signed-off-by: Michael Liang <mliang@purestorage.com>
Reviewed-by: Caleb Sander <csander@purestorage.com>
---
 drivers/nvme/host/fc.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index ad9336343e01..1cd2bf82319a 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2548,17 +2548,24 @@ nvme_fc_error_recovery(struct nvme_fc_ctrl *ctrl, char *errmsg)
 	 * the controller.  Abort any ios on the association and let the
 	 * create_association error path resolve things.
 	 */
-	if (ctrl->ctrl.state == NVME_CTRL_CONNECTING) {
-		__nvme_fc_abort_outstanding_ios(ctrl, true);
+	enum nvme_ctrl_state state;
+	unsigned long flags;
+
+	spin_lock_irqsave(&ctrl->lock, flags);
+	state = ctrl->ctrl.state;
+	if (state == NVME_CTRL_CONNECTING) {
 		set_bit(ASSOC_FAILED, &ctrl->flags);
+		spin_unlock_irqrestore(&ctrl->lock, flags);
+		__nvme_fc_abort_outstanding_ios(ctrl, true);
 		dev_warn(ctrl->ctrl.device,
 			"NVME-FC{%d}: transport error during (re)connect\n",
 			ctrl->cnum);
 		return;
 	}
+	spin_unlock_irqrestore(&ctrl->lock, flags);
 
 	/* Otherwise, only proceed if in LIVE state - e.g. on first error */
-	if (ctrl->ctrl.state != NVME_CTRL_LIVE)
+	if (state != NVME_CTRL_LIVE)
 		return;
 
 	dev_warn(ctrl->ctrl.device,
@@ -3172,12 +3179,16 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
 		else
 			ret = nvme_fc_recreate_io_queues(ctrl);
 	}
+
+	spin_lock_irqsave(&ctrl->lock, flags);
 	if (!ret && test_bit(ASSOC_FAILED, &ctrl->flags))
 		ret = -EIO;
-	if (ret)
+	if (ret) {
+		spin_unlock_irqrestore(&ctrl->lock, flags);
 		goto out_term_aen_ops;
-
+	}
 	changed = nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_LIVE);
+	spin_unlock_irqrestore(&ctrl->lock, flags);
 
 	ctrl->ctrl.nr_reconnects = 0;
 
-- 
2.34.1


