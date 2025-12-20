Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E834DD78797
	for <linux-nvme@archiver.kernel.org>; Sat, 20 Dec 2025 00:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=0b+OXrygZ1J1Hfb+NWdhuR5R53IopwscYd6YvtLJjJ0=; b=TrURyZ2lTCGNCnUA8LzeOt63RZ
	VWC1YORiK295T6C2Z72MyOslZxUGrH7qT4TVKJNGkR6ZsD1oj+THFN25+PzfaDHlrhxVRap9Ot8ri
	CwbSQWoxfU/eDWago7wdMazOF8WMK+g6hk3YBL2DG6kLNLi83ayviGZfhIo1Jz0beLNqE+zVsklvv
	mw0krVGLd274nlsFt/FGmW18tgzIEl967mOHuFUE8KlsC4rErEVh7xrS9cIG6J//k4ijyRhs/uTOr
	1ws05DKJKF1v0uMbmGCuppUGE2ASY8RUT4W+a+R8PvT2vch1Nd5umdiSmD36ZzX2uGHqTKbP5Nnk/
	vbXhad4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vWkgK-0000000B7V7-1g2o;
	Sat, 20 Dec 2025 00:18:48 +0000
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vWkgI-0000000B7Ue-1MaF
	for linux-nvme@lists.infradead.org;
	Sat, 20 Dec 2025 00:18:47 +0000
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-c03ec27c42eso1299943a12.1
        for <linux-nvme@lists.infradead.org>; Fri, 19 Dec 2025 16:18:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766189925; x=1766794725; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0b+OXrygZ1J1Hfb+NWdhuR5R53IopwscYd6YvtLJjJ0=;
        b=CmERSvB/dbBgaaU+/UalBRs1ZuI6bC+LSXdwFrk/tXYpZADyuWGgre8yLIBXvyzqmZ
         9Xmq0KnoqZ5E9FOZCsbkDh4wHB2xT0k/+u4mgJVBeCzeqn+mlZ6yoZr8sUm+qA6frgOb
         68ML5H0zRPOdeF3wQQwoMMStm6UYJ91rERdcFC84m5t5sJBK+3wPwf9dSxq5IeYtgLOX
         vVSRvydvaDrnpCCifE5dfko5kM2hgCgckmbwavo1jIBDT4qUmYeX+pminC+sh0Oi1Vqe
         Dlm6t5c8ugDoJfmddM1yabrDJNcBj/FXxDGyUFosdUomyKM+bsXqV3agzonMyA4QbFhY
         3Rfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766189925; x=1766794725;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0b+OXrygZ1J1Hfb+NWdhuR5R53IopwscYd6YvtLJjJ0=;
        b=xPnF3XtuUgaopO0cIODV4v5j7ltfnFf0q6CjR0ZrZvELJaprgGNw8vGu07RR5s8hKd
         NEmwXPUh4Ire3PDB7E3fu7gAYyn/nkbWvNBVJAQ7wmH8rrRn1LfzbIy9YTqc2dalqa7h
         Zxb5xt9YoHUgVteOTxyxywBpWWItom9g2bg2b9zwgnHaIF6tB0ZNSER8rZcXqkLc4yQF
         w5l/67ygfHfi+yc8PQgnbUis6R76JslfpYqWVsgYlP1B5vOestdr3REz2YY+jhShjvPM
         iQiuUZzsiozWo6uPZZepWUTk1Hd7Ww00bDoqm7j/3s5pj8Vxwwanh5sP+Vcl2Qc1I3Ot
         yr3A==
X-Gm-Message-State: AOJu0YwagwWaS/mebe+nmfATGT259l6ECMR6K8/xqMX7M2SeWJyPDHzg
	+hJR6lKif8jfcp431K2H9jJJhaXGLneFPvan9k0zsHvTTnvy4AfwRXmhqoo8AQ==
X-Gm-Gg: AY/fxX5zrPAw1WmD84yylyiVEkr30rfr8XQCNikmH79T35xokgxLECnWDB9H2XLWs7T
	uo6+E9e1ebBtdFAOQ2hzKwBaWprkycSjbTkaDS17Zo4AZbR+3jX8exn32ez8HVwIpa/Qky0dkm3
	1QVr5owbc0SyUx4IIBTEhLGBmoaTF+Af57POQg3P0EAc3/nqzX/tOR72QGUh4yL/OwC8cONuDfz
	79mCUsE92lZ0Bn+3jChcY++Imu9HaNTEFPrPnfWDhU/RZT2lndCXRDeGR5vDULPfze2GjQTdtvd
	hB/ZxrBdJz9pLURveRkIwDJ4soELB81W1PywC/TDrrX76gj00bybkiHxXVSt2ZbTYKFS8YJm13R
	bu4rkJPNtSh4bFbSDaRHMBGW8+irrV66SG3x4AhH+Hdbh2KO6oqmBpayMbkyIzJIff546ml97aP
	s8CYPvkX5NEG47OcUoFpsA3tAQFwlPsKaSZNUqtab9218q75k=
X-Google-Smtp-Source: AGHT+IFc33B+pCduC8zmMz/6SEqTDcWW2WOZ9sjIwoHNBXmAfK/xJv0LnLqxkIMhQLSmXDidwU5TJA==
X-Received: by 2002:a05:7301:dd82:b0:2a4:3593:466d with SMTP id 5a478bee46e88-2b05ebdd4a7mr4914285eec.9.1766189925029;
        Fri, 19 Dec 2025 16:18:45 -0800 (PST)
Received: from localhost (ip70-175-132-216.oc.oc.cox.net. [70.175.132.216])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b05fcfc1b7sm9729910eec.0.2025.12.19.16.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 16:18:44 -0800 (PST)
From: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
To: linux-nvme@lists.infradead.org
Cc: justin.tee@broadcom.com,
	nareshgottumukkala83@gmail.com,
	paul.ely@broadcom.com,
	kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	yi.zhang@redhat.com,
	Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Subject: [BUG FIX PATCH COMPILE TESTED ONLY] nvme-fc: release admin tagset if init fails
Date: Fri, 19 Dec 2025 16:18:42 -0800
Message-Id: <20251220001842.6027-1-ckulkarnilinux@gmail.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251219_161846_364791_522E016A 
X-CRM114-Status: UNSURE (   9.47  )
X-CRM114-Notice: Please train this message.
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

nvme_fabrics creates an NVMe/FC controller in following path:

    nvmf_dev_write()
      -> nvmf_create_ctrl()
        -> nvme_fc_create_ctrl()
          -> nvme_fc_init_ctrl()

nvme_fc_init_ctrl() allocates the admin blk-mq resources right after
nvme_add_ctrl() succeeds.  If any of the subsequent steps fail (changing
the controller state, scheduling connect work, etc.), we jump to the
fail_ctrl path, which tears down the controller references but never
frees the admin queue/tag set.  The leaked blk-mq allocations match the
kmemleak report seen during blktests nvme/fc.

Check ctrl->ctrl.admin_tagset in the fail_ctrl path and call
nvme_remove_admin_tag_set() when it is set so that all admin queue
allocations are reclaimed whenever controller setup aborts.

Reported-by: Yi Zhang <yi.zhang@redhat.com>
Signed-off-by: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
---
 drivers/nvme/host/fc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index bc455fa98246..6948de3f438a 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -3587,6 +3587,8 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 
 	ctrl->ctrl.opts = NULL;
 
+	if (ctrl->ctrl.admin_tagset)
+		nvme_remove_admin_tag_set(&ctrl->ctrl);
 	/* initiate nvme ctrl ref counting teardown */
 	nvme_uninit_ctrl(&ctrl->ctrl);
 
-- 
2.40.0


