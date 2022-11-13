Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48D9CC4332F
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Nov 2022 11:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BaK9ydKi11K/iEsek0T9Cll/VguHoCMUJPNpiC+mQAQ=; b=uIkB9FdLfukBG4Z6/2cySgymxC
	SwWSi3zA5oRIn6+njDuxqRs12ZDMrZYwd6DCH7x0x1O3V8LH3MI4vtXSvPJmv4A346Ccg05SzSbuE
	y7YrHxWV3d/CfSsfkEplDLgmez4NN0/Ll4+JRUNmlGngAB/Zz+mHHUw3wTNdfUf0VCmenm/9Kz8rS
	MWjlAQKN+iezzBu1djKnczP0jDVOLM0VEJBMMQOfiKu8pcfBfPLHUaY6EV4WowVpmLBMcNC1BE5Tn
	FDedqkPAFeQSp2OPwM64MuCsdA0qOLCVCEd9DhbHMryPsbAVVh+u7Lk07y9kkfhHzeqbjE/Uhp7U9
	O3usqO2Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ouB6T-00B6T2-AC; Sun, 13 Nov 2022 11:24:45 +0000
Received: from mail-wr1-f53.google.com ([209.85.221.53])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ouB6G-00B6Ms-B3
	for linux-nvme@lists.infradead.org; Sun, 13 Nov 2022 11:24:33 +0000
Received: by mail-wr1-f53.google.com with SMTP id o4so12409004wrq.6
        for <linux-nvme@lists.infradead.org>; Sun, 13 Nov 2022 03:24:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BaK9ydKi11K/iEsek0T9Cll/VguHoCMUJPNpiC+mQAQ=;
        b=MN7OjMTyc77S56NSwsAUgmMJ6uAhw8rhO8Ky9Q/DRt2NM6wo+tQTLuPuvlBoBno8dl
         dF7Ua7eE/5uMGOq8+8haX0u0qy2TFd8EQYA3kxIzShubOLkO8xGJYFEzBAEokm16X6nm
         NxSxA6PtbmUmpSTAES661FqMP/XuU9hsoWvcptrrhX0vJDVz6hRiCyyv8D+CGTMetKgR
         BugMVqjC4lsUSS1U/xsvpy2jwXUVaLuneOHMmbtlgGhwTNZIMsEow4srC5XWYvFK4hkB
         +WABLn5IUmc2ITzt5flB88L6ZmmRWmqixYyoNTSdh/yMLyyjE7H32FQldmd4IIFjNCql
         tQyA==
X-Gm-Message-State: ANoB5pnVy17Zp9EHPWYRLzLFhsK7qpteNdY79G7AX7Y1EMnuR7n2DIfh
	t1BhbcPBZ3s6/JrYa4hmYwJFX6NiwSo=
X-Google-Smtp-Source: AA0mqf5+a/qaCATrOMyW5D2u8o8VUwF/0ExSM1ztw9OEs0Zq+iRNs4wo5QFRNDSYKbP79kyJuJFUoA==
X-Received: by 2002:adf:f347:0:b0:236:6dd1:eb68 with SMTP id e7-20020adff347000000b002366dd1eb68mr5040268wrp.261.1668338670587;
        Sun, 13 Nov 2022 03:24:30 -0800 (PST)
Received: from localhost.localdomain (46-116-236-159.bb.netvision.net.il. [46.116.236.159])
        by smtp.gmail.com with ESMTPSA id p1-20020a1c5441000000b003b4868eb71bsm14318393wmi.25.2022.11.13.03.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Nov 2022 03:24:30 -0800 (PST)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH v2 03/20] nvme-auth: remove symbol export from nvme_auth_reset
Date: Sun, 13 Nov 2022 13:24:07 +0200
Message-Id: <20221113112424.1049834-4-sagi@grimberg.me>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221113112424.1049834-1-sagi@grimberg.me>
References: <20221113112424.1049834-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221113_032432_396285_1084EB4A 
X-CRM114-Status: GOOD (  10.67  )
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

Only the nvme module calls it.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/auth.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index e3e801e2b78d..2f823c6b84fd 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -932,7 +932,6 @@ void nvme_auth_reset(struct nvme_ctrl *ctrl)
 	}
 	mutex_unlock(&ctrl->dhchap_auth_mutex);
 }
-EXPORT_SYMBOL_GPL(nvme_auth_reset);
 
 static void nvme_ctrl_auth_work(struct work_struct *work)
 {
-- 
2.34.1


