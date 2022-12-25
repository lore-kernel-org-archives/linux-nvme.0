Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8518C4332F
	for <linux-nvme@archiver.kernel.org>; Sun, 25 Dec 2022 11:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=fK27CTWi7z6BAiHIvT6BdzByPUiW0oluYji9r8SyZWo=; b=0qsGyyVKA9xZQGAR3XhSGXBXd8
	tSAXcaoDui/CVNmvhwigV5xtuQ7qYxNXQa+JiNsr9xjP8DFW1LjwDm+Af1zI7OomDeWEtpOE861D9
	/1L1fA98FPOHj45jpGg9JLXeXVbRWsl+Vb6yeNWkobTfxuNYu1nzfza0UhLE25Pw68D92BVjbVHmv
	rJEPtFpef00E4bNgIWFy9fBkl7K3xEWe6T/m1D3+enLu4gr0+e9Wtk6VNivAD6HcHCUs6OfDZxjJb
	plZucUQVlXEMkV4Va4pA4D16kNf2d/6ydgAw/5sOWvoz9mLetfNWsuXx/IjSQNCO/JLPh5hcbFtQj
	86YmVwBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p9PHc-00AX8k-UR; Sun, 25 Dec 2022 11:35:13 +0000
Received: from mail-wr1-f46.google.com ([209.85.221.46])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p9PBX-00AUBL-6H
	for linux-nvme@lists.infradead.org; Sun, 25 Dec 2022 11:28:56 +0000
Received: by mail-wr1-f46.google.com with SMTP id y16so8213027wrm.2
        for <linux-nvme@lists.infradead.org>; Sun, 25 Dec 2022 03:28:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fK27CTWi7z6BAiHIvT6BdzByPUiW0oluYji9r8SyZWo=;
        b=CbYyOa/nDhAUHVcVNQHig3eBv52BdjyANQPpAaR+7iohmrOVvo4IelMOWiqHmEeFlC
         ck4s0l7slQAFF9rjl8Dweae14+21wV3dCfNnM792dBiK1uxCSPbqT+owEd4hSnGP3LT+
         x+Emqa60SR2T22nMR/HuNQkNhf39pzEk9MGjM0B98Mvb4tXtiw0X/zHnjb4urOLG08cG
         1tQZKQkzZ88ySp7LdAkTiJTxlpskwTK5Pz4Zt3W72Ddk9TxB0y054fvwwh8CyaP0rK50
         XHkKK4EAC7VpX07hGWBMR4vBAc8sQPyY66b4VD03RzislwXJvNHI+WoZolfItSt+dnYd
         so8w==
X-Gm-Message-State: AFqh2kqYdUK2IODl4yDX20nAjdRaKIfJc7PvUA+4WCenS4BGpUfBs/Kt
	6leWgpBEUwq/5tc8aC7js7d6isOE7DU=
X-Google-Smtp-Source: AMrXdXsTc31T0Ibm36bUFXanIbrM+uzNdl9MHFOshdFhAodAya2l1rQ1PMzVEfNBSJGk+X3LuUWXqA==
X-Received: by 2002:a5d:6541:0:b0:273:e357:2c23 with SMTP id z1-20020a5d6541000000b00273e3572c23mr5326023wrv.64.1671967733064;
        Sun, 25 Dec 2022 03:28:53 -0800 (PST)
Received: from localhost.localdomain (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id i13-20020a5d558d000000b00241e5b917d0sm9036258wrv.36.2022.12.25.03.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Dec 2022 03:28:52 -0800 (PST)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	Dan Carpenter <error27@gmail.com>
Subject: [PATCH] nvme-auth: fix smatch warning complaints
Date: Sun, 25 Dec 2022 13:28:51 +0200
Message-Id: <20221225112851.351885-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221225_032855_405032_C1F1AD14 
X-CRM114-Status: GOOD (  11.86  )
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

When initializing auth context, there may be no secrets passed
by the user. Make return code explicit when returning successfully.

smatch warnings:
drivers/nvme/host/auth.c:950 nvme_auth_init_ctrl() warn: missing error code? 'ret'

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <error27@gmail.com>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/auth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index bb0abbe4491c..4424f53a8a0a 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -953,7 +953,7 @@ int nvme_auth_init_ctrl(struct nvme_ctrl *ctrl)
 		goto err_free_dhchap_secret;
 
 	if (!ctrl->opts->dhchap_secret && !ctrl->opts->dhchap_ctrl_secret)
-		return ret;
+		return 0;
 
 	ctrl->dhchap_ctxs = kvcalloc(ctrl_max_dhchaps(ctrl),
 				sizeof(*chap), GFP_KERNEL);
-- 
2.34.1


