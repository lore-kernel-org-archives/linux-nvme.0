Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B363EEB64DC
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Jun 2023 09:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=X3p2ort1XGfY89Cgvtn4nymi2nkRUSI09DjSmE7WY64=; b=ISkiYyDRZ+l3nxTFmprOBCeA97
	TQUYt61OGDof6LymEW/21UiWX2kfOHV83wbX88OsCBmfBrREj6sYtmlstlg8aZq3/Wb0s8/JZEwp4
	gnF3HsN3Rv+M+0L985YBh1QK/TVBTK0GqOT1O6wcnwBiUjDIYBPlPS6utNXKR/hkcg1SVIUOzq03A
	X3fA4dOD49QXd6SOe9vpn2Xa92aVzKl0SnHwWmc4gcgsfZ0stp1cTsb1TrU9cXnWt6y5cyXKgYhvi
	A65VAJe03LPzQcqygPOQl8GdJ134PsD1eo8UQMBXQP4W5OvvV7T3fDlFdWu38MWWofqP+tpBFeTyH
	GXLcxDtA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q9jbc-00EMWn-0v;
	Thu, 15 Jun 2023 09:49:28 +0000
Received: from mail-lf1-f51.google.com ([209.85.167.51])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q9jbZ-00EMV2-1h
	for linux-nvme@lists.infradead.org;
	Thu, 15 Jun 2023 09:49:26 +0000
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-4f6283d0d84so10237570e87.1
        for <linux-nvme@lists.infradead.org>; Thu, 15 Jun 2023 02:49:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686822562; x=1689414562;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X3p2ort1XGfY89Cgvtn4nymi2nkRUSI09DjSmE7WY64=;
        b=FR2cGIFDGteBd4cfrDtmpxjeCjmZ+dRW7yikxX1V3RL80dYdhTxWV4fi9eXPNSfo0B
         +nCqpKR95H9YgDpupUefgWR2aNf0OycJSKbca1HA2VxotlUbz5uhyjaNNRowKco9mpL5
         BwcJm5grwnXekMNDBVw1axlFWcy0eYhmGGR4StrxFVt6kFGNLO0uHyfLNxIsDT/ndkf1
         ih1ujUb95znOgj3ZyA3rwa6AGl88VZaLNAUxVUXJShbHczPNG/8kjxW7Rb/jx+1Dy/LE
         tJmN5PsobMHBxSpJK104BcBxmHxGKyik45m8T7uHLHpJ5h+PKxY6fcxCKEP/gbNcMjH+
         4OIA==
X-Gm-Message-State: AC+VfDylyjOcRBmRUiQXHKk4xvb8O90/1BVSafTipy2f2JwDTAN26d1D
	KQhCOcYTPdFJhjkwkwXyPadGjXbkcgsryQ==
X-Google-Smtp-Source: ACHHUZ6n1qAOSY3/0bIrcpUeXl81ZgXAtxlDJsdZNrgMFHeGSnpSuSse7UXpr46DQ9B0soM8Gyp3xQ==
X-Received: by 2002:a05:6512:b08:b0:4f8:46e9:9f1b with SMTP id w8-20020a0565120b0800b004f846e99f1bmr355064lfu.3.1686822561819;
        Thu, 15 Jun 2023 02:49:21 -0700 (PDT)
Received: from localhost (fwdproxy-cln-022.fbsv.net. [2a03:2880:31ff:16::face:b00c])
        by smtp.gmail.com with ESMTPSA id z10-20020a05600c114a00b003f7e60622f0sm20038060wmz.6.2023.06.15.02.49.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 02:49:21 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: leit@fb.com,
	linux-nvme@lists.infradead.org (open list:NVM EXPRESS DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] nvme: Print capabilities changes just once
Date: Thu, 15 Jun 2023 02:49:03 -0700
Message-Id: <20230615094903.1341683-1-leitao@debian.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230615_024925_562387_B3F6462C 
X-CRM114-Status: GOOD (  14.59  )
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

This current dev_info() could be very verbose and being printed very
frequently depending on some userspace application sending some specific
commands.

Just print this message once and skip it until the controller resets.
Use a controller flag (NVME_CTRL_DIRTY_CAPABILITY) to track if the
capability needs a reset.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/nvme/host/core.c | 6 +++++-
 drivers/nvme/host/nvme.h | 1 +
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 76e8f8b4098e..4b7f9edab5e8 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1125,8 +1125,11 @@ void nvme_passthru_end(struct nvme_ctrl *ctrl, u32 effects,
 		mutex_unlock(&ctrl->scan_lock);
 	}
 	if (effects & NVME_CMD_EFFECTS_CCC) {
-		dev_info(ctrl->device,
+		if (!test_and_set_bit(NVME_CTRL_DIRTY_CAPABILITY,
+				      &ctrl->flags)) {
+			dev_info(ctrl->device,
 "controller capabilities changed, reset may be required to take effect.\n");
+		}
 	}
 	if (effects & (NVME_CMD_EFFECTS_NIC | NVME_CMD_EFFECTS_NCC)) {
 		nvme_queue_scan(ctrl);
@@ -3280,6 +3283,7 @@ int nvme_init_ctrl_finish(struct nvme_ctrl *ctrl, bool was_suspended)
 			return ret;
 	}
 
+	clear_bit(NVME_CTRL_DIRTY_CAPABILITY, &ctrl->flags);
 	ctrl->identified = true;
 
 	return 0;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 78308f15e090..f3182134487a 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -243,6 +243,7 @@ enum nvme_ctrl_flags {
 	NVME_CTRL_STARTED_ONCE		= 2,
 	NVME_CTRL_STOPPED		= 3,
 	NVME_CTRL_SKIP_ID_CNS_CS	= 4,
+	NVME_CTRL_DIRTY_CAPABILITY	= 5,
 };
 
 struct nvme_ctrl {
-- 
2.34.1


