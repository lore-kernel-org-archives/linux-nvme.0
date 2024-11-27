Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64BB8D609B8
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Nov 2024 08:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=I5TXHgZ3Z8QTGy7TWH/5+kFsxPLaG9TqvwezPRwTQdc=; b=On/sGPmONr6XeaHxQZ7NoglajC
	Nl0LZrqPbFXCDPqqi6dRCp0xXQWKXt2X5iVPuXFpDdMKvLWYL2ix1mk+SoHKGKKUPDPRNcoEQj7if
	gwJgdDNmvofEBfS90psOLjMSvU6CVwnUcWkqU++VNt1Ul711tGxoTGW90LCAn1fDHcY+1cZYwvj/x
	tvXYvIgPx7Aonh7w6TIXUHaz0s+7kIdyLKI6WiYLg/Qa0zZ0b9ArTWdh3M5YZoPc/sN7fESjk62L/
	DS+X50oBB9xverbfDwYDPGTy2oqzhwiANB3aBIAKfUVD52qp0kn3DaOFaiSigHozKS5ncgUCe2GHB
	zTud8/Rw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tGDmb-0000000CcP0-2sY8;
	Wed, 27 Nov 2024 08:52:25 +0000
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tGDmY-0000000CcNc-3F1w
	for linux-nvme@lists.infradead.org;
	Wed, 27 Nov 2024 08:52:23 +0000
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-2eacc4c9164so5555514a91.0
        for <linux-nvme@lists.infradead.org>; Wed, 27 Nov 2024 00:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732697542; x=1733302342; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I5TXHgZ3Z8QTGy7TWH/5+kFsxPLaG9TqvwezPRwTQdc=;
        b=AeASd0HR0yOqDGesSXNjXyoGrBG8dpC4HMgRw4woWnxsn7xT8R+Decvn9bt22gQVJS
         r0qGYszMMOOVCssYYFHXiSx3wcmGtDE08rg/ELOKRuyNTrjTg2tDFyEoymuPdr+g3DFn
         JisT9ZH6XsFCXqnYB3Ck+EavDARanFU2ZJGB0dmhOvhZuKIctVXIGUiORpipDVsYXjNS
         h+5bPF9Med1+w6kHFNDOZ1KJPAWfpMpNvH77HCwl4d6sCi5afRoujnA/RYkg8lkVu+no
         mdZZL7sJITwHfotolIbyeoB72h5RMr6+iJAt0EKO25SetOaqyJWcxWzVGhDar0XeDTqF
         kvdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732697542; x=1733302342;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I5TXHgZ3Z8QTGy7TWH/5+kFsxPLaG9TqvwezPRwTQdc=;
        b=QDy/sgk1KNuPtiI9+iEjK91Ft216iM59um52Y2raMhIbAijInBZcXSkVOwhjAorH/0
         fuWSb/f9zE2xGOk5Ow7fBv64B6sa/GWTWlhxq3ALQG3x3O2Woc4HIAbEE7/y7JPKz3ko
         alUbPPLieW+6CjVmf7k2KEOA4e/z5ldy023pxvGPaxXIOTicF/ORAjkncOOOE6LcJKB+
         eIiss+8JKjpT+vEQYe5hkcwIelyancQqlejElyv9Je4KEZYC+YL0NyL1Zqx+hGeYennt
         Za8nmdjVMD0FV7RGdj+DphYEtKI8irgda3/XebcQKCM4mSO2adr8p1UOb+cTc7iKv93a
         6NSQ==
X-Gm-Message-State: AOJu0Yy5zLD1dt7tsjf02uXUZC/tTjZrSc/80oMzPmmbazKruZ2fLR9d
	dFvuYUKhfMh3qjrr1wBV8+JXtRRQpY/PGyQx2LkX27d9GlaSfr91
X-Gm-Gg: ASbGncsAhnK5IRv7hBNfgUfN90/AXl6zNUEoDoSRVpY1wCC5F6A0WsAWVWmIPLP0YR0
	0TF/3qHReoynW9or9L6/8Pz8vbfGbBjzCSpR9BvGbko4QZVHYhw8exREqQ1EcDvNAJlffxXbmNj
	089Rlrfx3T2695gNqfyVTcvK+LU099K6sxuQCct1JiVP2O+u6ZNZmRwmA1K694dEcrdvbD0gtnr
	vk3zs6eY968EqgH5Z3utXAP2TjHAcmK5N73qv6IO2djMAgVrxFAdAMOY2Lluw==
X-Google-Smtp-Source: AGHT+IF6CYkTsIeE1XeYAMX6OTkwBCN+caMMwhD4ZTXviHRAggHQYeZCg5sgJ6GOgj0vulov/WbgKQ==
X-Received: by 2002:a17:90b:38ca:b0:2ea:4578:46c0 with SMTP id 98e67ed59e1d1-2ee08ece4a4mr3032590a91.18.1732697541734;
        Wed, 27 Nov 2024 00:52:21 -0800 (PST)
Received: from localhost.localdomain ([143.92.64.17])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ee0fa60091sm960531a91.20.2024.11.27.00.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 00:52:21 -0800 (PST)
From: "brookxu.cn" <brookxu.cn@gmail.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	hare@suse.de
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/5] nvme-tcp: fix the memleak while create new ctrl failed
Date: Wed, 27 Nov 2024 17:27:47 +0800
Message-Id: <d57573f42413b9e46fe227ef389e2f8a6971f1db.1732699313.git.chunguang.xu@shopee.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1732699313.git.chunguang.xu@shopee.com>
References: <cover.1732699313.git.chunguang.xu@shopee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241127_005222_813243_CF55C989 
X-CRM114-Status: GOOD (  13.24  )
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

From: "Chunguang.xu" <chunguang.xu@shopee.com>

Now while we create new ctrl failed, we have not free the
tagset occupied by admin_q, here try to fix it.

Fixes: fd1418de10b9 ("nvme-tcp: avoid open-coding nvme_tcp_teardown_admin_queue()")
Signed-off-by: Chunguang.xu <chunguang.xu@shopee.com>
---
 drivers/nvme/host/tcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 3e416af2659f..55abfe5e1d25 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2278,7 +2278,7 @@ static int nvme_tcp_setup_ctrl(struct nvme_ctrl *ctrl, bool new)
 	}
 destroy_admin:
 	nvme_stop_keep_alive(ctrl);
-	nvme_tcp_teardown_admin_queue(ctrl, false);
+	nvme_tcp_teardown_admin_queue(ctrl, new);
 	return ret;
 }
 
-- 
2.25.1


